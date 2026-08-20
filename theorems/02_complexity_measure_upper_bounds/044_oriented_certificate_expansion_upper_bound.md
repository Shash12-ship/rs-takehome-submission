# Local Certificate-Expansion Upper Bound

## Statement

Let $(P,N)$ be a partial assignment, where $P,N\subseteq\lbrace1,\ldots,n\rbrace$ are disjoint. Its cylinder is

$$ [P,N] := \lbrace x\in\lbrace0,1\rbrace^n : x_i=1 \text{ for } i\in P,\ x_j=0 \text{ for } j\in N\rbrace. $$

A family $\mathcal{C}_1$ of such partial assignments is a $1$-certificate cover for $f$ if

$$ f^{-1}(1) \subseteq \bigcup_{(P,N)\in\mathcal{C}_1}[P,N] \subseteq f^{-1}(1). $$

If $\mathcal{C}_1$ is a $1$-certificate cover, then

$$ H^{\ast}(f) \leq \sum_{(P,N)\in\mathcal{C}_1} \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace. $$

The dual statement holds for a $0$-certificate cover $\mathcal{C}_0$:

$$ H^{\ast}(f) \leq \sum_{(P,N)\in\mathcal{C}_0} \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace. $$

> **Interpretation.** A one-sided certificate cover is cheap when each certificate fixes few bits of at least one sign. The cheaper sign may be chosen separately for each certificate.

## Proof

We first note a small extension of the polynomial-threshold sparsity construction. A signed positive monomial

$$ a\prod_{i\in S}x_i $$

can be approximated uniformly by one head by [041_ptf_sparsity_upper_bound.md](041_ptf_sparsity_upper_bound.md). By global bit-flip invariance from [028_restrictions_and_sign_rank.md](028_restrictions_and_sign_rank.md), the same is true for a signed negative monomial

$$ a\prod_{i\in S}(1-x_i). $$

Let $\mathcal{C}_1$ be a $1$-certificate cover. For a partial assignment $(P,N)$, define its indicator term

$$ T_{P,N}(x) := \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right). $$

Since $\mathcal{C}_1$ covers exactly the true set, the polynomial

$$ Q(x) := \sum_{(P,N)\in\mathcal{C}_1}T_{P,N}(x)-\frac{1}{2} $$

strictly sign-represents $f$. Indeed, if $f(x)=0$, then no certificate cylinder contains $x$, so $Q(x)=-1/2$. If $f(x)=1$, then at least one certificate cylinder contains $x$, so $Q(x)\geq1/2$.

For each certificate term, choose the cheaper of two expansions. Expanding the negative literals gives

$$ \begin{aligned} T_{P,N}(x) &= \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right) \cr &= \sum_{U\subseteq N} (-1)^{\lvert U\rvert} \prod_{i\in P\cup U}x_i. \end{aligned} $$

This costs $2^{\lvert N\rvert}$ positive monomials. Expanding the positive literals instead gives

$$ \begin{aligned} T_{P,N}(x) &= \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right) \cr &= \sum_{U\subseteq P} (-1)^{\lvert U\rvert} \prod_{j\in N\cup U}(1-x_j). \end{aligned} $$

This costs $2^{\lvert P\rvert}$ negative monomials.

Choosing the cheaper expansion for each $(P,N)$, the polynomial $Q$ becomes a sum of at most

$$ M := \sum_{(P,N)\in\mathcal{C}_1} \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace $$

pure positive or pure negative monomials, plus a constant. If $M=0$, then $f$ is constant $0$ and the bound is trivial. Otherwise, approximate each nonconstant pure monomial term by one head with uniform error less than $1/(4M)$. The total approximation error is then less than $1/4$ on the cube.

Since $Q(x)\leq -1/2$ on false inputs and $Q(x)\geq1/2$ on true inputs, the approximating head score has the same sign as $Q$ everywhere. Therefore

$$ H^{\ast}(f) \leq \sum_{(P,N)\in\mathcal{C}_1} \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace. $$

If $\mathcal{C}_0$ is a $0$-certificate cover for $f$, then it is a $1$-certificate cover for $1-f$. Applying the first part to $1-f$ and using complement invariance from [028_restrictions_and_sign_rank.md](028_restrictions_and_sign_rank.md) proves the $0$-certificate bound. $\blacksquare$

## Consequence

The mixed-literal DNF/CNF literal-expansion theorem [042_dnf_cnf_literal_expansion_upper_bound.md](042_dnf_cnf_literal_expansion_upper_bound.md) is strengthened to the local bound

$$ H^{\ast}(f) \leq \sum_a\min\lbrace2^{\lvert P_a\rvert},2^{\lvert N_a\rvert}\rbrace. $$

The decision-tree leaf-profile theorem [043_decision_tree_upper_bound.md](043_decision_tree_upper_bound.md) is strengthened similarly. If a decision tree has depth at most $d$, then every leaf satisfies

$$ \min\lbrace\lvert P_\ell\rvert,\lvert N_\ell\rvert\rbrace \leq \left\lfloor\frac{d}{2}\right\rfloor. $$

Thus every nonconstant $f$ satisfies

$$ H^{\ast}(f) \leq 2^{D(f)+\lfloor D(f)/2\rfloor-1}. $$

This bound complements the volume certificate theorem [040_certificate_cover_upper_bound.md](040_certificate_cover_upper_bound.md). Volume certificates are strongest for high-codimension cylinders in a large ambient cube, while local expansion certificates are strongest when each cylinder fixes few bits of at least one sign.
