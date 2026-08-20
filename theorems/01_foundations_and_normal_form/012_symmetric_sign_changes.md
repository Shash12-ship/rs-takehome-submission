# Symmetric Sign-Change Characterization

## Statement

Let $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$ be symmetric. Thus there is a function

$$ F : \lbrace0,\ldots,n\rbrace \to \lbrace0,1\rbrace $$

such that

$$ f(x) = F(\lvert x\rvert) $$

for every input $x$, where $\lvert x\rvert := x_1 + \cdots + x_n$.

Define the sign sequence

$$ \sigma_k := \begin{cases} +1 & \text{if } F(k) = 1, \cr -1 & \text{if } F(k) = 0, \end{cases} \qquad 0 \leq k \leq n. $$

Let

$$ C(F) := \lvert \left\lbrace t \in \lbrace1,\ldots,n\rbrace : \sigma_{t-1} \neq \sigma_t \right\rbrace \rvert. $$

Then

$$ H^{\ast}(f) = C(F). $$

> **Equivalently.** For symmetric Boolean functions, head complexity is exactly the number of times the Hamming-weight truth table changes value.

## Proof

We prove matching lower and upper bounds.

### Theorem 1. Symmetric threshold degree equals sign-change count

For symmetric $f$ as above,

$$ \deg_{\pm}(f) = C(F). $$

**Proof.** Let

$$ T := \lbrace t \in \lbrace1,\ldots,n\rbrace : \sigma_{t-1} \neq \sigma_t\rbrace. $$

First, we build a degree $C(F)$ sign-representing polynomial. Define

$$ P(z) := \sigma_0 \prod_{t \in T} \left(t - \frac{1}{2} - z\right). $$

At $z = 0$, every factor is positive, so $P(0)$ has sign $\sigma_0$. As $z$ moves through the integer points $0,1,\ldots,n$, the only roots of $P$ between consecutive integers occur in intervals

$$ \left(t-1,t\right) \qquad \text{with } t \in T. $$

Therefore the sign of $P(k)$ flips exactly when the target sign sequence flips. Hence

$$ \mathrm{sgn}(P(k)) = \sigma_k \qquad \text{for every } k \in \lbrace0,\ldots,n\rbrace. $$

So

$$ Q(x) := P(\lvert x\rvert) $$

sign-represents $f$ and has degree $C(F)$. Thus

$$ \deg_{\pm}(f) \leq C(F). $$

For the reverse inequality, suppose $Q(x_1,\ldots,x_n)$ is any degree $d$ polynomial that sign-represents $f$. Replacing $Q$ by its multilinear reduction modulo the Boolean identities $x_i^2 = x_i$ does not change its values on the cube and does not increase its degree. So we may assume $Q$ is multilinear.

Symmetrize it over all coordinate permutations:

$$ \overline Q(x) := \frac{1}{n!} \sum_{\pi \in \mathfrak{S}_n} Q(x_{\pi(1)},\ldots,x_{\pi(n)}). $$

This polynomial is symmetric and has degree at most $d$. On an input of Hamming weight $k$, every term in the average has sign $\sigma_k$, because $f$ is symmetric and $Q$ sign-represents $f$. Therefore $\overline Q$ also sign-represents $f$.

Every symmetric multilinear polynomial of degree at most $d$, restricted to the Boolean cube, is a univariate polynomial in the Hamming weight of degree at most $d$. Concretely, it is a linear combination of the elementary symmetric polynomials

$$ e_m(x) := \sum_{\lvert S\rvert=m} \prod_{i \in S} x_i, \qquad 0 \leq m \leq d, $$

and on inputs of weight $k$,

$$ e_m(x) = \binom{k}{m}, $$

which is a polynomial in $k$ of degree $m$.

Thus there is a univariate polynomial $R(k)$ of degree at most $d$ such that

$$ \mathrm{sgn}(R(k)) = \sigma_k \qquad \text{for every } k \in \lbrace0,\ldots,n\rbrace. $$

Whenever $t \in T$, the values $R(t-1)$ and $R(t)$ have opposite signs. By the intermediate value theorem, $R$ has a real root in the interval $(t-1,t)$. These intervals are disjoint for distinct $t \in T$, so $R$ has at least $C(F)$ distinct real roots.

A nonzero polynomial of degree at most $d$ has at most $d$ roots. Hence

