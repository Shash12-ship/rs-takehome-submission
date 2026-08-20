# Positive-Statistic Raw-Bit Cubic Span

## Statement

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let $P(z,y)$ be a strict sign polynomial for a Boolean function $f(z,y)$ that can be written as a cubic polynomial in $t(y)$ and $z$, reduced using $z^2=z$:

$$ P(z,y) = \sum_{r=0}^{3}a_rt(y)^r + z\sum_{r=0}^{2}b_rt(y)^r. $$

Then

$$ H^{\ast}(f)\leq3. $$

> **Interpretation.** Any strict cubic threshold in one positive statistic and one raw bit has a three-head certificate.

## Proof

Write $u$ for $t(y)$. Use the cubic basis

$$ 1,\quad u,\quad u^2,\quad u^3,\quad z,\quad zu,\quad zu^2. $$

Define positive affine denominators

$$ B_1:=1+u+z, \qquad B_2:=2+u+2z, \qquad B_3:=3+u+4z. $$

The following table records seven denominator-cleared products, reduced using $z^2=z$:

| Product | $1$ | $u$ | $u^2$ | $u^3$ | $z$ | $zu$ | $zu^2$ |
|---|---:|---:|---:|---:|---:|---:|---:|
| $B_2B_3$ | $6$ | $5$ | $1$ | $0$ | $22$ | $6$ | $0$ |
| $uB_2B_3$ | $0$ | $6$ | $5$ | $1$ | $0$ | $22$ | $6$ |
| $zB_2B_3$ | $0$ | $0$ | $0$ | $0$ | $28$ | $11$ | $1$ |
| $B_1B_3$ | $3$ | $4$ | $1$ | $0$ | $11$ | $5$ | $0$ |
| $uB_1B_3$ | $0$ | $3$ | $4$ | $1$ | $0$ | $11$ | $5$ |
| $B_1B_2$ | $2$ | $3$ | $1$ | $0$ | $6$ | $3$ | $0$ |
| $uB_1B_2$ | $0$ | $2$ | $3$ | $1$ | $0$ | $6$ | $3$ |

The determinant of this $7\times7$ coefficient matrix is $-480$, so these products span all cubic polynomials in $u$ and $z$ on the Boolean slice $z^2=z$.

Therefore there are affine functions

$$ A_h(z,u)=a_h+b_hu+c_hz, \qquad h\in\lbrace1,2,3\rbrace, $$

such that

$$ P = A_1B_2B_3+A_2B_1B_3+A_3B_1B_2 $$

on the Boolean cube. Since each $B_h$ has positive constant term and positive coefficients on every variable appearing in $t$ and on $z$, the affine-over-positive-affine atom lemma [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md) makes every ratio $A_h/B_h$ a one-head atom.

The three-head score

$$ \frac{A_1}{B_1}+\frac{A_2}{B_2}+\frac{A_3}{B_3} $$

has sign equal to the sign of

$$ \frac{P}{B_1B_2B_3}, $$

and the denominator is positive on the cube. Thus three heads compute $f$. $\blacksquare$

## Consequence

Fresh XOR with an affine slab along a positive statistic has a three-head upper bound whenever its standard sign polynomial has the form $(1-2z)Q(t)$ with $Q$ quadratic.
