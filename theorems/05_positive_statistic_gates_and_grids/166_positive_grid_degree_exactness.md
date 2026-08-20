# Positive Grid Degree And Exactness

## Statement

Use the setup of Theorem 165. Suppose that for each raw level $\nu_r$ there is a univariate polynomial $P_r(v)$ of degree at most $d_r$ such that

$$ \mathrm{sgn}(P_r(t(y)))= \begin{cases} +1 & \text{if } F(\nu_r,t(y))=1,\cr -1 & \text{if } F(\nu_r,t(y))=0 \end{cases} $$

for every $y\in\lbrace0,1\rbrace^{m}$. Let

$$ \delta_r:=\deg_{\pm}\bigl(F(\nu_r,t(y))\bigr). $$

Then

$$ \max_r\delta_r \leq H^{\ast}(f) \leq \sum_{r=0}^{R-1}d_r+J_{\mathrm{grid}}. $$

If $d_r\leq d$ for every $r$, then

$$ H^{\ast}(f)\leq Rd+J_{\mathrm{grid}}. $$

Moreover, if

$$ \deg_{\pm}(f) = \sum_{r=0}^{R-1}C_r+J_{\mathrm{grid}}, $$

then

$$ H^{\ast}(f)=\deg_{\pm}(f). $$

> **Interpretation.** On a positive grid, the upper bound scales with the number of raw statistic levels. It becomes exact whenever threshold degree reaches the grid concatenation cost.

## Proof

The lower bound follows by restricting to a raw assignment at each raw level and using the threshold-degree lower bound:

$$ \delta_r \leq H^{\ast}\bigl(F(\nu_r,t(y))\bigr) \leq H^{\ast}(f). $$

For the upper bound, let $C_r$ be the sign-change count of slice $r$. Since $P_r$ strictly sign-represents that slice, every adjacent sign change along the ordered image of $t$ gives a distinct real root of $P_r$. Hence

$$ C_r\leq d_r. $$

The positive grid slice sandwich [165_positive_grid_slice_sandwich.md](165_positive_grid_slice_sandwich.md) gives

$$ H^{\ast}(f) \leq \sum_r C_r+J_{\mathrm{grid}} \leq \sum_r d_r+J_{\mathrm{grid}}. $$

If $d_r\leq d$ for every $r$, then $\sum_r d_r\leq Rd$.

For exactness, combine the positive grid upper bound

$$ H^{\ast}(f)\leq\sum_r C_r+J_{\mathrm{grid}} $$

with the threshold-degree lower bound

$$ \deg_{\pm}(f)\leq H^{\ast}(f). $$

If the two endpoint quantities are equal, then all inequalities are equalities. $\blacksquare$

## Consequence

Theorem 162 applies directly to positive grids after the raw assignments are compressed into raw statistic levels.
