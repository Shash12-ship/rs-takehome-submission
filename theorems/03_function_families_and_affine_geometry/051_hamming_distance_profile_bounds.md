# Hamming-Distance Profile Bounds

## Statement

Let $F:\lbrace0,1,\ldots,m\rbrace\to\lbrace0,1\rbrace$ and define the Hamming-distance profile function

$$ g_F(x,y) := F \left(\Delta(x,y)\right), \qquad x,y\in\lbrace0,1\rbrace^m, $$

where

$$ \Delta(x,y) := \sum_{i=1}^{m}(x_i\oplus y_i) = \sum_{i=1}^{m}(x_i+y_i-2x_i y_i). $$

Let $C(F)$ be the number of sign changes in the sequence

$$ F(0),F(1),\ldots,F(m). $$

Define

$$ U_m(C) := \begin{cases} 0 & \text{if } C=0,\cr 1+m+\sum_{r=2}^{C}3^r\binom{m}{r} & \text{if } C\geq1. \end{cases} $$

Then

$$ C(F) \leq H^{\ast}(g_F) \leq U_m(C(F)). $$

> **Interpretation.** Hamming-distance profiles have the same symmetric sign-change lower bound as ordinary symmetric functions, by restricting one string to zero. The upper bound is less efficient than the intersection-profile bound because each distance bit $x_i\oplus y_i$ expands into three monomials, but all linear terms still cost only one affine head.

## Proof

### Lemma 1. Symmetric restriction lower bound

Restrict

$$ y_1=\cdots=y_m=0. $$

Then

$$ \Delta(x,0)=\sum_{i=1}^{m}x_i, $$

and therefore

$$ g_F(x,0) = F \left(\sum_{i=1}^{m}x_i\right). $$

This is the symmetric Boolean function with Hamming-weight label sequence

$$ F(0),F(1),\ldots,F(m). $$

By the symmetric sign-change theorem [012_symmetric_sign_changes.md](../01_foundations_and_normal_form/012_symmetric_sign_changes.md), the restricted function has head complexity $C(F)$. Restriction monotonicity from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) gives

$$ H^{\ast}(g_F)\geq C(F). $$

### Lemma 2. A degree-C(F) sign polynomial in distance

As in [050_intersection_profile_bounds.md](050_intersection_profile_bounds.md), define

$$ q_k:= \begin{cases} +1 & \text{if } F(k)=1,\cr -1 & \text{if } F(k)=0, \end{cases} $$

and

$$ \mathcal{J}:=\lbrace j\in\lbrace0,\ldots,m-1\rbrace:q_j\neq q_{j+1}\rbrace. $$

Let

$$ R(t):= q_0\prod_{j\in\mathcal{J}}\left(j+\frac{1}{2}-t\right). $$

Then $R$ has degree $C(F)$ and satisfies

$$ q_kR(k)\gt0 $$

for every $k\in\lbrace0,\ldots,m\rbrace$.

Thus

$$ R(\Delta(x,y)) $$

sign-represents $g_F$.

### Lemma 3. Affine-free sparse expansion upper bound

Set

$$ z_i:=x_i\oplus y_i=x_i+y_i-2x_i y_i. $$

If $C(F)=0$, then $F$ is constant and $g_F$ is constant, so $H^{\ast}(g_F)=0$.

Assume $C(F)\geq1$. By Lemma 2, $R(z_1+\cdots+z_m)$ sign-represents $g_F$ and has degree at most $C(F)$ in the variables $z_i$. After reducing modulo $z_i^2=z_i$, it is a linear combination of products

$$ \prod_{i\in S}z_i $$

with

$$ 1\leq\lvert S\rvert\leq C(F). $$

For $\lvert S\rvert=1$, the corresponding terms are scalar multiples of

$$ z_i=x_i+y_i-2x_i y_i. $$

Across all $i$, the linear pieces $x_i$ and $y_i$ form one affine part, while the nonlinear pieces $x_i y_i$ contribute at most $m$ degree-two monomials.

For $\lvert S\rvert=r\geq2$, the product

$$ \prod_{i\in S}(x_i+y_i-2x_i y_i) $$

expands into at most $3^r$ monomials in the original $2m$ Boolean variables, and every such monomial has degree at least $2$.

Therefore the affine-free support cost of this sign polynomial is at most

$$ 1+m+\sum_{r=2}^{C(F)}3^r\binom{m}{r}. $$

Applying the affine-free polynomial-threshold sparsity upper bound [048_affine_free_sparsity_upper_bound.md](048_affine_free_sparsity_upper_bound.md) gives

$$ H^{\ast}(g_F) \leq 1+m+\sum_{r=2}^{C(F)}3^r\binom{m}{r} = U_m(C(F)). $$

Together with Lemma 1 and the constant case, this proves the theorem. $\blacksquare$

## Consequence

### Lemma 4. Hamming-distance thresholds

For $1\leq t\leq m$, define

$$ \mathrm{HDTH}_{m,t}(x,y) := \mathbf{1}[\Delta(x,y)\geq t]. $$

Then

$$ H^{\ast}(\mathrm{HDTH}_{1,1})=2, $$

and for $m\geq2$,

$$ 2\leq H^{\ast}(\mathrm{HDTH}_{m,t})\leq m+1. $$

**Proof.** The upper bound is the theorem with one sign change, so $U_m(1)=m+1$.

For the lower bound, fix the first $t-1$ pairs to be unequal, leave pair $t$ free, and fix all pairs after $t$ to be equal. Then $\mathrm{HDTH}_{m,t}$ restricts to

$$ x\oplus y $$

on the free pair. Exact two-bit parity gives head complexity $2$, so restriction monotonicity gives the lower bound.

When $m=1$ and $t=1$, the function is exactly $\mathrm{XOR}_2$, so the exact parity theorem gives

$$ H^{\ast}(\mathrm{HDTH}_{1,1})=2. $$

$\blacksquare$

### Lemma 5. Equality revisited

Equality is the endpoint Hamming-distance profile

$$ \mathrm{EQ}_m(x,y)=\mathbf{1}[\Delta(x,y)=0]. $$

Here $C(F)=1$, so the theorem gives

$$ H^{\ast}(\mathrm{EQ}_m)\leq m+1. $$

The sharper equality bracket and threshold-degree statement are recorded in [049_equality_bounds.md](049_equality_bounds.md).
