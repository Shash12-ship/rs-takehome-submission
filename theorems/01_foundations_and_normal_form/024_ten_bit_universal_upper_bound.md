# Ten-Bit Universal Upper Bound

## Statement

For every Boolean function

$$ f : \lbrace0,1\rbrace^{10} \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 103. $$

This improves the general positive weighted-sum bound, which gives only $H^{\ast}(f) \leq 1023$ at $n=10$.

## Proof

The proof is a determinant-span certificate at the first head count where the full-span method can possibly work.

### Lemma 1. Every ten-bit sign pattern is a 103-head score

Define the $103$ positive affine denominators by

$$ B_h(x) = b_{h,0} + \sum_{i=1}^{10}b_{h,i}x_i, $$

with coefficient rows

$$ \begin{array}{c|rrrrrrrrrrr} h & b_{h,0} & b_{h,1} & b_{h,2} & b_{h,3} & b_{h,4} & b_{h,5} & b_{h,6} & b_{h,7} & b_{h,8} & b_{h,9} & b_{h,10} \cr \hline 1 & 1 & 50 & 98 & 54 & 6 & 34 & 66 & 63 & 52 & 39 & 62 \cr 2 & 1 & 46 & 75 & 28 & 65 & 18 & 37 & 18 & 97 & 13 & 80 \cr 3 & 1 & 33 & 69 & 91 & 78 & 19 & 40 & 13 & 94 & 10 & 88 \cr 4 & 1 & 43 & 61 & 72 & 13 & 46 & 56 & 41 & 79 & 82 & 27 \cr 5 & 1 & 71 & 62 & 57 & 67 & 34 & 8 & 71 & 2 & 12 & 93 \cr 6 & 1 & 52 & 91 & 86 & 81 & 1 & 79 & 64 & 43 & 32 & 94 \cr 7 & 1 & 42 & 91 & 9 & 25 & 73 & 29 & 31 & 19 & 70 & 58 \cr 8 & 1 & 12 & 11 & 41 & 66 & 63 & 14 & 39 & 71 & 38 & 91 \cr 9 & 1 & 16 & 71 & 43 & 70 & 27 & 78 & 71 & 76 & 37 & 57 \cr 10 & 1 & 12 & 77 & 50 & 41 & 74 & 31 & 38 & 24 & 25 & 24 \cr 11 & 1 & 5 & 79 & 85 & 34 & 61 & 9 & 12 & 87 & 97 & 17 \cr 12 & 1 & 20 & 5 & 11 & 90 & 70 & 88 & 51 & 91 & 68 & 36 \cr 13 & 1 & 67 & 31 & 28 & 87 & 76 & 54 & 75 & 36 & 58 & 64 \cr 14 & 1 & 85 & 83 & 90 & 46 & 11 & 42 & 79 & 15 & 63 & 76 \cr 15 & 1 & 81 & 43 & 25 & 32 & 3 & 94 & 35 & 15 & 91 & 29 \cr 16 & 1 & 48 & 22 & 43 & 55 & 8 & 13 & 19 & 90 & 29 & 6 \cr 17 & 1 & 74 & 82 & 69 & 78 & 88 & 10 & 4 & 16 & 82 & 25 \cr 18 & 1 & 78 & 74 & 16 & 51 & 12 & 48 & 15 & 5 & 78 & 3 \cr 19 & 1 & 25 & 24 & 92 & 16 & 62 & 27 & 94 & 8 & 87 & 3 \cr 20 & 1 & 70 & 55 & 80 & 13 & 34 & 9 & 29 & 10 & 83 & 39 \cr 21 & 1 & 45 & 56 & 24 & 8 & 65 & 60 & 6 & 77 & 13 & 90 \cr 22 & 1 & 51 & 26 & 34 & 46 & 94 & 61 & 73 & 22 & 90 & 87 \cr 23 & 1 & 27 & 99 & 8 & 87 & 21 & 21 & 44 & 68 & 33 & 16 \cr 24 & 1 & 77 & 57 & 86 & 23 & 2 & 61 & 88 & 53 & 73 & 66 \cr 25 & 1 & 40 & 84 & 46 & 50 & 85 & 33 & 20 & 72 & 89 & 2 \cr 26 & 1 & 59 & 95 & 11 & 43 & 95 & 6 & 70 & 36 & 18 & 31 \cr 27 & 1 & 98 & 62 & 46 & 79 & 37 & 87 & 46 & 76 & 82 & 80 \cr 28 & 1 & 17 & 92 & 40 & 50 & 96 & 54 & 84 & 11 & 1 & 77 \cr 29 & 1 & 25 & 90 & 43 & 21 & 31 & 29 & 82 & 58 & 49 & 91 \cr 30 & 1 & 87 & 73 & 54 & 5 & 52 & 90 & 73 & 54 & 99 & 85 \cr 31 & 1 & 91 & 6 & 22 & 58 & 9 & 34 & 90 & 21 & 58 & 68 \cr 32 & 1 & 63 & 72 & 78 & 97 & 1 & 5 & 64 & 42 & 40 & 60 \cr 33 & 1 & 7 & 54 & 25 & 71 & 82 & 11 & 93 & 17 & 2 & 52 \cr 34 & 1 & 87 & 54 & 41 & 1 & 28 & 2 & 92 & 97 & 1 & 87 \cr 35 & 1 & 68 & 79 & 13 & 25 & 16 & 78 & 84 & 26 & 39 & 36 \cr 36 & 1 & 89 & 24 & 13 & 61 & 51 & 81 & 11 & 3 & 36 & 58 \cr 37 & 1 & 15 & 33 & 18 & 84 & 67 & 84 & 83 & 45 & 15 & 20 \cr 38 & 1 & 36 & 3 & 6 & 6 & 27 & 88 & 34 & 72 & 41 & 47 \cr 39 & 1 & 73 & 6 & 96 & 90 & 78 & 84 & 64 & 92 & 83 & 59 \cr 40 & 1 & 82 & 56 & 48 & 69 & 23 & 27 & 49 & 76 & 38 & 2 \cr 41 & 1 & 18 & 20 & 35 & 43 & 44 & 48 & 92 & 12 & 44 & 80 \cr 42 & 1 & 5 & 6 & 35 & 21 & 20 & 75 & 38 & 47 & 51 & 71 \cr 43 & 1 & 17 & 38 & 15 & 62 & 94 & 31 & 7 & 40 & 23 & 67 \cr 44 & 1 & 94 & 10 & 39 & 52 & 43 & 39 & 54 & 14 & 13 & 72 \cr 45 & 1 & 62 & 61 & 44 & 44 & 16 & 62 & 15 & 90 & 64 & 55 \cr 46 & 1 & 5 & 39 & 43 & 95 & 88 & 20 & 22 & 81 & 73 & 49 \cr 47 & 1 & 82 & 12 & 9 & 11 & 26 & 96 & 29 & 8 & 50 & 2 \cr 48 & 1 & 13 & 51 & 72 & 67 & 38 & 58 & 63 & 75 & 92 & 87 \cr 49 & 1 & 28 & 55 & 11 & 48 & 29 & 34 & 75 & 22 & 56 & 25 \cr 50 & 1 & 46 & 15 & 9 & 90 & 4 & 68 & 58 & 97 & 87 & 26 \cr 51 & 1 & 16 & 64 & 51 & 33 & 27 & 83 & 6 & 28 & 80 & 19 \cr 52 & 1 & 14 & 26 & 59 & 49 & 47 & 70 & 20 & 14 & 77 & 63 \cr 53 & 1 & 19 & 73 & 52 & 82 & 88 & 55 & 67 & 64 & 87 & 42 \cr 54 & 1 & 64 & 64 & 82 & 86 & 26 & 70 & 79 & 29 & 2 & 44 \cr 55 & 1 & 91 & 96 & 41 & 42 & 5 & 68 & 19 & 33 & 78 & 20 \cr 56 & 1 & 49 & 75 & 38 & 92 & 91 & 61 & 9 & 11 & 67 & 6 \cr 57 & 1 & 9 & 29 & 17 & 6 & 39 & 2 & 98 & 58 & 43 & 21 \cr 58 & 1 & 20 & 84 & 59 & 48 & 65 & 49 & 68 & 65 & 5 & 74 \cr 59 & 1 & 12 & 87 & 67 & 98 & 77 & 10 & 96 & 55 & 97 & 27 \cr 60 & 1 & 38 & 69 & 77 & 54 & 62 & 50 & 78 & 76 & 30 & 3 \cr 61 & 1 & 85 & 1 & 95 & 24 & 39 & 65 & 73 & 33 & 43 & 9 \cr 62 & 1 & 64 & 34 & 39 & 99 & 53 & 50 & 50 & 8 & 21 & 83 \cr 63 & 1 & 17 & 31 & 37 & 94 & 43 & 8 & 5 & 62 & 54 & 19 \cr 64 & 1 & 63 & 78 & 92 & 11 & 87 & 90 & 20 & 46 & 53 & 5 \cr 65 & 1 & 79 & 60 & 50 & 59 & 7 & 13 & 61 & 20 & 3 & 5 \cr 66 & 1 & 77 & 80 & 17 & 81 & 42 & 14 & 90 & 71 & 84 & 45 \cr 67 & 1 & 25 & 50 & 63 & 15 & 8 & 79 & 90 & 60 & 79 & 81 \cr 68 & 1 & 44 & 84 & 16 & 88 & 92 & 80 & 38 & 17 & 50 & 38 \cr 69 & 1 & 96 & 88 & 16 & 67 & 25 & 5 & 51 & 57 & 48 & 97 \cr 70 & 1 & 25 & 59 & 46 & 81 & 10 & 6 & 6 & 63 & 33 & 4 \cr 71 & 1 & 67 & 86 & 73 & 74 & 28 & 30 & 12 & 81 & 65 & 90 \cr 72 & 1 & 68 & 54 & 65 & 40 & 15 & 19 & 55 & 73 & 55 & 11 \cr 73 & 1 & 14 & 54 & 9 & 13 & 54 & 20 & 94 & 4 & 58 & 56 \cr 74 & 1 & 88 & 54 & 4 & 64 & 42 & 93 & 33 & 11 & 46 & 10 \cr 75 & 1 & 16 & 46 & 89 & 4 & 45 & 45 & 23 & 2 & 30 & 47 \cr 76 & 1 & 10 & 77 & 19 & 27 & 1 & 27 & 85 & 87 & 94 & 16 \cr 77 & 1 & 96 & 1 & 38 & 48 & 89 & 4 & 78 & 30 & 19 & 24 \cr 78 & 1 & 59 & 15 & 62 & 45 & 91 & 34 & 17 & 4 & 27 & 47 \cr 79 & 1 & 43 & 61 & 38 & 38 & 71 & 82 & 42 & 24 & 76 & 11 \cr 80 & 1 & 14 & 69 & 75 & 40 & 21 & 49 & 19 & 17 & 29 & 41 \cr 81 & 1 & 66 & 32 & 31 & 97 & 24 & 38 & 48 & 54 & 85 & 6 \cr 82 & 1 & 17 & 77 & 3 & 51 & 10 & 90 & 10 & 17 & 54 & 39 \cr 83 & 1 & 71 & 54 & 95 & 19 & 76 & 55 & 39 & 82 & 46 & 11 \cr 84 & 1 & 32 & 57 & 81 & 48 & 82 & 68 & 8 & 49 & 53 & 2 \cr 85 & 1 & 54 & 94 & 42 & 57 & 27 & 48 & 38 & 61 & 12 & 24 \cr 86 & 1 & 14 & 36 & 15 & 72 & 78 & 89 & 20 & 90 & 58 & 52 \cr 87 & 1 & 24 & 99 & 54 & 56 & 23 & 32 & 59 & 44 & 67 & 19 \cr 88 & 1 & 46 & 60 & 81 & 82 & 12 & 62 & 97 & 27 & 38 & 1 \cr 89 & 1 & 90 & 58 & 80 & 60 & 1 & 28 & 39 & 15 & 99 & 81 \cr 90 & 1 & 39 & 70 & 78 & 20 & 55 & 91 & 97 & 61 & 12 & 87 \cr 91 & 1 & 64 & 98 & 30 & 70 & 98 & 52 & 36 & 81 & 3 & 16 \cr 92 & 1 & 35 & 86 & 6 & 1 & 33 & 51 & 68 & 75 & 91 & 51 \cr 93 & 1 & 57 & 14 & 96 & 33 & 46 & 37 & 97 & 87 & 26 & 77 \cr 94 & 1 & 11 & 5 & 10 & 34 & 40 & 69 & 44 & 16 & 68 & 32 \cr 95 & 1 & 98 & 21 & 9 & 54 & 38 & 37 & 67 & 18 & 74 & 67 \cr 96 & 1 & 81 & 27 & 69 & 14 & 53 & 82 & 70 & 52 & 95 & 36 \cr 97 & 1 & 38 & 57 & 48 & 73 & 81 & 18 & 21 & 16 & 90 & 16 \cr 98 & 1 & 49 & 52 & 76 & 60 & 18 & 72 & 86 & 39 & 46 & 81 \cr 99 & 1 & 61 & 96 & 54 & 28 & 62 & 63 & 89 & 65 & 41 & 64 \cr 100 & 1 & 84 & 8 & 57 & 39 & 19 & 96 & 64 & 7 & 80 & 28 \cr 101 & 1 & 4 & 46 & 61 & 51 & 2 & 68 & 9 & 88 & 11 & 88 \cr 102 & 1 & 95 & 86 & 51 & 1 & 47 & 6 & 15 & 80 & 1 & 35 \cr 103 & 1 & 82 & 90 & 38 & 94 & 30 & 19 & 97 & 74 & 37 & 25. \end{array} $$

