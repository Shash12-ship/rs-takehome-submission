#!/bin/bash
#SBATCH --job-name=lean-check
#SBATCH --account=gusr38169
#SBATCH --partition=cbuild,staging
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=24G
#SBATCH --time=00:15:00
#SBATCH --output=formalization/check.slurm.out
set -uo pipefail
export LEAN_NUM_THREADS="${SLURM_CPUS_PER_TASK:-8}"
repository_dir="${SLURM_SUBMIT_DIR:?Submit this job from the repository root}"
if [ ! -f "$repository_dir/formalization/lakefile.toml" ]; then
  echo "Repository root not found at $repository_dir" >&2
  exit 2
fi
if [ -z "${CHECK_FILE:-}" ]; then
  echo "Set CHECK_FILE with sbatch --export=ALL,CHECK_FILE=..." >&2
  exit 2
fi
cd "$repository_dir/formalization" || exit 1
echo "host=$(hostname) file=$CHECK_FILE"; date
if lake env lean "$CHECK_FILE"; then
  check_rc=0
else
  check_rc=$?
fi
echo "CHECK_RC=$check_rc"; date; echo "DONE_SENTINEL"
exit "$check_rc"
