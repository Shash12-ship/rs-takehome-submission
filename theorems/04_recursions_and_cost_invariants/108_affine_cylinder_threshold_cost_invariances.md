# Affine-Cylinder Threshold Cost Invariances

## Statement

Let

$$ f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace. $$

The affine-cylinder threshold cost $\mathrm{actc}(f)$ has the following structural properties.

1. Output complement does not change the cost:

   $\mathrm{actc}(1-f)=\mathrm{actc}(f).$

2. Coordinate permutations do not change the cost. If $\pi$ is a permutation of $\lbrace1,\ldots,n\rbrace$ and

   $f^{\pi}(x_1,\ldots,x_n) := f(x_{\pi(1)},\ldots,x_{\pi(n)}),$

   then

   $\mathrm{actc}(f^{\pi})=\mathrm{actc}(f).$

3. Global bit-flip does not change the cost. If

   $f^{\mathrm{flip}}(x) := f(1-x_1,\ldots,1-x_n),$

   then

   $\mathrm{actc}(f^{\mathrm{flip}})=\mathrm{actc}(f).$

4. Restrictions cannot increase the cost. If $g$ is obtained from $f$ by fixing some coordinates, then

   $\mathrm{actc}(g)\leq\mathrm{actc}(f).$

5. Adding dummy variables does not change the cost. If

   $F(x,y)=f(x),$

   then

   $\mathrm{actc}(F)=\mathrm{actc}(f).$

> **Interpretation.** The affine-cylinder invariant can be optimized on the same canonical representatives as $\mathrm{ctc}$, and hard restrictions remain valid witnesses for lower-bound attempts.

## Proof

We use the notation of [103_affine_cylinder_threshold_cost.md](103_affine_cylinder_threshold_cost.md). A representation has score

$$ S(x) := A(x)+\sum_{a=1}^{s}c_aC_{P_a,N_a}(x), $$

and cost

$$ \lambda(A)+\sum_{a:c_a\neq0}\kappa(P_a,N_a). $$

### Lemma 1. Output complement

Fix a strict affine-cylinder representation

$$ f(x)=1 \qquad\Longleftrightarrow\qquad S(x)\gt0. $$

Because the representation is strict, $f(x)=0$ is equivalent to $S(x)\lt0$. Thus

$$ 1-f(x)=1 \qquad\Longleftrightarrow\qquad -S(x)\gt0. $$

This changes the affine part from $A$ to $-A$, which has the same value of $\lambda$, and changes each cylinder coefficient from $c_a$ to $-c_a$ without changing its support or cost. Hence

$$ \mathrm{actc}(1-f)\leq\mathrm{actc}(f). $$

Applying the same argument to $1-f$ proves equality.

### Lemma 2. Coordinate permutations and global bit-flip

Under a coordinate permutation, the affine form $A$ is relabeled. It has a nonzero linear part exactly when the original affine form does, so $\lambda(A)$ is unchanged. Each cylinder is relabeled to another cylinder with the same values of $\lvert P\rvert$ and $\lvert N\rvert$, so every $\kappa(P,N)$ is unchanged. Precomposing a representation with the permutation gives

$$ \mathrm{actc}(f^{\pi})\leq\mathrm{actc}(f), $$

and applying the inverse permutation gives equality.

Under global bit-flip, the affine form becomes

$$ A(1-x_1,\ldots,1-x_n), $$

which has a nonzero linear part exactly when $A$ does. Each cylinder $(P,N)$ becomes $(N,P)$, and

$$ \kappa(N,P)=\kappa(P,N). $$

The same reversible argument gives

$$ \mathrm{actc}(f^{\mathrm{flip}})=\mathrm{actc}(f). $$

### Lemma 3. Restrictions

Let $g$ be obtained by fixing coordinates outside a free set $K$ to values $\xi_i$. Start from a strict affine-cylinder representation of $f$ with score

$$ S(x) = A(x)+\sum_{a=1}^{s}c_aC_{P_a,N_a}(x). $$

Restrict $S$ to the subcube. The affine part restricts to an affine form $A_K$ on the free coordinates. Its nonconstant linear part is obtained by deleting some slopes of $A$, so

$$ \lambda(A_K)\leq\lambda(A). $$

For a cylinder $C_{P,N}$, there are two cases. If a fixed coordinate conflicts with the cylinder, then that cylinder is identically $0$ on the restricted subcube and can be dropped. Otherwise it restricts to

$$ C_{P\cap K,N\cap K} $$

on the free variables. As in the proof of [100_cylinder_threshold_cost_invariances.md](100_cylinder_threshold_cost_invariances.md),

$$ \kappa(P\cap K,N\cap K)\leq\kappa(P,N), $$

with both sides equal to $0$ when the relevant cylinder is vacuous.

Thus the restricted score is a strict affine-cylinder representation of $g$ with no larger total cost. Taking the minimum over representations of $f$ proves

$$ \mathrm{actc}(g)\leq\mathrm{actc}(f). $$

### Lemma 4. Dummy variables

Let $F(x,y)=f(x)$. Any affine-cylinder representation of $f$ extends to one for $F$ by using the same affine form on the $x$ coordinates, zero slopes on the dummy coordinates, and the same cylinders on the $x$ coordinates. The cost is unchanged, so

$$ \mathrm{actc}(F)\leq\mathrm{actc}(f). $$

Conversely, fixing the dummy variables in $F$ recovers $f$. Restriction monotonicity gives

$$ \mathrm{actc}(f)\leq\mathrm{actc}(F). $$

Therefore

$$ \mathrm{actc}(F)=\mathrm{actc}(f). $$

Combining Lemmas 1 through 4 proves all stated properties. $\blacksquare$

## Consequences

The invariant $\mathrm{actc}$ is suitable for symmetry-reduced search. It can be minimized after quotienting by output complement, coordinate permutation, and global bit-flip, and any hard restriction of $f$ gives a lower-bound obstruction for $f$ itself.
