# Monotone DNF And CNF Upper Bounds

## Statement

Let

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace $$

be computed by a monotone DNF with $s$ nonempty terms:

$$ f(x) = \bigvee_{a=1}^{s}\bigwedge_{i\in S_a}x_i, \qquad S_a\neq\varnothing. $$

Then

$$ H^{\ast}(f)\leq s. $$

If the DNF has an empty term, then $f$ is constant $1$ and $H^{\ast}(f)=0$. If the DNF has no terms, then $f$ is constant $0$ and $H^{\ast}(f)=0$.

The dual statement also holds. If $f$ is computed by a monotone CNF with $s$ nonempty clauses:

$$ f(x) = \bigwedge_{a=1}^{s}\bigvee_{i\in S_a}x_i, \qquad S_a\neq\varnothing, $$

then

$$ H^{\ast}(f)\leq s. $$

> **Interpretation.** A monotone OR of $s$ conjunctions needs at most one head per conjunction. This gives a non-symmetric structured upper bound that does not require the whole function to factor through a single positive weighted sum.

## Proof

### Lemma 1. One head can make a conjunction large-positive and otherwise tiny-negative

Fix a nonempty set $S\subseteq\lbrace1,\ldots,n\rbrace$ and let $k:=\lvert S\rvert$. Define the defect

$$ d_S(x):=k-\sum_{i\in S}x_i. $$

Thus $d_S(x)=0$ exactly when the conjunction $\bigwedge_{i\in S}x_i$ is true, and $d_S(x)\geq1$ otherwise.

Fix constants

$$ C\gt0,\qquad R\gt0,\qquad 0\lt\varepsilon\lt R. $$

Define

$$ A_S(x):=\frac{1}{2}-d_S(x) $$

and

$$ B_S(x) := C+R  d_S(x) +\varepsilon\sum_{i\notin S}(1-x_i). $$

Then $B_S$ is positive on the cube and has strictly negative coefficients for every variable:

$$ B_S(x) = C+Rk+\varepsilon(n-k) -R\sum_{i\in S}x_i -\varepsilon\sum_{i\notin S}x_i. $$

By the denominator-orientation lemma [032_denominator_orientation.md](032_denominator_orientation.md),

$$ \phi_S(x):=\frac{A_S(x)}{B_S(x)} $$

is a one-head atom.

If the conjunction on $S$ is true, then

$$ \phi_S(x) \geq \frac{1}{2(C+\varepsilon n)}. $$

If the conjunction on $S$ is false, then $d_S(x)\geq1$ and

$$ -\frac{1}{R} \lt \phi_S(x) \lt 0. $$

Indeed, in the false case

$$ A_S(x)=\frac{1}{2}-d_S(x)\lt0 $$

and

$$ B_S(x)\geq C+R  d_S(x), $$

so

$$ \phi_S(x) \geq \frac{\frac{1}{2}-d_S(x)}{C+R  d_S(x)} \gt -\frac{1}{R}. $$

$\blacksquare$

### Lemma 2. Sum the term atoms

For each DNF term $S_a$, construct $\phi_{S_a}$ as in Lemma 1 with the same $C,\varepsilon,R$. Let

$$ \mu:=\frac{1}{2(C+\varepsilon n)}. $$

Choose $R$ so large that

$$ \frac{s}{R}\lt\frac{\mu}{2}. $$

Consider the $s$-head score

$$ S(x):=\sum_{a=1}^{s}\phi_{S_a}(x). $$

If no DNF term is satisfied, then every summand is negative, so

$$ S(x)\lt0. $$

If at least one DNF term is satisfied, then one summand is at least $\mu$, and all other summands are greater than $-1/R$. Hence

$$ S(x) \gt \mu-\frac{s-1}{R} \gt \frac{\mu}{2} \gt 0. $$

Therefore

$$ f(x)=1 \qquad\Longleftrightarrow\qquad S(x)\gt0. $$

Since each $\phi_{S_a}$ is a one-head atom, the linear-fractional normal form from [010_linear_fractional_normal_form.md](../01_foundations_and_normal_form/010_linear_fractional_normal_form.md) gives

$$ H^{\ast}(f)\leq s. $$

$\blacksquare$

### Lemma 3. Monotone CNFs have the same bound

Suppose

$$ f(x) = \bigwedge_{a=1}^{s}\bigvee_{i\in S_a}x_i. $$

Then

$$ 1-f(x) = \bigvee_{a=1}^{s}\bigwedge_{i\in S_a}(1-x_i). $$

Define

$$ g(y):=1-f(1-y). $$

Then

$$ g(y) = \bigvee_{a=1}^{s}\bigwedge_{i\in S_a}y_i, $$

so Lemma 2 gives

$$ H^{\ast}(g)\leq s. $$

By complement and global bit-flip invariance from [028_restrictions_and_sign_rank.md](028_restrictions_and_sign_rank.md),

$$ H^{\ast}(f)=H^{\ast}(g). $$

Therefore $H^{\ast}(f)\leq s$. $\blacksquare$

## Consequence

Let $\mathrm{mDNF}(f)$ be the minimum number of nonempty terms in a monotone DNF for $f$, with $\mathrm{mDNF}(0)=\mathrm{mDNF}(1)=0$. Then every monotone Boolean function satisfies

$$ H^{\ast}(f)\leq\mathrm{mDNF}(f). $$

Let $\mathrm{mCNF}(f)$ be the minimum number of nonempty clauses in a monotone CNF for $f$, with $\mathrm{mCNF}(0)=\mathrm{mCNF}(1)=0$. Then every monotone Boolean function also satisfies

$$ H^{\ast}(f)\leq\mathrm{mCNF}(f). $$

Combining the two bounds,

$$ H^{\ast}(f) \leq \min\lbrace\mathrm{mDNF}(f),\mathrm{mCNF}(f)\rbrace. $$

This upper bound can be much smaller than the generic interpolation bound $2^n-1$ when $f$ has a compact monotone formula in either normal form.
