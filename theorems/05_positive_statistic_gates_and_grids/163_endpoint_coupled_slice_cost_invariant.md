# Endpoint-Coupled Slice Cost Invariant

## Statement

For a fixed split of variables $(z,y)$ with $z\in\lbrace0,1\rbrace^{k}$, define the endpoint-coupled positive slice cost

$$ \mathrm{eps}_{+}^{z\mid y}(f) := \min_t \left( \sum_{a\in\lbrace0,1\rbrace^{k}} C_a(t)+B_{+}(p_t,q_t) \right), $$

where $t(y)=\sum_i\lambda_i y_i$ ranges over all positive statistics through which every raw slice factors,

$$ f(a,y)=F_{a,t}(t(y)), $$

$C_a(t)$ is the sign-change count of $F_{a,t}$ along the ordered image of $t$, and

$$ q_t(a):=F_{a,t}(\tau_0), \qquad p_t(a):=F_{a,t}(\tau_{M-1}). $$

Then

$$ H^{\ast}(f)\leq \mathrm{eps}_{+}^{z\mid y}(f). $$

Moreover,

$$ \mathrm{eps}_{+}^{z\mid y}(f) \leq \mathrm{osc}_{+}^{z\mid y}(f), $$

where $\mathrm{osc}_{+}^{z\mid y}$ is the optimized ordered-slice cost from Lemma 149.

The cost is invariant under output complement:

$$ \mathrm{eps}_{+}^{z\mid y}(1-f) = \mathrm{eps}_{+}^{z\mid y}(f). $$

It is also invariant under permutations of the raw coordinates and under permutations of the feature coordinates.

> **Interpretation.** The optimized endpoint-coupled cost is a sharper split invariant than the ordered-slice cost because it optimizes the endpoint boundary separately from the within-slice statistic.

## Proof

The upper bound is Theorem 158, minimized over all shared positive-statistic certificates.

For the comparison with $\mathrm{osc}_{+}^{z\mid y}$, fix a certificate $t$ and a positive raw order $\rho$. The ordered-slice boundary for this pair is

$$ J_{t,\rho}(f)=B_{\rho}(p_t,q_t). $$

Since

$$ B_{+}(p_t,q_t)\leq B_{\rho}(p_t,q_t), $$

we have

$$ \sum_a C_a(t)+B_{+}(p_t,q_t) \leq \sum_a C_a(t)+J_{t,\rho}(f). $$

Minimizing the left side over $t$ and the right side over $t,\rho$ gives

$$ \mathrm{eps}_{+}^{z\mid y}(f) \leq \mathrm{osc}_{+}^{z\mid y}(f). $$

For output complement, the same certificates $t$ are feasible. Replacing each slice $F_{a,t}$ by $1-F_{a,t}$ preserves the within-slice sign-change counts. The endpoint functions become $1-p_t$ and $1-q_t$. For any raw order,

$$ (1-p_t)(a^{(r)})\neq(1-q_t)(a^{(r+1)}) \quad\Longleftrightarrow\quad p_t(a^{(r)})\neq q_t(a^{(r+1)}), $$

so

$$ B_{+}(1-p_t,1-q_t)=B_{+}(p_t,q_t). $$

Thus each certificate has the same cost for $f$ and $1-f$, and the minima are equal.

Raw coordinate permutations simply relabel the raw assignments and transport positive raw orders by permuting their weights. Feature coordinate permutations transport each positive statistic by the same permutation of coefficients. In both cases the feasible certificate costs are unchanged. $\blacksquare$

## Consequence

Theorem 162 can be restated as: if $\deg_{\pm}(f)=\mathrm{eps}_{+}^{z\mid y}(f)$ for some split, then $H^{\ast}(f)$ is exactly this endpoint-coupled slice cost.
