# Positive Grid Cost Invariant

## Statement

For a fixed split $(z,y)$, define $\mathrm{pgc}_{+}^{z\mid y}(f)$ to be the minimum of

$$ \sum_{r=0}^{R-1}C_r+J_{\mathrm{grid}} $$

over all positive-grid certificates

$$ u(z)=\sum_j\rho_jz_j, \qquad t(y)=\sum_i\lambda_i y_i, \qquad \rho_j,\lambda_i\gt0, $$

and all functions $F$ such that

$$ f(z,y)=F(u(z),t(y)). $$

Here $C_r$ and $J_{\mathrm{grid}}$ are the raw-level slice variation and endpoint-jump terms from Theorem 165. Then

$$ H^{\ast}(f)\leq\mathrm{pgc}_{+}^{z\mid y}(f). $$

Moreover, if $C_{+}(f)$ denotes the optimized positive-projection sign-change count, then

$$ C_{+}(f)\leq\mathrm{pgc}_{+}^{z\mid y}(f). $$

The cost $\mathrm{pgc}_{+}^{z\mid y}$ is invariant under output complement, raw-coordinate permutation, and feature-coordinate permutation.

Finally, if

$$ \deg_{\pm}(f)=\mathrm{pgc}_{+}^{z\mid y}(f), $$

then

$$ H^{\ast}(f)=\deg_{\pm}(f)=\mathrm{pgc}_{+}^{z\mid y}(f). $$

> **Interpretation.** Positive-grid cost is an optimized split invariant. It can be much smaller than raw-assignment slice cost when many raw assignments share one raw statistic level.

## Proof

For any fixed positive-grid certificate, Theorem 165 gives

$$ H^{\ast}(f)\leq\sum_r C_r+J_{\mathrm{grid}}. $$

Minimizing over certificates proves

$$ H^{\ast}(f)\leq\mathrm{pgc}_{+}^{z\mid y}(f). $$

The proof of Theorem 165 constructs a single positive statistic

$$ s(z,y)=Ku(z)+t(y) $$

whose ordered label sequence has exactly

$$ \sum_r C_r+J_{\mathrm{grid}} $$

sign changes. Therefore the optimized positive-projection sign-change count satisfies

$$ C_{+}(f)\leq\sum_r C_r+J_{\mathrm{grid}} $$

for every grid certificate. Taking the minimum gives

$$ C_{+}(f)\leq\mathrm{pgc}_{+}^{z\mid y}(f). $$

For output complement, the same grid certificates remain feasible, and replacing $F$ by $1-F$ preserves every within-level sign-change count and every endpoint-jump count. Hence the cost is unchanged.

Raw-coordinate and feature-coordinate permutations transport positive statistics by permuting their positive coefficients. The grid images, slice sign-change counts, and endpoint jumps are unchanged after relabeling. Thus the optimized cost is invariant under those permutations.

If $\deg_{\pm}(f)=\mathrm{pgc}_{+}^{z\mid y}(f)$, then the threshold-degree lower bound gives

$$ \mathrm{pgc}_{+}^{z\mid y}(f) = \deg_{\pm}(f) \leq H^{\ast}(f) \leq \mathrm{pgc}_{+}^{z\mid y}(f), $$

so equality holds throughout. $\blacksquare$

## Consequence

Theorem 166 can be restated as a certificate-level exactness theorem for $\mathrm{pgc}_{+}^{z\mid y}$.
