# Two-Block Singleton Grid Points Are Two-Head

## Statement

Let the variables be split into two nonempty blocks $A$ and $B$, with

$$ s(x):=\sum_{i\in A}x_i, \qquad t(x):=\sum_{j\in B}x_j. $$

Fix grid levels

$$ r\in\lbrace0,\ldots,\lvert A\rvert\rbrace, \qquad q\in\lbrace0,\ldots,\lvert B\rvert\rbrace. $$

Define the singleton grid-point predicate

$$ f_{r,q}(x):=\mathbf{1}[s(x)=r \text{ and } t(x)=q]. $$

Then

$$ H^{\ast}(f_{r,q})\leq2. $$

More precisely,

$$ H^{\ast}(f_{r,q}) = \begin{cases} 1, & \text{if } f_{r,q} \text{ is a nonconstant LTF},\cr 2, & \text{otherwise}. \end{cases} $$

For the associated singleton grid function $G_{r,q}$, this is exactly

$$ H^{\ast}(f_{r,q})=\delta(G_{r,q}). $$

The two-head upper bound uses denominators with positive coefficients, so it is valid for the model-faithful one-signed denominator class.

> **Interpretation.** A disk on the two-block Hamming grid whose positive set is a single grid point is not a counterexample to the two-block collapse conjecture. It is an exact affine level set after a nonresonant linear recombination of the two Hamming weights.

## Proof

The grid is finite. Choose a real number $\eta$ avoiding the finite bad set

$$ \left\lbrace -\frac{u-r}{v-q}: (u,v)\in\lbrace0,\ldots,\lvert A\rvert\rbrace\times\lbrace0,\ldots,\lvert B\rvert\rbrace, (u,v)\neq(r,q), v\neq q \right\rbrace. $$

Define the affine form

$$ L(x):=s(x)-r+\eta(t(x)-q). $$

At the target grid point $(r,q)$, we have $L(x)=0$.

Conversely, suppose a grid point $(u,v)$ satisfies

$$ u-r+\eta(v-q)=0. $$

If $v=q$, then the equation gives $u=r$. If $v\neq q$, then

$$ \eta=-\frac{u-r}{v-q}, $$

which is excluded by the choice of $\eta$. Hence $(u,v)=(r,q)$.

Therefore

$$ f_{r,q}(x)=\mathbf{1}[L(x)=0]. $$

Let

$$ \Delta:=\min\lbrace \lvert u-r+\eta(v-q)\rvert : (u,v)\neq(r,q) \text{ is a grid point} \rbrace. $$

Then $\Delta\gt0$, and the bivariate polynomial

$$ R(u,v):=\frac{1}{2}-\left(\frac{u-r+\eta(v-q)}{\Delta}\right)^2 $$

strictly sign-represents $G_{r,q}$ on the grid. Thus $\delta(G_{r,q})\leq2$.

If $f_{r,q}$ is a nonconstant LTF, then $\delta(G_{r,q})=1$. Otherwise it is not linearly threshold, so $\delta(G_{r,q})\geq2$, and the degree-two separator gives

$$ \delta(G_{r,q})=2. $$

The affine level-set theorem [061_affine_level_set_upper_bound.md](../03_function_families_and_affine_geometry/061_affine_level_set_upper_bound.md) gives

$$ H^{\ast}(f_{r,q})\leq2. $$

That theorem constructs the two atoms using affine denominators with positive constant term and positive variable coefficients. Hence the construction lies in the one-signed denominator class.

Finally, the zero-head case cannot occur because both blocks are nonempty and the grid has at least two points. The one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) says that the remaining exact value is $1$ precisely for nonconstant LTFs and $2$ otherwise. Combining this with the preceding computation of $\delta(G_{r,q})$ proves $H^{\ast}(f_{r,q})=\delta(G_{r,q})$. $\blacksquare$

## Consequence

Let $a=b=m$ and let

$$ G(s,t)=\mathbf{1}[(s-s_0)^2+(t-t_0)^2\lt\rho^2]. $$

If the strict disk contains exactly one grid point, then the lifted two-block function has head complexity at most $2$, and has exact value $2$ unless that singleton grid layer is linearly threshold.
