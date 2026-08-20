# One-Bit Gate Threshold-Degree Trichotomy

## Statement

Let

$$ T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace $$

be nonconstant, and set

$$ d:=\deg_{\pm}(T). $$

Let

$$ G:\lbrace0,1\rbrace^{2}\to\lbrace0,1\rbrace $$

be any Boolean gate, and define

$$ F(z,y):=G(z,T(y)). $$

For $b\in\lbrace0,1\rbrace$, write

$$ G_b(u):=G(b,u). $$

Each slice $G_b$ is one of $0$, $1$, $u$, or $1-u$. Then:

1. If $G_0$ and $G_1$ are both constant, then

$$ \deg_{\pm}(F) = \begin{cases} 0 & \text{if } G_0=G_1,\cr 1 & \text{if } G_0\neq G_1. \end{cases} $$

2. If at least one slice is nonconstant and the nonconstant slices, when there are two, are not opposite, then

$$ \deg_{\pm}(F)=d. $$

3. If $\lbrace G_0,G_1\rbrace=\lbrace u,1-u\rbrace$, then

$$ \deg_{\pm}(F)=d+1. $$

Consequently, fresh-bit AND, OR, implication, and their complements preserve threshold degree when the feature branch is nonconstant, while XOR and XNOR raise threshold degree by exactly one.

## Proof

Since $T$ is nonconstant, $d\geq1$.

### Constant slices

If $G_0$ and $G_1$ are the same constant, then $F$ is constant, so $\deg_{\pm}(F)=0$.

If $G_0$ and $G_1$ are different constants, then $F$ is either $z$ or $1-z$. Hence it is a nonconstant LTF and

$$ \deg_{\pm}(F)=1. $$

### Same nonconstant slice

Suppose $G_0=G_1=u$ or $G_0=G_1=1-u$. Then $F$ is either $T$ or $1-T$, ignoring $z$. Negating a strict sign polynomial swaps a function with its complement, so complements have the same threshold degree. Therefore

$$ \deg_{\pm}(F)=d. $$

### Exactly one nonconstant slice

Suppose first that $G_0$ is constant and $G_1$ is nonconstant. Let $U$ be the $z=1$ slice, so $U$ is either $T$ or $1-T$. Choose a strict sign polynomial $P(y)$ for $U$ with degree $d$:

$$ U(y)=1 \qquad\Longleftrightarrow\qquad P(y)\gt0. $$

Choose

$$ M\gt\max_{y\in\lbrace0,1\rbrace^{m}}\lvert P(y)\rvert. $$

If $G_0$ is the constant $1$ function, define

$$ R(z,y):=P(y)+M(1-z). $$

Then $R(1,y)=P(y)$ and $R(0,y)\gt0$ for every $y$.

If $G_0$ is the constant $0$ function, define

$$ R(z,y):=P(y)-M(1-z). $$

Then $R(1,y)=P(y)$ and $R(0,y)\lt0$ for every $y$.

In either case, $R$ strictly sign-represents $F$ and has degree at most $d$, because $d\geq1$.

The lower bound

$$ \deg_{\pm}(F)\geq d $$

follows by restricting to the slice $z=1$, where $F$ equals $U$. Thus $\deg_{\pm}(F)=d$.

The case where $G_0$ is nonconstant and $G_1$ is constant is the same, replacing $1-z$ by $z$.

### Opposite nonconstant slices

If $G_0=u$ and $G_1=1-u$, then

$$ F(z,y)=z\oplus T(y). $$

By the fresh-bit XOR threshold-degree theorem [081_fresh_bit_xor_threshold_degree.md](081_fresh_bit_xor_threshold_degree.md),

$$ \deg_{\pm}(F)=d+1. $$

If $G_0=1-u$ and $G_1=u$, then $F$ is the complement of $z\oplus T(y)$. Complementing preserves threshold degree, so again

$$ \deg_{\pm}(F)=d+1. $$

These cases exhaust all possibilities for the pair of slices $G_0,G_1$. $\blacksquare$

## Consequences

For nonconstant $T$,

$$ \deg_{\pm}(z\wedge T(y)) = \deg_{\pm}(z\vee T(y)) = \deg_{\pm}(T), $$

while

$$ \deg_{\pm}(z\oplus T(y)) = \deg_{\pm}(T)+1. $$

Thus the lower-bound behavior of one-bit branching depends on the gate, not just on the presence of a fresh raw bit.
