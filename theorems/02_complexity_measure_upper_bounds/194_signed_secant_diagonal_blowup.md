# Signed-Secant Diagonal Blow-Up

## Statement

Fix a nonconstant Boolean function $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$, a head count $H\geq1$, and one orientation for each head. Let $y_x=2f(x)-1$. Using the oriented literals from Theorem 193, put

$$ B_h(x;\theta_h)=\sum_{i=0}^{n}\theta_{hi}L_i^{\sigma_h}(x),\qquad Q_\theta(x)=\prod_{h=1}^{H}B_h(x;\theta_h),\qquad \Theta=(\Delta_n)^H. $$

For two endpoints and a mixture scalar, define the signed secant score

$$ S_x\left(\theta^{(0)},\theta^{(1)},s\right)=sQ_{\theta^{(1)}}(x)-(1-s)Q_{\theta^{(0)}}(x),\qquad 0\leq s\leq1. $$

A normalized signed direction is a pair $(v,a)$ satisfying

$$ \sum_{i=0}^{n}v_{hi}=0,\qquad \max\lbrace\lVert v\rVert_{\infty},\lvert a\rvert\rbrace=1. $$

For $0\leq t\leq1$ with $\theta+tv\in\Theta$, set

$$ s(t)=\frac{1+ta}{2},\qquad \mathcal S_x(\theta,v,a,t)=s(t)Q_{\theta+tv}(x)-(1-s(t))Q_\theta(x). $$

The polynomial $\mathcal S_x(\theta,v,a,t)$ vanishes at $t=0$. Define its exact quotient by

$$ \mathcal S_x(\theta,v,a,t)=t\widetilde{\mathcal S}_x(\theta,v,a,t). $$

Then the following are equivalent:

1. There exist $\theta^{(0)},\theta^{(1)}\in\Theta$ and $s\in[0,1]$ such that $y_xS_x(\theta^{(0)},\theta^{(1)},s)\gt0$ for every cube vertex $x$.

2. There exist $\theta\in\Theta$, a normalized signed direction $(v,a)$, and $t\in[0,1]$ such that $\theta+tv\in\Theta$ and $y_x\widetilde{\mathcal S}_x(\theta,v,a,t)\gt0$ for every cube vertex $x$.

The same equivalence holds with the two endpoint denominator tuples in the interiors of their simplices. The normalization is the finite union of the $2H(n+1)+2$ charts

$$ v_{hi}=1,\qquad v_{hi}=-1,\qquad a=1,\qquad a=-1, $$

with all remaining direction coordinates in $[-1,1]$. The quotient has degree at most $H$ in $t$, standard total degree at most $2H+1$, and degree at most one in each joint head block $(\theta_h,v_h)$.

> **Computational consequence.** The exact pair-gap blow-up in Theorem 193 uses $\lvert f^{-1}(1)\rvert\lvert f^{-1}(0)\rvert$ strict inequalities, cross-vertex product nodes, and quotient polynomials of total degree at most $3H-1$. The signed blow-up uses only $2^n$ strict inequalities, no cross-vertex products, and one additional bounded scalar direction. Its chart domains are closed and compact, with no face implications or tangent-cone case split.

## Proof

### Lemma 1. Exact quotient formula

Define the divided product polynomial $\widetilde Q$ by

$$ Q_{\theta+tv}(x)-Q_\theta(x)=t\widetilde Q_x(\theta,v,t). $$

Each factor in $Q_{\theta+tv}$ is affine in $t$, so $\widetilde Q_x$ has degree at most $H-1$ in $t$. Direct expansion gives

$$ \begin{aligned} \mathcal S_x(\theta,v,a,t) &= \frac12\left(Q_{\theta+tv}(x)-Q_\theta(x)\right)+\frac{ta}{2}\left(Q_{\theta+tv}(x)+Q_\theta(x)\right) \cr &= \frac t2\left(\widetilde Q_x(\theta,v,t)+a\left(Q_{\theta+tv}(x)+Q_\theta(x)\right)\right). \end{aligned} $$

Therefore

$$ \widetilde{\mathcal S}_x(\theta,v,a,t)=\frac12\left(\widetilde Q_x(\theta,v,t)+a\left(Q _{\theta+tv}(x)+Q _\theta(x)\right)\right), $$

