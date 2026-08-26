#!/bin/bash
#SBATCH --job-name=rs-hdth-verify
#SBATCH --account=bfir-dtai-gh
#SBATCH --partition=ghx4
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=00:20:00
#SBATCH --output=submission/results/verify-%j.out

set -euo pipefail

cd "${SLURM_SUBMIT_DIR}"
mkdir -p submission/results

python -m unittest discover -s submission/tests -v
python submission/verify_hamming_threshold_family.py \
  --max-pairs 12 \
  --exhaustive-endpoints-through 8 \
  --output submission/results/hamming_threshold_family_verification.json
