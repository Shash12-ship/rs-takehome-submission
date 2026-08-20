# LTF One-Bit Gate Classification

## Statement

Let

$$ T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace $$

be a nonconstant LTF, and let $G:\lbrace0,1\rbrace^{2}\to\lbrace0,1\rbrace$ be any Boolean gate. Define

$$ F(z,y):=G(z,T(y)). $$

Then

$$ H^{\ast}(F)= \begin{cases} 0 & \text{if } G \text{ is constant},\cr 2 & \text{if } G \text{ is XOR or XNOR},\cr 1 & \text{otherwise}. \end{cases} $$

> **Interpretation.** A raw bit and one arbitrary LTF feature generate no hidden head complexity. XOR and XNOR are exactly the two-head cases; every other nonconstant gate is itself an LTF.

## Proof

Choose a strict affine separator

$$ A(y)=a+\sum_{i=1}^{m}\alpha_i y_i $$

such that

$$ T(y)=1 \qquad\Longleftrightarrow\qquad A(y)\gt0. $$

Since $T$ is nonconstant, both label classes are nonempty. Set

$$ a_-:=\max\lbrace A(y):T(y)=0\rbrace\lt0, \qquad a_+:=\min\lbrace A(y):T(y)=1\rbrace\gt0, $$

and also

$$ A_{\min}:=\min_y A(y), \qquad A_{\max}:=\max_y A(y). $$

### Lemma 1. Fresh XOR is an affine slab

Choose $B\gt0$ so large that

$$ B\gt a_+-a_-, \qquad B\gt A_{\max}-A_{\min}. $$

Define

$$ M(z,y):=A(y)+Bz. $$

Then

$$ z\oplus T(y)=1 \qquad\Longleftrightarrow\qquad a_+\leq M(z,y)\leq B+a_-. $$

Indeed, if $z=0$, then the displayed slab condition becomes

$$ a_+\leq A(y)\leq B+a_-. $$

The lower inequality is exactly $T(y)=1$, and the upper inequality is automatic on $z=0$ true inputs because

$$ A(y)\leq A_{\max}\lt B+A_{\min}\leq B+a_-. $$

If $z=0$ and $T(y)=0$, then $A(y)\leq a_-\lt a_+$, so the slab condition fails below.

If $z=1$, then the slab condition becomes

$$ a_+\leq A(y)+B\leq B+a_-, $$

or equivalently

$$ a_+-B\leq A(y)\leq a_-. $$

The upper inequality is exactly $T(y)=0$, and the lower inequality is automatic on $z=1$ true inputs because

$$ a_+-B\lt A_{\min}\leq A(y). $$

If $z=1$ and $T(y)=1$, then $A(y)\geq a_+$, so $M(z,y)\geq B+a_+\gt B+a_-$, and the slab condition fails above.

Thus $z\oplus T$ is an affine slab in the variables $(z,y)$. By the affine-slab theorem [062_affine_slab_upper_bound.md](../03_function_families_and_affine_geometry/062_affine_slab_upper_bound.md),

$$ H^{\ast}(z\oplus T)\leq2. $$

The fresh-bit XOR threshold-degree theorem [081_fresh_bit_xor_threshold_degree.md](../04_recursions_and_cost_invariants/081_fresh_bit_xor_threshold_degree.md) gives

$$ \deg_{\pm}(z\oplus T)=\deg_{\pm}(T)+1=2, $$

and threshold degree lower-bounds $H^{\ast}$. Hence

$$ H^{\ast}(z\oplus T)=2. $$

Output complement preserves head complexity by [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), so XNOR has the same value.

### Lemma 2. Literal gating is an LTF

Let $U$ be either $T$ or $1-T$. Then there is an affine separator $W(y)$ such that

$$ U(y)=1 \qquad\Longleftrightarrow\qquad W(y)\gt0, $$

with both signs attained. Let

$$ w_-:=\max\lbrace W(y):U(y)=0\rbrace\lt0, \qquad w_+:=\min\lbrace W(y):U(y)=1\rbrace\gt0, $$

and set

$$ W_{\max}:=\max_y W(y), \qquad \theta:=\frac{w_-+w_+}{2}. $$

Let $r(z)$ be either $z$ or $1-z$. Choose

$$ C\gt W_{\max}-\theta. $$

Then

$$ r(z)\wedge U(y)=1 \qquad\Longleftrightarrow\qquad W(y)+C  r(z)\gt C+\theta. $$

If $r(z)=1$ and $U(y)=1$, then $W(y)\geq w_+\gt\theta$, so the displayed inequality holds. If $r(z)=1$ and $U(y)=0$, then $W(y)\leq w_-\lt\theta$, so the displayed inequality fails. If $r(z)=0$, then

$$ W(y)+C  r(z)\leq W_{\max}\lt C+\theta, $$

so the displayed inequality also fails. Hence every literal conjunction $r\wedge U$ is an LTF. Its complement is also an LTF.

### Conclusion

If $G$ is constant, then $F$ is constant and $H^{\ast}(F)=0$.

If $G$ is XOR or XNOR, Lemma 1 gives $H^{\ast}(F)=2$.

Assume now that $G$ is nonconstant and neither XOR nor XNOR. If $G$ has two true inputs, then its two true inputs are adjacent in the two-bit square. Thus $G$ depends on only one input, so $F$ is one of $z$, $1-z$, $T$, or $1-T$, all nonconstant LTFs.

If $G$ has one true input, then $F$ is one of

$$ r(z)\wedge T(y), \qquad r(z)\wedge(1-T(y)), $$

for a raw literal $r$. Lemma 2 shows that $F$ is a nonconstant LTF.

If $G$ has three true inputs, then $1-G$ has one true input. Hence $1-F$ is a nonconstant LTF by the previous case, so $F$ is also a nonconstant LTF.

Thus every remaining nonconstant gate gives a nonconstant LTF. By the one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md),

$$ H^{\ast}(F)=1. $$

This proves the classification. $\blacksquare$

## Consequences

For every nonconstant LTF $T$,

$$ H^{\ast}(z\oplus T)=H^{\ast}(1-(z\oplus T))=2. $$

Thus the generic one-bit LTF branching bound

$$ H^{\ast}(G(z,T))\leq1+\lvert\mathrm{supp}(T)\rvert $$

is sharp only in the one-bit feature case. For arbitrary-support LTF features, the exact gate cost is at most two and is one except for XOR and XNOR.
