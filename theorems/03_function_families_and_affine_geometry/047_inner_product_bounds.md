# Inner-Product Mod Two Bounds

## Statement

For $m\geq1$, define

$$ \mathrm{IP}_m(x,y) := \bigoplus_{i=1}^{m}x_i y_i, \qquad x,y\in\lbrace0,1\rbrace^m. $$

Then

$$ \deg_{\pm}(\mathrm{IP}_m)=m $$

and therefore

$$ m\leq H^{\ast}(\mathrm{IP}_m)\leq2^m-1. $$

> **Interpretation.** Inner product mod $2$ is a standard nonsymmetric test family whose threshold degree is exactly the number of pairs. It already forces linearly many heads, while the sparse-polynomial route gives a simple exponential upper bound.

## Proof

### Threshold-degree lower bound

Restrict $y_1=\cdots=y_m=1$. On this subcube,

$$ \mathrm{IP}_m(x,1) = \bigoplus_{i=1}^{m}x_i = \mathrm{XOR}_m(x). $$

By the affine-parity restriction theorem [046_affine_parity_exact.md](046_affine_parity_exact.md),

$$ H^{\ast}(\mathrm{IP}_m)\geq m. $$

Equivalently, using the threshold-degree theorem [006_threshold_degree_head_complexity_bound.md](../01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md), this restriction proves

$$ \deg_{\pm}(\mathrm{IP}_m)\geq m. $$

For the matching threshold-degree upper bound, define

$$ A_i(x,y):=x_i+y_i-\frac{3}{2}. $$

Then $A_i(x,y)\gt0$ exactly when $x_i y_i=1$, and $A_i(x,y)\lt0$ otherwise. If $k$ is the number of indices with $x_i y_i=1$, then

$$ \prod_{i=1}^{m}A_i(x,y) $$

has sign $(-1)^{m-k}$. Hence

$$ Q(x,y):=(-1)^{m+1}\prod_{i=1}^{m}A_i(x,y) $$

is positive exactly when $k$ is odd, namely when $\mathrm{IP}_m(x,y)=1$. Thus $Q$ sign-represents $\mathrm{IP}_m$ and has degree $m$. Therefore

$$ \deg_{\pm}(\mathrm{IP}_m)\leq m. $$

Combining the two threshold-degree inequalities gives

$$ \deg_{\pm}(\mathrm{IP}_m)=m. $$

Since $\deg_{\pm}(f)\leq H^{\ast}(f)$ for every $f$, we again get

$$ H^{\ast}(\mathrm{IP}_m)\geq m. $$

### Upper bound

The sign-valued parity of the products $x_i y_i$ is

$$ \prod_{i=1}^{m}(1-2x_i y_i). $$

This equals $1$ when $\mathrm{IP}_m(x,y)=0$ and $-1$ when $\mathrm{IP}_m(x,y)=1$. Therefore

$$ P(x,y):= -\prod_{i=1}^{m}(1-2x_i y_i) $$

sign-represents $\mathrm{IP}_m$.

Expanding,

$$ P(x,y) = -1+ \sum_{\varnothing\neq U\subseteq\lbrace1,\ldots,m\rbrace} (-1)^{\lvert U\rvert+1}2^{\lvert U\rvert} \prod_{i\in U}x_i y_i. $$

This polynomial has exactly $2^m-1$ nonconstant monomials in the $2m$ Boolean variables. Applying the polynomial-threshold sparsity upper bound [041_ptf_sparsity_upper_bound.md](../02_complexity_measure_upper_bounds/041_ptf_sparsity_upper_bound.md) gives

$$ H^{\ast}(\mathrm{IP}_m)\leq2^m-1. $$

Combining the lower and upper head bounds proves the theorem. $\blacksquare$

## Consequence

The case $m=1$ is the ordinary two-bit $\mathrm{AND}$, so the bound gives

$$ H^{\ast}(\mathrm{IP}_1)=1. $$

For $m\geq2$, the exact value of $H^{\ast}(\mathrm{IP}_m)$ remains open in these notes. The threshold-degree lower bound is exact at $m$, but the current constructive upper bound is $2^m-1$.
