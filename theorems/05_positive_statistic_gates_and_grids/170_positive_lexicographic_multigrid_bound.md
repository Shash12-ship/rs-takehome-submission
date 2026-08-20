# Positive Lexicographic Multigrid Bound

## Statement

Let the variables be split into $b\geq2$ disjoint blocks

$$ x^{(1)},\ldots,x^{(b)}. $$

For each block, let

$$ t_j(x^{(j)})=\sum_i\lambda_{j,i}x^{(j)}_i, \qquad \lambda_{j,i}\gt0, $$

and write the image of $t_j$ as

$$ V_j=\lbrace\nu^{(j)}_0\lt\nu^{(j)}_1\lt\cdots\lt\nu^{(j)}_{R_j-1}\rbrace. $$

Assume

$$ f(x^{(1)},\ldots,x^{(b)})=F(t_1(x^{(1)}),\ldots,t_b(x^{(b)})). $$

Order the grid

$$ V_1\times\cdots\times V_b $$

lexicographically, with $V_1$ slowest and $V_b$ fastest. Let $L_{\mathrm{lex}}(F)$ be the number of sign changes in the ordered Boolean sequence obtained by reading $F$ along this lexicographic grid path.

Then

$$ H^{\ast}(f)\leq L_{\mathrm{lex}}(F). $$

For every block $j$ and every choice of levels in the other blocks, the corresponding one-block fiber gives a restriction lower bound:

$$ H^{\ast}\bigl(F(\nu^{(1)}_{r_1},\ldots,\nu^{(j-1)}_{r_{j-1}},t_j(x^{(j)}),\nu^{(j+1)}_{r_{j+1}},\ldots,\nu^{(b)}_{r_b})\bigr) \leq H^{\ast}(f). $$

If

$$ \deg_{\pm}(f)=L_{\mathrm{lex}}(F), $$

then

$$ H^{\ast}(f)=\deg_{\pm}(f)=L_{\mathrm{lex}}(F). $$

> **Interpretation.** Any finite positive-statistic multigrid can be traversed by one positive projection. The cost is the number of label changes along that lexicographic traversal.

## Proof

First discard any block whose statistic has a one-point image, since it is constant and does not affect the grid order. Thus assume each $R_j\geq2$.

For each $j$, let

$$ \Delta_j:=\min_{0\leq r\lt R_j-1}\left(\nu^{(j)}_{r+1}-\nu^{(j)}_r\right)\gt0 $$

and

$$ \Lambda_j:=\nu^{(j)}_{R_j-1}-\nu^{(j)}_0. $$

Choose positive scales $K_b,K_{b-1},\ldots,K_1$ recursively. Start with $K_b=1$. Having chosen $K_{j+1},\ldots,K_b$, choose $K_j$ so large that

$$ K_j\Delta_j\gt\sum_{\ell=j+1}^{b}K_{\ell}\Lambda_{\ell}. $$

Define the combined positive statistic

$$ s(x):=\sum_{j=1}^{b}K_jt_j(x^{(j)}). $$

The scale inequalities ensure that increasing an earlier coordinate of the grid by one level moves $s$ more than the entire possible variation of all later coordinates. Therefore the ordering of the grid by $s$ is exactly the chosen lexicographic order.

Since $f$ factors through the grid, it also factors through the ordered image of $s$ along this lexicographic traversal. The sign-change count along $s$ is $L_{\mathrm{lex}}(F)$. Applying the positive-projection sign-change upper bound [013_positive_projection_sign_changes.md](../01_foundations_and_normal_form/013_positive_projection_sign_changes.md) gives

$$ H^{\ast}(f)\leq L_{\mathrm{lex}}(F). $$

For the lower bound, fix all blocks except $j$ to assignments attaining the specified levels. Restriction monotonicity gives the displayed inequality.

If $\deg_{\pm}(f)=L_{\mathrm{lex}}(F)$, combine the upper bound with the threshold-degree lower bound

$$ \deg_{\pm}(f)\leq H^{\ast}(f). $$

The two sides match, so $H^{\ast}(f)=\deg_{\pm}(f)=L_{\mathrm{lex}}(F)$. $\blacksquare$

## Consequence

Theorem 165 is the two-block case. This theorem gives a direct route for functions of several positive statistics.
