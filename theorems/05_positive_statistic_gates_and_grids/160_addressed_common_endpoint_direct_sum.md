# Addressed Common-Endpoint Direct Sum

## Statement

Let $A\subseteq\lbrace0,1\rbrace^{k}$ be a set of raw addresses. Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

with ordered image

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}. $$

For each $a\in A$, let

$$ T_a(y)=F_a(t(y)) $$

be a positive-statistic feature with sign-change count $C_a$. Suppose there is a common background label $b\in\lbrace0,1\rbrace$ such that

$$ F_a(\tau_0)=F_a(\tau_{M-1})=b \qquad \text{for every }a\in A. $$

Define a function $f_A(z,y)$ by

$$ f_A(a,y)=T_a(y) \quad\text{for }a\in A, \qquad f_A(a,y)=b \quad\text{for }a\notin A. $$

Then

$$ \max_{a\in A}H^{\ast}(T_a) \leq H^{\ast}(f_A) \leq \sum_{a\in A}C_a. $$

Consequently, if $A=\lbrace a_0\rbrace$ and $H^{\ast}(T_{a_0})=C_{a_0}$, then

$$ H^{\ast}(f_A)=C_{a_0}. $$

More generally, if each $T_a$ has a univariate sign polynomial in $t$ of degree at most $d_a$, then

$$ \max_{a\in A}\deg_{\pm}(T_a) \leq H^{\ast}(f_A) \leq \sum_{a\in A}d_a. $$

> **Interpretation.** Several features with the same endpoint background can be placed at disjoint raw addresses with additive head cost and no boundary penalty. A single addressed exact feature stays exact.

## Proof

Extend the slice family to every raw assignment by setting

$$ F_a(u):=b \qquad \text{for }a\notin A. $$

Every slice now factors through the same positive statistic $t$. The endpoint labels of every slice are $b$, and the constant background slices have sign-change count $0$.

The shared-statistic slice sandwich [158_shared_statistic_slice_sandwich.md](158_shared_statistic_slice_sandwich.md) gives

$$ \max_a H^{\ast}\bigl(F_a(t(y))\bigr) \leq H^{\ast}(f_A) \leq \sum_a C_a. $$

The maximum and sum ignore the constant background slices, so this is exactly

$$ \max_{a\in A}H^{\ast}(T_a) \leq H^{\ast}(f_A) \leq \sum_{a\in A}C_a. $$

If $A=\lbrace a_0\rbrace$ and $H^{\ast}(T_{a_0})=C_{a_0}$, the two sides match.

For the degree version, apply the shared-statistic degree sandwich [159_shared_statistic_degree_sandwich.md](159_shared_statistic_degree_sandwich.md). The constant background slices have degree $0$, so only the addresses in $A$ contribute to the upper bound, and the lower bound is the maximum threshold degree among the addressed slices. $\blacksquare$

## Consequence

Theorem 156 is the single-address case with one feature. The present theorem allows many addressed features, provided they share the same positive statistic and the same endpoint background.
