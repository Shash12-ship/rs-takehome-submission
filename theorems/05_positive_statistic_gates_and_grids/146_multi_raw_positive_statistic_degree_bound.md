# Multi-Raw Positive-Statistic Degree Bound

## Statement

Let $k\geq0$, let $z\in\lbrace0,1\rbrace^{k}$ be raw bits, and let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0. $$

Suppose $P(z,y)$ is a strict sign polynomial for a Boolean function $f(z,y)$, and suppose that for each raw assignment $a\in\lbrace0,1\rbrace^{k}$, the slice

$$ P_a(u):=P(a,y)\quad\text{with }u=t(y) $$

is a univariate polynomial in $u$ of degree at most $d_a$. Then

$$ H^{\ast}(f) \leq \sum_{a\in\lbrace0,1\rbrace^{k}} d_a + 2^{k}-1. $$

In particular, if $P$ has degree at most $d$ in the quantities $t(y),z_1,\ldots,z_k$, reduced multilinearly in the raw bits, then

$$ H^{\ast}(f)\leq 2^{k}(d+1)-1. $$

> **Interpretation.** A bounded-degree threshold in one positive statistic and $k$ raw bits has a head bound exponential only in the number of raw bits, and independent of the number of feature variables.

## Proof

Fix a raw assignment $a$. Since $P$ strictly sign-represents $f$, the slice polynomial $P_a$ is nonzero on every point of the ordered image of $t$. If the sign of $P_a$ changes between two consecutive image points, the intermediate value theorem gives a real root of $P_a$ between those two points. Distinct adjacent sign changes give distinct open intervals, hence distinct roots. Therefore the sign-change count $C_a$ of the slice $f(a,y)$ along $t$ satisfies

$$ C_a\leq d_a. $$

The common positive-statistic multi-slice bound [145_common_positive_statistic_multi_slice_bound.md](145_common_positive_statistic_multi_slice_bound.md) gives

$$ H^{\ast}(f) \leq \sum_{a\in\lbrace0,1\rbrace^{k}}C_a + 2^k-1 \leq \sum_{a\in\lbrace0,1\rbrace^{k}}d_a + 2^k-1. $$

If $P$ has total degree at most $d$ in $t(y),z_1,\ldots,z_k$, then every raw slice has degree at most $d$, so

$$ \sum_{a\in\lbrace0,1\rbrace^{k}}d_a\leq2^k d. $$

This gives

$$ H^{\ast}(f)\leq2^k d+2^k-1=2^k(d+1)-1. $$

$\blacksquare$

## Consequence

For fixed raw-bit count $k$ and fixed degree $d$, this is a dimension-free head bound for all functions whose dependence on the remaining variables factors through one positive statistic. It is weaker than Lemma 138 when $k=1$, but it applies to arbitrary many unrelated raw slices.
