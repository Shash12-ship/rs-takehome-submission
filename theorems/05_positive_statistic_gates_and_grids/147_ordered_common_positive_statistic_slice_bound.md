# Ordered Common Positive-Statistic Slice Bound

## Statement

Let $k\geq1$, let $z\in\lbrace0,1\rbrace^{k}$ be raw bits, and let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0. $$

Suppose each raw-bit slice of $f(z,y)$ factors through $t$:

$$ f(a,y)=F_a(t(y)) \qquad \text{for every }a\in\lbrace0,1\rbrace^{k}. $$

Write the image of $t$ as

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}. $$

Choose positive raw weights $\rho_1,\ldots,\rho_k$ with distinct subset sums, and order the raw assignments as

$$ a^{(0)},a^{(1)},\ldots,a^{(2^k-1)} $$

so that

$$ \sum_{j=1}^{k}\rho_j a^{(q)}_j \lt \sum_{j=1}^{k}\rho_j a^{(q+1)}_j. $$

Let $C_a$ be the sign-change count of $F_a$ along $\tau_0,\ldots,\tau_{M-1}$, and let $J_{\rho}$ be the number of boundary jumps:

$$ J_{\rho} := \left\lvert \left\lbrace q\in\lbrace0,\ldots,2^k-2\rbrace: F_{a^{(q)}}(\tau_{M-1})\neq F_{a^{(q+1)}}(\tau_0) \right\rbrace \right\rvert. $$

Then

$$ H^{\ast}(f) \leq \sum_{a\in\lbrace0,1\rbrace^{k}}C_a+J_{\rho}. $$

> **Interpretation.** The multi-slice construction pays only for actual boundary label changes between consecutive raw slices, not for every boundary.

## Proof

Let

$$ \Lambda:=\sum_{i=1}^{m}\lambda_i. $$

Let

$$ r(a):=\sum_{j=1}^{k}\rho_j a_j, $$

and let

$$ \Delta:=\min_{0\leq q\lt2^k-1}\bigl(r(a^{(q+1)})-r(a^{(q)})\bigr)\gt0. $$

Choose

$$ K\gt\frac{\Lambda}{\Delta}. $$

Define a positive statistic on the combined variables by

$$ s(z,y):=t(y)+K\sum_{j=1}^{k}\rho_jz_j. $$

For a fixed raw assignment $a$, the values of $s(a,y)$ lie in the interval

$$ [Kr(a),Kr(a)+\Lambda]. $$

The choice of $K$ makes these intervals disjoint and ordered as

$$ a^{(0)},a^{(1)},\ldots,a^{(2^k-1)}. $$

Therefore the ordered label sequence of $f$ along $s$ is the concatenation

$$ F_{a^{(0)}}(\tau_0),\ldots,F_{a^{(0)}}(\tau_{M-1}), F_{a^{(1)}}(\tau_0),\ldots,F_{a^{(1)}}(\tau_{M-1}), \ldots, F_{a^{(2^k-1)}}(\tau_0),\ldots,F_{a^{(2^k-1)}}(\tau_{M-1}). $$

Its sign changes are exactly the within-slice sign changes, totaling $\sum_a C_a$, plus the boundary jumps counted by $J_{\rho}$. The positive-projection sign-change upper bound [013_positive_projection_sign_changes.md](../01_foundations_and_normal_form/013_positive_projection_sign_changes.md) applied to $s$ gives

$$ H^{\ast}(f)\leq \sum_a C_a+J_{\rho}. $$

$\blacksquare$

## Consequence

Lemma 145 is the coarse bound obtained by using a fixed binary-code order and replacing $J_{\rho}$ by the worst-case bound $2^k-1$.
