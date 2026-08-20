# Literature Survey

## Results Most Relevant For Upper Bounds

The papers below are the ones most likely to help with the upper-bound side of the project.

### 1. Weiss, Goldberg, and Yahav 2021. Thinking Like Transformers

Source: [PMLR](https://proceedings.mlr.press/v139/weiss21a.html)

Weiss, Goldberg, and Yahav introduce RASP as a programming language for transformer encoders. Their examples include histograms, sorting, and Dyck languages, and the RASP viewpoint makes constructions look like explicit sequence statistics followed by simple post-processing.

**Why it matters here.** This is the cleanest conceptual guide for upper bounds in this repo. It suggests that the right approach is not black-box universality, but rather:

- identify a low-cardinality statistic of the input,
- make attention compute that statistic or a basis of functions of that statistic,
- finish by interpolation in the readout.

That is exactly the shape of the weighted-sum interpolation proof in [theorems/01_foundations_and_normal_form/009_weighted_sum_upper_bound.md](theorems/01_foundations_and_normal_form/009_weighted_sum_upper_bound.md).

### 2. Yang and Chiang 2024. Counting Like Transformers: Compiling Temporal Counting Logic Into Softmax Transformers

Source: [arXiv](https://arxiv.org/abs/2404.04393)

Yang and Chiang show that temporal counting logic formulas can be compiled into future-masked soft attention transformers.

**Why it matters here.** This is the strongest nearby evidence that softmax attention is naturally suited to count-like constructions. It supports trying to upper-bound $H^{\ast}(f)$ by the complexity of a small collection of counting statistics rather than by generic universality arguments.

### 3. Kajitsuka and Sato 2024. Are Transformers with One Layer Self-Attention Using Low-Rank Weight Matrices Universal Approximators?

Source: [OpenReview](https://openreview.net/forum?id=nJnky5K944)

Kajitsuka and Sato show that one-layer, single-head self-attention with low-rank weight matrices can memorize finite samples, and that adding two feedforward networks yields universal approximation for continuous permutation-equivariant functions on compact domains.

**Why it matters here.** This is one of the closest positive expressivity results for shallow attention. It says one-layer attention can already do a lot of contextual identification. The limitation for us is that the theorem uses a more permissive architecture than [model.md](model.md), especially because the feedforward layers and the continuous approximation setting do real work.

### 4. Likhosherstov, Choromanski, and Weller 2021. On the Expressive Power of Self-Attention Matrices

Source: [arXiv](https://arxiv.org/abs/2106.03764)

Likhosherstov, Choromanski, and Weller show that fixed self-attention parameters can approximate broad families of sparse attention matrices by varying the inputs, with hidden size only logarithmic in the sequence length.

**Why it matters here.** This paper isolates what the attention matrix itself can encode before the readout is applied. For upper bounds, it suggests looking for constructions where the attention matrix is doing structured routing or sparse selection, while the final linear probe only decodes a low-dimensional summary.

### 5. Paturi 1992. On the Degree of Polynomials that Approximate Symmetric Boolean Functions

Source: [PDF](https://cseweb.ucsd.edu/~paturi/myPapers/pubs/Paturi_1992_stoc.pdf)

Paturi gives matching upper and lower bounds for the approximate degree of symmetric Boolean functions, using symmetrization to reduce the problem to one variable.

**Why it matters here.** This is the classical guide for any symmetric-family upper bound. The repo already reduces symmetric functions to Hamming weight exactly. Paturi says that once a function depends only on $|x|$, the right next move is usually to work with a one-variable surrogate. Our new weighted-sum upper bound is an exact, attention-level analogue of that strategy.

### 6. Nisan and Szegedy 1994. On the Degree of Boolean Functions as Real Polynomials

Source: [Computational Complexity summary](https://cris.huji.ac.il/en/publications/on-the-degree-of-boolean-functions-as-real-polynomials-14)

Nisan and Szegedy show that exact degree, approximate degree, and decision-tree complexity are polynomially related up to known losses.

**Why it matters here.** This gives a map of the classical landscape. If head complexity eventually turns out to be controlled by degree-like quantities, then decision trees and related combinatorial measures automatically become relevant comparison points.

### 7. Klivans and Servedio 2004. Learning DNF in Time 2^Õ(n^(1/3))

Source: [journal page](https://www.sciencedirect.com/science/article/pii/S0022000003001363), [author page](https://www.cs.columbia.edu/~rocco/papers/stoc01.html)

Klivans and Servedio show that every $s$-term DNF has a polynomial threshold representation of degree

$$O(n^{1/3} \log s).$$

**Why it matters here.** This is exactly the kind of structural upper bound one would like to import into head complexity. Right now we only know

$$\deg_{\pm}(f) \leq H^{\ast}(f),$$

not the reverse implication. But if some partial converse is ever proved for the attention model, this paper would immediately turn sparse DNF formulas into strong head upper bounds.

### 8. Sherstov 2018. Algorithmic Polynomials

Source: [ECCC](https://eccc.weizmann.ac.il/report/2018/010/)

Sherstov gives explicit constructive approximate polynomials for several Boolean families, including $k$-DNF and $k$-CNF, with degree

$$O\left(n^{1-\frac{1}{k+1}}\right).$$

**Why it matters here.** The main attraction is constructive form. If we want upper bounds rather than just existential comparisons, explicit approximants are much more usable than generic existence theorems. The limitation is that the paper is about approximation, whereas our model computes Boolean functions exactly.

### 9. Iyer et al. 2023. On the Rational Degree of Boolean Functions and Applications

Source: [arXiv](https://arxiv.org/abs/2310.08004)

Iyer, Jain, Kothari, Kovacs-Deak, Kumar, Schaeffer, Wang, and Whitmeyer study exact rational degree. They show, among other things, that symmetric and unate families have substantial rational degree, and they derive bounds for read-once formulas.

**Why it matters here.** Our model naturally produces sums of ratios of affine functions, so rational degree is a more native comparison measure than polynomial degree alone. This paper is the strongest indication that rational representations should stay in view as a candidate invariant for upper and lower bounds on $H^{\ast}(f)$.

### Immediate Lessons For This Repo

The literature currently points to four plausible upper-bound routes.

1. **Low-cardinality statistic route.** Make the network depend only on a statistic with small image, then interpolate. This is the route currently realized in [theorems/01_foundations_and_normal_form/009_weighted_sum_upper_bound.md](theorems/01_foundations_and_normal_form/009_weighted_sum_upper_bound.md).
2. **Rational-function route.** Because each head contributes a ratio of affine functions after scalar readout, rational degree looks like a more natural target invariant than polynomial degree.
3. **PTF import route.** Structural upper bounds for polynomial threshold functions of DNF, CNF, and formula classes are potentially relevant, but only if we can show a converse from low-degree sign representations to few-head constructions on some class.
4. **Exactification route.** Approximate-degree results are inspirational, especially for symmetric and formula families, but they do not by themselves answer exact computation in the model from [model.md](model.md).

## Scope

This note records papers that are closest to the project question:

$$f : \lbrace 0,1\rbrace^n \to \lbrace 0,1\rbrace$$

computed exactly by a one-layer attention-only model with a linear readout from a designated query token.

Most transformer expressivity papers study a different regime. Typical differences are:

- unbounded input length rather than a fixed Boolean cube,
- multiple layers rather than one layer,
- feedforward blocks, hard attention, or finite-precision assumptions,
- approximation or language recognition rather than exact Boolean computation,
- depth or precision as the main resource rather than the number of heads.

So the literature is useful mainly for orientation, candidate invariants, and construction ideas, not as a direct answer to the quantity $H^{\ast}(f)$ from [problem_statement.md](problem_statement.md) and [model.md](model.md).

## Broad Expressivity And Universality

### Yun et al. 2020. Are Transformers universal approximators of sequence-to-sequence functions?

Source: [OpenReview](https://openreview.net/forum?id=ByxRM0Ntvr)

Yun, Bhojanapalli, Rawat, Reddi, and Kumar prove that transformer networks are universal approximators of continuous sequence-to-sequence functions on compact domains. Their proof highlights distinct roles for self-attention and feedforward layers, and shows that positional encodings remove permutation-equivariance restrictions.

**Relevance.** This is the standard positive result showing that transformers are expressive in principle. It does not address our exact setting, because the proof uses a richer architecture than one-layer attention-only and studies approximation of continuous maps rather than exact Boolean computation.

### Pérez et al. 2021. Attention is Turing-Complete

Source: [JMLR](https://www.jmlr.org/papers/v22/20-302.html)

Pérez, Barceló, and Marinkovic show that transformers with hard attention are Turing complete under arbitrary precision. The point is to understand algorithmic expressivity of the full architecture, not exact head count in shallow softmax attention.

**Relevance.** This is a useful contrast result. It shows that very strong expressivity is possible once one allows a more permissive setting. It does not give an upper bound that survives our stripped-down model.

## Formal-Language Limits And Logical Characterizations

### Hahn 2020. Theoretical Limitations of Self-Attention in Neural Sequence Models

Source: [ACL Anthology](https://aclanthology.org/2020.tacl-1.11/)

Hahn proves strong limitations for fixed-depth self-attention on formal languages. In particular, periodic finite-state languages and hierarchical structure are out of reach unless the number of heads or layers grows with input length.

**Relevance.** This is strong evidence that parity-like behavior is genuinely constrained in shallow attention. But the paper studies asymptotic language recognition with input length growing, not exact computation on a fixed cube $\lbrace 0,1\rbrace^n$.

### Bhattamishra et al. 2020. On the Computational Power of Transformers and Its Implications in Sequence Modeling

Source: [ACL Anthology](https://aclanthology.org/2020.conll-1.37/)

Bhattamishra, Patel, and Goyal analyze Turing-completeness of transformers and identify which architectural components matter. One message is that residual structure is crucial in their completeness proofs.

**Relevance.** This helps separate what comes from self-attention alone from what comes from the rest of the transformer block. It does not produce a head-count formula for our one-layer attention-only model.

### Chiang et al. 2023. Tighter Bounds on the Expressivity of Transformer Encoders

Source: [OpenReview](https://openreview.net/forum?id=XKcogevHj8)

Chiang, Cholak, and Pillay connect transformer encoders to a logic with counting quantifiers, tightening prior upper and lower bounds for fixed-precision encoders.

**Relevance.** This is conceptually close to the repo's fourth core question, because it connects transformer computation to better-understood logical and circuit-style formalisms. The limitation is again that the setting is fixed-precision encoders over unbounded lengths, not exact head complexity on a fixed Boolean cube.

### Merrill and Sabharwal 2023. A Logic for Expressing Log-Precision Transformers

Source: [OpenReview](https://openreview.net/forum?id=uR8TtWCIsr)

Merrill and Sabharwal show that log-precision transformer classifiers admit a logical characterization with majority quantifiers. They also emphasize that finite-precision transformers are too weak to model broad uniform attention.

**Relevance.** This is another useful bridge to threshold-circuit style reasoning. It supports comparing our head complexity to threshold-like complexity measures, but it still does not isolate the one-layer softmax model from [model.md](model.md).

## Constructive Attention And Counting

### Weiss et al. 2021. Thinking Like Transformers

Source: [PMLR](https://proceedings.mlr.press/v139/weiss21a.html)

Weiss, Goldberg, and Yahav introduce RASP as a programming language for transformer encoders. Their examples include histograms, sorting, and Dyck languages, and the RASP viewpoint helps reason about how many layers and heads a construction needs.

**Relevance.** This is the most useful constructive mindset for the current repo. It suggests that head upper bounds should come from explicit summary statistics and interpolation schemes, not from black-box universality.

### Likhosherstov et al. 2021. On the Expressive Power of Self-Attention Matrices

Source: [arXiv](https://arxiv.org/abs/2106.03764)

Likhosherstov, Choromanski, and Weller study the self-attention matrix itself. They show that fixed self-attention parameters can approximate arbitrary sparse attention patterns when the inputs are chosen appropriately, with hidden dimension growing only logarithmically in sequence length.

**Relevance.** This is about attention patterns rather than exact Boolean readout. Still, it is relevant because it isolates what the softmax attention matrix can encode before the final probe is applied.

### Yang and Chiang 2024. Counting Like Transformers: Compiling Temporal Counting Logic Into Softmax Transformers

Source: [arXiv](https://arxiv.org/abs/2404.04393)

Yang and Chiang compile a temporal counting logic into future-masked soft attention transformers. This gives a constructive counting result in a softmax setting.

**Relevance.** This is the closest constructive precedent for the upper-bound route that currently looks promising in the repo. It suggests that count-like statistics are a natural target for softmax attention constructions.

## Closest Recent Parity Reference

### Kozachinskiy et al. 2026. Parity, Sensitivity, and Transformers

Source: [arXiv](https://arxiv.org/abs/2602.05896)

Kozachinskiy, Steifer, and Wałȩga give a parity construction for softmax transformers with length-independent positional encodings and no layer normalization, and they also prove a lower bound showing that parity cannot be solved with one layer and one head.

**Relevance.** This is very close in spirit to the repo. It directly studies parity and a shallow transformer setting. However, it still does not compute the exact quantity $H^{\ast}(\mathrm{XOR}_n)$ for the model in [model.md](model.md), and it does not give a general upper-bound invariant for arbitrary Boolean functions.

## What Seems Missing Relative To This Repo

The survey suggests three gaps.

1. I did not find a prior paper that directly studies the exact minimum head count $H^{\ast}(f)$ for the one-layer attention-only model from [model.md](model.md).

2. Existing upper bounds are usually too coarse for our purpose. They are about universality, Turing-completeness, or logical definability, not exact head complexity on a fixed cube.

3. Existing lower bounds are often asymptotic in input length. They do not automatically convert into finite $n$ exact statements like $H^{\ast}(\mathrm{XOR}_n) = n$.

## Working Takeaway For Upper Bounds

The strongest reusable idea from the literature is constructive counting.

For the current project, the cleanest version is to make heads produce a basis of rational functions of a single positive weighted sum

$$t(x) = \sum_{i=1}^{n} \lambda_i x_i,$$

then interpolate arbitrary target labels on the finite image of $t$.

That is the route taken in [theorems/01_foundations_and_normal_form/009_weighted_sum_upper_bound.md](theorems/01_foundations_and_normal_form/009_weighted_sum_upper_bound.md). It gives:

- a general upper bound when $f$ factors through a positive weighted sum,
- a clean $n$-head upper bound for all symmetric Boolean functions,
- a universal bound $H^{\ast}(f) \leq 2^n - 1$ by taking binary weights.
