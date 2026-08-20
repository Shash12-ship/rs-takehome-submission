# Affine Statistic Sign-Change Upper Bound

## Statement

Let

$$ L(x)=c+\sum_{i=1}^{n}a_i x_i $$

be an affine function on $\lbrace0,1\rbrace^n$, and let

$$ \mathrm{supp}(L):=\lbrace i:a_i\neq0\rbrace, \qquad k:=\lvert\mathrm{supp}(L)\rvert. $$

Let $G:\mathrm{Im}(L)\to\lbrace0,1\rbrace$, and define

$$ f(x):=G(L(x)). $$

Write the distinct image values as

$$ z_1\lt z_2\lt\cdots\lt z_M, $$

and let $C_L(G)$ be the number of sign changes in the sequence

$$ G(z_1),G(z_2),\ldots,G(z_M). $$

Then:

1. If $C_L(G)=0$, then $H^{\ast}(f)=0$.

2. If $C_L(G)=1$, then $H^{\ast}(f)=1$.

3. If $C_L(G)=2$, then

   $H^{\ast}(f) = 1$ if $f$ is a nonconstant linear threshold function, and $H^{\ast}(f) = 2$ otherwise.

4. If $C_L(G)\geq3$, then

   $H^{\ast}(f) \leq 1+\sum_{r=2}^{\min\lbrace C_L(G),k\rbrace}\binom{k}{r}.$

> **Interpretation.** A function of one arbitrary affine statistic is controlled by the number of label changes along that statistic. The first three regimes are exact or exactly reduced to the one-head test; beyond that, the affine-free sparse-polynomial route gives an explicit support-size bound.

## Proof

Let

$$ C:=C_L(G). $$

### Lemma 1. Sign changes give a univariate sign polynomial

For each index $j$ with

$$ G(z_j)\neq G(z_{j+1}), $$

choose a cutpoint $\tau_j$ satisfying

$$ z_j\lt\tau_j\lt z_{j+1}. $$

Let $J$ be the set of these change indices. Define

$$ Q(t):=\sigma\prod_{j\in J}(t-\tau_j), $$

where $\sigma\in\lbrace-1,1\rbrace$ is chosen so that

$$ Q(z_1)\gt0 \qquad\Longleftrightarrow\qquad G(z_1)=1. $$

As $t$ passes through the ordered image values, the sign of $Q(t)$ flips exactly at the selected cutpoints. Therefore

$$ G(z_m)=1 \qquad\Longleftrightarrow\qquad Q(z_m)\gt0 $$

for every $m$. Consequently,

$$ f(x)=1 \qquad\Longleftrightarrow\qquad Q(L(x))\gt0. $$

Thus $Q(L(x))$ is a sign-representing polynomial for $f$ of degree at most $C$ in the affine statistic $L$.

### Lemma 2. General sparse upper bound

Expand $Q(L(x))$ on the Boolean cube and reduce multilinearly using $x_i^2=x_i$. Only variables in $\mathrm{supp}(L)$ can appear, and the degree is at most

$$ d:=\min\lbrace C,k\rbrace. $$

Thus the number of possible nonlinear monomials is at most

$$ \sum_{r=2}^{d}\binom{k}{r}. $$

If the resulting function is nonconstant, the affine-free polynomial-threshold sparsity upper bound [048_affine_free_sparsity_upper_bound.md](048_affine_free_sparsity_upper_bound.md) gives

$$ H^{\ast}(f) \leq 1+\sum_{r=2}^{d}\binom{k}{r}. $$

This proves the displayed upper bound whenever $C\geq1$, and in particular for $C\geq3$.

### Lemma 3. The small sign-change cases

If $C=0$, then $G$ is constant on $\mathrm{Im}(L)$, so $f$ is constant and

$$ H^{\ast}(f)=0. $$

If $C=1$, then $G$ changes once along the ordered image. Hence there is a cutpoint $\tau$ such that either

$$ f(x)=\mathbf{1}[L(x)\gt\tau] $$

or

$$ f(x)=\mathbf{1}[L(x)\lt\tau]. $$

This is a nonconstant LTF, so the one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) gives

$$ H^{\ast}(f)=1. $$

If $C=2$, then either the true set or the false set is a single affine slab:

$$ \alpha\leq L(x)\leq\beta $$

for suitable $\alpha\leq\beta$. The affine-slab theorem [062_affine_slab_upper_bound.md](062_affine_slab_upper_bound.md), together with complement invariance from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), gives

$$ H^{\ast}(f)\leq2. $$

If $f$ is a nonconstant LTF, the one-head characterization gives $H^{\ast}(f)=1$. Otherwise the same characterization gives $H^{\ast}(f)\geq2$, and the two-head upper bound gives

$$ H^{\ast}(f)=2. $$

This proves all cases. $\blacksquare$

## Consequence

The positive-projection sign-change theorem gives the sharper bound

$$ H^{\ast}(f)\leq C_{+}(f) $$

when the statistic can be chosen with strictly positive weights. This lemma is the orientation-free fallback for a single affine statistic: mixed signs in $L$ no longer break the route, but for $C\geq3$ the price is the affine-free support bound.

For a statistic using $k$ coordinates and $C$ sign changes, the nonconstant fallback is

$$ H^{\ast}(f) \leq 1+\sum_{r=2}^{\min\lbrace C,k\rbrace}\binom{k}{r}. $$

The cases $C=1$ and $C=2$ are sharper:

$$ C=1 \Longrightarrow H^{\ast}(f)=1, \qquad C=2 \Longrightarrow H^{\ast}(f)\leq2. $$
