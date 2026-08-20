# Positive-Secant Diagonal Blow-Up

## Statement

Fix a nonconstant Boolean function $f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace$, a head count $H\geq1$, and one orientation for each head. Let

$$ L_0^{\sigma}(x)=1,\qquad L_i^{+}(x)=x_i,\qquad L_i^{-}(x)=1-x_i. $$

For $\theta_h\in\Delta_n$, define

$$ B_h(x;\theta_h)=\sum_{i=0}^{n}\theta_{hi}L_i^{\sigma_h}(x),\qquad Q_\theta(x)=\prod_{h=1}^{H}B_h(x;\theta_h). $$

Put $\Theta=(\Delta_n)^H$, $P=f^{-1}(1)$, and $N=f^{-1}(0)$. For $\theta^{(0)},\theta^{(1)}\in\Theta$, define the positive-secant pair gap

$$ G_{p,q}\left(\theta^{(0)},\theta^{(1)}\right)=Q_{\theta^{(0)}}(q)Q_{\theta^{(1)}}(p)-Q_{\theta^{(0)}}(p)Q_{\theta^{(1)}}(q),\qquad p\in P,\quad q\in N. $$

A normalized feasible direction at $\theta\in\Theta$ is a block vector $v=(v_{hi})$ satisfying

$$ \sum_{i=0}^{n}v_{hi}=0,\qquad \theta_{hi}=0\Longrightarrow v_{hi}\geq0,\qquad \lVert v\rVert_{\infty}=1. $$

For such $\theta,v$, the polynomial

$$ G_{p,q}\left(\theta,\theta+tv\right) $$

vanishes at $t=0$. Define its exact polynomial quotient by

$$ G_{p,q}\left(\theta,\theta+tv\right)=t\widetilde G_{p,q}(\theta,v,t). $$

Then the following are equivalent:

1. There exist $\theta^{(0)},\theta^{(1)}\in\Theta$ such that $G_{p,q}(\theta^{(0)},\theta^{(1)})\gt0$ for every $p\in P$ and $q\in N$.

2. There exist $\theta\in\Theta$, a normalized feasible direction $v$, and $t\geq0$ such that $\theta+tv\in\Theta$ and $\widetilde G_{p,q}(\theta,v,t)\gt0$ for every $p\in P$ and $q\in N$.

The same equivalence holds with all denominator parameters in the interiors of their simplices. The normalization $\lVert v\rVert_{\infty}=1$ is the finite union of the $2H(n+1)$ charts

$$ v_{hi}=1\quad\text{or}\quad v_{hi}=-1,\qquad -1\leq v_{gj}\leq1. $$

Moreover, $\widetilde G_{p,q}$ has degree at most $H-1$ in the scalar $t$.

> **Interpretation.** The identically zero endpoint diagonal is replaced exactly by normalized tangent directions. Strict feasibility at the new $t=0$ boundary is not spurious. It always opens into a genuine positive secant.

## Proof

### Lemma 1. Pair gaps eliminate the mixture scalar

Every $Q_\theta(x)$ is nonnegative on the cube, and it is positive when all barycentric coefficients are positive. For two interior products, a scalar $s\in(0,1)$ gives the signs of $f$ through

$$ sQ_{\theta^{(1)}}(x)-(1-s)Q_{\theta^{(0)}}(x) $$

if and only if

$$ \max_{p\in P}\frac{Q_{\theta^{(0)}}(p)}{Q_{\theta^{(1)}}(p)}\lt\min_{q\in N}\frac{Q_{\theta^{(0)}}(q)}{Q_{\theta^{(1)}}(q)}. $$

Cross multiplication by positive products gives exactly

$$ G_{p,q}\left(\theta^{(0)},\theta^{(1)}\right)\gt0\qquad\text{for every }p\in P,\quad q\in N. $$

$\blacksquare$

### Lemma 2. Exact divisibility

For fixed $\theta,v,p,q$, each perturbed factor is affine in $t$:

