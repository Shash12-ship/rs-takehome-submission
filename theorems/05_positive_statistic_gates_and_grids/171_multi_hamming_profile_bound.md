# Multi-Hamming Profile Bound

## Statement

Let the variables be split into $b\geq2$ blocks

$$ x^{(1)},\ldots,x^{(b)} $$

with block sizes $n_1,\ldots,n_b$. Suppose

$$ f(x^{(1)},\ldots,x^{(b)}) = F(\lvert x^{(1)}\rvert,\ldots,\lvert x^{(b)}\rvert). $$

Read the grid

$$ \lbrace0,\ldots,n_1\rbrace\times\cdots\times\lbrace0,\ldots,n_b\rbrace $$

in lexicographic order, with the first block slowest and the last block fastest. Let $L_{\mathrm{Ham}}(F)$ be the number of sign changes of $F$ along this ordered grid path.

Then

$$ H^{\ast}(f)\leq L_{\mathrm{Ham}}(F). $$

For every block $j$ and every choice of Hamming weights in the other blocks, the corresponding symmetric one-block fiber lower-bounds $H^{\ast}(f)$:

$$ H^{\ast}\bigl(F(r_1,\ldots,r_{j-1},\lvert x^{(j)}\rvert,r_{j+1},\ldots,r_b)\bigr) \leq H^{\ast}(f). $$

If

$$ \deg_{\pm}(f)=L_{\mathrm{Ham}}(F), $$

then

$$ H^{\ast}(f)=\deg_{\pm}(f)=L_{\mathrm{Ham}}(F). $$

> **Interpretation.** A function of several Hamming weights has a head upper bound equal to the sign changes along any chosen lexicographic path through its weight grid.

## Proof

Apply the positive lexicographic multigrid bound [170_positive_lexicographic_multigrid_bound.md](170_positive_lexicographic_multigrid_bound.md) with

$$ t_j(x^{(j)})=\lvert x^{(j)}\rvert. $$

The image of $t_j$ is $\lbrace0,\ldots,n_j\rbrace$, so the multigrid lexicographic sign-change count is exactly $L_{\mathrm{Ham}}(F)$.

The one-block fiber lower bounds and the exactness statement are the corresponding conclusions of Theorem 170. $\blacksquare$

## Consequence

The ordinary symmetric theorem is the one-block case. This theorem gives a direct multiblock extension for profile predicates.
