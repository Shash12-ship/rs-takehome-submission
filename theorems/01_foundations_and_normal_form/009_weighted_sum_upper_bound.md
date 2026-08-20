# Weighted-Sum Interpolation Upper Bound

## Statement

Let $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$.

Suppose there exist positive real numbers

$$ \lambda_1, \ldots, \lambda_n \gt 0 $$

and a function

$$ F : \mathrm{Im}(t) \to \lbrace0,1\rbrace, $$

where

$$ t(x) := \sum_{i=1}^{n} \lambda_i x_i, $$

such that

$$ f(x) = F(t(x)) $$

for every $x \in \lbrace0,1\rbrace^n$.

Let

$$ M := \lvert\mathrm{Im}(t)\rvert. $$

Then

$$ H^{\ast}(f) \leq M - 1. $$

> **Equivalently.** If a Boolean function depends only on a positive weighted sum of the input bits, then one can realize it with one head per distinct nonzero level of that statistic.

## Proof

We work in the formal model from [../model.md](../../model.md).

Set

$$ \Lambda := \sum_{i=1}^{n} \lambda_i. $$

Because every $\lambda_i$ is positive, the image of $t$ consists of $M$ distinct nonnegative numbers. Write them in increasing order as

$$ 0 = \tau_0 \lt \tau_1 \lt \cdots \lt \tau_{M-1}. $$

We will build an explicit $(M-1)$-head network whose score depends only on $t(x)$, and whose head outputs form a basis of all real-valued functions on $\mathrm{Im}(t)$.

### Shared Ambient Space And Embeddings

Take

$$ d_{\mathrm{model}} = d_{\mathrm{head}} = M + 2. $$

Work in $\mathbb{R}^{M+2}$ with orthonormal basis

$$ q, r, u, e_1, \ldots, e_{M-1}. $$

Choose token embeddings

$$ \mathrm{token}(0) = 0, \qquad \mathrm{token}(1) = u, \qquad \mathrm{token}(=) = q, $$

and positional embeddings

$$ p_i = (\log \lambda_i)   r \quad \text{for } 1 \leq i \leq n, \qquad p_= = 0. $$

Thus an input token at position $i$ is represented by

$$ u_i(x) = \begin{cases} (\log \lambda_i)   r & \text{if } x_i = 0, \cr u + (\log \lambda_i)   r & \text{if } x_i = 1. \end{cases} $$

The query token is represented by the constant vector $q$.

### Head j

Fix distinct real numbers

$$ \alpha_1, \ldots, \alpha_{M-1} \gt 1. $$

For each $j \in \lbrace1, \ldots, M-1\rbrace$, define linear maps as follows.

1. $W_Q^{(j)}$ sends $q$ to $q$ and annihilates the orthogonal complement of $q$.
2. $W_K^{(j)}$ sends $r$ to $q$, sends $u$ to $(\log \alpha_j)   q$, and annihilates $q, e_1, \ldots, e_{M-1}$.
3. $W_V^{(j)}$ sends $u$ to $e_j$ and annihilates $q, r, e_1, \ldots, e_{M-1}$.
4. $W_O^{(j)}$ is the identity on $\mathbb{R}^{M+2}$.

These choices define a valid attention head in the model from [../model.md](../../model.md).

### Theorem 1. The output of head j depends only on t(x)

For every input $x$,

$$ y^{(j)}(x) = g_j(t(x))   e_j, $$

where

$$ g_j(s) := \frac{\alpha_j s}{1 + \Lambda + (\alpha_j - 1) s}. $$

**Proof.** Fix a position $i$.

If $x_i = 0$, the embedded vector is $(\log \lambda_i)   r$. Therefore:

$$ W_K^{(j)} u_i(x) = (\log \lambda_i)   q, $$

so the logit at that position is $\log \lambda_i$ and the unnormalized attention weight is $\lambda_i$. Also

$$ W_V^{(j)} u_i(x) = 0. $$

