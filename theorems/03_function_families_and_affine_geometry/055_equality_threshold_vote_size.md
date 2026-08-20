# Equality Has Threshold-Vote Size Two

## Statement

Let $s_{\mathrm{LTF}}(f)$ be the minimum threshold-vote size from [054_three_bit_threshold_vote_invariant.md](054_three_bit_threshold_vote_invariant.md). For

$$ \mathrm{EQ}_m(x,y)=\mathbf{1}[x=y], \qquad x,y\in\lbrace0,1\rbrace^m, $$

we have, for every $m\geq1$,

$$ s_{\mathrm{LTF}}(\mathrm{EQ}_m)=2. $$

> **Interpretation.** Equality is a family where threshold-vote size and head complexity agree: both $s_{\mathrm{LTF}}(\mathrm{EQ}_m)$ and $H^{\ast}(\mathrm{EQ}_m)$ equal $2$.

## Proof

### Lemma 1. Two threshold gates compute equality

Encode each $m$-bit string by the injective positive-weighted sum

$$ T(x):=\sum_{i=1}^{m}2^{i-1}x_i. $$

Define two comparison predicates

$$ G_{\mathrm{gt}}(x,y):=\mathbf{1}[T(x)-T(y)\geq1], \qquad G_{\mathrm{lt}}(x,y):=\mathbf{1}[T(y)-T(x)\geq1]. $$

Both are linear threshold functions in the $2m$ input bits. Since $T$ is injective on $\lbrace0,1\rbrace^m$,

$$ x=y \qquad\Longleftrightarrow\qquad G_{\mathrm{gt}}(x,y)=0 \text{ and } G_{\mathrm{lt}}(x,y)=0. $$

Thus

$$ \mathrm{EQ}_m(x,y)=1 \qquad\Longleftrightarrow\qquad \frac{1}{2}-G_{\mathrm{gt}}(x,y)-G_{\mathrm{lt}}(x,y)\gt0. $$

This is a weighted vote of two linear threshold functions, so

$$ s_{\mathrm{LTF}}(\mathrm{EQ}_m)\leq2. $$

### Lemma 2. Equality is not one threshold gate

It remains to rule out $s_{\mathrm{LTF}}(\mathrm{EQ}_m)\leq1$. The function is nonconstant, so $s _{\mathrm{LTF}}(\mathrm{EQ}_m)\neq0$.

If $\mathrm{EQ}_m$ were a single linear threshold function, then every restriction would also be a linear threshold function. Restrict

$$ x_i=y_i=0 \qquad \text{for }2\leq i\leq m. $$

The remaining two-bit function is

$$ \mathrm{EQ}_1(a,b)=\mathbf{1}[a=b]. $$

This is true on $(0,0)$ and $(1,1)$ and false on $(0,1)$ and $(1,0)$. If an affine score $A(a,b)=\alpha a+\beta b+\gamma$ were positive exactly on the true inputs, then

$$ \gamma\gt0, \qquad \alpha+\beta+\gamma\gt0, $$

while

$$ \alpha+\gamma\lt0, \qquad \beta+\gamma\lt0. $$

Adding the last two inequalities gives

$$ \alpha+\beta+2\gamma\lt0. $$

Since $\gamma\gt0$, this implies

$$ \alpha+\beta+\gamma\lt-\gamma\lt0, $$

contradicting $\alpha+\beta+\gamma\gt0$. Hence $\mathrm{EQ}_1$ is not an LTF, and neither is $\mathrm{EQ}_m$.

Therefore

$$ s_{\mathrm{LTF}}(\mathrm{EQ}_m)\geq2. $$

Combining the upper and lower bounds gives

$$ s_{\mathrm{LTF}}(\mathrm{EQ}_m)=2. $$

$\blacksquare$

## Consequence

For $m=2$, the finite enumeration in `src/hstar/threshold_votes.py` also finds $\mathrm{EQ}_2$ in the two-vote closure. Running

```bash
python -m src.hstar.threshold_votes --summary four-bit-targets
```

reports that $\mathrm{EQ}_2$ is not an LTF but is covered by two threshold votes.

The head-complexity analogue is resolved in [060_equality_exact_two_heads.md](060_equality_exact_two_heads.md):

$$ H^{\ast}(\mathrm{EQ}_m)=2 \qquad \text{for every }m\geq1. $$
