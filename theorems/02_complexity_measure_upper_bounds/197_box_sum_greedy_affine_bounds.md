# Greedy Affine Bounds on a Box With One Sum Constraint

## Statement

Let $m\geq1$, let $\ell_i\leq u_i$ and $c_i$ be rational numbers, and suppose

$$ \sum_{i=1}^{m}\ell_i\leq T\leq\sum_{i=1}^{m}u_i. $$

Define the rational polytope

$$ K=\left\lbrace x\in\mathbb R^m:\ell_i\leq x_i\leq u_i,\quad \sum_{i=1}^{m}x_i=T\right\rbrace. $$

Put $w_i=u_i-\ell_i$ and $R=T-\sum_i\ell_i$. Choose a permutation $\pi$ such that

$$ c_{\pi(1)}\leq c_{\pi(2)}\leq\cdots\leq c_{\pi(m)}. $$

Starting with $r_0=R$, define

$$ \delta_{\pi(k)}=\min\lbrace w_{\pi(k)},r_{k-1}\rbrace,\qquad r_k=r_{k-1}-\delta_{\pi(k)}. $$

Then $x_i^{-}=\ell_i+\delta_i$ minimizes $c^{\top}x$ over $K$. Reversing the coefficient order gives a maximizer $x^+$. Consequently, the exact range of $c^{\top}x$ over $K$ is computable using rational arithmetic in $O(m\log m)$ comparisons and $O(m)$ arithmetic operations after sorting.

> **Computational meaning.** Exact affine intervals over a subdivided simplex or zero-sum direction box do not require a linear-program call. They are fractional-knapsack bounds with a short exact checker.

## Proof

The feasibility assumption gives

$$ 0\leq R\leq\sum_iw_i. $$

The greedy construction therefore allocates all of $R$ without exceeding any capacity. Hence $x^-\in K$.

Consider any feasible allocation $\eta_i=x_i-\ell_i$, so $0\leq\eta_i\leq w_i$ and $\sum_i\eta_i=R$. Suppose there are indices $i,j$ with $c_i\lt c_j$, $\eta_i\lt w_i$, and $\eta_j\gt0$. For

$$ 0\lt\varepsilon\leq\min\lbrace w_i-\eta_i,\eta_j\rbrace, $$

replace $\eta_i$ by $\eta_i+\varepsilon$ and $\eta_j$ by $\eta_j-\varepsilon$. Feasibility is preserved, while the objective changes by

$$ \varepsilon(c_i-c_j)\lt0. $$

Thus a minimizer can put positive allocation on a larger coefficient only after every strictly smaller coefficient is saturated. Ties may be resolved arbitrarily. This is exactly the ascending greedy allocation. Reversing the exchange proves the descending rule for the maximum. Sorting dominates the running time. $\blacksquare$

## Consequence for Signed-Secant Relaxations

Let $\theta_h$ lie in a simplex cell, and let $L(x)\in\lbrace0,1\rbrace^{n+1}$ be one oriented literal vector. The theorem gives the exact cellwise interval of

$$ b_h=L(x)^{\top}\theta_h. $$

In particular, the unsplit simplex gives $0\leq b_h\leq1$.

For a normalized direction cell with $\sum_i v_{hi}=0$, the same rule with $T=0$ gives the exact interval of

$$ d_h=L(x)^{\top}v_h. $$

After introducing $z_{hi}=tv_{hi}$ and the exact RLT identity $\sum_i z_{hi}=0$, it also bounds $L(x)^{\top}z_h$. Finally, the endpoint coordinates $\theta_h+z_h$ are nonnegative and sum to one, so

$$ 0\leq c_h=L(x)^{\top}(\theta_h+z_h)\leq1. $$

These bounds are valid for the McCormick relaxation itself because they use linear box constraints and exact sum equalities already present in that relaxation. They can therefore replace the looser independent-coordinate intervals before any product envelopes are generated.

## Verification

The implementation is `linear_box_sum_bounds` in `src/hstar/signed_secant_mccormick.py`. The verifier enumerates every extreme point of $700$ random rational box-sum polytopes through dimension seven and compares both endpoints exactly. It also checks all $512$ zero-one literal masks on a nine-coordinate simplex.

```bash
PYTHONPATH=src python3 artifacts/calculations/verify_box_sum_affine_bounds.py
```
