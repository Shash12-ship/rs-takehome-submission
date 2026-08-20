# DNF And CNF Literal-Expansion Upper Bound

## Statement

For disjoint sets $P,N\subseteq\lbrace1,\ldots,n\rbrace$, write the mixed-literal term

$$ T_{P,N}(x) := \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right). $$

Suppose $f$ has a DNF

$$ f(x)=\bigvee_{a=1}^{s}T_{P_a,N_a}(x), $$

where every term is consistent and nonempty. Then

$$ H^{\ast}(f) \leq \min\left\lbrace \sum_{a=1}^{s}2^{\lvert P_a\rvert}, \sum_{a=1}^{s}2^{\lvert N_a\rvert} \right\rbrace. $$

The same bound holds for a CNF

$$ f(x) = \bigwedge_{a=1}^{s} \left( \bigvee_{i\in P_a}x_i \vee \bigvee_{j\in N_a}(1-x_j) \right) $$

with consistent nonempty clauses.

> **Interpretation.** Mixed-literal formulas are easy when each term or clause is close to monotone after choosing one global orientation. This recovers the monotone DNF/CNF bound and is often incomparable with the support-volume bound.

## Proof

### Lemma 1. A DNF pays for expanding one literal sign

Assume

$$ f(x)=\bigvee_{a=1}^{s}T_{P_a,N_a}(x). $$

The polynomial

$$ Q(x):=\sum_{a=1}^{s}T_{P_a,N_a}(x)-\frac{1}{2} $$

strictly sign-represents $f$: if no term is satisfied then $Q(x)=-1/2$, while if at least one term is satisfied then $Q(x)\geq1/2$.

Each term expands in the monotone monomial basis as

$$ \begin{aligned} T_{P,N}(x) &= \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right) \cr &= \sum_{U\subseteq N} (-1)^{\lvert U\rvert} \prod_{i\in P\cup U}x_i. \end{aligned} $$

Thus the number of nonconstant monomials contributed before cancellations is at most $2^{\lvert N\rvert}$. Therefore

$$ \mathrm{ptfsp}(f) \leq \sum_{a=1}^{s}2^{\lvert N_a\rvert}. $$

By the polynomial-threshold sparsity upper bound [041_ptf_sparsity_upper_bound.md](041_ptf_sparsity_upper_bound.md),

$$ H^{\ast}(f) \leq \sum_{a=1}^{s}2^{\lvert N_a\rvert}. $$

Now apply the same argument after the global bit flip $y_i=1-x_i$. The flipped function

$$ g(y):=f(1-y) $$

has DNF terms $T_{N_a,P_a}(y)$. Hence

$$ H^{\ast}(g) \leq \sum_{a=1}^{s}2^{\lvert P_a\rvert}. $$

Global bit-flip invariance from [028_restrictions_and_sign_rank.md](028_restrictions_and_sign_rank.md) gives $H^{\ast}(f)=H^{\ast}(g)$, so

$$ H^{\ast}(f) \leq \sum_{a=1}^{s}2^{\lvert P_a\rvert}. $$

Taking the smaller of the two bounds proves the DNF statement. $\blacksquare$

### Lemma 2. CNFs follow by complementing

Suppose

$$ f(x) = \bigwedge_{a=1}^{s} \left( \bigvee_{i\in P_a}x_i \vee \bigvee_{j\in N_a}(1-x_j) \right). $$

The complement is the DNF

$$ 1-f(x) = \bigvee_{a=1}^{s} \left( \prod_{i\in P_a}(1-x_i) \right) \left( \prod_{j\in N_a}x_j \right), $$

whose terms have positive-literal sets $N_a$ and negative-literal sets $P_a$. Lemma 1 gives

$$ H^{\ast}(1-f) \leq \min\left\lbrace \sum_{a=1}^{s}2^{\lvert P_a\rvert}, \sum_{a=1}^{s}2^{\lvert N_a\rvert} \right\rbrace. $$

Complement invariance from [028_restrictions_and_sign_rank.md](028_restrictions_and_sign_rank.md) gives $H^{\ast}(f)=H^{\ast}(1-f)$, proving the CNF statement. $\blacksquare$

## Consequence

If a DNF or CNF has $s$ terms or clauses and, after possibly applying the global bit flip, every term or clause contains at most $r$ literals of the less convenient sign, then

$$ H^{\ast}(f)\leq s 2^r. $$

For monotone DNF and CNF formulas, $r=0$, so this recovers the one-head-per-term bound

$$ H^{\ast}(f)\leq s. $$

This bound is independent of unused variables. It complements the support-volume bound

$$ H^{\ast}(f)\leq2\sum_a2^{n-w_a}, $$

which is better for high-width terms that cover few cube points.
