# Junta Reduction And Small-Junta Upper Bounds

## Statement

Let

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace $$

be a $k$-junta. Let $f_{\mathrm{ess}}$ be the induced Boolean function on the essential variables of $f$. Then

$$ H^{\ast}(f)=H^{\ast}(f_{\mathrm{ess}}). $$

Consequently, every $k$-junta satisfies the generic bound

$$ H^{\ast}(f)\leq 2^k-1 $$

for $k\geq1$, and constants have $H^{\ast}(f)=0$.

For $k\leq12$, the current best universal small-junta bounds are:

$$ \begin{array}{c|rrrrrrrrrrrrr} k & 0 & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 \cr \hline H^{\ast}(f)\leq & 0 & 1 & 2 & 3 & 4 & 7 & 11 & 19 & 32 & 57 & 103 & 187 & 342. \end{array} $$

> **Interpretation.** Head complexity depends on essential variables, not ambient variables. A function of twelve essential variables embedded in a million dummy coordinates still has the twelve-bit universal bound.

## Proof

### Lemma 1. Junta reduction

The equality

$$ H^{\ast}(f)=H^{\ast}(f_{\mathrm{ess}}) $$

is exactly the junta consequence of [028_restrictions_and_sign_rank.md](028_restrictions_and_sign_rank.md): fixing dummy coordinates gives the lower bound, and adding dummy variables preserves head complexity for the upper bound. Coordinate permutations preserve $H^{\ast}$, so the essential coordinates may be moved to the first $k$ positions.

### Lemma 2. Generic upper bound

For $k\geq1$, the weighted-sum interpolation theorem [009_weighted_sum_upper_bound.md](../01_foundations_and_normal_form/009_weighted_sum_upper_bound.md) gives

$$ H^{\ast}(f_{\mathrm{ess}})\leq2^k-1, $$

using an injective positive weighted sum on the $k$ essential variables. Lemma 1 transfers this to $f$.

### Lemma 3. The two-variable case

Every two-bit Boolean function has head complexity at most $2$.

If the function is constant, it needs $0$ heads. If it is a nonconstant linear threshold function, it needs $1$ head by [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md).

It remains only to consider the non-linear-threshold two-bit functions. A two-bit Boolean function fails to be linearly separable only when its two positive inputs are opposite corners of the square, or equivalently when its two negative inputs are opposite corners. These are two-bit parity and anti-parity up to complement. The exact parity theorem [008_exact_parity_complexity.md](../01_foundations_and_normal_form/008_exact_parity_complexity.md) gives

$$ H^{\ast}(\mathrm{XOR}_2)=2, $$

and complement invariance from [028_restrictions_and_sign_rank.md](028_restrictions_and_sign_rank.md) gives the anti-parity case. Thus every two-bit function has $H^{\ast}\leq2$.

### Lemma 4. Determinant certificates through twelve variables

For $3\leq k\leq12$, the compact determinant certificate [025_compact_threshold_certificates.md](../01_foundations_and_normal_form/025_compact_threshold_certificates.md) gives

$$ H^{\ast}(f_{\mathrm{ess}}) \leq \left\lceil\frac{2^k-1}{k}\right\rceil. $$

The displayed table is exactly:

$$ \begin{array}{c|rrrrrrrrrr} k & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 \cr \hline \left\lceil(2^k-1)/k\right\rceil & 3 & 4 & 7 & 11 & 19 & 32 & 57 & 103 & 187 & 342. \end{array} $$

Combining Lemmas 1 through 4 proves the statement. $\blacksquare$

## Consequence

Let $\mathrm{ess}(f)$ be the number of essential variables of $f$. Then

$$ H^{\ast}(f) \leq 2^{\mathrm{ess}(f)}-1. $$

For $\mathrm{ess}(f)\leq12$, the table in the statement gives the sharper finite-certificate bounds. This is independent of the ambient input length $n$.
