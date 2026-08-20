# Building & verifying the Lean proofs

This document gives **exact, reproducible** instructions for compiling the
`head-complexity` Lean 4 formalization and checking that the results are
axiom-clean. It covers both a generic machine and the specific HPC environment
(SURF Snellius, project `gusr0688`) the proofs were developed on.

For the wider project context see [`README.md`](README.md), and for the current
proof architecture see [`PROOF_OVERVIEW.md`](PROOF_OVERVIEW.md).

---

## 1. Toolchain and dependencies

| Component | Version | Where selected |
|-----------|----------------|--------------|
| Lean      | `leanprover/lean4:v4.31.0` | `lean-toolchain` |
| Lake      | `5.0.0-src` (ships with the toolchain) | — |
| mathlib   | `v4.31.0` (`leanprover-community/mathlib4`) | `lakefile.toml` → `[[require]]`, locked in `lake-manifest.json` |
| elan      | Current stable (any recent version works) | official `elan.lean-lang.org` installer |

`elan` installs the exact Lean/Lake the toolchain file requests, so you do **not**
need to install Lean by hand — just have `elan` on `PATH` and let it resolve the
pin on first `lake` invocation.

The project builds against a stock mathlib with **no patches**; the only thing
that must match is the rev. The Lake package root is `formalization/`, where
`lakefile.toml` lives. Validation commands below run from the repository root.

---

## 2. Generic build (any machine with internet)

```bash
bash artifacts/scripts/validate.sh --fetch-cache
```

The `--fetch-cache` option runs `lake exe cache get`, which fetches mathlib's
prebuilt `.olean` files so you don't recompile mathlib (which would take hours).
The validator then passes every tracked Lean library source to `lake build`
explicitly. This covers the public `HeadComplexity` umbrella, all `Results` and
`Examples`, and any future tracked module that has not yet been imported by an
umbrella. A clean full build is a few minutes on a modern multi-core machine once
the mathlib cache is present.

If `lake exe cache get` fails with a TLS/`curl`/JSON error, see §4.

---

## 3. Verifying proof integrity

The point of the formalization is a *trusted* proof, so always confirm the final
theorems depend only on Lean's three standard axioms
(`propext`, `Classical.choice`, `Quot.sound`) — i.e. no `sorry`, no extra axioms:

```bash
bash artifacts/scripts/validate.sh
```

The shared validator runs three gates:

1. `lake build` on every tracked Lean library source.

2. `rg -n "sorry|admit\b"` on every tracked Lean source, plus the checked-in
   axiom checker.

3. The axiom audit in `artifacts/scripts/AxiomCheck.lean`, which dynamically
   imports every tracked module and discovers all theorem declarations from
   Lean's module metadata. It uses `Lean.collectAxioms` to check each theorem,
   including generated and private theorem declarations.

Every discovered theorem may depend on any subset of
`[propext, Classical.choice, Quot.sound]`, but no other axiom. Project-defined
axioms, proof placeholders, `native_decide`, and any other extra axiom make the
command exit nonzero. No theorem names are maintained manually. Typical output
includes:

```
BUILD_RC=0
PLACEHOLDER_RC=0
Audited NNN theorem declarations across MM modules.
Every theorem depends only on allowed axioms #[propext, Classical.choice, Quot.sound].
AXIOM_RC=0
```

To run the individual diagnostics from the repository root:

```bash
rg -n "sorry|admit\b" formalization/HeadComplexity.lean formalization/HeadComplexity
(cd formalization && \
  lake build ./HeadComplexity/Results/ThresholdDegree.lean && \
  lake env lean --run ../artifacts/scripts/AxiomCheck.lean \
    HeadComplexity/Results/ThresholdDegree.lean)
```

The standalone command accepts one or more source paths or module names and
automatically checks every theorem declared in each one. It reads compiled module
metadata, so build a changed source first as shown above. The shared validator
already builds and then passes all tracked Lean source paths to it.

`artifacts/scripts/build.slurm` (§5) calls the same validator, so local,
GitLab, and Snellius verification cannot drift apart.

---

## 4. The mathlib-cache `curl` fix (required on some systems)

**Symptom:** `lake exe cache get` fails. mathlib's cache tool ships its own static
`curl-7.88.1`, which on some hosts links a broken OpenSSL 3.0.8 and dies with
`error:16000069 STORE routines::unregistered scheme`. Substituting the system
`curl` then trips a second bug: `curl --write-out %{json}` emits the token
`"http_connect":000`, and JSON forbids leading zeros, so the cache tool's JSON
parser chokes.

**Fix:** place a wrapper at the path mathlib's `getCurl` (in `Cache/IO.lean`)
probes — `<mathlib-cache-dir>/curl-7.88.1` — that delegates to a working system
`curl` and repairs the writeout JSON on the fly. On Snellius the cache dir is
`/projects/gusr0688/.cache/mathlib`; adjust for your `XDG`/cache location.

```bash
#!/usr/bin/env bash
# Delegate to the system curl (working TLS) and repair the one invalid JSON
# token ("http_connect":000 → :0) that mathlib's cache parser rejects.
# Downloaded bodies use `-o <file>`, so only the small writeout JSON flows
# through this pipe.
set -o pipefail
/usr/bin/curl "$@" | sed -u 's/:000\([,}]\)/:0\1/g'
exit "${PIPESTATUS[0]}"
```

```bash
# install it (make executable; mathlib picks it up automatically, no re-download)
install -m755 curl-wrapper.sh /projects/gusr0688/.cache/mathlib/curl-7.88.1
```

