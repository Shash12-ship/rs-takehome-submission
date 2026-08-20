# Few-Run Raw-Mask Gate Theorem

## Statement

Let $R:\lbrace0,1\rbrace^{k}\to\lbrace0,1\rbrace$ be a raw mask. Suppose there is a positive raw statistic

$$ s(z)=\sum_{j=1}^{k}\rho_jz_j, \qquad \rho_j\gt0, $$

with distinct subset sums, such that the ordered truth sequence of $R$ along $s$ has $q$ true intervals. Let

$$ \epsilon_0:=R(a^{(0)}), \qquad \epsilon_1:=R(a^{(2^k-1)}), $$

where

$$ a^{(0)},a^{(1)},\ldots,a^{(2^k-1)} $$

is the raw order induced by $s$. Define

$$ K_R:= \begin{cases} 0, & q=0,\cr 2q-\epsilon_0-\epsilon_1, & q\geq1. \end{cases} $$

Then

$$ C_{+}(R)\leq K_R\leq2q. $$

Now let

$$ T(y)=F(t(y)) $$

be a positive-statistic feature with sign-change count $C$ and endpoint labels

$$ e_0:=F(\tau_0), \qquad e_1:=F(\tau_{M-1}). $$

Put

$$ r_1:=\lvert R^{-1}(1)\rvert, \qquad r_0:=\lvert R^{-1}(0)\rvert. $$

For $A=R\wedge T$,

$$ H^{\ast}(A)\leq \begin{cases} r_1C, & e_0=e_1=0,\cr r_1C+K_R, & e_0=e_1=1,\cr r_1(C+1), & e_0\neq e_1. \end{cases} $$

For $O=R\vee T$,

$$ H^{\ast}(O)\leq \begin{cases} r_0C, & e_0=e_1=1,\cr r_0C+K_R, & e_0=e_1=0,\cr r_0(C+1), & e_0\neq e_1. \end{cases} $$

For $X=R\oplus T$,

$$ H^{\ast}(X)\leq \begin{cases} 2^kC+K_R, & e_0=e_1,\cr 2^k(C+1)+K_R, & e_0\neq e_1. \end{cases} $$

> **Interpretation.** If the raw mask has few runs in some positive raw order, the raw-boundary term in the mask-gate theorem is controlled by that run count. Endpoint masks have $K_R\leq1$, and one-interval masks have $K_R\leq2$.

## Proof

Along the chosen raw order, each true interval contributes one upward transition unless it begins at the first ordered point, and one downward transition unless it ends at the last ordered point. Therefore the sign-change count of $R$ along this order is

$$ K_R= \begin{cases} 0, & q=0,\cr 2q-\epsilon_0-\epsilon_1, & q\geq1. \end{cases} $$

Since $C_{+}(R)$ is the minimum positive-order sign-change count over all positive raw statistics, this gives

$$ C_{+}(R)\leq K_R. $$

The inequality $K_R\leq2q$ is immediate.

Apply the raw-mask endpoint bounds [154_raw_mask_gate_endpoint_bounds.md](154_raw_mask_gate_endpoint_bounds.md). The only occurrence of the raw positive-order cost there is

$$ C_R=C_{+}(R). $$

Replacing $C_R$ by the upper bound $K_R$ gives all three displayed bounds. $\blacksquare$

## Consequence

This theorem converts Lemma 154 into a concrete bound for raw masks with low positive-order alternation. It is most useful when the raw mask is a positive endpoint, a positive interval, or a small union of such intervals.
