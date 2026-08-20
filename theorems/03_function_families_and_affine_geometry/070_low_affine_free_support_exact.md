# Low Affine-Free Support Is Exact

## Statement

Let

$$ f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace. $$

Suppose

$$ \mathrm{afs}_{\pm}(f)\leq2, $$

where $\mathrm{afs}_{\pm}$ is the affine-free polynomial-threshold support cost from [048_affine_free_sparsity_upper_bound.md](048_affine_free_sparsity_upper_bound.md). Then

$$ H^{\ast}(f)\leq2. $$

More precisely,

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

In particular, this applies whenever $f$ is sign-represented by a polynomial of the form

$$ P(x)=A(x)+b\prod_{i\in S}x_i, \qquad \lvert S\rvert\geq2, $$

where $A$ is affine. It also applies to sign polynomials with no affine part and at most two nonlinear monomials.

> **Interpretation.** The affine-free support bound has an exact first nontrivial regime. Any Boolean function whose sign polynomial consists of one affine part plus one genuinely nonlinear monomial is either an LTF already or has exact value two.

## Proof

The affine-free sparsity theorem [048_affine_free_sparsity_upper_bound.md](048_affine_free_sparsity_upper_bound.md) gives

$$ H^{\ast}(f)\leq\mathrm{afs}_{\pm}(f). $$

Hence the hypothesis implies

$$ H^{\ast}(f)\leq2. $$

If $f$ is constant, then $H^{\ast}(f)=0$. If $f$ is a nonconstant LTF, the one-head characterization from [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) gives

$$ H^{\ast}(f)=1. $$

If $f$ is neither constant nor a nonconstant LTF, the same characterization gives

$$ H^{\ast}(f)\geq2. $$

Together with the two-head upper bound, this proves

$$ H^{\ast}(f)=2. $$

Finally, a sign polynomial of the displayed form has affine-free support cost at most two: the whole affine part costs one head, and the single nonlinear monomial costs one more. If the affine part is absent, two nonlinear monomials also have affine-free support cost at most two. $\blacksquare$

## Consequence

This gives a practical exactness test:

1. Find a sign polynomial with at most two affine-free pieces.
2. Check whether the function is constant or an LTF.
3. If not, conclude $H^{\ast}(f)=2$.

The criterion is complementary to the low positive-projection alternation criterion. It can certify two heads even when no good one-dimensional positive ordering is known.
