# One-Head Two-Coordinate Restrictions Split Additively

## Statement

Fix the one-layer attention-only model from [../../model.md](../../model.md), with a single head and a linear readout from the query token. Freeze all but two input coordinates $i \neq j$, and write the restricted input as $x^{(a,b)}$, where $(a,b)$ are the two free bits in positions $i, j$.

Let $\widetilde y(a,b)$ be the unprojected one-head output at the query token, and let

$$ z(a,b) := W_O \widetilde y(a,b) $$

be the projected contribution of that head to the query residual. Then

$$ z(a,b) = \frac{N(a,b)}{D(a,b)} $$

where

$$ N(a,b) := \sum_{t \in \lbrace1,\ldots,n,=\rbrace} \exp\bigl(\ell_t(a,b)\bigr)  \widehat v_t(a,b), $$

$$ D(a,b) := \sum_{t \in \lbrace1,\ldots,n,=\rbrace} \exp\bigl(\ell_t(a,b)\bigr), $$

and

$$ \widehat v_t(a,b) := W_O v_t(a,b). $$

So $N(a,b)$ is the vector-valued softmax numerator after the output projection, and $D(a,b) \gt 0$ is the scalar denominator.

Then on the restricted 2-cube both $N$ and $D$ decompose additively:

$$ N(a,b) = A(a) + B(b) + C, \qquad D(a,b) = \alpha(a) + \beta(b) + \gamma $$

for suitable functions $A, B, \alpha, \beta$ and constants $C, \gamma$.

## Proof

Each sequence position belongs to exactly one of three types:

1. The $i$-th input position depends only on $a$.
2. The $j$-th input position depends only on $b$.
3. Every other position, including the query token, is fixed across the restriction and contributes a constant.

Since the attention numerator is a sum over positions of per-position terms

$$ \exp\bigl(\ell_t(a,b)\bigr)  \widehat v_t(a,b), $$

and the denominator is the same sum without the projected value vectors, the dependence splits coordinatewise. Collecting the type-1, type-2, and constant terms separately in the numerator and the denominator gives the stated decomposition $N(a,b) = A(a) + B(b) + C$ and $D(a,b) = \alpha(a) + \beta(b) + \gamma$. $\blacksquare$

## Consequence

This additive structure is the engine behind the antipode identities [002_antipode_identities.md](002_antipode_identities.md) and, through them, the checkerboard one-head lower bound [003_checkerboard_obstruction.md](003_checkerboard_obstruction.md).
