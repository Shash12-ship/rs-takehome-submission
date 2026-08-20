import Lean
import Lean.Util.CollectAxioms

open Lean

private structure ModuleAudit where
  name : Name
  theoremCount : Nat

private inductive AuditFailure where
  | projectAxiom (name : Name)
  | unexpectedAxioms (name : Name) (actual unexpected : Array Name)

private def allowedAxioms : Array Name :=
  #[``propext, ``Classical.choice, ``Quot.sound]

private abbrev AuditM := StateT Environment IO

private instance : MonadEnv AuditM where
  getEnv := get
  modifyEnv f := modify f

private def moduleNameOfArg (arg : String) : Name :=
  let path := if arg.startsWith "./" then (arg.drop 2).copy else arg
  let path := if path.endsWith ".lean" then (path.dropEnd 5).copy else path
  (path.replace "/" ".").toName

private def auditModules (moduleNames : Array Name) : AuditM (Array ModuleAudit × Array AuditFailure) := do
  let env ← getEnv
  let mut audits : Array ModuleAudit := #[]
  let mut failures : Array AuditFailure := #[]
  for moduleName in moduleNames do
    let some moduleIdx := env.getModuleIdx? moduleName
      | throw <| IO.userError s!"Imported module not found: {moduleName}"
    let moduleData := env.header.moduleData[moduleIdx.toNat]!
    let mut theoremCount := 0
    for constantInfo in moduleData.constants do
      if constantInfo.isAxiom then
        failures := failures.push (.projectAxiom constantInfo.name)
      else if constantInfo.isTheorem then
        theoremCount := theoremCount + 1
        let actual ← collectAxioms constantInfo.name
        let unexpected := actual.filter fun axiomName => !allowedAxioms.contains axiomName
        unless unexpected.isEmpty do
          failures := failures.push (.unexpectedAxioms constantInfo.name actual unexpected)
    audits := audits.push { name := moduleName, theoremCount }
  return (audits, failures)

unsafe def main (args : List String) : IO UInt32 := do
  if args.isEmpty then
    IO.eprintln "Usage: lake env lean --run AxiomCheck.lean MODULE_OR_SOURCE..."
    return 2

  let moduleNames := args.toArray.map moduleNameOfArg
  if moduleNames.any (·.isAnonymous) then
    IO.eprintln "Every axiom-check argument must identify a Lean module or .lean source file."
    return 2
  if moduleNames.toList.eraseDups.length != moduleNames.size then
    IO.eprintln "Axiom-check module arguments must be distinct."
    return 2

  Lean.enableInitializersExecution
  let imports : Array Import := moduleNames.map fun moduleName => { module := moduleName }
  let env ← importModules imports {} (loadExts := true)
  let (audits, failures) ← (auditModules moduleNames).run' env

  let theoremCount := audits.foldl (init := 0) fun count audit => count + audit.theoremCount
  for audit in audits do
    IO.println s!"{audit.name}: audited {audit.theoremCount} theorem declarations"

  for failure in failures do
    match failure with
    | .projectAxiom name =>
        IO.eprintln s!"{name}: project-defined axioms are not allowed"
    | .unexpectedAxioms name actual unexpected =>
        IO.eprintln s!"{name}: depends on {actual}; unexpected axioms: {unexpected}"

  IO.println s!"Audited {theoremCount} theorem declarations across {audits.size} modules."
  if failures.isEmpty then
    IO.println s!"Every theorem depends only on allowed axioms {allowedAxioms}."
    return 0
  else
    IO.eprintln s!"Axiom audit failed for {failures.size} declarations."
    return 1
