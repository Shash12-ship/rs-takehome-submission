# Positive-Projection Sign-Change Upper Bound

## Statement

Let $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$.

Suppose there are positive weights

$$ \lambda_1,\ldots,\lambda_n \gt 0 $$

and a function

$$ F : \mathrm{Im}(t) \to \lbrace0,1\rbrace, $$

where

$$ t(x) := \sum_{i=1}^{n} \lambda_i x_i, $$

such that

$$ f(x) = F(t(x)) $$

for every $x \in \lbrace0,1\rbrace^n$.

Write the image of $t$ in increasing order as

$$ 0 = \tau_0 \lt \tau_1 \lt \cdots \lt \tau_{M-1}. $$

Define signs

$$ \sigma_m := \begin{cases} +1 & \text{if } F(\tau_m) = 1, \cr -1 & \text{if } F(\tau_m) = 0, \end{cases} \qquad 0 \leq m \leq M-1. $$

Let

$$ C_t(F) := \lvert \left\lbrace m \in \lbrace1,\ldots,M-1\rbrace : \sigma_{m-1} \neq \sigma_m \right\rbrace \rvert. $$

Then

$$ H^{\ast}(f) \leq C_t(F). $$

Consequently, if

$$ C_{+}(f) := \min C_t(F), $$

where the minimum ranges over all positive weighted sums $t$ through which $f$ factors, then

$$ H^{\ast}(f) \leq C_{+}(f) \leq M_{+}(f) - 1. $$

The quantity $C_{+}(f)$ is finite for every Boolean function, because the binary-weight projection

$$ t(x) = \sum_{i=1}^{n} 2^{i-1}x_i $$

is injective on the Boolean cube.

> **Equivalently.** If a Boolean function becomes a one-dimensional labeled sequence after projection onto a positive weighted sum, then one head per label change along that sequence suffices.

## Proof

If $C_t(F) = 0$, then all labels on $\mathrm{Im}(t)$ are equal, so $f$ is constant and $H^{\ast}(f)=0$.

Assume

$$ C := C_t(F) \geq 1. $$

### Lemma 1. A shifted reciprocal of t costs one head

Fix $r \gt 0$ and $d \in \mathbb{R}$. The scalar function

$$ \psi_{r,d}(x) := \frac{d}{t(x)+r} $$

is a one-head atom in the sense of [010_linear_fractional_normal_form.md](010_linear_fractional_normal_form.md).

**Proof.** Let

$$ \Lambda := \sum_{i=1}^{n} \lambda_i. $$

Choose

$$ \alpha \gt 1 + \frac{\Lambda}{r}. $$

Set

$$ \rho_i := \frac{\lambda_i}{\alpha - 1} \qquad \text{for } 1 \leq i \leq n, $$

and

$$ \gamma := r - \frac{\Lambda}{\alpha - 1}. $$

Then every $\rho_i$ is positive and $\gamma \gt 0$.

In the one-head atom definition, take

$$ \eta = d, \qquad m_i = 0, \qquad \delta = 0. $$

Since $x_i \in \lbrace0,1\rbrace$,

$$ \alpha^{x_i} = 1 + (\alpha - 1)x_i. $$

Therefore

$$ \begin{aligned} \gamma + \sum_{i=1}^{n} \rho_i \alpha^{x_i} &= r - \frac{\Lambda}{\alpha - 1} + \sum_{i=1}^{n} \frac{\lambda_i}{\alpha - 1}\left(1 + (\alpha - 1)x_i\right) \cr &= r + \sum_{i=1}^{n} \lambda_i x_i \cr &= r+t(x). \end{aligned} $$

The numerator is the constant $d$. Hence the atom is exactly

$$ \frac{d}{t(x)+r}. $$

$\blacksquare$

### Lemma 2. C heads realize the projected sign sequence

Let

$$ J := \lbrace m \in \lbrace1,\ldots,M-1\rbrace : \sigma_{m-1} \neq \sigma_m\rbrace. $$

For every $m \in J$, choose a cut point

$$ a_m \in (\tau_{m-1},\tau_m). $$

Define

$$ P(z) := \sigma_0 \prod_{m \in J} (a_m - z). $$

Then $P$ has degree $C$ and

$$ \mathrm{sgn}(P(\tau_m)) = \sigma_m \qquad \text{for every } m \in \lbrace0,\ldots,M-1\rbrace. $$

Now choose distinct positive numbers

$$ r_1,\ldots,r_C \gt 0 $$

and set

$$ B(z) := \prod_{j=1}^{C}(z+r_j). $$

Because every $\tau_m$ is nonnegative, $B(\tau_m) \gt 0$. Therefore

$$ S(z) := \frac{P(z)}{B(z)} $$

has the same sign as $P$ on $\mathrm{Im}(t)$.

Since $\deg P \leq C = \deg B$ and the roots $-r_j$ are distinct, the partial-fraction decomposition has the form

$$ S(z) = c + \sum_{j=1}^{C} \frac{d_j}{z+r_j} $$

for some real coefficients

$$ c,d_1,\ldots,d_C \in \mathbb{R}. $$

By Lemma 1, each function

$$ x \mapsto \frac{d_j}{t(x)+r_j} $$

is a one-head atom. Therefore $C$ heads and constant offset $c$ realize the score

$$ c + \sum_{j=1}^{C} \frac{d_j}{t(x)+r_j} = S(t(x)). $$

This score is positive exactly when $F(t(x)) = 1$, and negative exactly when $F(t(x)) = 0$. Hence

$$ H^{\ast}(f) \leq C_t(F). $$

$\blacksquare$

This proves the theorem. Since $C_t(F) \leq \lvert\mathrm{Im}(t)\rvert - 1$ for every positive projection $t$, minimizing over all such projections gives

$$ H^{\ast}(f) \leq C_{+}(f) \leq M_{+}(f) - 1. $$

$\blacksquare$

## Consequences

1. The weighted-sum interpolation bound is never stronger than this sign-change bound, because a sequence with $M$ levels has at most $M-1$ sign changes.

2. For symmetric functions, taking $t(x)=\lvert x\rvert$ gives the exact sign-change count from [012_symmetric_sign_changes.md](012_symmetric_sign_changes.md).

3. The universal binary-weight projection gives

$$ H^{\ast}(f) \leq 2^n - 1 $$

for every Boolean function, but the sign-change count along that projection may be much smaller than $2^n - 1$.
