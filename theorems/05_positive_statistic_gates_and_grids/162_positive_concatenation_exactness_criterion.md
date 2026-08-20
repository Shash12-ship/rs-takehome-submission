# Positive Concatenation Exactness Criterion

## Statement

Let $f(z,y)$ have a shared positive-statistic certificate as in Theorem 158. Fix a positive raw order $\rho$, and let

$$ L_{\rho}(f) := \sum_a C_a+J_{\rho}(f) $$

be the sign-change count of the concatenated slice sequence in that raw order.

Then

$$ \deg_{\pm}(f) \leq H^{\ast}(f) \leq L_{\rho}(f). $$

Consequently, if

$$ \deg_{\pm}(f)=L_{\rho}(f) $$

for some shared positive-statistic certificate and some positive raw order $\rho$, then

$$ H^{\ast}(f)=\deg_{\pm}(f)=L_{\rho}(f). $$

Let

$$ \mathrm{eps}_{+}^{z\mid y}(f) := \min_t \left( \sum_a C_a+B_{+}(p,q) \right), $$

where the minimum ranges over all shared positive-statistic certificates $t$ for the raw slices, and $p,q$ are the endpoint raw functions attached to $t$. Then

$$ \deg_{\pm}(f) \leq H^{\ast}(f) \leq \mathrm{eps}_{+}^{z\mid y}(f). $$

In particular, if

$$ \deg_{\pm}(f)=\mathrm{eps}_{+}^{z\mid y}(f), $$

then

$$ H^{\ast}(f)=\deg_{\pm}(f)=\mathrm{eps}_{+}^{z\mid y}(f). $$

> **Interpretation.** Any positive concatenation upper bound becomes an exact theorem once threshold degree reaches the same value. The optimized endpoint-coupled cost gives a compact exactness target.

## Proof

The lower bound

$$ \deg_{\pm}(f)\leq H^{\ast}(f) $$

is the threshold-degree lower bound.

For a fixed raw order $\rho$, the ordered common positive-statistic slice bound [147_ordered_common_positive_statistic_slice_bound.md](147_ordered_common_positive_statistic_slice_bound.md) gives

$$ H^{\ast}(f)\leq L_{\rho}(f). $$

If $\deg_{\pm}(f)=L_{\rho}(f)$, the two inequalities match, proving exactness.

For the optimized endpoint-coupled cost, Theorem 158 gives for each shared positive-statistic certificate $t$:

$$ H^{\ast}(f) \leq \sum_a C_a+B_{+}(p,q). $$

Taking the minimum over $t$ gives

$$ H^{\ast}(f)\leq\mathrm{eps}_{+}^{z\mid y}(f). $$

Combining this with the threshold-degree lower bound gives the displayed sandwich, and equality follows when the two sides match. $\blacksquare$

## Consequence

This is the theorem-scale version of the recurring proof pattern: construct heads by positive concatenation, then prove exactness by threshold degree.
