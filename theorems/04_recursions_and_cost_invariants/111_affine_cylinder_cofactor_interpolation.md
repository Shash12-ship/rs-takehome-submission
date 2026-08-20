# Affine-Cylinder Cofactor Interpolation

## Statement

Let

$$ f:\lbrace0,1\rbrace\times\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace, $$

and write

$$ f_b(y):=f(b,y) \qquad (b\in\lbrace0,1\rbrace). $$

Suppose $f_b$ has a strict affine-cylinder score

$$ S_b(y) = A_b(y) + \sum_{\gamma\in\Gamma_b}c_{b,\gamma}C_{\gamma}(y), $$

meaning

$$ f_b(y)=1 \qquad\Longleftrightarrow\qquad S_b(y)\gt0, $$

where

$$ A_b(y)=a_b+\sum_{i=1}^{m}\alpha_{b,i}y_i, $$

each $\gamma=(P,N)$ is a nonvacuous cylinder support on the $y$ variables, the supports in $\Gamma_b$ are distinct, and all coefficients $c_{b,\gamma}$ are nonzero. For $\gamma\notin\Gamma_b$, set $c_{b,\gamma}:=0$.

Let

$$ \eta(A_0,A_1) := \mathbf{1} \left[ a_1\neq a_0 \text{ or } \exists i,\ \alpha_{0,i}\neq0 \right], $$

let

$$ \Delta_{\mathrm{lin}} := \lbrace i:\alpha_{1,i}\neq\alpha_{0,i}\rbrace, $$

and let

$$ \Delta_{\mathrm{cyl}} := \lbrace\gamma\in\Gamma_0\cup\Gamma_1:c_{1,\gamma}\neq c_{0,\gamma}\rbrace. $$

Then

$$ \mathrm{actc}(f) \leq \eta(A_0,A_1) + \lvert\Delta_{\mathrm{lin}}\rvert + \sum_{\gamma=(P,N)\in\Gamma_0}\kappa(P,N) + \sum_{\gamma=(P,N)\in\Delta_{\mathrm{cyl}}}\kappa(P\cup\lbrace z\rbrace,N), $$

where $z$ denotes the split coordinate.

> **Interpretation.** A split interpolation pays for one base affine block, changed affine slopes as $zy_i$ cylinders, the base cylinder vote on the $z=0$ cofactor, and only those cylinder coefficients that actually change across the split.

## Proof

Define the cofactor interpolation score

$$ S(z,y):=(1-z)S_0(y)+zS_1(y) = S_0(y)+z(S_1(y)-S_0(y)). $$

If $z=0$, then $S(z,y)=S_0(y)$, and if $z=1$, then $S(z,y)=S_1(y)$. Since both cofactor scores are strict on the cube,

$$ f(z,y)=1 \qquad\Longleftrightarrow\qquad S(z,y)\gt0. $$

We now rewrite $S$ as an affine-cylinder score. The affine part contributes

$$ A_0(y)+z(a_1-a_0) = a_0+\sum_{i=1}^{m}\alpha_{0,i}y_i+(a_1-a_0)z. $$

This affine form has nonzero linear part exactly when either $a_1\neq a_0$ or some $\alpha_{0,i}$ is nonzero. Hence it contributes $\eta(A_0,A_1)$ to the affine-cylinder cost.

The changed affine slopes contribute

$$ \sum_{i\in\Delta_{\mathrm{lin}}}(\alpha_{1,i}-\alpha_{0,i})z y_i. $$

Each product $zy_i$ is the cylinder $C_{\lbrace z,i\rbrace,\varnothing}$, whose local cost is

$$ \kappa(\lbrace z,i\rbrace,\varnothing)=1. $$

The base cylinder terms contribute

$$ \sum_{\gamma\in\Gamma_0}c_{0,\gamma}C_{\gamma}(y), $$

with total cost

$$ \sum_{\gamma=(P,N)\in\Gamma_0}\kappa(P,N). $$

Finally, for each changed cylinder support $\gamma=(P,N)\in\Delta_{\mathrm{cyl}}$, the interpolation contributes

$$ z(c_{1,\gamma}-c_{0,\gamma})C_{P,N}(y). $$

Since $zC_{P,N}(y)$ is the cylinder

$$ C_{P\cup\lbrace z\rbrace,N}(z,y), $$

these changed-cylinder terms have total cost

$$ \sum_{\gamma=(P,N)\in\Delta_{\mathrm{cyl}}}\kappa(P\cup\lbrace z\rbrace,N). $$

Combining the affine part, changed affine slopes, base cylinders, and changed cylinders gives a strict affine-cylinder representation of $f$ with exactly the displayed cost. By the definition of $\mathrm{actc}$,

$$ \mathrm{actc}(f) \leq \eta(A_0,A_1) + \lvert\Delta_{\mathrm{lin}}\rvert + \sum_{\gamma=(P,N)\in\Gamma_0}\kappa(P,N) + \sum_{\gamma=(P,N)\in\Delta_{\mathrm{cyl}}}\kappa(P\cup\lbrace z\rbrace,N). $$

$\blacksquare$

## Consequences

This is the affine-cylinder analogue of the split affine-free support invariant. It is sharper than separately paying for two cofactor certificates when the two slices share many cylinder coefficients.

If the two cofactor certificates use the same cylinder vote, then the interpolation only pays for that shared base cylinder vote plus the affine block. If there are no cylinder terms and the two affine parts differ only in their constants, then the full function has $\mathrm{actc}\leq1$. If the resulting function is nonconstant, it is an LTF by Lemma 109.
