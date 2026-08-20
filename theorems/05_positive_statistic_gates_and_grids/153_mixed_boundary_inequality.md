# Mixed Boundary Inequality

## Statement

For raw functions

$$ p,q:\lbrace0,1\rbrace^{k}\to\lbrace0,1\rbrace, $$

let

$$ D(p,q):= \left\lvert \lbrace a\in\lbrace0,1\rbrace^{k}:p(a)\neq q(a)\rbrace \right\rvert. $$

Then

$$ B_{+}(p,q) \leq \min\lbrace C_{+}(p),C_{+}(q)\rbrace+D(p,q), $$

where $B_{+}$ is the optimized positive mixed boundary cost from Lemma 151 and $C_{+}$ is the optimized positive-order sign-change count of a raw function.

Consequently, in the setup of Lemma 151, if $F(\tau_0)\neq F(\tau_{M-1})$, then

$$ H^{\ast}\bigl(G(z,T(y))\bigr) \leq N_G C+\min\lbrace C_{+}(g_0),C_{+}(g_1)\rbrace+N_G. $$

> **Interpretation.** A mixed endpoint boundary can be paid for by ordinary raw variation plus the number of raw assignments where the gate really depends on the feature bit.

## Proof

Fix a positive raw order $\rho$ that realizes $C_{+}(p)$. Write the ordered raw assignments as

$$ a^{(0)},a^{(1)},\ldots,a^{(2^k-1)}. $$

If

$$ p(a^{(r)})\neq q(a^{(r+1)}), $$

then at least one of the following two events holds:

$$ p(a^{(r)})\neq p(a^{(r+1)}), \qquad p(a^{(r+1)})\neq q(a^{(r+1)}). $$

The first event occurs for exactly $C_{+}(p)$ values of $r$. The second event occurs for at most $D(p,q)$ values of $r$, because each vertex $a^{(r+1)}$ appears as the right endpoint of at most one boundary. Therefore

$$ B_{+}(p,q)\leq B_{\rho}(p,q)\leq C_{+}(p)+D(p,q). $$

The same argument with a raw order realizing $C_{+}(q)$ uses the implication

$$ p(a^{(r)})\neq q(a^{(r+1)}) \quad\Longrightarrow\quad q(a^{(r)})\neq q(a^{(r+1)}) \ \text{or}\ p(a^{(r)})\neq q(a^{(r)}), $$

and gives

$$ B_{+}(p,q)\leq C_{+}(q)+D(p,q). $$

Taking the smaller of the two upper bounds proves the first claim.

For the gate consequence, apply Lemma 151 with the endpoint pair $g_1,g_0$ or $g_0,g_1$. The pointwise distance between $g_0$ and $g_1$ is

$$ D(g_0,g_1)=N_G, $$

by the definition of $N_G$. Substituting the mixed boundary inequality gives the displayed bound. $\blacksquare$

## Consequence

This gives a useful fallback when the feature has odd endpoint parity. The cost is at most one extra unit for each raw slice where the gate depends on the feature, plus the easier of the two endpoint raw variations.
