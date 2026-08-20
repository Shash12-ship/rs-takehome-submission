# Polynomial-Threshold Sparsity Upper Bound

## Statement

For a nonempty set $S\subseteq\lbrace1,\ldots,n\rbrace$, write

$$ q_S(x):=\prod_{i\in S}x_i. $$

Let $\mathrm{ptfsp}(f)$ be the least number of nonconstant monomials appearing with nonzero coefficient in a real polynomial

$$ P(x)=a_{\varnothing}+\sum_{\varnothing\neq S\subseteq\lbrace1,\ldots,n\rbrace}a_S q_S(x) $$

that sign-represents $f$, meaning

$$ f(x)=1 \qquad\Longleftrightarrow\qquad P(x)\gt0 $$

for every $x\in\lbrace0,1\rbrace^n$.

Then

$$ H^{\ast}(f)\leq\mathrm{ptfsp}(f). $$

In particular, if $\deg_{\pm}(f)\leq d$, then

$$ H^{\ast}(f) \leq \sum_{r=1}^{d}\binom{n}{r}. $$

> **Interpretation.** Sparse polynomial threshold representations give sparse head representations. Threshold degree is a lower bound on $H^{\ast}$, but low threshold degree also gives a general, possibly loose, upper bound through the number of low-degree monomials.

## Proof

We first show that one head can approximate any nonconstant monomial with arbitrary signed coefficient.

### Lemma 1. One head approximates a signed monotone monomial

Fix a nonempty set $S\subseteq\lbrace1,\ldots,n\rbrace$, a coefficient $a\in\mathbb{R}$, and a tolerance $\varepsilon\gt0$. There is a one-head atom $\phi_{S,a,\varepsilon}$ such that

$$ \left\lvert \phi_{S,a,\varepsilon}(x)-a q_S(x) \right\rvert \lt \varepsilon $$

for every $x\in\lbrace0,1\rbrace^n$.

**Proof.** If $a=0$, take the zero numerator over any valid denominator. Assume $a\neq0$.

Let

$$ k:=\lvert S\rvert, \qquad d_S(x):=k-\sum_{i\in S}x_i. $$

Then $d_S(x)=0$ exactly when $q_S(x)=1$, and $d_S(x)\geq1$ when $q_S(x)=0$.

Choose parameters $R\gt0$ and $\delta\gt0$, and define

$$ A(x):=2a\left(\frac{1}{2}-d_S(x)\right) $$

and

$$ B(x):= 1+R  d_S(x) +\delta\sum_{i\notin S}(1-x_i). $$

Equivalently,

$$ B(x) = 1+Rk+\delta(n-k) -R\sum_{i\in S}x_i -\delta\sum_{i\notin S}x_i. $$

The denominator is positive on the cube, and all variable coefficients are strictly negative. By the denominator-orientation lemma [032_denominator_orientation.md](032_denominator_orientation.md), $\phi:=A/B$ is a one-head atom.

If $q_S(x)=1$, then $d_S(x)=0$ and

$$ \phi(x) = \frac{a}{1+\delta\sum_{i\notin S}(1-x_i)}. $$

Taking $\delta$ small enough makes this value uniformly within $\varepsilon$ of $a$ on all inputs with $q_S(x)=1$.

If $q_S(x)=0$, then $d_S(x)\geq1$, so

$$ \lvert \phi(x)\rvert \leq \frac{2\lvert a\rvert d_S(x)} {1+R  d_S(x)} \leq \frac{2\lvert a\rvert}{R}. $$

Taking $R$ large enough makes this uniformly smaller than $\varepsilon$ on all inputs with $q_S(x)=0$. Thus $\phi$ approximates $a q_S$ uniformly on the cube. $\blacksquare$

### Lemma 2. Approximate a sparse sign polynomial

Let

$$ P(x)=a_{\varnothing}+\sum_{S\in\mathcal{M}}a_S q_S(x) $$

sign-represent $f$, where $\mathcal{M}$ is a family of nonempty sets and every $a_S\neq0$. Since the cube is finite and the signs are strict,

$$ \Delta:=\min_{x\in\lbrace0,1\rbrace^n}\lvert P(x)\rvert\gt0. $$

If $\mathcal{M}=\varnothing$, then $P$ is constant-sign and $f$ is constant, so $H^{\ast}(f)=0$.

Assume $\mathcal{M}\neq\varnothing$. For each $S\in\mathcal{M}$, use Lemma 1 with tolerance

$$ \varepsilon:=\frac{\Delta}{2\lvert\mathcal{M}\rvert} $$

to choose a one-head atom $\phi_S$ satisfying

$$ \lvert \phi_S(x)-a_S q_S(x)\rvert\lt\varepsilon $$

for every cube point. Define

$$ \widetilde{P}(x):= a_{\varnothing}+\sum_{S\in\mathcal{M}}\phi_S(x). $$

Then

$$ \lvert \widetilde{P}(x)-P(x)\rvert \leq \sum_{S\in\mathcal{M}} \lvert \phi_S(x)-a_S q_S(x)\rvert \lt \frac{\Delta}{2} $$

for every $x$. Therefore $\widetilde{P}$ has the same sign as $P$ on the whole cube.

By the linear-fractional normal form [010_linear_fractional_normal_form.md](../01_foundations_and_normal_form/010_linear_fractional_normal_form.md), $\widetilde{P}$ is an $\lvert\mathcal{M}\rvert$-head score computing $f$. Hence

$$ H^{\ast}(f)\leq\lvert\mathcal{M}\rvert. $$

Minimizing over all sign-representing polynomials proves

$$ H^{\ast}(f)\leq\mathrm{ptfsp}(f). $$

Finally, if $\deg_{\pm}(f)\leq d$, choose a degree-at-most $d$ sign-representing polynomial. It has no more than

$$ \sum_{r=1}^{d}\binom{n}{r} $$

nonconstant monomials. Applying the sparsity bound proves the displayed threshold-degree corollary. $\blacksquare$

## Consequence

For every Boolean function,

$$ \deg_{\pm}(f) \leq H^{\ast}(f) \leq \mathrm{ptfsp}(f). $$

For functions with small threshold degree $d$, this gives the uniform upper bound

$$ H^{\ast}(f) \leq \binom{n}{1}+\binom{n}{2}+\cdots+\binom{n}{d}. $$

This bound is usually not tight. For example, nonconstant linear threshold functions have $H^{\ast}(f)=1$, while the sparsity route only gives $H^{\ast}(f)\leq n$ from an arbitrary dense affine threshold. Its value is that it converts sparse sign polynomials into head upper bounds without requiring determinant-span certificates.
