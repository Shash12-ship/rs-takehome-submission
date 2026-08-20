# Affine-Cylinder Threshold Cost

## Statement

For a partial assignment $(P,N)$ with disjoint $P,N\subseteq\lbrace1,\ldots,n\rbrace$, define

$$ C_{P,N}(x) := \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right) $$

and

$$ \kappa(P,N) := \begin{cases} 0, & P=N=\varnothing, \cr \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace, & \text{otherwise}. \end{cases} $$

For an affine form

$$ A(x)=a_{\varnothing}+\sum_{i=1}^{n}a_i x_i, $$

define

$$ \lambda(A) := \mathbf{1} \left[ \exists i,\ a_i\neq0 \right]. $$

Define the affine-cylinder threshold cost $\mathrm{actc}(f)$ to be the minimum of

$$ \lambda(A)+\sum_{a:c_a\neq0}\kappa(P_a,N_a) $$

over all strict representations

$$ f(x)=1 \qquad\Longleftrightarrow\qquad A(x)+\sum_{a=1}^{s}c_aC_{P_a,N_a}(x)\gt0. $$

Then

$$ H^{\ast}(f)\leq\mathrm{actc}(f). $$

Moreover,

$$ \mathrm{actc}(f)\leq\mathrm{ctc}(f), $$

so $\mathrm{actc}(f)$ is finite for every Boolean function.

> **Interpretation.** A strict cylinder-threshold representation should not pay separately for every linear monomial. The affine-cylinder cost keeps the signed cylinder-vote flexibility of $\mathrm{ctc}$ while letting one head approximate the whole affine part.

## Proof

First note that the feasible set is nonempty. The singleton-cylinder representation used in [099_cylinder_threshold_cost_invariant.md](099_cylinder_threshold_cost_invariant.md) is an affine-cylinder representation with affine part $A=0$. Thus the set of feasible integer costs is a nonempty subset of the nonnegative integers, so it has a least element.

Fix a strict affine-cylinder representation

$$ f(x)=1 \qquad\Longleftrightarrow\qquad V(x)\gt0, \qquad V(x):= A(x)+\sum_{a=1}^{s}c_aC_{P_a,N_a}(x). $$

Since $V$ is strict on the finite cube, its margin

$$ \Delta := \min_{x\in\lbrace0,1\rbrace^n}\lvert V(x)\rvert $$

is positive.

Let

$$ \mathcal{J} := \lbrace a:c_a\neq0,\ \kappa(P_a,N_a)\gt0\rbrace. $$

Vacuous cylinders have $\kappa(P_a,N_a)=0$ and are constants, so they can be kept exactly in the final readout bias.

Choose positive tolerances so that the total weighted error is below the margin:

$$ \epsilon_A + \sum_{a\in\mathcal{J}}\lvert c_a\rvert\epsilon_a \lt \Delta, $$

where the $\epsilon_A$ term is used only when $\lambda(A)=1$.

If $\lambda(A)=1$, Lemma 1 of [048_affine_free_sparsity_upper_bound.md](../03_function_families_and_affine_geometry/048_affine_free_sparsity_upper_bound.md) gives one head atom $\psi_A$ such that

$$ \lvert\psi_A(x)-A(x)\rvert\lt\epsilon_A \qquad \text{for every }x. $$

If $\lambda(A)=0$, then $A$ is constant and is kept exactly in the final readout bias, using no head.

For each $a\in\mathcal{J}$, the subcube raw calibration lemma [096_subcube_raw_calibration_cost.md](096_subcube_raw_calibration_cost.md) gives a constant $b_{a,0}$ and at most $\kappa(P_a,N_a)$ one-head atoms $\phi_{a,h}$ such that

$$ \left\lvert b_{a,0} + \sum_{h=1}^{\kappa(P_a,N_a)}\phi_{a,h}(x) - C_{P_a,N_a}(x) \right\rvert \lt \epsilon_a \qquad \text{for every }x. $$

Let $\widetilde V$ be the resulting approximation to $V$: use $\psi_A$ for the affine part when $\lambda(A)=1$, keep all constant pieces in the readout bias, and replace each nonvacuous cylinder by its raw calibrated approximation. Then for every cube point,

$$ \lvert\widetilde V(x)-V(x)\rvert \lt \Delta. $$

Therefore $\widetilde V$ has the same sign as $V$ on the cube. Scalar multiples of one-head atoms are still one-head atoms by scaling numerator parameters. Hence the linear-fractional normal form [010_linear_fractional_normal_form.md](../01_foundations_and_normal_form/010_linear_fractional_normal_form.md) gives

$$ H^{\ast}(f) \leq \lambda(A)+\sum_{a:c_a\neq0}\kappa(P_a,N_a). $$

Taking the minimum over strict affine-cylinder representations proves

$$ H^{\ast}(f)\leq\mathrm{actc}(f). $$

Finally, every strict cylinder-threshold representation

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{a=1}^{s}c_aC_{P_a,N_a}(x)\gt0 $$

is an affine-cylinder representation by taking $A(x)=c_0$. Since $\lambda(A)=0$ for a constant affine form, the same representation has the same cost. Minimizing gives

$$ \mathrm{actc}(f)\leq\mathrm{ctc}(f). $$

The finiteness of $\mathrm{actc}(f)$ follows from the finiteness of $\mathrm{ctc}(f)$ in Lemma 99. $\blacksquare$

## Consequences

The invariant $\mathrm{actc}$ is a strict optimization target between the linear-fractional normal form and older certificate classes. It inherits every feasible cylinder-threshold certificate, but it also treats dense affine thresholds as one-head primitives.

In particular, a representation with many linear monomials and a few locally cheap cylinders can have small $\mathrm{actc}$ even when the same score has large ordinary cylinder cost or large ordinary monomial sparsity.
