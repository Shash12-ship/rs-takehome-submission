# Positive Profile Projection Collapse

## Statement

Let the variables be split into blocks

$$ B_1,\ldots,B_b $$

with block sizes $n_1,\ldots,n_b$. Suppose

$$ f(x)=F(\lvert x_{B_1}\rvert,\ldots,\lvert x_{B_b}\rvert). $$

Let $a_1,\ldots,a_b\gt0$. Assume there is a Boolean function $G$ on the image of

$$ s(r_1,\ldots,r_b):=\sum_{j=1}^{b}a_jr_j $$

over the profile grid such that

$$ F(r_1,\ldots,r_b)=G(s(r_1,\ldots,r_b)). $$

List the image of $s$ on the grid in increasing order:

$$ \tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}. $$

Define

$$ C_a(G) := \lvert\lbrace m\in\lbrace1,\ldots,M-1\rbrace:G(\tau_{m-1})\neq G(\tau_m)\rbrace\rvert. $$

Then

$$ H^{\ast}(f)\leq C_a(G), \qquad C_{+}(f)\leq C_a(G). $$

If

$$ \deg_{\pm}(f)=C_a(G), $$

then

$$ H^{\ast}(f)=\deg_{\pm}(f)=C_a(G). $$

In particular, if $a_1=\cdots=a_b=1$, so that

$$ f(x)=G(\lvert x\rvert), $$

and $N=n_1+\cdots+n_b$, then

$$ H^{\ast}(f) = \lvert\lbrace k\in\lbrace1,\ldots,N\rbrace:G(k-1)\neq G(k)\rbrace\rvert. $$

> **Interpretation.** A multiblock Hamming profile can sometimes collapse to one positive projection. In that case the right cost is the sign-change count of the collapsed weighted sum, not the sign-change count along a full lexicographic grid traversal.

## Proof

Define the positive weighted sum on input variables

$$ t(x):=\sum_{j=1}^{b}a_j\lvert x_{B_j}\rvert = \sum_{j=1}^{b}\sum_{i\in B_j}a_jx_i. $$

All coefficients of $t$ are positive. By the assumed factorization,

$$ f(x)=G(t(x)). $$

The increasing image of $t$ on the cube is exactly the increasing image of $s$ on the profile grid. Its label sign-change count is $C_a(G)$. Applying the positive-projection sign-change theorem [013_positive_projection_sign_changes.md](../01_foundations_and_normal_form/013_positive_projection_sign_changes.md) gives

$$ H^{\ast}(f)\leq C_a(G) $$

and also

$$ C_{+}(f)\leq C_a(G). $$

If $\deg_{\pm}(f)=C_a(G)$, combine the upper bound with

$$ \deg_{\pm}(f)\leq H^{\ast}(f) $$

to get equality throughout.

When all $a_j$ are $1$, the function is symmetric in all $N$ variables. The exact symmetric sign-change theorem [012_symmetric_sign_changes.md](../01_foundations_and_normal_form/012_symmetric_sign_changes.md) gives

$$ H^{\ast}(f) = \lvert\lbrace k\in\lbrace1,\ldots,N\rbrace:G(k-1)\neq G(k)\rbrace\rvert. $$

This proves the final claim. $\blacksquare$

## Consequence

Theorem 174 is useful when the lexicographic grid path is the available certificate. This theorem gives the competing certificate: if the profile factors through a positive weighted sum of block weights, collapse the grid first and count changes only after the collapse.
