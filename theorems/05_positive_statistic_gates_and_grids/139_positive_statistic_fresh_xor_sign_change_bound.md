# Positive-Statistic Fresh-XOR Sign-Change Bound

## Statement

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let $T(y)=F(t(y))$ be nonconstant. Write the ordered image of $t$ as

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}, $$

and let $C$ be the number of sign changes in the label sequence

$$ F(\tau_0),F(\tau_1),\ldots,F(\tau_{M-1}). $$

Then

$$ \deg_{\pm}(T)+1 \leq H^{\ast}(z\oplus T(y)) \leq C+1, $$

and the same bounds hold for XNOR. In particular, if $\deg_{\pm}(T)=C$, then

$$ H^{\ast}(z\oplus T(y)) = H^{\ast}(1-(z\oplus T(y))) = C+1. $$

> **Interpretation.** For positive-statistic features, fresh XOR costs at most one more than the original one-dimensional sign-change count, not the separated two-slice sign-change count.

## Proof

Because $T$ is nonconstant, $C\geq1$. For every index $j$ with

$$ F(\tau_j)\neq F(\tau_{j+1}), $$

choose a point

$$ \gamma_j\in(\tau_j,\tau_{j+1}). $$

Define

$$ Q(u):=\sigma\prod_j(u-\gamma_j), $$

where the product ranges over the sign-change indices and the sign $\sigma\in\lbrace1,-1\rbrace$ is chosen so that $Q(\tau_0)\gt0$ exactly when $F(\tau_0)=1$. As $u$ moves through the ordered image of $t$, the sign of $Q$ flips exactly at the chosen sign-change gaps and nowhere else. Thus

$$ T(y)=1 \qquad\Longleftrightarrow\qquad Q(t(y))\gt0, $$

and $\deg Q=C$.

The polynomial

$$ P(z,y):=(1-2z)Q(t(y)) $$

strictly sign-represents $z\oplus T(y)$. It has degree at most $C+1$ in the two quantities $t(y)$ and $z$, reduced using $z^2=z$. The positive-statistic raw-bit degree span [138_positive_statistic_raw_bit_degree_span.md](138_positive_statistic_raw_bit_degree_span.md) gives

$$ H^{\ast}(z\oplus T(y))\leq C+1. $$

The lower bound is the fresh-bit XOR threshold-degree theorem [081_fresh_bit_xor_threshold_degree.md](../04_recursions_and_cost_invariants/081_fresh_bit_xor_threshold_degree.md):

$$ H^{\ast}(z\oplus T(y)) \geq \deg_{\pm}(z\oplus T(y)) = \deg_{\pm}(T)+1. $$

XNOR is the output complement of XOR, so complement invariance gives the same bounds and exactness statement. $\blacksquare$

## Consequence

For internal positive slabs, $C=2$ and $\deg_{\pm}(T)=2$, so fresh XOR and XNOR have exact value $3$. More generally, every threshold-degree-tight positive-statistic sequence remains exact after XOR with one fresh raw bit.
