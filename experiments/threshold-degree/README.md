# Threshold-Degree Solver

This directory contains a self-contained solver for the threshold degree of total
and partial Boolean functions. It is separate from the PyTorch-based experimental
$H^{\ast}$ solver in [`experiments/hstar/search.py`](../hstar/search.py).

## What threshold degree means

Let $D\subseteq\lbrace 0,1\rbrace^n$ be a set of Boolean inputs, and let
$f:D\to\lbrace 0,1\rbrace$ be a Boolean function. The function is *total* when
$D=\lbrace 0,1\rbrace^n$ and *partial* when it is specified only on a subset of
the cube.

A **real polynomial** in $n$ variables is a finite sum of monomials with real
coefficients. It has the form

$$ p(x_1,\ldots,x_n)=\sum_{\alpha\in A}c_\alpha x_1^{\alpha_1}\cdots x_n^{\alpha_n},\qquad c_\alpha\in\mathbb{R}, $$

where $A$ is a finite set of exponent vectors
$\alpha=(\alpha_1,\ldots,\alpha_n)$ whose entries are nonnegative integers. The
**total degree** of $p$ is the largest value of
$\alpha_1+\cdots+\alpha_n$ among its monomials with nonzero coefficients.

On Boolean inputs, this simplifies. Since $x_i\in\lbrace 0,1\rbrace$,

$$ x_i^k=x_i\qquad\text{for every integer }k\geq 1. $$

Thus every polynomial can be made **multilinear** without changing its values
on the Boolean cube or increasing its degree. Equivalently, we may assume that
every exponent $\alpha_i$ is either $0$ or $1$ and write

$$ p(x)=\sum_{S\subseteq\lbrace 1,\ldots,n\rbrace}c_S\prod_{i\in S}x_i. $$

In this form, the total degree is the largest $\lvert S\rvert$ for which
$c_S\neq 0$.

The polynomial $p$ **sign-represents** $f$ on $D$ when its sign agrees with the
output at every specified input:

$$ f(x)=1\Longleftrightarrow p(x)\gt 0,\qquad f(x)=0\Longleftrightarrow p(x)\lt 0. $$

In particular, $p$ may not vanish at any point in $D$. The **threshold degree**
of $f$ is the smallest total degree of any polynomial that sign-represents it:

$$ \deg_{\pm}(f)=\min\lbrace\deg(p):p\text{ sign-represents }f\text{ on }D\rbrace. $$

> Put informally, threshold degree asks how complicated a polynomial must be if
> only the sign of its value, rather than its exact value, needs to reproduce the
> truth table.

For example, AND and OR have threshold degree $1$, while two-bit XOR has
threshold degree $2$.

## From the definition to a linear program

For the linear program, replace each bit by
$s_i=1-2x_i\in\lbrace -1,1\rbrace$. This substitution preserves degree. For a
candidate degree $d$, define a matrix $A_d$ whose rows are indexed by $x\in D$
and whose columns are indexed by subsets
$S\subseteq\lbrace 1,\ldots,n\rbrace$ with $\lvert S\rvert\leq d$:

$$ A_d[x,S]=(2f(x)-1)\prod_{i\in S}s_i. $$

There is a degree $d$ sign-representing polynomial exactly when some coefficient
vector $c$ satisfies

$$ A_d c\geq\mathbf{1}. $$

The right side can be fixed at $\mathbf{1}$ because $D$ is finite, so any
strictly positive margins can be rescaled.

When the linear program is infeasible, the solver looks for nonnegative weights
$\lambda_x$, one for each input $x\in D$, such that the weights sum to $1$ and
the weighted average of every column of $A_d$ is zero:

$$ \lambda\geq 0,\qquad A_d^\top\lambda=0,\qquad \sum_x\lambda_x=1. $$

To see why these weights are a certificate, suppose some $c$ satisfied
$A_d c\geq\mathbf{1}$. The weighted average of the entries of $A_d c$ would be
at least $1$. But the zero-column-average condition gives

$$ \lambda^\top A_d c=(A_d^\top\lambda)^\top c=0. $$

This contradiction proves that no degree $d$ sign-representing polynomial
exists.

The solver uses SciPy's HiGHS backend. It also attempts to reconstruct
independently verifiable integer primal and dual witnesses from the numerical
solutions.

## Exactness

HiGHS uses floating-point arithmetic. A result is reported as `exact` only when
the solver reconstructs and verifies an integer sign-representing polynomial
and, for positive degree, an integer dual lower-bound certificate.

The JSON `status` field has four possible values:

- `exact`: the threshold degree has exact upper and lower certificates.

- `numerical`: HiGHS found a candidate threshold degree, but at least one exact
  certificate is unavailable.

- `certified-lower-bound`: the degree cutoff was reached and an exact dual
  certificate proves the reported lower bound.

- `numerical-lower-bound`: the degree cutoff was reached without an exact dual
  certificate.

The `upper_bound_certified` and `lower_bound_certified` fields expose the two
checks separately. Using `--no-dual` normally makes a positive-degree result
`numerical`, even when its polynomial certificate is exact.

## Files

- `solver.py`: Boolean-domain validation, monomial matrices, LP solving, and
  certificate verification.

- `cli.py`: command-line parsing and JSON output.

- `tests/test_solver.py`: exact-value, witness, and regression tests.

- `examples/`: full and partial truth-table inputs.

## Command line

The solver requires Python 3.10 or newer, NumPy, and SciPy. Install its
dependencies into any Python environment:

```bash
python -m pip install -r experiments/threshold-degree/requirements.txt
```

For a full truth table, list outputs in lexicographic input order. The bitstring
`0110` is two-bit XOR:

```bash
python experiments/threshold-degree/cli.py \
  --truth-table 0110
```

The number of bits is inferred from the truth-table length. It can be checked
explicitly with `--n`.

JSON input is also supported:

```bash
python experiments/threshold-degree/cli.py \
  --input experiments/threshold-degree/examples/xor.json
```

A partial function uses a list of points:

```json
{
  "n_bits": 2,
  "points": [
    {"input": "00", "output": 0},
    {"input": "01", "output": 1},
    {"input": "10", "output": 1}
  ]
}
```

Use `--max-degree d` to stop the search at degree $d$. If no polynomial has
been found, the result reports a certified lower bound. Use `--no-dual` to skip
constructing the explicit dual certificate.

## Tests

From this directory, run:

```bash
python -m unittest discover -s tests -v
```

The tests cover constants, AND, XOR, parity, partial functions, lower-bound-only
searches, and the ten-bit strict-separation function $f_{10}$.

## Scaling

For a domain of size $m$, the degree $d$ LP has $m$ constraints and

$$ \sum_{k=0}^{d}\binom{n}{k} $$

coefficient variables. The current implementation materializes this matrix
densely because every entry is $+1$ or $-1$. A configurable entry limit prevents
accidental construction of an unreasonably large matrix.
