# Raw Calibration Invariances

## Statement

Let

$$ T:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace $$

be a Boolean feature. The raw calibration cost $\rho(T)$ has the following structural properties.

1. Output complement does not change raw cost:

   $\rho(1-T)=\rho(T).$

2. Coordinate permutations do not change raw cost. If $\pi$ is a permutation of $\lbrace1,\ldots,n\rbrace$ and

   $T^{\pi}(x_1,\ldots,x_n) := T(x_{\pi(1)},\ldots,x_{\pi(n)}),$

   then

   $\rho(T^{\pi})=\rho(T).$

3. Global bit-flip does not change raw cost. If

   $T^{\mathrm{flip}}(x) := T(1-x_1,\ldots,1-x_n),$

   then

   $\rho(T^{\mathrm{flip}})=\rho(T).$

4. Adding dummy variables does not change raw cost. If

   $F(x,y)=T(x),$

   then

   $\rho(F)=\rho(T).$

5. Restrictions cannot increase raw cost. If $R$ is obtained from $T$ by fixing some input coordinates, then

   $\rho(R)\leq\rho(T).$

All equalities and inequalities are interpreted in $\mathbb{N}\cup\lbrace\infty\rbrace$.

> **Interpretation.** Raw calibration cost has the same basic robustness properties needed for a reusable invariant: complements, relabelings, global bit-flips, dummy variables, and restrictions do not create artificial cost.

## Proof

We use the one-head atom normal form from [010_linear_fractional_normal_form.md](../01_foundations_and_normal_form/010_linear_fractional_normal_form.md). An atom has the form

$$ \phi(x) := \frac{ \eta + \sum_{i=1}^{n} \rho_i \alpha^{x_i}(m_i + \delta x_i) }{ \gamma + \sum_{i=1}^{n} \rho_i \alpha^{x_i} }, $$

where

$$ \gamma\gt0,\qquad \rho_i\gt0,\qquad \alpha\gt0. $$

### Lemma 1. Elementary atom closures

Multiplying an atom by a scalar gives another atom by multiplying $\eta,m_i,\delta$ by that scalar and leaving the denominator unchanged.

Coordinate permutations give atoms by permuting the parameter triples attached to the coordinates.

Global bit-flip also gives an atom. Indeed,

$$ \alpha^{1-x_i} = \alpha(\alpha^{-1})^{x_i}, $$

and

$$ m_i+\delta(1-x_i) = (m_i+\delta)-\delta x_i. $$

Thus $\phi(1-x_1,\ldots,1-x_n)$ has the same atom form with parameter $\alpha^{-1}$, coordinate weights $\rho_i\alpha$, coordinate offsets $m_i+\delta$, and slope $-\delta$.

Finally, restricting coordinates gives atoms in the remaining variables. Fixed-coordinate contributions are absorbed into the new constants $\gamma$ and $\eta$, exactly as in the restriction proof of [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md).

### Lemma 2. Complement, permutations, bit-flips, and restrictions

Assume first that $\rho(T)=r\lt\infty$. Given $\epsilon\gt0$, choose atoms $\phi_1,\ldots,\phi_r$ and a constant $a_0$ such that

$$ \left\lvert a_0+\sum_{h=1}^{r}\phi_h(x)-T(x) \right\rvert \leq \epsilon $$

for every $x$.

For $1-T$, use

$$ 1-a_0-\sum_{h=1}^{r}\phi_h(x). $$

Scalar closure from Lemma 1 keeps the same number of atoms, so $\rho(1-T)\leq r$. Applying the same argument to $1-T$ proves equality.

For a coordinate permutation or global bit-flip, precompose each $\phi_h$ with the same input transformation. Lemma 1 says each precomposed term is again an atom, and the approximation error is unchanged. Applying the inverse transformation proves equality.

For a restriction $R$, restrict the same approximating expression to the subcube. Lemma 1 keeps each restricted term inside the atom class on the free variables, so

$$ \rho(R)\leq r. $$

If $\rho(T)=\infty$, these inequalities are vacuous, and the equalities follow from applying the finite-cost implications in both directions.

### Lemma 3. Dummy variables

Let $F(x,y)=T(x)$. The lower bound

$$ \rho(T)\leq\rho(F) $$

follows from the restriction inequality by fixing the dummy block $y$ to any value.

For the upper bound, assume $\rho(T)=r\lt\infty$ and fix $\epsilon\gt0$. Choose an $r$-atom approximation to $T$ with error at most $\epsilon/2$. It remains to extend each atom from the $x$ variables to the larger $(x,y)$ cube while changing its value by at most $\epsilon/(2\max\lbrace1,r\rbrace)$.

For a fixed atom $\phi(x)$, keep all original parameters on the $x$ coordinates. Add each dummy coordinate with a positive weight $\lambda$, arbitrary offset $m=0$, and the same atom parameter $\alpha$ and slope $\delta$. As $\lambda\to0^{+}$, the extended denominator and numerator converge uniformly on the finite $(x,y)$ cube to the original denominator and numerator. Since the original denominator is strictly positive on the finite $x$ cube, the extended atom converges uniformly to $\phi(x)$.

Choose $\lambda$ small enough for each atom and sum the extended atoms with the same constant. The total uniform error is at most $\epsilon$. Hence

$$ \rho(F)\leq r. $$

Together with the lower bound, this proves $\rho(F)=\rho(T)$, with the infinite case again following from the finite-cost implications. $\blacksquare$

## Consequences

Any raw calibration lower bound for a feature automatically passes to all coordinate relabelings, global bit-flips, and dummy extensions. Any hard restriction also lower-bounds the original feature:

$$ \rho(T)\geq\rho(R). $$

Thus raw calibration lower-bound searches can work on canonical representatives and small restricted witnesses without losing validity.
