# LTF Cofactor Slope Distance

## Statement

Let

$$ f:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace, $$

and split off one coordinate, writing inputs as $(z,y)\in\lbrace0,1\rbrace\times\lbrace0,1\rbrace^{n-1}$. Let

$$ f_0(y):=f(0,y), \qquad f_1(y):=f(1,y). $$

Suppose $f_0$ and $f_1$ have affine sign representations

$$ L_b(y) = \beta_b+\sum_{i=1}^{n-1}\alpha_{b,i}y_i \qquad (b\in\lbrace0,1\rbrace), $$

meaning

$$ f_b(y)=1 \qquad\Longleftrightarrow\qquad L_b(y)\gt0 $$

on the $(n-1)$-cube. Let

$$ \Delta(L_0,L_1) := \left\lbrace i\in\lbrace1,\ldots,n-1\rbrace: \alpha_{0,i}\neq\alpha_{1,i} \right\rbrace, $$

and set

$$ t:=\lvert\Delta(L_0,L_1)\rvert. $$

Then

$$ H^{\ast}(f)\leq1+t. $$

In particular, if both cofactors are constants or linear threshold functions, then

$$ H^{\ast}(f)\leq n. $$

If the affine sign representations can be chosen with $t=0$, then $f$ is constant or a nonconstant linear threshold function, so

$$ H^{\ast}(f)\in\lbrace0,1\rbrace. $$

If they can be chosen with $t\leq1$, then

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** When the two slices across one bit are LTFs, the cost is controlled by how many affine slopes change across the split. The constant term and all unchanged slopes are free inside one affine head; each changed slope creates one mixed monomial $zy_i$.

## Proof

Define the cofactor interpolation polynomial

$$ P(z,y):=(1-z)L_0(y)+zL_1(y). $$

Then $P(0,y)=L_0(y)$ and $P(1,y)=L_1(y)$, so

$$ f(z,y)=1 \qquad\Longleftrightarrow\qquad P(z,y)\gt0. $$

Thus $P$ sign-represents $f$.

Expanding,

$$ \begin{aligned} P(z,y) &=L_0(y)+z\bigl(L_1(y)-L_0(y)\bigr)\cr &= \beta_0+\sum_{i=1}^{n-1}\alpha_{0,i}y_i +z(\beta_1-\beta_0) +\sum_{i\in\Delta(L_0,L_1)}(\alpha_{1,i}-\alpha_{0,i})zy_i. \end{aligned} $$

The first three terms are affine in $(z,y)$. The only nonlinear monomials are the $t$ mixed monomials

$$ zy_i \qquad (i\in\Delta(L_0,L_1)). $$

Therefore

$$ \mathrm{afs}(P)\leq1+t. $$

The affine-free sparsity theorem [048_affine_free_sparsity_upper_bound.md](../03_function_families_and_affine_geometry/048_affine_free_sparsity_upper_bound.md) gives

$$ H^{\ast}(f)\leq1+t. $$

If both cofactors are constants or LTFs, affine sign representations exist and $t\leq n-1$, so $H^{\ast}(f)\leq n$.

If $t=0$, then $P$ is affine in $(z,y)$. Hence $f$ is constant or a nonconstant LTF, giving $H^{\ast}(f)\in\lbrace0,1\rbrace$ by the one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md).

If $t\leq1$, then $\mathrm{afs}(P)\leq2$. The exact classification follows from the low affine-free support theorem [070_low_affine_free_support_exact.md](../03_function_families_and_affine_geometry/070_low_affine_free_support_exact.md). $\blacksquare$

## Consequences

For functions with LTF cofactors along one split, define the slope cost of a chosen pair of affine cofactor separators as the number of coordinates whose linear coefficients differ. Minimizing this cost over all separator choices gives a concrete invariant $\sigma_z(f)$ for that split, and the theorem gives

$$ H^{\ast}(f)\leq1+\sigma_z(f). $$

This is useful because affine separators are not unique. A bad pair of separators may change many slopes, while a better pair can reveal that the glued function is already an LTF or exactly two-head.
