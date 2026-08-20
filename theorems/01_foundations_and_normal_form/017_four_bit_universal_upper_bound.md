# Four-Bit Universal Upper Bound

## Statement

For every Boolean function

$$ f : \lbrace0,1\rbrace^4 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 4. $$

This improves the general positive weighted-sum bound, which gives only $H^{\ast}(f) \leq 15$ at $n=4$.

## Proof

The proof is the four-bit analogue of [016_three_bit_exact_classification.md](016_three_bit_exact_classification.md), but here we only claim an upper bound.

### Lemma 1. Every four-bit sign polynomial is a four-head score

Let $P$ be any multilinear polynomial in four Boolean variables. Then there are positive affine functions $B_1,B_2,B_3,B_4$, affine functions $A_1,A_2,A_3,A_4$, and a constant $c$ such that

$$ P(x) = c\prod_{j=1}^{4}B_j(x) + \sum_{h=1}^{4} A_h(x)\prod_{j\neq h}B_j(x) $$

on $\lbrace0,1\rbrace^4$.

**Proof.** Work in the multilinear basis indexed by all subsets of $\lbrace1,2,3,4\rbrace$:

$$ \prod_{i\in S}x_i, \qquad S\subseteq\lbrace1,2,3,4\rbrace. $$

Define

$$ \begin{aligned} B_1(x) &:= 1+x_1+x_2+x_3+x_4, \cr B_2(x) &:= 1+x_1+2x_2+4x_3+8x_4, \cr B_3(x) &:= 1+x_1+3x_2+9x_3+27x_4, \cr B_4(x) &:= 1+x_1+4x_2+16x_3+64x_4. \end{aligned} $$

Consider the following $16$ products:

$$ \prod_{j=1}^{4}B_j, $$

the four products

$$ M\prod_{j\neq 1}B_j \qquad \text{for } M\in\lbrace1,x_1,x_2,x_3\rbrace, $$

the four products

$$ M\prod_{j\neq 2}B_j \qquad \text{for } M\in\lbrace1,x_1,x_2,x_3\rbrace, $$

the four products

$$ M\prod_{j\neq 3}B_j \qquad \text{for } M\in\lbrace1,x_1,x_2,x_3\rbrace, $$

and the three products

$$ M\prod_{j\neq 4}B_j \qquad \text{for } M\in\lbrace1,x_1,x_2\rbrace. $$

Reduce all products using $x_i^2=x_i$ on the Boolean cube and write their coefficient vectors in the multilinear basis. The determinant of the resulting $16\times16$ coefficient matrix is

$$ -191377524548329363449095194819952640000. $$

Since this determinant is nonzero, these products form a basis for all real-valued functions on $\lbrace0,1\rbrace^4$, equivalently for all multilinear polynomials in four Boolean variables. Hence every multilinear $P$ has the displayed form. $\blacksquare$

### Lemma 2. Four heads suffice for every four-bit function

Let $f : \lbrace0,1\rbrace^4 \to \lbrace0,1\rbrace$. Interpolate the sign labels

$$ Q_f(x) = \begin{cases} +1 & \text{if } f(x)=1, \cr -1 & \text{if } f(x)=0. \end{cases} $$

by a multilinear polynomial $P$ on $\lbrace0,1\rbrace^4$.

Apply Lemma 1 to this $P$. Since each $B_h$ is positive on the cube, the score

$$ S(x) := c+\sum_{h=1}^{4}\frac{A_h(x)}{B_h(x)} $$

has the same sign as $P(x)$, because

$$ S(x) = \frac{P(x)}{\prod_{j=1}^{4}B_j(x)}. $$

Each ratio $A_h(x)/B_h(x)$ is a one-head atom by Lemma 1 of [015_three_bit_quadratic_upper_bound.md](015_three_bit_quadratic_upper_bound.md). Therefore thresholding a constant plus four one-head atoms computes $f$, and the exact normal form from [010_linear_fractional_normal_form.md](010_linear_fractional_normal_form.md) gives

$$ H^{\ast}(f) \leq 4. $$

$\blacksquare$

## Consequence

The current small $n$ upper bounds are now:

- $n=1$: $H^{\ast}(f) \leq 1$.
- $n=2$: $H^{\ast}(f) \leq 2$.
- $n=3$: $H^{\ast}(f) \leq 3$, and in fact $H^{\ast}(f) = \deg_{\pm}(f)$.
- $n=4$: $H^{\ast}(f) \leq 4$.

The first dimension where the universal upper bound from these determinant decompositions does not yet match $n$ is $n=5$.
