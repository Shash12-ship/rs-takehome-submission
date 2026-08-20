# Checkerboard Obstruction For One Head

## Statement

Fix the one-layer attention-only model from [../../model.md](../../model.md), with a single head and a linear readout from the query token.

Let $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$. Suppose there exist distinct coordinates $i \neq j$ and a base assignment to all other coordinates such that, restricted to the two free bits $(a,b)$ in positions $i, j$, the function looks like

$$ f(0,0) = c, \qquad f(1,1) = c, \qquad f(0,1) = 1 - c, \qquad f(1,0) = 1 - c $$

for some $c \in \lbrace0,1\rbrace$.

Then $f$ cannot be computed with one head, so

$$ H^{\ast}(f)  \geq  2. $$

> **Equivalently.** Any function containing a 2-bit checkerboard restriction has head complexity at least $2$: one head cannot separate one diagonal of a restricted 2-cube from the other diagonal.

## Why This Is The Right Generalization Of XOR

The usual 2-bit XOR truth table is exactly the special case $c = 0$:

$$ 0,   1,   1,   0. $$

So the single-head XOR impossibility is just the first instance of a more general obstruction: *one head cannot separate one diagonal of a 2-cube from the other diagonal*.

## Proof

Fix all coordinates except $i$ and $j$, and let

$$ z(a,b) = \frac{N(a,b)}{D(a,b)} $$

be the projected one-head contribution to the query residual, as set up in [001_checkerboard_additive_decomposition.md](001_checkerboard_additive_decomposition.md). Recall that $D(a,b) \gt 0$ on the restriction.

**The same-class segments intersect.** Define

$$ P := \frac{N(0,0) + N(1,1)}{D(0,0) + D(1,1)}. $$

By the antipode identities [002_antipode_identities.md](002_antipode_identities.md) this is also

$$ P = \frac{N(0,1) + N(1,0)}{D(0,1) + D(1,0)}. $$

Since each $D(a,b)$ is strictly positive, both expressions are convex combinations:

$$ P \in \bigl[z(0,0),  z(1,1)\bigr] \quad\text{and}\quad P \in \bigl[z(0,1),  z(1,0)\bigr]. $$

So the segment joining one diagonal intersects the segment joining the other diagonal.

**Conclusion.** Assume there were an affine functional $L(z) = w^\top z - \tau$ separating the two classes.

- If $c = 0$, then $L$ must be nonpositive on $z(0,0), z(1,1)$ and positive on $z(0,1), z(1,0)$. By convexity it is nonpositive on the entire segment $[z(0,0), z(1,1)]$ and positive on the entire segment $[z(0,1), z(1,0)]$.

But those two segments intersect at $P$, so $L(P)$ would have to be both nonpositive and positive. Contradiction.

The case $c = 1$ is the same argument with the signs reversed.

Therefore no single head can realize a checkerboard restriction. $\blacksquare$

## Consequence

Any function with such a restriction must satisfy

$$ H^{\ast}(f)  \geq  2. $$

This is the core lower-bound mechanism currently available in the softmax-attention model. The exact one-head characterization [011_one_head_characterization.md](011_one_head_characterization.md) strengthens it: $H^{\ast}(f) \leq 1$ holds if and only if $f$ is a linear threshold function, and a checkerboard restriction is not linearly separable.
