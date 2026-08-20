# Subcube-Threshold Vote Upper Bound

## Statement

For a partial assignment $(P,N)$ with disjoint $P,N\subseteq\lbrace1,\ldots,n\rbrace$, define the subcube indicator

$$ C_{P,N}(x) := \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right). $$

Define its local expansion cost

$$ \kappa(P,N) := \begin{cases} 0, & P=N=\varnothing, \cr \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace, & \text{otherwise}. \end{cases} $$

Suppose

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{a=1}^{s}c_a C_{P_a,N_a}(x)\gt0 $$

with positive margin on the Boolean cube. Then

$$ H^{\ast}(f) \leq \sum_{a:c_a\neq0}\kappa(P_a,N_a). $$

> **Interpretation.** Any strict real threshold of subcube indicators has a head upper bound given by the local literal-orientation cost of the cylinders. The cylinders need not be disjoint, one-sided, or a certificate cover.

## Proof

For each $a$, the subcube raw calibration lemma [096_subcube_raw_calibration_cost.md](096_subcube_raw_calibration_cost.md) gives

$$ \rho(C_{P_a,N_a}) \leq \kappa(P_a,N_a). $$

Indeed, the vacuous cylinder is the constant feature $1$ and costs $0$, while every nonvacuous cylinder costs at most

$$ \min\lbrace2^{\lvert P_a\rvert},2^{\lvert N_a\rvert}\rbrace. $$

Apply the raw-calibrated vote support bound [093_raw_calibrated_vote_support_bound.md](093_raw_calibrated_vote_support_bound.md) to the strict vote over the features $C_{P_a,N_a}$. It gives

$$ H^{\ast}(f) \leq \sum_{a:c_a\neq0}\rho(C_{P_a,N_a}) \leq \sum_{a:c_a\neq0}\kappa(P_a,N_a). $$

$\blacksquare$

## Consequences

The local certificate-expansion upper bound is the special case where all nonzero coefficients are $1$ and the cylinders form a one-sided exact cover, with readout threshold $1/2$.

The theorem also handles overlapping signed cylinder expansions. This gives a direct route for upper-bounding functions represented as strict thresholded decision sets of partial assignments, even when the representation is not a DNF, CNF, or decision list.
