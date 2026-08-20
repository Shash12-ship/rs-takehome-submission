# Sparse-Slice Endpoint-Coupled Bound

## Statement

Let $f(z,y)$ have a shared positive-statistic certificate as in Theorem 158. Let

$$ A:=\lbrace a\in\lbrace0,1\rbrace^{k}:F_a(t(y))\text{ is nonconstant}\rbrace $$

be the active raw-slice set. Let $C_a$ be the sign-change count of slice $a$, and define the endpoint raw functions $p,q$ as in Theorem 158. Then

$$ \max_{a\in A}H^{\ast}\bigl(F_a(t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{a\in A}C_a+B_{+}(p,q). $$

In particular, if every active slice has at most $C_{\max}$ sign changes, then

$$ H^{\ast}(f)\leq \lvert A\rvert C_{\max}+B_{+}(p,q). $$

If all slices share one endpoint background label $b$, then

$$ \max_{a\in A}H^{\ast}\bigl(F_a(t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{a\in A}C_a \leq \lvert A\rvert C_{\max}. $$

If each active slice has a univariate sign polynomial in $t$ of degree at most $d_a$, then

$$ \max_{a\in A}\deg_{\pm}\bigl(F_a(t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{a\in A}d_a+B_{+}(p,q), $$

with the $B_{+}$ term vanishing in the common-endpoint case.

> **Interpretation.** A shared-statistic function with only a few nonconstant raw slices has head complexity controlled by the active slices plus endpoint coupling, independent of the total number of raw assignments except through the endpoint boundary.

## Proof

Constant slices have sign-change count $0$ and head complexity $0$. Therefore the lower and upper bounds from Theorem 158 reduce to

$$ \max_{a\in A}H^{\ast}\bigl(F_a(t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{a\in A}C_a+B_{+}(p,q). $$

If $C_a\leq C_{\max}$ for every active slice, then

$$ \sum_{a\in A}C_a\leq \lvert A\rvert C_{\max}. $$

If all slices share one endpoint background label $b$, then Theorem 158 gives $B_{+}(p,q)=0$, proving the common-endpoint bound.

For the degree version, constant slices have degree $0$. Applying Theorem 159 and omitting the zero contributions from inactive slices gives

$$ \max_{a\in A}\deg_{\pm}\bigl(F_a(t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{a\in A}d_a+B_{+}(p,q). $$

Again, common endpoints make the endpoint-coupling term vanish. $\blacksquare$

## Consequence

This theorem is the sparse-slice analogue of sparse support: the cost is governed by the number and complexity of active raw slices, not by all $2^k$ raw slices.
