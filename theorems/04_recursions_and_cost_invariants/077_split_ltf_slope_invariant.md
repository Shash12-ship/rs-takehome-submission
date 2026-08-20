# Split LTF Slope Invariant

## Statement

Let

$$ f:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace. $$

For a coordinate $j$, write the two cofactors as

$$ f_{j,b}(y):=f(y_1,\ldots,y_{j-1},b,y_j,\ldots,y_{n-1}) \qquad (b\in\lbrace0,1\rbrace), $$

where $y\in\lbrace0,1\rbrace^{n-1}$. Say that $j$ is an LTF split if both $f_{j,0}$ and $f_{j,1}$ are constants or linear threshold functions.

For an LTF split $j$, define $\sigma_j(f)$ to be the minimum, over all affine sign representations

$$ L_b(y) = \beta_b+\sum_{i=1}^{n-1}\alpha_{b,i}y_i \qquad (b\in\lbrace0,1\rbrace) $$

of the two cofactors, of the slope-change count

$$ \left\lvert \left\lbrace i\in\lbrace1,\ldots,n-1\rbrace: \alpha_{0,i}\neq\alpha_{1,i} \right\rbrace \right\rvert. $$

If $f$ has at least one LTF split, define

$$ \sigma_{\mathrm{split}}(f) := \min_{j:\ j\text{ is an LTF split}}\sigma_j(f). $$

Then

$$ H^{\ast}(f) \leq 1+\sigma_{\mathrm{split}}(f). $$

In particular, every function with an LTF split satisfies

$$ H^{\ast}(f)\leq n. $$

If $\sigma_{\mathrm{split}}(f)=0$, then $f$ is constant or a nonconstant LTF, so

$$ H^{\ast}(f)\in\lbrace0,1\rbrace. $$

If $\sigma_{\mathrm{split}}(f)\leq1$, then

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** A one-bit branch between two LTF slices is controlled by the best coordinate and the best pair of affine separators. This gives a coordinate-free invariant for the LTF-cofactor regime.

## Proof

Choose an LTF split $j$ and affine cofactor separators realizing $\sigma_{\mathrm{split}}(f)$. By coordinate permutation invariance from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), we may relabel the split coordinate as the first coordinate $z$ without changing $H^{\ast}$.

The LTF cofactor slope-distance theorem [076_ltf_cofactor_slope_distance.md](076_ltf_cofactor_slope_distance.md) applies to this split and gives

$$ H^{\ast}(f) \leq 1+\sigma_{\mathrm{split}}(f). $$

Since a slope-change count is always at most $n-1$, every function with an LTF split satisfies $H^{\ast}(f)\leq n$.

If $\sigma_{\mathrm{split}}(f)=0$, Lemma 76 says that $f$ is constant or a nonconstant LTF. The one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) gives $H^{\ast}(f)\in\lbrace0,1\rbrace$.

If $\sigma_{\mathrm{split}}(f)\leq1$, Lemma 76 gives $H^{\ast}(f)\leq2$. The exact value is then forced by the zero-head and one-head characterization from [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md): constants have value $0$, nonconstant LTFs have value $1$, and all remaining functions have value exactly $2$. $\blacksquare$

## Consequences

This invariant turns the LTF-cofactor theorem into an optimization problem:

1. choose a split coordinate whose two slices are LTFs,
2. choose affine separators for the two slices,
3. minimize the number of slopes that change across the split.

The theorem is strongest for functions that are not themselves LTFs but become LTFs after fixing one coordinate. It gives an exact two-head certificate whenever the best pair of slice separators changes only one slope.
