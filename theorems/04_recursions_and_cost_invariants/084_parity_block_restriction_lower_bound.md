# Parity-Block Restriction Lower Bound

## Statement

Let

$$ f:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace. $$

Suppose a restriction of $f$ leaves two disjoint sets of free variables $Z$ and $Y$, with

$$ \lvert Z\rvert=k, $$

and on that restricted subcube has the form

$$ f_{\rho}(z,y) = \left(\bigoplus_{j=1}^{k}z_j\right)\oplus T(y) $$

for some Boolean function $T$ on the $Y$ variables. Then

$$ \deg_{\pm}(f)\geq k+\deg_{\pm}(T), $$

and hence

$$ H^{\ast}(f)\geq k+\deg_{\pm}(T). $$

The same conclusion holds if the restricted function is the complement of the displayed parity-block form.

> **Interpretation.** A lower bound does not require finding a pure parity restriction. It is enough to find a parity block that modulates any residual hard subfunction on the remaining free variables.

## Proof

Restricting variables cannot increase threshold degree: any strict sign polynomial for $f$ restricts to a strict sign polynomial for $f_{\rho}$ of no larger degree. Therefore

$$ \deg_{\pm}(f)\geq\deg_{\pm}(f_{\rho}). $$

By the parity-block threshold-degree amplifier [083_parity_block_threshold_degree_amplifier.md](083_parity_block_threshold_degree_amplifier.md),

$$ \deg_{\pm}(f_{\rho})=k+\deg_{\pm}(T). $$

Thus

$$ \deg_{\pm}(f)\geq k+\deg_{\pm}(T). $$

The head lower bound follows from the general threshold-degree lower bound [006_threshold_degree_head_complexity_bound.md](../01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md):

$$ H^{\ast}(f)\geq\deg_{\pm}(f)\geq k+\deg_{\pm}(T). $$

If the restriction is the complement of the displayed parity-block form, the same proof applies because complementing a Boolean function preserves threshold degree. $\blacksquare$

## Consequences

The usual affine-parity restriction lower bound is the special case where $T$ is constant.

The new certificate can be stronger when the residual $T$ already has nontrivial threshold degree. For example, a restriction of the form

$$ \left(\bigoplus_{j=1}^{k}z_j\right) \oplus \mathrm{XOR}_{r}(y) $$

certifies

$$ H^{\ast}(f)\geq k+r. $$
