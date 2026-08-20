# Affine-Free Cofactor Recursion

## Statement

Let

$$ f:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace, $$

and split off one coordinate, writing inputs as $(z,y)\in\lbrace0,1\rbrace\times\lbrace0,1\rbrace^{n-1}$. Let

$$ f_0(y):=f(0,y), \qquad f_1(y):=f(1,y). $$

Suppose $P_0$ and $P_1$ strictly sign-represent $f_0$ and $f_1$, and write

$$ P_b(y) = c_b+\sum_{i=1}^{n-1}\alpha_{b,i}y_i +\sum_{\substack{S\subseteq\lbrace1,\ldots,n-1\rbrace\cr \lvert S\rvert\geq2}} a_{b,S}\prod_{i\in S}y_i \qquad (b\in\lbrace0,1\rbrace). $$

Let

$$ \mathcal{N}_b := \left\lbrace S\subseteq\lbrace1,\ldots,n-1\rbrace: \lvert S\rvert\geq2,\ a_{b,S}\neq0 \right\rbrace, $$

and let

$$ \mathcal{L}_{\Delta} := \left\lbrace i\in\lbrace1,\ldots,n-1\rbrace: \alpha_{1,i}\neq\alpha_{0,i} \right\rbrace. $$

Then

$$ H^{\ast}(f) \leq 1 +\lvert\mathcal{N}_0\rvert +\lvert\mathcal{N}_0\cup\mathcal{N}_1\rvert +\lvert\mathcal{L}_{\Delta}\rvert. $$

Consequently, if both cofactors have threshold degree at most $d$, then

$$ H^{\ast}(f) \leq 1+(n-1) +2\sum_{r=2}^{\min\lbrace d,n-1\rbrace}\binom{n-1}{r}. $$

In particular, if both cofactors are constants or linear threshold functions, then

$$ H^{\ast}(f)\leq n. $$

Finally, if $f_0$ and $f_1$ have affine sign representations whose linear coefficient vectors differ in at most one coordinate, then

$$ H^{\ast}(f)\leq2. $$

In that last case, the exact value is $0$, $1$, or $2$ according as $f$ is constant, a nonconstant linear threshold function, or neither.

> **Interpretation.** The sparse cofactor recursion can overpay for linear terms. Affine-free sparsity bundles all affine terms into one head and only pays separately for genuine nonlinear cofactor monomials and for slope changes across the split.

## Proof

Define

$$ P(z,y):=(1-z)P_0(y)+zP_1(y). $$

As in the sparse cofactor recursion, $P$ strictly sign-represents $f$, because $P(0,y)=P_0(y)$ and $P(1,y)=P_1(y)$.

Expanding,

$$ P(z,y) = P_0(y)+z\bigl(P_1(y)-P_0(y)\bigr). $$

The affine part of $P$ includes the constant term, the linear terms in $y$ from $P_0$, and the possible singleton term $z(c_1-c_0)$. All of these cost at most one affine head under the affine-free sparsity theorem [048_affine_free_sparsity_upper_bound.md](../03_function_families_and_affine_geometry/048_affine_free_sparsity_upper_bound.md).

The genuinely nonlinear monomials of $P$ are contained in three groups.

1. The nonlinear monomials from $P_0$, namely

$$ \prod_{i\in S}y_i \qquad (S\in\mathcal{N}_0). $$

2. The mixed quadratic monomials coming from changed linear coefficients:

$$ z y_i \qquad (i\in\mathcal{L}_{\Delta}). $$

3. The mixed monomials coming from nonlinear cofactor differences:

$$ z\prod_{i\in S}y_i \qquad (S\in\mathcal{N}_0\cup\mathcal{N}_1). $$

Therefore

$$ \mathrm{afs}(P) \leq 1 +\lvert\mathcal{N}_0\rvert +\lvert\mathcal{L}_{\Delta}\rvert +\lvert\mathcal{N}_0\cup\mathcal{N}_1\rvert. $$

Applying the affine-free sparsity theorem gives the same upper bound for $H^{\ast}(f)$:

$$ H^{\ast}(f) \leq 1 +\lvert\mathcal{N}_0\rvert +\lvert\mathcal{N}_0\cup\mathcal{N}_1\rvert +\lvert\mathcal{L}_{\Delta}\rvert. $$

For the threshold-degree corollary, choose degree-at-most $d$ sign polynomials for both cofactors. Then

$$ \lvert\mathcal{N}_b\rvert \leq \sum_{r=2}^{\min\lbrace d,n-1\rbrace}\binom{n-1}{r} \qquad (b\in\lbrace0,1\rbrace), $$

and

$$ \lvert\mathcal{L}_{\Delta}\rvert\leq n-1. $$

Substituting these bounds proves

$$ H^{\ast}(f) \leq 1+(n-1) +2\sum_{r=2}^{\min\lbrace d,n-1\rbrace}\binom{n-1}{r}. $$

If both cofactors are constants or linear threshold functions, take $d=1$. The sum is empty, so

$$ H^{\ast}(f)\leq n. $$

Finally, suppose $f_0$ and $f_1$ have affine sign representations whose linear coefficient vectors differ in at most one coordinate. Then

$$ \mathcal{N}_0=\mathcal{N}_1=\varnothing, \qquad \lvert\mathcal{L}_{\Delta}\rvert\leq1. $$

The displayed bound gives $H^{\ast}(f)\leq2$. The exact $0$, $1$, or $2$ classification follows from the low affine-free support theorem [070_low_affine_free_support_exact.md](../03_function_families_and_affine_geometry/070_low_affine_free_support_exact.md). $\blacksquare$

## Consequences

This theorem gives a sharper recursion than the raw sparse-polynomial cofactor bound whenever the cofactor polynomials have many linear terms. In particular, a function whose two slices along one coordinate are LTFs always has a linear head bound:

$$ H^{\ast}(f)\leq n. $$

The strongest exact corollary is the one-slope-change case. If the two affine slice separators differ in no slope coordinates, the glued polynomial is affine and $f$ is an LTF. If they differ in one slope coordinate, the glued polynomial is affine plus one quadratic monomial, so the low affine-free support classification gives the exact constant, one-head, or two-head split.
