# Counting Lower Bound For Monotone Functions

## Statement

Let $\mathsf{Mon}_n$ be the set of monotone Boolean functions on $\lbrace0,1\rbrace^n$, and define

$$ W_{\mathrm{mon}}(n) := \max_{f\in\mathsf{Mon}_n} H^{\ast}(f). $$

Let

$$ B_n:=\binom{n}{\lfloor n/2\rfloor}. $$

Then

$$ W_{\mathrm{mon}}(n) = \Omega \left(\frac{B_n}{n^2}\right). $$

Combined with the monotone antichain upper bound [035_monotone_antichain_upper_bound.md](035_monotone_antichain_upper_bound.md), this gives

$$ \Omega \left(\frac{1}{n^2}\binom{n}{\lfloor n/2\rfloor}\right) \leq W_{\mathrm{mon}}(n) \leq \binom{n}{\lfloor n/2\rfloor}. $$

More quantitatively, if

$$ H=o \left(\frac{B_n}{n^2}\right), $$

then the fraction of monotone $n$-bit Boolean functions with $H^{\ast}(f)\leq H$ tends to $0$.

> **Interpretation.** The monotone antichain upper bound is near-optimal for the whole monotone class, up to the same polynomial slack as the general Warren-counting lower bound.

## Proof

### Lemma 1. There are many monotone functions

Let

$$ k:=\lfloor n/2\rfloor, \qquad \mathcal{L}_k:=\lbrace S\subseteq\lbrace1,\ldots,n\rbrace:\lvert S\rvert=k\rbrace. $$

For each family $\mathcal{A}\subseteq\mathcal{L}_k$, define a monotone Boolean function $f _{\mathcal{A}}$ by

$$ f_{\mathcal{A}}(1_X)=1 \qquad\Longleftrightarrow\qquad \text{there exists } S\in\mathcal{A} \text{ with } S\subseteq X. $$

This function is monotone because the condition $S\subseteq X$ is preserved when $X$ grows.

The map

$$ \mathcal{A}\mapsto f_{\mathcal{A}} $$

is injective. Indeed, if $T\in\mathcal{L}_k$, then

$$ f_{\mathcal{A}}(1_T)=1 \qquad\Longleftrightarrow\qquad T\in\mathcal{A}, $$

because two $k$-element sets satisfy $S\subseteq T$ only when $S=T$.

Therefore

$$ \lvert\mathsf{Mon}_n\rvert \geq 2^{\lvert\mathcal{L}_k\rvert} = 2^{B_n}. $$

### Lemma 2. Few low-head functions are available

By the general counting lower bound [026_counting_lower_bound.md](../01_foundations_and_normal_form/026_counting_lower_bound.md), the number of all $n$-bit Boolean functions computable with at most $H$ heads is at most

$$ 2^{O(n^2H)} $$

for $1\leq H\leq2^n$.

Hence the number of monotone functions computable with at most $H$ heads is also at most

$$ 2^{O(n^2H)}. $$

If

$$ H=o \left(\frac{B_n}{n^2}\right), $$

then

$$ 2^{O(n^2H)} = 2^{o(B_n)}. $$

Dividing by the lower bound $\lvert\mathsf{Mon}_n\rvert\geq2^{B_n}$ from Lemma 1, the fraction of monotone functions with $H^{\ast}(f)\leq H$ is at most

$$ 2^{-B_n+o(B_n)}, $$

which tends to $0$.

In particular, for a sufficiently small absolute constant $c\gt0$, not every monotone function can satisfy

$$ H^{\ast}(f) \leq c\frac{B_n}{n^2}. $$

Thus

$$ W_{\mathrm{mon}}(n) = \Omega \left(\frac{B_n}{n^2}\right). $$

The upper bound

$$ W_{\mathrm{mon}}(n)\leq B_n $$

is exactly the monotone antichain upper bound from [035_monotone_antichain_upper_bound.md](035_monotone_antichain_upper_bound.md). $\blacksquare$

## Consequence

The monotone class has exponentially large worst-case head complexity:

$$ \Omega \left(\frac{2^n}{n^{5/2}}\right) \leq W_{\mathrm{mon}}(n) \leq O \left(\frac{2^n}{\sqrt n}\right), $$

using the standard asymptotic size of the middle binomial coefficient.

Thus the exponential typical-complexity phenomenon is not caused only by arbitrary labelings. It already appears inside the monotone Boolean functions, despite the strong antichain upper bound.
