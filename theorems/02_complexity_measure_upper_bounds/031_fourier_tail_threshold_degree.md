# Fourier Tail Threshold-Degree Criterion

## Statement

Let $q : \lbrace-1,1\rbrace^n \to \lbrace-1,1\rbrace$ be the sign-valued version of a Boolean function $f$. Write its Fourier expansion as

$$ q(z) = \sum_{S\subseteq[n]}\widehat q(S)\chi_S(z), \qquad \chi_S(z):=\prod_{i\in S}z_i. $$

Fix $d\in\lbrace0,\ldots,n\rbrace$. Define the high-degree Fourier tail

$$ T_{\gt d}(z) := \sum_{\substack{S\subseteq[n]\cr \lvert S\rvert\gt d}} \widehat q(S)\chi_S(z). $$

If

$$ \lVert T_{\gt d}\rVert_{\infty}\lt1, $$

then

$$ \deg_{\pm}(f)\leq d. $$

In particular, the simpler coefficient condition

$$ \sum_{\substack{S\subseteq[n]\cr \lvert S\rvert\gt d}} \lvert \widehat q(S)\rvert \lt1 $$

also implies

$$ \deg_{\pm}(f)\leq d. $$

> **Interpretation.** A sign function whose high-degree Fourier tail is uniformly smaller than its pointwise sign margin has a low-degree sign representation. This is a practical sufficient condition for feeding functions into the threshold-degree span schema.

## Proof

Define the low-degree truncation

$$ P_{\leq d}(z) := q(z)-T_{\gt d}(z) = \sum_{\substack{S\subseteq[n]\cr \lvert S\rvert\leq d}} \widehat q(S)\chi_S(z). $$

This polynomial has degree at most $d$. For every $z\in\lbrace-1,1\rbrace^n$,

$$ \begin{aligned} q(z)P_{\leq d}(z) &= q(z)\bigl(q(z)-T_{\gt d}(z)\bigr) \cr &= 1-q(z)T_{\gt d}(z) \cr &\geq 1-\lVert T_{\gt d}\rVert_{\infty} \cr &\gt 0. \end{aligned} $$

Thus $P_{\leq d}$ sign-represents $f$, so

$$ \deg_{\pm}(f)\leq d. $$

The coefficient condition implies the sup-norm condition because each character has absolute value $1$:

$$ \lVert T_{\gt d}\rVert_{\infty} \leq \sum_{\substack{S\subseteq[n]\cr \lvert S\rvert\gt d}} \lvert \widehat q(S)\rvert. $$

$\blacksquare$

## Consequence

The top-threshold-degree theorem [027_top_threshold_degree.md](../01_foundations_and_normal_form/027_top_threshold_degree.md) is the case $d=n-1$. Then

$$ T_{\gt n-1}(z)=\widehat q([n]) \chi_{[n]}(z). $$

If $q$ is not parity or anti-parity, then

$$ \lvert\widehat q([n])\rvert\lt1, $$

so the criterion gives $\deg_{\pm}(f)\leq n-1$.

Combined with [030_threshold_degree_span_schema.md](030_threshold_degree_span_schema.md), the criterion gives a concrete upper-bound pipeline:

$$ \lVert T_{\gt d}\rVert_{\infty}\lt1 \qquad\Longrightarrow\qquad \deg_{\pm}(f)\leq d \qquad\Longrightarrow\qquad H^{\ast}(f)\leq H $$

whenever a degree $d$ span certificate with $H$ heads is available.
