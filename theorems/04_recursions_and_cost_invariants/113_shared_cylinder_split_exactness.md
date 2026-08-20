# Shared-Cylinder Split Exactness

## Statement

Let

$$ f:\lbrace0,1\rbrace\times\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace, $$

and write its two cofactors as

$$ f_b(y):=f(b,y) \qquad (b\in\lbrace0,1\rbrace). $$

Suppose both cofactors have strict affine-cylinder scores with the same cylinder correction:

$$ S_b(y)=A_b(y)+V(y), \qquad A_b(y)=a_b+\sum_{i=1}^{m}\alpha_{b,i}y_i, $$

where

$$ V(y)=\sum_{\gamma\in\Gamma}c_{\gamma}C_{\gamma}(y) $$

uses distinct nonvacuous cylinder supports. Define

$$ K(V):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N), $$

and

$$ D(A_0,A_1):=\lbrace i:\alpha_{1,i}\neq\alpha_{0,i}\rbrace. $$

Then

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{sactc}(f) \leq \eta(A_0,A_1) + \lvert D(A_0,A_1)\rvert + K(V), $$

where

$$ \eta(A_0,A_1) := \mathbf{1} \left[ a_1\neq a_0 \text{ or } \exists i,\ \alpha_{0,i}\neq0 \right]. $$

In particular, if

$$ \eta(A_0,A_1) + \lvert D(A_0,A_1)\rvert + K(V) \leq2, $$

then

$$ H^{\ast}(f) = \begin{cases} 0, & \text{if } f \text{ is constant},\cr 1, & \text{if } f \text{ is a nonconstant LTF},\cr 2, & \text{otherwise}. \end{cases} $$

> **Interpretation.** When two cofactors share the same signed cylinder correction, the split only pays for that shared correction and the affine changes between the slices.

## Proof

Apply the cofactor interpolation lemma [111_affine_cylinder_cofactor_interpolation.md](111_affine_cylinder_cofactor_interpolation.md) to the displayed scores. Since the cylinder correction $V$ is identical in both cofactors, the two cylinder-support sets are the same and every cylinder coefficient is unchanged. Thus

$$ \Delta_{\mathrm{cyl}}=\varnothing. $$

The interpolation bound therefore becomes

$$ \mathrm{actc}(f) \leq \eta(A_0,A_1) + \lvert D(A_0,A_1)\rvert + \sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N). $$

By the definition of $\mathrm{sactc}(f)$ in [112_split_affine_cylinder_cost.md](112_split_affine_cylinder_cost.md), the same displayed certificate gives

$$ \mathrm{sactc}(f) \leq \eta(A_0,A_1) + \lvert D(A_0,A_1)\rvert + K(V). $$

Lemma [112_split_affine_cylinder_cost.md](112_split_affine_cylinder_cost.md) gives

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{sactc}(f), $$

so the full chain follows.

If the right-hand side is at most $2$, then $\mathrm{sactc}(f)\leq2$. The low-cost exactness clause of [112_split_affine_cylinder_cost.md](112_split_affine_cylinder_cost.md) gives the displayed exact split. $\blacksquare$

## Consequences

If the two cofactors have the same affine slopes and share one local-cost-one cylinder correction, then

$$ \mathrm{sactc}(f)\leq2 $$

whenever $\eta(A_0,A_1)\leq1$. Every nonconstant non-LTF in this class is exactly two-head.

If the shared cylinder correction is absent and the two affine parts differ only by their constants, then $\mathrm{sactc}(f)\leq1$. Thus every nonconstant function in this subcase is an LTF, recovering the expected affine split behavior.
