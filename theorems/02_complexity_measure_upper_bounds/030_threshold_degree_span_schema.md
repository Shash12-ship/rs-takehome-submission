# Threshold-Degree Span Upper-Bound Schema

## Statement

This note isolates the degree-restricted version of the determinant-span method.

Let $V_{n,d}$ be the vector space of multilinear polynomials of degree at most $d$ on $\lbrace0,1\rbrace^n$. Its dimension is

$$ D(n,d):=\sum_{r=0}^{d}\binom{n}{r}. $$

Fix $H\geq1$. Suppose there are affine functions with positive coefficients

$$ B_1,\ldots,B_H $$

on $\lbrace0,1\rbrace^n$, namely

$$ B_h(x)=b_{h,0}+\sum_{i=1}^{n}b_{h,i}x_i, \qquad b_{h,0}\gt0, \qquad b_{h,i}\gt0, $$

such that $D(n,d)$ functions chosen from

$$ \prod_{j=1}^{H}B_j, \qquad M\prod_{j\neq h}B_j \quad \text{for } h\in\lbrace1,\ldots,H\rbrace, \quad M\in\lbrace1,x_1,\ldots,x_n\rbrace, $$

span $V_{n,d}$ as a subspace of all functions on the Boolean cube, after reduction modulo $x_i^2=x_i$. Then every Boolean function

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace $$

with

$$ \deg_{\pm}(f)\leq d $$

satisfies

$$ H^{\ast}(f)\leq H. $$

Moreover, this fixed-denominator degree $d$ span method cannot work unless

$$ 1+nH\geq D(n,d), $$

or equivalently

$$ H\geq\left\lceil\frac{D(n,d)-1}{n}\right\rceil. $$

> **Interpretation.** The universal determinant-span certificates are the special case $d=n$. For exact classification, the useful intermediate question is whether functions of threshold degree $d$ can be covered at the dimension threshold for $V_{n,d}$.
>
> **Caution.** The hypothesis is full containment of $V_{n,d}$ inside the denominator-cleared span. It is not enough for the selected products to have full rank after projecting their coefficient vectors to degree at most $d$; all higher-degree components must cancel in the actual function space.

## Proof

Let $f$ have threshold degree at most $d$. Then there is a polynomial

$$ P\in V_{n,d} $$

such that

$$ f(x)=1 \qquad\Longleftrightarrow\qquad P(x)\gt0 $$

on the cube.

By the spanning hypothesis, there are affine functions

$$ A_h(x)=a_{h,0}+\sum_{i=1}^{n}a_{h,i}x_i $$

and a constant $c$ such that

$$ P(x) = c\prod_{j=1}^{H}B_j(x) + \sum_{h=1}^{H}A_h(x)\prod_{j\neq h}B_j(x) $$

as functions on $\lbrace0,1\rbrace^n$.

Since every $B_h$ is positive on the cube, the rational score

$$ S(x) := c+\sum_{h=1}^{H}\frac{A_h(x)}{B_h(x)} $$

has the same sign as $P(x)$:

$$ S(x) = \frac{P(x)}{\prod_{j=1}^{H}B_j(x)}. $$

Each ratio $A_h/B_h$ is a one-head atom by Lemma 1 of [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md). Therefore the linear-fractional normal form from [010_linear_fractional_normal_form.md](../01_foundations_and_normal_form/010_linear_fractional_normal_form.md) gives

$$ H^{\ast}(f)\leq H. $$

For the dimension lower bound, fix denominators $B_1,\ldots,B_H$. The rational functions

$$ 1,\qquad \frac{1}{B_h},\frac{x_1}{B_h},\ldots,\frac{x_n}{B_h} $$

span the same scores after dividing by the positive product $\prod_j B_j$. For each $h$, there is one linear relation:

$$ \frac{B_h(x)}{B_h(x)}=1. $$

Thus the score span has dimension at most

$$ 1+nH. $$

If it is to contain all of $V_{n,d}$ after denominator clearing, it must have dimension at least $D(n,d)$. Hence

$$ 1+nH\geq D(n,d), $$

as claimed. $\blacksquare$

## Consequence

The threshold-degree lower bound and the degree-restricted span schema give the following strategy for exact classification:

1. Lower-bound $H^{\ast}(f)$ by $\deg_{\pm}(f)$.
2. For each $d$, build a degree $d$ span certificate at or near

   $\left\lceil\frac{D(n,d)-1}{n}\right\rceil.$

3. If the degree $d$ threshold is $d$ itself for a range of $n,d$, then every function of threshold degree $d$ has exact value $d$.

The existing three-bit quadratic theorem is the case

$$ n=3,\qquad d=2,\qquad D(3,2)=7,\qquad H=2. $$

The full universal determinant-span schema from [021_determinant_span_schema.md](../01_foundations_and_normal_form/021_determinant_span_schema.md) is the case $d=n$.
