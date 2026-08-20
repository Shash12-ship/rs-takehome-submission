# Ordered Slice Degree Bound

## Statement

Let $k\geq1$, let $z\in\lbrace0,1\rbrace^{k}$ be raw bits, and let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0. $$

Suppose $P(z,y)$ is a strict sign polynomial for $f(z,y)$, and suppose that for each raw assignment $a\in\lbrace0,1\rbrace^{k}$ the slice

$$ P(a,y)=p_a(t(y)) $$

is a univariate polynomial in $t(y)$ of degree at most $d_a$. Choose positive raw weights $\rho_1,\ldots,\rho_k$ with distinct subset sums, and let $J_{\rho}(f)$ be the actual boundary-jump count from Lemma 147 for the slice functions of $f$ along this raw order. Then

$$ H^{\ast}(f) \leq \sum_{a\in\lbrace0,1\rbrace^{k}}d_a+J_{\rho}(f). $$

Consequently,

$$ H^{\ast}(f) \leq \sum_{a\in\lbrace0,1\rbrace^{k}}d_a + \min_{\rho}J_{\rho}(f). $$

If $P$ has degree at most $d$ in the quantities $t(y),z_1,\ldots,z_k$, reduced multilinearly in the raw bits, then

$$ H^{\ast}(f) \leq 2^k d+\min_{\rho}J_{\rho}(f). $$

> **Interpretation.** Degree controls the variation inside each raw slice, while the ordered-slice proof keeps the exact boundary price instead of paying the coarse $2^k-1$ term.

## Proof

Write the image of $t$ as

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}. $$

Fix a raw assignment $a$. Since $P$ strictly sign-represents $f$, the values

$$ p_a(\tau_r) $$

are nonzero for all $r$. If the slice label changes between $\tau_r$ and $\tau_{r+1}$, then $p_a(\tau_r)$ and $p_a(\tau_{r+1})$ have opposite signs. By the intermediate value theorem, $p_a$ has a real root in the interval $(\tau_r,\tau_{r+1})$.

Distinct adjacent sign changes give disjoint intervals, hence distinct roots. Therefore the sign-change count $C_a$ of the slice $f(a,y)$ along $t$ satisfies

$$ C_a\leq d_a. $$

The ordered common positive-statistic slice bound [147_ordered_common_positive_statistic_slice_bound.md](147_ordered_common_positive_statistic_slice_bound.md) gives

$$ H^{\ast}(f) \leq \sum_a C_a+J_{\rho}(f) \leq \sum_a d_a+J_{\rho}(f). $$

Minimizing over $\rho$ proves the second displayed bound.

If $P$ has total degree at most $d$ in $t(y),z_1,\ldots,z_k$, then each raw slice degree satisfies $d_a\leq d$. Hence

$$ \sum_a d_a\leq2^k d, $$

which gives the final bound. $\blacksquare$

## Consequence

Lemma 146 is the worst-case version obtained by using $J_{\rho}(f)\leq2^k-1$.
