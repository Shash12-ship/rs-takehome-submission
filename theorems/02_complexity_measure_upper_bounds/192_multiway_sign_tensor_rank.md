# Multiway Sign Tensor Rank Bound

## Statement

Let $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$ be nonconstant, and partition the coordinates into $k\geq2$ nonempty blocks

$$ I_1\sqcup\cdots\sqcup I_k=\lbrace1,\ldots,n\rbrace. $$

Write $\Sigma_f^{I_1,\ldots,I_k}$ for the resulting order $k$ sign tensor. Its real sign CP rank is the minimum CP rank of a real tensor having the same strict sign pattern.

If $H^{\ast}(f)\leq H$, then

$$ \mathrm{srank}_{\mathrm{CP}}\left(\Sigma_f^{I_1,\ldots,I_k}\right)\leq R_k(H):=k\left(k^H-(k-1)^H\right). $$

For $k=2$, this is the partition sign-rank bound

$$ R_2(H)=2^{H+1}-2. $$

The multiway extension does not improve the universal input-count screen. If $H\geq2$ and $n\leq2H+1$, then for every $k\geq2$ and every coordinate partition,

$$ \mathrm{srank}_{\mathrm{CP}}\left(\Sigma_f^{I_1,\ldots,I_k}\right)\leq R_k(H). $$

Consequently, no lower-bound method based only on proving large multiway sign CP rank can rule out $H$ heads below $2H+2$ input bits.

> **Interpretation.** Multiway tensor equations can still strengthen a particular instance by enforcing compatibility across several flattenings. Rank size alone is not the missing high-head obstruction. It cannot move the dimension frontier beyond the balanced matrix method.

## Proof

### Lemma 1. Tangent expansion across coordinate blocks

Suppose $f$ is computed with at most $H$ heads. Add zero-output heads if necessary. After clearing the positive denominators and absorbing the product term into the first numerator, the strict sign-representing polynomial has the tangent form

$$ P(x)=\left.\frac{d}{dt}\prod_{h=1}^{H}\left(B_h(x)+tA_h(x)\right)\right\rvert_{t=0}. $$

Every affine form splits as a sum of block-local affine functions. Thus, for each head $h$, write

$$ B_h(x)=\sum_{j=1}^{k}b_{h,j}(x_{I_j}),\qquad A_h(x)=\sum_{j=1}^{k}a_{h,j}(x_{I_j}). $$

The constant term may be assigned to any one block. Expanding the product gives

$$ \prod_{h=1}^{H}\left(B_h+tA_h\right)=\sum_{\tau:\lbrace1,\ldots,H\rbrace\to\lbrace1,\ldots,k\rbrace}\prod_{j=1}^{k}\prod_{h:\tau(h)=j}\left(b_{h,j}+ta_{h,j}\right). $$

Fix an assignment $\tau$. Differentiating its summand at zero gives one rank-one tensor for every nonempty fiber of $\tau$:

$$ \sum_{j\in\mathrm{im}(\tau)}\left(\sum_{h:\tau(h)=j}a_{h,j}\prod_{\substack{g:\tau(g)=j\cr g\neq h}}b_{g,j}\right)\prod_{\ell\neq j}\prod_{g:\tau(g)=\ell}b_{g,\ell}. $$

Therefore the evaluation tensor of $P$ has CP rank at most

$$ \sum_{\tau}\lvert\mathrm{im}(\tau)\rvert. $$

For each block $j$, exactly $k^H-(k-1)^H$ assignments use that block. Double counting the pairs $(\tau,j)$ with $j\in\mathrm{im}(\tau)$ gives

$$ \sum_{\tau}\lvert\mathrm{im}(\tau)\rvert=k\left(k^H-(k-1)^H\right). $$

Clearing denominators preserves every strict cube sign, so the evaluation tensor is a sign realization of $\Sigma_f^{I_1,\ldots,I_k}$. This proves the first claim. When $k=2$, the formula becomes $2(2^H-1)=2^{H+1}-2$. $\blacksquare$

### Lemma 2. Ambient CP-rank ceiling

Put $n_j=\lvert I_j\rvert$ and $m=\max_j n_j$. Every real tensor of format

$$ 2^{n_1}\times\cdots\times2^{n_k} $$

has CP rank at most

$$ \prod_{j\neq j_{\max}}2^{n_j}=2^{n-m}. $$

Indeed, expand in standard basis vectors along every mode except a largest mode, and retain the corresponding fiber as the vector in the largest mode. Since $m\geq\lceil n/k\rceil$,

$$ \mathrm{srank}_{\mathrm{CP}}\left(\Sigma_f^{I_1,\ldots,I_k}\right)\leq2^{n-\lceil n/k\rceil}. $$

$\blacksquare$

### Lemma 3. The matrix input-count barrier is optimal among block counts

Assume $H\geq2$ and $n\leq2H+1$. First let $k=2$. Lemma 2 gives

$$ \mathrm{srank}_{\mathrm{CP}}\left(\Sigma_f^{I_1,I_2}\right)\leq2^{\lfloor n/2\rfloor}\leq2^H\leq2^{H+1}-2=R_2(H). $$

Next let $k=3$. Lemma 2 gives the exponent bound

$$ n-\left\lceil\frac{n}{3}\right\rceil\leq\left\lfloor\frac{2(2H+1)}{3}\right\rfloor. $$

For $H=2$, the right side is $3$, so the ambient rank is at most $8\leq9=3^H$. For $H\geq3$, cubing the desired comparison and using $4\cdot16^H\leq27^H$ gives

$$ 2^{\left\lfloor2(2H+1)/3\right\rfloor}\leq3^H. $$

Finally, if $k\geq4$, then

$$ 2^{n-\lceil n/k\rceil}\leq2^{n-1}\leq2^{2H}\leq k^H. $$

For every $k\geq2$,

$$ k^H-(k-1)^H\geq k^{H-1}, $$

and hence $R_k(H)\geq k^H$. The ambient sign CP-rank ceiling is therefore at most $R_k(H)$ in all cases. This proves the dimension limitation. $\blacksquare$

## Consequence

A multiway tensor backend should be treated as a structured research layer, not as the default continuation of partition sign-rank. Any useful improvement must exploit equations or norms that couple different flattenings, positivity, or the tangential factor sharing. Ordinary flattening ranks and the ambient CP-rank ceiling cannot improve the balanced two-block input-count screen.
