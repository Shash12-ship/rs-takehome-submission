# Hypercube-Path Bilinear Strict Separation

## Statement

Let $\mathcal{R}$ be the following set of $8$-bit strings:

$$ \mathcal{R}:=\left\lbrace r\in\lbrace0,1\rbrace^8:r_8=0,\quad \sum_{j=1}^{8}r_j\equiv0\pmod2,\quad r_4=0\text{ or }r_1+r_2+r_3\equiv1\pmod2\right\rbrace. $$

This set has cardinality $48$. Define the $48\times8$ sign matrix $S$ by

$$ S_{r,j}:=(-1)^{r_j} \qquad\text{for }r\in\mathcal{R},\quad j\in\lbrace1,\ldots,8\rbrace. $$

Introduce Boolean variables $x_r$ for $r\in\mathcal{R}$ and $y_1,\ldots,y_8$. Thus there are $56$ input variables. Define

$$ P(x,y):=\frac{1}{2}+\sum_{r\in\mathcal{R}}\sum_{j=1}^{8}S_{r,j}x_r y_j, $$

and define $f_{\mathrm{HC}}:\lbrace0,1\rbrace^{56}\to\lbrace0,1\rbrace$ by

$$ f_{\mathrm{HC}}(x,y)=1 \qquad\Longleftrightarrow\qquad P(x,y)\gt0. $$

Then

$$ \deg_{\pm}(f_{\mathrm{HC}})=2 \qquad\text{and}\qquad H^{\ast}(f_{\mathrm{HC}})\geq3. $$

In particular,

$$ \deg_{\pm}(f_{\mathrm{HC}})\lt H^{\ast}(f_{\mathrm{HC}}). $$

> **Interpretation.** Threshold degree is not always equal to head complexity. This explicit function on $56$ bits has a quadratic sign representation, but no sum of two one-head linear-fractional atoms can realize its sign pattern.

## Proof

### Lemma 1. The row set hits every generic two-dimensional tope cycle

Identify a sign vector in $\lbrace-1,+1\rbrace^8$ with its bit string $r\in\lbrace0,1\rbrace^8$ through the rule $s_j=(-1)^{r_j}$. Negating the sign vector complements every bit. Therefore the condition $r_8=0$ chooses one representative from each antipodal pair.

Let $L$ be a generic two-dimensional subspace of $\mathbb{R}^8$. Generic means that no coordinate vanishes identically on $L$ and that no two coordinate kernels in $L$ coincide. As a nonzero vector travels once around $L$, its sign pattern changes one coordinate at a time. Modulo antipodes, the eight full sign patterns therefore have the form

$$ t^{(0)},t^{(1)},\ldots,t^{(7)}, $$

where each step flips one coordinate and the eight flipped coordinates are all distinct. The next vertex is

$$ t^{(8)}=t^{(0)}+(1,\ldots,1) $$

over $\mathbb{F}_2$.

We claim that at least one of these eight antipodal classes has its representative in $\mathcal{R}$. Suppose otherwise. The path alternates parity, so consider its four even-parity classes. Every even-parity class has a unique representative with eighth bit $0$. The even representatives excluded from $\mathcal{R}$ form the set

$$ \mathcal{C}:=\left\lbrace r\in\lbrace0,1\rbrace^8:r_8=0,\quad \sum_{j=1}^{8}r_j\equiv0\pmod2,\quad r_4=1,\quad r_1+r_2+r_3\equiv0\pmod2\right\rbrace. $$

Let $\widetilde{\mathcal{C}}$ contain both bit strings from every antipodal class represented by $\mathcal{C}$. It is the affine set defined by

$$ \sum_{j=1}^{8}r_j=0, \qquad r_4+r_8=1, \qquad r_1+r_2+r_3+r_8=0 $$

over $\mathbb{F}_2$. Its translation space $W$ is therefore defined by

$$ \sum_{j=1}^{8}w_j=0, \qquad w_4+w_8=0, \qquad w_1+w_2+w_3+w_8=0. $$

