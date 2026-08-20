# One-Bit Sparse-PTF Branching

## Statement

Let

$$ P(y) = c+\sum_{i=1}^{m}a_i y_i +\sum_{\substack{S\subseteq\lbrace1,\ldots,m\rbrace\cr \lvert S\rvert\geq2}} a_S\prod_{i\in S}y_i $$

strictly sign-represent a Boolean feature

$$ T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace, \qquad T(y)=1 \Longleftrightarrow P(y)\gt0. $$

Let

$$ \ell(P):=\lvert\lbrace i:a_i\neq0\rbrace\rvert, \qquad q(P):= \left\lvert \left\lbrace S:\lvert S\rvert\geq2,\ a_S\neq0 \right\rbrace \right\rvert. $$

Let

$$ G:\lbrace0,1\rbrace^2\to\lbrace0,1\rbrace $$

be arbitrary, and define

$$ f(z,y):=G(z,T(y)). $$

For $b\in\lbrace0,1\rbrace$, define $\mu_b\in\lbrace-1,0,1\rbrace$ by:

- $\mu_b=1$ if $G(b,u)=u$ as a function of $u$,
- $\mu_b=-1$ if $G(b,u)=1-u$ as a function of $u$,
- $\mu_b=0$ if $G(b,u)$ is constant as a function of $u$.

Then

$$ H^{\ast}(f) \leq 1 +\mathbf{1}[\mu_0\neq0]  q(P) +\mathbf{1}[\mu_1\neq\mu_0]\bigl(\ell(P)+q(P)\bigr). $$

In particular,

$$ H^{\ast}(f)\leq1+\ell(P)+2q(P). $$

If the refined displayed upper bound is at most $2$, then

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** A one-bit gate applied to a sparse PTF feature is cheap when the feature has few linear variables and few nonlinear monomials. If the two $z$-slices are the same function of $T$, the change term vanishes.

## Proof

Split on $z$. The two cofactors are

$$ f_b(y)=G(b,T(y)) \qquad (b\in\lbrace0,1\rbrace). $$

Each $f_b$ is one of $0$, $1$, $T$, or $1-T$. Choose strict sign polynomials $Q_b$ as follows. If $\mu_b=1$, set

$$ Q_b:=P. $$

If $\mu_b=-1$, set

$$ Q_b:=-P. $$

If $\mu_b=0$, then $f_b$ is constant. Set $Q_b:=1$ for the constant $1$ function and $Q_b:=-1$ for the constant $0$ function.

These choices strictly sign-represent the two cofactors.

Now apply the split affine-free support invariant [078_split_affine_free_support_invariant.md](078_split_affine_free_support_invariant.md) to the pair $Q_0,Q_1$.

The affine indicator contributes at most

$$ 1. $$

The nonlinear support of the base cofactor $Q_0$ contributes at most

$$ \mathbf{1}[\mu_0\neq0]  q(P). $$

The changed linear coefficients contribute at most

$$ \mathbf{1}[\mu_1\neq\mu_0] \ell(P), $$

because all nonzero linear coefficients of $Q_b$ are scalar multiples of the linear coefficients of $P$.

The changed nonlinear coefficients contribute at most

$$ \mathbf{1}[\mu_1\neq\mu_0]  q(P), $$

for the same reason. Therefore Lemma 78 gives

$$ H^{\ast}(f) \leq 1 +\mathbf{1}[\mu_0\neq0]  q(P) +\mathbf{1}[\mu_1\neq\mu_0]\bigl(\ell(P)+q(P)\bigr). $$

The uniform corollary follows from

$$ \mathbf{1}[\mu_0\neq0]\leq1, \qquad \mathbf{1}[\mu_1\neq\mu_0]\leq1. $$

Finally, if the refined displayed upper bound is at most $2$, then $H^{\ast}(f)\leq2$. The exact value is forced by the zero-head and one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md): constants have value $0$, nonconstant LTFs have value $1$, and every remaining function has value exactly $2$. $\blacksquare$

## Consequences

For XOR with a sparse PTF feature,

$$ f(z,y)=z\oplus T(y), $$

the branch codes satisfy $\mu_0=1$ and $\mu_1=-1$, so

$$ H^{\ast}(z\oplus T(y)) \leq 1+\ell(P)+2q(P). $$

For AND with a sparse PTF feature,

$$ f(z,y)=z\wedge T(y), $$

the branch codes satisfy $\mu_0=0$ and $\mu_1=1$, so

$$ H^{\ast}(z\wedge T(y)) \leq 1+\ell(P)+q(P). $$

When $P$ is affine, $q(P)=0$, and this recovers the one-bit LTF branching bound.
