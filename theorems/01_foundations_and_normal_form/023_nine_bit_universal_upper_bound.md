# Nine-Bit Universal Upper Bound

## Statement

For every Boolean function

$$ f : \lbrace0,1\rbrace^9 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 57. $$

This improves the general positive weighted-sum bound, which gives only $H^{\ast}(f) \leq 511$ at $n=9$.

## Proof

The proof is a determinant-span certificate at the first head count where the full-span method can possibly work.

### Lemma 1. Every nine-bit sign pattern is a fifty-seven-head score

Define the fifty-seven positive affine denominators by

$$ B_h(x) = b_{h,0} + \sum_{i=1}^{9}b_{h,i}x_i, $$

with coefficient rows

$$ \begin{array}{c|rrrrrrrrrr} h & b_{h,0} & b_{h,1} & b_{h,2} & b_{h,3} & b_{h,4} & b_{h,5} & b_{h,6} & b_{h,7} & b_{h,8} & b_{h,9} \cr \hline 1 & 1 & 50 & 98 & 54 & 6 & 34 & 66 & 63 & 52 & 39 \cr 2 & 1 & 62 & 46 & 75 & 28 & 65 & 18 & 37 & 18 & 97 \cr 3 & 1 & 13 & 80 & 33 & 69 & 91 & 78 & 19 & 40 & 13 \cr 4 & 1 & 94 & 10 & 88 & 43 & 61 & 72 & 13 & 46 & 56 \cr 5 & 1 & 41 & 79 & 82 & 27 & 71 & 62 & 57 & 67 & 34 \cr 6 & 1 & 8 & 71 & 2 & 12 & 93 & 52 & 91 & 86 & 81 \cr 7 & 1 & 1 & 79 & 64 & 43 & 32 & 94 & 42 & 91 & 9 \cr 8 & 1 & 25 & 73 & 29 & 31 & 19 & 70 & 58 & 12 & 11 \cr 9 & 1 & 41 & 66 & 63 & 14 & 39 & 71 & 38 & 91 & 16 \cr 10 & 1 & 71 & 43 & 70 & 27 & 78 & 71 & 76 & 37 & 57 \cr 11 & 1 & 12 & 77 & 50 & 41 & 74 & 31 & 38 & 24 & 25 \cr 12 & 1 & 24 & 5 & 79 & 85 & 34 & 61 & 9 & 12 & 87 \cr 13 & 1 & 97 & 17 & 20 & 5 & 11 & 90 & 70 & 88 & 51 \cr 14 & 1 & 91 & 68 & 36 & 67 & 31 & 28 & 87 & 76 & 54 \cr 15 & 1 & 75 & 36 & 58 & 64 & 85 & 83 & 90 & 46 & 11 \cr 16 & 1 & 42 & 79 & 15 & 63 & 76 & 81 & 43 & 25 & 32 \cr 17 & 1 & 3 & 94 & 35 & 15 & 91 & 29 & 48 & 22 & 43 \cr 18 & 1 & 55 & 8 & 13 & 19 & 90 & 29 & 6 & 74 & 82 \cr 19 & 1 & 69 & 78 & 88 & 10 & 4 & 16 & 82 & 25 & 78 \cr 20 & 1 & 74 & 16 & 51 & 12 & 48 & 15 & 5 & 78 & 3 \cr 21 & 1 & 25 & 24 & 92 & 16 & 62 & 27 & 94 & 8 & 87 \cr 22 & 1 & 3 & 70 & 55 & 80 & 13 & 34 & 9 & 29 & 10 \cr 23 & 1 & 83 & 39 & 45 & 56 & 24 & 8 & 65 & 60 & 6 \cr 24 & 1 & 77 & 13 & 90 & 51 & 26 & 34 & 46 & 94 & 61 \cr 25 & 1 & 73 & 22 & 90 & 87 & 27 & 99 & 8 & 87 & 21 \cr 26 & 1 & 21 & 44 & 68 & 33 & 16 & 77 & 57 & 86 & 23 \cr 27 & 1 & 2 & 61 & 88 & 53 & 73 & 66 & 40 & 84 & 46 \cr 28 & 1 & 50 & 85 & 33 & 20 & 72 & 89 & 2 & 59 & 95 \cr 29 & 1 & 11 & 43 & 95 & 6 & 70 & 36 & 18 & 31 & 98 \cr 30 & 1 & 62 & 46 & 79 & 37 & 87 & 46 & 76 & 82 & 80 \cr 31 & 1 & 17 & 92 & 40 & 50 & 96 & 54 & 84 & 11 & 1 \cr 32 & 1 & 77 & 25 & 90 & 43 & 21 & 31 & 29 & 82 & 58 \cr 33 & 1 & 49 & 91 & 87 & 73 & 54 & 5 & 52 & 90 & 73 \cr 34 & 1 & 54 & 99 & 85 & 91 & 6 & 22 & 58 & 9 & 34 \cr 35 & 1 & 90 & 21 & 58 & 68 & 63 & 72 & 78 & 97 & 1 \cr 36 & 1 & 5 & 64 & 42 & 40 & 60 & 7 & 54 & 25 & 71 \cr 37 & 1 & 82 & 11 & 93 & 17 & 2 & 52 & 87 & 54 & 41 \cr 38 & 1 & 1 & 28 & 2 & 92 & 97 & 1 & 87 & 68 & 79 \cr 39 & 1 & 13 & 25 & 16 & 78 & 84 & 26 & 39 & 36 & 89 \cr 40 & 1 & 24 & 13 & 61 & 51 & 81 & 11 & 3 & 36 & 58 \cr 41 & 1 & 15 & 33 & 18 & 84 & 67 & 84 & 83 & 45 & 15 \cr 42 & 1 & 20 & 36 & 3 & 6 & 6 & 27 & 88 & 34 & 72 \cr 43 & 1 & 41 & 47 & 73 & 6 & 96 & 90 & 78 & 84 & 64 \cr 44 & 1 & 92 & 83 & 59 & 82 & 56 & 48 & 69 & 23 & 27 \cr 45 & 1 & 49 & 76 & 38 & 2 & 18 & 20 & 35 & 43 & 44 \cr 46 & 1 & 48 & 92 & 12 & 44 & 80 & 5 & 6 & 35 & 21 \cr 47 & 1 & 20 & 75 & 38 & 47 & 51 & 71 & 17 & 38 & 15 \cr 48 & 1 & 62 & 94 & 31 & 7 & 40 & 23 & 67 & 94 & 10 \cr 49 & 1 & 39 & 52 & 43 & 39 & 54 & 14 & 13 & 72 & 62 \cr 50 & 1 & 61 & 44 & 44 & 16 & 62 & 15 & 90 & 64 & 55 \cr 51 & 1 & 5 & 39 & 43 & 95 & 88 & 20 & 22 & 81 & 73 \cr 52 & 1 & 49 & 82 & 12 & 9 & 11 & 26 & 96 & 29 & 8 \cr 53 & 1 & 50 & 2 & 13 & 51 & 72 & 67 & 38 & 58 & 63 \cr 54 & 1 & 75 & 92 & 87 & 28 & 55 & 11 & 48 & 29 & 34 \cr 55 & 1 & 75 & 22 & 56 & 25 & 46 & 15 & 9 & 90 & 4 \cr 56 & 1 & 68 & 58 & 97 & 87 & 26 & 16 & 64 & 51 & 33 \cr 57 & 1 & 27 & 83 & 6 & 28 & 80 & 19 & 14 & 26 & 59. \end{array} $$

