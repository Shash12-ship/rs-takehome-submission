# Antipode Identities On A Restricted 2-Cube

## Statement

Use the single-head 2-coordinate restriction of [001_checkerboard_additive_decomposition.md](001_checkerboard_additive_decomposition.md), with $N(a,b)$ and $D(a,b)$ the projected softmax numerator and denominator. Then the two diagonal sums agree:

$$ N(0,0) + N(1,1) = N(0,1) + N(1,0) $$

and

$$ D(0,0) + D(1,1) = D(0,1) + D(1,0). $$

## Proof

By the additive decomposition [001_checkerboard_additive_decomposition.md](001_checkerboard_additive_decomposition.md), $N(a,b) = A(a) + B(b) + C$. Expanding both diagonal sums,

$$ \begin{aligned} N(0,0) + N(1,1) &= \bigl(A(0) + B(0) + C\bigr) + \bigl(A(1) + B(1) + C\bigr) \cr &= A(0) + A(1) + B(0) + B(1) + 2C, \end{aligned} $$

and

$$ \begin{aligned} N(0,1) + N(1,0) &= \bigl(A(0) + B(1) + C\bigr) + \bigl(A(1) + B(0) + C\bigr) \cr &= A(0) + A(1) + B(0) + B(1) + 2C. \end{aligned} $$

The two are equal. The denominator $D(a,b) = \alpha(a) + \beta(b) + \gamma$ has the identical form, so the proof for $D$ is the same. $\blacksquare$
