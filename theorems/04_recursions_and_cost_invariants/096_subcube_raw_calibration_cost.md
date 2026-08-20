# Subcube Raw Calibration Cost

## Statement

Let $(P,N)$ be a partial assignment, where $P,N\subseteq\lbrace1,\ldots,n\rbrace$ are disjoint. Define its subcube indicator

$$ C_{P,N}(x) := \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right). $$

If $P=N=\varnothing$, then

$$ \rho(C_{P,N})=0. $$

Otherwise,

$$ \rho(C_{P,N}) \leq \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace. $$

> **Interpretation.** A single cylinder test has low raw calibration cost when it fixes few coordinates of at least one sign. This is the raw-feature version of local certificate expansion.

## Proof

If $P=N=\varnothing$, then $C_{P,N}=1$, and the constant term allowed in the definition of $\rho$ gives $\rho(C_{P,N})=0$.

Assume now that $(P,N)$ is nonvacuous. The local certificate-expansion lemma [044_oriented_certificate_expansion_upper_bound.md](../02_complexity_measure_upper_bounds/044_oriented_certificate_expansion_upper_bound.md) records two exact expansions. Expanding the negative literals gives

$$ \begin{aligned} C_{P,N}(x) &= \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right) \cr &= \sum_{U\subseteq N} (-1)^{\lvert U\rvert} \prod_{i\in P\cup U}x_i. \end{aligned} $$

This expansion has at most $2^{\lvert N\rvert}$ terms, each a signed pure positive monomial, with any empty monomial absorbed into the free constant.

Expanding the positive literals instead gives

$$ \begin{aligned} C_{P,N}(x) &= \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right) \cr &= \sum_{U\subseteq P} (-1)^{\lvert U\rvert} \prod_{j\in N\cup U}(1-x_j). \end{aligned} $$

This expansion has at most $2^{\lvert P\rvert}$ terms, each a signed pure negative monomial, again with any empty monomial absorbed into the free constant.

Choose the cheaper expansion and let $\mathcal{M}$ be the set of its nonconstant signed pure monomial terms. Then

$$ \lvert\mathcal{M}\rvert \leq \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace. $$

The proof of [044_oriented_certificate_expansion_upper_bound.md](../02_complexity_measure_upper_bounds/044_oriented_certificate_expansion_upper_bound.md), using [041_ptf_sparsity_upper_bound.md](../02_complexity_measure_upper_bounds/041_ptf_sparsity_upper_bound.md) and bit-flip invariance from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), shows that every signed pure positive or signed pure negative monomial can be approximated uniformly to arbitrary accuracy by one head.

Given $\epsilon\gt0$, approximate each term in $\mathcal{M}$ with uniform error at most $\epsilon/\max\lbrace1,\lvert\mathcal{M}\rvert\rbrace$, and keep the constant part exactly. The sum of these one-head atoms and the constant term approximates $C_{P,N}$ uniformly within $\epsilon$. Hence

$$ \rho(C_{P,N}) \leq \lvert\mathcal{M}\rvert \leq \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace. $$

$\blacksquare$

## Consequences

If a strict weighted vote uses subcube indicators $C_{P_j,N_j}$ as features, then Lemma 93 gives

$$ H^{\ast}(f) \leq \sum_{j:c_j\neq0} \min\lbrace2^{\lvert P_j\rvert},2^{\lvert N_j\rvert}\rbrace. $$

If a decision list tests subcube indicators, Lemma 94 gives the same summed local expansion cost over the tested cylinders. Thus the local certificate-expansion theorem can be reused inside arbitrary strict votes and decision lists, not only as a one-sided cover of a label class.
