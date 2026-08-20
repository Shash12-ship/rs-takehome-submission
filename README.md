# How many attention heads does it take to compute a Boolean function?

A single attention head can linearly realize $\mathrm{AND}$ or $\mathrm{OR}$ on two bits,
but it cannot realize $\mathrm{XOR}$. Two heads can. This small gap is the seed of the
whole project: it suggests that the **number of attention heads** is itself a complexity
measure for Boolean functions, sitting somewhere alongside the classical measures
(threshold degree, circuit depth, Fourier complexity) but native to the transformer.

We make that precise, prove what we can, and measure the rest empirically.

## The question

Fix a **single-layer, attention-only transformer**: $n$ input bits plus one query token,
one self-attention layer with $H$ parallel heads, no MLP, no layer norm, and a linear
readout from the query token. A Boolean function $f : \lbrace 0,1\rbrace^n \to \lbrace 0,1\rbrace$ is
*computable with* $H$ *heads* if some choice of embeddings, attention parameters, and
readout reproduces $f$ on every input. Define

$$H^{\ast}(f) := \min\lbrace H : f \text{ is computable with } H \text{ heads} \rbrace.$$

The central problem: **understand $H^{\ast}(f)$** as a function of $f$. Prove lower and upper
bounds, compute it for natural families, and ask whether it equals a known invariant.

The precise model (embeddings, softmax head, residual readout, masking convention) is in
[`model.md`](model.md); the formal problem statement and the list of core questions is in
[`problem_statement.md`](problem_statement.md).

## What we know so far

The results below are written up in full under [`theorems/`](theorems/) and indexed, with the
dependency order between them, in [`theorems.md`](theorems.md).

**Lower bounds (a function needs many heads).**
- *Checkerboard obstruction.* If $f$ has a 2-bit "checkerboard" restriction (one diagonal
  of some 2-cube slice disagrees with the other, the way $\mathrm{XOR}$ does), then
  $H^{\ast}(f) \geq 2$. One head can never separate the two diagonals.
- *Threshold-degree bound.* Head complexity dominates threshold degree:
  $\deg_{\pm}(f) \leq H^{\ast}(f)$.

**Upper bounds (a function needs few heads).**
- *Symmetric thresholds need one head.* Every $T_{n,t}(x) = \mathbf{1}[|x| \geq t]$ is
  computable with a single head, so $H^{\ast}(\mathrm{AND}_n) = H^{\ast}(\mathrm{OR}_n) = H^{\ast}(\mathrm{MAJORITY}_n) = 1$.
- *Weighted-sum interpolation.* If $f(x) = F\left(\sum_i \lambda_i x_i\right)$ for
  positive weights $\lambda_i$ and the weighted sum takes $M$ distinct values, then
  $H^{\ast}(f) \leq M - 1$. Consequently every symmetric function needs at most $n$ heads and
  every Boolean function at most $2^n - 1$.

**Exact answers.**
- *Parity is the extremal case.* $H^{\ast}(\mathrm{XOR}_n) = n$: in this model, parity needs
  exactly one head per input bit. The lower bound comes from $\deg _{\pm}(\mathrm{PARITY}_n) = n$, the upper bound from an explicit $n$-head construction.
- A first split inside the symmetric functions: monotone thresholds have complexity $1$,
  while parity and the internal exact-count predicates $\mathrm{EXACT}_{n,k}$ need at
  least $2$.

**Strict separation.**
- [Theorem 13](theorems/02_separations_and_counterexamples/013_strict_threshold_degree_separation.md)
  gives an explicit ten-bit function $f_{10}$ with
  $\deg_{\pm}(f_{10})=2 \lt 3\leq H^{\ast}(f_{10})$. Thus threshold degree is a genuine
  lower bound, not an exact characterization of head complexity.

Taken together this is a *partial* characterization, not yet a single invariant
$I(f)$ with $H^{\ast}(f) \asymp I(f)$. Closing that gap is the main open problem.

## Open directions

- Determine the exact value of $H^{\ast}(f_{10})$, and find scalable families with a
  growing gap between threshold degree and head complexity.
- Tighten the gap between the threshold-degree lower bound and the weighted-sum upper
  bound.
- Push the formalization in [`formalization/`](formalization/) to cover more of the
  theorem stack.
- Extend the empirical search to larger $n$ and reconcile it with the proofs.

## Repository map

| Path | What it is |
| --- | --- |
| [`problem_statement.md`](problem_statement.md) | The question and the core open problems. |
| [`model.md`](model.md) | The precise attention model and the definition of $H^{\ast}(f)$. |
| [`theorems.md`](theorems.md) | Ledger of the main theorems, their status, and how they fit together. |
| [`theorems/`](theorems/) | Full writeups: initial results, normal forms, and explicit separations. |
| [`artifacts/intro-materials/writeup.md`](artifacts/intro-materials/writeup.md) | Original blog-post writeup of the two-bit XOR result. |
| [`literature_survey.md`](literature_survey.md) | Related work across transformers and Boolean complexity. |
| [`formalization/`](formalization/) | Lean 4 formalization of the results (depends on mathlib). |
| [`experiments/hstar/`](experiments/hstar/) | Python package that empirically estimates $H^{\ast}(f)$ by training small attention models. |
| [`artifacts/intro-materials/proposal.pdf`](artifacts/intro-materials/proposal.pdf) / [`proposal.tex`](artifacts/intro-materials/proposal.tex) | Project proposal (build with `./artifacts/scripts/compile_pdf.sh`). |
| [`AGENTS.md`](AGENTS.md) | Markdown conventions used across the writeups. |

New here? Read [`problem_statement.md`](problem_statement.md), then skim
[`theorems.md`](theorems.md). The individual files under [`theorems/`](theorems/) are self-contained.

## Getting started

**Lean proofs.** Needs [Lean 4 / elan](https://leanprover-community.github.io/get_started.html).

```bash
bash artifacts/scripts/validate.sh --fetch-cache
```

**Python search.** Needs Python with [PyTorch](https://pytorch.org/). The package
enumerates symmetry-class representatives of $n$-bit functions and, for each, trains
attention models with increasing head counts to estimate $H^{\ast}(f)$.

```bash
# Estimate H*(f) over all 3-bit representatives, trying up to 3 heads.
PYTHONPATH=experiments python -m hstar.cli --n 3 --max-heads 3
```

Useful flags: `--limit` / `--start-index` / `--end-index` to slice the representative
list, `--robust` for a stronger second-pass search, `--device {cpu,cuda,mps}`, and
`--output result.json` to save the payload. Run with `--help` for the full list.

**Proposal PDF.**

```bash
./artifacts/scripts/compile_pdf.sh   # runs pdflatex on proposal.tex and cleans up aux files
```
