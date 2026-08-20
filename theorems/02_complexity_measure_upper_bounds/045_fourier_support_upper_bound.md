# Fourier Support-Cost Upper Bound

## Statement

For $S\subseteq\lbrace1,\ldots,n\rbrace$, define the Walsh character

$$ \chi_S(x):=(-1)^{\sum_{i\in S}x_i} = \prod_{i\in S}(1-2x_i). $$

Let $q:\lbrace0,1\rbrace^n\to\lbrace-1,1\rbrace$ be the sign-valued version of $f$, with $q(x)=1$ on $f^{-1}(1)$ and $q(x)=-1$ on $f^{-1}(0)$.

Suppose a Fourier-sparse polynomial

$$ R(x)=\sum_{S\in\mathcal{A}}c_S\chi_S(x) $$

sign-represents $f$, meaning

$$ q(x)R(x)\gt0 $$

for every $x\in\lbrace0,1\rbrace^n$.

Define $a_1(R)=1$ if some active set of size one has a nonzero coefficient, and define $a_1(R)=0$ otherwise. Then

$$ H^{\ast}(f) \leq a_1(R)+\sum_{\substack{S\in\mathcal{A}\cr \lvert S\rvert\geq2,\ c_S\neq0}}\lvert S\rvert. $$

In particular, if every active nonconstant set has size at most $d$, there are $m_1$ active singleton sets, and there are $m_{\geq2}$ other active nonconstant sets, then

$$ H^{\ast}(f)\leq\mathbf{1}[m_1\gt0]+dm_{\geq2}. $$

As a Fourier-tail corollary, if

$$ \left\lVert q-\sum_{S\in\mathcal{A}}\widehat q(S)\chi_S \right\rVert_{\infty} \lt1, $$

then the same upper bound holds.

> **Interpretation.** A sparse Walsh sign approximant gives a head upper bound. All constant and singleton characters combine into one affine score, so together they cost at most one head. Every remaining character on $\lvert S\rvert$ bits is parity on those bits and costs only $\lvert S\rvert$ heads. Expanding it into monotone monomials loses both structures.

## Proof

Let

$$ \Delta:=\min_{x\in\lbrace0,1\rbrace^n}q(x)R(x)\gt0. $$

First collect the degree-zero and degree-one part:

$$ R_{\mathrm{aff}}(x):=c_{\varnothing}+\sum_{\substack{S\in\mathcal A\cr\lvert S\rvert=1}}c_S\chi_S(x), $$

where absent coefficients are interpreted as zero. This is affine in $x$. If it is nonconstant, choose the strictly positive affine denominator

$$ B_{\varepsilon}(x):=1+\varepsilon\sum_{i=1}^nx_i. $$

The one-head atom $R_{\mathrm{aff}}/B_{\varepsilon}$ converges uniformly to $R_{\mathrm{aff}}$ on the finite cube as $\varepsilon\to0$. If $R_{\mathrm{aff}}$ is constant, absorb it into the global readout constant and use no head.

Now fix $S$ with $\lvert S\rvert\geq2$ and $c_S\neq0$, and put $k=\lvert S\rvert$. On its $k$ active variables, $\chi_S$ is $k$-bit parity in sign-valued form. The exact parity construction [008_exact_parity_complexity.md](../01_foundations_and_normal_form/008_exact_parity_complexity.md), followed by negating the score if needed, produces a $k$-head score equal to $\chi_S$ at every active input. Scaling its readout coefficients produces a score equal to

$$ c_S\chi_S. $$

Extend every atom in this score to the remaining dummy variables by giving each dummy coordinate a sufficiently small positive weight. The uniform-convergence argument in [028_restrictions_and_sign_rank.md](028_restrictions_and_sign_rank.md) shows that the extended score converges uniformly on the full cube to $c_S\chi_S$ as those weights tend to zero.

There are only finitely many components. Choose $\varepsilon$ and all dummy weights small enough that the sum of their uniform errors is less than $\Delta/2$. Add all the extended scores. The linear-fractional normal form [010_linear_fractional_normal_form.md](../01_foundations_and_normal_form/010_linear_fractional_normal_form.md) realizes this finite sum by concatenating its one-head atoms. The resulting score $\widetilde R$ uses

$$ a_1(R)+\sum_{\substack{S\in\mathcal{A}\cr \lvert S\rvert\geq2,\ c_S\neq0}}\lvert S\rvert $$

heads and satisfies

$$ \lvert\widetilde R(x)-R(x)\rvert\lt\frac{\Delta}{2} $$

for every cube point. Hence

$$ q(x)\widetilde R(x)\gt0 $$

everywhere, which proves the first bound. If the $m_{\geq2}$ active nonsingleton sets have size at most $d$, their total parity cost is at most $dm_{\geq2}$, while all singleton terms cost at most one additional head.

Finally, suppose

$$ \left\lVert q-\sum_{S\in\mathcal{A}}\widehat q(S)\chi_S \right\rVert_{\infty} \lt1. $$

Let

$$ R_{\mathcal{A}}(x):=\sum_{S\in\mathcal{A}}\widehat q(S)\chi_S(x). $$

Then for every $x$,

$$ \lvert q(x)-R_{\mathcal{A}}(x)\rvert\lt1. $$

Since $q(x)\in\lbrace-1,1\rbrace$, this implies $q(x)R_{\mathcal{A}}(x)\gt0$. Hence $R_{\mathcal{A}}$ sign-represents $f$, and the first part applies. $\blacksquare$

## Consequence

The Fourier-tail threshold-degree certificate [031_fourier_tail_threshold_degree.md](031_fourier_tail_threshold_degree.md) proves low threshold degree by retaining all Fourier levels up to $d$. This lemma gives a direct head bound that can be sharper when only a few low-degree Fourier coefficients need to be retained.

For a degree $d$ Fourier truncation supported on $\mathcal{A}$,

$$ H^{\ast}(f) \leq a_1(R_{\mathcal A})+\sum_{\substack{S\in\mathcal{A}\cr \lvert S\rvert\geq2,\ \widehat q(S)\neq0}}\lvert S\rvert, $$

which can be much smaller than both the monomial-expansion cost and the uniform degree-only upper bound

$$ \sum_{r=1}^{d}\binom{n}{r}. $$
