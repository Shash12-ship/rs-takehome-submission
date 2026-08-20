# Affine Parity Exact Complexity

## Statement

Let $S\subseteq\lbrace1,\ldots,n\rbrace$ and $b\in\lbrace0,1\rbrace$. Define

$$ f_{S,b}(x) := b\oplus\bigoplus_{i\in S}x_i. $$

Then

$$ H^{\ast}(f_{S,b})=\lvert S\rvert. $$

Consequently, if some restriction of a Boolean function $f$ is affine parity on $k$ free variables, then

$$ H^{\ast}(f)\geq k. $$

> **Interpretation.** Parity remains exactly one head per essential bit even after adding dummy variables, permuting coordinates, or complementing the output. Affine-parity subcubes are therefore explicit lower-bound witnesses.

## Proof

If $S=\varnothing$, then $f_{S,b}$ is constant, so $H^{\ast}(f_{S,b})=0$.

Assume $\lvert S\rvert=k\geq1$. After permuting coordinates, $f_{S,0}$ is the $k$-bit parity function with $n-k$ dummy variables. By dummy-variable invariance from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) and the exact parity theorem [008_exact_parity_complexity.md](../01_foundations_and_normal_form/008_exact_parity_complexity.md),

$$ H^{\ast}(f_{S,0})=H^{\ast}(\mathrm{XOR}_k)=k. $$

If $b=1$, then $f_{S,1}=1-f_{S,0}$. Complement invariance from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) gives

$$ H^{\ast}(f_{S,1})=H^{\ast}(f_{S,0})=k. $$

Thus $H^{\ast}(f_{S,b})=\lvert S\rvert$ for every $S$ and $b$.

Now suppose a restriction $g$ of $f$ is affine parity on $k$ free variables. By the first part,

$$ H^{\ast}(g)=k. $$

Restriction monotonicity from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) gives

$$ k=H^{\ast}(g)\leq H^{\ast}(f), $$

which proves the lower bound. $\blacksquare$

## Consequence

Define the affine-parity restriction number

$$ \pi_{\oplus}(f) := \max\lbrace k : \text{some restriction of } f \text{ is affine parity on } k \text{ free variables}\rbrace. $$

Then every Boolean function satisfies

$$ H^{\ast}(f)\geq\pi_{\oplus}(f). $$

This invariant is often easier to certify than threshold degree: it only requires finding one subcube on which the labels alternate as affine parity.
