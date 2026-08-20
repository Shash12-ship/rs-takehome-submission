# Low Affine-Cylinder Cost Is Exact

## Statement

If

$$ \mathrm{actc}(f)\leq2, $$

then

$$ H^{\ast}(f) = \begin{cases} 0, & \text{if } f \text{ is constant},\cr 1, & \text{if } f \text{ is a nonconstant LTF},\cr 2, & \text{otherwise}. \end{cases} $$

In particular, every nonconstant non-LTF with $\mathrm{actc}(f)\leq2$ is exactly two-head.

> **Interpretation.** Once the affine-cylinder certificate reaches two heads, the only remaining question is the universal zero-head and one-head split.

## Proof

Lemma 103 gives

$$ H^{\ast}(f)\leq\mathrm{actc}(f). $$

Thus the hypothesis implies

$$ H^{\ast}(f)\leq2. $$

The exact zero-head and one-head characterization from [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) says:

- $H^{\ast}(f)=0$ exactly for constant functions,
- $H^{\ast}(f)=1$ exactly for nonconstant LTFs,
- every nonconstant non-LTF has $H^{\ast}(f)\geq2$.

Combining this lower split with the upper bound $H^{\ast}(f)\leq2$ proves the displayed case distinction. $\blacksquare$

## Consequences

This upgrades any low-cost affine-cylinder representation into an exact head count. In particular, every nonconstant non-LTF that can be written as a strict threshold of one affine score plus locally cheap cylinders of total cost at most one is exactly two-head.

Since

$$ \mathrm{actc}(f) \leq \min\lbrace\mathrm{ctc}(f),\mathrm{afs}_{\pm}(f)\rbrace, $$

the same exactness conclusion applies whenever either $\mathrm{ctc}(f)\leq2$ or $\mathrm{afs}_{\pm}(f)\leq2$.
