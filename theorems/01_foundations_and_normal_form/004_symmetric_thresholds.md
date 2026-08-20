# One Head Computes Symmetric Thresholds

## Statement

For $n \geq 1$ and $1 \leq t \leq n$, define the symmetric threshold function

$$ T_{n,t}(x)  =  \mathbf{1} \left[ \lvert x\rvert \geq t \right] $$

where $\lvert x\rvert$ is the Hamming weight.

Then $T_{n,t}$ is computable with one head. Since $T_{n,t}$ is nonconstant for $1 \leq t \leq n$, it follows that

$$ H^{\ast}(T_{n,t})  =  1. $$

This includes:

- $\mathrm{OR}_n$, which is $T _{n,1}$,
- $\mathrm{AND}_n$, which is $T _{n,n}$,
- $\mathrm{MAJORITY}_n$, which is $T _{n,\lceil n/2 \rceil}$.

## Construction

We use the model from [../model.md](../../model.md) with

$$ d_{\mathrm{model}} = d_{\mathrm{head}} = 2. $$

Work in $\mathbb{R}^{2}$ with basis vectors $u = (1,0)$ and $v = (0,1)$.

Choose token embeddings

$$ e_{0} = (0,0), \qquad e_{1} = (1,1), \qquad e_{=} = (1,0), $$

and set all positional embeddings to zero.

Choose linear maps

$$ W_Q  =  W_K  =  \begin{pmatrix} 1 & 0 \cr 0 & 0 \end{pmatrix}, \qquad W_V  =  \begin{pmatrix} 0 & 0 \cr 0 & 1 \end{pmatrix}, \qquad W_O  =  I_2. $$

## What This Does

For an input-bit position:

1. If the bit is $0$, then its embedded vector is $(0,0)$.
   - Its attention logit against the query is $0$, so its softmax weight numerator is $\exp(0) = 1$.
   - Its value vector is $0$.
2. If the bit is $1$, then its embedded vector is $(1,1)$.
   - Its attention logit against the query is $1$, so its softmax weight numerator is $\exp(1) = e$.
   - Its value vector is $v$.

For the query token itself:

- its embedded vector is $(1,0)$,
- its attention logit is also $1$, so its softmax numerator is $e$,
- its value vector is $0$.

Because $W_O = I_2$, the projected one-head contribution is exactly the same as the unprojected one. Thus if the input has Hamming weight $k$, the query update is

$$ z(k)  =  s(k)  v $$

with

$$ s(k)  =  \frac{e  k}{e  k + (n-k) + e}. $$

So the entire head output lies on a single ray, and the only thing that matters is the scalar score $s(k)$.

## Monotonicity Theorem

**Claim.** The function $s(k)$ is strictly increasing in $k$.

**Proof.** Write

$$ s(k)  =  \frac{e  k}{(e-1)k + n + e}. $$

For integer $0 \leq k \lt n$,

$$ s(k+1) - s(k)  =  \frac{e (n+e)}{\bigl((e-1)k + n + e\bigr)\bigl((e-1)(k+1) + n + e\bigr)}, $$

which is strictly positive. Hence

$$ s(0)  \lt  s(1)  \lt  \cdots  \lt  s(n). \qquad \blacksquare $$

## Readout

Take the linear probe $w = v$. Then the probe score on an input of Hamming weight $k$ is exactly

$$ \langle w,  z(k) \rangle  =  s(k). $$

Because $s(k)$ is strictly increasing, for every threshold index $t \in \lbrace1, \ldots, n\rbrace$ we can choose any $\tau$ with

$$ s(t-1)  \lt  \tau  \lt  s(t). $$

Then $\langle w, z(x) \rangle \gt \tau$ holds exactly when $\lvert x\rvert \geq t$. So the head computes $T_{n,t}$.

## Exact Complexity

Zero heads only give a constant query residual, so no nonconstant function can be computed with zero heads. Since each $T_{n,t}$ with $1 \leq t \leq n$ is nonconstant, we conclude

$$ H^{\ast}(T_{n,t})  =  1. $$

## Why This Matters

This is a broad upper bound family:

- one head already computes all monotone symmetric threshold functions,
- therefore one head is not merely capable of $\mathrm{OR}$ and $\mathrm{AND}$,
- it already reaches $\mathrm{MAJORITY}$ and every other Hamming-weight threshold.

So the interesting gap is not between linear threshold functions and attention heads. The gap appears when the target needs a *middle band* or *alternating* dependence on Hamming weight, such as parity or exact-count predicates.
