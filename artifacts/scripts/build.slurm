#!/bin/bash
#SBATCH --job-name=lean-build
#SBATCH --account=gusr38169
# cbuild is the official build partition (has internet, for refreshing elan/cache);
# staging is the same srv hardware as a fallback (officially data-transfer, but works).
# SLURM schedules on whichever is free first. Both bill 2.0 SBU/thread-hour.
#SBATCH --partition=cbuild,staging
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=00:25:00
#SBATCH --output=formalization/build.slurm.out

set -uo pipefail
# CRITICAL on a shared/cgroup node: cap Lean's worker threads to the cores we
# actually own, else Lean spawns one thread per HOST core (32) inside a 16-core
# cgroup and thrashes (the earlier 4-core job stalled this way).
export LEAN_NUM_THREADS="${SLURM_CPUS_PER_TASK:-16}"
repository_dir="${SLURM_SUBMIT_DIR:?Submit this job from the repository root}"
if [ ! -f "$repository_dir/formalization/lakefile.toml" ]; then
  echo "Repository root not found at $repository_dir" >&2
  exit 2
fi
cd "$repository_dir" || exit 1

echo "=== host: $(hostname)  cpus: ${SLURM_CPUS_PER_TASK:-?}  LEAN_NUM_THREADS=$LEAN_NUM_THREADS ==="
date
echo "=== shared full validation ==="
if bash artifacts/scripts/validate.sh; then
  validation_rc=0
else
  validation_rc=$?
fi
date
echo "VALIDATION_RC=$validation_rc"
echo "DONE_SENTINEL"
exit "$validation_rc"
