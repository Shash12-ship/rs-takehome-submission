# Compact Hypercube-Path Strict Separation

## Statement

For $r=(r_1,\ldots,r_8)\in\lbrace0,1\rbrace^8$, define its integer code by

$$ \mathrm{code}(r):=\sum_{j=1}^{8}2^{j-1}r_j. $$

Let $\mathcal{R}_{35}$ be the set of strings whose codes belong to

$$ \mathcal{C}_{35}:=\lbrace0,3,5,10,12,15,18,20,23,30,34,36,39,46,54,65,72,75,77,80,83,85,90,92,95,96,99,101,106,108,111,114,116,119,126\rbrace. $$

Every string in $\mathcal{R}_{35}$ has even parity and eighth bit $0$. Define the $35\times8$ sign matrix $S^{(35)}$ by

$$ S^{(35)}_{r,j}:=(-1)^{r_j} \qquad\text{for }r\in\mathcal{R}_{35},\quad j\in\lbrace1,\ldots,8\rbrace. $$

Introduce Boolean variables $x_r$ for $r\in\mathcal{R}_{35}$ and $y_1,\ldots,y_8$. Thus there are $43$ input variables. Define

$$ P_{35}(x,y):=\frac{1}{2}+\sum_{r\in\mathcal{R}_{35}}\sum_{j=1}^{8}S^{(35)}_{r,j}x_r y_j, $$

and define $f_{35}:\lbrace0,1\rbrace^{43}\to\lbrace0,1\rbrace$ by

$$ f_{35}(x,y)=1 \qquad\Longleftrightarrow\qquad P_{35}(x,y)\gt0. $$

Then

$$ \deg_{\pm}(f_{35})=2 \qquad\text{and}\qquad H^{\ast}(f_{35})\geq3. $$

In particular,

$$ \deg_{\pm}(f_{35})\lt H^{\ast}(f_{35}). $$

> **Interpretation.** This is a computer-certified compression of the structured $56$-bit construction in Theorem 180. Its complete description is the displayed list of $35$ row codes.

## Proof

### Lemma 1. The compact row set hits every generic two-dimensional tope cycle

Let

$$ \widehat{\mathcal{C}}_{35}:=\mathcal{C}_{35}\cup\lbrace255-c:c\in\mathcal{C}_{35}\rbrace. $$

This is the union of the $35$ coded sign patterns and their antipodes. The finite certificate is the following assertion. For every $a\in\lbrace0,\ldots,127\rbrace$ and every permutation $\pi$ of $\lbrace1,\ldots,8\rbrace$, define

$$ v_0:=a, \qquad v_k:=a\oplus2^{\pi(1)-1}\oplus\cdots\oplus2^{\pi(k)-1} \quad\text{for }1\leq k\leq7. $$

Then

$$ \lbrace v_0,\ldots,v_7\rbrace\cap\widehat{\mathcal{C}}_{35}\neq\varnothing. $$

The script [verify_hypercube_path_separation.py](../../artifacts/calculations/verify_hypercube_path_separation.py) checks this assertion directly. It enumerates all

$$ 128\cdot40320=5160960 $$

choices of $a$ and $\pi$, and terminates with an assertion failure if any path misses the row set. The exact output is

```text
structured row representatives: 48
compact row representatives: 35
antipodal coordinate-flip paths: 5160960
certificate: verified
```

Every generic two-dimensional subspace of $\mathbb{R}^8$ has, modulo antipodes, a full-sign tope cycle of this form. Indeed, during a half-turn around the subspace, each coordinate changes sign exactly once, and genericity makes the eight changes occur separately. Thus the finite certificate proves that the row set of $S^{(35)}$ meets the full sign patterns of every generic two-dimensional subspace.

### Lemma 2. The compact sign matrix has sign-rank at least seven

Suppose a real matrix $B$ has strict sign pattern $S^{(35)}$ and rank at most $6$. Choose a two-dimensional subspace $L$ of its kernel. As in Lemma 2 of [180_hypercube_path_strict_separation.md](180_hypercube_path_strict_separation.md), perturb $L$ slightly to a generic subspace while orthogonally projecting the finitely many rows of $B$ onto the new orthogonal complement. All row signs persist under a sufficiently small perturbation.

By Lemma 1, some persisted row sign is, up to negation, the full sign vector of a vector $z\in L$. Replace $z$ by $-z$ if necessary. If $b'$ is the corresponding projected row, then $z$ and $b'$ have the same strict coordinate signs. Therefore

$$ \langle z,b'\rangle=\sum_{j=1}^{8}\lvert z_jb'_j\rvert\gt0, $$

contradicting $z\in L$ and $b'\in L^{\perp}$. Hence

$$ \mathrm{srank}(S^{(35)})\geq7. $$

### Lemma 3. The compact function has threshold degree two

The bilinear sum in $P_{35}$ is integer-valued on the Boolean cube. Hence $P_{35}$ is always a nonzero half-integer and strictly sign-represents $f_{35}$. This proves

$$ \deg_{\pm}(f_{35})\leq2. $$

If an affine function sign-represented $f_{35}$, its values on the two-block singleton slice would form a matrix of rank at most $2$. That slice has strict sign pattern $S^{(35)}$, contradicting Lemma 2. Therefore

$$ \deg_{\pm}(f_{35})=2. $$

### Conclusion

Lemma 3 of [180_hypercube_path_strict_separation.md](180_hypercube_path_strict_separation.md) proves that every two-head function has two-block singleton-slice sign-rank at most $6$. The singleton-slice sign matrix of $f_{35}$ is $S^{(35)}$, whose sign-rank is at least $7$ by Lemma 2. Therefore

$$ H^{\ast}(f_{35})\geq3. $$

Together with Lemma 3,

$$ \deg_{\pm}(f_{35})=2\lt3\leq H^{\ast}(f_{35}). \qquad\blacksquare $$

## Consequence

There is an explicit strict separation between threshold degree and head complexity on $43$ input bits. The certificate is deterministic and exhaustive, but this theorem does not prove that $43$ is the least possible dimension.
