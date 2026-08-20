# Boolean-Cube Ceiling For The Slice Relaxation

## Statement

Let $2\leq H\leq n$. Let $\mathcal B_{\leq d}$ be the vector space of real functions on $\lbrace0,1\rbrace^n$ represented by multilinear polynomials of degree at most $d$, and put

$$ D_d=\dim\mathcal B_{\leq d}=\sum_{j=0}^{d}\binom{n}{j}. $$

For a two-plane $U=\mathrm{span}(L_1,L_2)$ of affine forms, define the evaluated slice space

$$ \mathcal I_H(U)=L_1\mathcal B_{\leq H-1}+L_2\mathcal B_{\leq H-1}\subseteq\mathcal B_{\leq H}. $$

Then the maximum, and hence the generic value, of $\dim\mathcal I_H(U)$ is

$$ r_H=\min\left\lbrace D_H,2D_{H-1}-D_{H-2}\right\rbrace. $$

The maximum is attained by

$$ U_0=\mathrm{span}\left(1,x_1+\cdots+x_n\right). $$

Consequently, if

$$ H\geq\left\lceil\frac{n+1}{2}\right\rceil, $$

then $\mathcal I_H(U_0)=\mathcal B_{\leq H}$. In this range, the real slice-rank-two sign relaxation is equivalent to threshold degree at most $H$. The equivalence remains true after requiring the slice plane to contain one admissible positive denominator.

If $H\leq\lfloor n/2\rfloor$, the generic fixed-plane codimension inside $\mathcal B_{\leq H}$ is

$$ \binom{n}{H}-\binom{n}{H-1}. $$

The projective union over all two-planes has dimension at most $r_H-1+2(n-1)$. It is therefore a proper algebraic subset of $\mathbb P(\mathcal B_{\leq H})$ whenever

$$ \binom{n}{H}-\binom{n}{H-1}\gt2(n-1). $$

## Proof

Squarefree monomials of degree at most $d$ form a basis of $\mathcal B_{\leq d}$, which gives the dimension $D_d$.

Choose a generic ordered basis $L_1,L_2$ of a generic plane. The evaluation of $L_1$ is nonzero at every cube vertex on a nonempty Zariski-open set. For every $R\in\mathcal B_{\leq H-2}$, the pair

$$ (L_2R,-L_1R) $$

lies in the kernel of the map

$$ \mathcal B_{\leq H-1}^{2}\to\mathcal B_{\leq H},\qquad(Q_1,Q_2)\mapsto L_1Q_1+L_2Q_2. $$

This kernel family has dimension $D_{H-2}$ because multiplication by the nowhere-zero function $L_1$ is injective on cube functions. Thus the generic rank is at most $2D_{H-1}-D_{H-2}$, and it is also at most $D_H$. Since matrix rank is maximal on a Zariski-open set, this bounds the maximum rank over all planes.

It remains to attain the bound. Put

$$ \ell=x_1+\cdots+x_n\qquad U_0=\mathrm{span}(1,\ell). $$

The first summand in $\mathcal I_H(U_0)$ contains all of $\mathcal B_{\leq H-1}$. Modulo this subspace, multiplication by $\ell$ is the Boolean-lattice up map

$$ U_{H-1}:A_{H-1}\to A_H, $$

where $A_k$ is spanned by the squarefree monomials of degree $k$. This map has rank

$$ \min\left\lbrace\binom{n}{H-1},\binom{n}{H}\right\rbrace. $$

For completeness, let $D_k:A_k\to A_{k-1}$ delete one variable from a squarefree monomial. With the monomial bases orthonormal, $D_{k+1}=U_k^{\top}$, and direct counting gives

$$ D_{k+1}U_k-U_{k-1}D_k=(n-2k)I_{A_k}. $$

If $k\lt n/2$ and $U_kv=0$, taking the inner product with $v$ gives

$$ -\lVert D_kv\rVert_2^{2}=(n-2k)\lVert v\rVert_2^{2}, $$

so $v=0$. Thus $U_k$ is injective below the middle level. Complementing subsets and taking transposes gives surjectivity above the middle level. Hence $U_k$ has full possible rank in every degree.

Therefore

$$ \begin{aligned} \dim\mathcal I_H(U_0) &=D_{H-1}+\min\left\lbrace\binom{n}{H-1},\binom{n}{H}\right\rbrace \cr &=\min\left\lbrace D_H,2D_{H-1}-D_{H-2}\right\rbrace. \end{aligned} $$

This proves the maximum-rank formula.

When $H\geq\lceil(n+1)/2\rceil$, one has $\binom{n}{H}\leq\binom{n}{H-1}$, so the maximum equals $D_H$. Every degree at most $H$ polynomial threshold representation therefore has an evaluated slice-rank-two homogeneous lift. Conversely, every such slice lift has degree at most $H$ on the cube. The plane $U_0$ contains $1+\varepsilon\ell$ for every $\varepsilon\gt0$, which is an admissible strictly positive denominator. Thus the positivity-aware slice-plane condition does not change the equivalence.

Below the middle level, subtracting the displayed maximum from $D_H$ gives the fixed-plane codimension. Finally, $\mathrm{Gr}(2,n+1)$ has dimension $2(n-1)$, so the incidence dimension bound and the properness criterion follow. $\blacksquare$

## Consequences For Computation

The slice atlas should be enabled only after this rank screen.

- For $n=6$ and $H=4$, the slice relaxation is exactly the degree-four threshold relaxation. It cannot raise the lower bound for the six-bit parity triple flip.

- For $n=8$ and $H=2$, the fixed-plane codimension is $20$ and the Grassmann dimension is $14$. The incidence remains a proper algebraic subset, so slice search can add information beyond quadratic threshold degree.

- In general, slice incidence is most promising when $n$ is appreciably larger than $2H$. Near or above the middle level, use matrix bounds, model-aware positive secants, direct parameter certificates, or constructive upper search instead.

The rank formula and the exact six-bit cubic dominance warning have an independent executable audit in [boolean_cube_slice_rank_and_n6_cubic_dominance.md](../../artifacts/calculations/boolean_cube_slice_rank_and_n6_cubic_dominance.md).

## Literature Connection

The full-rank Boolean-lattice up map is the weak Lefschetz property of the squarefree monomial complete intersection. It is a special case of Stanley's strong Lefschetz theorem for monomial complete intersections. A modern linear-algebra proof is given by [Phuong and Tran](https://arxiv.org/abs/2211.13548).

The underlying slice obstruction is proved in [190_slice_rank_two_obstruction.md](190_slice_rank_two_obstruction.md).
