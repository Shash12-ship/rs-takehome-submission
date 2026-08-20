# Split Affine-Free Support Invariant

## Statement

Let

$$ f:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace. $$

Fix a split coordinate and write inputs as $(z,y)\in\lbrace0,1\rbrace\times\lbrace0,1\rbrace^{n-1}$. Let

$$ f_b(y):=f(b,y) \qquad (b\in\lbrace0,1\rbrace). $$

Let $P_0$ and $P_1$ be strict sign representations of $f_0$ and $f_1$, written as

$$ P_b(y) = c_b+\sum_{i=1}^{n-1}\alpha_{b,i}y_i +\sum_{\substack{S\subseteq\lbrace1,\ldots,n-1\rbrace\cr \lvert S\rvert\geq2}} a_{b,S}\prod_{i\in S}y_i \qquad (b\in\lbrace0,1\rbrace). $$

Define

$$ \lambda(P_0,P_1) := \mathbf{1} \left[ c_1\neq c_0 \text{ or } \exists i,\ \alpha_{0,i}\neq0 \right], $$

and the three support sets

$$ \mathcal{N}_0 := \left\lbrace S:\lvert S\rvert\geq2,\ a_{0,S}\neq0 \right\rbrace, $$

$$ \mathcal{L}_{\Delta} := \left\lbrace i:\alpha_{1,i}\neq\alpha_{0,i} \right\rbrace, $$

and

$$ \mathcal{N}_{\Delta} := \left\lbrace S:\lvert S\rvert\geq2,\ a_{1,S}\neq a_{0,S} \right\rbrace. $$

Let

$$ C(P_0,P_1) := \lambda(P_0,P_1) +\lvert\mathcal{N}_0\rvert +\lvert\mathcal{L}_{\Delta}\rvert +\lvert\mathcal{N}_{\Delta}\rvert. $$

For this split coordinate, let $\mathrm{scafs}_{\pm,j}(f)$ be the minimum of $C(P_0,P_1)$ over all strict sign representations of the two cofactors. Finally define

$$ \mathrm{scafs}_{\pm}(f) := \min_{1\leq j\leq n}\mathrm{scafs}_{\pm,j}(f). $$

Then

$$ H^{\ast}(f)\leq\mathrm{scafs}_{\pm}(f). $$

If

$$ \mathrm{scafs}_{\pm}(f)\leq2, $$

then

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** The cofactor recursion only needs to pay for affine-free structure that is present in the base cofactor, plus coefficients that actually change across the split. Shared nonlinear cofactor terms are not paid twice.

## Proof

Choose a coordinate $j$ and cofactor sign polynomials $P_0,P_1$. By coordinate permutation invariance from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), we may write this coordinate as the first coordinate $z$.

Define the interpolation polynomial

$$ P(z,y):=(1-z)P_0(y)+zP_1(y) = P_0(y)+z\bigl(P_1(y)-P_0(y)\bigr). $$

Then $P(0,y)=P_0(y)$ and $P(1,y)=P_1(y)$, so $P$ strictly sign-represents $f$.

Expanding the affine part gives

$$ c_0+\sum_{i=1}^{n-1}\alpha_{0,i}y_i +z(c_1-c_0). $$

This contributes exactly the affine indicator $\lambda(P_0,P_1)$ to affine-free support cost.

The degree at least two monomials of $P$ are contained in three disjoint families:

1. base nonlinear monomials from $P_0$,

$$ \prod_{i\in S}y_i \qquad (S\in\mathcal{N}_0); $$

2. mixed quadratic monomials from changed linear coefficients,

$$ z y_i \qquad (i\in\mathcal{L}_{\Delta}); $$

3. mixed higher monomials from changed nonlinear coefficients,

$$ z\prod_{i\in S}y_i \qquad (S\in\mathcal{N}_{\Delta}). $$

Therefore

$$ \mathrm{afs}(P) \leq C(P_0,P_1). $$

The affine-free sparsity theorem [048_affine_free_sparsity_upper_bound.md](../03_function_families_and_affine_geometry/048_affine_free_sparsity_upper_bound.md) gives

$$ H^{\ast}(f)\leq C(P_0,P_1). $$

Minimizing over cofactor sign polynomials and split coordinates proves

$$ H^{\ast}(f)\leq\mathrm{scafs}_{\pm}(f). $$

If $\mathrm{scafs}_{\pm}(f)\leq2$, then $H^{\ast}(f)\leq2$. The exact value is now forced by the zero-head and one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md): constants have value $0$, nonconstant LTFs have value $1$, and all remaining functions have value exactly $2$. $\blacksquare$

## Consequences

This invariant sharpens the raw affine-free cofactor recursion. Lemma 75 pays for the full union of nonlinear cofactor supports. The split affine-free support invariant pays only for nonlinear coefficients that already occur in the $z=0$ cofactor and coefficients that actually change across the split.

In particular, if two cofactors share a large sparse sign polynomial and differ only in a few coefficients, then $H^{\ast}(f)$ is controlled by that shared support plus the small change set.
