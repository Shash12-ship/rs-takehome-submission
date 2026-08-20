# Two-Block Affine Grid Lines Are Two-Head

## Statement

Let the variables be split into two nonempty blocks $A$ and $B$, with

$$ s(x):=\sum_{i\in A}x_i, \qquad t(x):=\sum_{j\in B}x_j. $$

Fix real numbers $a,b,c$, with $(a,b)\neq(0,0)$. Define the affine grid-line predicate

$$ f_{a,b,c}(x):=\mathbf{1}[a s(x)+b t(x)+c=0]. $$

Then

$$ H^{\ast}(f_{a,b,c})\leq2. $$

More precisely,

$$ H^{\ast}(f_{a,b,c}) = \begin{cases} 0 & \text{if } f_{a,b,c} \text{ is constant},\cr 1 & \text{if } f_{a,b,c} \text{ is a nonconstant LTF},\cr 2 & \text{otherwise}. \end{cases} $$

Let $G_{a,b,c}$ be the associated grid function

$$ G_{a,b,c}(u,v):=\mathbf{1}[a u+b v+c=0] $$

on the grid $\lbrace0,\ldots,\lvert A\rvert\rbrace\times\lbrace0,\ldots,\lvert B\rvert\rbrace$, and let $\delta(G_{a,b,c})$ be the least total degree of a real polynomial in $u,v$ that strictly sign-represents $G_{a,b,c}$ on this grid. Then

$$ H^{\ast}(f_{a,b,c})=\delta(G_{a,b,c}). $$

> **Interpretation.** Two-block Hamming profiles supported on one affine grid line collapse to the affine level-set theorem. Singleton grid points are the special case where the chosen affine line avoids every other grid point.

## Proof

The function

$$ L(x):=a s(x)+b t(x)+c $$

is affine in the original input bits. By definition,

$$ f_{a,b,c}(x)=\mathbf{1}[L(x)=0]. $$

The affine level-set theorem [061_affine_level_set_upper_bound.md](../03_function_families_and_affine_geometry/061_affine_level_set_upper_bound.md) gives

$$ H^{\ast}(f_{a,b,c})\leq2 $$

and the exact $0$, $1$, or $2$ case split according as the predicate is constant, a nonconstant LTF, or neither.

It remains to compare this value with the grid sign degree. If $G_{a,b,c}$ is constant, then $\delta(G_{a,b,c})=0$, and the lifted function is constant as well.

Assume $G_{a,b,c}$ is nonconstant. Then the grid contains at least one point on the line and at least one point off the line. Define

$$ \Delta:=\min\lbrace\lvert a u+b v+c\rvert : (u,v) \text{ is a grid point and } a u+b v+c\neq0\rbrace. $$

The grid is finite, so $\Delta\gt0$. The polynomial

$$ R(u,v):=\frac{1}{2}-\left(\frac{a u+b v+c}{\Delta}\right)^2 $$

strictly sign-represents $G_{a,b,c}$ on the grid. Indeed, $R(u,v)=1/2$ on the line, while $R(u,v)\leq -1/2$ at every off-line grid point. Hence

$$ \delta(G_{a,b,c})\leq2. $$

If $G_{a,b,c}$ is not linearly threshold on the grid, then it cannot have sign degree $1$, so $\delta(G_{a,b,c})=2$.

The lifted predicate $f_{a,b,c}$ is an LTF exactly when the grid predicate $G_{a,b,c}$ is linearly threshold on the grid. One direction is immediate by substituting $u=s(x)$ and $v=t(x)$. For the other direction, take any strict affine separator for $f_{a,b,c}$ on the cube and average it over all coordinate permutations within $A$ and within $B$. Since $f_{a,b,c}$ is constant on each two-block Hamming orbit, the averaged separator keeps the correct strict signs and has the form

$$ \alpha s(x)+\beta t(x)+\gamma. $$

Thus it gives a strict affine separator for $G_{a,b,c}$ on the grid.

Therefore the $0$, $1$, and $2$ cases for $H^{\ast}(f_{a,b,c})$ match the $0$, $1$, and $2$ cases for $\delta(G_{a,b,c})$. Hence

$$ H^{\ast}(f_{a,b,c})=\delta(G_{a,b,c}). $$

This proves the theorem. $\blacksquare$

## Consequence

Theorem 177 is recovered by choosing an affine line through the target grid point and avoiding all other grid points. More generally, any two-block profile whose true grid points form one affine line layer is exactly controlled by the two-dimensional grid sign degree and costs at most two heads.