All coefficients are positive, so every $B_h$ is positive on the cube.

Consider the following $512$ products:

$$ \prod_{j=1}^{57}B_j, $$

for each $h \in \lbrace1,\ldots,56\rbrace$, the nine products

$$ M\prod_{j\neq h}B_j \qquad \text{for } M \in \lbrace1,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8\rbrace, $$

and the seven products

$$ M\prod_{j\neq 57}B_j \qquad \text{for } M \in \lbrace1,x_1,x_2,x_3,x_4,x_5,x_6\rbrace. $$

Write their value vectors on $\lbrace0,1\rbrace^9$ in lexicographic input order. To keep the certificate small, compute the determinant of this $512\times512$ integer value matrix modulo the prime

$$ p := 1000003. $$

The determinant is congruent to

$$ 24497 \pmod p, $$

which is nonzero. Hence the determinant is nonzero over the integers, and the displayed products form a basis for all real-valued functions on $\lbrace0,1\rbrace^9$.

By the determinant-span schema from [021_determinant_span_schema.md](021_determinant_span_schema.md), every Boolean function $f : \lbrace0,1\rbrace^9 \to \lbrace0,1\rbrace$ has

$$ H^{\ast}(f) \leq 57. $$

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
- $n=9$: $H^{\ast}(f) \leq 57$.
- $n=10$: $H^{\ast}(f) \leq 103$ by [024_ten_bit_universal_upper_bound.md](024_ten_bit_universal_upper_bound.md).
- $n=11$: $H^{\ast}(f) \leq 187$ by [025_compact_threshold_certificates.md](025_compact_threshold_certificates.md).
- $n=12$: $H^{\ast}(f) \leq 342$ by [025_compact_threshold_certificates.md](025_compact_threshold_certificates.md).

This is not an exact classification. It is a universal upper bound.

The denominator-span dimension lower bound from [021_determinant_span_schema.md](021_determinant_span_schema.md) says this method cannot work for every nine-bit function unless

$$ 1 + 9H \geq 512. $$

Equivalently, this full-span route requires $H \geq 57$. Thus the displayed certificate reaches the first possible head count for this method at $n=9$.
