# Decision-Tree Leaf-Profile Upper Bound

## Statement

Let $\mathcal{T}$ be a deterministic decision tree computing

$$ f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace. $$

For a leaf $\ell$, let $P_\ell$ be the set of variables fixed to $1$ along the root-to-leaf path, and let $N_\ell$ be the set of variables fixed to $0$ along that path. Let $\mathcal{L}_1$ and $\mathcal{L}_0$ be the leaves labeled $1$ and $0$.

Then

$$ H^{\ast}(f) \leq \min\left\lbrace \sum_{\ell\in\mathcal{L}_1}2^{\lvert P_\ell\rvert}, \sum_{\ell\in\mathcal{L}_1}2^{\lvert N_\ell\rvert}, \sum_{\ell\in\mathcal{L}_0}2^{\lvert P_\ell\rvert}, \sum_{\ell\in\mathcal{L}_0}2^{\lvert N_\ell\rvert} \right\rbrace. $$

In particular, if $\mathcal{T}$ has depth at most $d$, then

$$ H^{\ast}(f) \leq 2^d\min\lbrace\lvert\mathcal{L}_0\rvert,\lvert\mathcal{L}_1\rvert\rbrace. $$

If $f$ is nonconstant and has deterministic decision-tree depth $D(f)=d\geq1$, then

$$ H^{\ast}(f)\leq2^{2d-1}. $$

> **Interpretation.** Adaptive decision structure gives a head upper bound controlled by the signed leaf profile, independent of the ambient number of variables except through the variables actually queried on paths.

## Proof

Each $1$-leaf $\ell\in\mathcal{L}_1$ contributes the mixed-literal certificate term

$$ T_\ell(x) := \left(\prod_{i\in P_\ell}x_i\right) \left(\prod_{j\in N_\ell}(1-x_j)\right). $$

The accepting leaves partition $f^{-1}(1)$, so

$$ f(x)=\bigvee_{\ell\in\mathcal{L}_1}T_\ell(x). $$

Applying the DNF literal-expansion upper bound [042_dnf_cnf_literal_expansion_upper_bound.md](042_dnf_cnf_literal_expansion_upper_bound.md) gives

$$ H^{\ast}(f) \leq \min\left\lbrace \sum_{\ell\in\mathcal{L}_1}2^{\lvert P_\ell\rvert}, \sum_{\ell\in\mathcal{L}_1}2^{\lvert N_\ell\rvert} \right\rbrace. $$

Similarly, the rejecting leaves give

$$ 1-f(x)=\bigvee_{\ell\in\mathcal{L}_0}T_\ell(x). $$

The same DNF bound applied to $1-f$ gives

$$ H^{\ast}(1-f) \leq \min\left\lbrace \sum_{\ell\in\mathcal{L}_0}2^{\lvert P_\ell\rvert}, \sum_{\ell\in\mathcal{L}_0}2^{\lvert N_\ell\rvert} \right\rbrace. $$

Complement invariance from [028_restrictions_and_sign_rank.md](028_restrictions_and_sign_rank.md) gives $H^{\ast}(f)=H^{\ast}(1-f)$, so the four-term minimum follows.

If the tree has depth at most $d$, then for every leaf

$$ \lvert P_\ell\rvert\leq d, \qquad \lvert N_\ell\rvert\leq d. $$

Therefore

$$ \sum_{\ell\in\mathcal{L}_b}2^{\lvert P_\ell\rvert} \leq 2^d\lvert\mathcal{L}_b\rvert, \qquad \sum_{\ell\in\mathcal{L}_b}2^{\lvert N_\ell\rvert} \leq 2^d\lvert\mathcal{L}_b\rvert $$

for $b\in\lbrace0,1\rbrace$, proving

$$ H^{\ast}(f) \leq 2^d\min\lbrace\lvert\mathcal{L}_0\rvert,\lvert\mathcal{L}_1\rvert\rbrace. $$

Finally, a depth $d$ binary decision tree has at most $2^d$ leaves. If $f$ is nonconstant, both labels occur, so

$$ \min\lbrace\lvert\mathcal{L}_0\rvert,\lvert\mathcal{L}_1\rvert\rbrace \leq 2^{d-1}. $$

Thus

$$ H^{\ast}(f)\leq2^d2^{d-1}=2^{2d-1}. $$

$\blacksquare$

## Consequence

If a function is computed by a shallow decision tree, then its head complexity is bounded in terms of the tree depth alone:

$$ H^{\ast}(f)\leq2^{2D(f)-1} $$

for every nonconstant $f$ with $D(f)\geq1$.

The leaf-profile bound can be sharper. If all accepting leaves have at most $r$ negative literals after choosing the original orientation, then

$$ H^{\ast}(f)\leq\lvert\mathcal{L}_1\rvert 2^r. $$

The analogous statements hold for rejecting leaves and after the global bit flip.
