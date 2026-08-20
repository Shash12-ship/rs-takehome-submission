# Positive Multigrid Cost Invariant

## Statement

Fix a partition $\mathcal{P}$ of the input variables into nonempty blocks

$$ B_1,\ldots,B_b. $$

A positive multigrid certificate for $f$ over $\mathcal{P}$ consists of positive statistics

$$ t_j(x_{B_j})=\sum_{i\in B_j}\lambda_{j,i}x_i, \qquad \lambda_{j,i}\gt0, $$

a Boolean function $F$ on the product of their images, and a block order $\pi$ such that

$$ f(x)=F(t_1(x_{B_1}),\ldots,t_b(x_{B_b})). $$

Let $L_{\pi}(F)$ be the sign-change count of $F$ when the product grid is read lexicographically with the block order $\pi$, slowest to fastest.

Define

$$ \mathrm{mgc}_{+}^{\mathcal{P}}(f) := \min L_{\pi}(F), $$

where the minimum ranges over all positive multigrid certificates over $\mathcal{P}$ and all block orders $\pi$.

Then

$$ H^{\ast}(f)\leq\mathrm{mgc}_{+}^{\mathcal{P}}(f). $$

Also

$$ C_{+}(f)\leq\mathrm{mgc}_{+}^{\mathcal{P}}(f). $$

The invariant is unchanged by output complement and by coordinate permutations that preserve the partition up to relabeling of blocks.

If

$$ \deg_{\pm}(f)=\mathrm{mgc}_{+}^{\mathcal{P}}(f), $$

then

$$ H^{\ast}(f)=\deg_{\pm}(f)=\mathrm{mgc}_{+}^{\mathcal{P}}(f). $$

> **Interpretation.** The multigrid cost is a partition-level positive-projection invariant. It captures the best lexicographic traversal of a product of positive-statistic images.

## Proof

Fix a positive multigrid certificate and block order $\pi$. The positive lexicographic multigrid bound [170_positive_lexicographic_multigrid_bound.md](170_positive_lexicographic_multigrid_bound.md) gives

$$ H^{\ast}(f)\leq L_{\pi}(F). $$

Minimizing proves

$$ H^{\ast}(f)\leq\mathrm{mgc}_{+}^{\mathcal{P}}(f). $$

The proof of Theorem 170 constructs one positive statistic on all variables whose ordered label sequence is exactly the chosen lexicographic grid traversal. Hence, for every certificate and order,

$$ C_{+}(f)\leq L_{\pi}(F). $$

Taking the minimum gives

$$ C_{+}(f)\leq\mathrm{mgc}_{+}^{\mathcal{P}}(f). $$

For output complement, keep the same positive statistics and block order, and replace $F$ by $1-F$. This preserves the sign-change count $L_{\pi}(F)$. Therefore the minimum is unchanged.

For coordinate permutations preserving the partition up to relabeling, transport each block statistic by the coordinate permutation and relabel the blocks. The feasible grid sequences and their lexicographic sign-change counts are unchanged.

Finally, if threshold degree equals the multigrid cost, then

$$ \mathrm{mgc}_{+}^{\mathcal{P}}(f) = \deg_{\pm}(f) \leq H^{\ast}(f) \leq \mathrm{mgc}_{+}^{\mathcal{P}}(f), $$

so all three quantities are equal. $\blacksquare$

## Consequence

The positive-grid cost $\mathrm{pgc}_{+}^{z\mid y}$ is the two-block special case where the block order is optimized over the two possible orders.
