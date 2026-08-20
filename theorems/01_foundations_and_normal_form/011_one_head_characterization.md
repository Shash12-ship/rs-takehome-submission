# Exact One-Head Characterization

## Statement

The first two levels of head complexity are exactly characterized:

$$ H^{\ast}(f) = 0 \qquad \Longleftrightarrow \qquad f \text{ is constant}, $$

and

$$ H^{\ast}(f) = 1 \qquad \Longleftrightarrow \qquad f \text{ is a nonconstant linear threshold function}. $$

In particular, every non-linear-threshold Boolean function has

$$ H^{\ast}(f) \geq 2. $$

This strictly strengthens the checkerboard obstruction [003_checkerboard_obstruction.md](003_checkerboard_obstruction.md) as a one-head lower bound.

## Proof

We use the linear-fractional normal form [010_linear_fractional_normal_form.md](010_linear_fractional_normal_form.md), which gives $H^{\ast}(f) = L_{\mathrm{frac}}(f)$.

**One head is exactly linear threshold.** First suppose $f$ is computed by one head. By the normal form, there is a constant $c$ and one atom

$$ \phi(x) = \frac{N(x)}{D(x)} $$

such that

$$ f(x) = 1 \qquad \Longleftrightarrow \qquad c + \phi(x) \gt 0. $$

The denominator satisfies $D(x) \gt 0$ on the Boolean cube. Also both $N$ and $D$ are affine functions of $x$, because

$$ \alpha^{x_i} = 1 + (\alpha - 1)x_i, $$

and

$$ \alpha^{x_i}(m_i + \delta x_i) = m_i + \bigl(\alpha(m_i + \delta) - m_i\bigr)x_i. $$

Thus

$$ c + \phi(x) \gt 0 \qquad \Longleftrightarrow \qquad cD(x) + N(x) \gt 0. $$

The right-hand side is an affine threshold. Therefore every one-head function is a linear threshold function.

**Conversely,** suppose $f$ is sign-represented by an affine function

$$ L(x) = \beta_0 + \sum_{i=1}^{n} \beta_i x_i, $$

meaning

$$ f(x) = 1 \qquad \Longleftrightarrow \qquad L(x) \gt 0. $$

Choose one atom with

$$ \alpha = 2, \qquad \gamma = 1, \qquad \rho_i = 1, $$

with

$$ \delta = 0, \qquad m_i = \beta_i, $$

and

$$ \eta = \beta_0 - \sum_{i=1}^{n} \beta_i. $$

Its numerator is

$$ \begin{aligned} \eta + \sum_{i=1}^{n} 2^{x_i} \beta_i &= \beta_0 - \sum_{i=1}^{n} \beta_i + \sum_{i=1}^{n} \beta_i(1 + x_i) \cr &= \beta_0 + \sum_{i=1}^{n} \beta_i x_i \cr &= L(x). \end{aligned} $$

Its denominator is positive. Therefore the atom has the same sign as $L(x)$, and one head computes $f$.

So every nonconstant function computable with one head is a linear threshold function, and every linear threshold function is computable with at most one head.

**Zero heads.** A zero-head model has only the fixed query residual, so it computes only constant functions. Conversely, either constant function is computed with zero heads by choosing the readout threshold on the correct side of the constant score.

Therefore

$$ H^{\ast}(f) = 0 \qquad \Longleftrightarrow \qquad f \text{ is constant}, $$

and

$$ H^{\ast}(f) = 1 \qquad \Longleftrightarrow \qquad f \text{ is a nonconstant linear threshold function}. $$

This completes the proof. $\blacksquare$

## Consequences

The checkerboard lower bound [003_checkerboard_obstruction.md](003_checkerboard_obstruction.md) is a special case: a checkerboard restriction is not linearly separable, so any function containing such a restriction cannot have $H^{\ast}(f) \leq 1$.

Combining this characterization with the threshold-degree lower bound [006_threshold_degree_head_complexity_bound.md](006_threshold_degree_head_complexity_bound.md) and the weighted-sum upper bound [009_weighted_sum_upper_bound.md](009_weighted_sum_upper_bound.md) gives the current general sandwich:

$$ \deg_{\pm}(f) \leq H^{\ast}(f) = L_{\mathrm{frac}}(f) \leq M_{+}(f) - 1 \leq 2^n - 1. $$

The new information is the exact identification of the first nontrivial level:

$$ \lbrace f : H^{\ast}(f) \leq 1\rbrace = \lbrace f : f \text{ is a linear threshold function}\rbrace. $$
