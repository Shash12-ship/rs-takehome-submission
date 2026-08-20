# Fresh-Bit XOR Affine-Cylinder Bound

## Statement

Let

$$ T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace $$

have a strict affine-cylinder score

$$ S(y)=A(y)+\sum_{\gamma\in\Gamma}c_{\gamma}C_{\gamma}(y), \qquad A(y)=a+\sum_{i=1}^{m}\alpha_i y_i, $$

with distinct nonvacuous cylinder supports. Let

$$ F(z,y):=z\oplus T(y). $$

Define

$$ L(A):=\lbrace i:\alpha_i\neq0\rbrace, $$

and

$$ K(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N), \qquad K_z(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P\cup\lbrace z\rbrace,N), $$

and

$$ \eta_{\oplus}(A) := \mathbf{1} \left[ a\neq0 \text{ or } \exists i,\ \alpha_i\neq0 \right]. $$

Then

$$ \deg_{\pm}(T)+1 \leq H^{\ast}(F) \leq \mathrm{actc}(F) \leq \mathrm{sactc}(F) \leq \eta_{\oplus}(A) + \lvert L(A)\rvert + K(\Gamma) + K_z(\Gamma). $$

The same upper and lower bounds hold for the XNOR function $1-F$.

Consequently, if

$$ \eta_{\oplus}(A) + \lvert L(A)\rvert + K(\Gamma) + K_z(\Gamma) = \deg_{\pm}(T)+1, $$

then

$$ H^{\ast}(z\oplus T)=H^{\ast}(1-(z\oplus T))=\deg_{\pm}(T)+1. $$

> **Interpretation.** Fresh-bit XOR is the branch where threshold degree provably rises. This lemma gives the matching affine-cylinder upper-bound target that would make the recursion exact.

## Proof

For $F(z,y)=z\oplus T(y)$, the two $z$-slices as functions of $u=T(y)$ are

$$ G(0,u)=u, \qquad G(1,u)=1-u. $$

Thus, in the notation of [118_one_bit_affine_cylinder_branching.md](118_one_bit_affine_cylinder_branching.md),

$$ \mu_0=1, \qquad \mu_1=-1, \qquad \delta_0=\delta_1=0. $$

The affine indicator in Lemma 118 becomes

$$ \mathbf{1} \left[ -a\neq a \text{ or } \exists i,\ \alpha_i\neq0 \right], $$

which is exactly $\eta_{\oplus}(A)$. Since $\mu_0\neq0$ and $\mu_1\neq\mu_0$, Lemma 118 gives

$$ H^{\ast}(F) \leq \mathrm{actc}(F) \leq \mathrm{sactc}(F) \leq \eta_{\oplus}(A) + \lvert L(A)\rvert + K(\Gamma) + K_z(\Gamma). $$

The threshold-degree lower bound follows from the fresh-bit XOR threshold-degree theorem [081_fresh_bit_xor_threshold_degree.md](081_fresh_bit_xor_threshold_degree.md) and the general lower bound [006_threshold_degree_head_complexity_bound.md](../01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md):

$$ H^{\ast}(F) \geq \deg_{\pm}(F) = \deg_{\pm}(T)+1. $$

For XNOR, note that $1-F$ is the output complement of $F$. Complementing preserves threshold degree and head complexity by [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), and it preserves the same affine-cylinder upper-bound certificate by negating the strict score. Hence the same bounds hold for $1-F$.

If the affine-cylinder upper bound equals $\deg_{\pm}(T)+1$, then the displayed lower and upper bounds meet. This proves the exact value for both XOR and XNOR. $\blacksquare$

## Consequences

For a sparse PTF score whose nonlinear terms are positive monomials, this gives the earlier bound

$$ H^{\ast}(z\oplus T) \leq 1+\lvert L(A)\rvert+2\lvert\Gamma\rvert $$

whenever $A$ is not the zero affine form. If $A=0$, the leading $1$ drops out.

For mixed-literal affine-cylinder scores, the exactness target is sharper:

$$ \eta_{\oplus}(A) + \lvert L(A)\rvert + K(\Gamma) + K_z(\Gamma). $$

If this equals the forced lower bound $\deg_{\pm}(T)+1$, then the fresh-bit XOR recursion is solved exactly for that feature.
