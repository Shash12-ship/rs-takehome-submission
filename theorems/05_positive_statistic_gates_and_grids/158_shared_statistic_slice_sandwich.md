# Shared-Statistic Slice Sandwich

## Statement

Let $k\geq1$, let $z\in\lbrace0,1\rbrace^{k}$ be raw bits, and let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0. $$

Write the image of $t$ as

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}. $$

Suppose every raw slice of $f(z,y)$ factors through $t$:

$$ f(a,y)=F_a(t(y)) \qquad \text{for every }a\in\lbrace0,1\rbrace^{k}. $$

Let $C_a$ be the sign-change count of $F_a$ along $\tau_0,\ldots,\tau_{M-1}$. Define the endpoint raw functions

$$ q(a):=F_a(\tau_0), \qquad p(a):=F_a(\tau_{M-1}). $$

Then

$$ \max_{a\in\lbrace0,1\rbrace^{k}}H^{\ast}\bigl(F_a(t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{a\in\lbrace0,1\rbrace^{k}}C_a+B_{+}(p,q). $$

In particular, if there is a label $b\in\lbrace0,1\rbrace$ such that

$$ F_a(\tau_0)=F_a(\tau_{M-1})=b \qquad \text{for every }a, $$

then

$$ \max_a H^{\ast}\bigl(F_a(t(y))\bigr) \leq H^{\ast}(f) \leq \sum_a C_a. $$

If, moreover, exactly one raw slice is nonconstant and that slice satisfies $H^{\ast}(F_a(t(y)))=C_a$, then

$$ H^{\ast}(f)=C_a. $$

> **Interpretation.** For arbitrary raw slices sharing one positive statistic, the only price beyond within-slice variation is the optimized mixed endpoint boundary. Common endpoints remove the boundary price entirely.

## Proof

The lower bound follows from restriction monotonicity. For any raw assignment $a$, fixing $z=a$ restricts $f$ to the slice

$$ y\mapsto F_a(t(y)). $$

Therefore

$$ H^{\ast}\bigl(F_a(t(y))\bigr)\leq H^{\ast}(f) $$

for every $a$, and taking the maximum gives the displayed lower bound.

For the upper bound, fix any positive raw order $\rho$. The ordered common positive-statistic slice bound [147_ordered_common_positive_statistic_slice_bound.md](147_ordered_common_positive_statistic_slice_bound.md) gives

$$ H^{\ast}(f)\leq \sum_a C_a+J_{\rho}(f). $$

For this order, the boundary term is exactly

$$ J_{\rho}(f)=B_{\rho}(p,q), $$

because the end label of slice $a$ is $p(a)$ and the start label of slice $a'$ is $q(a')$. Minimizing over positive raw orders gives

$$ H^{\ast}(f) \leq \sum_a C_a+B_{+}(p,q). $$

If all slice endpoints are the same label $b$, then $p=q=b$ is constant, so

$$ B_{+}(p,q)=0. $$

This proves the common-endpoint bracket.

If exactly one raw slice is nonconstant, say slice $a$, then all other $C_{a'}$ vanish. The common-endpoint upper bound gives

$$ H^{\ast}(f)\leq C_a. $$

The lower bound gives

$$ H^{\ast}(f)\geq H^{\ast}\bigl(F_a(t(y))\bigr)=C_a. $$

Thus equality holds. $\blacksquare$

## Consequence

Theorem 155 is the gate-specialized case where every slice is constant, $T$, or $1-T$. This theorem keeps the same mechanism available for arbitrary raw-slice families sharing one positive statistic.
