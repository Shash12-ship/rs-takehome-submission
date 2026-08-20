# Positive-Statistic Raw-Bit Degree Span

## Statement

Let $d\geq1$, let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let $P(z,y)$ be a strict sign polynomial for a Boolean function $f(z,y)$. Suppose $P$ has total degree at most $d$ in the two quantities $t(y)$ and $z$, reduced using $z^2=z$:

$$ P(z,y) = \sum_{r=0}^{d}a_rt(y)^r + z\sum_{r=0}^{d-1}b_rt(y)^r. $$

Then

$$ H^{\ast}(f)\leq d. $$

> **Interpretation.** A one-dimensional positive statistic remains head-efficient after adjoining one raw bit: degree $d$ in $(t,z)$ costs at most $d$ heads.

## Proof

Write $u$ for the formal statistic $t(y)$. For $h=1,\ldots,d$, define the positive affine denominators

$$ B_h(z,u):=u+h+2dz. $$

On the two raw-bit slices, write

$$ B_h^{(0)}(u):=u+h, \qquad B_h^{(1)}(u):=u+h+2d. $$

For $\epsilon\in\lbrace0,1\rbrace$, define

$$ Q_h^{(\epsilon)}(u):=\prod_{j\neq h}B_j^{(\epsilon)}(u). $$

For each fixed $\epsilon$, the polynomials $Q_h^{(\epsilon)}$ form a basis for the vector space of polynomials in $u$ of degree at most $d-1$. Indeed, evaluating at the $d$ distinct points $u=-h-2d\epsilon$ diagonalizes the family: $Q_h^{(\epsilon)}$ is nonzero at its own point, while $Q_{\ell}^{(\epsilon)}$ vanishes there when $\ell\neq h$.

Let

$$ P_0(u):=P(0,u), \qquad P_1(u):=P(1,u). $$

The displayed form of $P$ implies that $P_1-P_0$ has degree at most $d-1$. Hence $P_0$ and $P_1$ have the same coefficient $\ell$ of $u^d$.

Choose numbers $\mu_1,\ldots,\mu_d$ with

$$ \sum_{h=1}^{d}\mu_h=\ell. $$

Then

$$ R_0(u):=P_0(u)-\sum_{h=1}^{d}\mu_hu  Q_h^{(0)}(u) $$

has degree at most $d-1$, because each $uQ_h^{(0)}$ has leading coefficient $1$. By the basis property, choose $a_1,\ldots,a_d$ such that

$$ R_0(u)=\sum_{h=1}^{d}a_hQ_h^{(0)}(u). $$

Equivalently,

$$ P_0(u)=\sum_{h=1}^{d}(a_h+\mu_hu)Q_h^{(0)}(u). $$

Now define

$$ N_1(u):=\sum_{h=1}^{d}(a_h+\mu_hu)Q_h^{(1)}(u). $$

The coefficient of $u^d$ in $N_1$ is again $\sum_h \mu_h=\ell$, so $P_1-N_1$ has degree at most $d-1$. Using the basis property on the $z=1$ slice, choose $c_1,\ldots,c_d$ such that

$$ P_1(u)-N_1(u)=\sum_{h=1}^{d}c_hQ_h^{(1)}(u). $$

Set

$$ A_h(z,u):=a_h+\mu_hu+c_hz. $$

The two slice identities above say exactly that, on the Boolean slice $z\in\lbrace0,1\rbrace$,

$$ P(z,u)= \sum_{h=1}^{d}A_h(z,u)\prod_{j\neq h}B_j(z,u). $$

Therefore the score

$$ \sum_{h=1}^{d}\frac{A_h(z,t(y))}{B_h(z,t(y))} $$

has sign equal to the sign of

$$ \frac{P(z,y)}{\prod_{h=1}^{d}B_h(z,t(y))}. $$

Every denominator $B_h(z,t(y))$ has positive constant term and positive coefficients on every variable appearing in $t$ and on $z$, so the denominator product is positive on the cube, and each ratio is a one-head atom by the affine-over-positive-affine atom lemma [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md). Thus $d$ heads compute $f$. $\blacksquare$

## Consequence

The quadratic and cubic span lemmas are the $d=2$ and $d=3$ cases with small explicit determinant witnesses. The general form supplies a direct degree-sensitive upper bound for any one raw bit coupled to one positive statistic.
