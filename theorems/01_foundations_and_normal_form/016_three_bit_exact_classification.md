# Exact Three-Bit Classification

## Statement

For every Boolean function

$$ f : \lbrace0,1\rbrace^3 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) = \deg_{\pm}(f). $$

In particular, every three-bit Boolean function satisfies

$$ H^{\ast}(f) \leq 3. $$

## Proof

The lower bound is already known:

$$ \deg_{\pm}(f) \leq H^{\ast}(f) $$

by Lemma 6 of [../theorems.md](../../theorems.md). It remains to match this lower bound by upper bounds for threshold degree $0,1,2,3$.

### Lemma 1. Three-bit cubic thresholds use at most three heads

Let $f : \lbrace0,1\rbrace^3 \to \lbrace0,1\rbrace$. Suppose there is a multilinear polynomial $P$ of degree at most $3$ such that

$$ f(x)=1 \qquad \Longleftrightarrow \qquad P(x)\gt0 $$

for every $x\in\lbrace0,1\rbrace^3$. Then

$$ H^{\ast}(f) \leq 3. $$

**Proof.** Work in the multilinear polynomial basis

$$ 1,\quad x_1,\quad x_2,\quad x_3,\quad x_1x_2,\quad x_1x_3,\quad x_2x_3,\quad x_1x_2x_3. $$

Define three positive affine denominators

$$ \begin{aligned} B_1(x) &:= 1+x_1+x_2+x_3, \cr B_2(x) &:= 1+x_1+2x_2+4x_3, \cr B_3(x) &:= 1+2x_1+3x_2+5x_3. \end{aligned} $$

The following coefficient table records products of two denominators with affine monomials, reduced using $x_i^2=x_i$ on the Boolean cube:

| Product | $1$ | $x_1$ | $x_2$ | $x_3$ | $x_1x_2$ | $x_1x_3$ | $x_2x_3$ | $x_1x_2x_3$ |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| $B_2B_3$ | $1$ | $5$ | $11$ | $29$ | $7$ | $13$ | $22$ | $0$ |
| $x_1B_2B_3$ | $0$ | $6$ | $0$ | $0$ | $18$ | $42$ | $0$ | $22$ |
| $x_2B_2B_3$ | $0$ | $0$ | $12$ | $0$ | $12$ | $0$ | $51$ | $13$ |
| $x_3B_2B_3$ | $0$ | $0$ | $0$ | $30$ | $0$ | $18$ | $33$ | $7$ |
| $B_1B_3$ | $1$ | $5$ | $7$ | $11$ | $5$ | $7$ | $8$ | $0$ |
| $x_1B_1B_3$ | $0$ | $6$ | $0$ | $0$ | $12$ | $18$ | $0$ | $8$ |
| $x_2B_1B_3$ | $0$ | $0$ | $8$ | $0$ | $10$ | $0$ | $19$ | $7$ |
| $B_1B_2$ | $1$ | $3$ | $5$ | $9$ | $3$ | $5$ | $6$ | $0$ |

The determinant of this $8 \times 8$ table is

$$ -5723136, $$

so these eight products form a basis for all multilinear polynomials on $\lbrace0,1\rbrace^3$.

Therefore, for every degree-at-most $3$ polynomial $P$, there are affine functions $A_1,A_2,A_3$ with

$$ P(x) = A_1(x)B_2(x)B_3(x) +A_2(x)B_1(x)B_3(x) +A_3(x)B_1(x)B_2(x) $$

on the Boolean cube. Since $B_1(x),B_2(x),B_3(x)\gt0$, the rational score

$$ S(x) := \frac{A_1(x)}{B_1(x)} + \frac{A_2(x)}{B_2(x)} + \frac{A_3(x)}{B_3(x)} $$

has the same sign as $P(x)$, because

$$ S(x) = \frac{P(x)}{B_1(x)B_2(x)B_3(x)}. $$

Each summand $A_i(x)/B_i(x)$ is a one-head atom by Lemma 1 of [015_three_bit_quadratic_upper_bound.md](015_three_bit_quadratic_upper_bound.md). Hence thresholding the sum of three atoms computes $f$, so

$$ H^{\ast}(f) \leq 3. $$

$\blacksquare$

### Lemma 2. Every three-bit function has threshold degree at most three

Every real-valued function on $\lbrace0,1\rbrace^3$ has a unique multilinear interpolation polynomial of degree at most $3$. In particular, for a Boolean function $f$, interpolate the values

$$ Q_f(x) = \begin{cases} +1 & \text{if } f(x)=1, \cr -1 & \text{if } f(x)=0. \end{cases} $$

Then $Q_f$ sign-represents $f$, so

$$ \deg_{\pm}(f) \leq 3. $$

### Lemma 3. The exact three-bit classification

Let

$$ d := \deg_{\pm}(f). $$

By Lemma 2, $d\in\lbrace0,1,2,3\rbrace$.

1. If $d=0$, then $f$ is constant. By Lemma 11,

   $H^{\ast}(f) = 0 = d.$

2. If $d=1$, then $f$ is a nonconstant linear threshold function. By Lemma 11,

   $H^{\ast}(f) = 1 = d.$

3. If $d=2$, the threshold-degree lower bound gives $H^{\ast}(f) \geq 2$, while Lemma 15 gives $H^{\ast}(f) \leq 2$. Hence

   $H^{\ast}(f) = 2 = d.$

4. If $d=3$, the threshold-degree lower bound gives $H^{\ast}(f) \geq 3$, while Lemma 1 gives $H^{\ast}(f) \leq 3$. Hence

   $H^{\ast}(f) = 3 = d.$

Thus, for every $f : \lbrace0,1\rbrace^3 \to \lbrace0,1\rbrace$,

$$ H^{\ast}(f) = \deg_{\pm}(f). $$

$\blacksquare$

## Consequence

The first dimensions now have exact characterizations:

- $n=1$: constants have $H^{\ast}=0$, nonconstant functions have $H^{\ast}=1$.
- $n=2$: the existing Lean development classifies all functions.
- $n=3$: the theorem above gives $H^{\ast}(f) = \deg_{\pm}(f)$ for every Boolean function.

The next genuine classification boundary is therefore $n=4$.
