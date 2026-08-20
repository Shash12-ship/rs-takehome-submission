# Optimized Ordered Positive-Statistic Slice Cost

## Statement

Let $k\geq1$, let $z\in\lbrace0,1\rbrace^{k}$ be raw bits, and let $y\in\lbrace0,1\rbrace^{m}$ be the remaining variables. A common positive-statistic certificate for $f(z,y)$ is a positive statistic

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

such that every raw slice factors through $t$:

$$ f(a,y)=F_a(t(y)) \qquad \text{for every }a\in\lbrace0,1\rbrace^{k}. $$

Write the image of $t$ as

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}. $$

For such a certificate and for positive raw weights $\rho_1,\ldots,\rho_k$ with distinct subset sums, order the raw assignments as

$$ a^{(0)},a^{(1)},\ldots,a^{(2^k-1)} $$

by increasing value of $\sum_j\rho_j a_j$. Define the ordered slice cost

$$ \Omega_{t,\rho}(f) := \sum_{a\in\lbrace0,1\rbrace^{k}} \left\lvert \left\lbrace r\in\lbrace0,\ldots,M-2\rbrace:F_a(\tau_r)\neq F_a(\tau_{r+1}) \right\rbrace \right\rvert + J_{t,\rho}(f), $$

where

$$ J_{t,\rho}(f) := \left\lvert \left\lbrace q\in\lbrace0,\ldots,2^k-2\rbrace: F_{a^{(q)}}(\tau_{M-1})\neq F_{a^{(q+1)}}(\tau_0) \right\rbrace \right\rvert. $$

Let

$$ \mathrm{osc}_{+}^{z\mid y}(f) := \min_{t,\rho}\Omega_{t,\rho}(f), $$

where the minimum ranges over all common positive-statistic certificates $t$ and all positive raw weights $\rho$ with distinct subset sums. Then

$$ H^{\ast}(f)\leq \mathrm{osc}_{+}^{z\mid y}(f). $$

> **Interpretation.** The ordered multi-slice construction is an optimized invariant: it charges within-slice positive-statistic variation plus only the boundary jumps forced by the chosen positive raw order.

## Proof

Fix any certificate $t$ and any raw order $\rho$. The ordered common positive-statistic slice bound [147_ordered_common_positive_statistic_slice_bound.md](147_ordered_common_positive_statistic_slice_bound.md) gives

$$ H^{\ast}(f)\leq\Omega_{t,\rho}(f). $$

Taking the minimum over all such pairs gives

$$ H^{\ast}(f)\leq \mathrm{osc}_{+}^{z\mid y}(f). $$

The minimum is over a nonempty family. Indeed, choosing positive weights for $t$ with distinct subset sums separates all points of $\lbrace0,1\rbrace^{m}$, so every raw slice factors through $t$ trivially. Positive raw weights with distinct subset sums exist by the same generic choice. $\blacksquare$

## Consequence

Lemma 147 is the pointwise form of this optimized bound. Lemma 145 is recovered by using one fixed binary raw order and replacing $J_{t,\rho}(f)$ by the worst-case value $2^k-1$.
