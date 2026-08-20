# Determinant-Span Upper-Bound Schema

## Statement

This note isolates the common mechanism behind the four-, five-, six-, seven-, eight-, nine-, ten-, eleven-, and twelve-bit universal upper bounds.

Let $n \geq 1$ and $H \geq 1$. Suppose there are positive affine functions

$$ B_1,\ldots,B_H $$

on $\lbrace0,1\rbrace^n$ such that some $2^n$ functions chosen from

$$ \prod_{j=1}^{H}B_j, \qquad M\prod_{j\neq h}B_j \quad \text{for } h \in \lbrace1,\ldots,H\rbrace, \quad M \in \lbrace1,x_1,\ldots,x_n\rbrace, $$

have linearly independent value vectors on $\lbrace0,1\rbrace^n$. Then every Boolean function

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace $$

satisfies

$$ H^{\ast}(f) \leq H. $$

## Proof

Let $V$ be the vector space of real-valued functions on $\lbrace0,1\rbrace^n$. Its dimension is $2^n$. By hypothesis, the selected $2^n$ denominator-cleared products form a basis of $V$.

Let $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$ and define the sign labels

$$ Q_f(x) = \begin{cases} +1 & \text{if } f(x) = 1, \cr -1 & \text{if } f(x) = 0. \end{cases} $$

Since the selected products form a basis, $Q_f$ is a linear combination of them. By allowing zero coefficients on the unselected products, this gives affine functions

$$ A_h(x) = a_{h,0} + \sum_{i=1}^{n}a_{h,i}x_i $$

and a constant $c$ such that

$$ Q_f(x) = c\prod_{j=1}^{H}B_j(x) + \sum_{h=1}^{H}A_h(x)\prod_{j\neq h}B_j(x) $$

on the whole cube.

Because every $B_h$ is positive on the cube, the score

$$ S(x) := c + \sum_{h=1}^{H}\frac{A_h(x)}{B_h(x)} $$

has the same sign as $Q_f(x)$:

$$ S(x) = \frac{Q_f(x)}{\prod_{j=1}^{H}B_j(x)}. $$

Each ratio $A_h(x)/B_h(x)$ is a one-head atom by Lemma 1 of [015_three_bit_quadratic_upper_bound.md](015_three_bit_quadratic_upper_bound.md). Therefore thresholding a constant plus $H$ one-head atoms computes $f$. The exact normal form from [010_linear_fractional_normal_form.md](010_linear_fractional_normal_form.md) gives

$$ H^{\ast}(f) \leq H. $$

$\blacksquare$

## Dimension Lower Bound For This Method

For fixed denominators $B_1,\ldots,B_H$, the functions

$$ 1,\qquad \frac{1}{B_h},\frac{x_1}{B_h},\ldots,\frac{x_n}{B_h} $$

have one linear relation for each $h$, namely

$$ \frac{B_h(x)}{B_h(x)} = 1. $$

Thus the span of constant plus affine-over $B_h$ ratios has dimension at most

$$ 1 + nH. $$

Consequently, this full-span method cannot prove a universal bound for all functions on $\lbrace0,1\rbrace^n$ unless

$$ 1 + nH \geq 2^n, $$

or equivalently

$$ H \geq \left\lceil \frac{2^n - 1}{n} \right\rceil. $$

The known determinant certificates meet this dimension lower bound for $n \in \lbrace3,\ldots,12\rbrace$.
