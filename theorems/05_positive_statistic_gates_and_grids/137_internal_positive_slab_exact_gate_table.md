# Internal Positive Slab Exact Gate Table

## Statement

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let

$$ S(y):=\mathbf{1}[\alpha\leq t(y)\leq\beta]. $$

Assume $S$ is an internal non-LTF slab along the ordered image of $t$, so its label sequence has the form

$$ 0,\ldots,0,1,\ldots,1,0,\ldots,0 $$

with all three displayed blocks nonempty. For a two-input Boolean gate $G$, define

$$ F_G(z,y):=G(z,S(y)). $$

Then

$$ H^{\ast}(F_G)= \begin{cases} 0 & \text{if }G\text{ is constant},\cr 1 & \text{if }G\text{ is a raw-bit literal},\cr 3 & \text{if }G\text{ is XOR or XNOR},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** Internal positive slabs now have a complete exact one-bit gate table.

## Proof

By the affine-slab theorem [062_affine_slab_upper_bound.md](../03_function_families_and_affine_geometry/062_affine_slab_upper_bound.md), complement invariance, and the one-head characterization,

$$ H^{\ast}(S)=H^{\ast}(1-S)=2. $$

Consequently,

$$ \deg_{\pm}(S)=\deg_{\pm}(1-S)=2. $$

Constants and raw-bit literals give the first two cases. The feature literals $S$ and $1-S$ give exact value $2$ by the displayed equation.

The gates $r\wedge S$ and their complements have exact value $2$ by [133_internal_positive_slab_literal_gate_exact.md](133_internal_positive_slab_literal_gate_exact.md).

It remains to handle $r\wedge(1-S)$ and XOR/XNOR.

### Lemma 1. Complement-slab literal gates

Let $r(z)$ be either $z$ or $1-z$. We claim

$$ H^{\ast}(r(z)\wedge(1-S(y)))=2. $$

Choose a strict quadratic sign polynomial $Q(t)$ for $1-S$:

$$ 1-S(y)=1 \qquad\Longleftrightarrow\qquad Q(t(y))\gt0. $$

Since the cube is finite, choose

$$ M\gt\max_y \lvert Q(t(y))\rvert. $$

If $r(z)=z$, define

$$ P(z,y):=Q(t(y))-M(1-z). $$

If $r(z)=1-z$, define

$$ P(z,y):=Q(t(y))-Mz. $$

In either case, $P$ is a strict quadratic polynomial in $t(y)$ and $z$. On the slice where $r(z)=1$, its sign is the sign of $Q(t(y))$; on the slice where $r(z)=0$, it is strictly negative. Hence $P$ sign-represents $r\wedge(1-S)$.

The positive-statistic raw-bit quadratic span [135_positive_statistic_raw_bit_quadratic_span.md](135_positive_statistic_raw_bit_quadratic_span.md) gives

$$ H^{\ast}(r\wedge(1-S))\leq2. $$

The one-bit gate threshold-degree trichotomy [082_one_bit_gate_threshold_degree_trichotomy.md](../04_recursions_and_cost_invariants/082_one_bit_gate_threshold_degree_trichotomy.md) gives

$$ \deg_{\pm}(r\wedge(1-S))=\deg_{\pm}(1-S)=2. $$

Thus $H^{\ast}(r\wedge(1-S))=2$. Complement invariance gives exact value $2$ for the complements of these gates.

### Lemma 2. XOR and XNOR

Choose a strict quadratic sign polynomial $R(t)$ for $S$:

$$ S(y)=1 \qquad\Longleftrightarrow\qquad R(t(y))\gt0. $$

Then

$$ (1-2z)R(t(y)) $$

is a strict cubic polynomial in $t(y)$ and $z$ that sign-represents $z\oplus S(y)$. The positive-statistic raw-bit cubic span [136_positive_statistic_raw_bit_cubic_span.md](136_positive_statistic_raw_bit_cubic_span.md) gives

$$ H^{\ast}(z\oplus S)\leq3. $$

The fresh-bit XOR threshold-degree theorem [081_fresh_bit_xor_threshold_degree.md](../04_recursions_and_cost_invariants/081_fresh_bit_xor_threshold_degree.md) gives

$$ H^{\ast}(z\oplus S)\geq\deg_{\pm}(S)+1=3. $$

Hence

$$ H^{\ast}(z\oplus S)=3. $$

XNOR is the output complement of XOR, so complement invariance gives exact value $3$ for XNOR as well.

The sixteen two-input gates are exhausted by constants, raw-bit literals, feature literals, one-cell indicators and their complements, and XOR/XNOR. The one-cell indicators are exactly $r\wedge S$ and $r\wedge(1-S)$ for raw literals $r$. Combining the cases proves the table. $\blacksquare$

## Consequence

The previous positive-slab brackets collapse to exact values:

$$ H^{\ast}(r\wedge(1-S))=2, \qquad H^{\ast}(z\oplus S)=3. $$

Thus internal positive slabs behave like a clean three-level object under one raw-bit gates: raw-only gates cost $1$, non-XOR feature-dependent gates cost $2$, and XOR/XNOR cost $3$.
