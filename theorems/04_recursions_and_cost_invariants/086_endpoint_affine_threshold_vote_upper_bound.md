# Endpoint Affine-Threshold Vote Upper Bound

## Statement

For a nonempty set $S\subseteq\lbrace1,\ldots,n\rbrace$ and positive weights $\lambda_i\gt0$, define

$$ L_S(x):=\sum_{i\in S}\lambda_i x_i, \qquad \Lambda_S:=\sum_{i\in S}\lambda_i. $$

An endpoint affine-threshold feature is either

$$ U_S(x):=\mathbf{1}[L_S(x)\gt0] $$

or

$$ A_S(x):=\mathbf{1}[L_S(x)=\Lambda_S]. $$

Let $T_1,\ldots,T_s$ be endpoint affine-threshold features, and suppose

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{s}c_jT_j(x)\gt0 $$

with positive vote margin

$$ \mu := \min_{x\in\lbrace0,1\rbrace^{n}} \left\lvert c_0+\sum_{j=1}^{s}c_jT_j(x) \right\rvert \gt 0. $$

Then

$$ H^{\ast}(f)\leq s. $$

> **Interpretation.** The unqualified threshold-vote upper bound fails for arbitrary LTF gates, but it is valid for strict votes over endpoint positive affine thresholds. This includes weighted votes over positive OR-type clauses and positive AND-type terms.

## Proof

By the calibrated threshold-vote theorem [085_calibrated_threshold_vote_upper_bound.md](085_calibrated_threshold_vote_upper_bound.md), it suffices to show that each endpoint feature can be uniformly approximated by a single one-head atom with arbitrarily small error.

Fix $S$ and write

$$ \lambda_{\min}:=\min_{i\in S}\lambda_i\gt0. $$

### Lower endpoint

First consider

$$ U_S(x)=\mathbf{1}[L_S(x)\gt0]. $$

Choose small parameters $\delta\gt0$ and $\kappa\gt0$, and define

$$ B_U(x) := \delta+L_S(x)+\kappa\sum_{i\notin S}x_i. $$

This affine denominator has positive constant term and strictly positive coefficients for every variable after taking the coefficient $\kappa$ outside $S$. By the denominator-orientation theorem [032_denominator_orientation.md](../02_complexity_measure_upper_bounds/032_denominator_orientation.md),

$$ \phi_U(x):=\frac{L_S(x)}{B_U(x)} $$

is a one-head atom.

If $U_S(x)=0$, then $L_S(x)=0$, so

$$ \phi_U(x)=0. $$

If $U_S(x)=1$, then $L_S(x)\geq\lambda_{\min}$, and

$$ 0 \leq 1-\phi_U(x) = \frac{\delta+\kappa\sum_{i\notin S}x_i}{B_U(x)} \leq \frac{\delta+\kappa n}{\lambda_{\min}}. $$

Taking $\delta$ and $\kappa$ small enough makes this uniformly smaller than any prescribed tolerance.

### Upper endpoint

Now consider

$$ A_S(x)=\mathbf{1}[L_S(x)=\Lambda_S]. $$

Let

$$ D_S(x):=\Lambda_S-L_S(x). $$

Thus $D_S(x)=0$ exactly on the upper endpoint, and $D_S(x)\geq\lambda_{\min}$ otherwise.

Choose small parameters $\delta\gt0$ and $\kappa\gt0$, and define

$$ B_A(x) := \delta+D_S(x)+\kappa\sum_{i\notin S}(1-x_i). $$

Equivalently,

$$ B_A(x) = \delta+\Lambda_S+\kappa(n-\lvert S\rvert) -\sum_{i\in S}\lambda_i x_i -\kappa\sum_{i\notin S}x_i. $$

This affine denominator has strictly negative coefficients for every variable and remains positive on the cube. By the denominator-orientation theorem,

$$ \phi_A(x):=\frac{\delta}{B_A(x)} $$

is a one-head atom.

If $A_S(x)=1$, then $D_S(x)=0$, so

$$ \phi_A(x) = \frac{\delta}{\delta+\kappa\sum_{i\notin S}(1-x_i)}. $$

Choosing $\kappa$ much smaller than $\delta$ makes this uniformly as close to $1$ as desired.

If $A_S(x)=0$, then $D_S(x)\geq\lambda_{\min}$, so

$$ 0 \leq \phi_A(x) \leq \frac{\delta}{\delta+\lambda_{\min}}. $$

Choosing $\delta$ small makes this uniformly as close to $0$ as desired.

Therefore both endpoint feature types admit arbitrarily accurate one-head atom approximations.

Finally, choose for each feature $T_j$ an approximation error $\epsilon_j$ so small that

$$ \sum_{j=1}^{s}\lvert c_j\rvert\epsilon_j\lt\mu. $$

The calibrated threshold-vote theorem then gives

$$ H^{\ast}(f)\leq s. $$

$\blacksquare$

## Consequences

Every strict weighted vote of positive monotone conjunctions and positive monotone disjunctions has head complexity at most the number of voted features.

This recovers the one-head-per-term monotone DNF and CNF upper bounds as special cases, but it also allows arbitrary real outer weights and mixed votes of lower-endpoint and upper-endpoint features.
