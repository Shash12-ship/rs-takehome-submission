# Exact Parity Complexity

## Statement

For every $n \geq 1$, in the one-layer attention-only model from [../../model.md](../../model.md), the $n$-bit parity / XOR function

$$\mathrm{XOR}_n(x_1, \ldots, x_n) = x_1 \oplus \cdots \oplus x_n$$

has exact head complexity

$$H^{\ast}(\mathrm{XOR}_n) = n.$$

> **Equivalently.** In this one-layer attention model, parity needs exactly one head per input bit.

The proof combines a threshold-degree lower bound with an explicit construction.

## Lower Bound

If $\mathrm{XOR}_n$ were computable with fewer than $n$ heads, then by the threshold-degree bound [006_threshold_degree_head_complexity_bound.md](006_threshold_degree_head_complexity_bound.md) it would have threshold degree less than $n$. But parity has threshold degree exactly $n$ [007_parity_threshold_degree.md](007_parity_threshold_degree.md). This is a contradiction, so

$$H^{\ast}(\mathrm{XOR}_n) \geq n.$$

## Upper Bound

We now construct an explicit $n$-head network computing parity.

### Shared ambient space and embeddings

Take

$$ d_{\mathrm{model}} = d_{\mathrm{head}} = n + 2. $$

Work in $\mathbb{R}^{n+2}$.

Choose an orthonormal basis

$$q, u, e_1, \ldots, e_n.$$

Use shared token embeddings

$$\mathrm{token}(0) = 0, \qquad \mathrm{token}(1) = u, \qquad \mathrm{token}(=) = q,$$

and set all positional embeddings to zero.

So the query token always carries the constant vector $q$, every `0` token is the zero vector, and every `1` token is the vector $u$.

### Head j

Fix distinct parameters $\alpha_1, \ldots, \alpha_n$, all greater than $1$. For concreteness one may take

$$\alpha_j = 2^j.$$

For head $j$, define linear maps as follows.

1. $W_Q^{(j)}$ sends $q$ to $q$ and annihilates the orthogonal complement of $q$.
2. $W_K^{(j)}$ sends $u$ to $(\log \alpha_j)   q$ and annihilates $q, e_1, \ldots, e_n$.
3. $W_V^{(j)}$ sends $u$ to $e_j$ and annihilates $q, e_1, \ldots, e_n$.
4. $W_O^{(j)}$ is the identity on $\mathbb{R}^{n+2}$.

These maps are linear, so they define a valid attention head.

### Theorem 1. The output of head j depends only on Hamming weight

Let $k = x_1 + \cdots + x_n$ be the Hamming weight of the input.

Then the projected output of head $j$ is

$$y_j(x) = g_j(k)   e_j$$

where

$$g_j(k) = \frac{k   \alpha_j}{n + 1 + (\alpha_j - 1)   k}.$$

#### Proof

We compute the logits first.

1. If an input token is `1`, its embedding is $u$. So $W_K^{(j)} u = (\log \alpha_j)   q$. The query vector is $q$, and $W_Q^{(j)} q = q$, so the raw logit is $\langle (\log \alpha_j)   q, q \rangle = \log \alpha_j$.
2. If an input token is `0`, its embedding is $0$, so its key is $0$ and its logit is $0$.
3. The query token itself has embedding $q$, but $W_K^{(j)} q = 0$, so its self-logit is also $0$.

Therefore:

1. each `1`-token contributes unnormalized attention weight $\alpha_j$,
2. each `0`-token contributes unnormalized attention weight $1$,
3. the query token contributes unnormalized attention weight $1$.

Now compute the values.

1. A `1`-token has embedding $u$, and $W_V^{(j)} u = e_j$.
2. A `0`-token has embedding $0$, so its value is $0$.
3. The query token has embedding $q$, and $W_V^{(j)} q = 0$.

So if the input has Hamming weight $k$, then:

1. the numerator vector is $k   \alpha_j   e_j$,
2. the denominator scalar is $(n - k) \cdot 1 + k \cdot \alpha_j + 1$.

Hence

$$y_j(x) = \frac{k   \alpha_j}{(n - k) + k   \alpha_j + 1}   e_j = \frac{k   \alpha_j}{n + 1 + (\alpha_j - 1)   k}   e_j.$$

This proves the formula.

### Theorem 2. The functions 1, g₁, …, gₙ are linearly independent on {0, …, n}

Consider the $n + 1$ real-valued functions on the set $\lbrace0, \ldots, n\rbrace$

