# Parity-Block Threshold-Degree Amplifier

## Statement

Let

$$ T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace $$

be any Boolean function, and let

$$ \pi_k(z):=\bigoplus_{j=1}^{k}z_j \qquad (z\in\lbrace0,1\rbrace^{k}). $$

Define

$$ F(z,y):=\pi_k(z)\oplus T(y). $$

Then

$$ \deg_{\pm}(F)=\deg_{\pm}(T)+k. $$

Consequently,

$$ H^{\ast}(F)\geq\deg_{\pm}(T)+k. $$

If $P$ is a strict sign polynomial for $T$ with $m(P)$ nonconstant monomials, then

$$ H^{\ast}(F)\leq2^{k}\bigl(m(P)+1\bigr)-1. $$

In particular,

$$ H^{\ast}(\pi_k\oplus T) \leq 2^{k}\bigl(\mathrm{ptfsp}(T)+1\bigr)-1. $$

> **Interpretation.** A parity block is an additive threshold-degree amplifier. The sparse-PTF upper bound is only a safe fallback, but the lower bound is exact and composable.

## Proof

The threshold-degree identity is by induction on $k$.

For $k=0$, the statement is tautological. Suppose the statement holds for $k-1$. Write

$$ \pi_k(z)=z_k\oplus\pi_{k-1}(z_1,\ldots,z_{k-1}). $$

Set

$$ T_{k-1}(z_1,\ldots,z_{k-1},y) := \pi_{k-1}(z_1,\ldots,z_{k-1})\oplus T(y). $$

Then

$$ F(z,y)=z_k\oplus T_{k-1}(z_1,\ldots,z_{k-1},y). $$

By the induction hypothesis,

$$ \deg_{\pm}(T_{k-1})=\deg_{\pm}(T)+k-1. $$

Applying the fresh-bit XOR threshold-degree theorem [081_fresh_bit_xor_threshold_degree.md](081_fresh_bit_xor_threshold_degree.md) gives

$$ \deg_{\pm}(F) = \deg_{\pm}(T_{k-1})+1 = \deg_{\pm}(T)+k. $$

The head lower bound follows from the general threshold-degree lower bound [006_threshold_degree_head_complexity_bound.md](../01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md).

For the sparse upper bound, let $P(y)$ strictly sign-represent $T$. Define

$$ S(z):=\prod_{j=1}^{k}(1-2z_j). $$

Then $S(z)=1$ when $\pi_k(z)=0$ and $S(z)=-1$ when $\pi_k(z)=1$. Therefore

$$ Q(z,y):=S(z)P(y) $$

is positive exactly when $\pi_k(z)\oplus T(y)=1$.

Expanding $S(z)P(y)$ multiplies each monomial of $P$ by each monomial of $S$. Since $S$ has $2^k$ monomials and $P$ has at most $m(P)+1$ monomials including the constant monomial, $Q$ has at most

$$ 2^k\bigl(m(P)+1\bigr)-1 $$

nonconstant monomials. The polynomial-threshold sparsity upper bound [041_ptf_sparsity_upper_bound.md](../02_complexity_measure_upper_bounds/041_ptf_sparsity_upper_bound.md) gives the claimed head upper bound. $\blacksquare$

## Consequences

If $T$ already has threshold degree $d$, then XORing with $k$ fresh parity bits forces at least $d+k$ heads.

For $T$ constant, this recovers

$$ \deg_{\pm}(\pi_k)=k. $$

For $T=\mathrm{XOR}_m$, it recovers the parity identity

$$ \deg_{\pm}(\mathrm{XOR}_{m+k})=m+k. $$
