#!/bin/bash
#SBATCH --job-name=lean-chk2
#SBATCH --account=gusr38169
#SBATCH --partition=cbuild,staging
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=32G
#SBATCH --time=00:20:00
#SBATCH --output=formalization/check2.slurm.out
set -uo pipefail
export LEAN_NUM_THREADS="${SLURM_CPUS_PER_TASK:-12}"
repository_dir="${SLURM_SUBMIT_DIR:?Submit this job from the repository root}"
if [ ! -f "$repository_dir/formalization/lakefile.toml" ]; then
  echo "Repository root not found at $repository_dir" >&2
  exit 2
fi
cd "$repository_dir/formalization" || exit 1
echo "host=$(hostname)"; date
echo "=== build target oleans (Results.ThresholdDegree, Polynomial.ModelToPolynomial) ==="
if lake build HeadComplexity.Results.ThresholdDegree HeadComplexity.Polynomial.ModelToPolynomial; then
  dep_rc=0
else
  dep_rc=$?
fi
echo "DEP_RC=$dep_rc"
if [ "$dep_rc" -eq 0 ]; then
  echo "=== check Polynomial/ModelToPolynomial ==="
  if lake env lean HeadComplexity/Polynomial/ModelToPolynomial.lean; then
    check_rc=0
  else
    check_rc=$?
  fi
else
  echo "Skipping Lean check because the dependency build failed."
  check_rc=$dep_rc
fi
echo "CHECK_RC=$check_rc"; date; echo "DONE_SENTINEL"
exit "$check_rc"
