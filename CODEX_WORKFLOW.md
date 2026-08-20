# Working with Codex (and subagents) on Lean proofs — field notes

Practical lessons from formalizing Theorems 4–12 of this project with OpenAI's Codex
CLI as a peer reviewer. These extend the basic guidance in [`CLAUDE.md`](CLAUDE.md).
The throughline: **Codex is a fast idea/-API engine; the Lean build is the only
oracle.** Use Codex to shorten the path to a *candidate* proof, then verify every
line yourself with the build loop.

## The non-negotiables (learned the hard way)

1. **Always `codex exec "…" </dev/null`.** `codex exec` reads its prompt argument
   *and also drains stdin*. Launched as a background job (`run_in_background`),
   stdin is an open pipe that never sends EOF, so Codex hangs forever on
   "Reading additional input from stdin…". The `</dev/null` makes it take only the
   argument and return. This is mandatory for every background consult.

2. **Codex cannot run long builds.** With stdin closed (the fix above), Codex
   errors `stdin is closed for this session; rerun exec_command with tty=true`
   when it tries to manage a long-running sub-command (e.g. a 90 s `lake build`).
   So in the prompt, tell it **"do NOT run lake; reason from the code/goal"** and
   feed it the build results yourself. (`lake`/`lean` *are* on its `PATH` via
   `~/.bashrc` → `ELAN_HOME`, so quick `lake --version` / `rg` are fine; heavy
   builds are not.)

3. **Keep questions FOCUSED — bounded to one obstacle.** A broad question
   ("prove this injectivity AND plan all of Theorem 11") sent Codex into a
   13 000-line mathlib-grep loop that never converged; I killed it and solved the
   piece myself (`finFunctionFinEquiv`). The same model, asked one tight question
   ("what is the cleanest single-head construction realizing `b/(t(x)+a)`"),
   returned a complete, correct construction in ~130 k tokens. Recipe for a good
   consult prompt:
   - one specific obstacle (a single theorem, a single error, a single design fork);
   - the exact goal state / error text + the minimal surrounding definitions;
   - "be concise, <N words, concrete theorem names / tactics";
   - "do not run lake; reason from the goal";
   - if asking for a construction, give the working *template* it should mirror.

## What Codex is good / bad at here

- **Good:** model-level constructions (it designed the `atomHead` softmax gadget
  and the weighted/affine generalizations), naming the right mathlib theorem when
  you describe the goal, spotting a faithfulness gap, and giving a proof *skeleton*.
- **Unreliable:** exact mathlib signatures (it suggested `degree_interpolate_le`
  without its explicit `r` argument; it missed that `r`/`r'` are `variable`s), and
  whether a niche theorem exists at all (it correctly reported "no ready-made
  subset-sums-of-2^i-are-injective theorem" — but only after a long search). Treat
  every theorem name as a hypothesis to check against the build.
- **Verify, don't trust:** more than once Codex's suggested tactic was *almost*
  right (e.g. `<;> simp; ring` where `simp` fully closes one branch, so the
  trailing `ring` errors on no goals). The build caught it; Codex's reasoning did
  not.

## The loop that actually works

```
design/sketch with Codex (background, </dev/null, focused)
   → write the Lean myself
   → SLURM build (fast, authoritative feedback)
   → on error: either fix directly, or hand Codex the EXACT error + goal for a fix
   → repeat until CHECK_RC=0 AND zero warnings
```

The build is the source of truth and runs on a compute node (see
[`BUILDING.md`](formalization/BUILDING.md)); a single new ~300-line module checks
in well under a minute once its deps are cached. Iterating against the build is far
faster and safer than iterating against Codex's prose.

## Delegating subtasks (parallelism)

For a big but *well-specified* piece (e.g. the Theorem 11 affine head — a concrete
`d=n+1` construction), spawn a background **subagent** with: the full design, the
worked templates to mirror (`atomHead`/`weightedAtomHead`), the exact build
commands, and explicit permission to consult Codex for stuck steps. Meanwhile work
the easy/independent parts on the main thread, and run Codex consults in the
background for orthogonal sub-theorems. Three things make this safe:

- **Non-overlapping files.** Give the subagent its own file; never edit the same
  file concurrently. Add the root `import` only when assembling.
- **Separate SLURM output files.** Concurrent
  `sbatch artifacts/scripts/checkmod.slurm` runs clobber the shared
  `checkmod.slurm.out`. Use a per-worker script
  (`artifacts/scripts/checkmod2.slurm` with a distinct `--output=…`), and filter
  the queue by job name
  (`squeue -u $USER -n lean-mod2`) so each waiter only blocks on its own job.
- **A crisp contract.** The subagent's deliverable is one named theorem,
  `CHECK_RC=0`, no `sorry`, no warnings — easy to verify on return.

## Quick reference

```bash
# focused background consult
codex exec "$(cat prompt.txt)" </dev/null 2>&1   # prompt ends: "be concise; don't run lake"

# my build lane (so it doesn't collide with a subagent's checkmod.slurm)
sbatch --export=ALL,CHECK_MOD=HeadComplexity.Results.ThresholdDegree artifacts/scripts/checkmod2.slurm
while squeue -u $USER -h -n lean-mod2 -o "%i" | grep -q .; do sleep 15; done
grep -nE "CHECK_RC|error:|warning:" formalization/checkmod2.slurm.out
```
