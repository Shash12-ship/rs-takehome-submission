# Equal-Endpoint Multi-Raw Gate Bound

## Statement

Use the setup of Lemma 151. Suppose the positive-statistic feature has equal endpoint values:

$$ F(\tau_0)=F(\tau_{M-1})=e. $$

Let $g_e(a):=G(a,e)$, and let

$$ C_{+}(g_e) := \min_{\rho} \left\lvert \left\lbrace r\in\lbrace0,\ldots,2^k-2\rbrace: g_e(a^{(r)})\neq g_e(a^{(r+1)}) \right\rbrace \right\rvert $$

be the optimized positive-order sign-change count of the raw endpoint function. Then

$$ H^{\ast}\bigl(G(z,T(y))\bigr) \leq N_G C+C_{+}(g_e). $$

> **Interpretation.** When the feature begins and ends with the same value, repeated raw slices can be joined at a cost equal to the raw endpoint variation.

## Proof

Since the endpoints are both $e$, Lemma 151 gives

$$ H^{\ast}\bigl(G(z,T(y))\bigr) \leq N_G C+B_{+}(g_e,g_e). $$

For every positive raw order $\rho$,

$$ B_{\rho}(g_e,g_e) = \left\lvert \left\lbrace r:g_e(a^{(r)})\neq g_e(a^{(r+1)}) \right\rbrace \right\rvert. $$

Minimizing over $\rho$ gives

$$ B_{+}(g_e,g_e)=C_{+}(g_e). $$

Substituting this identity proves the bound. $\blacksquare$

## Consequence

If $T$ is nonconstant, the hypothesis holds exactly when its sign-change count $C$ is even. In that case, the boundary term is a raw positive-order invariant rather than a worst-case $2^k-1$ term.
