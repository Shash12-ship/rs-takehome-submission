# Cylinder-Threshold Cost Subsumes Local Certificates

## Statement

For disjoint $P,N\subseteq\lbrace1,\ldots,n\rbrace$, write

$$ C_{P,N}(x) := \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right) $$

and

$$ \kappa(P,N) := \begin{cases} 0, & P=N=\varnothing, \cr \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace, & \text{otherwise}. \end{cases} $$

Let $\mathcal{C}_1$ be a $1$-certificate cover for $f$ by partial assignments $(P,N)$. Then

$$ \mathrm{ctc}(f) \leq \sum_{(P,N)\in\mathcal{C}_1}\kappa(P,N). $$

The same bound holds for any $0$-certificate cover $\mathcal{C}_0$:

$$ \mathrm{ctc}(f) \leq \sum_{(P,N)\in\mathcal{C}_0}\kappa(P,N). $$

Consequently, if $f$ has a DNF

$$ f(x)=\bigvee_{a=1}^{s}C_{P_a,N_a}(x), $$

then

$$ \mathrm{ctc}(f) \leq \sum_{a=1}^{s}\kappa(P_a,N_a). $$

If $f$ has a CNF

$$ f(x) = \bigwedge_{a=1}^{s} \left( \bigvee_{i\in P_a}x_i \vee \bigvee_{j\in N_a}(1-x_j) \right), $$

then

$$ \mathrm{ctc}(f) \leq \sum_{a=1}^{s}\kappa(P_a,N_a). $$

If $f$ is computed by a deterministic decision tree $\mathcal{T}$ with accepting leaves $\mathcal{L}_1$ and rejecting leaves $\mathcal{L}_0$, then

$$ \mathrm{ctc}(f) \leq \min\left\lbrace \sum_{\ell\in\mathcal{L}_1}\kappa(P_\ell,N_\ell), \sum_{\ell\in\mathcal{L}_0}\kappa(P_\ell,N_\ell) \right\rbrace. $$

> **Interpretation.** The optimized cylinder-threshold invariant packages the local certificate-expansion theorem. Any local certificate cover, DNF, CNF, or decision-tree leaf cover is one feasible point in the $\mathrm{ctc}$ minimization.

## Proof

Let $\mathcal{C}_1$ be a $1$-certificate cover. Consider the score

$$ S_1(x) := \sum_{(P,N)\in\mathcal{C}_1}C_{P,N}(x)-\frac{1}{2}. $$

If $f(x)=0$, then no cylinder in $\mathcal{C}_1$ contains $x$, so

$$ S_1(x)=-\frac{1}{2}\lt0. $$

If $f(x)=1$, then at least one cylinder in $\mathcal{C}_1$ contains $x$, so

$$ S_1(x)\geq\frac{1}{2}\gt0. $$

Thus $S_1$ is a strict cylinder-threshold representation of $f$. By the definition of $\mathrm{ctc}$,

$$ \mathrm{ctc}(f) \leq \sum_{(P,N)\in\mathcal{C}_1}\kappa(P,N). $$

Now let $\mathcal{C}_0$ be a $0$-certificate cover. Use the score

$$ S_0(x) := \frac{1}{2} - \sum_{(P,N)\in\mathcal{C}_0}C_{P,N}(x). $$

If $f(x)=1$, then no zero-certificate cylinder contains $x$, so $S_0(x)=1/2\gt0$. If $f(x)=0$, then at least one zero-certificate cylinder contains $x$, so $S_0(x)\leq -1/2\lt0$. Hence $S_0$ is a strict cylinder-threshold representation of $f$, and the same cost bound follows.

For a DNF, the terms form a $1$-certificate cover, so the displayed DNF bound is the first part.

For a CNF, the false set is covered by the cylinders that falsify one clause:

$$ \left( \bigvee_{i\in P_a}x_i \vee \bigvee_{j\in N_a}(1-x_j) \right)=0 \qquad\Longleftrightarrow\qquad C_{N_a,P_a}(x)=1. $$

These cylinders form a $0$-certificate cover. Since $\kappa(N_a,P_a)=\kappa(P_a,N_a)$, the $0$-cover bound gives the displayed CNF inequality.

For a decision tree, the accepting leaves form a $1$-certificate cover and the rejecting leaves form a $0$-certificate cover. Applying the two cover bounds and taking the smaller value gives the decision-tree statement. $\blacksquare$

## Consequences

Combining this lemma with the head upper bound

$$ H^{\ast}(f)\leq\mathrm{ctc}(f) $$

from [099_cylinder_threshold_cost_invariant.md](099_cylinder_threshold_cost_invariant.md) recovers the local certificate-expansion theorem [044_oriented_certificate_expansion_upper_bound.md](../02_complexity_measure_upper_bounds/044_oriented_certificate_expansion_upper_bound.md), with $\kappa$ replacing the harmless vacuous-cylinder cost by $0$.

Thus $\mathrm{ctc}$ is a genuine extension of the local certificate route: it includes one-sided covers, but can also exploit overlapping signed cylinder votes that are not covers.
