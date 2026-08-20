# Lifted Literal-Gating Cost

## Statement

For a strict affine-cylinder score

$$ S(y)=A(y)+\sum_{\gamma\in\Gamma}c_{\gamma}C_{\gamma}(y), \qquad A(y)=a+\sum_{i=1}^{m}\alpha_i y_i, $$

define

$$ L(A):=\lbrace i:\alpha_i\neq0\rbrace, $$

and

$$ K_{+}(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P\cup\lbrace z\rbrace,N), \qquad K_{-}(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N\cup\lbrace z\rbrace). $$

Define the lifted literal-gating cost of a Boolean function $T$ by

$$ \mathrm{lgactc}(T) := \min_S \left( \lvert L(A)\rvert+\min\lbrace K_{+}(\Gamma),K_{-}(\Gamma)\rbrace \right), $$

where the minimum ranges over all strict affine-cylinder scores $S$ for $T$.

Then for either literal $r(z)\in\lbrace z,1-z\rbrace$,

$$ H^{\ast}(r(z)\wedge T(y)) \leq 1+\mathrm{lgactc}(T), $$

and

$$ H^{\ast}(r(z)\vee T(y)) \leq 1+\mathrm{lgactc}(T). $$

Moreover,

$$ \mathrm{lgactc}(T) \leq m+2\mathrm{actc}(T). $$

If $\mathrm{lgactc}(T)\leq1$, then every literal-gated function here that is neither constant nor a nonconstant LTF is exactly two-head.

> **Interpretation.** Literal gating has its own optimized cost: the number of affine slopes plus the cheaper way to lift the cylinder correction through the fresh literal.

## Proof

Fix a strict affine-cylinder score $S$ for $T$. Lemma [121_literal_gated_affine_cylinder_feature.md](121_literal_gated_affine_cylinder_feature.md) gives direct bounds for both $z$ and $1-z$ gates, using $K_{+}$ for the $z$ lift and $K_{-}$ for the $1-z$ lift.

If the cheaper lift is not the literal appearing in the desired gate, apply the global bit-flip on the fresh coordinate $z$. Head complexity is invariant under this bit flip by [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), and the bit flip swaps the two literals. Hence for either literal $r$,

$$ H^{\ast}(r\wedge T) \leq 1+\lvert L(A)\rvert+\min\lbrace K_{+}(\Gamma),K_{-}(\Gamma)\rbrace. $$

The same argument applies to $r\vee T$, or equivalently uses the disjunction bound in Lemma 121 and the same fresh-coordinate bit flip.

Minimizing over all strict affine-cylinder scores for $T$ proves the two displayed literal-gating bounds.

For the comparison with $\mathrm{actc}$, choose a strict affine-cylinder score $S$ for $T$ of optimal affine-cylinder cost. Let

$$ K(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N). $$

Then

$$ K(\Gamma)\leq\mathrm{actc}(T). $$

Also, $\lvert L(A)\rvert\leq m$, and for every cylinder support

$$ \kappa(P\cup\lbrace z\rbrace,N)\leq2\kappa(P,N), \qquad \kappa(P,N\cup\lbrace z\rbrace)\leq2\kappa(P,N). $$

Therefore

$$ \min\lbrace K_{+}(\Gamma),K_{-}(\Gamma)\rbrace \leq 2K(\Gamma) \leq 2\mathrm{actc}(T). $$

Thus

$$ \mathrm{lgactc}(T) \leq m+2\mathrm{actc}(T). $$

Finally, if $\mathrm{lgactc}(T)\leq1$, then each literal-gated function above has head complexity at most $2$. The exact constant, nonconstant LTF, or two-head split follows from the zero-head and one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md). $\blacksquare$

## Consequences

This cost is useful when $\mathrm{actc}(T)$ is small but the ordinary head representation of $T$ is not the right object to gate. The gate only needs lifted cylinder corrections and changed affine slopes.

The inequality

$$ \mathrm{lgactc}(T) \leq m+2\mathrm{actc}(T) $$

is intentionally coarse. In applications, the optimized lifted cost can be much smaller than the right-hand side, especially when one literal orientation keeps every cylinder locally cheap.
