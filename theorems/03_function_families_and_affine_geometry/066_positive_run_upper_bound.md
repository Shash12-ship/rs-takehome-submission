# Positive Run-Count Upper Bound

## Statement

Let

$$ f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace. $$

Let

$$ t(x)=\sum_{i=1}^{n}\lambda_i x_i, \qquad \lambda_i\gt0, $$

be injective on the Boolean cube. List the cube points in increasing order of $t$:

$$ x^{(0)},x^{(1)},\ldots,x^{(2^n-1)}. $$

For $b\in\lbrace0,1\rbrace$, let $R_t^b(f)$ be the number of maximal contiguous blocks of indices $j$ for which

$$ f(x^{(j)})=b. $$

Then

$$ H^{\ast}(f) \leq 2\min\lbrace R_t^0(f),R_t^1(f)\rbrace. $$

Consequently, if

$$ R_{+}(f) := \min_t\min\lbrace R_t^0(f),R_t^1(f)\rbrace, $$

where the minimum ranges over injective positive weighted sums $t$, then

$$ H^{\ast}(f)\leq2R_{+}(f). $$

> **Interpretation.** Sparse support is only the coarsest version of the positive-projection argument. What really matters is how many runs the cheaper label class forms in some positive ordering of the cube.

## Proof

Fix an injective positive weighted sum $t$. Since $t$ is injective, $f$ factors through $t$.

Let

$$ a_j:=f(x^{(j)}) $$

be the ordered label sequence. The number of sign changes in this sequence is at most twice the number of $1$-runs:

$$ C_t(f)\leq2R_t^1(f). $$

Indeed, each $1$-run contributes at most one sign change when entering the run and at most one sign change when leaving it. The same argument gives

$$ C_t(f)\leq2R_t^0(f). $$

Therefore

$$ C_t(f)\leq2\min\lbrace R_t^0(f),R_t^1(f)\rbrace. $$

The positive-projection sign-change theorem [013_positive_projection_sign_changes.md](../01_foundations_and_normal_form/013_positive_projection_sign_changes.md) gives

$$ H^{\ast}(f)\leq C_t(f), $$

and hence

$$ H^{\ast}(f) \leq 2\min\lbrace R_t^0(f),R_t^1(f)\rbrace. $$

Optimizing over injective positive weighted sums $t$ proves the $R_{+}(f)$ bound. $\blacksquare$

## Consequence

The sparse-support upper bound [037_sparse_support_upper_bound.md](../02_complexity_measure_upper_bounds/037_sparse_support_upper_bound.md) follows immediately. If $s(f)$ is the size of the smaller label class, then every run of that label contains at least one point, so

$$ R_{+}(f)\leq s(f), $$

and therefore

$$ H^{\ast}(f)\leq2s(f). $$

The run-count invariant can be strictly smaller than support size. If the smaller label class is contiguous in some positive ordering, then

$$ R_{+}(f)=1 $$

and the theorem gives a two-head upper bound.
