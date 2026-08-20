# Positive-Statistic Raw-Bit Quadratic Span

## Statement

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let $P(z,y)$ be a strict sign polynomial for a Boolean function $f(z,y)$ that can be written as a quadratic polynomial in the two quantities $t(y)$ and $z$, reduced using $z^2=z$:

$$ P(z,y)=p_0+p_1t(y)+p_2t(y)^2+q_0z+q_1z  t(y). $$

Then

$$ H^{\ast}(f)\leq2. $$

> **Interpretation.** Any strict quadratic threshold in one positive statistic and one raw bit has a two-head certificate.

## Proof

Write $u$ for the formal statistic $t(y)$. Use the quadratic basis

$$ 1,\quad u,\quad u^2,\quad z,\quad zu. $$

Define positive affine denominators

$$ B_1:=1+u+z, \qquad B_2:=2+u+3z. $$

The following table records five denominator-cleared products, reduced using $z^2=z$:

| Product | $1$ | $u$ | $u^2$ | $z$ | $zu$ |
|---|---:|---:|---:|---:|---:|
| $B_2$ | $2$ | $1$ | $0$ | $3$ | $0$ |
| $uB_2$ | $0$ | $2$ | $1$ | $0$ | $3$ |
| $zB_2$ | $0$ | $0$ | $0$ | $5$ | $1$ |
| $B_1$ | $1$ | $1$ | $0$ | $1$ | $0$ |
| $uB_1$ | $0$ | $1$ | $1$ | $0$ | $1$ |

The determinant of this $5\times5$ coefficient matrix is $-9$, so these products span all quadratic polynomials in $u$ and $z$ on the Boolean slice $z^2=z$.

Therefore there are affine functions

$$ A_1(z,u)=a_1+b_1u+c_1z, \qquad A_2(z,u)=a_2+b_2u+c_2z, $$

such that

$$ P(z,y)=A_1(z,t(y))B_2(z,t(y))+A_2(z,t(y))B_1(z,t(y)). $$

Since $B_1$ and $B_2$ have positive constant terms and positive coefficients on every variable appearing in $t$ and on $z$, the affine-over-positive-affine atom lemma [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md) makes

$$ \frac{A_1}{B_1}, \qquad \frac{A_2}{B_2} $$

one-head atoms. Their sum has sign

$$ \mathrm{sgn}\left( \frac{P}{B_1B_2} \right), $$

which is the sign of $P$ because $B_1B_2\gt0$ on the cube. Thus two heads compute $f$. $\blacksquare$

## Consequence

This lemma applies to a raw bit selecting between a constant slice and a quadratic one-dimensional threshold slice, provided the two slices admit one strict quadratic polynomial in $t$ and $z$.
