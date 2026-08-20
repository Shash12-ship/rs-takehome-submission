# Affine-Free Polynomial-Threshold Sparsity Upper Bound

## Statement

For a real multilinear polynomial

$$ P(x)=a_{\varnothing}+\sum_{\varnothing\neq S\subseteq\lbrace1,\ldots,n\rbrace}a_S\prod_{i\in S}x_i, $$

define its affine-free support cost by

$$ \mathrm{afs}(P) := \mathbf{1} \left[ \exists i,\ a_{\lbrace i\rbrace}\neq0 \right] + \left\lvert \left\lbrace S\subseteq\lbrace1,\ldots,n\rbrace: \lvert S\rvert\geq2,\ a_S\neq0 \right\rbrace \right\rvert. $$

Let

$$ \mathrm{afs}_{\pm}(f) $$

be the minimum of $\mathrm{afs}(P)$ over all real multilinear polynomials $P$ that sign-represent $f$ on the Boolean cube. Then

$$ H^{\ast}(f)\leq\mathrm{afs}_{\pm}(f). $$

Consequently, if $f$ is nonconstant and $\deg_{\pm}(f)\leq d$, then

$$ H^{\ast}(f) \leq 1+\sum_{r=2}^{d}\binom{n}{r}. $$

> **Interpretation.** The sparse-polynomial upper bound does not need to pay one head for each linear monomial. One head can approximate the whole affine part, and the remaining heads only pay for genuinely nonlinear monomials.

## Proof

### Lemma 1. One head approximates any affine function

Let

$$ L(x)=a_0+\sum_{i=1}^{n}a_i x_i $$

be affine, and let $\varepsilon\gt0$. There is a one-head atom $\psi$ such that

$$ \lvert\psi(x)-L(x)\rvert\lt\varepsilon $$

for every $x\in\lbrace0,1\rbrace^n$.

**Proof.** Choose $\delta\gt0$ and define the positive affine denominator

$$ B_{\delta}(x):=1+\delta\sum_{i=1}^{n}x_i. $$

By Lemma 1 of [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md), the ratio

$$ \psi_{\delta}(x):=\frac{L(x)}{B_{\delta}(x)} $$

is a one-head atom, because $B_{\delta}$ has positive constant term and positive variable coefficients.

As $\delta\to0$, $B_{\delta}(x)\to1$ uniformly on the finite cube. Hence $\psi_{\delta}(x)\to L(x)$ uniformly on the cube. Taking $\delta$ sufficiently small proves the claim. $\blacksquare$

### Lemma 2. Approximate an affine-free sparse sign polynomial

Let $P$ sign-represent $f$. Write

$$ P(x) = a_{\varnothing} + L(x) + \sum_{S\in\mathcal{M}}a_S q_S(x), \qquad q_S(x):=\prod_{i\in S}x_i, $$

where

$$ L(x):=\sum_{i=1}^{n}a_{\lbrace i\rbrace}x_i $$

is the linear part, and

$$ \mathcal{M} := \lbrace S:\lvert S\rvert\geq2,\ a_S\neq0\rbrace. $$

Since $P$ has strict sign on the finite cube, define the margin

$$ \Delta:=\min_{x\in\lbrace0,1\rbrace^n}\lvert P(x)\rvert\gt0. $$

Let

$$ \ell:= \mathbf{1} \left[ \exists i,\ a_{\lbrace i\rbrace}\neq0 \right]. $$

If $\ell=1$, use Lemma 1 with tolerance

$$ \frac{\Delta}{4} $$

to choose a one-head atom $\psi$ satisfying

$$ \lvert\psi(x)-L(x)\rvert\lt\frac{\Delta}{4} $$

for every $x$. If $\ell=0$, set $\psi:=0$ and use no affine head.

For each $S\in\mathcal{M}$, use Lemma 1 of [041_ptf_sparsity_upper_bound.md](../02_complexity_measure_upper_bounds/041_ptf_sparsity_upper_bound.md) to choose a one-head atom $\phi_S$ approximating $a_S q_S$ uniformly. If $\mathcal{M}\neq\varnothing$, take the tolerance

$$ \frac{\Delta}{4\lvert\mathcal{M}\rvert} $$

for each nonlinear monomial. If $\mathcal{M}=\varnothing$, no such heads are used.

Now define

$$ \widetilde{P}(x) := a_{\varnothing} + \psi(x) + \sum_{S\in\mathcal{M}}\phi_S(x), $$

where the term $\psi$ is omitted when $\ell=0$. For every cube point,

$$ \lvert\widetilde{P}(x)-P(x)\rvert \lt \frac{\Delta}{2}. $$

Indeed, the affine approximation contributes less than $\Delta/4$ when present and nothing when absent, while the total nonlinear error is less than $\Delta/4$ when $\mathcal{M}$ is nonempty and nothing otherwise.

Therefore $\widetilde{P}$ has the same sign as $P$ everywhere on the cube. By the linear-fractional normal form [010_linear_fractional_normal_form.md](../01_foundations_and_normal_form/010_linear_fractional_normal_form.md), $\widetilde{P}$ is a valid head score using

$$ \ell+\lvert\mathcal{M}\rvert = \mathrm{afs}(P) $$

heads. Hence

$$ H^{\ast}(f)\leq\mathrm{afs}(P). $$

Minimizing over all sign-representing $P$ proves

$$ H^{\ast}(f)\leq\mathrm{afs}_{\pm}(f). $$

### Lemma 3. Threshold-degree corollary

Assume $f$ is nonconstant and $\deg_{\pm}(f)\leq d$. Choose a degree-at-most $d$ polynomial $P$ that sign-represents $f$.

If all linear coefficients of $P$ vanish, then $\mathrm{afs}(P)$ is just the number of degree at least two monomials in $P$, and this is at most

$$ \sum_{r=2}^{d}\binom{n}{r}. $$

If some linear coefficient is nonzero, then all linear terms together cost one affine head, and the degree at least two terms cost at most the same displayed sum. Thus in all cases

$$ \mathrm{afs}(P) \leq 1+\sum_{r=2}^{d}\binom{n}{r}. $$

Applying Lemma 2 gives the corollary. $\blacksquare$

## Consequence

For nonconstant Boolean functions,

$$ \deg_{\pm}(f) \leq H^{\ast}(f) \leq \mathrm{afs}_{\pm}(f) \leq \mathrm{ptfsp}(f). $$

In particular, low threshold degree gives the improved uniform bound

$$ H^{\ast}(f) \leq 1+\binom{n}{2}+\binom{n}{3}+\cdots+\binom{n}{d}. $$

For $d=2$, every nonconstant quadratic threshold function satisfies

$$ H^{\ast}(f)\leq1+\binom{n}{2}. $$

This improves the earlier sparse-PTF corollary by bundling all linear terms into a single affine head.

As a concrete standard family, define equality on two $m$-bit strings by

$$ \mathrm{EQ}_m(x,y)=\mathbf{1}[x=y]. $$

The polynomial

$$ P(x,y) := \frac{1}{2} - \sum_{i=1}^{m}(x_i-y_i)^2 $$

is positive exactly when $x=y$. On the Boolean cube,

$$ P(x,y) = \frac{1}{2} - \sum_{i=1}^{m}x_i - \sum_{i=1}^{m}y_i + 2\sum_{i=1}^{m}x_i y_i. $$

It has one affine part and $m$ nonlinear monomials, so

$$ H^{\ast}(\mathrm{EQ}_m)\leq m+1. $$
