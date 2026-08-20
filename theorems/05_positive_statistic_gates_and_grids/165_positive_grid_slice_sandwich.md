# Positive Grid Slice Sandwich

## Statement

Let $z\in\lbrace0,1\rbrace^{k}$ and $y\in\lbrace0,1\rbrace^{m}$. Let

$$ u(z)=\sum_{j=1}^{k}\rho_j z_j, \qquad \rho_j\gt0, $$

and

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0. $$

Write the image of $u$ as

$$ \nu_0\lt\nu_1\lt\cdots\lt\nu_{R-1}, $$

and the image of $t$ as

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}. $$

Suppose $f(z,y)$ factors through the positive grid:

$$ f(z,y)=F(u(z),t(y)). $$

For each raw level $\nu_r$, let $C_r$ be the sign-change count of

$$ \tau\mapsto F(\nu_r,\tau) $$

along $\tau_0,\ldots,\tau_{M-1}$. Let

$$ J_{\mathrm{grid}} := \left\lvert \left\lbrace r\in\lbrace0,\ldots,R-2\rbrace: F(\nu_r,\tau_{M-1})\neq F(\nu_{r+1},\tau_0) \right\rbrace \right\rvert. $$

Then

$$ \max_{0\leq r\lt R}H^{\ast}\bigl(F(\nu_r,t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{r=0}^{R-1}C_r+J_{\mathrm{grid}}. $$

> **Interpretation.** If the raw block itself factors through one positive statistic, the construction pays per raw level, not per raw assignment.

## Proof

The lower bound follows from restriction monotonicity. For any raw level $\nu_r$, choose a raw assignment $a_r$ with $u(a_r)=\nu_r$. Restricting $f$ to $z=a_r$ gives

$$ y\mapsto F(\nu_r,t(y)). $$

Thus

$$ H^{\ast}\bigl(F(\nu_r,t(y))\bigr)\leq H^{\ast}(f) $$

for every $r$.

For the upper bound, let

$$ \Lambda:=\sum_{i=1}^{m}\lambda_i, $$

and let

$$ \Delta:=\min_{0\leq r\lt R-1}(\nu_{r+1}-\nu_r)\gt0. $$

Choose

$$ K\gt\frac{\Lambda}{\Delta}, $$

and define one positive statistic on the combined variables:

$$ s(z,y):=Ku(z)+t(y). $$

For a fixed raw level $\nu_r$, the values of $s$ lie in

$$ [K\nu_r,K\nu_r+\Lambda]. $$

The choice of $K$ makes these intervals disjoint and ordered by $r$. Therefore the ordered label sequence of $f$ along $s$ is the concatenation of the $R$ raw-level slice sequences:

$$ F(\nu_0,\tau_0),\ldots,F(\nu_0,\tau_{M-1}), F(\nu_1,\tau_0),\ldots,F(\nu_1,\tau_{M-1}), \ldots, F(\nu_{R-1},\tau_0),\ldots,F(\nu_{R-1},\tau_{M-1}). $$

The number of sign changes in this concatenated sequence is exactly

$$ \sum_{r=0}^{R-1}C_r+J_{\mathrm{grid}}. $$

Applying the positive-projection sign-change upper bound [013_positive_projection_sign_changes.md](../01_foundations_and_normal_form/013_positive_projection_sign_changes.md) to $s$ gives

$$ H^{\ast}(f)\leq\sum_r C_r+J_{\mathrm{grid}}. $$

$\blacksquare$

## Consequence

This theorem can be much stronger than the raw-assignment slice theorem when many raw assignments share the same raw statistic value.
