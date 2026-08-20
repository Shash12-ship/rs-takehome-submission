# DNF And CNF Volume Upper Bounds

## Statement

Let

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace. $$

Suppose $f$ has a DNF with consistent nonempty terms $T_1,\ldots,T_s$, and let $w_a$ be the width of $T_a$, namely the number of literals in the term. Then

$$ H^{\ast}(f) \leq 2\sum_{a=1}^{s}2^{n-w_a}. $$

In particular, if every term has width at least $w$, then

$$ H^{\ast}(f)\leq 2s 2^{n-w}. $$

The dual statement holds for CNFs. If $f$ has a CNF with consistent nonempty clauses $C_1,\ldots,C_s$, and $w_a$ is the width of $C_a$, then

$$ H^{\ast}(f) \leq 2\sum_{a=1}^{s}2^{n-w_a}. $$

> **Interpretation.** Arbitrary mixed-literal DNF does not have the monotone one-head-per-term construction, but high-width mixed terms still give a useful head bound because they cover small subcubes.

## Proof

### Lemma 1. DNF support volume

Let $T_a$ be a consistent term of width $w_a$. It fixes exactly $w_a$ coordinates and leaves the other $n-w_a$ coordinates free. Therefore

$$ \lvert T_a^{-1}(1)\rvert=2^{n-w_a}. $$

Since the true set of the DNF is contained in the union of the true sets of its terms,

$$ \lvert f^{-1}(1)\rvert \leq \sum_{a=1}^{s}\lvert T_a^{-1}(1)\rvert = \sum_{a=1}^{s}2^{n-w_a}. $$

The sparse-support upper bound [037_sparse_support_upper_bound.md](037_sparse_support_upper_bound.md) gives

$$ H^{\ast}(f) \leq 2\min\lbrace\lvert f^{-1}(1)\rvert,\lvert f^{-1}(0)\rvert\rbrace \leq 2\lvert f^{-1}(1)\rvert. $$

Combining the two inequalities proves

$$ H^{\ast}(f) \leq 2\sum_{a=1}^{s}2^{n-w_a}. $$

If every $w_a\geq w$, then

$$ \sum_{a=1}^{s}2^{n-w_a} \leq s 2^{n-w}, $$

which gives the advertised uniform-width bound.

### Lemma 2. CNF false-set volume

Let $C_a$ be a consistent clause of width $w_a$. The clause is false exactly when all of its $w_a$ literals are false, which fixes $w_a$ coordinates and leaves $n-w_a$ coordinates free. Thus

$$ \lvert C_a^{-1}(0)\rvert=2^{n-w_a}. $$

If the CNF is false, then at least one clause is false. Hence

$$ \lvert f^{-1}(0)\rvert \leq \sum_{a=1}^{s}2^{n-w_a}. $$

Applying the sparse-support upper bound to the false set gives

$$ H^{\ast}(f) \leq 2\lvert f^{-1}(0)\rvert \leq 2\sum_{a=1}^{s}2^{n-w_a}. $$

$\blacksquare$

## Consequence

For a DNF or CNF whose terms or clauses have large width, this can be much sharper than the generic $2^n-1$ bound. In the extreme case of a DNF of $s$ minterms, each of width $n$, it gives

$$ H^{\ast}(f)\leq2s. $$

The monotone DNF theorem [029_monotone_dnf_upper_bound.md](029_monotone_dnf_upper_bound.md) is still stronger for monotone formulas, giving one head per term. The point here is that arbitrary literal signs are allowed, at the cost of paying by covered volume rather than by term count alone.
