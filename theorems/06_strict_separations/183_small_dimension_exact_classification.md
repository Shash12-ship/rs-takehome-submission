# Exact Small-Dimension Classification Through Four Bits

## Statement

For every integer $n$ with $0\leq n\leq4$ and every Boolean function

$$ f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f)=\deg_{\pm}(f). $$

Consequently, if $n_{\mathrm{sep}}$ is the least input dimension of a strict separation, then

$$ n_{\mathrm{sep}}\geq5. $$

> **Certificate status.** The four-bit case is computer-assisted, but every archived witness is integral and the verifier uses exact integer arithmetic. No numerical linear-programming result is trusted during verification.

## Proof

The threshold-degree lower bound [006_threshold_degree_head_complexity_bound.md](../01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md) gives

$$ \deg_{\pm}(f)\leq H^{\ast}(f) $$

in every dimension. It remains to prove matching upper bounds on four bits.

### Lemma 1. Exact cleared-score certificates

Fix $H\in\lbrace2,3\rbrace$. A denominator dictionary consists of positive affine forms

$$ B_h(x)=b_{h,0}+\sum_{i=1}^{4}b_{h,i}x_i, \qquad h\in\lbrace1,\ldots,H\rbrace, $$

such that the four slopes of each form are all positive or all negative. For affine numerators $A_h$ and a constant $c$, define

$$ Q(x)=c\prod_{h=1}^{H}B_h(x)+\sum_{h=1}^{H}A_h(x)\prod_{g\neq h}B_g(x). $$

Every ratio $A_h/B_h$ is a one-head atom by the denominator-orientation theorem [032_denominator_orientation.md](../02_complexity_measure_upper_bounds/032_denominator_orientation.md). Since every denominator is positive on the Boolean cube,

$$ \mathrm{sgn}(Q(x))=\mathrm{sgn}\left(c+\sum_{h=1}^{H}\frac{A_h(x)}{B_h(x)}\right). $$

Thus an integral coefficient vector for $Q$ whose signs equal the target labels is an exact $H$-head certificate. It also gives a sign polynomial of degree at most $H$.

Index the vertices of the four-cube by the integers $x\in\lbrace0,\ldots,15\rbrace$, using the binary digits of $x$ as coordinates. Encode a truth table by

$$ M(f):=\sum_{x=0}^{15}f(x)2^x. $$

Output complementation sends $M(f)$ to $65535-M(f)$. Hence every complement pair has exactly one representative with

$$ 0\leq M(f)\lt32768. $$

The certificate archive [small_n4_exact_classification_certificate.npz](../../artifacts/calculations/small_n4_exact_classification_certificate.npz) contains the following integral data for these $32768$ representatives.

1. Seventeen two-denominator dictionaries and exact cleared-score coefficients cover $28787$ representatives.

2. Each of the remaining $3981$ representatives has an exact positive-circuit obstruction to threshold degree at most $2$.

3. Five three-denominator dictionaries and exact cleared-score coefficients cover $3980$ of the obstructed representatives.

The [verification script](../../artifacts/calculations/verify_small_n4_exact_classification.py) reconstructs every denominator and every cleared-score matrix from the archived integers. It checks denominator orientation, strict positivity, truth-table signs, uniqueness of the masks, and the complete partition of all $32768$ complement-pair representatives.

### Lemma 2. The positive circuits exclude quadratic thresholds

Let $V^{(2)}(x)$ be the vector of the $11$ squarefree monomials of degree at most $2$ evaluated at $x$. For each representative outside the two-head cover, the archive gives a nonzero vector

$$ \lambda:\lbrace0,\ldots,15\rbrace\to\mathbb{Z}_{\geq0} $$

such that, for the target signs $\sigma(x)\in\lbrace-1,+1\rbrace$,

$$ \sum_{x=0}^{15}\lambda(x)\sigma(x)V^{(2)}(x)=0. $$

Suppose a degree-at-most-two polynomial $P$ strictly sign-represented the same truth table. Write

$$ P(x)=\langle a,V^{(2)}(x)\rangle. $$

