# Endpoint Feature Fresh-XOR Exactness

## Statement

Let

$$ L(y)=\sum_{i\in S}\lambda_i y_i, \qquad \lambda_i\gt0, $$

with $S\neq\varnothing$. Set

$$ \Lambda:=\sum_{i\in S}\lambda_i, \qquad \mu:=\min_{i\in S}\lambda_i. $$

Define the positive endpoint features

$$ O_L(y):=\mathbf{1}[L(y)\gt0], \qquad A_L(y):=\mathbf{1}[L(y)=\Lambda]. $$

Then

$$ H^{\ast}(z\oplus O_L(y)) = H^{\ast}(1-(z\oplus O_L(y))) = 2, $$

and

$$ H^{\ast}(z\oplus A_L(y)) = H^{\ast}(1-(z\oplus A_L(y))) = 2. $$

> **Interpretation.** Fresh-bit XOR is hard in general, but it is exactly two heads for the positive OR-type and AND-type endpoint features used by the calibrated endpoint-vote theorem.

## Proof

Both endpoint features are nonconstant LTFs, so

$$ \deg_{\pm}(O_L)=\deg_{\pm}(A_L)=1. $$

The fresh-bit XOR threshold-degree theorem gives

$$ \deg_{\pm}(z\oplus O_L)=\deg_{\pm}(z\oplus A_L)=2. $$

Since threshold degree lower-bounds head complexity,

$$ H^{\ast}(z\oplus O_L)\geq2, \qquad H^{\ast}(z\oplus A_L)\geq2. $$

It remains to give two-head upper bounds. We do this by writing each fresh-XOR function as an affine slab and then applying [062_affine_slab_upper_bound.md](../03_function_families_and_affine_geometry/062_affine_slab_upper_bound.md).

### Lemma 1. OR endpoint

Let

$$ B:=\Lambda+\frac{\mu}{2}, \qquad M(z,y):=L(y)+Bz. $$

We claim that

$$ z\oplus O_L(y)=1 \qquad\Longleftrightarrow\qquad \frac{\mu}{2}\leq M(z,y)\leq \Lambda+\mu. $$

If $z=0$, then $z\oplus O_L=1$ exactly when $L(y)\gt0$. On the Boolean cube this means

$$ \mu\leq L(y)\leq \Lambda, $$

so the displayed slab condition holds. If $z=0$ and $L(y)=0$, then $M(z,y)=0$, below the slab.

If $z=1$, then $z\oplus O_L=1$ exactly when $L(y)=0$. In that case

$$ M(z,y)=B=\Lambda+\frac{\mu}{2}, $$

which lies in the slab. If $z=1$ and $L(y)\gt0$, then

$$ M(z,y)\geq B+\mu=\Lambda+\frac{3\mu}{2}, $$

which is above the slab.

Thus $z\oplus O_L$ is an affine slab, and hence

$$ H^{\ast}(z\oplus O_L)\leq2. $$

Combined with the lower bound, this proves $H^{\ast}(z\oplus O_L)=2$.

### Lemma 2. AND endpoint

Let

$$ M(z,y):=L(y)+\Lambda z. $$

We claim that

$$ z\oplus A_L(y)=1 \qquad\Longleftrightarrow\qquad \Lambda-\frac{\mu}{2}\leq M(z,y)\leq 2\Lambda-\frac{\mu}{2}. $$

If $z=0$, then $z\oplus A_L=1$ exactly when $L(y)=\Lambda$, giving $M(z,y)=\Lambda$, which lies in the slab. If $z=0$ and $L(y)\lt\Lambda$, then some coordinate in $S$ with weight at least $\mu$ is missing, so

$$ L(y)\leq\Lambda-\mu, $$

which is below the slab.

If $z=1$, then $z\oplus A_L=1$ exactly when $L(y)\lt\Lambda$. In that case

$$ \Lambda\leq M(z,y)\leq2\Lambda-\mu, $$

which lies in the slab. If $z=1$ and $L(y)=\Lambda$, then

$$ M(z,y)=2\Lambda, $$

which is above the slab.

Thus $z\oplus A_L$ is an affine slab, and hence

$$ H^{\ast}(z\oplus A_L)\leq2. $$

Combined with the lower bound, this proves $H^{\ast}(z\oplus A_L)=2$.

Finally, XNOR is the output complement of XOR, and output complement preserves head complexity by [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md). This proves the two XNOR equalities as well. $\blacksquare$

## Consequences

For every nonempty $S$,

$$ H^{\ast} \left(z\oplus \mathrm{OR}_S(y)\right) = H^{\ast} \left(z\oplus \mathrm{AND}_S(y)\right) = 2, $$

and the same holds for the corresponding XNOR functions.

This shows that the generic one-bit LTF branching bound

$$ H^{\ast}(z\oplus T)\leq1+\lvert\mathrm{supp}(T)\rvert $$

can be very loose even for endpoint LTFs. The endpoint geometry collapses the fresh-XOR function to a two-head affine slab.
