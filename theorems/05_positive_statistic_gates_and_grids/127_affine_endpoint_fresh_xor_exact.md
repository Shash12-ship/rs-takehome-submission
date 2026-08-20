# Affine Endpoint Fresh-XOR Exactness

## Statement

Let

$$ L(y)=a+\sum_{i=1}^{m}\alpha_i y_i $$

be a nonconstant affine statistic on $\lbrace0,1\rbrace^{m}$. Let

$$ \ell_{\min}:=\min_y L(y), \qquad \ell_{\max}:=\max_y L(y), $$

and define the two endpoint predicates

$$ E_{\min}(y):=\mathbf{1}[L(y)=\ell_{\min}], \qquad E_{\max}(y):=\mathbf{1}[L(y)=\ell_{\max}]. $$

Then

$$ H^{\ast}(z\oplus E_{\min}(y)) = H^{\ast}(1-(z\oplus E_{\min}(y))) = 2, $$

and

$$ H^{\ast}(z\oplus E_{\max}(y)) = H^{\ast}(1-(z\oplus E_{\max}(y))) = 2. $$

Equivalently, if $E$ is either endpoint predicate, then both fresh-bit XOR and fresh-bit XNOR over $E$ have exact head complexity $2$.

> **Interpretation.** Lemma 126 is not a positive-weights accident. Fresh XOR with an affine endpoint is always a two-head affine slab, no matter how the affine coefficients are signed.

## Proof

We prove the claim for a generic endpoint. Let $e$ be either $\ell_{\min}$ or $\ell_{\max}$, and set

$$ R(y):= \begin{cases} L(y)-\ell_{\min} & \text{if } e=\ell_{\min},\cr \ell_{\max}-L(y) & \text{if } e=\ell_{\max}. \end{cases} $$

Then $R$ is affine, $R(y)\geq0$ on the cube, and the endpoint predicate is

$$ E(y)=\mathbf{1}[R(y)=0]. $$

Since $L$ is nonconstant, $R$ has at least one positive value. Define

$$ R_{\max}:=\max_y R(y)\gt0, \qquad \delta:=\min\lbrace R(y):R(y)\gt0\rbrace\gt0. $$

The endpoint predicate is a nonconstant LTF, because

$$ E(y)=1 \qquad\Longleftrightarrow\qquad \frac{\delta}{2}-R(y)\gt0. $$

Hence

$$ \deg_{\pm}(E)=1. $$

By the fresh-bit XOR threshold-degree theorem,

$$ \deg_{\pm}(z\oplus E)=2. $$

Since threshold degree lower-bounds head complexity,

$$ H^{\ast}(z\oplus E)\geq2. $$

It remains to prove the two-head upper bound. Set

$$ B:=-R_{\max}-\frac{\delta}{2}, \qquad M(z,y):=R(y)+Bz. $$

We claim that

$$ z\oplus E(y)=1 \qquad\Longleftrightarrow\qquad B+\delta\leq M(z,y)\leq0. $$

If $z=0$ and $E(y)=1$, then $R(y)=0$ and $M(z,y)=0$, so the slab condition holds. If $z=0$ and $E(y)=0$, then $R(y)\geq\delta$ and $M(z,y)\geq\delta\gt0$, so the slab condition fails above the interval.

If $z=1$ and $E(y)=1$, then $R(y)=0$ and $M(z,y)=B\lt B+\delta$, so the slab condition fails below the interval. If $z=1$ and $E(y)=0$, then

$$ \delta\leq R(y)\leq R_{\max}, $$

and therefore

$$ B+\delta\leq M(z,y)\leq B+R_{\max}=-\frac{\delta}{2}\lt0. $$

Thus the slab condition holds exactly on the true inputs of $z\oplus E$. Since $M$ is affine in $(z,y)$, the affine-slab theorem [062_affine_slab_upper_bound.md](../03_function_families_and_affine_geometry/062_affine_slab_upper_bound.md) gives

$$ H^{\ast}(z\oplus E)\leq2. $$

Together with the lower bound, this proves

$$ H^{\ast}(z\oplus E)=2. $$

Finally, output complement preserves head complexity by [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), so

$$ H^{\ast}(1-(z\oplus E))=2. $$

Applying this to $E_{\min}$ and $E_{\max}$ proves the result. $\blacksquare$

## Consequences

The positive endpoint theorem [126_endpoint_feature_fresh_xor_exact.md](../04_recursions_and_cost_invariants/126_endpoint_feature_fresh_xor_exact.md) is the special case where $L(y)=\sum_{i\in S}\lambda_i y_i$ with $\lambda_i\gt0$: the OR-type endpoint is the complement of $E_{\min}$, and the AND-type endpoint is $E_{\max}$.

Thus every affine statistic has exact two-head fresh-XOR behavior at its two finite cube endpoints, even when the generic one-bit LTF branching and optimized $\mathrm{xactc}$ upper bounds are much larger.
