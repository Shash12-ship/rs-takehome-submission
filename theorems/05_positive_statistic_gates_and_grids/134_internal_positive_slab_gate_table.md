# Internal Positive Slab One-Bit Gate Table

## Statement

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let

$$ S(y):=\mathbf{1}[\alpha\leq t(y)\leq\beta]. $$

Assume $S$ is an internal non-LTF slab along the ordered image of $t$, so its label sequence has the form

$$ 0,\ldots,0,1,\ldots,1,0,\ldots,0 $$

with all three displayed blocks nonempty. For a two-input Boolean gate $G$, define

$$ F_G(z,y):=G(z,S(y)). $$

Then the following table holds.

1. If $G$ is constant, then

$$ H^{\ast}(F_G)=0. $$

2. If $G$ is a raw-bit literal $z$ or $1-z$, then

$$ H^{\ast}(F_G)=1. $$

3. If $G$ is the feature literal $u$ or $1-u$, then

$$ H^{\ast}(F_G)=2. $$

4. If $G$ or $1-G$ is $r\wedge u$ for a raw literal $r\in\lbrace z,1-z\rbrace$, then

$$ H^{\ast}(F_G)=2. $$

5. If $G$ or $1-G$ is $r\wedge(1-u)$ for a raw literal $r\in\lbrace z,1-z\rbrace$, then

$$ 2\leq H^{\ast}(F_G)\leq3. $$

6. If $G$ is XOR or XNOR, then

$$ 3\leq H^{\ast}(F_G)\leq5. $$

These cases exhaust all two-input gates.

> **Interpretation.** For an internal positive slab feature, every one-bit gate is classified except two narrow families: XOR/XNOR, and literal gates through the complement of the slab.

## Proof

First note that

$$ H^{\ast}(S)=H^{\ast}(1-S)=2. $$

Indeed, $S$ is a non-LTF affine slab, so this follows from the affine-slab theorem [062_affine_slab_upper_bound.md](../03_function_families_and_affine_geometry/062_affine_slab_upper_bound.md), complement invariance, and the one-head characterization. Consequently,

$$ \deg_{\pm}(S)=\deg_{\pm}(1-S)=2. $$

Cases 1 and 2 are immediate from constants and one raw-bit LTFs.

Case 3 follows from the displayed exact value for $S$ and complement invariance.

Case 4 is exactly [133_internal_positive_slab_literal_gate_exact.md](133_internal_positive_slab_literal_gate_exact.md), again using complement invariance when $1-G$ is the literal-gated slab.

For Case 5, consider $r\wedge(1-S)$. The feature $1-S$ has sign-change sequence

$$ 1,\ldots,1,0,\ldots,0,1,\ldots,1. $$

For $r=z$, the concatenated sequence in the positive-projection one-bit gate bound is a block of zeros followed by this sequence, so it has three sign changes. For $r=1-z$, the same sequence is followed by a block of zeros, and again there are three sign changes. Lemma 132 gives

$$ H^{\ast}(r\wedge(1-S))\leq3. $$

The one-bit gate threshold-degree trichotomy [082_one_bit_gate_threshold_degree_trichotomy.md](../04_recursions_and_cost_invariants/082_one_bit_gate_threshold_degree_trichotomy.md) gives

$$ \deg_{\pm}(r\wedge(1-S))=\deg_{\pm}(1-S)=2. $$

Thus

$$ H^{\ast}(r\wedge(1-S))\geq2. $$

Complement invariance gives the same bracket when $1-G$ has this form.

For Case 6, the fresh-bit XOR threshold-degree theorem gives

$$ H^{\ast}(z\oplus S)\geq\deg_{\pm}(S)+1=3. $$

The positive-projection fresh-XOR sign-change bound [131_positive_projection_fresh_xor_sign_change_bound.md](131_positive_projection_fresh_xor_sign_change_bound.md) applies with $C=2$, hence

$$ H^{\ast}(z\oplus S)\leq5. $$

Complement invariance gives the same bracket for XNOR.

It remains only to note that the sixteen two-input gates are exhausted by constants, raw-bit literals, feature literals, one-cell indicators and their complements, and XOR/XNOR. The one-cell indicators are exactly the gates $r\wedge u$ and $r\wedge(1-u)$. This proves the table. $\blacksquare$

## Consequence

The remaining positive-slab exactness targets are now explicit:

$$ r\wedge(1-S) \qquad \text{and} \qquad z\oplus S $$

up to output complement and raw-bit flip. The current brackets are $2$ to $3$ for the first family and $3$ to $5$ for the XOR family.
