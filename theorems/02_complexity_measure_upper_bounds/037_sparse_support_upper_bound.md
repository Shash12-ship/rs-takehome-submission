# Sparse Support Upper Bound

## Statement

Let

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace $$

and define the minority support size

$$ s(f) := \min\lbrace \lvert f^{-1}(1)\rvert, \lvert f^{-1}(0)\rvert \rbrace. $$

Then

$$ H^{\ast}(f)\leq 2s(f). $$

In particular, every function with at most $s$ true inputs or at most $s$ false inputs satisfies

$$ H^{\ast}(f)\leq 2s. $$

If $s(f)=1$, then the sharper bound

$$ H^{\ast}(f)\leq1 $$

holds.

> **Interpretation.** Sparse and co-sparse functions are easy even when their true points have no monotone or symmetric structure. The invariant is the size of the smaller label class.

## Proof

If $f$ is constant, then $s(f)=0$ and $H^{\ast}(f)=0$.

Assume $f$ is nonconstant. Choose the positive injective statistic

$$ t(x):=\sum_{i=1}^{n}2^{i-1}x_i. $$

This statistic is injective on $\lbrace0,1\rbrace^n$, so $f$ factors through $t$.

List the cube points in increasing order of $t$:

$$ x^{(0)},x^{(1)},\ldots,x^{(2^n-1)}. $$

Let

$$ a_j:=f(x^{(j)}). $$

Let $m:=s(f)$, and choose the minority label $\beta\in\lbrace0,1\rbrace$ so that

$$ \lvert\lbrace j:a_j=\beta\rbrace\rvert=m. $$

The sign-change count of the sequence $a_0,\ldots,a_{2^n-1}$ is at most $2m$: each maximal contiguous block of minority labels contributes at most two boundary changes, one on entry and one on exit. The number of such blocks is at most $m$.

Therefore the positive-projection sign-change theorem [013_positive_projection_sign_changes.md](../01_foundations_and_normal_form/013_positive_projection_sign_changes.md) gives

$$ H^{\ast}(f)\leq C_t(f)\leq2m=2s(f). $$

If $s(f)=1$, then either $f^{-1}(1)=\lbrace a\rbrace$ or $f^{-1}(0)=\lbrace a\rbrace$ for some point $a\in\lbrace0,1\rbrace^n$. The singleton indicator is a linear threshold function:

$$ \mathbf{1}[x=a]=1 \qquad\Longleftrightarrow\qquad \sum_{i:a_i=1}x_i+\sum_{i:a_i=0}(1-x_i)\gt n-\frac{1}{2}. $$

Its complement is also a linear threshold function. By the exact one-head characterization from [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md), every nonconstant linear threshold function has $H^{\ast}=1$. Hence $H^{\ast}(f)\leq1$ when $s(f)=1$. $\blacksquare$

## Consequence

Let

$$ N_1(f):=\lvert f^{-1}(1)\rvert, \qquad N_0(f):=\lvert f^{-1}(0)\rvert. $$

Then

$$ H^{\ast}(f)\leq2\min\lbrace N_1(f),N_0(f)\rbrace. $$

This improves the generic $2^n-1$ bound whenever the smaller label class has size below $2^{n-1}$. It is especially useful for rare-event predicates and complements of rare-event predicates, where no low-dimensional positive projection or monotone normal form is visible.

The first nontrivial sparse case is sharper than the displayed general bound. If $s(f)\leq2$, then [064_two_point_support_exact.md](../03_function_families_and_affine_geometry/064_two_point_support_exact.md) gives

$$ H^{\ast}(f)\leq2, $$

with exact value determined by the constant, LTF, and non-LTF split.

The same sharpening applies to a larger geometric class. If a label class $A$ is exactly

$$ \mathrm{aff}(A)\cap\lbrace0,1\rbrace^n $$

and $\mathrm{aff}(A)$ is proper, then [065_affine_hull_clean_supports.md](../03_function_families_and_affine_geometry/065_affine_hull_clean_supports.md) gives the same two-head upper bound and exact split.
