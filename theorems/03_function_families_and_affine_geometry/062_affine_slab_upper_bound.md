# Affine Slabs Use At Most Two Heads

## Statement

Let

$$ L(x)=c+\sum_{i=1}^{n}a_i x_i $$

be an affine function on $\lbrace0,1\rbrace^n$, and let $\alpha\leq\beta$. Define the affine-slab predicate

$$ S_{L,\alpha,\beta}(x) := \mathbf{1}[\alpha\leq L(x)\leq\beta]. $$

Then

$$ H^{\ast}(S_{L,\alpha,\beta})\leq2. $$

More precisely,

$$ H^{\ast}(S_{L,\alpha,\beta}) = \begin{cases} 0 & \text{if } S_{L,\alpha,\beta} \text{ is constant},\cr 1 & \text{if } S_{L,\alpha,\beta} \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** A two-head score can carve out any finite Boolean-cube slice between two parallel affine hyperplanes. Exact affine level sets are the zero-width special case.

## Proof

If $S_{L,\alpha,\beta}$ is constant, there is nothing to prove. Assume from now on that it is nonconstant, so both its true and false sets are nonempty.

Set

$$ c_\ast:=\frac{\alpha+\beta}{2}, \qquad R_\ast:=\frac{\beta-\alpha}{2}. $$

Then

$$ \alpha\leq L(x)\leq\beta \qquad\Longleftrightarrow\qquad \lvert L(x)-c_\ast\rvert\leq R_\ast. $$

Because the Boolean cube is finite, define

$$ r_{\mathrm{in}} := \max\lbrace\lvert L(x)-c_\ast\rvert:S_{L,\alpha,\beta}(x)=1\rbrace $$

and

$$ r_{\mathrm{out}} := \min\lbrace\lvert L(x)-c_\ast\rvert:S_{L,\alpha,\beta}(x)=0\rbrace. $$

Every true input has distance at most $R_\ast$ from $c_\ast$, and every false input has distance strictly larger than $R_\ast$. Therefore

$$ r_{\mathrm{in}}\leq R_\ast\lt r_{\mathrm{out}}. $$

Choose $r$ with

$$ r_{\mathrm{in}}\lt r\lt r_{\mathrm{out}}, $$

and define

$$ M(x):=\frac{L(x)-c_\ast}{r} = c_0+\sum_{i=1}^{n}m_i x_i. $$

Then

$$ S_{L,\alpha,\beta}(x)=1 \qquad\Longleftrightarrow\qquad 1-M(x)^2\gt0. $$

Choose positive numbers $q_0,q_1,\ldots,q_n$ so large that

$$ q_0+c_0\gt0, \qquad q_i+m_i\gt0 \quad \text{for every }i. $$

Define

$$ Q(x):=q_0+\sum_{i=1}^{n}q_i x_i, \qquad P(x):=Q(x)+M(x). $$

Then $P$ and $Q$ have positive constant terms and positive variable coefficients, and

$$ P(x)-Q(x)=M(x). $$

Now define

$$ B_1:=1+P+Q, \qquad B_2:=1+P+2Q, $$

and

$$ A_1:=4P, \qquad A_2:=1-5P-Q. $$

The denominators $B_1$ and $B_2$ have positive constant terms and positive variable coefficients. Consider the two-atom score

$$ T(x):=\frac{A_1(x)}{B_1(x)}+\frac{A_2(x)}{B_2(x)}. $$

After clearing denominators, the numerator is

$$ \begin{aligned} A_1B_2+A_2B_1 &= 4P(1+P+2Q)+(1-5P-Q)(1+P+Q) \cr &= 1-(P-Q)^2 \cr &= 1-M^2. \end{aligned} $$

Since $B_1$ and $B_2$ are positive on the cube,

$$ T(x)\gt0 \qquad\Longleftrightarrow\qquad 1-M(x)^2\gt0 \qquad\Longleftrightarrow\qquad S_{L,\alpha,\beta}(x)=1. $$

By the affine-over-positive-affine atom lemma [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md), each ratio $A_j/B_j$ is a one-head atom. Therefore

$$ H^{\ast}(S_{L,\alpha,\beta})\leq2. $$

If $S_{L,\alpha,\beta}$ is a nonconstant LTF, the one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) gives

$$ H^{\ast}(S_{L,\alpha,\beta})=1. $$

If $S_{L,\alpha,\beta}$ is nonconstant and not an LTF, the same characterization gives

$$ H^{\ast}(S_{L,\alpha,\beta})\geq2. $$

Together with the two-head upper bound, this proves the exact case split. $\blacksquare$

## Consequence

The affine level-set theorem [061_affine_level_set_upper_bound.md](061_affine_level_set_upper_bound.md) is the special case $\alpha=\beta$.

Hamming-weight intervals satisfy

$$ H^{\ast} \left(\mathbf{1}[a\leq \lvert x\rvert\leq b]\right)\leq2. $$

This agrees with the exact symmetric sign-change theorem, since a single interval has at most two boundary crossings in the Hamming-weight sequence.

For binary encodings

$$ X=\sum_{i=1}^{m}2^{i-1}x_i, \qquad Y=\sum_{i=1}^{m}2^{i-1}y_i, $$

every signed-tolerance predicate

$$ \mathbf{1}[-t\leq X-Y\leq t] $$

uses at most two heads. Thus equality is the radius-zero endpoint of a larger two-head family.
