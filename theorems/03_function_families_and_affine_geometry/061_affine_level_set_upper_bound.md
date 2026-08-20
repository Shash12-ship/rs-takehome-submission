# Affine Level Sets Use At Most Two Heads

## Statement

Let

$$ L(x)=c+\sum_{i=1}^{n}a_i x_i $$

be an affine function on $\lbrace0,1\rbrace^n$, and define the exact affine-level predicate

$$ E_L(x):=\mathbf{1}[L(x)=0]. $$

Then

$$ H^{\ast}(E_L)\leq2. $$

More precisely,

$$ H^{\ast}(E_L) = \begin{cases} 0 & \text{if } E_L \text{ is constant},\cr 1 & \text{if } E_L \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** Exact equality to any affine statistic is cheap. This subsumes internal exact-count predicates and equality of two binary-encoded strings.

## Proof

If $E_L$ is constant, there is nothing to prove. Assume $E_L$ is nonconstant. Since the Boolean cube is finite, define

$$ \delta := \min\lbrace|L(x)|:L(x)\neq0\rbrace. $$

Then $\delta\gt0$. Set

$$ M(x):=\frac{L(x)}{\delta} = c_0+\sum_{i=1}^{n}m_i x_i. $$

Choose positive numbers $q_0,q_1,\ldots,q_n$ so large that

$$ q_0+c_0\gt0, \qquad q_i+m_i\gt0 \quad \text{for every }i. $$

Define two affine functions

$$ Q(x):=q_0+\sum_{i=1}^{n}q_i x_i, \qquad P(x):=Q(x)+M(x). $$

Then $P$ and $Q$ have positive constant terms and positive variable coefficients, and

$$ P(x)-Q(x)=M(x). $$

Now define

$$ B_1:=1+P+Q, \qquad B_2:=1+P+2Q, $$

and

$$ A_1:=4P, \qquad A_2:=1-5P-Q. $$

Both $B_1$ and $B_2$ have positive constant terms and positive variable coefficients. Consider

$$ S(x):=\frac{A_1(x)}{B_1(x)}+\frac{A_2(x)}{B_2(x)}. $$

After clearing denominators, the numerator is

$$ \begin{aligned} A_1B_2+A_2B_1 &= 4P(1+P+2Q)+(1-5P-Q)(1+P+Q) \cr &= 1-(P-Q)^2 \cr &= 1-M^2. \end{aligned} $$

If $L(x)=0$, then $M(x)=0$, so the cleared numerator is $1$. If $L(x)\neq0$, then by the definition of $\delta$,

$$ |M(x)|\geq1, $$

so

$$ 1-M(x)^2\leq0. $$

Since $E_L$ is nonconstant, there is at least one input with $L(x)=0$. The positive values of $S$ on the zero set of $L$ have a positive minimum, because the cube is finite. Choose a threshold $\theta\gt0$ below that minimum. Then

$$ S(x)-\theta\gt0 \qquad\Longleftrightarrow\qquad L(x)=0. $$

By the affine-over-positive-affine atom lemma [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md), each ratio $A_j/B_j$ is a one-head atom. Therefore

$$ H^{\ast}(E_L)\leq2. $$

If $E_L$ is a nonconstant LTF, the one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) gives

$$ H^{\ast}(E_L)=1. $$

If $E_L$ is nonconstant and not an LTF, the same characterization gives

$$ H^{\ast}(E_L)\geq2. $$

Together with the two-head upper bound, this proves the exact case split. $\blacksquare$

## Consequence

Internal exact-count predicates satisfy

$$ H^{\ast}(\mathrm{EXACT}_{n,k})=2 \qquad \text{for }1\leq k\leq n-1, $$

recovering the symmetric sign-change theorem in that special case.

Equality on two $m$-bit strings is also an affine level set after binary encoding:

$$ \mathrm{EQ}_m(x,y)=\mathbf{1} \left[\sum_{i=1}^{m}2^{i-1}x_i-\sum_{i=1}^{m}2^{i-1}y_i=0\right]. $$

Thus this theorem gives another route to

$$ H^{\ast}(\mathrm{EQ}_m)=2. $$
