# Three-Bit Quadratic Upper Bound

## Statement

This note gives a two-head upper bound for every three-bit Boolean function with a quadratic sign representation.

Let $f : \lbrace0,1\rbrace^3 \to \lbrace0,1\rbrace$. Suppose there is a multilinear polynomial $P$ of degree at most $2$ such that

$$ f(x)=1 \qquad \Longleftrightarrow \qquad P(x)\gt0 $$

for every $x \in \lbrace0,1\rbrace^3$. Then

$$ H^{\ast}(f) \leq 2. $$

Consequently, the historical provisional three-head function

$$ 00101001 $$

has exact value

$$ H^{\ast}(00101001) = 2. $$

## Proof

### Lemma 1. Affine-over-positive-affine ratios are one-head atoms

Let

$$ A(x) = a_0 + \sum_{i=1}^{n} a_i x_i $$

be any affine function. Let

$$ B(x) = b_0 + \sum_{i=1}^{n} b_i x_i $$

where

$$ b_0\gt0, \qquad b_i\gt0 \quad \text{for all } i. $$

Then $A(x)/B(x)$ is a one-head atom in the sense of [010_linear_fractional_normal_form.md](010_linear_fractional_normal_form.md).

**Proof.** Choose

$$ \alpha \gt 1 + \frac{\sum_i b_i}{b_0}. $$

Set

$$ \rho_i := \frac{b_i}{\alpha-1}, \qquad \gamma := b_0 - \sum_i \rho_i. $$

Then $\rho_i\gt0$ and $\gamma\gt0$. Also,

$$ \begin{aligned} \gamma+\sum_i \rho_i\alpha^{x_i} &= \gamma+\sum_i \rho_i\bigl(1+(\alpha-1)x_i\bigr) \cr &= b_0+\sum_i b_i x_i \cr &= B(x). \end{aligned} $$

Set $\delta := 0$ and

$$ m_i := \frac{a_i}{b_i}, \qquad \eta := a_0-\sum_i \rho_i m_i. $$

Then

$$ \begin{aligned} \eta+\sum_i \rho_i\alpha^{x_i}m_i &= \eta+\sum_i \rho_i m_i+\sum_i b_i m_i x_i \cr &= a_0+\sum_i a_i x_i \cr &= A(x). \end{aligned} $$

Thus $A(x)/B(x)$ has exactly the atom form from Lemma 10. $\blacksquare$

### Lemma 2. Every three-bit quadratic threshold uses at most two heads

Work in the multilinear polynomial basis

$$ 1,\quad x_1,\quad x_2,\quad x_3,\quad x_1x_2,\quad x_1x_3,\quad x_2x_3. $$

Define two positive affine denominators

$$ B_1(x) := 1+x_1+x_2+x_3, \qquad B_2(x) := 1+x_1+2x_2+4x_3. $$

The following coefficient table records the products of $B_1,B_2$ with affine monomials, reduced using $x_i^2=x_i$ on the Boolean cube:

| Product | $1$ | $x_1$ | $x_2$ | $x_3$ | $x_1x_2$ | $x_1x_3$ | $x_2x_3$ |
|---|---:|---:|---:|---:|---:|---:|---:|
| $B_1$ | $1$ | $1$ | $1$ | $1$ | $0$ | $0$ | $0$ |
| $x_1B_1$ | $0$ | $2$ | $0$ | $0$ | $1$ | $1$ | $0$ |
| $x_2B_1$ | $0$ | $0$ | $2$ | $0$ | $1$ | $0$ | $1$ |
| $x_3B_1$ | $0$ | $0$ | $0$ | $2$ | $0$ | $1$ | $1$ |
| $B_2$ | $1$ | $1$ | $2$ | $4$ | $0$ | $0$ | $0$ |
| $x_1B_2$ | $0$ | $2$ | $0$ | $0$ | $2$ | $4$ | $0$ |
| $x_2B_2$ | $0$ | $0$ | $3$ | $0$ | $1$ | $0$ | $4$ |

The $7 \times 7$ determinant of this table is $-24$, so these seven products form a basis for all multilinear polynomials of degree at most $2$ on $\lbrace0,1\rbrace^3$.

Therefore, for every such polynomial $P$, there are affine functions $A_1,A_2$ with

$$ P(x) = A_1(x)B_2(x)+A_2(x)B_1(x) $$

on the Boolean cube. Since $B_1(x)\gt0$ and $B_2(x)\gt0$, the rational score

$$ S(x) := \frac{A_1(x)}{B_1(x)} + \frac{A_2(x)}{B_2(x)} $$

has the same sign as $P(x)$, because

$$ S(x)=\frac{P(x)}{B_1(x)B_2(x)}. $$

By Lemma 1, each summand is a one-head atom. Hence thresholding the sum of two atoms computes $f$, so

$$ H^{\ast}(f) \leq 2. $$

$\blacksquare$

### Lemma 3. The function 00101001 has exact head complexity 2

Let $g$ be the function with positive inputs

$$ \lbrace010,100,111\rbrace. $$

Equivalently,

$$ g(x)=1 \qquad \Longleftrightarrow \qquad x_1+x_2-x_3=1. $$

Indeed, the statistic

$$ s(x):=x_1+x_2-x_3 $$

takes values in $\lbrace-1,0,1,2\rbrace$ on the cube, and $s(x)=1$ exactly at $010,100,111$.

Now define

$$ P(x) := \left(s(x)-\frac{1}{2}\right) \left(\frac{3}{2}-s(x)\right). $$

This polynomial is positive exactly when $s(x)=1$ and negative when $s(x)\in\lbrace-1,0,2\rbrace$. Its multilinear expansion is

$$ P(x) = -2x_1x_2+2x_1x_3+2x_2x_3+x_1+x_2-3x_3-\frac{3}{4}, $$

so $P$ has degree at most $2$. Lemma 2 gives

$$ H^{\ast}(g) \leq 2. $$

The lower bound $H^{\ast}(g) \geq 2$ was proved in [014_three_bit_projection_cases.md](014_three_bit_projection_cases.md), using the lattice-square obstruction and the one-head linear-threshold characterization. Therefore

$$ H^{\ast}(00101001) = 2. $$

$\blacksquare$

## Consequence

The four historical provisional three-head rows at $n=3$ are now resolved in prose:

1. `00010110` is $\mathrm{EXACT}_{3,2}$, so $H^{\ast}=2$.
2. `00011000` has $H^{\ast}=2$ by [014_three_bit_projection_cases.md](014_three_bit_projection_cases.md).
3. `00101001` has $H^{\ast}=2$ by Lemma 3 above.
4. `01101001` is $\mathrm{XOR}_3$, so $H^{\ast}=3$.
