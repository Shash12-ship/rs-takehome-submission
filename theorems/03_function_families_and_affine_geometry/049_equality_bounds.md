# Equality Bounds

## Statement

For $m\geq1$, define equality on two $m$-bit strings by

$$ \mathrm{EQ}_m(x,y) := \mathbf{1}[x=y], \qquad x,y\in\lbrace0,1\rbrace^m. $$

Then

$$ \deg_{\pm}(\mathrm{EQ}_m)=2 $$

and, in fact,

$$ H^{\ast}(\mathrm{EQ}_m)=2. $$

> **Interpretation.** Equality has threshold degree two and exact head complexity two. The affine-free sparsity proof gives the weaker linear upper bound $m+1$, while the exact two-head construction is recorded in [060_equality_exact_two_heads.md](060_equality_exact_two_heads.md).

## Proof

### Lemma 1. Equality has threshold degree at most two

Consider

$$ P(x,y) := \frac{1}{2} - \sum_{i=1}^{m}(x_i-y_i)^2. $$

If $x=y$, then every squared difference is $0$, so

$$ P(x,y)=\frac{1}{2}\gt0. $$

If $x\neq y$, then at least one squared difference is $1$, so

$$ P(x,y)\leq-\frac{1}{2}\lt0. $$

Thus $P$ sign-represents $\mathrm{EQ}_m$. On the Boolean cube,

$$ (x_i-y_i)^2=x_i+y_i-2x_i y_i, $$

so

$$ P(x,y) = \frac{1}{2} - \sum_{i=1}^{m}x_i - \sum_{i=1}^{m}y_i + 2\sum_{i=1}^{m}x_i y_i. $$

This is a degree-two multilinear polynomial. Therefore

$$ \deg_{\pm}(\mathrm{EQ}_m)\leq2. $$

### Lemma 2. Equality has threshold degree at least two

Restrict all pairs except the first one to be equal, for instance

$$ x_2=y_2=\cdots=x_m=y_m=0. $$

On the remaining two variables,

$$ \mathrm{EQ}_m(x,y) = \mathrm{EQ}_1(x_1,y_1). $$

The function $\mathrm{EQ}_1$ is the complement of $\mathrm{XOR}_2$. If a polynomial sign-represents $\mathrm{EQ}_1$, multiplying it by $-1$ sign-represents $\mathrm{XOR}_2$. Since parity on two bits has threshold degree $2$ by [007_parity_threshold_degree.md](../01_foundations_and_normal_form/007_parity_threshold_degree.md), we get

$$ \deg_{\pm}(\mathrm{EQ}_1)=2. $$

Threshold degree cannot increase under restriction, because restricting variables in a sign-representing polynomial preserves its degree and sign pattern on the restricted cube. Hence

$$ \deg_{\pm}(\mathrm{EQ}_m)\geq2. $$

Combining Lemmas 1 and 2 gives

$$ \deg_{\pm}(\mathrm{EQ}_m)=2. $$

### Lemma 3. Equality has an m+1 head upper bound

The expansion from Lemma 1 has one nonzero affine part and exactly $m$ nonlinear monomials:

$$ x_1y_1,\ldots,x_m y_m. $$

Applying the affine-free polynomial-threshold sparsity bound [048_affine_free_sparsity_upper_bound.md](048_affine_free_sparsity_upper_bound.md) gives

$$ H^{\ast}(\mathrm{EQ}_m)\leq m+1. $$

The lower bound

$$ H^{\ast}(\mathrm{EQ}_m)\geq2 $$

follows from the threshold-degree lower bound [006_threshold_degree_head_complexity_bound.md](../01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md).

When $m=1$, the upper and lower bounds coincide, so

$$ H^{\ast}(\mathrm{EQ}_1)=2. $$

For all $m\geq1$, the sharper two-atom construction in [060_equality_exact_two_heads.md](060_equality_exact_two_heads.md) gives

$$ H^{\ast}(\mathrm{EQ}_m)\leq2. $$

$\blacksquare$

## Consequence

Equality now gives a fully exact low-degree family:

$$ \deg_{\pm}(\mathrm{EQ}_m)=2, \qquad H^{\ast}(\mathrm{EQ}_m)=2. $$

Thus equality is no longer a candidate separation between threshold degree and head complexity. It is a useful model case for constructing two affine-over-positive-affine atoms from a quadratic sign representation.
