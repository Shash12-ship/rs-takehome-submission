# Research Scientist Take-Home Submission

This directory contains an exact Python verifier and the source for the accompanying
writeup. The new result turns one exact Hamming-distance separation into an infinite
family of strict separations.

## Result

For

$$ \mathrm{HDTH}_{m,t}(x,y)=\mathbf{1}[\Delta(x,y)\geq t], $$

where $x,y\in\lbrace0,1\rbrace^m$, the verifier supports the following theorem.

- Every threshold has $\deg_{\pm}(\mathrm{HDTH}_{m,t})=2$.
- For $m\geq4$, the endpoint thresholds $t=1$ and $t=m$ have exact head
  complexity two.
- For $m\geq4$, every threshold $2\leq t\leq m-2$ has head complexity
  at least three.
- The remaining near-endpoint case $t=m-1$ is not resolved by this argument.

The lower bound turns the repository's isolated exact separation
$H^{\ast}(\mathrm{HDTH}_{4,2})=3$ into an infinite natural family. A more general
version applies whenever five consecutive labels of a Hamming-distance profile are
`00111` or `11000`.

## Local verification

The verifier and its tests use only the Python standard library.

```bash
python -m unittest discover -s submission/tests -v
python submission/verify_hamming_threshold_family.py \
  --max-pairs 12 \
  --exhaustive-endpoints-through 8 \
  --output submission/results/hamming_threshold_family_verification.json
```

All classification identities and archived certificates are checked with integers.
No training run or floating-point optimization is used as evidence.

The final PDF is `output/pdf/rs_takehome_writeup.pdf`. To rebuild it:

```bash
mkdir -p output/pdf
pdflatex -interaction=nonstopmode -halt-on-error \
  -output-directory=output/pdf \
  -jobname=rs_takehome_writeup submission/writeup.tex
pdflatex -interaction=nonstopmode -halt-on-error \
  -output-directory=output/pdf \
  -jobname=rs_takehome_writeup submission/writeup.tex
```

## DeltaAI

Submit the included CPU verification job from the repository root:

```bash
mkdir -p submission/results
sbatch submission/run_verify.slurm
squeue -u "$USER" -n rs-hdth-verify
```

After completion:

```bash
rg -n "passed|all exact finite checks passed" submission/results
```

If the project allocation or partition differs, edit only the two corresponding
`#SBATCH` lines in `run_verify.slurm`.
