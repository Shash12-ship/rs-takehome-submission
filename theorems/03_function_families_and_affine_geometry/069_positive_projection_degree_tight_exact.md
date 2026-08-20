# Positive-Projection Degree-Tight Exactness

## Statement

Let

$$ f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace. $$

Let $C_{+}(f)$ be the minimum positive-projection sign-change count from [013_positive_projection_sign_changes.md](../01_foundations_and_normal_form/013_positive_projection_sign_changes.md). Then

$$ \deg_{\pm}(f) \leq H^{\ast}(f) \leq C_{+}(f). $$

Consequently, if

$$ \deg_{\pm}(f)=C_{+}(f), $$

then

$$ H^{\ast}(f)=\deg_{\pm}(f)=C_{+}(f). $$

More generally, suppose $f$ factors through a positive weighted sum $t$ with sign-change count $C_t(f)$. If

$$ \deg_{\pm}(f)=C_t(f), $$

then

$$ H^{\ast}(f)=C_t(f). $$

Finally, the low-alternation regime is exact. If

$$ C_{+}(f)\leq2, $$

then

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** The positive-projection sign-change count is an exact invariant whenever it meets threshold degree. This turns any matching pair of certificates into an exact value of $H^{\ast}$.

## Proof

The lower bound

$$ \deg_{\pm}(f)\leq H^{\ast}(f) $$

is the threshold-degree lower bound from [006_threshold_degree_head_complexity_bound.md](../01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md). The upper bound

$$ H^{\ast}(f)\leq C_{+}(f) $$

is the positive-projection sign-change theorem [013_positive_projection_sign_changes.md](../01_foundations_and_normal_form/013_positive_projection_sign_changes.md). Therefore, if

$$ \deg_{\pm}(f)=C_{+}(f), $$

then $H^{\ast}(f)$ is trapped between two equal numbers, so

$$ H^{\ast}(f)=\deg_{\pm}(f)=C_{+}(f). $$

The same proof works with any fixed positive projection $t$: if $f$ factors through $t$, then [013_positive_projection_sign_changes.md](../01_foundations_and_normal_form/013_positive_projection_sign_changes.md) gives

$$ H^{\ast}(f)\leq C_t(f). $$

Thus $\deg_{\pm}(f)=C_t(f)$ also forces

$$ H^{\ast}(f)=C_t(f). $$

It remains to record the low-alternation case. If $C_{+}(f)\leq2$, then the positive-projection theorem gives

$$ H^{\ast}(f)\leq2. $$

If $f$ is constant, then $H^{\ast}(f)=0$. If $f$ is a nonconstant LTF, the one-head characterization from [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) gives

$$ H^{\ast}(f)=1. $$

If $f$ is neither constant nor a nonconstant LTF, the same characterization gives

$$ H^{\ast}(f)\geq2. $$

Together with $H^{\ast}(f)\leq2$, this proves

$$ H^{\ast}(f)=2. $$

$\blacksquare$

## Consequences

This lemma gives a reusable proof template:

1. Find a positive projection with $C$ sign changes.
2. Prove $\deg_{\pm}(f)\geq C$.
3. Conclude $H^{\ast}(f)=C$.

The symmetric exact theorem is one instance: the Hamming-weight projection has $C$ sign changes, and symmetric threshold degree is exactly the same $C$.

The one-run positive-order theorem is the first low-alternation instance. One run gives $C_{+}(f)\leq2$, so every nonconstant non-LTF one-run class has exact value $2$.
