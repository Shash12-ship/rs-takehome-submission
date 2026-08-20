# Twelve-Bit Hamming-Threshold Strict Separation

## Statement

For $x,y\in\lbrace0,1\rbrace^6$, let

$$ \Delta(x,y):=\sum_{i=1}^{6}(x_i+y_i-2x_i y_i). $$

Thus $\Delta(x,y)$ is the Hamming distance between $x$ and $y$. Define $f_{\mathrm{Ham}}:\lbrace0,1\rbrace^{12}\to\lbrace0,1\rbrace$ by

$$ f_{\mathrm{Ham}}(x,y)=1 \qquad\Longleftrightarrow\qquad \Delta(x,y)\geq3. $$

Then

$$ \deg_{\pm}(f_{\mathrm{Ham}})=2 \qquad\text{and}\qquad H^{\ast}(f_{\mathrm{Ham}})\geq3. $$

In particular,

$$ \deg_{\pm}(f_{\mathrm{Ham}})\lt H^{\ast}(f_{\mathrm{Ham}}). $$

> **Interpretation.** Thresholding the Hamming distance between two six-bit strings gives an explicit twelve-bit strict separation. A deterministic finite certificate proves the sign-rank obstruction.

## Proof

### Lemma 1. An eight-column restriction hits every two-dimensional tope cycle

For a six-bit string $y$, define

$$ \mathrm{code}(y):=\sum_{i=1}^{6}2^{i-1}y_i. $$

Choose eight strings $y^{(1)},\ldots,y^{(8)}$ with codes

$$ \bigl(\mathrm{code}(y^{(1)}),\ldots,\mathrm{code}(y^{(8)})\bigr)=(43,29,37,19,48,36,8,62). $$

Define the $64\times8$ sign matrix $S$ by

$$ S_{x,j}:=\begin{cases}+1,&\Delta(x,y^{(j)})\geq3,\cr-1,&\Delta(x,y^{(j)})\lt3.\end{cases} $$

Encode each row sign by the eight-bit integer

$$ \rho(x):=\sum_{j=1}^{8}2^{j-1}\frac{1-S_{x,j}}{2}. $$

The canonical representatives of the resulting antipodal row classes are

$$ \mathcal{R}:=\left\lbrace\min\lbrace\rho(x),255-\rho(x)\rbrace:x\in\lbrace0,1\rbrace^6\right\rbrace. $$

Direct evaluation gives $64$ distinct representatives, namely

$$ \mathcal{R}=\lbrace1,2,3,8,9,10,11,12,13,14,19,24,25,26,27,28,32,36,37,38,39,47,48,49,50,52,53,54,55,61,62,63,64,65,67,69,70,72,73,74,75,76,77,79,82,88,91,94,98,100,103,110,112,113,115,116,117,118,119,121,122,124,125,127\rbrace. $$

Let

$$ \widehat{\mathcal{R}}:=\mathcal{R}\cup\lbrace255-r:r\in\mathcal{R}\rbrace. $$

The finite certificate is the following assertion. For every $a\in\lbrace0,\ldots,127\rbrace$ and every permutation $\pi$ of $\lbrace1,\ldots,8\rbrace$, define

$$ v_0:=a, \qquad v_k:=a\oplus2^{\pi(1)-1}\oplus\cdots\oplus2^{\pi(k)-1} \quad\text{for }1\leq k\leq7. $$

Then

$$ \lbrace v_0,\ldots,v_7\rbrace\cap\widehat{\mathcal{R}}\neq\varnothing. $$

The script [verify_hamming_distance_separation.py](../../artifacts/calculations/verify_hamming_distance_separation.py) checks this assertion using integer arithmetic. It enumerates all

$$ 128\cdot40320=5160960 $$

antipodal coordinate-flip paths. Its output is

```text
input bits: 12
selected column codes: (43, 29, 37, 19, 48, 36, 8, 62)
distinct antipodal row classes: 64
antipodal coordinate-flip paths: 5160960
certificate: verified
```

Every generic two-dimensional subspace of $\mathbb{R}^8$ has a full-sign tope cycle of this form modulo antipodes. During a half-turn around the subspace, each coordinate changes sign exactly once, and genericity makes the eight changes occur separately. Therefore the row signs of $S$, up to negation, meet the full sign patterns of every generic two-dimensional subspace of $\mathbb{R}^8$.

### Lemma 2. The restricted sign matrix has sign-rank at least seven

