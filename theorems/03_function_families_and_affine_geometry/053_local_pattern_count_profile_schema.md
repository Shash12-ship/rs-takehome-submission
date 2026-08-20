# Local-Pattern Count Profile Schema

## Statement

Let

$$ p:\lbrace0,1\rbrace^2\to\lbrace0,1\rbrace $$

be a two-bit predicate, and let $P_p(a,b)$ be its multilinear polynomial on the Boolean square. For $m\geq1$ and $F:\lbrace0,1,\ldots,m\rbrace\to\lbrace0,1\rbrace$, define

$$ f_{p,F}(x,y) := F \left(\sum_{i=1}^{m}p(x_i,y_i)\right), \qquad x,y\in\lbrace0,1\rbrace^m. $$

Let $C(F)$ be the number of sign changes in

$$ F(0),F(1),\ldots,F(m). $$

For $0\leq C\leq m$, define the local expansion cost $\Lambda_{p,m}(C)$ as follows. For each $S\subseteq\lbrace1,\ldots,m\rbrace$, set

$$ P_{p,S}(x,y):=\prod_{i\in S}P_p(x_i,y_i). $$

Let $\lambda_{p,m}(C)$ be $1$ if at least one product $P_{p,S}$ with $1\leq\lvert S\rvert\leq C$ contains a nonzero degree-one monomial after multilinear expansion, and $0$ otherwise. Let $\Gamma_{p,m}(C)$ be the set of degree at least two monomials that occur with nonzero coefficient in at least one such product. Define

$$ \Lambda_{p,m}(C):=\lambda_{p,m}(C)+\lvert\Gamma_{p,m}(C)\rvert. $$

If $C=0$, the index set is empty and $\Lambda_{p,m}(0)=0$.

Suppose $p$ has a symmetric one-bit slice: after fixing one of its two inputs to a constant, the remaining one-bit function is either $z$ or $1-z$. Then

$$ C(F) \leq H^{\ast}(f_{p,F}) \leq \Lambda_{p,m}(C(F)). $$

> **Interpretation.** Any count of identical local two-bit patterns inherits a symmetric sign-change lower bound when one slice exposes a free bit. The upper bound is exactly the affine-free monomial cost of expanding a univariate sign polynomial in the local count.

## Proof

### Lemma 1. One-bit slice lower bound

Assume first that fixing one coordinate of $p$ gives the identity function $z$. Applying the same restriction in every pair gives

$$ \sum_{i=1}^{m}p(x_i,y_i)=\sum_{i=1}^{m}z_i $$

on the restricted cube. Hence $f_{p,F}$ restricts to the symmetric function

$$ z\mapsto F(\lvert z\rvert). $$

By the symmetric sign-change theorem [012_symmetric_sign_changes.md](../01_foundations_and_normal_form/012_symmetric_sign_changes.md), this restricted function has head complexity $C(F)$. Restriction monotonicity from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) gives

$$ H^{\ast}(f_{p,F})\geq C(F). $$

If the one-bit slice is $1-z$ instead, the same restriction gives

$$ \sum_{i=1}^{m}p(x_i,y_i)=m-\lvert z\rvert. $$

The restricted profile has label sequence

$$ F(m),F(m-1),\ldots,F(0), $$

which has the same number of sign changes as the original sequence. The same symmetric theorem and restriction monotonicity again give

$$ H^{\ast}(f_{p,F})\geq C(F). $$

### Lemma 2. A degree-C(F) sign polynomial in the local count

Define

$$ q_k:= \begin{cases} +1 & \text{if } F(k)=1,\cr -1 & \text{if } F(k)=0, \end{cases} $$

and

$$ \mathcal{J}:=\lbrace j\in\lbrace0,\ldots,m-1\rbrace:q_j\neq q_{j+1}\rbrace. $$

Let

$$ R(t):= q_0\prod_{j\in\mathcal{J}}\left(j+\frac{1}{2}-t\right). $$

As in [050_intersection_profile_bounds.md](050_intersection_profile_bounds.md), this polynomial has degree $C(F)$ and satisfies

$$ q_kR(k)\gt0 $$

for every $k\in\lbrace0,\ldots,m\rbrace$. Therefore

$$ R \left(\sum_{i=1}^{m}p(x_i,y_i)\right) $$

sign-represents $f_{p,F}$.

### Lemma 3. Expansion-cost upper bound

Since $p$ is Boolean-valued, $P_p(x_i,y_i)^2=P_p(x_i,y_i)$ as a function on the Boolean square. Thus after multilinear reduction, the polynomial from Lemma 2 lies in the span of the products

$$ P_{p,S}(x,y) $$

with

$$ 0\leq\lvert S\rvert\leq C(F). $$

The constant part is absorbed into the final threshold. By the definition of $\Lambda_{p,m}(C(F))$, all linear monomials appearing in the expansion cost at most one affine head, and all degree at least two monomials appearing in the expansion are contained in $\Gamma_{p,m}(C(F))$.

Therefore the affine-free support cost of this sign polynomial is at most

$$ \Lambda_{p,m}(C(F)). $$

Applying the affine-free polynomial-threshold sparsity bound [048_affine_free_sparsity_upper_bound.md](048_affine_free_sparsity_upper_bound.md) gives

$$ H^{\ast}(f_{p,F}) \leq \Lambda_{p,m}(C(F)). $$

Together with Lemma 1, this proves the theorem. $\blacksquare$

## Consequence

This schema recovers the three profile families recorded separately in these notes.

1. For $p(a,b)=ab$, the slice $b=1$ gives $a$, and each product over $r$ coordinates is one monomial. Hence

   $\Lambda_{p,m}(C)\leq\sum_{r=1}^{C}\binom{m}{r}.$

   This is the intersection-profile bound from [050_intersection_profile_bounds.md](050_intersection_profile_bounds.md).

2. For $p(a,b)=a\oplus b$, the slice $b=0$ gives $a$, and

   $p(a,b)=a+b-2ab.$

   Thus

   $\Lambda_{p,m}(C) \leq 1+m+\sum_{r=2}^{C}3^r\binom{m}{r}$

   for $C\geq1$. This is the Hamming-distance profile bound from [051_hamming_distance_profile_bounds.md](051_hamming_distance_profile_bounds.md).

3. For $p(a,b)=a(1-b)$, the slice $b=0$ gives $a$, and

   $p(a,b)=a-ab.$

   Thus

   $\Lambda_{p,m}(C) \leq 1+m+\sum_{r=2}^{C}2^r\binom{m}{r}$

   for $C\geq1$. This is the directed-defect profile bound from [052_directed_defect_profile_bounds.md](052_directed_defect_profile_bounds.md).