$$ B_h(x;\theta_h+tv_h)=B_h(x;\theta_h)+t\dot B_h(x;v_h). $$

Hence $Q_{\theta+tv}(x)$ has degree at most $H$ in $t$. At $t=0$, the two terms in the pair gap coincide:

$$ G_{p,q}(\theta,\theta)=Q_\theta(q)Q_\theta(p)-Q_\theta(p)Q_\theta(q)=0. $$

Therefore the pair gap is divisible by $t$, and its quotient has degree at most $H-1$ in $t$. $\blacksquare$

### Lemma 3. Every secant enters one normalized chart

Suppose the first condition holds. Strict pair gaps force $\theta^{(0)}\neq\theta^{(1)}$. Put

$$ t=\left\lVert\theta^{(1)}-\theta^{(0)}\right\rVert_{\infty}\gt0,\qquad \theta=\theta^{(0)},\qquad v=\frac{\theta^{(1)}-\theta^{(0)}}{t}. $$

The simplex equalities give $\sum_i v_{hi}=0$. If $\theta_{hi}=0$, then $\theta^{(1)}_{hi}\geq0$ gives $v _{hi}\geq0$. Also $\lVert v\rVert _{\infty}=1$, so some coordinate lies in one of the stated charts. Finally,

$$ \widetilde G_{p,q}(\theta,v,t)=\frac{G_{p,q}\left(\theta^{(0)},\theta^{(1)}\right)}{t}\gt0. $$

This proves the forward implication. $\blacksquare$

### Lemma 4. The tangent boundary opens into a secant

Suppose the second condition holds. If $t\gt0$, then

$$ G_{p,q}\left(\theta,\theta+tv\right)=t\widetilde G_{p,q}(\theta,v,t)\gt0, $$

which proves the first condition.

It remains to consider $t=0$. Because $\sum_i v_{hi}=0$ and $v_{hi}\geq0$ whenever $\theta_{hi}=0$, there is an $\varepsilon_0\gt0$ such that

$$ \theta+\varepsilon v\in\Theta\qquad\text{for every }0\leq\varepsilon\leq\varepsilon_0. $$

There are finitely many pairs $(p,q)$. Continuity and strict positivity at zero give an $\varepsilon\in(0,\varepsilon_0]$ such that

$$ \widetilde G_{p,q}(\theta,v,\varepsilon)\gt0\qquad\text{for every }p\in P,\quad q\in N. $$

Multiplying by $\varepsilon\gt0$ gives strict pair gaps for $\theta$ and $\theta+\varepsilon v$. Thus the first condition also follows from a strict point on the blown-up boundary. $\blacksquare$

### Lemma 5. Strictification

Let $\bar\theta$ be the product of simplex barycenters. If two closed-simplex endpoints have all pair gaps strictly positive, replace each endpoint by

$$ (1-\delta)\theta^{(a)}+\delta\bar\theta,\qquad a\in\lbrace0,1\rbrace. $$

For every $\delta\gt0$, all barycentric coefficients are positive. Since there are finitely many strict pair inequalities, continuity preserves them for all sufficiently small $\delta\gt0$. Hence closed-simplex and interior positive-secant feasibility are equivalent.

Combining Lemmas 3, 4, and 5 proves the theorem. $\blacksquare$

## Consequence For Head Lower Bounds

Every strict $H$-head tangent sign pattern has a positive secant with paired orientations. Indeed, absorb the global product coefficient into one affine tangent direction, perturb the base factors into the interiors of their orientation simplices, and use a sufficiently short secant. Finite-cube strictness preserves all signs.

Therefore, if the blown-up pair-gap system is infeasible in every one of the $H+1$ orientation-count branches, then

$$ H^{\ast}(f)\gt H. $$

The blow-up does not make this global infeasibility easy. It removes the universal zero diagonal and replaces it with finitely charted tangent directions, which is the correct starting point for rational McCormick subdivision, pair generation, and exact residual certificates.
