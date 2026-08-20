# Top Threshold Degree Is Only Parity

## Statement

Let $n \geq 1$, and let

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace. $$

Then

$$ \deg_{\pm}(f)=n $$

if and only if $f$ is parity or the complement of parity.

Equivalently, the threshold-degree lower bound reaches $n$ heads only for

$$ \mathrm{XOR}_n \qquad \text{and} \qquad 1-\mathrm{XOR}_n. $$

## Proof

It is cleaner to work on the sign cube $\lbrace-1,1\rbrace^n$. Write

$$ z_i := (-1)^{x_i}. $$

Changing variables between $x_i\in\lbrace0,1\rbrace$ and $z_i\in\lbrace-1,1\rbrace$ is affine, so it preserves polynomial degree.

Let $q : \lbrace-1,1\rbrace^n \to \lbrace-1,1\rbrace$ be the sign-valued version of $f$. Thus a polynomial $P$ sign-represents $f$ exactly when

$$ q(z)P(z)\gt0 \qquad \text{for every } z\in\lbrace-1,1\rbrace^n. $$

Let

$$ \chi(z) := z_1z_2\cdots z_n. $$

This is parity in sign coordinates, up to the harmless choice of which Boolean label is called $1$.

First, if $q=\chi$ or $q=-\chi$, then $f$ is parity or its complement. The parity threshold-degree lemma from [007_parity_threshold_degree.md](007_parity_threshold_degree.md) gives

$$ \deg_{\pm}(f)=n. $$

Conversely, suppose $q$ is not equal to $\chi$ or $-\chi$. Let

$$ \rho := \mathbb{E}_{z\in\lbrace-1,1\rbrace^n}\bigl[q(z)\chi(z)\bigr]. $$

Since $q(z)\chi(z)$ is sign-valued and is not constant, we have

$$ \lvert \rho\rvert \lt 1. $$

Now expand $q$ in the Fourier basis on the sign cube:

$$ q(z)=\sum_{S\subseteq[n]}\widehat q(S)\prod_{i\in S}z_i. $$

The coefficient of the top character $\chi$ is exactly $\rho$. Define

$$ P(z):=q(z)-\rho\chi(z). $$

Then $P$ has degree at most $n-1$, because we have removed the only degree $n$ Fourier term.

For every $z$,

$$ \begin{aligned} q(z)P(z) &= q(z)^2-\rho q(z)\chi(z) \cr &= 1-\rho q(z)\chi(z) \cr &\geq 1-\lvert \rho\rvert \cr &\gt 0. \end{aligned} $$

Thus $P$ sign-represents $f$ and has degree at most $n-1$. Therefore $\deg_{\pm}(f)\leq n-1$ whenever $f$ is not parity or the complement of parity.

Combining the two directions proves the claim. $\blacksquare$

## Consequence

Threshold degree alone cannot prove superlinear head lower bounds. In particular, the counting lower bound in [026_counting_lower_bound.md](026_counting_lower_bound.md) is a genuinely different obstruction: it shows that typical functions need exponentially many heads, even though every threshold-degree lower bound is at most $n$.