Suppose a real matrix $B$ has strict sign pattern $S$ and rank at most $6$. Choose a two-dimensional subspace $L$ of its kernel. Every row of $B$ lies in $L^{\perp}$.

Perturb $L$ slightly to a generic two-dimensional subspace and orthogonally project the finitely many rows of $B$ onto the new orthogonal complement. All row signs persist under a sufficiently small perturbation. By Lemma 1, some persisted row sign is, up to negation, the full sign vector of a vector $z\in L$. Replace $z$ by $-z$ if necessary. If $b'$ is the corresponding projected row, then $z$ and $b'$ have the same strict coordinate signs. Hence

$$ \langle z,b'\rangle=\sum_{j=1}^{8}\lvert z_jb'_j\rvert\gt0, $$

contradicting $z\in L$ and $b'\in L^{\perp}$. Therefore

$$ \mathrm{srank}(S)\geq7. $$

### Lemma 3. Two heads give partition sign-rank at most six

Let $g$ be a Boolean function whose variables are split into blocks $a\in\lbrace0,1\rbrace^m$ and $b\in\lbrace0,1\rbrace^n$. Define its partition sign matrix by

$$ \Sigma_g(a,b):=\begin{cases}+1,&g(a,b)=1,\cr-1,&g(a,b)=0.\end{cases} $$

If $g$ is computable with at most two heads, then

$$ \mathrm{srank}(\Sigma_g)\leq6. $$

**Proof.** By the linear-fractional normal form [010_linear_fractional_normal_form.md](../01_foundations_and_normal_form/010_linear_fractional_normal_form.md), after adding a zero atom if necessary, a two-head score has the form

$$ A(a,b)=c+\frac{N_1(a,b)}{D_1(a,b)}+\frac{N_2(a,b)}{D_2(a,b)}, $$

where all four functions are affine and both denominators are positive on the Boolean cube. Clearing the positive denominators preserves the sign and gives

$$ Q(a,b)=(N_1(a,b)+cD_1(a,b))D_2(a,b)+N_2(a,b)D_1(a,b). $$

Thus $Q$ is a sum of two products of affine functions. For one such product, write

$$ F(a,b)=\alpha+u(a)+v(b), \qquad G(a,b)=\beta+r(a)+s(b). $$

Then

$$ F(a,b)G(a,b)=R(a)+C(b)+u(a)s(b)+r(a)v(b), $$

where

$$ R(a):=(\alpha+u(a))(\beta+r(a)), \qquad C(b):=\alpha s(b)+\beta v(b)+v(b)s(b). $$

Its value matrix is therefore a row-only matrix, a column-only matrix, and two outer products. For the sum of two affine products, the row-only terms combine into one rank-one matrix, the column-only terms combine into one rank-one matrix, and four outer products remain. Hence

$$ \mathrm{rank}\left([Q(a,b)]_{a,b}\right)\leq6. $$

This matrix has strict sign pattern $\Sigma_g$, which proves the claim. $\blacksquare$

### Lemma 4. The Hamming-threshold function has threshold degree two

The polynomial

$$ P(x,y):=\Delta(x,y)-\frac{5}{2} $$

is a quadratic strict sign representation of $f_{\mathrm{Ham}}$, so

$$ \deg_{\pm}(f_{\mathrm{Ham}})\leq2. $$

Suppose instead that an affine function sign-represents $f_{\mathrm{Ham}}$. Its values on the $64$ rows $x\in\lbrace0,1\rbrace^6$ and the eight selected columns $y^{(j)}$ have the form

$$ \lambda+u(x)+v(y^{(j)}). $$

This value matrix has rank at most $2$ and strict sign pattern $S$, contradicting Lemma 2. Hence

$$ \deg_{\pm}(f_{\mathrm{Ham}})=2. $$

### Conclusion

The full partition sign matrix of $f_{\mathrm{Ham}}$ contains $S$ as its restriction to the eight selected columns. If two heads computed this function, Lemma 3 would give sign-rank at most $6$ for the full matrix and therefore for $S$. This contradicts Lemma 2. Thus

$$ H^{\ast}(f_{\mathrm{Ham}})\geq3. $$

Together with Lemma 4,

$$ \deg_{\pm}(f_{\mathrm{Ham}})=2\lt3\leq H^{\ast}(f_{\mathrm{Ham}}). \qquad\blacksquare $$

## Consequence

There is an explicit strict separation between threshold degree and head complexity on $12$ input bits. The construction is the natural radius-three Hamming threshold; only its sign-rank lower bound uses a finite certificate.
