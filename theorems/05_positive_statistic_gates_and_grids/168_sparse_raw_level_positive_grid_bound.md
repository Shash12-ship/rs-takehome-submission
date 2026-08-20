# Sparse Raw-Level Positive Grid Bound

## Statement

Use the positive grid setup of Theorem 165. Let

$$ A:=\lbrace r\in\lbrace0,\ldots,R-1\rbrace:F(\nu_r,t(y))\text{ is nonconstant}\rbrace $$

be the active raw-level set. Then

$$ \max_{r\in A}H^{\ast}\bigl(F(\nu_r,t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{r\in A}C_r+J_{\mathrm{grid}}. $$

If each active raw-level slice has at most $C_{\max}$ sign changes, then

$$ H^{\ast}(f)\leq \lvert A\rvert C_{\max}+J_{\mathrm{grid}}. $$

If all raw-level slices share one endpoint background label $b$,

$$ F(\nu_r,\tau_0)=F(\nu_r,\tau_{M-1})=b \qquad \text{for every }r, $$

then

$$ \max_{r\in A}H^{\ast}\bigl(F(\nu_r,t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{r\in A}C_r. $$

The analogous degree bound replaces $C_r$ by univariate slice sign degrees $d_r$.

> **Interpretation.** If only a few raw statistic levels are active, the positive grid bound pays for those levels rather than for the whole raw block.

## Proof

Constant raw-level slices have sign-change count $0$ and head complexity $0$. Therefore the lower and upper bounds from Theorem 165 reduce to

$$ \max_{r\in A}H^{\ast}\bigl(F(\nu_r,t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{r\in A}C_r+J_{\mathrm{grid}}. $$

If $C_r\leq C_{\max}$ for every active level, then

$$ \sum_{r\in A}C_r\leq\lvert A\rvert C_{\max}. $$

If all raw-level slices share the endpoint background label $b$, then every boundary between consecutive raw levels has equal labels at the join. Hence

$$ J_{\mathrm{grid}}=0, $$

which gives the common-endpoint bound.

The degree version follows from [166_positive_grid_degree_exactness.md](166_positive_grid_degree_exactness.md) after omitting constant levels, whose degree contribution is $0$. $\blacksquare$

## Consequence

Theorem 164 pays for active raw assignments. This theorem pays only for active raw statistic levels, which can be exponentially fewer.