All coefficients are positive, so every $B_h$ is positive on the cube.

Consider the following $1024$ products:

$$ \prod_{j=1}^{103}B_j, $$

for each $h \in \lbrace1,\ldots,102\rbrace$, the ten products

$$ M\prod_{j\neq h}B_j \qquad \text{for } M \in \lbrace1,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9\rbrace, $$

and the three products

$$ M\prod_{j\neq 103}B_j \qquad \text{for } M \in \lbrace1,x_1,x_2\rbrace. $$

Write their value vectors on $\lbrace0,1\rbrace^{10}$ in lexicographic input order. To keep the certificate small, compute the determinant of this $1024\times1024$ integer value matrix modulo the prime

$$ p := 1000003. $$

The determinant is congruent to

$$ 865224 \pmod p, $$

which is nonzero. Hence the determinant is nonzero over the integers, and the displayed products form a basis for all real-valued functions on $\lbrace0,1\rbrace^{10}$.

By the determinant-span schema from [021_determinant_span_schema.md](021_determinant_span_schema.md), every Boolean function $f : \lbrace0,1\rbrace^{10} \to \lbrace0,1\rbrace$ has

$$ H^{\ast}(f) \leq 103. $$

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
- $n=10$: $H^{\ast}(f) \leq 103$.
- $n=11$: $H^{\ast}(f) \leq 187$ by [025_compact_threshold_certificates.md](025_compact_threshold_certificates.md).
- $n=12$: $H^{\ast}(f) \leq 342$ by [025_compact_threshold_certificates.md](025_compact_threshold_certificates.md).

This is not an exact classification. It is a universal upper bound.

The denominator-span dimension lower bound from [021_determinant_span_schema.md](021_determinant_span_schema.md) says this method cannot work for every ten-bit function unless

$$ 1 + 10H \geq 1024. $$

Equivalently, this full-span route requires $H \geq 103$. Thus the displayed certificate reaches the first possible head count for this method at $n=10$.
