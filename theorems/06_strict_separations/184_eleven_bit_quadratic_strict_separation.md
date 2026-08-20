# Eleven-Bit Quadratic Strict Separation

## Statement

Let $x\in\lbrace0,1\rbrace^6$ and $y\in\lbrace0,1\rbrace^5$. Define the integer-valued quadratic polynomial

$$ \begin{aligned} Q(x,y):={}&1-2x_3+8y_5-16x_1y_2+14x_1y_4-14x_1y_5-22x_2y_4+16x_2y_5 \cr &+2x_3y_1+12x_3y_2+6x_3y_5-18x_4y_3-2x_5y_1-14x_5y_3-16x_6y_5 \cr &+16y_1y_3+22y_2y_5-12y_3y_5. \end{aligned} $$

Define $f_{11}:\lbrace0,1\rbrace^{11}\to\lbrace0,1\rbrace$ by

$$ f_{11}(x,y)=1 \qquad\Longleftrightarrow\qquad Q(x,y)\gt0. $$

Then

$$ \deg_{\pm}(f_{11})=2 \qquad\text{and}\qquad H^{\ast}(f_{11})\geq3. $$

Consequently,

$$ \deg_{\pm}(f_{11})\lt H^{\ast}(f_{11}). $$

> **Interpretation.** An explicit quadratic threshold on a six-bit by five-bit partition contains the compact hypercube-path sign matrix. This gives a strict separation on eleven input bits.

## Proof

### Lemma 1. An exact selected submatrix is the compact path obstruction

For a bit string $z\in\lbrace0,1\rbrace^k$, define

$$ \mathrm{code}(z):=\sum_{i=1}^{k}2^{i-1}z_i. $$

Let

$$ \mathcal{C}_{35}:=\lbrace0,3,5,10,12,15,18,20,23,30,34,36,39,46,54,65,72,75,77,80,83,85,90,92,95,96,99,101,106,108,111,114,116,119,126\rbrace. $$

For each $c\in\mathcal{C}_{35}$, let $r(c)\in\lbrace0,1\rbrace^8$ be the bit string with code $c$, and let $x(c)\in\lbrace0,1\rbrace^6$ consist of its first six bits. These $35$ strings $x(c)$ are distinct.

Choose $y^{(1)},\ldots,y^{(8)}\in\lbrace0,1\rbrace^5$ with

$$ \bigl(\mathrm{code}(y^{(1)}),\ldots,\mathrm{code}(y^{(8)})\bigr)=(2,30,0,5,1,25,21,18). $$

Direct integer evaluation of the displayed polynomial gives

$$ \mathrm{sign}\bigl(Q(x(c),y^{(j)})\bigr)=(-1)^{r_j(c)} $$

for every $c\in\mathcal{C}_{35}$ and $j\in\lbrace1,\ldots,8\rbrace$. Moreover,

$$ \min_{c\in\mathcal{C}_{35}}\min_{1\leq j\leq8}\left\lvert Q(x(c),y^{(j)})\right\rvert=1. $$

Thus this selected $35\times8$ sign submatrix is exactly the matrix $S^{(35)}$ from [181_compact_hypercube_path_strict_separation.md](181_compact_hypercube_path_strict_separation.md).

The script [verify_eleven_bit_separation.py](../../artifacts/calculations/verify_eleven_bit_separation.py) checks these integer identities. It also independently enumerates all $5160960$ antipodal coordinate-flip paths and verifies that the row codes in $\mathcal{C}_{35}$ meet every path. Its output is

```text
input bits: 11
selected rows: 35
selected y codes: (2, 30, 0, 5, 1, 25, 21, 18)
minimum absolute selected Q value: 1
full-cube Q range: (-65, 69)
antipodal coordinate-flip paths: 5160960
certificate: verified
```

### Lemma 2. The selected sign matrix has sign-rank at least seven

The path-hitting certificate in Lemma 1 implies

$$ \mathrm{srank}(S^{(35)})\geq7. $$

Indeed, suppose a real matrix with this sign pattern had rank at most $6$. A generic two-dimensional subspace $L$ of its kernel has, modulo antipodes, a coordinate-flip tope path in eight dimensions. Lemma 1 supplies a row sign of $S^{(35)}$ that equals the strict sign of some $z\in L$, up to negation. The corresponding matrix row $b\in L^{\perp}$ can be chosen with the same sign as $z$. Therefore

$$ \langle z,b\rangle=\sum_{j=1}^{8}\lvert z_jb_j\rvert\gt0, $$

contradicting orthogonality. The standard small perturbation argument from [180_hypercube_path_strict_separation.md](180_hypercube_path_strict_separation.md) handles a nongeneric kernel subspace while preserving all strict row signs.

### Lemma 3. The function has threshold degree two

Every nonconstant coefficient of $Q$ is even and its constant coefficient is $1$. Thus $Q$ is odd-valued on the Boolean cube, so it never vanishes. It strictly sign-represents $f_{11}$ and has degree $2$. Hence

$$ \deg_{\pm}(f_{11})\leq2. $$

If an affine function sign-represented $f_{11}$, its values on the selected Cartesian submatrix from Lemma 1 would form a matrix of rank at most $2$. This contradicts Lemma 2. Therefore

$$ \deg_{\pm}(f_{11})=2. $$

### Conclusion

Lemma 3 of [182_hamming_threshold_strict_separation.md](182_hamming_threshold_strict_separation.md) proves that every two-head function has partition sign-rank at most $6$ under every split of its variables. Apply that result to the six-bit by five-bit partition of $f_{11}$. Its full partition sign matrix contains $S^{(35)}$, whose sign-rank is at least $7$ by Lemma 2. Thus

$$ H^{\ast}(f_{11})\geq3. $$

Together with Lemma 3,

$$ \deg_{\pm}(f_{11})=2\lt3\leq H^{\ast}(f_{11}). \qquad\blacksquare $$

## Consequence

There is an explicit strict separation between threshold degree and head complexity on $11$ input bits. The later antipodal-slice construction [185_nine_bit_antipodal_slice_strict_separation.md](185_nine_bit_antipodal_slice_strict_separation.md) improves the upper bound on the least separation dimension to $9$, and the eight-bit Hamming-threshold construction [189_eight_bit_hamming_threshold_strict_separation.md](189_eight_bit_hamming_threshold_strict_separation.md) improves it further to $8$.
