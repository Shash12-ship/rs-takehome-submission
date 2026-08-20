# Degree-Tight Positive-Statistic Gate Classification

## Statement

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let $T(y)=F(t(y))$ be nonconstant. Let $C$ be the sign-change count of $F$ along the ordered image of $t$. Assume

$$ \deg_{\pm}(T)=C. $$

For any two-input Boolean gate $G$, define

$$ H_G(z,y):=G(z,T(y)). $$

Then

$$ H^{\ast}(H_G)= \begin{cases} 0 & \text{if }G\text{ is constant},\cr 1 & \text{if }G\text{ is a raw-bit literal},\cr C+1 & \text{if }G\text{ is XOR or XNOR},\cr C & \text{otherwise}. \end{cases} $$

> **Interpretation.** Whenever the positive-statistic sign-change upper bound is threshold-degree tight for the feature, the complete one-bit gate table is exact.

## Proof

Constants and raw-bit literals have exact values $0$ and $1$ by the zero-head and one-head classification.

For XOR and XNOR, the positive-statistic fresh-XOR sign-change bound [139_positive_statistic_fresh_xor_sign_change_bound.md](139_positive_statistic_fresh_xor_sign_change_bound.md) gives

$$ H^{\ast}(H_G)\leq C+1. $$

The one-bit gate threshold-degree trichotomy [082_one_bit_gate_threshold_degree_trichotomy.md](../04_recursions_and_cost_invariants/082_one_bit_gate_threshold_degree_trichotomy.md) gives

$$ \deg_{\pm}(H_G)=\deg_{\pm}(T)+1=C+1. $$

Thus XOR and XNOR have exact value $C+1$.

For every remaining nonconstant gate, the positive-statistic non-XOR gate bound [140_positive_statistic_non_xor_gate_sign_change_bound.md](140_positive_statistic_non_xor_gate_sign_change_bound.md) gives

$$ H^{\ast}(H_G)\leq C. $$

The one-bit gate threshold-degree trichotomy gives

$$ \deg_{\pm}(H_G)=\deg_{\pm}(T)=C. $$

Thus these gates have exact value $C$. $\blacksquare$

## Consequence

Internal positive slabs are the case $C=2$. LTF features are the case $C=1$. The same table now applies to every positive-statistic feature whose sign-change count equals its threshold degree.
