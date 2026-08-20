# Positive One-Run Classes Are Exact

## Statement

Let

$$ f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace. $$

Suppose there is an injective positive weighted sum

$$ t(x)=\sum_{i=1}^{n}\lambda_i x_i, \qquad \lambda_i\gt0, $$

such that one label class of $f$ is a single contiguous block in the ordering of the cube by $t$.

Then

$$ H^{\ast}(f)\leq2. $$

More precisely,

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** The first nontrivial positive-run case is exactly solved. If the cheaper label class clusters into one interval along a positive ordering, the function is an affine slab.

## Proof

By complement invariance [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), it is enough to handle the case where the true set is one contiguous block in the $t$-ordering.

If the true set is empty or all of the cube, then $f$ is constant. Otherwise, list the cube points in increasing order of $t$:

$$ x^{(0)},x^{(1)},\ldots,x^{(2^n-1)}. $$

By assumption there are indices $a\leq b$ such that

$$ f(x^{(j)})=1 \qquad\Longleftrightarrow\qquad a\leq j\leq b. $$

Because $t$ is injective, choose real numbers $\alpha,\beta$ with

$$ t(x^{(a-1)})\lt\alpha\lt t(x^{(a)}) $$

if $a\gt0$, and choose $\alpha\lt t(x^{(0)})$ if $a=0$. Similarly, choose

$$ t(x^{(b)})\lt\beta\lt t(x^{(b+1)}) $$

if $b\lt2^n-1$, and choose $\beta\gt t(x^{(2^n-1)})$ otherwise.

Then

$$ f(x)=1 \qquad\Longleftrightarrow\qquad \alpha\leq t(x)\leq\beta. $$

Thus $f$ is an affine slab predicate. The affine-slab theorem [062_affine_slab_upper_bound.md](062_affine_slab_upper_bound.md) gives

$$ H^{\ast}(f)\leq2. $$

The exact case split follows from the zero-head and one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md): constants have value $0$, nonconstant LTFs have value $1$, and nonconstant non-LTFs need at least two heads. Together with the two-head upper bound, this proves the statement. $\blacksquare$

## Consequence

If

$$ R_{+}(f)=1, $$

where $R_{+}$ is the positive run-count invariant from [066_positive_run_upper_bound.md](066_positive_run_upper_bound.md), then $f$ has exact value $0$, $1$, or $2$ according as it is constant, a nonconstant LTF, or neither.
