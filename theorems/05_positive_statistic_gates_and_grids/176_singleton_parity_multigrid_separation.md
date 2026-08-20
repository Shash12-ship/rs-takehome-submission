# Singleton Parity Multigrid Separation

## Statement

Let

$$ \mathcal{P}_{\mathrm{sing}}=\lbrace\lbrace1\rbrace,\ldots,\lbrace n\rbrace\rbrace $$

be the singleton partition, and let $f=\mathrm{XOR}_n$. Define

$$ L_n := \sum_{\substack{1\leq \ell\leq n\cr n-\ell\ \mathrm{even}}}2^{\ell-1}. $$

Equivalently,

$$ L_n= \begin{cases} \dfrac{2^{n+1}-1}{3} & \text{if } n \text{ is odd},\cr[6pt] \dfrac{2^{n+1}-2}{3} & \text{if } n \text{ is even}. \end{cases} $$

Then, with $\mathrm{mhc}$ computed for the singleton Hamming profile of parity,

$$ \mathrm{mgc}_{+}^{\mathcal{P}_{\mathrm{sing}}}(\mathrm{XOR}_n) = \mathrm{mhc}(\mathrm{XOR}_n) = L_n, $$

while

$$ H^{\ast}(\mathrm{XOR}_n)=n. $$

Thus the singleton-block multigrid cost can be larger than the true head complexity by a factor

$$ \frac{L_n}{n}. $$

> **Interpretation.** Multigrid cost is a certificate cost, not an exact invariant of $H^{\ast}$. For parity, the singleton partition forces a long binary odometer traversal, while the total Hamming-weight collapse gives the exact $n$-head value.

## Proof

For the singleton partition, every positive block statistic has the form

$$ t_i(x_i)=\lambda_i x_i, \qquad \lambda_i\gt0. $$

Its image is $\lbrace0,\lambda_i\rbrace$. Therefore every lexicographic product-grid traversal is just the usual binary odometer traversal for some coordinate order. The labels for $\mathrm{XOR}_n$ are the parity of the number of coordinates at their nonzero level. The positive weights $\lambda_i$ do not affect these labels.

Fix any coordinate order and number its coordinates $1,\ldots,n$ from slowest to fastest. A transition of type $\ell$ is a transition where coordinate $\ell$ changes from $0$ to $1$, all faster coordinates reset from $1$ to $0$, and the slower coordinates are unchanged.

There are exactly

$$ 2^{\ell-1} $$

transitions of type $\ell$, because the $\ell-1$ slower coordinates are arbitrary.

Across a type $\ell$ transition, the Hamming weight changes by

$$ 1-(n-\ell). $$

Parity flips exactly when this number is odd, equivalently when $n-\ell$ is even. Hence every coordinate order has exactly

$$ \sum_{\substack{1\leq \ell\leq n\cr n-\ell\ \mathrm{even}}}2^{\ell-1} = L_n $$

lexicographic sign changes. This proves both the $\mathrm{mgc}_{+}^{\mathcal{P} _{\mathrm{sing}}}$ value and the singleton Hamming-profile value $\mathrm{mhc}$.

The closed form follows by summing the corresponding geometric progression:

$$ L_n= \begin{cases} 1+4+\cdots+2^{n-1}=\dfrac{2^{n+1}-1}{3} & \text{if } n \text{ is odd},\cr[6pt] 2+8+\cdots+2^{n-1}=\dfrac{2^{n+1}-2}{3} & \text{if } n \text{ is even}. \end{cases} $$

Finally, $\mathrm{XOR}_n$ is symmetric and its Hamming-weight truth table changes at every adjacent pair of weights. The exact symmetric sign-change theorem [012_symmetric_sign_changes.md](../01_foundations_and_normal_form/012_symmetric_sign_changes.md) gives

$$ H^{\ast}(\mathrm{XOR}_n)=n. $$

This proves the separation. $\blacksquare$

## Consequence

For parity, Theorem 175 with the total Hamming-weight projection gives the exact value $n$, while the singleton multigrid certificate costs $L_n$. Coarser positive projections can therefore be essential.