If $x_i = 1$, the embedded vector is $u + (\log \lambda_i)   r$. Therefore:

$$ W_K^{(j)} u_i(x) = \bigl(\log \alpha_j + \log \lambda_i \bigr) q, $$

so the logit is $\log(\alpha_j \lambda_i)$ and the unnormalized attention weight is $\alpha_j \lambda_i$. Also

$$ W_V^{(j)} u_i(x) = e_j. $$

For the query token, the embedding is $q$. Since $W_K^{(j)} q = 0$ and $W_V^{(j)} q = 0$, the query position contributes unnormalized weight $1$ and value $0$.

So the numerator vector of head $j$ is

$$ \sum_{i : x_i = 1} \alpha_j \lambda_i   e_j = \alpha_j \left( \sum_{i=1}^{n} \lambda_i x_i \right) e_j = \alpha_j t(x)   e_j, $$

while the denominator is

$$ \begin{aligned} 1 + \sum_{i : x_i = 0} \lambda_i + \sum_{i : x_i = 1} \alpha_j \lambda_i &= 1 + \sum_{i=1}^{n} \lambda_i + (\alpha_j - 1) \sum_{i=1}^{n} \lambda_i x_i \cr &= 1 + \Lambda + (\alpha_j - 1) t(x). \end{aligned} $$

Hence

$$ y^{(j)}(x) = \frac{\alpha_j t(x)}{1 + \Lambda + (\alpha_j - 1) t(x)}   e_j = g_j(t(x))   e_j. $$

This proves the formula. $\blacksquare$

### Theorem 2. The functions 1, g₁, …, g_M-1 are linearly independent on Im(t)

**Proof.** Suppose

$$ c_0 + \sum_{j=1}^{M-1} c_j g_j(\tau) = 0 $$

for every $\tau \in \mathrm{Im}(t)$.

Evaluating at $\tau_0 = 0$ gives $c_0 = 0$, because $g_j(0) = 0$ for every $j$.

Now fix $m \in \lbrace1, \ldots, M-1\rbrace$. Since $\tau_m \gt 0$, we may divide by $\tau_m$ and obtain

$$ \sum_{j=1}^{M-1} \frac{c_j \alpha_j}{1 + \Lambda + (\alpha_j - 1) \tau_m} = 0. $$

Define

$$ r_j := \frac{1 + \Lambda}{\alpha_j - 1}, \qquad d_j := \frac{c_j \alpha_j}{\alpha_j - 1}. $$

Then the relation becomes

$$ \sum_{j=1}^{M-1} \frac{d_j}{\tau_m + r_j} = 0 $$

for every $m = 1, \ldots, M-1$.

Now consider the rational function

$$ R(s) := \sum_{j=1}^{M-1} \frac{d_j}{s + r_j}. $$

Multiply by the common denominator to get

$$ N(s) := R(s) \prod_{j=1}^{M-1} (s + r_j) = \sum_{j=1}^{M-1} d_j \prod_{\ell \neq j} (s + r_{\ell}). $$

This is a polynomial of degree at most $M - 2$.

Because $R(\tau_m) = 0$ for $m = 1, \ldots, M-1$, the polynomial $N$ vanishes at the $M-1$ distinct points

$$ \tau_1, \ldots, \tau_{M-1}. $$

A polynomial of degree at most $M-2$ with $M-1$ distinct roots must be the zero polynomial. So

$$ N(s) \equiv 0. $$

Now fix $j$ and evaluate this zero polynomial at $s = -r_j$. Every term vanishes except the $j$-th one, so

$$ d_j \prod_{\ell \neq j} (r_{\ell} - r_j) = 0. $$

Because the $\alpha_j$ are distinct, the $r_j$ are distinct as well, so the product is nonzero. Therefore $d_j = 0$ for every $j$.

Hence every $c_j = 0$, and the functions $1, g_1, \ldots, g_{M-1}$ are linearly independent on $\mathrm{Im}(t)$. $\blacksquare$

