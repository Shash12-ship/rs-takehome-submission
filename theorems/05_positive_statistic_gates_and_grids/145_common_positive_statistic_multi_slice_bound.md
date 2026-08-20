# Common Positive-Statistic Multi-Slice Bound

## Statement

Let $k\geq0$, let $z\in\lbrace0,1\rbrace^{k}$ be raw bits, and let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0. $$

Suppose $f(z,y)$ factors through $t$ on every raw-bit slice: for each $a\in\lbrace0,1\rbrace^{k}$, there is a function $F_a$ on the image of $t$ such that

$$ f(a,y)=F_a(t(y)). $$

Let $C_a$ be the sign-change count of $F_a$ along the ordered image of $t$. Then

$$ H^{\ast}(f) \leq \sum_{a\in\lbrace0,1\rbrace^{k}} C_a + 2^{k}-1. $$

> **Interpretation.** If all raw-bit slices share one positive statistic, then the full function is controlled by the total one-dimensional variation inside the slices, plus one possible jump between adjacent slices.

## Proof

Let

$$ \Lambda:=\sum_{i=1}^{m}\lambda_i, $$

and choose a number

$$ B\gt\Lambda. $$

For a raw assignment $a=(a_1,\ldots,a_k)$, define its binary code

$$ \mathrm{code}(a):=\sum_{j=1}^{k}2^{j-1}a_j. $$

Now define a positive statistic on the combined variables:

$$ s(z,y):=t(y)+B\sum_{j=1}^{k}2^{j-1}z_j. $$

All coefficients of $s$ are positive. For a fixed raw assignment $a$, the values of $s(a,y)$ lie in the interval

$$ \left[B\mathrm{code}(a),  B\mathrm{code}(a)+\Lambda\right]. $$

Since $B\gt\Lambda$, these intervals are disjoint and ordered by $\mathrm{code}(a)$. Therefore the ordered label sequence of $f$ along the statistic $s$ is obtained by concatenating the ordered label sequences of the slices $F_a(t(y))$ in increasing binary-code order.

Inside the slice $a$, the number of sign changes is $C_a$. Between two consecutive nonempty slices, there is at most one additional sign change. There are $2^k-1$ such boundaries. Hence the total sign-change count along $s$ is at most

$$ \sum_{a\in\lbrace0,1\rbrace^{k}} C_a+2^k-1. $$

Applying the positive-projection sign-change upper bound [013_positive_projection_sign_changes.md](../01_foundations_and_normal_form/013_positive_projection_sign_changes.md) to $s$ gives the stated head bound. $\blacksquare$

## Consequence

The case $k=1$ recovers the separated-slice positive-projection construction. Lemmas 139 and 140 improve that special case for one-bit gates by exploiting the algebraic relation between the two slices; the present lemma is the more general fallback when the raw slices are unrelated except for sharing the same statistic $t$.
