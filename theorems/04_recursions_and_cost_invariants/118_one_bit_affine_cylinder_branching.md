# One-Bit Affine-Cylinder Branching

## Statement

Let

$$ T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace $$

have a strict affine-cylinder score

$$ S(y)=A(y)+\sum_{\gamma\in\Gamma}c_{\gamma}C_{\gamma}(y), \qquad A(y)=a+\sum_{i=1}^{m}\alpha_i y_i, $$

where the cylinder supports in $\Gamma$ are distinct and nonvacuous. Let

$$ G:\lbrace0,1\rbrace^{2}\to\lbrace0,1\rbrace $$

be any two-input Boolean gate, and define

$$ F(z,y):=G(z,T(y)). $$

For $b\in\lbrace0,1\rbrace$, define $\mu_b\in\lbrace-1,0,1\rbrace$ as follows:

- $\mu_b=1$ if $G(b,u)=u$ as a function of $u$,
- $\mu_b=-1$ if $G(b,u)=1-u$ as a function of $u$,
- $\mu_b=0$ if $G(b,u)$ is constant as a function of $u$.

When $\mu_b=0$, define $\delta_b=1$ if $G(b,u)$ is the constant $1$ function and $\delta_b=-1$ if it is the constant $0$ function. When $\mu_b\neq0$, define $\delta_b=0$.

Let

$$ L(A):=\lbrace i:\alpha_i\neq0\rbrace, $$

and

$$ K(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N), \qquad K_z(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P\cup\lbrace z\rbrace,N). $$

Finally define

$$ \eta_G(A) := \mathbf{1} \left[ \delta_1+\mu_1 a\neq \delta_0+\mu_0 a \text{ or } \exists i,\ \mu_0\alpha_i\neq0 \right]. $$

Then

$$ \begin{aligned} H^{\ast}(F) &\leq \mathrm{actc}(F) \leq \mathrm{sactc}(F) \cr &\leq \eta_G(A) + \mathbf{1}[\mu_0\neq0]K(\Gamma) + \mathbf{1}[\mu_1\neq\mu_0] \bigl(\lvert L(A)\rvert+K_z(\Gamma)\bigr). \end{aligned} $$

If the right-hand side is at most $2$, then

$$ H^{\ast}(F) = \begin{cases} 0, & \text{if } F \text{ is constant},\cr 1, & \text{if } F \text{ is a nonconstant LTF},\cr 2, & \text{otherwise}. \end{cases} $$

> **Interpretation.** One-bit branching over an affine-cylinder feature pays for the base cylinder correction only if the $z=0$ slice uses the feature, and pays changed affine slopes and changed cylinder coefficients only if the two slices use different signed copies of the feature.

## Proof

The two cofactors are

$$ F_b(y):=F(b,y)=G(b,T(y)). $$

If $\mu_b=1$, then $F_b=T$, and $S$ is a strict score for $F_b$. If $\mu_b=-1$, then $F_b=1-T$, and $-S$ is a strict score for $F_b$. If $\mu_b=0$, then $F_b$ is constant, and the constant score $\delta_b$ is strict for $F_b$.

Thus each cofactor has a strict affine-cylinder score

$$ S_b(y) = A_b(y) + \sum_{\gamma\in\Gamma_b}c_{b,\gamma}C_{\gamma}(y), $$

where

$$ A_b(y)=\delta_b+\mu_b A(y), $$

and

$$ \Gamma_b= \begin{cases} \Gamma, & \text{if } \mu_b\neq0,\cr \varnothing, & \text{if } \mu_b=0. \end{cases} $$

For $\gamma\in\Gamma$, the coefficient in the $b$-th cofactor is

$$ c_{b,\gamma}=\mu_b c_{\gamma}. $$

Now apply the split affine-cylinder interpolation invariant [112_split_affine_cylinder_cost.md](112_split_affine_cylinder_cost.md) to the split coordinate $z$ and these two cofactor scores.

The affine indicator in the interpolation is exactly $\eta_G(A)$, because the constant terms of $A_0,A_1$ are $\delta_0+\mu_0a$ and $\delta_1+\mu_1a$, and the slopes of $A_0$ are $\mu_0\alpha_i$.

The changed affine slopes are precisely the indices with

$$ \mu_1\alpha_i\neq\mu_0\alpha_i. $$

If $\mu_1=\mu_0$, this set is empty. If $\mu_1\neq\mu_0$, it is exactly $L(A)$. Therefore the changed affine-slope contribution is

$$ \mathbf{1}[\mu_1\neq\mu_0]\lvert L(A)\rvert. $$

The base cylinder contribution is present exactly when $\mu_0\neq0$, and then it is

$$ K(\Gamma). $$

For each $\gamma\in\Gamma$, the cylinder coefficient changes exactly when

$$ \mu_1c_{\gamma}\neq\mu_0c_{\gamma}. $$

Since every $c_{\gamma}$ is nonzero, this is equivalent to $\mu_1\neq\mu_0$. Therefore the changed-cylinder contribution is

$$ \mathbf{1}[\mu_1\neq\mu_0]K_z(\Gamma). $$

Combining the affine indicator, changed slopes, base cylinders, and changed cylinders gives

$$ \mathrm{sactc}(F) \leq \eta_G(A) + \mathbf{1}[\mu_0\neq0]K(\Gamma) + \mathbf{1}[\mu_1\neq\mu_0] \bigl(\lvert L(A)\rvert+K_z(\Gamma)\bigr). $$

The split affine-cylinder cost theorem also gives

$$ H^{\ast}(F) \leq \mathrm{actc}(F) \leq \mathrm{sactc}(F), $$

so the full displayed chain follows.

If the right-hand side is at most $2$, then $\mathrm{sactc}(F)\leq2$. The exact case split follows from [112_split_affine_cylinder_cost.md](112_split_affine_cylinder_cost.md). $\blacksquare$

## Consequences

When all cylinder supports are positive monomials, so $\gamma=(P,\varnothing)$, one has

$$ K(\Gamma)=K_z(\Gamma)=\lvert\Gamma\rvert. $$

Thus this lemma recovers the one-bit sparse-PTF branching bound [080_one_bit_sparse_ptf_branching.md](080_one_bit_sparse_ptf_branching.md) after replacing the nonlinear monomial support by positive cylinders.

The advantage is for mixed-literal cylinders. If a feature has a short affine-cylinder score with cheap local cylinder corrections, one-bit gates over that feature inherit the same local costs instead of paying for a full positive-monomial expansion.