$$ d \geq C(F). $$

Since this holds for every sign-representing polynomial $Q$ of degree $d$, we get

$$ \deg_{\pm}(f) \geq C(F). $$

Together the two inequalities prove

$$ \deg_{\pm}(f) = C(F). $$

$\blacksquare$

### Theorem 2. Shifted reciprocal Hamming-weight functions cost one head

Fix $r \gt 0$ and $d \in \mathbb{R}$. The scalar function

$$ \psi_{r,d}(x) := \frac{d}{\lvert x\rvert + r} $$

is a one-head atom in the sense of [010_linear_fractional_normal_form.md](010_linear_fractional_normal_form.md).

**Proof.** Choose

$$ \alpha \gt 1 + \frac{n}{r} $$

and set

$$ \gamma := (\alpha - 1)r - n. $$

Then $\gamma \gt 0$. In the one-head atom definition, take

$$ \rho_i = 1 \qquad \text{for every } i, $$

and

$$ \eta = (\alpha - 1)d, \qquad m_i = 0, \qquad \delta = 0. $$

If $k = \lvert x\rvert$, then

$$ \sum_{i=1}^{n} \alpha^{x_i} = n + (\alpha - 1)k. $$

So the atom is

$$ \frac{(\alpha - 1)d}{\gamma + n + (\alpha - 1)k} = \frac{(\alpha - 1)d}{(\alpha - 1)(r+k)} = \frac{d}{k+r}. $$

This is exactly $\psi_{r,d}(x)$. $\blacksquare$

### Theorem 3. C(F) heads realize the symmetric sign pattern

If $C(F) = 0$, then $f$ is constant, so $H^{\ast}(f) = 0$.

Assume now that $C := C(F) \geq 1$.

By Theorem 1, there is a degree $C$ univariate polynomial $P(z)$ such that

$$ \mathrm{sgn}(P(k)) = \sigma_k \qquad \text{for } k = 0,\ldots,n. $$

Choose distinct positive numbers

$$ r_1,\ldots,r_C \gt 0 $$

and define

$$ B(z) := \prod_{j=1}^{C} (z+r_j). $$

Since $B(k) \gt 0$ for every $k \in \lbrace0,\ldots,n\rbrace$, the rational function

$$ S(z) := \frac{P(z)}{B(z)} $$

has the same sign pattern as $P$ on the Hamming weights.

Because $\deg P \leq C = \deg B$ and the $r_j$ are distinct, the partial-fraction decomposition has the form

$$ S(z) = c + \sum_{j=1}^{C} \frac{d_j}{z+r_j} $$

for some real numbers

$$ c,d_1,\ldots,d_C \in \mathbb{R}. $$

By Theorem 2, each function

$$ x \mapsto \frac{d_j}{\lvert x\rvert+r_j} $$

is realized by one attention head. Therefore, using $C$ heads and constant offset $c$, the final score can be made equal to

$$ c + \sum_{j=1}^{C} \frac{d_j}{\lvert x\rvert+r_j} = S(\lvert x\rvert). $$

This score is positive exactly when $F(\lvert x\rvert) = 1$, and negative exactly when $F(\lvert x\rvert) = 0$. Hence

$$ H^{\ast}(f) \leq C(F). $$

$\blacksquare$

### Conclusion

By Theorem 1 and the general threshold-degree lower bound from [006_threshold_degree_head_complexity_bound.md](006_threshold_degree_head_complexity_bound.md),

$$ H^{\ast}(f) \geq \deg_{\pm}(f) = C(F). $$

By Theorem 3,

$$ H^{\ast}(f) \leq C(F). $$

Therefore

$$ H^{\ast}(f) = C(F). $$

$\blacksquare$

## Consequences

1. Monotone symmetric thresholds have one sign change, so $H^{\ast}(T_{n,t}) = 1$ for $1 \leq t \leq n$.

2. Parity has a sign change between every consecutive Hamming weight, so $H^{\ast}(\mathrm{XOR}_n) = n$.

3. Internal exact-count predicates have two sign changes. For $1 \leq k \leq n-1$, $H^{\ast}(\mathrm{EXACT}_{n,k}) = 2$.

The last item upgrades the earlier checkerboard lower bound for exact-count predicates from merely $H^{\ast} \geq 2$ to an exact value.
