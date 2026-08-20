# Five-Bit Universal Upper Bound

## Statement

For every Boolean function

$$ f : \lbrace0,1\rbrace^5 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 7. $$

This improves the general positive weighted-sum bound, which gives only $H^{\ast}(f) \leq 31$ at $n=5$.

## Proof

The proof is a determinant-span certificate for seven affine-over-positive-affine atoms.

### Lemma 1. Every five-bit sign polynomial is a seven-head score

Let $P$ be any multilinear polynomial in five Boolean variables. Then there are positive affine functions

$$ B_1,\ldots,B_7, $$

affine functions

$$ A_1,\ldots,A_7, $$

and a constant $c$ such that

$$ P(x) = c\prod_{j=1}^{7}B_j(x) + \sum_{h=1}^{7} A_h(x)\prod_{j\neq h}B_j(x) $$

on $\lbrace0,1\rbrace^5$.

**Proof.** Work in the multilinear basis indexed by all subsets of $\lbrace1,2,3,4,5\rbrace$:

$$ \prod_{i\in S}x_i, \qquad S\subseteq\lbrace1,2,3,4,5\rbrace. $$

Define the seven positive affine denominators by

$$ B_h(x)=b_{h,0}+\sum_{i=1}^{5}b_{h,i}x_i, $$

with coefficient rows

$$ \begin{array}{c|rrrrrr} h & b_{h,0} & b_{h,1} & b_{h,2} & b_{h,3} & b_{h,4} & b_{h,5} \cr \hline 1 & 1 & 85 & 64 & 51 & 27 & 31 \cr 2 & 1 & 5 & 8 & 2 & 18 & 81 \cr 3 & 1 & 65 & 91 & 50 & 61 & 97 \cr 4 & 1 & 73 & 63 & 54 & 56 & 93 \cr 5 & 1 & 28 & 81 & 67 & 1 & 40 \cr 6 & 1 & 85 & 55 & 4 & 76 & 73 \cr 7 & 1 & 84 & 18 & 9 & 86 & 3. \end{array} $$

All coefficients are positive, so every $B_h$ is positive on the cube.

Consider the following $32$ products:

$$ \prod_{j=1}^{7}B_j, $$

for each $h\in\lbrace1,2,3,4,5,6\rbrace$, the five products

$$ M\prod_{j\neq h}B_j \qquad \text{for } M\in\lbrace1,x_1,x_2,x_3,x_4\rbrace, $$

and the single product

$$ \prod_{j\neq 7}B_j. $$

Reduce these products using $x_i^2=x_i$ on the Boolean cube, and write their coefficient vectors in the $32$-element multilinear basis.

The determinant of this $32\times32$ integer matrix is nonzero. To keep the certificate small, compute it modulo the prime

$$ p := 1000003. $$

The determinant is congruent to

$$ 492876 \pmod p, $$

which is nonzero. Hence the determinant is nonzero over the integers, and the displayed products form a basis for all multilinear polynomials on $\lbrace0,1\rbrace^5$.

Therefore every multilinear $P$ has the displayed form. $\blacksquare$

### Lemma 2. Seven heads suffice for every five-bit function

Let $f : \lbrace0,1\rbrace^5 \to \lbrace0,1\rbrace$. Interpolate the sign labels

$$ Q_f(x) = \begin{cases} +1 & \text{if } f(x)=1, \cr -1 & \text{if } f(x)=0 \end{cases} $$

by a multilinear polynomial $P$ on $\lbrace0,1\rbrace^5$.

Apply Lemma 1 to this $P$. Since each $B_h$ is positive on the cube, the score

$$ S(x) := c+\sum_{h=1}^{7}\frac{A_h(x)}{B_h(x)} $$

has the same sign as $P(x)$, because

$$ S(x) = \frac{P(x)}{\prod_{j=1}^{7}B_j(x)}. $$

Each ratio $A_h(x)/B_h(x)$ is a one-head atom by Lemma 1 of [015_three_bit_quadratic_upper_bound.md](015_three_bit_quadratic_upper_bound.md). Therefore thresholding a constant plus seven one-head atoms computes $f$, and the exact normal form from [010_linear_fractional_normal_form.md](010_linear_fractional_normal_form.md) gives

$$ H^{\ast}(f) \leq 7. $$

$\blacksquare$

## Consequence

The current universal upper bounds for small $n$ are:

- $n=1$: $H^{\ast}(f) \leq 1$.
- $n=2$: $H^{\ast}(f) \leq 2$.
- $n=3$: $H^{\ast}(f) \leq 3$, and in fact $H^{\ast}(f) = \deg_{\pm}(f)$.
- $n=4$: $H^{\ast}(f) \leq 4$.
- $n=5$: $H^{\ast}(f) \leq 7$.

The determinant-span method is therefore already substantially sharper than the injective positive-projection bound at $n=5$.