### Corollary 3. The functions 1, g₁, …, g_M-1 form a basis of all real-valued functions on Im(t)

**Reason.** The set $\mathrm{Im}(t)$ has exactly $M$ points, so the vector space of real-valued functions on it has dimension $M$. By Theorem 2 we already have $M$ linearly independent functions on that set. $\blacksquare$

### Theorem 4. M-1 heads realize f exactly

**Proof.** Define a target sign pattern on $\mathrm{Im}(t)$ by

$$ \sigma(\tau) := \begin{cases} +1 & \text{if } F(\tau) = 1, \cr -1 & \text{if } F(\tau) = 0. \end{cases} $$

By Corollary 3, there exist coefficients

$$ \beta_0, \beta_1, \ldots, \beta_{M-1} $$

such that

$$ \beta_0 + \sum_{j=1}^{M-1} \beta_j g_j(\tau) = \sigma(\tau) $$

for every $\tau \in \mathrm{Im}(t)$.

Choose the final readout vector

$$ w := \sum_{j=1}^{M-1} \beta_j e_j. $$

Since $w$ is orthogonal to $q$, the constant query skip connection makes no contribution to the readout.

Let $r(x)$ be the final residual stream at the query token. By Theorem 1,

$$ w^\top r(x) = \sum_{j=1}^{M-1} \beta_j g_j(t(x)). $$

Now choose threshold

$$ \tau_{\mathrm{out}} := -\beta_0. $$

Then

$$ \begin{aligned} w^\top r(x) - \tau_{\mathrm{out}} &= \beta_0 + \sum_{j=1}^{M-1} \beta_j g_j(t(x)) \cr &= \sigma(t(x)). \end{aligned} $$

So this affine score is positive exactly when $F(t(x)) = 1$, and negative exactly when $F(t(x)) = 0$. Since $f(x) = F(t(x))$, the resulting $(M-1)$-head model computes $f$ exactly.

Therefore

$$ H^{\ast}(f) \leq M - 1. $$

This completes the proof of the theorem. $\blacksquare$

## Consequences

### Positive Weighted-Sum Image Complexity

Define

$$ M_{+}(f) := \min \left\lbrace \lvert \mathrm{Im}\left(\sum_{i=1}^{n} \lambda_i x_i\right) \rvert : \lambda_1, \ldots, \lambda_n \gt 0, f(x) = F \left(\sum_{i=1}^{n} \lambda_i x_i\right) \text{ for some } F \right\rbrace. $$

The theorem implies

$$ H^{\ast}(f) \leq M_{+}(f) - 1. $$

This gives a candidate upper-bound invariant for the first core question in [../problem_statement.md](../../problem_statement.md).

**Update.** The later note [013_positive_projection_sign_changes.md](013_positive_projection_sign_changes.md) sharpens this bound. For a fixed positive weighted sum $t$, the head count can be bounded by the number of label changes along the ordered image of $t$, not by the total number of nonzero image levels.

### Corollary 5. Every symmetric Boolean function has head complexity at most n

If $f$ is symmetric, take

$$ \lambda_1 = \cdots = \lambda_n = 1. $$

Then

$$ t(x) = x_1 + \cdots + x_n = \lvert x\rvert, $$

so

$$ \mathrm{Im}(t) = \lbrace0,1,\ldots,n\rbrace $$

and $M = n+1$. Therefore

$$ H^{\ast}(f) \leq n. $$

### Corollary 6. Universal upper bound

For an arbitrary Boolean function $f$, take binary weights

$$ \lambda_i = 2^{i-1}. $$

Then

$$ t(x) = \sum_{i=1}^{n} 2^{i-1} x_i $$

is injective on $\lbrace0,1\rbrace^n$, so

$$ \lvert\mathrm{Im}(t)\rvert = 2^n. $$

Therefore every Boolean function satisfies

$$ H^{\ast}(f) \leq 2^n - 1. $$
