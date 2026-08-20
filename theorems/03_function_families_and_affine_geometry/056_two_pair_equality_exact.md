# Two-Pair Equality Is Exact

## Statement

Let

$$ \mathrm{EQ}_2(x_1,x_2,y_1,y_2) := \mathbf{1}[(x_1,x_2)=(y_1,y_2)]. $$

Then

$$ H^{\ast}(\mathrm{EQ}_2)=2. $$

> **Interpretation.** This is the first nontrivial equality instance of the uniform exact equality theorem [060_equality_exact_two_heads.md](060_equality_exact_two_heads.md).

## Proof

### Lemma 1. A two-atom rational certificate

Define positive affine denominators

$$ B_1:=1+x_1+x_2+y_1+y_2, \qquad B_2:=1+x_1+x_2+2y_1+3y_2. $$

Define affine numerators

$$ A_1:=2+15x_1+32x_2, \qquad A_2:=-18x_1-42x_2-4y_1-14y_2. $$

Consider the rational score

$$ S:=\frac{A_1}{B_1}+\frac{A_2}{B_2}. $$

Since $B_1,B_2\gt0$ on the Boolean cube, the sign of $S$ is the sign of

$$ P:=A_1B_2+A_2B_1. $$

On the four equality inputs,

$$ P(0,0,0,0)=P(0,1,0,1)=P(1,0,1,0)=P(1,1,1,1)=2. $$

On the twelve nonequality inputs, the values of $P$ are

$$ -20,\ -2,\ -42,\ -16,\ -2,\ -2,\ -2,\ -11,\ -25,\ -33,\ -2,\ -11. $$

Thus

$$ S\gt0 \qquad\Longleftrightarrow\qquad (x_1,x_2)=(y_1,y_2). $$

Both denominators have positive constant term and positive variable coefficients. Therefore each ratio $A_i/B_i$ is a single one-head atom by the affine-over-positive-affine atom lemma [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md). Hence

$$ H^{\ast}(\mathrm{EQ}_2)\leq2. $$

### Lemma 2. One head is impossible

Restricting $x_2=y_2=0$ gives the two-bit equality function

$$ \mathrm{EQ}_1(x_1,y_1)=\mathbf{1}[x_1=y_1]. $$

This is not a linear threshold function by the two-bit checkerboard obstruction, or equivalently by the one-pair equality argument in [055_equality_threshold_vote_size.md](055_equality_threshold_vote_size.md). Since one head computes exactly the nonconstant linear threshold functions by [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md), we have

$$ H^{\ast}(\mathrm{EQ}_2)\geq2. $$

Combining the lower and upper bounds gives

$$ H^{\ast}(\mathrm{EQ}_2)=2. $$

$\blacksquare$

## Consequence

This is subsumed by the uniform equality theorem [060_equality_exact_two_heads.md](060_equality_exact_two_heads.md):

$$ H^{\ast}(\mathrm{EQ}_m)=2 $$

for every $m\geq1$.
