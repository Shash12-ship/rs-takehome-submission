# Non-XOR Gates Through Lifted Cost

## Statement

Let

$$ T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace $$

be any Boolean function, and let

$$ G:\lbrace0,1\rbrace^{2}\to\lbrace0,1\rbrace $$

be a two-input Boolean gate that is neither XOR nor XNOR. Define

$$ F(z,y):=G(z,T(y)). $$

Then:

1. If $G$ is constant or depends only on $z$, then

$$ H^{\ast}(F)\leq1. $$

2. If $G$ depends only on its second input, then

$$ H^{\ast}(F)\leq\mathrm{actc}(T). $$

3. If $G$ genuinely depends on both inputs, then

$$ H^{\ast}(F)\leq1+\mathrm{lgactc}(T). $$

In particular, for every non-XOR and non-XNOR gate $G$,

$$ H^{\ast}(G(z,T(y))) \leq 1+\mathrm{actc}(T)+\mathrm{lgactc}(T), $$

and the sharper case split above should be used whenever the gate form is known.

> **Interpretation.** The arbitrary non-XOR recursion $H^{\ast}(G(z,T))\leq H^{\ast}(T)+1$ can be sharpened for gates that genuinely combine the fresh literal with the feature: the relevant parameter is the lifted literal-gating cost of $T$.

## Proof

If $G$ is constant, then $F$ is constant, so $H^{\ast}(F)=0$. If $G$ depends only on $z$, then $F$ is a one-bit literal or its complement, so $H^{\ast}(F)\leq1$.

If $G$ depends only on its second input, then $F$ is either $T$ or $1-T$. The affine-cylinder upper bound [103_affine_cylinder_threshold_cost.md](103_affine_cylinder_threshold_cost.md) and complement invariance give

$$ H^{\ast}(F)\leq\mathrm{actc}(T). $$

Now suppose $G$ depends on both inputs and is neither XOR nor XNOR. Then, up to output complement and complementing the $T$ input, $G$ is one of

$$ r(z)\wedge u \qquad \text{or} \qquad r(z)\vee u, $$

where $r(z)$ is either $z$ or $1-z$.

Replacing $T$ by $1-T$ does not change $\mathrm{lgactc}(T)$, because negating a strict affine-cylinder score preserves the affine slopes and cylinder supports. Output complement does not change head complexity. Therefore the genuine two-input case follows from [122_lifted_literal_gating_cost.md](122_lifted_literal_gating_cost.md):

$$ H^{\ast}(F)\leq1+\mathrm{lgactc}(T). $$

The final uniform bound follows from the three cases, since each right-hand side is at most

$$ 1+\mathrm{actc}(T)+\mathrm{lgactc}(T). $$

$\blacksquare$

## Consequences

This separates the non-XOR gates into two regimes. If the gate ignores the fresh bit, the feature cost $\mathrm{actc}(T)$ is enough. If the gate genuinely uses both inputs, the cost is controlled by $\mathrm{lgactc}(T)$.

Thus the hard one-bit gates remain XOR and XNOR, where threshold degree increases and the lifted literal-gating cost is not the right target.
