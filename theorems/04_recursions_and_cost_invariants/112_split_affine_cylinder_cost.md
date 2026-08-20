# Split Affine-Cylinder Cost

## Statement

Let

$$ f:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace $$

with $n\geq1$. Fix a split coordinate $j$ and write the inputs as

$$ (z,y)\in\lbrace0,1\rbrace\times\lbrace0,1\rbrace^{n-1}. $$

For $b\in\lbrace0,1\rbrace$, let

$$ f_b(y):=f(b,y). $$

Given strict affine-cylinder scores $S_0,S_1$ for the two cofactors, written as in [111_affine_cylinder_cofactor_interpolation.md](111_affine_cylinder_cofactor_interpolation.md), define their split interpolation cost by

$$ \begin{aligned} I(S_0,S_1) :={}& \eta(A_0,A_1) + \lvert\Delta_{\mathrm{lin}}\rvert \cr &+ \sum_{\gamma=(P,N)\in\Gamma_0}\kappa(P,N) + \sum_{\gamma=(P,N)\in\Delta_{\mathrm{cyl}}}\kappa(P\cup\lbrace z\rbrace,N). \end{aligned} $$

Let

$$ \mathrm{sactc}_{j}(f) $$

be the minimum of $I(S_0,S_1)$ over all choices of strict affine-cylinder scores for $f_0$ and $f_1$ along the split coordinate $j$, and define

$$ \mathrm{sactc}(f) := \min_{1\leq j\leq n}\mathrm{sactc}_{j}(f). $$

Then

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{sactc}(f). $$

If

$$ \mathrm{sactc}(f)\leq2, $$

then

$$ H^{\ast}(f) = \begin{cases} 0, & \text{if } f \text{ is constant},\cr 1, & \text{if } f \text{ is a nonconstant LTF},\cr 2, & \text{otherwise}. \end{cases} $$

> **Interpretation.** The split affine-cylinder cost is an optimized recursive certificate. It is not a new lower bound on $\mathrm{actc}$; it is a structured way to produce affine-cylinder certificates by interpolating two cofactors.

## Proof

For every split coordinate $j$, the two cofactors have strict affine-cylinder scores because $\mathrm{actc}$ is finite for every Boolean function by [103_affine_cylinder_threshold_cost.md](103_affine_cylinder_threshold_cost.md). Hence the minimum defining $\mathrm{sactc}_{j}(f)$ is over a nonempty set of nonnegative integers.

Fix a split coordinate $j$ and strict affine-cylinder cofactor scores $S_0,S_1$. Lemma [111_affine_cylinder_cofactor_interpolation.md](111_affine_cylinder_cofactor_interpolation.md) gives

$$ \mathrm{actc}(f)\leq I(S_0,S_1). $$

Minimizing first over the two cofactor scores and then over the split coordinate gives

$$ \mathrm{actc}(f)\leq\mathrm{sactc}(f). $$

The affine-cylinder threshold-cost theorem [103_affine_cylinder_threshold_cost.md](103_affine_cylinder_threshold_cost.md) gives

$$ H^{\ast}(f)\leq\mathrm{actc}(f). $$

Combining the two inequalities proves

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{sactc}(f). $$

If $\mathrm{sactc}(f)\leq2$, then $\mathrm{actc}(f)\leq2$. The low affine-cylinder exactness theorem [109_low_affine_cylinder_cost_exactness.md](109_low_affine_cylinder_cost_exactness.md) now gives the displayed constant, nonconstant LTF, or two-head split. $\blacksquare$

## Consequences

This packages Lemma 111 as a reusable invariant for recursive search. To prove a small head upper bound, it is enough to find one coordinate whose two cofactors admit affine-cylinder scores with small base cost and few changed coefficients.

The exact low-cost corollary is especially useful: every nonconstant non-LTF with $\mathrm{sactc}(f)\leq2$ is exactly two-head.
