# Raw-Calibrated Vote Support Bound

## Statement

For a Boolean feature

$$ T:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace, $$

define $\rho(T)$ to be the least nonnegative integer $r$ such that for every $\epsilon\gt0$ there are one-head atoms

$$ \phi_1,\ldots,\phi_r $$

and a constant $a_0$ with

$$ \left\lvert a_0+\sum_{h=1}^{r}\phi_h(x)-T(x) \right\rvert \leq \epsilon \qquad \text{for every }x. $$

If no such $r$ exists, set $\rho(T)=\infty$.

Suppose

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{s}c_jT_j(x)\gt0 $$

with positive vote margin

$$ \mu := \min_x \left\lvert c_0+\sum_{j=1}^{s}c_jT_j(x) \right\rvert \gt 0. $$

Then

$$ H^{\ast}(f) \leq \sum_{j:c_j\neq0}\rho(T_j). $$

Moreover, let

$$ T(x) = a_{\varnothing} + \sum_{\varnothing\neq S\subseteq[n]}a_S\prod_{i\in S}x_i $$

be the exact multilinear expansion of $T$. Define the exact affine-free support cost

$$ \mathrm{eafs}(T) := \mathbf{1} \left[ \exists i,\ a_{\lbrace i\rbrace}\neq0 \right] + \left\lvert \lbrace S:\lvert S\rvert\geq2,\ a_S\neq0\rbrace \right\rvert. $$

Then

$$ \rho(T)\leq\mathrm{eafs}(T). $$

Consequently,

$$ H^{\ast}(f) \leq \sum_{j:c_j\neq0}\mathrm{eafs}(T_j). $$

> **Interpretation.** The calibrated-vote theorem does not require every feature to be approximated by one atom. A feature may cost several raw atoms, and exact multilinear sparsity gives a concrete fallback cost.

## Proof

### Lemma 1. Raw costs compose inside a strict vote

Let

$$ R:=\sum_{j:c_j\neq0}\rho(T_j). $$

If $R=\infty$, there is nothing to prove. Assume $R\lt\infty$.

Choose positive tolerances $\epsilon_j$ for the features with $c_j\neq0$ so small that

$$ \sum_{j:c_j\neq0}\lvert c_j\rvert\epsilon_j\lt\mu. $$

By the definition of $\rho(T_j)$, choose an approximation

$$ \Phi_j(x) := a_{j,0} + \sum_{h=1}^{\rho(T_j)}\phi_{j,h}(x) $$

with

$$ \lvert\Phi_j(x)-T_j(x)\rvert\leq\epsilon_j \qquad \text{for every }x. $$

Define

$$ \widetilde V(x) := c_0 + \sum_{j:c_j\neq0}c_j\Phi_j(x). $$

Let

$$ V(x):=c_0+\sum_{j=1}^{s}c_jT_j(x). $$

Then

$$ \begin{aligned} \lvert\widetilde V(x)-V(x)\rvert &\leq \sum_{j:c_j\neq0} \lvert c_j\rvert\lvert\Phi_j(x)-T_j(x)\rvert \cr &\leq \sum_{j:c_j\neq0}\lvert c_j\rvert\epsilon_j \cr &\lt \mu. \end{aligned} $$

Thus $\widetilde V$ has the same sign as $V$ at every cube point. After absorbing the constants $c_ja_{j,0}$ into the final readout constant, $\widetilde V$ is a constant plus $R$ scalar multiples of one-head atoms. Scalar multiples are still one-head atoms, by scaling the numerator parameters. Therefore the linear-fractional normal form gives

$$ H^{\ast}(f)\leq R. $$

### Lemma 2. Exact affine-free support controls raw cost

Let

$$ T(x) = a_{\varnothing} +L(x) + \sum_{S\in\mathcal{M}}a_Sq_S(x), \qquad q_S(x):=\prod_{i\in S}x_i, $$

where $L$ is the linear part and

$$ \mathcal{M}:=\lbrace S:\lvert S\rvert\geq2,\ a_S\neq0\rbrace. $$

If $L$ is nonzero, Lemma 1 of [048_affine_free_sparsity_upper_bound.md](../03_function_families_and_affine_geometry/048_affine_free_sparsity_upper_bound.md) gives one atom approximating $L$ uniformly to any prescribed tolerance. If $L$ is zero, no affine atom is needed.

For each $S\in\mathcal{M}$, Lemma 1 of [041_ptf_sparsity_upper_bound.md](../02_complexity_measure_upper_bounds/041_ptf_sparsity_upper_bound.md) gives one atom approximating $a_Sq_S$ uniformly to any prescribed tolerance.

Choose all these tolerances small enough that the sum of the uniform errors is at most the requested $\epsilon$. Adding the constant term $a_{\varnothing}$ proves

$$ \rho(T)\leq \mathbf{1} \left[L\neq0\right] + \lvert\mathcal{M}\rvert = \mathrm{eafs}(T). $$

Combining this with Lemma 1 proves the final displayed bound. $\blacksquare$

## Consequences

The one-atom calibrated-vote theorem is the special case $\rho(T_j)\leq1$ for every feature used by the outer vote.

For the internal LTF

$$ T(x)=x_1\wedge(x_2\vee x_3), $$

the exact expansion is

$$ T(x)=x_1x_2+x_1x_3-x_1x_2x_3. $$

Thus

$$ \rho(T)\leq3, $$

while Lemma 91 shows $\rho(T)\neq1$. This makes the obstruction quantitative: internal threshold indicators can still be calibrated by spending more raw atoms.