`getCurl` uses this path **only if the file exists**, otherwise it falls back to
`curl` on `PATH`. If your system `curl` is healthy you may not need this at all —
try the plain build in §2 first.

---

## 5. Building on Snellius compute nodes (recommended here)

The login node is heavily contended (load ~35–40); offload builds to a compute
node via SLURM. **All toolchain + cache state lives on shared GPFS**
(`/gpfs/work5/0/gusr0688/...` and `/projects/gusr0688/...`), visible from every
node, so compute nodes build fully **offline** — no re-fetch needed.

Make Lean available in the submission environment before starting a job. SLURM
exports that environment by default. On Snellius, the shared installation can be
selected with:

```bash
export ELAN_HOME=/gpfs/work5/0/gusr0688/fair_stuff/.elan
export PATH="$ELAN_HOME/bin:$PATH"
```

Each job script sets `LEAN_NUM_THREADS` from its requested CPU count.

> **CRITICAL:** set `LEAN_NUM_THREADS=$SLURM_CPUS_PER_TASK`. Otherwise Lean spawns
> one worker per *host* core (32) inside a smaller cgroup and thrashes — a 4-core
> job once stalled at ~8 s CPU in 3 min. With the cap, a full `lake build` +
> axiom check finishes in ~2–3 min.

**Account / partitions:** account `gusr38169` has budget only for `cbuild`,
`staging`, and GPU partitions (not `rome`/`genoa`). Use `--partition=cbuild,staging`
and let SLURM pick whichever is free (both are the identical shared `srv[1-10]`
hardware, 32 cores / 224 GB, ~2.0 SBU/thread-hour). `cbuild` is the official build
partition and has **outbound internet** (use it if you ever need to re-fetch the
mathlib cache or a toolchain); `staging` is officially data-transfer but works as
a fallback. Set `--mem` explicitly so the job fits the shared node's free RAM (a
too-large `--mem`, e.g. 16 cpu × 7 G = 112 G, makes the job pend on `Resources`).
A 16-thread ~3-min build costs ≈ 1.6 SBU.

### Job scripts (in `artifacts/scripts`)

Submit these jobs from the repository root. They use `SLURM_SUBMIT_DIR` to find
the checkout, rather than embedding its GPFS path.

| Script | What it does | Submit with |
|--------|--------------|-------------|
| `build.slurm`   | shared full build + placeholder + all-theorem axiom audit (16 cpu / 32 G / 25 min) | `sbatch artifacts/scripts/build.slurm` |
| `check.slurm`   | typecheck one **already-imported** file via `lake env lean` (8 cpu / 24 G) | `sbatch --export=ALL,CHECK_FILE=HeadComplexity/Results/ThresholdDegree.lean artifacts/scripts/check.slurm` |
| `check2.slurm`  | build and check the two fixed polynomial targets (12 cpu / 32 G) | `sbatch artifacts/scripts/check2.slurm` |
| `checkmod.slurm`| build one module **and its deps** via `lake build <Module>` (16 cpu / 48 G) | `sbatch --export=ALL,CHECK_MOD=HeadComplexity.Results.ThresholdDegree artifacts/scripts/checkmod.slurm` |
| `checkmod2.slurm` | second module-check worker with separate job and output names | `sbatch --export=ALL,CHECK_MOD=HeadComplexity.Results.ThresholdDegree artifacts/scripts/checkmod2.slurm` |
| `checkmod3.slurm` | third module-check worker with separate job and output names | `sbatch --export=ALL,CHECK_MOD=HeadComplexity.Results.ThresholdDegree artifacts/scripts/checkmod3.slurm` |

Each script writes `formalization/<name>.slurm.out` (gitignored via `*.out`)
ending in a `DONE_SENTINEL` line. The full build reports `BUILD_RC`,
`PLACEHOLDER_RC`, `AXIOM_RC`, and `VALIDATION_RC` as `0` on success; the focused
scripts report `CHECK_RC=0`.

```bash
sbatch artifacts/scripts/build.slurm
# wait, then:
grep -E "BUILD_RC|PLACEHOLDER_RC|AXIOM_RC|VALIDATION_RC|Build completed" formalization/build.slurm.out
# → Build completed successfully (NNNN jobs).
#   BUILD_RC=0
#   PLACEHOLDER_RC=0
#   AXIOM_RC=0
#   VALIDATION_RC=0
```

> **check vs checkmod:** `lake env lean HeadComplexity/Results/ThresholdDegree.lean`
> (what `check.slurm` runs) requires every import of that file to already have a
> built `.olean`. For a *brand-new* file whose deps aren't yet in the root build,
> use `checkmod.slurm` (`lake build HeadComplexity.Results.ThresholdDegree`),
> which builds the dependency oleans first.

---

## 6. Quick reference

```bash
# full generic validation on a machine with internet:
bash artifacts/scripts/validate.sh --fetch-cache

# repeat validation after the mathlib cache is present:
bash artifacts/scripts/validate.sh

# watch for DONE_SENTINEL on Snellius, offloaded
sbatch artifacts/scripts/build.slurm && tail -f formalization/build.slurm.out
```

The latest top-level separation theorem proved by a clean build is

```lean
theorem theorem13_strict_separation : thresholdDeg f10 < HStar 10 f10
```

It depends only on the three standard Lean axioms. Theorem 12 remains the
headline general-family result:

```lean
theorem theorem12_symmetric (F : ℕ → Bool) (n : ℕ) :
    HStar n (symmetricFn F) = signChanges n F
```
