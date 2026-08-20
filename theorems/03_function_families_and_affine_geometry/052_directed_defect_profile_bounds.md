# Directed-Defect Profile Bounds

## Statement

Let $F:\lbrace0,1,\ldots,m\rbrace\to\lbrace0,1\rbrace$ and define the directed-defect profile function

$$ h_F(x,y) := F(D(x,y)), \qquad x,y\in\lbrace0,1\rbrace^m, $$

where

$$ D(x,y) := \sum_{i=1}^{m}x_i(1-y_i). $$

Let $C(F)$ be the number of sign changes in

$$ F(0),F(1),\ldots,F(m). $$

Define

$$ V_m(C) := \begin{cases} 0 & \text{if } C=0,\cr 1+m+\sum_{r=2}^{C}2^r\binom{m}{r} & \text{if } C\geq1. \end{cases} $$

Then

$$ C(F) \leq H^{\ast}(h_F) \leq V_m(C(F)). $$

> **Interpretation.** Directed-defect profiles measure how many coordinates violate $x_i\leq y_i$. They sit between intersection profiles and Hamming-distance profiles: each defect bit expands into two monomials, $x_i-x_i y_i$, so the upper bound has a $2^r$ expansion cost rather than $1$ or $3^r$.

## Proof

### Lemma 1. Symmetric restriction lower bound

Restrict

$$ y_1=\cdots=y_m=0. $$

Then

$$ D(x,0)=\sum_{i=1}^{m}x_i, $$

and hence

$$ h_F(x,0) = F \left(\sum_{i=1}^{m}x_i\right). $$

This is the symmetric Boolean function with Hamming-weight label sequence

$$ F(0),F(1),\ldots,F(m). $$

By the symmetric sign-change theorem [012_symmetric_sign_changes.md](../01_foundations_and_normal_form/012_symmetric_sign_changes.md), the restricted function has head complexity $C(F)$. Restriction monotonicity from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) gives

$$ H^{\ast}(h_F)\geq C(F). $$

### Lemma 2. A degree-C(F) sign polynomial in the defect count

Define

$$ q_k:= \begin{cases} +1 & \text{if } F(k)=1,\cr -1 & \text{if } F(k)=0, \end{cases} $$

and

$$ \mathcal{J}:=\lbrace j\in\lbrace0,\ldots,m-1\rbrace:q_j\neq q_{j+1}\rbrace. $$

Let

$$ R(t):= q_0\prod_{j\in\mathcal{J}}\left(j+\frac{1}{2}-t\right). $$

As in [050_intersection_profile_bounds.md](050_intersection_profile_bounds.md), $R$ has degree $C(F)$ and satisfies

$$ q_kR(k)\gt0 $$

for every $k\in\lbrace0,\ldots,m\rbrace$. Thus

$$ R(D(x,y)) $$

sign-represents $h_F$.

### Lemma 3. Affine-free sparse expansion upper bound

Set

$$ z_i:=x_i(1-y_i)=x_i-x_i y_i. $$

If $C(F)=0$, then $F$ is constant and $h_F$ is constant, so $H^{\ast}(h_F)=0$.

Assume $C(F)\geq1$. By Lemma 2, $R(z_1+\cdots+z_m)$ sign-represents $h_F$ and has degree at most $C(F)$ in the variables $z_i$. After reducing modulo $z_i^2=z_i$, it is a linear combination of products

$$ \prod_{i\in S}z_i $$

with

$$ 1\leq\lvert S\rvert\leq C(F). $$

For $\lvert S\rvert=1$, the corresponding terms are scalar multiples of

$$ z_i=x_i-x_i y_i. $$

Across all $i$, the linear pieces $x_i$ form one affine part, while the nonlinear pieces $x_i y_i$ contribute at most $m$ degree-two monomials.

For $\lvert S\rvert=r\geq2$, the product

$$ \prod_{i\in S}x_i(1-y_i) $$

