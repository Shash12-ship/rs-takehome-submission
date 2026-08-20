#!/bin/bash
#SBATCH --job-name=lean-mod
#SBATCH --account=gusr38169
#SBATCH --partition=staging,cbuild
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=48G
#SBATCH --time=00:30:00
#SBATCH --output=formalization/checkmod.slurm.out
set -uo pipefail
export LEAN_NUM_THREADS="${SLURM_CPUS_PER_TASK:-16}"
repository_dir="${SLURM_SUBMIT_DIR:?Submit this job from the repository root}"
if [ ! -f "$repository_dir/formalization/lakefile.toml" ]; then
  echo "Repository root not found at $repository_dir" >&2
  exit 2
fi
if [ -z "${CHECK_MOD:-}" ]; then
  echo "Set CHECK_MOD with sbatch --export=ALL,CHECK_MOD=..." >&2
  exit 2
fi
cd "$repository_dir/formalization" || exit 1
echo "host=$(hostname) mod=$CHECK_MOD"; date
if lake build "$CHECK_MOD"; then
  check_rc=0
else
  check_rc=$?
fi
echo "CHECK_RC=$check_rc"; date; echo "DONE_SENTINEL"
exit "$check_rc"
