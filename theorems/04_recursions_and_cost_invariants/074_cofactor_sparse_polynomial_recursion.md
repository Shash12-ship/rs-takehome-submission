# Cofactor Sparse-Polynomial Recursion

## Statement

Let

$$ f:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace, $$

and split off one coordinate, writing inputs as $(z,y)\in\lbrace0,1\rbrace\times\lbrace0,1\rbrace^{n-1}$. Let

$$ f_0(y):=f(0,y), \qquad f_1(y):=f(1,y). $$

Suppose $P_0$ and $P_1$ strictly sign-represent $f_0$ and $f_1$. Let $\mathcal{A}_b$ be the set of nonconstant monomials appearing in $P_b$, and write

$$ m_b:=\lvert\mathcal{A}_b\rvert \qquad (b\in\lbrace0,1\rbrace). $$

Then

$$ H^{\ast}(f) \leq m_0 +\lvert\mathcal{A}_0\cup\mathcal{A}_1\rvert +1. $$

In particular,

$$ H^{\ast}(f) \leq 2m_0+m_1+1. $$

Consequently, in terms of polynomial-threshold sparsity,

$$ H^{\ast}(f) \leq 2\mathrm{ptfsp}(f_0) +\mathrm{ptfsp}(f_1) +1. $$

Also, if both cofactors have threshold degree at most $d$, then

$$ \deg_{\pm}(f)\leq d+1. $$

For nonconstant $f$, this gives the affine-free head bound

$$ H^{\ast}(f) \leq 1+\sum_{r=2}^{\min\lbrace d+1,n\rbrace}\binom{n}{r}. $$

> **Interpretation.** A clean one-head Shannon recursion remains open, but sparse sign polynomials do satisfy an explicit one-sided cofactor recursion. This gives a recursive route for structured functions whose cofactors have sparse sign representations.

## Proof

Let

$$ P_b(y) = c_b+\sum_{S\in\mathcal{A}_b}a_{b,S}\prod_{i\in S}y_i \qquad (b\in\lbrace0,1\rbrace) $$

strictly sign-represent $f_b$. Define

$$ P(z,y):=(1-z)P_0(y)+zP_1(y). $$

If $z=0$, then $P(z,y)=P_0(y)$, and if $z=1$, then $P(z,y)=P_1(y)$. Hence

$$ f(z,y)=1 \qquad\Longleftrightarrow\qquad P(z,y)\gt0. $$

Thus $P$ sign-represents $f$.

Expanding,

$$ P(z,y) = P_0(y)+z\bigl(P_1(y)-P_0(y)\bigr). $$

The nonconstant monomials not involving $z$ are contained in $\mathcal{A}_0$. The monomials involving $z$ are $z$ times the monomials appearing in $P_1-P_0$. These are contained in:

- the singleton monomial $z$, coming from the constant term $c_1-c_0$,
- the monomials $z\prod_{i\in S}y_i$ for $S\in\mathcal{A}_0\cup\mathcal{A}_1$.

Therefore this construction gives a sign polynomial for $f$ with at most

$$ m_0+\lvert\mathcal{A}_0\cup\mathcal{A}_1\rvert+1 $$

nonconstant monomials.

Applying the polynomial-threshold sparsity theorem [041_ptf_sparsity_upper_bound.md](../02_complexity_measure_upper_bounds/041_ptf_sparsity_upper_bound.md) proves

$$ H^{\ast}(f) \leq m_0 +\lvert\mathcal{A}_0\cup\mathcal{A}_1\rvert +1. $$

Since

$$ \lvert\mathcal{A}_0\cup\mathcal{A}_1\rvert \leq m_0+m_1, $$

the displayed coarser bound follows. Minimizing over sparse sign representations of the two cofactors and using the coarser support bound proves the $\mathrm{ptfsp}$ corollary.

Finally, if $P_0$ and $P_1$ have degree at most $d$, then

$$ P(z,y)=(1-z)P_0(y)+zP_1(y) $$

has degree at most $d+1$. Hence

$$ \deg_{\pm}(f)\leq d+1. $$

If $f$ is nonconstant, the affine-free sparsity corollary [048_affine_free_sparsity_upper_bound.md](../03_function_families_and_affine_geometry/048_affine_free_sparsity_upper_bound.md) gives

$$ H^{\ast}(f) \leq 1+\sum_{r=2}^{\min\lbrace d+1,n\rbrace}\binom{n}{r}. $$

$\blacksquare$

## Consequences

This theorem gives a provable recursive replacement for the currently open one-head cofactor recursion:

$$ H^{\ast}(f) \stackrel{?}{\leq} \max\lbrace H^{\ast}(f_0),H^{\ast}(f_1)\rbrace+1. $$

The open recursion would compose head representations directly. The proved recursion composes sparse sign polynomials instead, then routes them through the sparse-PTF upper bound.

For a decision tree, iterating this construction recovers the fact that a depth $d$ tree has threshold degree at most $d$. For formulas and branching programs with sparse cofactor sign polynomials, the support-count version can be sharper than using degree alone.
