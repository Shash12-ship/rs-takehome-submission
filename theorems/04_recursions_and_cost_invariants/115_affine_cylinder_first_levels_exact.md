# Affine-Cylinder First Levels Are Exact

## Statement

For every Boolean function $f$,

$$ \mathrm{actc}(f)=0 \qquad\Longleftrightarrow\qquad f \text{ is constant}, $$

and

$$ \mathrm{actc}(f)=1 \qquad\Longleftrightarrow\qquad f \text{ is a nonconstant LTF}. $$

Equivalently,

$$ \mathrm{actc}(f)\geq2 \qquad\Longleftrightarrow\qquad f \text{ is neither constant nor a nonconstant LTF}. $$

> **Interpretation.** The affine-cylinder cost has the same first two levels as head complexity. Its first possible slack over $H^{\ast}$ can only begin at level $2$.

## Proof

If $\mathrm{actc}(f)=0$, then the affine-cylinder representation has no nonconstant affine part and no nonvacuous cylinder terms. The score is constant on the cube, so $f$ is constant.

Conversely, if $f$ is constant, choose a constant strict score, positive for the constant $1$ function and negative for the constant $0$ function. This has affine-cylinder cost $0$, so

$$ \mathrm{actc}(f)=0. $$

Now suppose $f$ is a nonconstant LTF. Choose a strict affine separator

$$ A(x)=a_0+\sum_{i=1}^{n}a_i x_i $$

for $f$. Since $f$ is nonconstant, some linear coefficient is nonzero. Thus $\lambda(A)=1$, and the affine score alone gives

$$ \mathrm{actc}(f)\leq1. $$

The function is not constant, so the first part rules out $\mathrm{actc}(f)=0$. Hence

$$ \mathrm{actc}(f)=1. $$

Conversely, suppose $\mathrm{actc}(f)=1$. The head upper bound [103_affine_cylinder_threshold_cost.md](103_affine_cylinder_threshold_cost.md) gives

$$ H^{\ast}(f)\leq1. $$

The zero-head and one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) says that functions with $H^{\ast}\leq1$ are exactly constants and nonconstant LTFs. Since $\mathrm{actc}(f)\neq0$, the first part shows that $f$ is not constant. Therefore $f$ is a nonconstant LTF.

Finally, the displayed lower-level characterization implies

$$ \mathrm{actc}(f)\leq1 \qquad\Longleftrightarrow\qquad f \text{ is constant or a nonconstant LTF}. $$

Taking the negation gives the final equivalence. $\blacksquare$

## Consequences

The low-cost exactness theorem [109_low_affine_cylinder_cost_exactness.md](109_low_affine_cylinder_cost_exactness.md) starts with a sharp base:

$$ \mathrm{actc}(f) = H^{\ast}(f) \qquad \text{for } \mathrm{actc}(f)\in\lbrace0,1\rbrace. $$

Thus any affine-cylinder certificate for a function that is neither constant nor a nonconstant LTF must pay cost at least $2$, and cost $2$ is automatically an exact two-head certificate.
