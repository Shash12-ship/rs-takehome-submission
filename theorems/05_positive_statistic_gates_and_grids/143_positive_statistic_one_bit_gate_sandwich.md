# Positive-Statistic One-Bit Gate Sandwich

## Statement

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let $T(y)=F(t(y))$ be nonconstant. Let $C$ be the sign-change count of $F$ along the ordered image of $t$, and set

$$ d:=\deg_{\pm}(T). $$

For a two-input gate $G$, define

$$ H_G(z,y):=G(z,T(y)). $$

Then:

1. if $G$ is constant, then $H^{\ast}(H_G)=0$;
2. if $G$ is a raw-bit literal, then $H^{\ast}(H_G)=1$;
3. if $G$ is XOR or XNOR, then

$$ d+1 \leq H^{\ast}(H_G) \leq C+1; $$

4. otherwise,

$$ d \leq H^{\ast}(H_G) \leq C. $$

> **Interpretation.** For one-bit gates over a positive-statistic feature, the only possible gap is the original gap between threshold degree and positive-statistic sign-change count.

## Proof

The constant and raw-bit literal cases are immediate from the zero-head and one-head classification.

If $G$ is XOR or XNOR, Lemma 139 gives the upper bound

$$ H^{\ast}(H_G)\leq C+1, $$

and the one-bit gate threshold-degree trichotomy [082_one_bit_gate_threshold_degree_trichotomy.md](../04_recursions_and_cost_invariants/082_one_bit_gate_threshold_degree_trichotomy.md) gives

$$ \deg_{\pm}(H_G)=d+1. $$

Since $H^{\ast}$ lower-bounds threshold degree, the XOR and XNOR sandwich follows.

For every remaining nonconstant gate, Lemma 140 gives the upper bound

$$ H^{\ast}(H_G)\leq C, $$

and the same trichotomy gives

$$ \deg_{\pm}(H_G)=d. $$

Again using $\deg_{\pm}\leq H^{\ast}$ gives the displayed sandwich. $\blacksquare$

## Consequence

If $C=d$, the sandwich collapses to the exact table of Lemma 141. If $C\gt d$, improving the one-bit gate bounds for $T$ is equivalent to improving the original positive-statistic sign-change upper bound for $T$.
