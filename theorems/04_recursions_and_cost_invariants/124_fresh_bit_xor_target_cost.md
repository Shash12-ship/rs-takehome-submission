# Fresh-Bit XOR Target Cost

## Statement

For a strict affine-cylinder score

$$ S(y)=A(y)+\sum_{\gamma\in\Gamma}c_{\gamma}C_{\gamma}(y), \qquad A(y)=a+\sum_{i=1}^{m}\alpha_i y_i, $$

define

$$ L(A):=\lbrace i:\alpha_i\neq0\rbrace, $$

$$ K_{0}(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N), \qquad K_{+}(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P\cup\lbrace z\rbrace,N), \qquad K_{-}(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N\cup\lbrace z\rbrace), $$

and

$$ \eta_{\oplus}(A) := \mathbf{1} \left[ a\neq0 \text{ or } \exists i,\ \alpha_i\neq0 \right]. $$

Define

$$ \mathrm{xactc}(T) := \min_S \left( \eta_{\oplus}(A) + \lvert L(A)\rvert + K_{0}(\Gamma) + \min\lbrace K_{+}(\Gamma),K_{-}(\Gamma)\rbrace \right), $$

where the minimum ranges over all strict affine-cylinder scores $S$ for $T$.

Then

$$ \deg_{\pm}(T)+1 \leq H^{\ast}(z\oplus T(y)) \leq \mathrm{xactc}(T), $$

and the same bounds hold for $1-(z\oplus T(y))$.

Consequently, if

$$ \mathrm{xactc}(T)=\deg_{\pm}(T)+1, $$

then fresh-bit XOR and XNOR over $T$ have exact head complexity $\deg_{\pm}(T)+1$.

Moreover,

$$ \mathrm{xactc}(T) \leq 1+m+3\mathrm{actc}(T). $$

> **Interpretation.** The XOR target cost is the optimized affine-cylinder quantity that must match threshold degree to solve the fresh-bit XOR recursion exactly for a feature.

## Proof

Fix a strict affine-cylinder score $S$ for $T$. The fresh-bit XOR affine-cylinder bound [119_fresh_bit_xor_affine_cylinder_bound.md](119_fresh_bit_xor_affine_cylinder_bound.md) gives

$$ \deg_{\pm}(T)+1 \leq H^{\ast}(z\oplus T) \leq \eta_{\oplus}(A) + \lvert L(A)\rvert + K_{0}(\Gamma) + K_{+}(\Gamma). $$

Applying the same bound after flipping the fresh coordinate $z$ gives the same upper bound with $K_{-}(\Gamma)$ in place of $K_{+}(\Gamma)$, because $zC_{P,N}$ is replaced by $(1-z)C_{P,N}=C_{P,N\cup\lbrace z\rbrace}$. Fresh-coordinate bit-flip turns XOR into XNOR, and output complement preserves head complexity, so both orientations are valid for the XOR and XNOR pair.

Hence

$$ \deg_{\pm}(T)+1 \leq H^{\ast}(z\oplus T) \leq \eta_{\oplus}(A) + \lvert L(A)\rvert + K_{0}(\Gamma) + \min\lbrace K_{+}(\Gamma),K_{-}(\Gamma)\rbrace. $$

Minimizing the upper bound over $S$ gives

$$ H^{\ast}(z\oplus T) \leq \mathrm{xactc}(T). $$

The XNOR case follows by the same output-complement argument.

If $\mathrm{xactc}(T)=\deg_{\pm}(T)+1$, the lower and upper bounds meet, proving exactness.

For the comparison with $\mathrm{actc}$, choose a strict affine-cylinder score $S$ for $T$ of optimal affine-cylinder cost and write

$$ K(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N). $$

Then $K_{0}(\Gamma)=K(\Gamma)\leq\mathrm{actc}(T)$, while

$$ \eta_{\oplus}(A)\leq1, \qquad \lvert L(A)\rvert\leq m, $$

and

$$ \min\lbrace K_{+}(\Gamma),K_{-}(\Gamma)\rbrace \leq 2K(\Gamma). $$

Therefore

$$ \mathrm{xactc}(T) \leq 1+m+3\mathrm{actc}(T). $$

$\blacksquare$

## Consequences

The two optimized one-bit costs now split the non-XOR and XOR cases:

$$ H^{\ast}(r\wedge T),\ H^{\ast}(r\vee T) \leq 1+\mathrm{lgactc}(T), $$

while

$$ \deg_{\pm}(T)+1 \leq H^{\ast}(z\oplus T) \leq \mathrm{xactc}(T). $$

Thus the exact fresh-bit XOR problem becomes the concrete equality problem

$$ \mathrm{xactc}(T)=\deg_{\pm}(T)+1. $$