Rotate the tope cycle so that $t^{(0)}$ has even parity. If all four even classes belonged to $\mathcal{C}$, then

$$ t^{(0)},t^{(2)},t^{(4)},t^{(6)},t^{(8)}\in\widetilde{\mathcal{C}}. $$

Consequently, each of the four differences

$$ t^{(2)}-t^{(0)}, \qquad t^{(4)}-t^{(2)}, \qquad t^{(6)}-t^{(4)}, \qquad t^{(8)}-t^{(6)} $$

would lie in $W$. Each difference has weight two, and their supports partition the eight coordinates.

Set

$$ A:=\lbrace1,2,3\rbrace, \qquad B:=\lbrace5,6,7\rbrace. $$

A weight-two vector lies in $W$ only if its support is a pair contained in $A$ or a pair contained in $B$. Indeed, the equation $w_4=w_8$ first rules out a pair containing exactly one of coordinates $4,8$. The pair $\lbrace4,8\rbrace$ violates $w_1+w_2+w_3+w_8=0$. If neither $4$ nor $8$ occurs, the same equation requires an even number of coordinates from $A$, so both coordinates lie in $A$ or both lie in $B$.

Four such pairs cannot partition all eight coordinates, because coordinates $4$ and $8$ occur in none of them. This contradiction proves that the row set of $S$ meets the full sign patterns of every generic two-dimensional subspace.

### Lemma 2. The sign matrix has sign-rank at least seven

For a sign matrix $M$, let $\mathrm{srank}(M)$ denote the least rank of a real matrix with the same strict entrywise signs as $M$.

Suppose for contradiction that $\mathrm{srank}(S)\leq6$. Then there is a real matrix $B$ of rank at most $6$ whose row indexed by $r$ has sign vector $((-1)^{r_j})_{j=1}^{8}$. Choose a two-dimensional subspace $L$ of the kernel of $B$.

For every row $b_r$ of $B$, one has $b_r\in L^{\perp}$. Orthogonally projecting the finitely many rows onto the complements of nearby two-dimensional subspaces changes them continuously. Since every coordinate of every $b_r$ is nonzero, a sufficiently small perturbation of $L$ preserves all row signs after projection. We may therefore perturb $L$ so that it is generic while retaining, for each $r\in\mathcal{R}$, a vector

$$ b'_r\in L^{\perp} \qquad\text{with}\qquad \mathrm{sign}(b'_r)=((-1)^{r_j})_{j=1}^{8}. $$

By Lemma 1, some row sign of $S$ is also, up to negation, the full sign vector of a vector in $L$. Replace that vector by its negative if necessary. For that row $r$, there is a vector $z\in L$ such that

