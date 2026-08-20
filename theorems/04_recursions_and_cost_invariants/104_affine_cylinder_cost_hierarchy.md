# Affine-Cylinder Cost Hierarchy

## Statement

Let $\mathrm{afs}_{\pm}(f)$ be the affine-free polynomial-threshold sparsity from [048_affine_free_sparsity_upper_bound.md](../03_function_families_and_affine_geometry/048_affine_free_sparsity_upper_bound.md), and let $\mathrm{ptfsp}(f)$ be ordinary polynomial-threshold sparsity. Then

$$ \mathrm{actc}(f) \leq \mathrm{afs}_{\pm}(f) \leq \mathrm{ptfsp}(f). $$

Combining with Lemma 103 gives

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \min\lbrace\mathrm{ctc}(f),\mathrm{afs}_{\pm}(f)\rbrace. $$

Consequently, if $f$ is nonconstant and $\deg_{\pm}(f)\leq d$, then

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq 1+\sum_{r=2}^{d}\binom{n}{r}. $$

> **Interpretation.** The affine-cylinder invariant is a common refinement of two upper-bound routes: signed local cylinder votes and affine-free sparse sign polynomials.

## Proof

Let

$$ P(x) = a_{\varnothing} + \sum_{\varnothing\neq S\subseteq\lbrace1,\ldots,n\rbrace}a_S\prod_{i\in S}x_i $$

be a strict sign-representing polynomial for $f$. Split it as

$$ P(x) = A(x) + \sum_{S\in\mathcal{M}}a_S\prod_{i\in S}x_i, $$

where

$$ A(x) := a_{\varnothing} + \sum_{i=1}^{n}a_{\lbrace i\rbrace}x_i $$

is the affine part and

$$ \mathcal{M} := \lbrace S:\lvert S\rvert\geq2,\ a_S\neq0\rbrace. $$

For each $S\in\mathcal{M}$,

$$ \prod_{i\in S}x_i = C_{S,\varnothing}(x) $$

and

$$ \kappa(S,\varnothing)=1. $$

Therefore the same strict sign polynomial is an affine-cylinder threshold representation:

$$ f(x)=1 \qquad\Longleftrightarrow\qquad A(x)+\sum_{S\in\mathcal{M}}a_SC_{S,\varnothing}(x)\gt0. $$

Its affine-cylinder cost is

$$ \lambda(A)+\lvert\mathcal{M}\rvert = \mathrm{afs}(P). $$

Thus

$$ \mathrm{actc}(f)\leq\mathrm{afs}(P). $$

Minimizing over all strict sign-representing polynomials proves

$$ \mathrm{actc}(f)\leq\mathrm{afs}_{\pm}(f). $$

For every polynomial $P$, the affine-free support cost is at most the number of nonconstant monomials in $P$: all nonzero linear monomials together cost at most one, and all nonlinear monomials are counted exactly. Taking a polynomial that achieves $\mathrm{ptfsp}(f)$ gives

$$ \mathrm{afs}_{\pm}(f)\leq\mathrm{ptfsp}(f). $$

Lemma 103 gives

$$ H^{\ast}(f)\leq\mathrm{actc}(f) \qquad \text{and} \qquad \mathrm{actc}(f)\leq\mathrm{ctc}(f). $$

Combining these inequalities yields

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \min\lbrace\mathrm{ctc}(f),\mathrm{afs}_{\pm}(f)\rbrace. $$

Finally, if $f$ is nonconstant and $\deg_{\pm}(f)\leq d$, choose a degree-at-most $d$ sign polynomial. Its affine-free support cost is at most

$$ 1+\sum_{r=2}^{d}\binom{n}{r}, $$

because all linear terms together cost one affine block and there are at most $\binom{n}{r}$ monomials of each degree $r\geq2$. The degree corollary follows. $\blacksquare$

## Consequences

The ordinary sparse-PTF theorem and the affine-free sparse-PTF theorem both factor through $\mathrm{actc}$:

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{afs}_{\pm}(f) \leq \mathrm{ptfsp}(f). $$

Together with Lemma 103,

$$ \mathrm{actc}(f) \leq \min\lbrace\mathrm{ctc}(f),\mathrm{afs}_{\pm}(f)\rbrace. $$

Thus the next sharper upper-bound search can ask for a strict threshold of locally cheap cylinders after first extracting one dense affine component.
