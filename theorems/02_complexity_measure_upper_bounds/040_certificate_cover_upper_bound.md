# Certificate-Cover Upper Bound

## Statement

Let

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace. $$

A partial assignment is a pair $(D,\xi)$ with

$$ D\subseteq\lbrace1,\ldots,n\rbrace, \qquad \xi\in\lbrace0,1\rbrace^{D}. $$

Its cylinder is

$$ [D,\xi] := \lbrace x\in\lbrace0,1\rbrace^n : x_i=\xi_i \text{ for every } i\in D\rbrace. $$

Its width is $\lvert D\rvert$, and its volume is

$$ \lvert[D,\xi]\rvert=2^{n-\lvert D\rvert}. $$

A family $\mathcal{C}_1$ of partial assignments is a $1$-certificate cover for $f$ if

$$ f^{-1}(1) \subseteq \bigcup_{(D,\xi)\in\mathcal{C}_1}[D,\xi] \subseteq f^{-1}(1). $$

Equivalently, every cylinder in $\mathcal{C}_1$ is contained in the true set, and the family covers the true set. Define $0$-certificate covers analogously, with $f^{-1}(0)$ in place of $f^{-1}(1)$.

If $\mathcal{C}_1$ is a $1$-certificate cover, then

$$ H^{\ast}(f) \leq 2\sum_{(D,\xi)\in\mathcal{C}_1}2^{n-\lvert D\rvert}. $$

If $\mathcal{C}_0$ is a $0$-certificate cover, then

$$ H^{\ast}(f) \leq 2\sum_{(D,\xi)\in\mathcal{C}_0}2^{n-\lvert D\rvert}. $$

Thus, if

$$ \mathrm{certvol}_b(f) := \min_{\mathcal{C}_b} \sum_{(D,\xi)\in\mathcal{C}_b}2^{n-\lvert D\rvert} $$

where the minimum ranges over all $b$-certificate covers, then

$$ H^{\ast}(f) \leq 2\min\lbrace\mathrm{certvol}_0(f),\mathrm{certvol}_1(f)\rbrace. $$

> **Interpretation.** A small one-sided cover by large-width certificates gives a head upper bound. This packages sparse support and mixed-literal DNF/CNF volume into one invariant.

## Proof

Let $\mathcal{C}_1$ be a $1$-certificate cover. Since the true set is covered by the cylinders,

$$ \lvert f^{-1}(1)\rvert \leq \sum_{(D,\xi)\in\mathcal{C}_1} \lvert[D,\xi]\rvert = \sum_{(D,\xi)\in\mathcal{C}_1}2^{n-\lvert D\rvert}. $$

The sparse-support upper bound [037_sparse_support_upper_bound.md](037_sparse_support_upper_bound.md) gives

$$ H^{\ast}(f) \leq 2\min\lbrace\lvert f^{-1}(1)\rvert,\lvert f^{-1}(0)\rvert\rbrace \leq 2\lvert f^{-1}(1)\rvert. $$

Combining the two inequalities gives

$$ H^{\ast}(f) \leq 2\sum_{(D,\xi)\in\mathcal{C}_1}2^{n-\lvert D\rvert}. $$

The proof for $0$-certificate covers is identical, using

$$ \lvert f^{-1}(0)\rvert \leq \sum_{(D,\xi)\in\mathcal{C}_0}2^{n-\lvert D\rvert} $$

and the sparse-support bound in the form

$$ H^{\ast}(f)\leq2\lvert f^{-1}(0)\rvert. $$

Taking the smaller of the two optimized certificate volumes proves the final display. $\blacksquare$

## Consequence

A DNF term is exactly a $1$-certificate cylinder, and a CNF clause contributes a $0$-certificate cylinder for the inputs that falsify it. Therefore [038_dnf_cnf_volume_upper_bound.md](038_dnf_cnf_volume_upper_bound.md) is a direct corollary.

Singleton certificates recover the sparse-support theorem [037_sparse_support_upper_bound.md](037_sparse_support_upper_bound.md). The certificate-cover view is useful when a label class is not small pointwise but is covered by a few high-codimension subcubes.
