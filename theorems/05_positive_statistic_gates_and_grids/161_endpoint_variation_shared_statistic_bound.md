# Endpoint Variation Shared-Statistic Bound

## Statement

Use the setup of Theorem 158. Thus every raw slice factors through one positive statistic:

$$ f(a,y)=F_a(t(y)), \qquad t(y)=\sum_i\lambda_i y_i, \qquad \lambda_i\gt0. $$

Let $C_a$ be the sign-change count of $F_a$ along the ordered image of $t$, and define endpoint raw functions

$$ q(a):=F_a(\tau_0), \qquad p(a):=F_a(\tau_{M-1}). $$

Then

$$ H^{\ast}(f) \leq \sum_a C_a+\min\lbrace C_{+}(p),C_{+}(q)\rbrace+D(p,q), $$

where

$$ D(p,q):=\left\lvert\lbrace a:p(a)\neq q(a)\rbrace\right\rvert. $$

Moreover, suppose $p$ has a positive raw order in which its true set has $q_p$ intervals and endpoint labels $\epsilon^p_0,\epsilon^p_1$. Define

$$ K_p:= \begin{cases} 0, & q_p=0,\cr 2q_p-\epsilon^p_0-\epsilon^p_1, & q_p\geq1. \end{cases} $$

Define $K_q$ analogously if $q$ has such a run certificate. If both certificates are available, then

$$ H^{\ast}(f) \leq \sum_a C_a+\min\lbrace K_p,K_q\rbrace+D(p,q). $$

> **Interpretation.** The endpoint coupling can be bounded by ordinary raw endpoint variation plus the number of slices whose two endpoints disagree. Few-run endpoint functions give a concrete version of the bound.

## Proof

The shared-statistic slice sandwich [158_shared_statistic_slice_sandwich.md](158_shared_statistic_slice_sandwich.md) gives

$$ H^{\ast}(f) \leq \sum_a C_a+B_{+}(p,q). $$

The mixed boundary inequality [153_mixed_boundary_inequality.md](153_mixed_boundary_inequality.md) gives

$$ B_{+}(p,q) \leq \min\lbrace C_{+}(p),C_{+}(q)\rbrace+D(p,q). $$

Substituting proves the first bound.

For the few-run version, Theorem 157 applied to the raw endpoint functions gives

$$ C_{+}(p)\leq K_p, \qquad C_{+}(q)\leq K_q. $$

Thus

$$ \min\lbrace C_{+}(p),C_{+}(q)\rbrace\leq\min\lbrace K_p,K_q\rbrace. $$

Substitute this into the first bound. $\blacksquare$

## Consequence

Theorem 158 is strongest when $B_{+}(p,q)$ is computed exactly. This theorem gives a practical fallback using only endpoint run counts and endpoint disagreement.
