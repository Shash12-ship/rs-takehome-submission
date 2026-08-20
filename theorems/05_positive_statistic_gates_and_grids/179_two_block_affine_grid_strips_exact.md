# Two-Block Affine Grid Strips Are Two-Head

## Statement

Let the variables be split into two nonempty blocks $A$ and $B$, with

$$ s(x):=\sum_{i\in A}x_i, \qquad t(x):=\sum_{j\in B}x_j. $$

Fix real numbers $a,b,c,\alpha,\beta$, with $(a,b)\neq(0,0)$ and $\alpha\leq\beta$. Define the affine grid-strip predicate

$$ f_{a,b,c,\alpha,\beta}(x):=\mathbf{1}[\alpha\leq a s(x)+b t(x)+c\leq\beta]. $$

Then

$$ H^{\ast}(f_{a,b,c,\alpha,\beta})\leq2. $$

More precisely,

$$ H^{\ast}(f_{a,b,c,\alpha,\beta}) = \begin{cases} 0 & \text{if } f_{a,b,c,\alpha,\beta} \text{ is constant},\cr 1 & \text{if } f_{a,b,c,\alpha,\beta} \text{ is a nonconstant LTF},\cr 2 & \text{otherwise}. \end{cases} $$

Let $G_{a,b,c,\alpha,\beta}$ be the associated grid function

$$ G_{a,b,c,\alpha,\beta}(u,v):=\mathbf{1}[\alpha\leq a u+b v+c\leq\beta] $$

on the grid $\lbrace0,\ldots,\lvert A\rvert\rbrace\times\lbrace0,\ldots,\lvert B\rvert\rbrace$, and let $\delta(G_{a,b,c,\alpha,\beta})$ be the least total degree of a real polynomial in $u,v$ that strictly sign-represents $G_{a,b,c,\alpha,\beta}$ on this grid. Then

$$ H^{\ast}(f_{a,b,c,\alpha,\beta})=\delta(G_{a,b,c,\alpha,\beta}). $$

> **Interpretation.** A two-block Hamming profile supported between two parallel affine grid lines is exactly an affine slab after lifting to the cube. Thus all affine strips in the two-block profile grid live at head complexity at most two.

## Proof

Define the affine statistic on the original cube

$$ L(x):=a s(x)+b t(x)+c. $$

Then

$$ f_{a,b,c,\alpha,\beta}(x)=\mathbf{1}[\alpha\leq L(x)\leq\beta]. $$

The affine slab theorem [062_affine_slab_upper_bound.md](../03_function_families_and_affine_geometry/062_affine_slab_upper_bound.md) gives

$$ H^{\ast}(f_{a,b,c,\alpha,\beta})\leq2 $$

and the exact $0$, $1$, or $2$ split according as the predicate is constant, a nonconstant LTF, or neither.

Now compare this with the grid sign degree. If $G_{a,b,c,\alpha,\beta}$ is constant, then $\delta(G_{a,b,c,\alpha,\beta})=0$, and the lifted function is constant as well.

Assume $G_{a,b,c,\alpha,\beta}$ is nonconstant. Set

$$ m:=\frac{\alpha+\beta}{2}, \qquad r_0:=\frac{\beta-\alpha}{2}. $$

For a grid point $(u,v)$, define

$$ W(u,v):=a u+b v+c-m. $$

The true grid points are exactly those with $\lvert W(u,v)\rvert\leq r_0$. Since the grid is finite and the predicate is nonconstant, there are true and false grid points. Define

$$ r_{\mathrm{in}}:=\max\lbrace\lvert W(u,v)\rvert:G_{a,b,c,\alpha,\beta}(u,v)=1\rbrace $$

and

$$ r_{\mathrm{out}}:=\min\lbrace\lvert W(u,v)\rvert:G_{a,b,c,\alpha,\beta}(u,v)=0\rbrace. $$

Then

$$ r_{\mathrm{in}}\leq r_0\lt r_{\mathrm{out}}. $$

Choose $r$ with

$$ r_{\mathrm{in}}\lt r\lt r_{\mathrm{out}}. $$

The polynomial

$$ R(u,v):=1-\left(\frac{W(u,v)}{r}\right)^2 $$

strictly sign-represents $G_{a,b,c,\alpha,\beta}$ on the grid. Therefore

$$ \delta(G_{a,b,c,\alpha,\beta})\leq2. $$

If $G_{a,b,c,\alpha,\beta}$ is not linearly threshold on the grid, then its sign degree is not $1$, so $\delta(G_{a,b,c,\alpha,\beta})=2$.

The lifted predicate $f_{a,b,c,\alpha,\beta}$ is an LTF exactly when $G_{a,b,c,\alpha,\beta}$ is linearly threshold on the grid. If the grid predicate has a strict affine separator in $u,v$, substituting $u=s(x)$ and $v=t(x)$ gives one for the lifted predicate. Conversely, average any strict affine separator for the lifted predicate over all coordinate permutations inside $A$ and inside $B$. The signs are preserved because the lifted predicate is constant on two-block Hamming orbits, and the averaged affine form has the shape

$$ \lambda s(x)+\mu t(x)+\nu. $$

This descends to a strict affine separator on the grid.

Thus the $0$, $1$, and $2$ cases for $H^{\ast}(f_{a,b,c,\alpha,\beta})$ match the $0$, $1$, and $2$ cases for $\delta(G_{a,b,c,\alpha,\beta})$. Hence

$$ H^{\ast}(f_{a,b,c,\alpha,\beta})=\delta(G_{a,b,c,\alpha,\beta}). $$

This proves the theorem. $\blacksquare$

## Consequence

Theorem 178 is the zero-width case $\alpha=\beta=0$ after absorbing constants into $c$. Theorem 177 is the further specialization where the affine level intersects the grid in one point. More generally, every two-block profile whose true set is one affine strip is exactly controlled by bivariate grid sign degree and costs at most two heads.
