# DNF And CNF Width Give Threshold-Degree Upper Bounds

## Statement

Let

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace. $$

If $f$ has a DNF in which every term has width at most $w$, then

$$ \deg_{\pm}(f)\leq w. $$

If $f$ has a CNF in which every clause has width at most $w$, then

$$ \deg_{\pm}(f)\leq w. $$

Consequently, if a degree $w$ span certificate with $H$ heads is available in the sense of [030_threshold_degree_span_schema.md](030_threshold_degree_span_schema.md), then every width $w$ DNF or CNF function satisfies

$$ H^{\ast}(f)\leq H. $$

> **Interpretation.** Arbitrary mixed-literal DNF is not handled by the monotone one-head-per-term construction, but bounded-width DNF still gives bounded threshold degree. The head upper bound then depends on available degree-restricted span certificates.

## Proof

### Lemma 1. Width-w DNF has threshold degree at most w

Write the DNF as

$$ f(x) = \bigvee_{a=1}^{s} T_a(x), $$

where each term $T_a$ is a conjunction of literals and has width at most $w$.

For each term, let $P_a$ be the set of variables appearing positively and $N_a$ the set of variables appearing negated. Define the term indicator polynomial

$$ I_a(x) := \prod_{i\in P_a}x_i \cdot \prod_{j\in N_a}(1-x_j). $$

The intended meaning is that empty products are $1$. This polynomial has degree

$$ \lvert P_a\rvert+\lvert N_a\rvert\leq w $$

and satisfies $I_a(x)=1$ exactly when term $T_a$ is true, and $I_a(x)=0$ otherwise.

Now define

$$ P(x):=\sum_{a=1}^{s}I_a(x)-\frac{1}{2}. $$

If $f(x)=1$, at least one term is true, so $P(x)\geq1/2$. If $f(x)=0$, every term is false, so $P(x)=-1/2$. Thus $P$ sign-represents $f$ and has degree at most $w$.

Therefore

$$ \deg_{\pm}(f)\leq w. $$

$\blacksquare$

### Lemma 2. Width-w CNF has threshold degree at most w

Write the CNF as

$$ f(x) = \bigwedge_{a=1}^{s} C_a(x), $$

where each clause $C_a$ is a disjunction of literals and has width at most $w$.

For each clause, define $J_a(x)$ to be the indicator that clause $C_a$ is false. If $P_a$ is the set of variables appearing positively in $C_a$ and $N_a$ is the set of variables appearing negated, then

$$ J_a(x) := \prod_{i\in P_a}(1-x_i) \cdot \prod_{j\in N_a}x_j. $$

Again $J_a$ has degree at most $w$, and $J_a(x)=1$ exactly when $C_a(x)=0$.

Define

$$ Q(x):=\frac{1}{2}-\sum_{a=1}^{s}J_a(x). $$

If $f(x)=1$, every clause is true, so every $J_a(x)=0$ and $Q(x)=1/2$. If $f(x)=0$, at least one clause is false, so $Q(x)\leq-1/2$. Thus $Q$ sign-represents $f$ and has degree at most $w$.

Therefore

$$ \deg_{\pm}(f)\leq w. $$

$\blacksquare$

### Lemma 3. Convert threshold degree to heads when a span certificate exists

This is exactly [030_threshold_degree_span_schema.md](030_threshold_degree_span_schema.md): if all degree-at-most $w$ multilinear polynomials lie in an $H$-head denominator-cleared span, then every function with threshold degree at most $w$ has head complexity at most $H$.

Combining Lemma 1 or Lemma 2 with that schema gives the stated head upper bound. $\blacksquare$

## Consequence

Bounded-width DNF and CNF give a clean route to head upper bounds without requiring monotonicity:

$$ \text{width}(f)\leq w \qquad\Longrightarrow\qquad \deg_{\pm}(f)\leq w. $$

For $n=3$, the exact three-bit classification then gives

$$ H^{\ast}(f)\leq w $$

for every three-bit function with DNF or CNF width $w$. For larger $n$, the missing ingredient is a concrete degree $w$ span certificate.
