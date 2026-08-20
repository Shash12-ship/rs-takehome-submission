# Fresh-Bit XOR Raises Threshold Degree

## Statement

Let

$$ f:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace, $$

and define

$$ g:\lbrace0,1\rbrace^{m+1}\to\lbrace0,1\rbrace, \qquad g(z,y):=z\oplus f(y). $$

Then

$$ \deg_{\pm}(g)=\deg_{\pm}(f)+1. $$

Consequently,

$$ H^{\ast}(g)\geq\deg_{\pm}(f)+1. $$

If $P$ is a strict sign polynomial for $f$ with $\ell(P)$ nonzero linear coefficients and $q(P)$ nonlinear monomials, then

$$ \deg_{\pm}(f)+1 \leq H^{\ast}(z\oplus f(y)) \leq 1+\ell(P)+2q(P). $$

> **Interpretation.** XOR with a fresh raw bit is a reliable lower-bound amplifier: it raises threshold degree by exactly one. This explains why the desired recursion $H^{\ast}(z\oplus f)\leq H^{\ast}(f)+1$ would be tight on every family where $H^{\ast}$ already matches threshold degree.

## Proof

Let

$$ d:=\deg_{\pm}(f). $$

### Upper bound

Choose a strict sign polynomial $P(y)$ for $f$ with degree $d$:

$$ f(y)=1 \qquad\Longleftrightarrow\qquad P(y)\gt0. $$

Define

$$ Q(z,y):=(1-2z)P(y). $$

If $z=0$, then $Q(z,y)=P(y)$, so $Q\gt0$ exactly when $f(y)=1$. If $z=1$, then $Q(z,y)=-P(y)$, so $Q\gt0$ exactly when $f(y)=0$. Hence

$$ Q(z,y)\gt0 \qquad\Longleftrightarrow\qquad z\oplus f(y)=1. $$

Thus $Q$ sign-represents $g$ and has degree at most $d+1$. Therefore

$$ \deg_{\pm}(g)\leq d+1. $$

### Lower bound

Let $R(z,y)$ be any strict sign polynomial for $g$, and let

$$ e:=\deg R. $$

Write $R$ in multilinear form with respect to $z$:

$$ R(z,y)=A(y)+zB(y). $$

The $z=0$ slice computes $f$, so

$$ f(y)=1 \qquad\Longleftrightarrow\qquad A(y)\gt0. $$

The $z=1$ slice computes $1-f$, so

$$ f(y)=1 \qquad\Longleftrightarrow\qquad A(y)+B(y)\lt0. $$

If $f(y)=1$, then $A(y)\gt0$ and $A(y)+B(y)\lt0$, hence $B(y)\lt0$. If $f(y)=0$, then $A(y)\lt0$ and $A(y)+B(y)\gt0$, hence $B(y)\gt0$. Therefore

$$ f(y)=1 \qquad\Longleftrightarrow\qquad -B(y)\gt0. $$

So $-B$ strictly sign-represents $f$.

Since every monomial of $zB(y)$ has total degree at most $e$, the polynomial $B$ has degree at most $e-1$. Thus

$$ d=\deg_{\pm}(f)\leq\deg B\leq e-1. $$

Hence $e\geq d+1$. Since $R$ was arbitrary,

$$ \deg_{\pm}(g)\geq d+1. $$

Combining the two inequalities proves

$$ \deg_{\pm}(g)=\deg_{\pm}(f)+1. $$

The head lower bound follows from the general threshold-degree lower bound [006_threshold_degree_head_complexity_bound.md](../01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md). The upper bound using $\ell(P)$ and $q(P)$ is the XOR case of one-bit sparse-PTF branching [080_one_bit_sparse_ptf_branching.md](080_one_bit_sparse_ptf_branching.md). $\blacksquare$

## Consequences

For every Boolean function $f$,

$$ H^{\ast}(z\oplus f(y))\geq\deg_{\pm}(f)+1. $$

If a class satisfies $H^{\ast}(f)=\deg_{\pm}(f)$ and also admits a matching one-bit-XOR upper bound, then the class remains exact after XORing with a fresh bit.

For parity, this recovers the inductive lower bound:

$$ \deg_{\pm}(\mathrm{XOR}_{m+1}) = \deg_{\pm}(\mathrm{XOR}_{m})+1. $$
