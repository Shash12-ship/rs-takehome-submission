# Parity Has Threshold Degree Exactly n

## Statement

For

$$ \mathrm{PARITY}_n(x) = x_1 \oplus \cdots \oplus x_n, $$

we have

$$ \deg_{\pm}(\mathrm{PARITY}_n) = n. $$

Here $\deg_{\pm}$ is the threshold degree, the least degree of a real polynomial that sign-represents the function on $\lbrace0,1\rbrace^n$ (see [006_threshold_degree_head_complexity_bound.md](006_threshold_degree_head_complexity_bound.md)).

## Proof

### Lower bound: no degree-(<n) sign representation

Let $\mathrm{PARITY}_n(x)$ be $1$ when $\sum_i x_i$ is odd and $0$ when it is even. We show no real polynomial of degree less than $n$ can sign-represent it on $\lbrace0,1\rbrace^n$.

It is more convenient to pass to $\lbrace-1,1\rbrace$ variables. Define

$$z_i := 1 - 2 x_i.$$

Then $z_i = 1$ when $x_i = 0$ and $z_i = -1$ when $x_i = 1$.

The parity sign function is

$$\pi(z) := -\prod_{i=1}^{n} z_i.$$

Indeed, $\prod_i z_i = (-1)^{x_1 + \cdots + x_n}$, which is $+1$ on even parity and $-1$ on odd parity, so multiplying by $-1$ makes $\pi(z)$ positive exactly on odd inputs.

Now suppose, toward a contradiction, that there were a polynomial $Q(z_1, \ldots, z_n)$ of degree less than $n$ such that

$$Q(z) \gt 0 \text{ whenever } \pi(z) = 1,$$

$$Q(z) \lt 0 \text{ whenever } \pi(z) = -1.$$

Equivalently,

$$\pi(z)   Q(z) \gt 0$$

for every $z \in \lbrace-1,1\rbrace^n$.

Since the cube is finite, averaging gives

$$\mathbb{E}[\pi(z)   Q(z)] \gt 0.$$

We now show that this expectation must in fact be zero.

For each subset $S \subseteq \lbrace1, \ldots, n\rbrace$, define the Walsh character

$$\chi_S(z) := \prod_{i \in S} z_i.$$

Every real-valued function on $\lbrace-1,1\rbrace^n$ can be written uniquely as a linear combination of these characters. In particular, every polynomial of degree less than $n$, restricted to the cube, has an expansion

$$Q(z) = \sum_{S \subsetneq [n]} c_S   \chi_S(z),$$

where only subsets $S$ of size strictly less than $n$ occur.

This is because on the cube $z_i^2 = 1$, so every monomial reduces to a squarefree monomial without increasing degree, and squarefree monomials are exactly the Walsh characters.

Also,

$$\pi(z) = -\chi_{[n]}(z).$$

Using orthogonality of the Walsh characters,

$$\mathbb{E}[\chi_{[n]}(z)   \chi_S(z)] = 0$$

for every proper subset $S \subsetneq [n]$.

The reason is that

$$\chi_{[n]}(z)   \chi_S(z) = \chi_{[n]  \triangle  S}(z),$$

and $[n]  \triangle  S$ is nonempty when $S \neq [n]$. The expectation of a nontrivial character over the uniform cube is zero, because if $T$ is nonempty then

$$\mathbb{E}[\chi_T(z)] = \prod_{i \in T} \mathbb{E}[z_i] = 0.$$

Therefore

$$\mathbb{E}[\pi(z)   Q(z)] = -\sum_{S \subsetneq [n]} c_S   \mathbb{E}[\chi_{[n]}(z)   \chi_S(z)] = 0.$$

This contradicts the earlier inequality $\mathbb{E}[\pi(z)   Q(z)] \gt 0$.

So no degree $(\lt n)$ polynomial sign-represents parity.

### Upper bound: a degree-n sign representation

Define

$$ P_{\mathrm{par}}(x) := -\prod_{i=1}^{n} (1 - 2x_i). $$

This is a polynomial of degree $n$. On the Boolean cube, each factor $1 - 2x_i$ equals $+1$ when $x_i = 0$ and $-1$ when $x_i = 1$, so

$$ P_{\mathrm{par}}(x) = -(-1)^{x_1 + \cdots + x_n}. $$

Therefore $P_{\mathrm{par}}(x)$ is positive exactly on odd-parity inputs and negative exactly on even-parity inputs. So parity has threshold degree at most $n$.

Combining the lower and upper bounds gives

$$ \deg_{\pm}(\mathrm{PARITY}_n) = n. \qquad \blacksquare $$
