# Seven-Bit Universal Upper Bound

## Statement

For every Boolean function

$$ f : \lbrace0,1\rbrace^7 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 19. $$

This improves the general positive weighted-sum bound, which gives only $H^{\ast}(f) \leq 127$ at $n=7$.

## Proof

The proof is another determinant-span certificate for affine-over-positive-affine atoms.

### Lemma 1. Every seven-bit sign polynomial is a nineteen-head score

Let $P$ be any multilinear polynomial in seven Boolean variables. Then there are positive affine functions

$$ B_1,\ldots,B_{19}, $$

affine functions

$$ A_1,\ldots,A_{19}, $$

and a constant $c$ such that

$$ P(x) = c\prod_{j=1}^{19}B_j(x) + \sum_{h=1}^{19} A_h(x)\prod_{j\neq h}B_j(x) $$

on $\lbrace0,1\rbrace^7$.

**Proof.** Work in the vector space of real-valued functions on $\lbrace0,1\rbrace^7$. We write value vectors in lexicographic input order. This is equivalent to working with multilinear polynomials on the Boolean cube.

Define the nineteen positive affine denominators by

$$ B_h(x) = b_{h,0} + \sum_{i=1}^{7}b_{h,i}x_i, $$

with coefficient rows

$$ \begin{array}{c|rrrrrrrr} h & b_{h,0} & b_{h,1} & b_{h,2} & b_{h,3} & b_{h,4} & b_{h,5} & b_{h,6} & b_{h,7} \cr \hline 1 & 1 & 50 & 98 & 54 & 6 & 34 & 66 & 63 \cr 2 & 1 & 52 & 39 & 62 & 46 & 75 & 28 & 65 \cr 3 & 1 & 18 & 37 & 18 & 97 & 13 & 80 & 33 \cr 4 & 1 & 69 & 91 & 78 & 19 & 40 & 13 & 94 \cr 5 & 1 & 10 & 88 & 43 & 61 & 72 & 13 & 46 \cr 6 & 1 & 56 & 41 & 79 & 82 & 27 & 71 & 62 \cr 7 & 1 & 57 & 67 & 34 & 8 & 71 & 2 & 12 \cr 8 & 1 & 93 & 52 & 91 & 86 & 81 & 1 & 79 \cr 9 & 1 & 64 & 43 & 32 & 94 & 42 & 91 & 9 \cr 10 & 1 & 25 & 73 & 29 & 31 & 19 & 70 & 58 \cr 11 & 1 & 12 & 11 & 41 & 66 & 63 & 14 & 39 \cr 12 & 1 & 71 & 38 & 91 & 16 & 71 & 43 & 70 \cr 13 & 1 & 27 & 78 & 71 & 76 & 37 & 57 & 12 \cr 14 & 1 & 77 & 50 & 41 & 74 & 31 & 38 & 24 \cr 15 & 1 & 25 & 24 & 5 & 79 & 85 & 34 & 61 \cr 16 & 1 & 9 & 12 & 87 & 97 & 17 & 20 & 5 \cr 17 & 1 & 11 & 90 & 70 & 88 & 51 & 91 & 68 \cr 18 & 1 & 36 & 67 & 31 & 28 & 87 & 76 & 54 \cr 19 & 1 & 75 & 36 & 58 & 64 & 85 & 83 & 90. \end{array} $$

All coefficients are positive, so every $B_h$ is positive on the cube.

Consider the following $128$ products:

$$ \prod_{j=1}^{19}B_j, $$

for each $h \in \lbrace1,\ldots,18\rbrace$, the seven products

$$ M\prod_{j\neq h}B_j \qquad \text{for } M \in \lbrace1,x_1,x_2,x_3,x_4,x_5,x_6\rbrace, $$

and the single product

$$ \prod_{j\neq 19}B_j. $$

Write their value vectors on $\lbrace0,1\rbrace^7$ in lexicographic input order. The determinant of this $128\times128$ integer value matrix is nonzero. To keep the certificate small, compute it modulo the prime

$$ p := 1000003. $$

The determinant is congruent to

$$ 471767 \pmod p, $$

which is nonzero. Hence the determinant is nonzero over the integers, and the displayed products form a basis for all real-valued functions on $\lbrace0,1\rbrace^7$.

Therefore every multilinear $P$ has the displayed form. $\blacksquare$

### Lemma 2. Nineteen heads suffice for every seven-bit function

Let $f : \lbrace0,1\rbrace^7 \to \lbrace0,1\rbrace$. Interpolate the sign labels

$$ Q_f(x) = \begin{cases} +1 & \text{if } f(x) = 1, \cr -1 & \text{if } f(x) = 0 \end{cases} $$

by a multilinear polynomial $P$ on $\lbrace0,1\rbrace^7$.

Apply Lemma 1 to this $P$. Since each $B_h$ is positive on the cube, the score

$$ S(x) := c + \sum_{h=1}^{19}\frac{A_h(x)}{B_h(x)} $$

has the same sign as $P(x)$, because

$$ S(x) = \frac{P(x)}{\prod_{j=1}^{19}B_j(x)}. $$

Each ratio $A_h(x)/B_h(x)$ is a one-head atom by Lemma 1 of [015_three_bit_quadratic_upper_bound.md](015_three_bit_quadratic_upper_bound.md). Therefore thresholding a constant plus nineteen one-head atoms computes $f$, and the exact normal form from [010_linear_fractional_normal_form.md](010_linear_fractional_normal_form.md) gives

$$ H^{\ast}(f) \leq 19. $$

$\blacksquare$

## Consequence

The current universal upper bounds for small $n$ are:

- $n=1$: $H^{\ast}(f) \leq 1$.
- $n=2$: $H^{\ast}(f) \leq 2$.
- $n=3$: $H^{\ast}(f) \leq 3$, and in fact $H^{\ast}(f) = \deg_{\pm}(f)$.
- $n=4$: $H^{\ast}(f) \leq 4$.
- $n=5$: $H^{\ast}(f) \leq 7$.
- $n=6$: $H^{\ast}(f) \leq 11$.
- $n=7$: $H^{\ast}(f) \leq 19$.
- $n=8$: $H^{\ast}(f) \leq 32$ by [022_eight_bit_universal_upper_bound.md](022_eight_bit_universal_upper_bound.md).
- $n=9$: $H^{\ast}(f) \leq 57$ by [023_nine_bit_universal_upper_bound.md](023_nine_bit_universal_upper_bound.md).
- $n=10$: $H^{\ast}(f) \leq 103$ by [024_ten_bit_universal_upper_bound.md](024_ten_bit_universal_upper_bound.md).
- $n=11$: $H^{\ast}(f) \leq 187$ by [025_compact_threshold_certificates.md](025_compact_threshold_certificates.md).
- $n=12$: $H^{\ast}(f) \leq 342$ by [025_compact_threshold_certificates.md](025_compact_threshold_certificates.md).

This is not an exact classification. It is a universal upper bound.

The same determinant-span route cannot prove a seven-bit universal bound with fewer than $19$ fixed denominators. For fixed denominators $B_1,\ldots,B_H$, the functions

$$ 1,\qquad \frac{1}{B_h},\frac{x_1}{B_h},\ldots,\frac{x_7}{B_h} $$

have one linear relation for each $h$, namely

$$ \frac{B_h(x)}{B_h(x)} = 1. $$

Thus their span has dimension at most $1 + 7H$. Since all real-valued functions on $\lbrace0,1\rbrace^7$ form a $128$-dimensional space, this full-span method requires $1 + 7H \geq 128$, hence $H \geq 19$.
