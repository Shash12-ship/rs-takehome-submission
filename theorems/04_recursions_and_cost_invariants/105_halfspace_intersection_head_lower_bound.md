# Halfspace Intersections Force Many Heads

## Statement

There are an absolute constant $c\gt0$ and an infinite family of pairs of linear threshold functions

$$ T_n,U_n:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace $$

such that, for

$$ F_n(x):=T_n(x)\wedge U_n(x), $$

one has

$$ H^{\ast}(F_n)\geq c n. $$

> **Interpretation.** Even the intersection of two halfspaces can require linearly many attention heads. The obstruction is not Boolean formula size, but threshold degree.

## Proof

Sherstov's optimal halfspace-intersection theorem [Optimal bounds for sign-representing the intersection of two halfspaces by polynomials](https://arxiv.org/abs/0910.4224) gives an absolute constant $c\gt0$ and an infinite family of pairs of halfspaces

$$ T_n,U_n:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace $$

such that

$$ \deg_{\pm}(T_n\wedge U_n)\geq c n. $$

Apply the threshold-degree lower bound [006_threshold_degree_head_complexity_bound.md](../01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md), which gives

$$ \deg_{\pm}(f)\leq H^{\ast}(f) $$

for every Boolean function $f$. With $F_n=T_n\wedge U_n$, this yields

$$ H^{\ast}(F_n) \geq \deg_{\pm}(F_n) \geq c n. $$

$\blacksquare$

## Consequences

This family is a sharp warning against treating linear threshold gates as raw attention-head features. Each $T_n$ and $U_n$ has head complexity one after thresholding, but their raw indicators cannot both be cheaply calibrated in a two-feature vote. Otherwise Lemma 95 would contradict the displayed threshold-degree lower bound.

The theorem also gives a clean lower-bound benchmark for future upper-bound invariants: any invariant that always upper-bounds $H^{\ast}$ must assign linear cost to at least some intersections of two halfspaces.
