# Nine-Bit Antipodal-Slice Strict Separation

## Statement

Let $x=(x_1,x_2,x_3,x_4)\in\lbrace-1,1\rbrace^4$ and $y=(y_0,y_1,y_2,y_3,y_4)\in\lbrace-1,1\rbrace^5$. Define

$$ S(y):=\sum_{j=0}^{4}y_j, \qquad T(x):=1+\sum_{i=1}^{4}x_i, \qquad D(x,y):=y_0+\sum_{i=1}^{4}x_i y_i, $$

and put

$$ Q(x,y):=S(y)T(x)-3D(x,y). $$

Define $f_9:\lbrace-1,1\rbrace^9\to\lbrace0,1\rbrace$ by

$$ f_9(x,y)=1 \qquad\Longleftrightarrow\qquad Q(x,y)\gt0. $$

Then

$$ \deg_{\pm}(f_9)=2 \qquad\text{and}\qquad H^{\ast}(f_9)\geq3. $$

Consequently,

$$ \deg_{\pm}(f_9)\lt H^{\ast}(f_9). $$

> **Interpretation.** Five antipodal pairs of five-bit inputs force a nonsingular $5\times5$ block in every quadratic sign representation. A cleared two-head score can have block rank at most four.

## Proof

### Lemma 1. The displayed quadratic never vanishes

Write

$$ x_i=1-2\alpha_i, \qquad y_j=1-2\beta_j, $$

where all $\alpha_i,\beta_j$ belong to $\lbrace0,1\rbrace$. Put

$$ A:=\sum_{i=1}^{4}\alpha_i, \qquad B:=\sum_{j=0}^{4}\beta_j, \qquad C:=\sum_{i=1}^{4}\alpha_i\beta_i. $$

Direct expansion gives

$$ S=5-2B, \qquad T=5-2A, \qquad D=5-2(A+B)+4C. $$

Therefore

$$ \begin{aligned} Q &= (5-2B)(5-2A)-3\bigl(5-2(A+B)+4C\bigr) \cr &=2+4\bigl(2-A-B+AB-3C\bigr). \end{aligned} $$

Thus every value of $Q$ is congruent to $2$ modulo $4$. In particular, $Q$ never vanishes and is a strict quadratic sign representation of $f_9$.

### Lemma 2. Five antipodal slices encode a diagonal basis

Let $J$ denote the $5\times5$ all-ones matrix, and define

$$ V:=J-2I. $$

For $j\in\lbrace0,1,2,3,4\rbrace$, let $v^{(j)}$ be column $j$ of $V$. Thus $v^{(j)}$ has entry $-1$ in coordinate $j$ and entry $1$ in every other coordinate.

Put

$$ \ell(x):=(1,x_1,x_2,x_3,x_4)^{\top}. $$

The quadratic can be written as

$$ Q(x,y)=\ell(x)^{\top}(J-3I)y. $$

Since $J^2=5J$,

$$ (J-3I)(J-2I)=6I. $$

It follows that

$$ Q\bigl(x,v^{(0)}\bigr)=6, \qquad Q\bigl(x,v^{(j)}\bigr)=6x_j \quad\text{for }1\leq j\leq4, $$

and replacing $v^{(j)}$ by $-v^{(j)}$ negates the value.

The eigenvalues of $V=J-2I$ are $3,-2,-2,-2,-2$, so

$$ \det(V)=48\neq0. $$

### Lemma 3. Every two-head cleared score has cross-block rank at most four

Suppose a function on the nine variables is computed with at most two heads. After adding a zero atom if necessary, the linear-fractional normal form gives a score

$$ c+\frac{N_1}{D_1}+\frac{N_2}{D_2}, $$

where all four displayed forms are affine and both denominators are positive on the cube. Clearing the positive denominators preserves signs and gives

$$ P=(cD_1+N_1)D_2+N_2D_1. $$

Reduce the cleared polynomial using the sign-cube relations $x_i^2=y_j^2=1$. Let $C_P$ be the $5\times5$ coefficient matrix of the terms

$$ \ell_i(x)y_j, \qquad 0\leq i,j\leq4. $$

One product of two affine forms contributes to $C_P$ a sum of two outer products, so its contribution has rank at most two. The displayed sum of two products therefore satisfies

$$ \mathrm{rank}(C_P)\leq4. $$

### Lemma 4. The target signs force cross-block rank five

Suppose a quadratic polynomial $P$ strictly sign-represents $f_9$. For each $j\in\lbrace0,1,2,3,4\rbrace$, define the antipodal difference

$$ \Delta_j(x):=P\bigl(x,v^{(j)}\bigr)-P\bigl(x,-v^{(j)}\bigr). $$

All terms even in $y$ cancel, so

$$ \Delta_j(x)=2\ell(x)^{\top}C_Pv^{(j)}. $$

Write $a^{(j)}:=2C_Pv^{(j)}$. Lemma 2 and strict sign agreement imply

$$ \Delta_0(x)\gt0 \quad\text{for every }x, \qquad \mathrm{sgn}(\Delta_j(x))=x_j \quad\text{for }1\leq j\leq4. $$

The first condition gives

$$ a^{(0)}_0\gt\sum_{i=1}^{4}\left|a^{(0)}_i\right|. $$

For $1\leq j\leq4$, multiply $\Delta_j(x)$ by $x_j$. The four signs $x_j$ and $x_ix_j$ for $i\neq j$ vary independently as $x$ ranges over the cube. Hence

$$ a^{(j)}_j\gt\left|a^{(j)}_0\right|+\sum_{\substack{1\leq i\leq4\cr i\neq j}}\left|a^{(j)}_i\right|. $$

Thus the matrix

$$ A:=\begin{pmatrix}a^{(0)}&a^{(1)}&a^{(2)}&a^{(3)}&a^{(4)}\end{pmatrix}=2C_PV $$

is strictly diagonally dominant by columns. Its transpose is strictly diagonally dominant by rows and is therefore nonsingular. Indeed, a nonzero kernel vector and a coordinate of maximum absolute value would contradict strict dominance in the corresponding row. Since $V$ is nonsingular, $C_P$ is nonsingular as well. Consequently,

$$ \mathrm{rank}(C_P)=5. $$

### Conclusion

If two heads computed $f_9$, Lemma 3 would give a strict quadratic sign representation with cross-block rank at most four. Lemma 4 says that every such representation has cross-block rank five. Therefore

$$ H^{\ast}(f_9)\geq3. $$

Lemma 1 gives $\deg_{\pm}(f_9)\leq2$. An affine sign representation would have cross-block rank at most one, contradicting Lemma 4. Hence $\deg_{\pm}(f_9)\geq2$, and therefore

$$ \deg_{\pm}(f_9)=2\lt3\leq H^{\ast}(f_9). \qquad\blacksquare $$

## Exact verification

The [exact verifier](../../artifacts/calculations/verify_nine_bit_antipodal_slice_separation.py) checks every value of $Q$ on the nine-cube, the five antipodal slice identities, and the exact determinant identities. Its output is

```text
input bits: 9
Q value range: (-14, 14)
minimum absolute Q value: 2
selected antipodal pairs: 5
det(V): 48
det(J - 3I): 162
certificate: verified
```

## Consequence

Combined with the exact classification through four bits, this theorem gives

$$ 5\leq n_{\mathrm{sep}}\leq9. $$

The later eight-bit Hamming-threshold separation
[189_eight_bit_hamming_threshold_strict_separation.md](189_eight_bit_hamming_threshold_strict_separation.md)
improves the current upper bound to $8$.
