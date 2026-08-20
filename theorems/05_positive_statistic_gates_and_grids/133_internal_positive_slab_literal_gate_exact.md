# Internal Positive Slab Literal-Gate Exactness

## Statement

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let

$$ S(y):=\mathbf{1}[\alpha\leq t(y)\leq\beta]. $$

Assume $S$ is an internal non-LTF slab along the ordered image of $t$: both $S^{-1}(1)$ and $S^{-1}(0)$ are nonempty, and the label sequence of $S$ along $\mathrm{Im}(t)$ has the form

$$ 0,\ldots,0,1,\ldots,1,0,\ldots,0 $$

with all three displayed blocks nonempty.

Let $r(z)$ be either raw literal $z$ or $1-z$. Then

$$ H^{\ast}(r(z)\wedge S(y)) = H^{\ast}(1-(r(z)\wedge S(y))) = 2. $$

> **Interpretation.** Gating an internal positive slab by a raw literal keeps the function exactly two-head. The raw bit does not add a third head for this non-XOR gate.

## Proof

Because $S$ is a non-LTF affine slab, the affine-slab theorem [062_affine_slab_upper_bound.md](../03_function_families_and_affine_geometry/062_affine_slab_upper_bound.md) and the one-head characterization give

$$ H^{\ast}(S)=2. $$

In particular,

$$ \deg_{\pm}(S)=2, $$

since the threshold-degree lower bound gives $\deg_{\pm}(S)\leq2$, while $S$ is not an LTF.

First take $r(z)=z$. In the notation of the positive-projection one-bit gate bound [132_positive_projection_one_bit_gate_bound.md](132_positive_projection_one_bit_gate_bound.md), the concatenated sequence for $z\wedge S$ is

$$ 0,\ldots,0, 0,\ldots,0,1,\ldots,1,0,\ldots,0. $$

The first block is the $z=0$ slice, and the second block is the $z=1$ slice. Since the slab sequence starts and ends with $0$ and has exactly two sign changes, the concatenated sequence also has exactly two sign changes. Lemma 132 gives

$$ H^{\ast}(z\wedge S)\leq2. $$

The one-bit gate threshold-degree trichotomy [082_one_bit_gate_threshold_degree_trichotomy.md](../04_recursions_and_cost_invariants/082_one_bit_gate_threshold_degree_trichotomy.md) says that the non-XOR gate $z\wedge S$ preserves threshold degree:

$$ \deg_{\pm}(z\wedge S)=\deg_{\pm}(S)=2. $$

Therefore

$$ H^{\ast}(z\wedge S)\geq2, $$

and hence

$$ H^{\ast}(z\wedge S)=2. $$

For $r(z)=1-z$, the concatenated sequence is

$$ 0,\ldots,0,1,\ldots,1,0,\ldots,0, 0,\ldots,0, $$

and again has exactly two sign changes. The same upper-bound and threshold-degree lower-bound argument gives

$$ H^{\ast}((1-z)\wedge S)=2. $$

Finally, output complement preserves head complexity by [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), so the complements also have exact value $2$. $\blacksquare$

## Consequence

For internal positive slabs, the literal-gated non-XOR branch is already exact:

$$ H^{\ast}(z\wedge S)=H^{\ast}((1-z)\wedge S)=2. $$

The harder literal gates are those through the complement slab, such as $z\wedge(1-S)$, where the same positive-projection route gives a three-head upper bound but threshold degree gives only a two-head lower bound.
