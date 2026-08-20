# Affine-Cylinder Cofactor Recursion

## Statement

Let

$$ f:\lbrace0,1\rbrace\times\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace, $$

and write its cofactors as

$$ f_b(y):=f(b,y) \qquad (b\in\lbrace0,1\rbrace). $$

Let

$$ r_b:=\mathrm{actc}(f_b). $$

Then

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{sactc}(f) \leq 1+m+2(r_0+r_1)+\min\lbrace r_0,r_1\rbrace. $$

Equivalently, for either choice of base cofactor $b\in\lbrace0,1\rbrace$,

$$ \mathrm{sactc}(f) \leq 1+m+3r_b+2r_{1-b}. $$

> **Interpretation.** This is a coarse Shannon recursion for the affine-cylinder invariant. It pays one affine block, up to one changed-slope cylinder per remaining coordinate, and at most twice the cofactor cylinder costs when supports are lifted by the split bit.

## Proof

Choose strict affine-cylinder scores for $f_0$ and $f_1$ achieving costs $r_0$ and $r_1$:

$$ S_b(y) = A_b(y) + \sum_{\gamma\in\Gamma_b}c_{b,\gamma}C_{\gamma}(y), $$

where

$$ A_b(y)=a_b+\sum_{i=1}^{m}\alpha_{b,i}y_i. $$

Let

$$ C_b:=\sum_{\gamma=(P,N)\in\Gamma_b}\kappa(P,N) $$

be the cylinder part of the $b$-th score. Since the total affine-cylinder cost is $r_b$,

$$ C_b\leq r_b. $$

Apply the cofactor interpolation lemma [111_affine_cylinder_cofactor_interpolation.md](111_affine_cylinder_cofactor_interpolation.md) with $S_0$ as the base score. Its affine indicator is at most $1$, and the number of changed affine slopes is at most $m$.

For every cylinder support $\gamma=(P,N)$,

$$ \kappa(P\cup\lbrace z\rbrace,N) = \min\lbrace2^{\lvert P\rvert+1},2^{\lvert N\rvert}\rbrace \leq 2\min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace = 2\kappa(P,N). $$

Thus the base cylinder contribution is at most $C_0$, and the changed-cylinder contribution is at most

$$ 2(C_0+C_1), $$

because every changed cylinder support lies in $\Gamma_0\cup\Gamma_1$. Therefore

$$ \mathrm{sactc}(f) \leq 1+m+C_0+2(C_0+C_1) = 1+m+3C_0+2C_1 \leq 1+m+3r_0+2r_1. $$

This proves the displayed bound with base cofactor $0$.

To use the cylinder part of cofactor $1$ as the base instead, use the same interpolated score

$$ S(z,y)=(1-z)S_0(y)+zS_1(y), $$

but rewrite its affine part as

$$ A_0(y)+z(A_1(y)-A_0(y)). $$

The affine indicator is again at most $1$, and the changed affine slopes again contribute at most $m$ pure positive cylinders $zy_i$.

For the cylinder part, rewrite

$$ (1-z)V_0(y)+zV_1(y) = V_1(y)+(1-z)(V_0(y)-V_1(y)), $$

where

$$ V_b(y):=\sum_{\gamma\in\Gamma_b}c_{b,\gamma}C_{\gamma}(y). $$

The base cylinder contribution is now at most $C_1$. A lifted changed cylinder has the form

$$ (1-z)C_{P,N}(y)=C_{P,N\cup\lbrace z\rbrace}(z,y), $$

and

$$ \kappa(P,N\cup\lbrace z\rbrace) = \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert+1}\rbrace \leq 2\kappa(P,N). $$

Therefore the same argument gives

$$ \mathrm{sactc}(f) \leq 1+m+C_1+2(C_0+C_1) = 1+m+2C_0+3C_1 \leq 1+m+2r_0+3r_1. $$

Taking the smaller of the two estimates gives

$$ \mathrm{sactc}(f) \leq 1+m+2(r_0+r_1)+\min\lbrace r_0,r_1\rbrace. $$

Finally, [112_split_affine_cylinder_cost.md](112_split_affine_cylinder_cost.md) gives

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{sactc}(f), $$

which completes the chain. $\blacksquare$

## Consequences

If both cofactors have bounded affine-cylinder cost, then $f$ has bounded head complexity with only a linear-in $m$ switching overhead:

$$ H^{\ast}(f) \leq 1+m+2(r_0+r_1)+\min\lbrace r_0,r_1\rbrace. $$

This is not intended to be tight for parity, where the exact recursion costs one head per fresh XOR bit. Its use is as a safe fallback when two cofactors have good affine-cylinder certificates but do not share enough structure for the sharper split interpolation lemmas to apply.
