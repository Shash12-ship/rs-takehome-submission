# Eight-Bit Universal Upper Bound

## Statement

For every Boolean function

$$ f : \lbrace0,1\rbrace^8 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 32. $$

This improves the general positive weighted-sum bound, which gives only $H^{\ast}(f) \leq 255$ at $n=8$.

## Proof

The proof is a determinant-span certificate at the first head count where the full-span method can possibly work.

### Lemma 1. Every eight-bit sign pattern is a thirty-two-head score

Define the thirty-two positive affine denominators by

$$ B_h(x) = b_{h,0} + \sum_{i=1}^{8}b_{h,i}x_i, $$

with coefficient rows

$$ \begin{array}{c|rrrrrrrrr} h & b_{h,0} & b_{h,1} & b_{h,2} & b_{h,3} & b_{h,4} & b_{h,5} & b_{h,6} & b_{h,7} & b_{h,8} \cr \hline 1 & 1 & 50 & 98 & 54 & 6 & 34 & 66 & 63 & 52 \cr 2 & 1 & 39 & 62 & 46 & 75 & 28 & 65 & 18 & 37 \cr 3 & 1 & 18 & 97 & 13 & 80 & 33 & 69 & 91 & 78 \cr 4 & 1 & 19 & 40 & 13 & 94 & 10 & 88 & 43 & 61 \cr 5 & 1 & 72 & 13 & 46 & 56 & 41 & 79 & 82 & 27 \cr 6 & 1 & 71 & 62 & 57 & 67 & 34 & 8 & 71 & 2 \cr 7 & 1 & 12 & 93 & 52 & 91 & 86 & 81 & 1 & 79 \cr 8 & 1 & 64 & 43 & 32 & 94 & 42 & 91 & 9 & 25 \cr 9 & 1 & 73 & 29 & 31 & 19 & 70 & 58 & 12 & 11 \cr 10 & 1 & 41 & 66 & 63 & 14 & 39 & 71 & 38 & 91 \cr 11 & 1 & 16 & 71 & 43 & 70 & 27 & 78 & 71 & 76 \cr 12 & 1 & 37 & 57 & 12 & 77 & 50 & 41 & 74 & 31 \cr 13 & 1 & 38 & 24 & 25 & 24 & 5 & 79 & 85 & 34 \cr 14 & 1 & 61 & 9 & 12 & 87 & 97 & 17 & 20 & 5 \cr 15 & 1 & 11 & 90 & 70 & 88 & 51 & 91 & 68 & 36 \cr 16 & 1 & 67 & 31 & 28 & 87 & 76 & 54 & 75 & 36 \cr 17 & 1 & 58 & 64 & 85 & 83 & 90 & 46 & 11 & 42 \cr 18 & 1 & 79 & 15 & 63 & 76 & 81 & 43 & 25 & 32 \cr 19 & 1 & 3 & 94 & 35 & 15 & 91 & 29 & 48 & 22 \cr 20 & 1 & 43 & 55 & 8 & 13 & 19 & 90 & 29 & 6 \cr 21 & 1 & 74 & 82 & 69 & 78 & 88 & 10 & 4 & 16 \cr 22 & 1 & 82 & 25 & 78 & 74 & 16 & 51 & 12 & 48 \cr 23 & 1 & 15 & 5 & 78 & 3 & 25 & 24 & 92 & 16 \cr 24 & 1 & 62 & 27 & 94 & 8 & 87 & 3 & 70 & 55 \cr 25 & 1 & 80 & 13 & 34 & 9 & 29 & 10 & 83 & 39 \cr 26 & 1 & 45 & 56 & 24 & 8 & 65 & 60 & 6 & 77 \cr 27 & 1 & 13 & 90 & 51 & 26 & 34 & 46 & 94 & 61 \cr 28 & 1 & 73 & 22 & 90 & 87 & 27 & 99 & 8 & 87 \cr 29 & 1 & 21 & 21 & 44 & 68 & 33 & 16 & 77 & 57 \cr 30 & 1 & 86 & 23 & 2 & 61 & 88 & 53 & 73 & 66 \cr 31 & 1 & 40 & 84 & 46 & 50 & 85 & 33 & 20 & 72 \cr 32 & 1 & 89 & 2 & 59 & 95 & 11 & 43 & 95 & 6. \end{array} $$

All coefficients are positive, so every $B_h$ is positive on the cube.

Consider the following $256$ products:

$$ \prod_{j=1}^{32}B_j, $$

for each $h \in \lbrace1,\ldots,31\rbrace$, the eight products

$$ M\prod_{j\neq h}B_j \qquad \text{for } M \in \lbrace1,x_1,x_2,x_3,x_4,x_5,x_6,x_7\rbrace, $$

and the seven products

$$ M\prod_{j\neq 32}B_j \qquad \text{for } M \in \lbrace1,x_1,x_2,x_3,x_4,x_5,x_6\rbrace. $$

Write their value vectors on $\lbrace0,1\rbrace^8$ in lexicographic input order. To keep the certificate small, compute the determinant of this $256\times256$ integer value matrix modulo the prime

$$ p := 1000003. $$

The determinant is congruent to

$$ 539166 \pmod p, $$

which is nonzero. Hence the determinant is nonzero over the integers, and the displayed products form a basis for all real-valued functions on $\lbrace0,1\rbrace^8$.

By the determinant-span schema from [021_determinant_span_schema.md](021_determinant_span_schema.md), every Boolean function $f : \lbrace0,1\rbrace^8 \to \lbrace0,1\rbrace$ has

$$ H^{\ast}(f) \leq 32. $$

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
- $n=8$: $H^{\ast}(f) \leq 32$.
- $n=9$: $H^{\ast}(f) \leq 57$ by [023_nine_bit_universal_upper_bound.md](023_nine_bit_universal_upper_bound.md).
- $n=10$: $H^{\ast}(f) \leq 103$ by [024_ten_bit_universal_upper_bound.md](024_ten_bit_universal_upper_bound.md).
- $n=11$: $H^{\ast}(f) \leq 187$ by [025_compact_threshold_certificates.md](025_compact_threshold_certificates.md).
- $n=12$: $H^{\ast}(f) \leq 342$ by [025_compact_threshold_certificates.md](025_compact_threshold_certificates.md).

This is not an exact classification. It is a universal upper bound.

The denominator-span dimension lower bound from [021_determinant_span_schema.md](021_determinant_span_schema.md) says this method cannot work for every eight-bit function unless

$$ 1 + 8H \geq 256. $$

Equivalently, this full-span route requires $H \geq 32$. Thus the displayed certificate reaches the first possible head count for this method at $n=8$.
