# Denominator Orientation For One-Head Atoms

## Statement

Consider an affine denominator

$$ B(x)=b_0+\sum_{i=1}^{n}b_i x_i $$

on the Boolean cube. A nonconstant one-head atom denominator has all nonzero variable coefficients with the same sign.

More precisely, if

$$ B(x)=\gamma+\sum_{i=1}^{n}\rho_i\alpha^{x_i} $$

with

$$ \gamma\gt0,\qquad \rho_i\gt0,\qquad \alpha\gt0, $$

then either $\alpha=1$ and $B$ is constant, or every variable coefficient of $B$ is nonzero and has sign $\mathrm{sgn}(\alpha-1)$.

Conversely, let $A(x)$ be any affine numerator.

1. If

   $B(x)=b_0+\sum_{i=1}^{n}b_i x_i, \qquad b_0\gt0, \qquad b_i\gt0$

   for every $i$, then $A/B$ is a one-head atom.

2. If

   $B(x)=b_0-\sum_{i=1}^{n}d_i x_i, \qquad d_i\gt0, \qquad b_0\gt\sum_{i=1}^{n}d_i,$

   then $A/B$ is a one-head atom.

> **Interpretation.** One head has a global orientation in its denominator. It can make all variables increase the denominator, or all variables decrease it, but it cannot make some literals increase and others decrease within the same atom.

## Proof

First expand an atom denominator:

$$ \begin{aligned} \gamma+\sum_{i=1}^{n}\rho_i\alpha^{x_i} &= \gamma+\sum_{i=1}^{n}\rho_i\bigl(1+(\alpha-1)x_i\bigr) \cr &= \left(\gamma+\sum_{i=1}^{n}\rho_i\right) + \sum_{i=1}^{n}\rho_i(\alpha-1)x_i. \end{aligned} $$

If $\alpha=1$, every variable coefficient is $0$, so $B$ is constant. If $\alpha\neq1$, then every coefficient $\rho_i(\alpha-1)$ is nonzero and all have the same sign.

Now prove the converse constructions.

### Positive orientation

Suppose $b_i\gt0$ for every $i$. Choose

$$ \alpha\gt1+\frac{\sum_i b_i}{b_0}. $$

Set

$$ \rho_i:=\frac{b_i}{\alpha-1}, \qquad \gamma:=b_0-\sum_i\rho_i. $$

Then $\rho_i\gt0$ and $\gamma\gt0$. Also,

$$ \gamma+\sum_i\rho_i\alpha^{x_i} = b_0+\sum_i b_i x_i = B(x). $$

Write

$$ A(x)=a_0+\sum_i a_i x_i. $$

Set $\delta:=0$,

$$ m_i:=\frac{a_i}{b_i}, \qquad \eta:=a_0-\sum_i\rho_i m_i. $$

Then

$$ \eta+\sum_i\rho_i\alpha^{x_i}m_i = a_0+\sum_i a_i x_i = A(x). $$

Thus $A/B$ has the one-head atom form.

### Negative orientation

Suppose

$$ B(x)=b_0-\sum_i d_i x_i, \qquad d_i\gt0, \qquad b_0\gt\sum_i d_i. $$

Choose $\alpha\in(0,1)$ so small that

$$ \sum_i\frac{d_i}{1-\alpha}\lt b_0. $$

Set

$$ \rho_i:=\frac{d_i}{1-\alpha}, \qquad \gamma:=b_0-\sum_i\rho_i. $$

Then $\rho_i\gt0$, $\gamma\gt0$, and

$$ \gamma+\sum_i\rho_i\alpha^{x_i} = b_0-\sum_i d_i x_i = B(x). $$

Again write

$$ A(x)=a_0+\sum_i a_i x_i. $$

Set $\delta:=0$ and choose $m_i$ by

$$ \rho_i(\alpha-1)m_i=a_i. $$

Finally set

$$ \eta:=a_0-\sum_i\rho_i m_i. $$

Then

$$ \eta+\sum_i\rho_i\alpha^{x_i}m_i = A(x). $$

So $A/B$ is a one-head atom. $\blacksquare$

## Consequence

The monotone DNF construction in [029_monotone_dnf_upper_bound.md](029_monotone_dnf_upper_bound.md) uses exactly this orientation freedom: each conjunction atom chooses a negative-orientation denominator, so missing any required positive literal makes the denominator large and the atom contribution tiny.

This also explains a real limitation of that construction. A general mixed-literal DNF term, such as

$$ x_1\wedge(1-x_2), $$

would naturally want a denominator that grows when $x_1=0$ and also grows when $x_2=1$. Those two requirements ask for opposite denominator orientations in the same atom. The one-head denominator form does not allow that. Extending the DNF upper bound to arbitrary literals therefore requires a different construction, not just a syntactic bit-flip reduction.
