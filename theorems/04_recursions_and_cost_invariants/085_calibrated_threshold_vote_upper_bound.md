# Calibrated Threshold-Vote Upper Bound

## Statement

Let

$$ T_1,\ldots,T_s:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace $$

be Boolean features, and let

$$ c_0,c_1,\ldots,c_s\in\mathbb{R}. $$

Define

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{s}c_jT_j(x)\gt0. $$

Let the vote margin be

$$ \mu := \min_{x\in\lbrace0,1\rbrace^{n}} \left\lvert c_0+\sum_{j=1}^{s}c_jT_j(x) \right\rvert. $$

Assume $\mu\gt0$. Suppose that for each $j$ there is a one-head linear-fractional atom $\phi_j$ such that

$$ \lvert \phi_j(x)-T_j(x)\rvert\leq\epsilon_j \qquad \text{for every }x\in\lbrace0,1\rbrace^{n}, $$

and

$$ \sum_{j=1}^{s}\lvert c_j\rvert\epsilon_j\lt\mu. $$

Then

$$ H^{\ast}(f)\leq s. $$

> **Interpretation.** Threshold-vote size alone is not an upper bound for $H^{\ast}$. What suffices is calibrated access to the raw features: the one-head atoms must approximate the inner gate indicators accurately enough compared with the outer vote margin.

## Proof

Define the true vote score

$$ V(x):=c_0+\sum_{j=1}^{s}c_jT_j(x) $$

and the atom score

$$ \widetilde V(x):=c_0+\sum_{j=1}^{s}c_j\phi_j(x). $$

For every $x$,

$$ \begin{aligned} \lvert \widetilde V(x)-V(x)\rvert &= \left\lvert \sum_{j=1}^{s}c_j(\phi_j(x)-T_j(x)) \right\rvert \cr &\leq \sum_{j=1}^{s}\lvert c_j\rvert\lvert \phi_j(x)-T_j(x)\rvert \cr &\leq \sum_{j=1}^{s}\lvert c_j\rvert\epsilon_j \lt \mu. \end{aligned} $$

If $f(x)=1$, then $V(x)\gt0$, and by definition of $\mu$ we have $V(x)\geq\mu$. Therefore

$$ \widetilde V(x)\gt0. $$

If $f(x)=0$, then $V(x)\lt0$, and by definition of $\mu$ we have $V(x)\leq-\mu$. Therefore

$$ \widetilde V(x)\lt0. $$

Thus

$$ f(x)=1 \qquad\Longleftrightarrow\qquad \widetilde V(x)\gt0. $$

Multiplying a one-head atom by a scalar gives another one-head atom, by multiplying its numerator parameters by that scalar and leaving its positive denominator unchanged. Hence the score $\widetilde V$ is a constant plus a sum of $s$ one-head atoms. The linear-fractional normal form [010_linear_fractional_normal_form.md](../01_foundations_and_normal_form/010_linear_fractional_normal_form.md) gives

$$ H^{\ast}(f)\leq s. $$

$\blacksquare$

## Consequences

Let $s_{\mathrm{LTF}}(f)$ be the minimum number of LTF indicators in a weighted vote for $f$. The inequality

$$ H^{\ast}(f)\leq s_{\mathrm{LTF}}(f) $$

is false in general, because intersections of two halfspaces can have high threshold degree. The theorem above identifies the missing hypothesis: the specific LTF indicators in the vote must be uniformly approximable by one-head atoms at the required vote margin.

In particular, a finite calibrated certificate for a vote consists of:

1. the outer weights $c_j$ and margin $\mu$,
2. one-head atom parameters for each inner feature,
3. uniform error bounds $\epsilon_j$ satisfying $\sum_j\lvert c_j\rvert\epsilon_j\lt\mu$.

Such a certificate immediately proves an $s$-head upper bound.
