# Multigrid Run Bound

## Statement

Use the setup of Theorem 170, and read the grid values of $F$ in the same lexicographic order. For a label $b\in\lbrace0,1\rbrace$, let $R_b$ be the number of contiguous runs of the label $b$ in this ordered grid sequence.

Then

$$ H^{\ast}(f)\leq 2\min\lbrace R_0,R_1\rbrace. $$

More sharply, if the chosen cheaper label $b$ has first and last sequence labels $\epsilon_0,\epsilon_1$ with respect to membership in the $b$-label set, then

$$ H^{\ast}(f)\leq 2R_b-\epsilon_0-\epsilon_1. $$

If this sharper run count equals $\deg_{\pm}(f)$, then this upper bound is exact.

> **Interpretation.** Multigrid structure reduces sparse-support style bounds to runs along a grid path. The cost depends on the number of grid runs, not on the number of cube points in those runs.

## Proof

The lexicographic grid sequence is a Boolean sequence. If a label $b$ appears in $R_b$ contiguous runs, then the number of transitions into and out of those runs is

$$ 2R_b-\epsilon_0-\epsilon_1, $$

where $\epsilon_0=1$ if the first sequence value is $b$ and $\epsilon_1=1$ if the last sequence value is $b$.

This transition count is at most $2R_b$. It is also exactly the sign-change count of the full Boolean grid sequence. Applying Theorem 170 gives

$$ H^{\ast}(f)\leq2R_b-\epsilon_0-\epsilon_1. $$

Choosing the cheaper label gives

$$ H^{\ast}(f)\leq2\min\lbrace R_0,R_1\rbrace. $$

If the sharper transition count equals $\deg_{\pm}(f)$, then the threshold-degree lower bound matches the upper bound, so the value is exact. $\blacksquare$

## Consequence

For multiblock profile functions, sparse or interval-like behavior on the profile grid can yield head bounds far below the support size in the full Boolean cube.