expands into at most $2^r$ monomials in the original $2m$ Boolean variables, and every such monomial has degree at least $2$.

Therefore the affine-free support cost of this sign polynomial is at most

$$ 1+m+\sum_{r=2}^{C(F)}2^r\binom{m}{r}. $$

Applying the affine-free polynomial-threshold sparsity upper bound [048_affine_free_sparsity_upper_bound.md](048_affine_free_sparsity_upper_bound.md) gives

$$ H^{\ast}(h_F) \leq 1+m+\sum_{r=2}^{C(F)}2^r\binom{m}{r} = V_m(C(F)). $$

Together with Lemma 1 and the constant case, this proves the theorem. $\blacksquare$

## Consequence

### Lemma 4. Containment and noncontainment

Define

$$ \mathrm{SUB}_m(x,y) := \mathbf{1}[x_i\leq y_i\text{ for every }i], $$

and

$$ \mathrm{NCON}_m:=1-\mathrm{SUB}_m. $$

Equivalently,

$$ \mathrm{SUB}_m(x,y)=\mathbf{1}[D(x,y)=0], \qquad \mathrm{NCON}_m(x,y)=\mathbf{1}[D(x,y)\geq1]. $$

For $m=1$,

$$ H^{\ast}(\mathrm{SUB}_1) = H^{\ast}(\mathrm{NCON}_1) =1. $$

For $m\geq2$,

$$ 2\leq H^{\ast}(\mathrm{SUB}_m)\leq m+1 $$

and

$$ 2\leq H^{\ast}(\mathrm{NCON}_m)\leq m+1. $$

For $m=2$, this is sharpened in [057_two_pair_containment_exact.md](057_two_pair_containment_exact.md) to

$$ H^{\ast}(\mathrm{SUB}_2)=H^{\ast}(\mathrm{NCON}_2)=2. $$

For $m=3$, [059_three_pair_endpoint_exact.md](059_three_pair_endpoint_exact.md) gives

$$ H^{\ast}(\mathrm{SUB}_3)=H^{\ast}(\mathrm{NCON}_3)=2. $$

**Proof.** The upper bound is the theorem with one sign change, so $V_m(1)=m+1$.

For $m=1$, $\mathrm{NCON}_1(x,y)=x(1-y)$ and $\mathrm{SUB}_1=1-\mathrm{NCON}_1$ are nonconstant linear threshold functions, so both have head complexity $1$ by the one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md).

Assume $m\geq2$. We prove $\mathrm{NCON}_m$ is not a linear threshold function. It is enough to restrict to the first two coordinate pairs. Suppose an affine score with coefficients $a_1,a_2$ on $x_1,x_2$, coefficients $b_1,b_2$ on $y_1,y_2$, and constant $c$ is positive on noncontainment inputs and negative on containment inputs.

The inputs $(x,y)=(e_1,0)$ and $(e_2,0)$ violate containment, so

$$ a_1+c\gt0, \qquad a_2+c\gt0. $$

The inputs $(e_1,e_1)$ and $(e_2,e_2)$ satisfy containment, so

$$ a_1+b_1+c\lt0, \qquad a_2+b_2+c\lt0. $$

The cross inputs $(e_1,e_2)$ and $(e_2,e_1)$ violate containment, so

$$ a_1+b_2+c\gt0, \qquad a_2+b_1+c\gt0. $$

Adding the two containment inequalities gives

$$ a_1+a_2+b_1+b_2+2c\lt0. $$

Adding the two cross noncontainment inequalities gives

$$ a_1+a_2+b_1+b_2+2c\gt0, $$

a contradiction. Thus $\mathrm{NCON}_m$ is not a linear threshold function, so $H^{\ast}(\mathrm{NCON}_m)\geq2$.

Complement invariance from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) gives the same lower bound for $\mathrm{SUB}_m$. $\blacksquare$
