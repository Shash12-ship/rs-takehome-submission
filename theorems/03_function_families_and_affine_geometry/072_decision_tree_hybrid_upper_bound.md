# Decision-Tree Hybrid Upper Bound

## Statement

Let $\mathcal{T}$ be a deterministic decision tree computing

$$ f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace. $$

Let $d$ be the depth of $\mathcal{T}$, and let $v$ be the number of distinct variables queried anywhere in $\mathcal{T}$. For a leaf $\ell$, let $P_\ell$ be the set of variables fixed to $1$ along the root-to-leaf path, and let $N_\ell$ be the set of variables fixed to $0$. Let $\mathcal{L}_1$ and $\mathcal{L}_0$ be the accepting and rejecting leaves.

Define the local leaf-profile cost

$$ \Lambda(\mathcal{T}) := \min\left\lbrace \sum_{\ell\in\mathcal{L}_1}\min\lbrace2^{\lvert P_\ell\rvert},2^{\lvert N_\ell\rvert}\rbrace, \sum_{\ell\in\mathcal{L}_0}\min\lbrace2^{\lvert P_\ell\rvert},2^{\lvert N_\ell\rvert}\rbrace \right\rbrace. $$

If $f$ is nonconstant, then

$$ H^{\ast}(f) \leq \min\left\lbrace \Lambda(\mathcal{T}), 2^v-1, 1+\sum_{r=2}^{\min\lbrace d,v\rbrace}\binom{v}{r} \right\rbrace. $$

If $f$ is constant, then $H^{\ast}(f)=0$.

> **Interpretation.** A decision tree gives several different head certificates. Leaf profiles are ambient-dimension-free and reward one-sided certificates with few literals of one sign. The degree route is polynomial in the number of variables queried when the depth is small. The junta route is best when the tree uses few variables overall.

## Proof

The local leaf-profile upper bound is exactly [044_oriented_certificate_expansion_upper_bound.md](../02_complexity_measure_upper_bounds/044_oriented_certificate_expansion_upper_bound.md) applied to the accepting and rejecting leaf covers:

$$ H^{\ast}(f)\leq\Lambda(\mathcal{T}). $$

Since $f$ depends only on the variables queried by $\mathcal{T}$, it is a $v$-junta. The junta upper bound [039_junta_upper_bounds.md](../02_complexity_measure_upper_bounds/039_junta_upper_bounds.md) gives

$$ H^{\ast}(f)\leq2^v-1 $$

for nonconstant $f$.

It remains to prove the degree route. The accepting leaves give the exact DNF

$$ f(x) = \bigvee_{\ell\in\mathcal{L}_1} \left[ \left(\prod_{i\in P_\ell}x_i\right) \left(\prod_{j\in N_\ell}(1-x_j)\right) =1 \right]. $$

Equivalently, the polynomial

$$ Q(x) := \sum_{\ell\in\mathcal{L}_1} \left(\prod_{i\in P_\ell}x_i\right) \left(\prod_{j\in N_\ell}(1-x_j)\right) -\frac{1}{2} $$

strictly sign-represents $f$ on the cube. Every root-to-leaf path fixes at most $d$ variables, so each term has degree at most $d$ after multilinear expansion. Since only the $v$ queried variables appear, $Q$ has degree at most

$$ \min\lbrace d,v\rbrace. $$

Thus

$$ \deg_{\pm}(f)\leq\min\lbrace d,v\rbrace. $$

If $f$ is nonconstant, the affine-free polynomial-threshold sparsity theorem [048_affine_free_sparsity_upper_bound.md](048_affine_free_sparsity_upper_bound.md) gives

$$ H^{\ast}(f) \leq 1+\sum_{r=2}^{\min\lbrace d,v\rbrace}\binom{v}{r}, $$

because the sign polynomial only uses the $v$ queried variables. Taking the minimum of the three displayed upper bounds proves the theorem. $\blacksquare$

## Consequences

For every nonconstant $f$ with deterministic decision-tree depth $D(f)=d$ and essential-variable count $\mathrm{ess}(f)=v$,

$$ H^{\ast}(f) \leq \min\left\lbrace 2^{d+\lfloor d/2\rfloor-1}, 2^v-1, 1+\sum_{r=2}^{\min\lbrace d,v\rbrace}\binom{v}{r} \right\rbrace. $$

The first term is the uniform leaf-profile bound from [044_oriented_certificate_expansion_upper_bound.md](../02_complexity_measure_upper_bounds/044_oriented_certificate_expansion_upper_bound.md). The second is the generic junta bound. The third is the depth-degree route.

For fixed depth $d$, this gives a polynomial upper bound in the number of variables actually queried by the tree:

$$ H^{\ast}(f) \leq 1+\sum_{r=2}^{d}\binom{v}{r} = O(v^d). $$

This complements the ambient-dimension-free leaf-profile bound, which can be much smaller for balanced leaf paths but much larger when $d$ is fixed and $v$ is moderate.
