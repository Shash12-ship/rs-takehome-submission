# Literal-Gated Affine-Cylinder Features

## Statement

Let

$$ T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace $$

have a strict affine-cylinder score

$$ S(y)=A(y)+\sum_{\gamma\in\Gamma}c_{\gamma}C_{\gamma}(y), \qquad A(y)=a+\sum_{i=1}^{m}\alpha_i y_i, $$

with distinct nonvacuous cylinder supports. Let $r(z)$ be either $z$ or $1-z$. Define

$$ L(A):=\lbrace i:\alpha_i\neq0\rbrace. $$

If $r(z)=z$, set

$$ K_r(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P\cup\lbrace z\rbrace,N), $$

and if $r(z)=1-z$, set

$$ K_r(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N\cup\lbrace z\rbrace). $$

Then

$$ H^{\ast}(r(z)\wedge T(y)) \leq 1+\lvert L(A)\rvert+K_r(\Gamma). $$

Also,

$$ H^{\ast}(r(z)\vee T(y)) \leq 1+\lvert L(A)\rvert+K_{1-r}(\Gamma), $$

where $1-r$ denotes the complementary literal.

In either case, if the displayed upper bound is at most $2$, then the exact value is $0$, $1$, or $2$ according as the gated function is constant, a nonconstant LTF, or neither.

> **Interpretation.** Literal conjunction and disjunction do not need the full raw-indicator calibration of $T$. They only need to lift the cylinders in one direction and pay for changed affine slopes.

## Proof

First consider $r(z)=z$ and the conjunction

$$ F(z,y):=z\wedge T(y). $$

The two slices as functions of $u=T(y)$ are

$$ G(0,u)=0, \qquad G(1,u)=u. $$

In the notation of [118_one_bit_affine_cylinder_branching.md](118_one_bit_affine_cylinder_branching.md),

$$ \mu_0=0, \qquad \mu_1=1. $$

Lemma 118 gives

$$ H^{\ast}(F) \leq \eta_G(A)+\lvert L(A)\rvert+K_r(\Gamma). $$

Since $\eta_G(A)\leq1$, this proves

$$ H^{\ast}(z\wedge T) \leq 1+\lvert L(A)\rvert+K_z(\Gamma), $$

where $K_z(\Gamma)=K_r(\Gamma)$ for $r=z$.

For $r(z)=1-z$, apply the same argument after replacing the split coordinate by its complementary literal. Equivalently, in the cofactor interpolation proof the lifted cylinders are

$$ (1-z)C_{P,N}(y)=C_{P,N\cup\lbrace z\rbrace}(z,y), $$

which gives the cost $K_r(\Gamma)$ in this case. Thus

$$ H^{\ast}((1-z)\wedge T) \leq 1+\lvert L(A)\rvert+K_{1-z}(\Gamma). $$

Now use De Morgan duality for disjunction. For any literal $r$,

$$ r\vee T = 1-\bigl((1-r)\wedge(1-T)\bigr). $$

The complement $1-T$ has strict score $-S$, with the same set $L(A)$ and the same cylinder supports and local costs. Complementing the output preserves head complexity by [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md). Applying the conjunction bound to $(1-r)\wedge(1-T)$ gives

$$ H^{\ast}(r\vee T) \leq 1+\lvert L(A)\rvert+K_{1-r}(\Gamma). $$

Finally, if either displayed upper bound is at most $2$, then the gated function has $H^{\ast}\leq2$. The exact constant, nonconstant LTF, or two-head split follows from the zero-head and one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md). $\blacksquare$

## Consequences

If the affine part has no nonzero slopes and every cylinder in $\Gamma$ remains local-cost one after the relevant lift, then literal gating costs at most two heads. Every nonconstant non-LTF in that class is exactly two-head.

For positive-monomial cylinder supports, the conjunction bound specializes to

$$ H^{\ast}(z\wedge T) \leq 1+\lvert L(A)\rvert+\lvert\Gamma\rvert. $$

For mixed-literal cylinder supports, the same formula holds with $\lvert\Gamma\rvert$ replaced by the lifted local costs, which can be much smaller than expanding all mixed cylinders into positive monomials.
