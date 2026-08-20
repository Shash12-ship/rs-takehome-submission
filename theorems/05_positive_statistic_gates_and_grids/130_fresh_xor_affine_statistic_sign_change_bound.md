# Fresh-XOR Affine-Statistic Sign-Change Bound

## Statement

Let

$$ L(y)=a+\sum_{i=1}^{m}\alpha_i y_i $$

be an affine statistic on $\lbrace0,1\rbrace^{m}$, and let

$$ k:=\lvert\lbrace i:\alpha_i\neq0\rbrace\rvert. $$

Let $G:\mathrm{Im}(L)\to\lbrace0,1\rbrace$, and define

$$ T(y):=G(L(y)). $$

Write the distinct image values as

$$ \lambda_1\lt\lambda_2\lt\cdots\lt\lambda_M, $$

and let $C$ be the number of sign changes in the sequence

$$ G(\lambda_1),G(\lambda_2),\ldots,G(\lambda_M). $$

Define

$$ D_{\oplus}(C):= \begin{cases} 2C+1 & \text{if } C \text{ is even},\cr 2C & \text{if } C \text{ is odd}. \end{cases} $$

Then:

1. If $C=0$, then

$$ H^{\ast}(z\oplus T(y))=H^{\ast}(1-(z\oplus T(y)))=1. $$

2. If $C=1$, then

$$ H^{\ast}(z\oplus T(y))=H^{\ast}(1-(z\oplus T(y)))=2. $$

3. If $C\geq2$, then

$$ H^{\ast}(z\oplus T(y)) \leq 1+\sum_{r=2}^{\min\lbrace D_{\oplus}(C),k+1\rbrace}\binom{k+1}{r}, $$

and the same upper bound holds for XNOR.

> **Interpretation.** Fresh XOR over one affine statistic doubles the sign-change pattern and adds one boundary change exactly when the original pattern starts and ends with the same label.

## Proof

Choose $B\gt0$ so large that

$$ B\gt\lambda_M-\lambda_1, $$

and define the affine statistic on $(z,y)$

$$ M_B(z,y):=L(y)+Bz. $$

The image values of $M_B$ are ordered as

$$ \lambda_1\lt\cdots\lt\lambda_M\lt B+\lambda_1\lt\cdots\lt B+\lambda_M. $$

Define $H:\mathrm{Im}(M_B)\to\lbrace0,1\rbrace$ by

$$ H(\lambda_i):=G(\lambda_i), \qquad H(B+\lambda_i):=1-G(\lambda_i). $$

Then

$$ z\oplus T(y)=H(M_B(z,y)). $$

The first block

$$ H(\lambda_1),\ldots,H(\lambda_M) $$

has $C$ sign changes. The second block

$$ H(B+\lambda_1),\ldots,H(B+\lambda_M) $$

is the complement of the same sequence, so it also has $C$ sign changes.

There is one additional boundary change between the two blocks exactly when

$$ G(\lambda_M)\neq1-G(\lambda_1), $$

or equivalently when

$$ G(\lambda_M)=G(\lambda_1). $$

Since each sign change flips the current label, this last equality holds exactly when $C$ is even. Hence the sign-change count of $H$ along $\mathrm{Im}(M_B)$ is $D_{\oplus}(C)$.

The statistic $M_B$ uses at most $k+1$ variables. Applying the affine-statistic sign-change theorem [063_affine_statistic_sign_changes.md](../03_function_families_and_affine_geometry/063_affine_statistic_sign_changes.md) gives the following.

If $C=0$, then $D_{\oplus}(C)=1$, so $z\oplus T$ is a nonconstant LTF and

$$ H^{\ast}(z\oplus T)=1. $$

If $C=1$, then $D_{\oplus}(C)=2$, so the same theorem gives

$$ H^{\ast}(z\oplus T)\leq2. $$

In this case $T$ is a nonconstant LTF, so the LTF one-bit gate classification [129_ltf_one_bit_gate_classification.md](129_ltf_one_bit_gate_classification.md) gives the matching lower bound and exact value

$$ H^{\ast}(z\oplus T)=2. $$

If $C\geq2$, then $D_{\oplus}(C)\geq3$, and the same affine-statistic theorem gives

$$ H^{\ast}(z\oplus T) \leq 1+\sum_{r=2}^{\min\lbrace D_{\oplus}(C),k+1\rbrace}\binom{k+1}{r}. $$

Finally, XNOR is the output complement of fresh XOR, and output complement preserves head complexity by [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md). This proves all claims. $\blacksquare$

## Consequences

If $T$ is a non-LTF affine slab, then $C=2$, so

$$ D_{\oplus}(C)=5 $$

and therefore

$$ H^{\ast}(z\oplus T) \leq 1+\sum_{r=2}^{\min\lbrace5,k+1\rbrace}\binom{k+1}{r}. $$

This is the current orientation-free fallback for fresh XOR over affine slabs beyond the LTF case. The endpoint and one-threshold cases are sharper: they are exactly two-head by Lemmas 127 and 129.