$$ \mathrm{sign}(z)=\mathrm{sign}(b'_r). $$

Both vectors have nonzero coordinates, so

$$ \langle z,b'_r\rangle=\sum_{j=1}^{8}\lvert z_jb'_{r,j}\rvert\gt0. $$

This contradicts $z\in L$ and $b'_r\in L^{\perp}$. Hence

$$ \mathrm{srank}(S)\geq7. $$

### Lemma 3. Two heads give singleton-slice sign-rank at most six

Let $g$ be a Boolean function whose variables are split into blocks

$$ a=(a_1,\ldots,a_m), \qquad b=(b_1,\ldots,b_n). $$

For each $i,j$, let $z^{i,j}$ be the input with $a_i=b_j=1$ and every other coordinate equal to $0$. Define its two-block singleton-slice sign matrix by

$$ \Sigma_g(i,j):=\begin{cases}+1,&g(z^{i,j})=1,\cr-1,&g(z^{i,j})=0.\end{cases} $$

If $g$ is computable with at most two heads, then

$$ \mathrm{srank}(\Sigma_g)\leq6. $$

**Proof.** By the linear-fractional normal form [010_linear_fractional_normal_form.md](../01_foundations_and_normal_form/010_linear_fractional_normal_form.md), after adding a zero atom if necessary, a two-head score has the form

$$ A(z)=c+\frac{N_1(z)}{D_1(z)}+\frac{N_2(z)}{D_2(z)}, $$

where every $N_h$ and $D_h$ is affine on the Boolean cube and

$$ D_1(z)\gt0, \qquad D_2(z)\gt0. $$

Clearing the positive denominators preserves the sign. The resulting quadratic polynomial is

$$ Q(z)=(N_1(z)+cD_1(z))D_2(z)+N_2(z)D_1(z). $$

Thus $Q$ is a sum of two products of affine functions.

Consider one such product $F(z)G(z)$. On the singleton slice, write

$$ F(z^{i,j})=\alpha+p_i+q_j, \qquad G(z^{i,j})=\beta+r_i+s_j. $$

Define

$$ R_i:=(\alpha+p_i)(\beta+r_i), \qquad C_j:=\alpha s_j+\beta q_j+q_j s_j. $$

Then

$$ F(z^{i,j})G(z^{i,j})=R_i+C_j+p_i s_j+r_i q_j. $$

Consequently, the matrix of this product on the singleton slice is the sum of one row-only matrix, one column-only matrix, and two outer products. For the sum of two affine products, the two row-only terms combine into one rank-one matrix, the two column-only terms combine into one rank-one matrix, and four outer products remain. Hence

$$ \mathrm{rank}\left([Q(z^{i,j})]_{i,j}\right)\leq6. $$

The matrix $[Q(z^{i,j})]_{i,j}$ has strict sign pattern $\Sigma_g$, so

$$ \mathrm{srank}(\Sigma_g)\leq6. \qquad\blacksquare $$

### Lemma 4. The hypercube-path function has threshold degree two

The quantity

$$ \sum_{r\in\mathcal{R}}\sum_{j=1}^{8}S_{r,j}x_r y_j $$

is an integer on every Boolean input. Therefore $P(x,y)$ is always a nonzero half-integer. It strictly sign-represents $f_{\mathrm{HC}}$ and has degree $2$, so

$$ \deg_{\pm}(f_{\mathrm{HC}})\leq2. $$

For the reverse inequality, suppose an affine function $L$ sign-represents $f_{\mathrm{HC}}$. On the two-block singleton slice, it has the form

$$ L(z^{r,j})=\lambda+\alpha_r+\beta_j. $$

The matrix $[L(z^{r,j})]_{r,j}$ has rank at most $2$. On the other hand,

$$ P(z^{r,j})=\frac{1}{2}+S_{r,j}, $$

so its strict sign pattern is $S$. Thus the existence of $L$ would imply

$$ \mathrm{srank}(S)\leq2, $$

contradicting Lemma 2. Hence $f_{\mathrm{HC}}$ has no affine sign representation, and

$$ \deg_{\pm}(f_{\mathrm{HC}})=2. $$

### Conclusion

The singleton-slice sign matrix of $f_{\mathrm{HC}}$ is exactly $S$, because

$$ \mathrm{sign}(P(z^{r,j}))=S_{r,j}. $$

If two heads computed $f_{\mathrm{HC}}$, Lemma 3 would give $\mathrm{srank}(S)\leq6$. Lemma 2 gives $\mathrm{srank}(S)\geq7$, a contradiction. Therefore

$$ H^{\ast}(f_{\mathrm{HC}})\geq3. $$

Together with Lemma 4,

$$ \deg_{\pm}(f_{\mathrm{HC}})=2\lt3\leq H^{\ast}(f_{\mathrm{HC}}). \qquad\blacksquare $$

## Consequence

The universal lower bound

$$ \deg_{\pm}(f)\leq H^{\ast}(f) $$

can be strict even for a function with threshold degree two. The obstruction is visible on a non-subcube slice: two heads force rank at most six on every two-block singleton slice after clearing denominators, while this explicit hypercube-path slice has sign-rank at least seven.

This construction proves that a strict separation exists on $56$ input bits. It does not prove that $56$ is the least possible dimension.

The finite row count and tope-path hitting property can also be checked directly with [verify_hypercube_path_separation.py](../../artifacts/calculations/verify_hypercube_path_separation.py).
