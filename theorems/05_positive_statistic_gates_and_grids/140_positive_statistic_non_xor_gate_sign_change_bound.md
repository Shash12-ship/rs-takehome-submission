# Positive-Statistic Non-XOR Gate Sign-Change Bound

## Statement

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let $T(y)=F(t(y))$ be nonconstant. Let $C$ be the number of sign changes in the ordered label sequence of $F$ on the image of $t$.

For a two-input gate $G$, define

$$ H_G(z,y):=G(z,T(y)). $$

If $G$ is neither XOR nor XNOR, then:

1. constant gates have $H^{\ast}(H_G)=0$;
2. raw-bit literals have $H^{\ast}(H_G)=1$;
3. every other gate satisfies

$$ \deg_{\pm}(T) \leq H^{\ast}(H_G) \leq C. $$

In particular, if $\deg_{\pm}(T)=C$, then every nonconstant feature-dependent non-XOR and non-XNOR gate over $z$ and $T$ has exact value $C$.

> **Interpretation.** One raw-bit non-XOR branching over a positive-statistic feature preserves the original sign-change cost.

## Proof

As in [139_positive_statistic_fresh_xor_sign_change_bound.md](139_positive_statistic_fresh_xor_sign_change_bound.md), choose a strict degree $C$ polynomial $Q$ such that

$$ T(y)=1 \qquad\Longleftrightarrow\qquad Q(t(y))\gt0. $$

For $b\in\lbrace0,1\rbrace$, write

$$ G_b(u):=G(b,u). $$

Each slice is one of $0$, $1$, $u$, or $1-u$.

The constant and raw-bit literal cases are immediate. Now suppose at least one slice is nonconstant and the two nonconstant slices, if both appear, are not opposite.

If the two slices are the same nonconstant function, then $H_G$ is either $T$ or $1-T$, ignoring $z$. Lemma 138 applied to $Q(t)$, or to $-Q(t)$, gives

$$ H^{\ast}(H_G)\leq C. $$

It remains to handle the case where exactly one slice is nonconstant. Let $U(y)$ be that nonconstant slice, so $U$ is either $T$ or $1-T$. Define

$$ Q_U(t):= \begin{cases} Q(t) & \text{if }U=T,\cr -Q(t) & \text{if }U=1-T. \end{cases} $$

Choose

$$ M\gt\max_y\lvert Q_U(t(y))\rvert. $$

If the nonconstant slice occurs at $z=1$, set

$$ P(z,y):= \begin{cases} Q_U(t(y))+M(1-z) & \text{if }G_0\text{ is the constant }1,\cr Q_U(t(y))-M(1-z) & \text{if }G_0\text{ is the constant }0. \end{cases} $$

If the nonconstant slice occurs at $z=0$, set

$$ P(z,y):= \begin{cases} Q_U(t(y))+Mz & \text{if }G_1\text{ is the constant }1,\cr Q_U(t(y))-Mz & \text{if }G_1\text{ is the constant }0. \end{cases} $$

In each case, $P$ strictly sign-represents $H_G$ and has degree at most $C$ in $t(y)$ and $z$. Lemma 138 gives

$$ H^{\ast}(H_G)\leq C. $$

The lower bound for feature-dependent non-XOR gates is the one-bit gate threshold-degree trichotomy [082_one_bit_gate_threshold_degree_trichotomy.md](../04_recursions_and_cost_invariants/082_one_bit_gate_threshold_degree_trichotomy.md):

$$ \deg_{\pm}(H_G)=\deg_{\pm}(T). $$

Since $H^{\ast}$ lower-bounds threshold degree, the displayed sandwich follows. $\blacksquare$

## Consequence

Together with the fresh-XOR bound, every one-bit gate over a positive-statistic feature has a sign-change upper bound using the original feature sequence: non-XOR feature-dependent gates cost at most $C$, while XOR and XNOR cost at most $C+1$.
