# Positive Mixed Boundary Gate Bound

## Statement

For raw functions

$$ p,q:\lbrace0,1\rbrace^{k}\to\lbrace0,1\rbrace, $$

and positive raw weights $\rho_1,\ldots,\rho_k$ with distinct subset sums, order the raw assignments as

$$ a^{(0)},a^{(1)},\ldots,a^{(2^k-1)} $$

by increasing value of $\sum_j\rho_j a_j$. Define the mixed boundary count

$$ B_{\rho}(p,q) := \left\lvert \left\lbrace r\in\lbrace0,\ldots,2^k-2\rbrace: p(a^{(r)})\neq q(a^{(r+1)}) \right\rbrace \right\rvert, $$

and the optimized positive mixed boundary cost

$$ B_{+}(p,q):=\min_{\rho}B_{\rho}(p,q). $$

Now let

$$ T(y)=F(t(y)), \qquad t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

with image

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}. $$

Let $C$ be the sign-change count of $F$ along this image, and put

$$ e_{\min}:=F(\tau_0), \qquad e_{\max}:=F(\tau_{M-1}). $$

For a Boolean gate

$$ G:\lbrace0,1\rbrace^{k}\times\lbrace0,1\rbrace\to\lbrace0,1\rbrace, $$

write

$$ g_e(a):=G(a,e) \qquad \text{for }e\in\lbrace0,1\rbrace, $$

and let

$$ N_G:=\left\lvert\lbrace a:g_0(a)\neq g_1(a)\rbrace\right\rvert. $$

Then

$$ H^{\ast}\bigl(G(z,T(y))\bigr) \leq N_G C+B_{+}(g_{e_{\max}},g_{e_{\min}}). $$

> **Interpretation.** For a multi-raw gate over one positive-statistic feature, the boundary term depends only on the two endpoint raw functions seen at the end and the beginning of each feature slice.

## Proof

Fix a positive raw order $\rho$. For a raw assignment $a$, the slice

$$ G(a,T(y)) $$

is constant unless $g_0(a)\neq g_1(a)$. If it is not constant, it is either $T(y)$ or $1-T(y)$, and hence contributes exactly $C$ sign changes along $t$. Thus the total within-slice contribution is $N_GC$.

For two consecutive raw assignments $a^{(r)}$ and $a^{(r+1)}$, the label at the end of the first slice is

$$ G(a^{(r)},e_{\max})=g_{e_{\max}}(a^{(r)}), $$

and the label at the beginning of the next slice is

$$ G(a^{(r+1)},e_{\min})=g_{e_{\min}}(a^{(r+1)}). $$

Therefore the boundary contribution is exactly

$$ B_{\rho}(g_{e_{\max}},g_{e_{\min}}). $$

Applying the ordered common positive-statistic slice bound [147_ordered_common_positive_statistic_slice_bound.md](147_ordered_common_positive_statistic_slice_bound.md) gives

$$ H^{\ast}\bigl(G(z,T(y))\bigr) \leq N_GC+B_{\rho}(g_{e_{\max}},g_{e_{\min}}). $$

Minimizing over $\rho$ proves the claim. $\blacksquare$

## Consequence

Lemma 148 is the same estimate with a fixed raw order. This lemma isolates the part of the bound that can be improved by changing the positive order on the raw block.
