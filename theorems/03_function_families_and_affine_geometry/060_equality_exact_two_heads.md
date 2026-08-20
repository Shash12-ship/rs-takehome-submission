# Equality Has Exact Head Complexity Two

## Statement

For $m\geq1$, let

$$ \mathrm{EQ}_m(x,y):=\mathbf{1}[x=y], \qquad x,y\in\lbrace0,1\rbrace^m. $$

Then

$$ H^{\ast}(\mathrm{EQ}_m)=2. $$

Consequently,

$$ H^{\ast}(\mathrm{NEQ}_m)=2 $$

for $\mathrm{NEQ}_m:=1-\mathrm{EQ}_m$.

> **Interpretation.** Equality is not a gap example. Although the affine-free sparsity route only gives $H^{\ast}(\mathrm{EQ}_m)\leq m+1$, a two-head rational score compares the binary encodings of the two strings directly.

## Proof

### Lemma 1. A two-atom score for equality

Encode the two strings by

$$ X:=\sum_{i=1}^{m}2^{i-1}x_i, \qquad Y:=\sum_{i=1}^{m}2^{i-1}y_i. $$

Define positive affine denominators

$$ B_1:=1+X+Y, \qquad B_2:=1+X+2Y. $$

Define affine numerators

$$ A_1:=4X, \qquad A_2:=1-5X-Y. $$

Consider

$$ S(x,y):=\frac{A_1}{B_1}+\frac{A_2}{B_2}. $$

Since $B_1,B_2\gt0$, the sign and ordering of $S$ are controlled by the cleared numerator

$$ P:=A_1B_2+A_2B_1. $$

Expanding gives

$$ \begin{aligned} P &= 4X(1+X+2Y)+(1-5X-Y)(1+X+Y) \cr &= 1-(X-Y)^2. \end{aligned} $$

Let

$$ N:=2^m-1. $$

If $x=y$, then $X=Y$, so $P=1$ and

$$ S(x,y) = \frac{1}{(1+2X)(1+3X)} \geq \frac{1}{(1+2N)(1+3N)}. $$

If $x\neq y$, then $X\neq Y$, so $(X-Y)^2\geq1$ and hence

$$ P\leq0, \qquad S(x,y)\leq0. $$

Therefore thresholding $S$ at

$$ \theta:=\frac{1}{2(1+2N)(1+3N)} $$

computes $\mathrm{EQ}_m$. Equivalently,

$$ S(x,y)-\theta\gt0 \qquad\Longleftrightarrow\qquad x=y. $$

Both $B_1$ and $B_2$ are positive affine functions with positive variable coefficients, so $A_1/B_1$ and $A_2/B_2$ are one-head atoms by the affine-over-positive-affine atom lemma [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md). Hence

$$ H^{\ast}(\mathrm{EQ}_m)\leq2. $$

### Lemma 2. One head is impossible

Restrict all pairs except the first to be equal to zero:

$$ x_i=y_i=0 \qquad \text{for }2\leq i\leq m. $$

The restricted function is

$$ \mathrm{EQ}_1(x_1,y_1)=\mathbf{1}[x_1=y_1]. $$

This two-bit function is not a linear threshold function, as shown in [055_equality_threshold_vote_size.md](055_equality_threshold_vote_size.md). Since one head computes exactly the nonconstant linear threshold functions by [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md), restriction monotonicity gives

$$ H^{\ast}(\mathrm{EQ}_m)\geq2. $$

Combining the two inequalities proves

$$ H^{\ast}(\mathrm{EQ}_m)=2. $$

Complement invariance from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) gives

$$ H^{\ast}(\mathrm{NEQ}_m)=2. $$

$\blacksquare$

## Consequence

The equality bracket from [049_equality_bounds.md](049_equality_bounds.md) collapses completely:

$$ \deg_{\pm}(\mathrm{EQ}_m)=2 \qquad \text{and} \qquad H^{\ast}(\mathrm{EQ}_m)=2 $$

for every $m\geq1$.
