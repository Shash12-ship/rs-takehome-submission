# Problem Statement: Head Complexity of Boolean Functions in One-Layer Attention

## Goal

We want to characterize the minimum number of attention heads required to compute a Boolean function

$$f : \lbrace 0,1 \rbrace^n \to \lbrace 0,1 \rbrace$$

in a **single-layer attention-only transformer** with a **linear readout** from a designated query token.

The motivating example is that, in the 2-bit setting, a single head can linearly realize functions such as $\mathrm{AND}$ and $\mathrm{OR}$, but cannot realize $\mathrm{XOR}$, while two heads suffice. This suggests that the number of heads may define a meaningful complexity measure for Boolean functions.

## Model

We fix the following architecture.

- **Input:** a sequence consisting of $n$ input bits and one dedicated query token `=`.
- **Embedding:** token embeddings plus positional embeddings.
- **Computation:** a *single self-attention layer* with $H$ parallel heads and no MLP.
- **Output:** the residual stream at the query token after the attention update.
- **Readout:** a linear probe (equivalently, a thresholded affine functional) applied to that query residual.

A Boolean function $f$ is said to be **computable with $H$ heads** if there exists a choice of embeddings, attention parameters, and linear readout such that the resulting classifier equals $f$ on all inputs in $\lbrace 0,1 \rbrace^n$.

## Main Quantity

Define

$$H^{\ast}(f) := \min \left\lbrace H : f \text{ is computable with } H \text{ heads in the above model} \right\rbrace.$$

Our central problem is to understand $H^{\ast}(f)$ as a function of $f$.

## Core Questions

1. **Exact characterization.** Can $H^{\ast}(f)$ be expressed, exactly or approximately, in terms of a known invariant of $f$?
2. **Lower bounds.** What techniques prove that a function requires at least $H$ heads?
3. **Upper bounds.** Can we constructively realize broad classes of Boolean functions with few heads?
4. **Comparison to classical complexity measures.** How does $H^{\ast}(f)$ relate to:
   - threshold degree,
   - rational degree,
   - threshold density / sparsity,
   - circuit depth / threshold-circuit complexity,
   - Fourier or spectral complexity measures?
5. **Natural families.** What is $H^{\ast}(f)$ for standard functions such as:
   - $\mathrm{AND}$, $\mathrm{OR}$,
   - parity / $\mathrm{XOR}$,
   - majority,
   - exact-count / symmetric functions,
   - address / indexing functions,
   - intersections of threshold functions?

## Desired Outcome

We would like to identify either:

- an invariant $I(f)$ such that $H^{\ast}(f)$ is controlled by $I(f)$ (ideally $H^{\ast}(f) \asymp I(f)$ on broad classes), or
- explicit function families for which the head complexity exhibits qualitatively new behavior compared to classical measures.

In short:

> **What is the right notion of Boolean-function complexity captured by the minimum number of attention heads in one-layer attention with a linear readout?**
