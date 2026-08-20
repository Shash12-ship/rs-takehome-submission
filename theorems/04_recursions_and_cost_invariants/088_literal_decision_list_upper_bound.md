# Literal Decision-List Upper Bound

## Statement

A read-once literal decision list of length $L$ consists of distinct coordinates

$$ i_1,\ldots,i_L, $$

literals

$$ \ell_j(x)\in\lbrace x_{i_j},1-x_{i_j}\rbrace, $$

branch labels

$$ b_1,\ldots,b_L\in\lbrace0,1\rbrace, $$

and a default label $b_{L+1}\in\lbrace0,1\rbrace$. It computes the Boolean function $f$ that returns $b_j$ at the first index $j$ with $\ell_j(x)=1$, and returns $b_{L+1}$ if no literal fires.

Then

$$ H^{\ast}(f)\leq L. $$

More generally, any ordinary literal decision list is equivalent to a read-once literal decision list of no larger length, so the same bound holds for its simplified length.

> **Interpretation.** Literal decision lists admit a direct head-level recursion. Each tested literal costs at most one additional head.

## Proof

We first prove the read-once statement. For $j\in\lbrace1,\ldots,L+1\rbrace$, let $F_j$ be the suffix decision-list function beginning at test $j$, with $F_{L+1}\equiv b_{L+1}$. Thus $F_1=f$.

We prove by backward induction that

$$ H^{\ast}(F_j)\leq L-j+1. $$

The base case $j=L+1$ is constant, so

$$ H^{\ast}(F_{L+1})=0. $$

Now suppose $j\leq L$ and the claim holds for $F_{j+1}$. The coordinate $i_j$ does not occur in the suffix because the list is read-once, so $F_{j+1}$ is a function of the remaining coordinates.

If $b_j=1$, then the suffix relation is

$$ F_j(x)=\ell_j(x)\vee F_{j+1}(x). $$

The OR gate is neither XOR nor XNOR. Applying the one-bit non-XOR recursion theorem [087_one_bit_non_xor_gate_recursion.md](087_one_bit_non_xor_gate_recursion.md) gives

$$ H^{\ast}(F_j) \leq H^{\ast}(F_{j+1})+1 \leq L-j+1. $$

If $b_j=0$, then

$$ F_j(x)=(1-\ell_j(x))\wedge F_{j+1}(x). $$

The AND gate is also neither XOR nor XNOR, and the theorem applies again, with the complemented literal as the raw input. Therefore

$$ H^{\ast}(F_j) \leq H^{\ast}(F_{j+1})+1 \leq L-j+1. $$

This completes the induction and gives $H^{\ast}(f)\leq L$.

For an ordinary literal decision list, repeated coordinates can be removed without increasing length. Along the path reaching a later repeated coordinate, all earlier tested literals have failed, so the coordinate's value is already fixed. A later literal on that coordinate is therefore either always false and can be deleted, or always true and can be replaced by the corresponding output label as the new default for that suffix, deleting all later tests. Repeating this simplification terminates with an equivalent read-once literal decision list of no larger length.

Applying the read-once bound to the simplified list proves the general statement. $\blacksquare$

## Consequences

This proves the literal case of the decision-list upper-bound program:

$$ H^{\ast}(f)\leq L_{\mathrm{litDL}}(f), $$

where $L_{\mathrm{litDL}}(f)$ is the minimum length of a literal decision list computing $f$.

The result is incomparable with the positive-projection sign-change bound. For example, some literal decision lists alternate between variables that do not share one positive statistic, while monotone OR has $H^{\ast}=1$ even though its natural literal decision list has length $n$.
