# Cylinder-Threshold Cost Invariant

## Statement

For a partial assignment $(P,N)$ with disjoint $P,N\subseteq\lbrace1,\ldots,n\rbrace$, define

$$ C_{P,N}(x) := \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right) $$

and

$$ \kappa(P,N) := \begin{cases} 0, & P=N=\varnothing, \cr \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace, & \text{otherwise}. \end{cases} $$

Define the cylinder-threshold cost $\mathrm{ctc}(f)$ to be the minimum of

$$ \sum_{a:c_a\neq0}\kappa(P_a,N_a) $$

over all strict representations

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{a=1}^{s}c_aC_{P_a,N_a}(x)\gt0 $$

by subcube indicators. Then

$$ H^{\ast}(f)\leq\mathrm{ctc}(f). $$

Moreover, $\mathrm{ctc}(f)$ is finite for every Boolean function.

> **Interpretation.** Instead of choosing a DNF, CNF, certificate cover, or decision list first, one can optimize directly over strict real threshold votes of cylinders and pay the local orientation cost of the selected cylinders.

## Proof

Fix a strict cylinder-threshold representation of $f$:

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{a=1}^{s}c_aC_{P_a,N_a}(x)\gt0. $$

The subcube-threshold vote theorem [098_subcube_threshold_vote_upper_bound.md](098_subcube_threshold_vote_upper_bound.md) gives

$$ H^{\ast}(f) \leq \sum_{a:c_a\neq0}\kappa(P_a,N_a). $$

Taking the minimum over all strict cylinder-threshold representations proves

$$ H^{\ast}(f)\leq\mathrm{ctc}(f). $$

It remains only to note that the minimum ranges over a nonempty finite set of cylinder supports. Repeated copies of the same cylinder can be merged by adding their coefficients, and cylinders with resulting coefficient $0$ can be deleted, without increasing the cost. Since there are only finitely many subcube indicators on $\lbrace0,1\rbrace^n$, there are only finitely many possible nonzero cylinder supports.

If $f$ is constant, choose $s=0$ and an appropriate constant $c_0$, giving cost $0$.

If $f$ is nonconstant, use the singleton-cylinder representation of its true set:

$$ f(x)=1 \qquad\Longleftrightarrow\qquad \sum_{a\in f^{-1}(1)}C_{P(a),N(a)}(x)-\frac{1}{2}\gt0, $$

where

$$ P(a):=\lbrace i:a_i=1\rbrace, \qquad N(a):=\lbrace i:a_i=0\rbrace. $$

This is strict on the Boolean cube and has finite cost. Hence $\mathrm{ctc}(f)\lt\infty$ for every $f$. $\blacksquare$

## Consequences

Every one-sided local certificate-expansion bound is an instance of $\mathrm{ctc}(f)$: use coefficient $1$ on each covering cylinder and threshold $1/2$.

The singleton representation gives the explicit fallback

$$ \mathrm{ctc}(f) \leq \sum_{a\in f^{-1}(1)} \min\lbrace2^{\lvert a\rvert},2^{n-\lvert a\rvert}\rbrace, $$

The same bound holds with $f^{-1}(0)$ in place of $f^{-1}(1)$ by using coefficient $-1$ on the zero-set singleton cylinders and threshold $1/2$. This fallback is not meant to dominate sparse support in general; its value is to expose when a strict cylinder vote has low local orientation cost even if it is not a one-sided cover in a standard normal form.