Then every number $\lambda(x)\sigma(x)P(x)$ is nonnegative, and at least one is positive. Therefore

$$ 0\lt\sum_{x=0}^{15}\lambda(x)\sigma(x)P(x)=\left\langle a,\sum_{x=0}^{15}\lambda(x)\sigma(x)V^{(2)}(x)\right\rangle=0, $$

a contradiction. Thus every one of these $3981$ representatives has threshold degree at least $3$.

All identities in this argument are checked over the integers. This is the strict-separation alternative of Gordan's theorem, specialized to the degree-two monomial evaluation matrix.

### Lemma 3. Every four-bit function has matching complexity

Consider first one of the $28787$ representatives with a two-head certificate. Its cleared score has degree at most $2$, so its threshold degree belongs to $\lbrace0,1,2\rbrace$.

If the threshold degree is $0$, the function is constant and has zero heads. If the threshold degree is $1$, the exact one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) gives one head. Otherwise its threshold degree is $2$, the archived score gives at most two heads, and the universal lower bound gives exactly two heads. Hence equality holds throughout the two-head cover.

Now consider one of the $3980$ non-parity representatives with a positive-circuit obstruction and a three-head certificate. Lemma 2 gives threshold degree at least $3$. Its cleared three-head score gives both threshold degree and head complexity at most $3$. Therefore

$$ H^{\ast}(f)=\deg_{\pm}(f)=3. $$

The only obstructed representative not covered by three heads is the parity mask

$$ \sum_{\substack{0\leq x\lt16\cr \lvert x\rvert\text{ odd}}}2^x=27030. $$

The exact parity theorem [008_exact_parity_complexity.md](../01_foundations_and_normal_form/008_exact_parity_complexity.md) gives

$$ H^{\ast}(\mathrm{XOR}_4)=\deg_{\pm}(\mathrm{XOR}_4)=4. $$

Output complementation preserves head complexity by [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md), and negating a sign polynomial preserves threshold degree. Thus the same classification holds for both members of every complement pair. This proves the theorem on four bits.

Finally, let $f$ use fewer than four bits and adjoin dummy variables to obtain a four-bit function $F$. Dummy-variable invariance in [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) gives

$$ H^{\ast}(F)=H^{\ast}(f). $$

Threshold degree is also invariant under dummy variables: extending a sign polynomial proves one inequality, and restricting the dummy variables proves the reverse inequality. Applying the four-bit result to $F$ gives

$$ H^{\ast}(f)=\deg_{\pm}(f). \qquad\blacksquare $$

## Certificate Summary

The exact cumulative and level counts on four bits are

$$ \begin{array}{c|rrrrr} d & 0 & 1 & 2 & 3 & 4 \cr \hline \lvert\lbrace f:\deg_{\pm}(f)=d\rbrace\rvert & 2 & 1880 & 55692 & 7960 & 2. \end{array} $$

The certificate directly verifies the cumulative degree-at-most-two count

$$ 2+1880+55692=57574, $$

the $7960$ degree-three functions, and the parity pair at degree $4$. The known count of four-variable linear threshold functions supplies the split between degrees $0$, $1$, and $2$ inside the two-head cover.

The archive has SHA-256 digest

```text
b9f41afb4252a6d7a0326e5b738b1c12f0c47caa740103cdf3161219b84cecb1
```

Running the verifier under Python $3.9.6$ and Python $3.13.9$ produces

```text
Exact integer certificate verified.
Complement-pair representatives with degree <= 2 and H* <= 2: 28,787
Complement-pair representatives with degree >= 3: 3,981
Non-parity representatives among them with degree = H* = 3: 3,980
The final pair is parity and its complement, with degree = H* = 4.
Therefore H*(f) = deg_pm(f) for every Boolean function on at most four bits.
```

## Consequence

Combined with the eight-bit Hamming-threshold separation
[189_eight_bit_hamming_threshold_strict_separation.md](189_eight_bit_hamming_threshold_strict_separation.md),
the smallest possible strict separation lies in the certified range

$$ 5\leq n_{\mathrm{sep}}\leq8. $$