and its degree in $t$ is at most $H$. A monomial of $Q_{\theta+tv}$ using $k$ direction terms has total degree $H+k$. Multiplication by $a$ gives total degree at most $2H+1$. Each factor uses only one joint head block, so the quotient is affine in each block $(\theta_h,v_h)$. $\blacksquare$

### Lemma 2. Every strict signed secant enters one chart

Suppose the first condition holds. Put

$$ t=\max\left\lbrace\left\lVert\theta^{(1)}-\theta^{(0)}\right\rVert_{\infty},\lvert2s-1\rvert\right\rbrace. $$

Strict representation of a nonconstant function forces $t\gt0$. Indeed, $t=0$ would give equal endpoints and $s=1/2$, hence the zero score. Differences of simplex coordinates have absolute value at most one, and $\lvert2s-1\rvert\leq1$, so $t\leq1$.

Set

$$ \theta=\theta^{(0)},\qquad v=\frac{\theta^{(1)}-\theta^{(0)}}{t},\qquad a=\frac{2s-1}{t}. $$

The simplex equalities give zero block sums for $v$. The definition of $t$ gives

$$ \max\lbrace\lVert v\rVert_{\infty},\lvert a\rvert\rbrace=1, $$

so one chart equality holds. Moreover, $\theta+tv=\theta^{(1)}$ and $s=(1+ta)/2$. Thus

$$ \widetilde{\mathcal S}_x(\theta,v,a,t)=\frac{S_x(\theta^{(0)},\theta^{(1)},s)}{t}, $$

which proves the forward implication. $\blacksquare$

### Lemma 3. The new boundary opens into a signed secant

Suppose the second condition holds. If $t\gt0$, multiply every strict quotient inequality by $t$ to obtain the first condition.

Now suppose $t=0$. Let $\bar\theta$ be the product of simplex barycenters and set

$$ \theta_\delta=(1-\delta)\theta+\delta\bar\theta. $$

The quotient is polynomial in $\theta$. Since there are finitely many strict signed inequalities, they remain positive at $(\theta_\delta,v,a,0)$ for every sufficiently small $\delta\gt0$. Every coordinate of $\theta_\delta$ is then positive. The zero block sums of $v$ give an $\varepsilon_0\gt0$ such that $\theta_\delta+\varepsilon v\in\Theta$ for every $0\leq\varepsilon\leq\varepsilon_0$. Also $\lvert a\rvert\leq1$, so $(1+\varepsilon a)/2\in[0,1]$ whenever $0\leq\varepsilon\leq1$.

There are finitely many cube vertices. Continuity and strict positivity at zero give an $\varepsilon\in(0,\min\lbrace1,\varepsilon_0\rbrace]$ such that

$$ y_x\widetilde{\mathcal S}_x(\theta _\delta,v,a,\varepsilon)\gt0\qquad\text{for every }x\in\lbrace0,1\rbrace^n. $$

Since $\mathcal S_x=\varepsilon\widetilde{\mathcal S}_x$, these are the strict signed inequalities for the endpoints $\theta _\delta$ and $\theta _\delta+\varepsilon v$ with mixture scalar $(1+\varepsilon a)/2$. This proves the reverse implication. Notice that a direction which points out of a boundary face causes no spurious strict solution. Moving the base point into the interior first makes a sufficiently short ray feasible. $\blacksquare$

### Lemma 4. Strictification and symmetry

As in Theorem 193, perturb both endpoints toward the product of simplex barycenters. Finitely many strict signed inequalities survive for a sufficiently small perturbation. Hence closed-simplex and interior feasibility are equivalent.

Within a fixed orientation-count branch, simultaneous head permutations preserve every product and every signed inequality. Therefore charts whose normalized coordinate lies on two heads with the same orientation are equivalent. After this symmetry quotient, each orientation-count branch needs at most

$$ 4(n+1)+2 $$

chart types, independent of $H$. This completes the proof. $\blacksquare$

## Consequence For Head Lower Bounds

Interior signed-secant feasibility is equivalent to the positive pair-gap feasibility of Theorem 193 by elimination of the scalar $s$. Every strict $H$-head tangent sign pattern has such a signed secant after an arbitrarily small perturbation.

Consequently, if the signed blown-up system is infeasible in every chart of every one of the $H+1$ orientation-count branches, then

$$ H^{\ast}(f)\gt H. $$

This formulation is the preferred exact branch-and-bound target. Candidate separation and exact verification require one signed inequality per truth-table vertex, rather than one inequality per oppositely labeled pair.