$$1,   g_1,   \ldots,   g_n.$$

These functions are linearly independent.

#### Proof

Assume

$$c_0 + \sum_{j=1}^{n} c_j   g_j(k) = 0$$

for every $k = 0, 1, \ldots, n$.

At $k = 0$, every $g_j(0) = 0$, so $c_0 = 0$.

For $k = 1, \ldots, n$, divide by $k$ to obtain

$$\sum_{j=1}^{n} \frac{c_j   \alpha_j}{n + 1 + (\alpha_j - 1)   k} = 0.$$

Define

$$r_j := \frac{n + 1}{\alpha_j - 1}, \qquad d_j := \frac{c_j   \alpha_j}{\alpha_j - 1}.$$

Then the relation becomes

$$\sum_{j=1}^{n} \frac{d_j}{k + r_j} = 0$$

for every $k = 1, \ldots, n$.

Now consider the rational function

$$R(t) := \sum_{j=1}^{n} \frac{d_j}{t + r_j}.$$

Multiply by the common denominator to get

$$ N(t) := R(t) \prod_{j=1}^{n} (t + r_j) = \sum_{j=1}^{n} d_j \prod_{m \neq j} (t + r_m). $$

This is a polynomial of degree at most $n - 1$.

But $R(k) = 0$ for $k = 1, \ldots, n$, so $N(k) = 0$ for those $n$ distinct values.

A polynomial of degree at most $n - 1$ with $n$ distinct roots must be the zero polynomial. Therefore $N(t) \equiv 0$.

Now fix $j$ and evaluate the zero polynomial $N$ at $t = -r_j$. Every term vanishes except the $j$-th one, so

$$d_j \prod_{m \neq j} (r_m - r_j) = 0.$$

Because the $\alpha_j$ are distinct, the $r_j$ are distinct as well, so the product is nonzero. Therefore $d_j = 0$.

So every $d_j = 0$, hence every $c_j = 0$.

Therefore $1, g_1, \ldots, g_n$ are linearly independent.

### Corollary 3. 1, g₁, …, gₙ form a basis of all functions on {0, …, n}

The set $\lbrace0, \ldots, n\rbrace$ has exactly $n + 1$ points, so the vector space of real-valued functions on this set has dimension $n + 1$.

By Theorem 2 we already have $n + 1$ linearly independent functions.

Therefore $1, g_1, \ldots, g_n$ form a basis.

### Theorem 4. n heads can realize parity exactly

Define a target sign pattern on Hamming weights by

$$t_k := +1 \text{ if } k \text{ is odd}, \qquad t_k := -1 \text{ if } k \text{ is even}.$$

By Corollary 3, there exist coefficients $\beta_0, \beta_1, \ldots, \beta_n$ such that

$$\beta_0 + \sum_{j=1}^{n} \beta_j   g_j(k) = t_k$$

for every $k = 0, \ldots, n$.

Now choose the final linear probe

$$w := \sum_{j=1}^{n} \beta_j   e_j.$$

Since $w$ is orthogonal to $q$, the constant query skip connection does not affect the probe score.

By Theorem 1, on an input of Hamming weight $k$,

$$\Bigl\langle w, \sum_{j=1}^{n} y_j(x) \Bigr\rangle = \sum_{j=1}^{n} \beta_j   g_j(k).$$

So the full affine score

$$S(x) := \beta_0 + \Bigl\langle w, \sum_{j=1}^{n} y_j(x) \Bigr\rangle$$

satisfies

$$S(x) = t_k,$$

where $k = \lvert x\rvert$.

Therefore:

1. $S(x) = +1$ on odd-parity inputs,
2. $S(x) = -1$ on even-parity inputs.

So thresholding at $0$ computes $\mathrm{XOR}_n$ exactly. Hence

$$H^{\ast}(\mathrm{XOR}_n) \leq n.$$

## Conclusion

We proved:

1. $H^{\ast}(\mathrm{XOR}_n) \geq n$ by threshold degree,
2. $H^{\ast}(\mathrm{XOR}_n) \leq n$ by explicit construction.

Therefore

$$H^{\ast}(\mathrm{XOR}_n) = n. \qquad \blacksquare$$

## Remarks

1. The lower bound uses only the one-layer attention structure and the linear readout.
2. The upper bound uses no positional embeddings.
3. The upper-bound construction actually proves more: $n$ heads suffice to realize every symmetric Boolean function of Hamming weight, not just parity, because the basis interpolation works for any target values on $k = 0, \ldots, n$.
