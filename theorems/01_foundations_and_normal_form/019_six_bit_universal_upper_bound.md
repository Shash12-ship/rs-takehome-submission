# Six-Bit Universal Upper Bound

## Statement

For every Boolean function

$$ f : \lbrace0,1\rbrace^6 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 11. $$

This improves the general positive weighted-sum bound, which gives only $H^{\ast}(f) \leq 63$ at $n=6$.

## Proof

The proof is another determinant-span certificate for affine-over-positive-affine atoms.

### Lemma 1. Every six-bit sign polynomial is an eleven-head score

Let $P$ be any multilinear polynomial in six Boolean variables. Then there are positive affine functions

$$ B_1,\ldots,B_{11}, $$

affine functions

$$ A_1,\ldots,A_{11}, $$

and a constant $c$ such that

$$ P(x) = c\prod_{j=1}^{11}B_j(x) + \sum_{h=1}^{11} A_h(x)\prod_{j\neq h}B_j(x) $$

on $\lbrace0,1\rbrace^6$.

**Proof.** Work in the multilinear basis indexed by all subsets of $\lbrace1,2,3,4,5,6\rbrace$:

$$ \prod_{i\in S}x_i, \qquad S\subseteq\lbrace1,2,3,4,5,6\rbrace. $$

Define the eleven positive affine denominators by

$$ B_h(x)=b_{h,0}+\sum_{i=1}^{6}b_{h,i}x_i, $$

with coefficient rows

$$ \begin{array}{c|rrrrrrr} h & b_{h,0} & b_{h,1} & b_{h,2} & b_{h,3} & b_{h,4} & b_{h,5} & b_{h,6} \cr \hline 1 & 1 & 85 & 64 & 51 & 27 & 31 & 5 \cr 2 & 1 & 8 & 2 & 18 & 81 & 65 & 91 \cr 3 & 1 & 50 & 61 & 97 & 73 & 63 & 54 \cr 4 & 1 & 56 & 93 & 28 & 81 & 67 & 1 \cr 5 & 1 & 40 & 85 & 55 & 4 & 76 & 73 \cr 6 & 1 & 84 & 18 & 9 & 86 & 3 & 54 \cr 7 & 1 & 8 & 30 & 48 & 42 & 40 & 3 \cr 8 & 1 & 1 & 13 & 1 & 67 & 53 & 65 \cr 9 & 1 & 26 & 61 & 76 & 38 & 46 & 99 \cr 10 & 1 & 80 & 98 & 38 & 68 & 95 & 65 \cr 11 & 1 & 84 & 69 & 70 & 39 & 87 & 14. \end{array} $$

All coefficients are positive, so every $B_h$ is positive on the cube.

Consider the following $64$ products:

$$ \prod_{j=1}^{11}B_j, $$

for each $h\in\lbrace1,\ldots,10\rbrace$, the six products

$$ M\prod_{j\neq h}B_j \qquad \text{for } M\in\lbrace1,x_1,x_2,x_3,x_4,x_5\rbrace, $$

and the three products

$$ M\prod_{j\neq 11}B_j \qquad \text{for } M\in\lbrace1,x_1,x_2\rbrace. $$

Reduce these products using $x_i^2=x_i$ on the Boolean cube, and write their coefficient vectors in the $64$-element multilinear basis.

The determinant of this $64\times64$ integer matrix is nonzero. To keep the certificate small, compute it modulo the prime

$$ p := 1000003. $$

The determinant is congruent to

$$ 632336 \pmod p, $$

which is nonzero. Hence the determinant is nonzero over the integers, and the displayed products form a basis for all multilinear polynomials on $\lbrace0,1\rbrace^6$.

Therefore every multilinear $P$ has the displayed form. $\blacksquare$

### Lemma 2. Eleven heads suffice for every six-bit function

Let $f : \lbrace0,1\rbrace^6 \to \lbrace0,1\rbrace$. Interpolate the sign labels

$$ Q_f(x) = \begin{cases} +1 & \text{if } f(x)=1, \cr -1 & \text{if } f(x)=0 \end{cases} $$

by a multilinear polynomial $P$ on $\lbrace0,1\rbrace^6$.

Apply Lemma 1 to this $P$. Since each $B_h$ is positive on the cube, the score

$$ S(x) := c+\sum_{h=1}^{11}\frac{A_h(x)}{B_h(x)} $$

has the same sign as $P(x)$, because

$$ S(x) = \frac{P(x)}{\prod_{j=1}^{11}B_j(x)}. $$

Each ratio $A_h(x)/B_h(x)$ is a one-head atom by Lemma 1 of [015_three_bit_quadratic_upper_bound.md](015_three_bit_quadratic_upper_bound.md). Therefore thresholding a constant plus eleven one-head atoms computes $f$, and the exact normal form from [010_linear_fractional_normal_form.md](010_linear_fractional_normal_form.md) gives

$$ H^{\ast}(f) \leq 11. $$

$\blacksquare$

## Consequence

The current universal upper bounds for small $n$ are:

- $n=1$: $H^{\ast}(f) \leq 1$.
- $n=2$: $H^{\ast}(f) \leq 2$.
- $n=3$: $H^{\ast}(f) \leq 3$, and in fact $H^{\ast}(f) = \deg_{\pm}(f)$.
- $n=4$: $H^{\ast}(f) \leq 4$.
- $n=5$: $H^{\ast}(f) \leq 7$.
- $n=6$: $H^{\ast}(f) \leq 11$.
- $n=7$: $H^{\ast}(f) \leq 19$ by [020_seven_bit_universal_upper_bound.md](020_seven_bit_universal_upper_bound.md).
- $n=8$: $H^{\ast}(f) \leq 32$ by [022_eight_bit_universal_upper_bound.md](022_eight_bit_universal_upper_bound.md).
- $n=9$: $H^{\ast}(f) \leq 57$ by [023_nine_bit_universal_upper_bound.md](023_nine_bit_universal_upper_bound.md).
- $n=10$: $H^{\ast}(f) \leq 103$ by [024_ten_bit_universal_upper_bound.md](024_ten_bit_universal_upper_bound.md).
- $n=11$: $H^{\ast}(f) \leq 187$ by [025_compact_threshold_certificates.md](025_compact_threshold_certificates.md).
- $n=12$: $H^{\ast}(f) \leq 342$ by [025_compact_threshold_certificates.md](025_compact_threshold_certificates.md).

The determinant-span method remains far sharper than the injective positive-projection bound through $n=12$.
