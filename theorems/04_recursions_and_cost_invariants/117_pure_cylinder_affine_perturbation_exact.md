# Pure-Cylinder Affine Perturbations Are Exact

## Statement

Let

$$ f:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace. $$

Suppose there are disjoint sets $P,N\subseteq\lbrace1,\ldots,n\rbrace$ with either $P=\varnothing$ or $N=\varnothing$, an affine form

$$ A(x)=a_0+\sum_{i=1}^{n}a_i x_i, $$

and a real coefficient $c$ such that

$$ f(x)=1 \qquad\Longleftrightarrow\qquad A(x)+cC_{P,N}(x)\gt0 $$

strictly on the cube. Then

$$ \mathrm{actc}(f)\leq2. $$

Consequently,

$$ H^{\ast}(f) = \begin{cases} 0, & \text{if } f \text{ is constant},\cr 1, & \text{if } f \text{ is a nonconstant LTF},\cr 2, & \text{otherwise}. \end{cases} $$

> **Interpretation.** A single pure positive or pure negative cylinder can be added to an arbitrary affine score at two-head cost. This includes negative-literal conjunctions without expanding them into many positive monomials.

## Proof

If $P=N=\varnothing$, then $C_{P,N}$ is constant, so the displayed score is affine. Hence $f$ is constant or a nonconstant LTF, and the conclusion follows from the zero-head and one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md).

Assume now that $(P,N)$ is nonvacuous. Since either $P=\varnothing$ or $N=\varnothing$,

$$ \kappa(P,N)=1. $$

The displayed strict score is an affine-cylinder representation with one affine part and one nonvacuous cylinder. Its cost is at most

$$ \lambda(A)+\kappa(P,N)\leq2. $$

Therefore

$$ \mathrm{actc}(f)\leq2. $$

The exact case distinction now follows from the low affine-cylinder exactness theorem [109_low_affine_cylinder_cost_exactness.md](109_low_affine_cylinder_cost_exactness.md). $\blacksquare$

## Consequences

Every function that is neither constant nor a nonconstant LTF and has the form

$$ x\mapsto \mathbf{1} \left[ A(x)+c\prod_{i\in P}x_i\gt0 \right] $$

is exactly two-head.

The same is true for every function that is neither constant nor a nonconstant LTF and has the form

$$ x\mapsto \mathbf{1} \left[ A(x)+c\prod_{j\in N}(1-x_j)\gt0 \right]. $$

The second family can have a large positive-monomial expansion, but the affine-cylinder certificate pays only the local cylinder cost $1$.
