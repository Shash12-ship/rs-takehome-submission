# Cylinder-Threshold Cost Invariances

## Statement

Let

$$ f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace. $$

The cylinder-threshold cost $\mathrm{ctc}(f)$ has the following structural properties.

1. Output complement does not change the cost:

   $\mathrm{ctc}(1-f)=\mathrm{ctc}(f).$

2. Coordinate permutations do not change the cost. If $\pi$ is a permutation of $\lbrace1,\ldots,n\rbrace$ and

   $f^{\pi}(x_1,\ldots,x_n) := f(x_{\pi(1)},\ldots,x_{\pi(n)}),$

   then

   $\mathrm{ctc}(f^{\pi})=\mathrm{ctc}(f).$

3. Global bit-flip does not change the cost. If

   $f^{\mathrm{flip}}(x) := f(1-x_1,\ldots,1-x_n),$

   then

   $\mathrm{ctc}(f^{\mathrm{flip}})=\mathrm{ctc}(f).$

4. Restrictions cannot increase the cost. If $g$ is obtained from $f$ by fixing some coordinates, then

   $\mathrm{ctc}(g)\leq\mathrm{ctc}(f).$

5. Adding dummy variables does not change the cost. If

   $F(x,y)=f(x),$

   then

   $\mathrm{ctc}(F)=\mathrm{ctc}(f).$

> **Interpretation.** The optimized cylinder-threshold upper-bound invariant is stable under the same basic symmetries as $H^{\ast}$. Restrictions can only make the invariant smaller, so hard restrictions are valid witnesses for lower-bound attempts on $\mathrm{ctc}$.

## Proof

We use the notation of [099_cylinder_threshold_cost_invariant.md](099_cylinder_threshold_cost_invariant.md). For a cylinder indicator

$$ C_{P,N}(x) := \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right), $$

write

$$ \kappa(P,N) := \begin{cases} 0, & P=N=\varnothing, \cr \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace, & \text{otherwise}. \end{cases} $$

### Lemma 1. Output complement

Fix a strict cylinder-threshold representation

$$ f(x)=1 \qquad\Longleftrightarrow\qquad S(x):=c_0+\sum_{a=1}^{s}c_aC_{P_a,N_a}(x)\gt0. $$

Because the representation is strict on the Boolean cube, $f(x)=0$ is equivalent to $S(x)\lt0$, hence

$$ 1-f(x)=1 \qquad\Longleftrightarrow\qquad -S(x)\gt0. $$

This uses the same cylinders and the same cost. Therefore

$$ \mathrm{ctc}(1-f)\leq\mathrm{ctc}(f). $$

Applying the same argument to $1-f$ proves equality.

### Lemma 2. Coordinate permutations and global bit-flip

A coordinate permutation sends every cylinder indicator to another cylinder indicator with the same values of $\lvert P\rvert$ and $\lvert N\rvert$. Thus the cost of each term is unchanged. Precomposing an optimal representation with the permutation gives

$$ \mathrm{ctc}(f^{\pi})\leq\mathrm{ctc}(f), $$

and applying the inverse permutation gives equality.

Under global bit-flip, the cylinder $(P,N)$ becomes $(N,P)$. Since

$$ \kappa(N,P)=\kappa(P,N), $$

the same argument gives

$$ \mathrm{ctc}(f^{\mathrm{flip}})=\mathrm{ctc}(f). $$

### Lemma 3. Restrictions

Let $g$ be obtained by fixing coordinates outside a free set $K$ to values $\xi_i$. Start from a strict cylinder-threshold representation of $f$:

$$ S(x)=c_0+\sum_{a=1}^{s}c_aC_{P_a,N_a}(x). $$

Restrict this score to the subcube. For a term $C_{P,N}$, there are two cases.

If some fixed coordinate conflicts with the cylinder, namely if either

$$ i\in P,\quad i\notin K,\quad \xi_i=0, $$

or

$$ i\in N,\quad i\notin K,\quad \xi_i=1, $$

then $C_{P,N}$ is identically $0$ on the restricted subcube and can be dropped.

Otherwise the term restricts to the cylinder indicator

$$ C_{P\cap K,N\cap K} $$

on the free variables. Its cost does not exceed the original cost. If $P\cap K=N\cap K=\varnothing$, the restricted cost is $0$. Otherwise,

$$ \begin{aligned} \kappa(P\cap K,N\cap K) &= \min\lbrace2^{\lvert P\cap K\rvert},2^{\lvert N\cap K\rvert}\rbrace \cr &\leq \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace = \kappa(P,N), \end{aligned} $$

with the last equality interpreted in the nonvacuous case. If the original cylinder is vacuous, both costs are $0$.

Thus the restricted score is a strict cylinder-threshold representation of $g$ with no larger total cost. Taking the minimum over representations of $f$ proves

$$ \mathrm{ctc}(g)\leq\mathrm{ctc}(f). $$

### Lemma 4. Dummy variables

Let $F(x,y)=f(x)$. Any cylinder-threshold representation of $f$ extends to one for $F$ by using the same cylinders on the $x$ coordinates and imposing no constraints on the dummy coordinates. The cost is unchanged, so

$$ \mathrm{ctc}(F)\leq\mathrm{ctc}(f). $$

Conversely, fixing the dummy variables in $F$ recovers $f$. The restriction monotonicity from Lemma 3 gives

$$ \mathrm{ctc}(f)\leq\mathrm{ctc}(F). $$

Hence

$$ \mathrm{ctc}(F)=\mathrm{ctc}(f). $$

Combining Lemmas 1 through 4 proves all stated properties. $\blacksquare$

## Consequences

The invariant $\mathrm{ctc}$ can be optimized on canonical representatives under coordinate relabeling, global bit-flip, and output complement. For lower-bound attempts on $\mathrm{ctc}$, hard restrictions are valid witnesses for the original function, because restrictions can only decrease $\mathrm{ctc}$.
