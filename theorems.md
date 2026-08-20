# Theorems Toward The First Core Question

## Goal

We want a step-by-step route to the first core question in [problem_statement.md](problem_statement.md):

> Can $H^{\ast}(f)$ be expressed, exactly or approximately, in terms of a known invariant of $f$?

This file is the statement ledger. It records the current lemma and theorem statements, how they fit together, and where each proof lives under `theorems/`.

For nearby literature and context, see [literature_survey.md](literature_survey.md).

## Current Status

The current notes do **not** yet give an exact characterization of $H^{\ast}(f)$ for all Boolean functions.

What they *do* give is:

- a structural one-head lower bound via checkerboard restrictions,
- an exact normal form as a thresholded sum of one-head linear-fractional atoms,
- an exact characterization of the zero-head and one-head levels,
- an exact characterization of all symmetric Boolean functions by sign changes,
- a sharper positive-projection sign-change upper bound,
- Boolean closure for functions sharing one positive projection statistic,
- a two-head upper bound for all three-bit quadratic threshold functions,
- an exact classification of all three-bit Boolean functions by threshold degree,
- an exact integer-certificate classification of all Boolean functions through four bits, with head complexity equal to threshold degree,
- an exact two-head classification of every five-bit function of threshold degree two,
- an exact four-head classification of every five-bit function of threshold degree four,
- an exact match between three-bit head complexity and threshold-vote size,
- exact threshold-vote and head complexity two for equality on two strings,
- a four-head universal upper bound for all four-bit Boolean functions,
- a seven-head universal upper bound for all five-bit Boolean functions,
- an eleven-head universal upper bound for all six-bit Boolean functions,
- a nineteen-head universal upper bound for all seven-bit Boolean functions,
- a determinant-span schema explaining this class of universal upper bounds,
- a degree-restricted determinant-span schema for threshold-degree classes,
- a thirty-two-head universal upper bound for all eight-bit Boolean functions,
- a fifty-seven-head universal upper bound for all nine-bit Boolean functions,
- a 103-head universal upper bound for all ten-bit Boolean functions,
- a compact determinant-threshold certificate through twelve bits,
- a counting lower bound showing that almost all $n$-bit functions need $\Omega(2^n/n^2)$ heads,
- exact complexity for affine parities on any support,
- exact threshold degree and explicit head bounds for inner product mod $2$,
- exact threshold degree and explicit head bounds for equality,
- exact head complexity for equality on all string lengths,
- a degree-tight positive-projection exactness criterion,
- exact constant, one-head, or two-head classification for affine level-set predicates,
- exact constant, one-head, or two-head classification for affine slab predicates,
- an orientation-free affine-statistic sign-change upper bound,
- exact head complexity for the standard three-pair endpoint families,
- upper and lower bounds for all intersection-profile predicates,
- upper and lower bounds for all Hamming-distance profile predicates,
- upper and lower bounds for all directed-defect profile predicates,
- exact head complexity for two-pair containment and noncontainment,
- exact classification of two-pair local-count threshold profiles,
- a local-pattern count profile schema subsuming the profile bounds,
- a proof that parity and its complement are the only functions of threshold degree $n$,
- a Fourier-tail criterion for certifying low threshold degree,
- a polynomial-threshold sparsity upper bound,
- an affine-free polynomial-threshold sparsity upper bound,
- an exact classification for affine-free support cost at most two,
- a Fourier support-cost head upper bound,
- DNF and CNF width as threshold-degree upper bounds,
- a denominator-orientation characterization for one-head atoms,
- restriction monotonicity, junta invariance, and a partition sign-rank lower-bound route,
- a dimension ceiling for the degree-only partition sign-rank bound, together with a sharper two-head factorization that surpasses that ceiling,
- explicit quadratic strict separations on $56$, $43$, $12$, $11$, $9$, and $8$ bits, with threshold degree two and head complexity at least three,
- monotone DNF and CNF upper bounds using one head per term or clause,
- a monotone antichain upper bound via minimal true sets and maximal false sets,
- a monotone counting lower bound showing the antichain upper bound is polynomially sharp,
- a positive-order run-count upper bound refining sparse support,
- an exact classification for one-run positive-order label classes,
- a sparse-support upper bound for functions with a small minority label class,
- an exact sparse-support classification when the minority label class has size at most two,
- a two-head criterion for affine-hull clean label classes,
- a DNF/CNF volume upper bound for arbitrary mixed-literal formulas,
- a DNF/CNF literal-expansion upper bound for formulas close to monotone,
- a hybrid DNF/CNF upper bound combining volume, local expansion, used-variable juntas, and width-degree sparsity,
- a decision-tree leaf-profile upper bound,
- an exact classification for depth-two decision trees,
- a hybrid decision-tree upper bound combining leaf profiles, queried-variable juntas, and depth-degree sparsity,
- a cofactor sparse-polynomial recursion for inductive upper bounds,
- an affine-free cofactor recursion that gives linear bounds for functions with LTF cofactors,
- an LTF cofactor slope-distance upper bound with exact control at slope distance at most one,
- a split LTF slope invariant minimizing this bound over coordinates and separator choices,
- a split affine-free support invariant for sparse cofactors with small coefficient-change sets,
- a one-bit LTF branching upper bound for arbitrary gates of one raw bit and one LTF feature,
- a one-bit sparse-PTF branching upper bound for arbitrary gates of one raw bit and one sparse PTF feature,
- a one-bit non-XOR recursion theorem for arbitrary inner features,
- a literal decision-list upper bound with one head per tested literal,
- an endpoint decision-list upper bound with one head per endpoint test,
- a calibrated decision-list upper bound for tests with one-head atom indicator approximations,
- an internal LTF indicator obstruction showing that LTF computation is not the same as calibrated indicator approximation,
- a sharp $1/4$ one-atom indicator-approximation infimum for that internal LTF,
- a raw-calibrated vote upper bound controlled by raw atom approximation costs and exact affine-free support,
- a raw-calibrated decision-list upper bound controlled by the same per-test costs,
- a threshold-degree lower-bound schema for raw calibration costs in strict votes,
- a subcube raw-calibration upper bound controlled by local literal orientation,
- basic invariances and restriction monotonicity for raw calibration cost,
- a subcube-threshold vote upper bound for strict real votes over cylinder indicators,
- an optimized cylinder-threshold cost invariant upper-bounding $H^{\ast}$,
- structural invariances and restriction monotonicity for the cylinder-threshold cost,
- a subsumption theorem showing $\mathrm{ctc}$ recovers local certificate, formula, and decision-tree bounds,
- a comparison theorem placing $\mathrm{ctc}$ below polynomial-threshold sparsity,
- an affine-cylinder threshold cost invariant that allows one dense affine component,
- a hierarchy theorem placing the affine-cylinder cost below both $\mathrm{ctc}$ and affine-free sparsity,
- an explicit linear head lower-bound family from intersections of two halfspaces,
- a formal separation between $H^{\ast}$ and constant threshold-vote or LTF decision-list size,
- a linear worst-case lower bound for raw calibration cost among LTF indicators,
- structural invariances and restriction monotonicity for the affine-cylinder cost,
- exact $0$, $1$, or $2$ classification for functions with affine-cylinder cost at most two,
- a threshold-degree sandwich for $\mathrm{actc}$ and the surrounding sparsity costs,
- an affine-cylinder cofactor interpolation rule that pays only for changed affine slopes and changed cylinder coefficients,
- an optimized lifted literal-gating cost for non-XOR one-bit gates,
- a sharp case split for every non-XOR and non-XNOR gate over a fresh bit,
- an optimized fresh-bit XOR target cost whose equality with threshold degree gives exactness,
- structural invariances and restriction monotonicity for the optimized one-bit costs,
- exact two-head fresh-bit XOR for positive endpoint OR-type and AND-type features,
- exact two-head fresh-bit XOR for arbitrary nonconstant affine endpoint features,
- exact one-bit gate classification for affine endpoint features,
- exact one-bit gate classification for arbitrary nonconstant LTF features,
- an affine-statistic sign-change upper bound for fresh XOR,
- a sharper positive-projection sign-change upper bound for fresh XOR,
- a positive-projection sign-change upper bound for arbitrary one-bit gates,
- exact literal-gate behavior for internal positive slabs,
- a two-head span theorem for strict quadratics in one positive statistic and one raw bit,
- a three-head span theorem for strict cubics in one positive statistic and one raw bit,
- a degree-sensitive span theorem for one positive statistic coupled to one raw bit,
- a complete exact one-bit gate table for internal positive slabs,
- a sharper fresh-XOR sign-change upper bound for all positive-statistic features,
- a sharper non-XOR gate sign-change upper bound for all positive-statistic features,
- an exact one-bit gate table for threshold-degree-tight positive-statistic features,
- an exact one-bit gate table for arbitrary symmetric features,
- a one-bit gate sandwich for positive-statistic features,
- a one-bit gate sandwich using the optimized positive-order invariant $C_{+}$,
- a multi-slice upper bound for raw-bit slices sharing one positive statistic,
- a degree-sensitive upper bound for one positive statistic coupled to many raw bits,
- an ordered multi-slice bound that pays only for actual boundary jumps,
- a multi-raw gate bound over one positive-statistic feature,
- an optimized ordered-slice invariant for shared positive-statistic slices,
- a degree-sensitive ordered-slice bound that keeps the actual boundary cost,
- an optimized mixed-boundary bound for multi-raw gates over one positive-statistic feature,
- an equal-endpoint multi-raw gate bound using raw positive-order variation,
- a mixed-boundary inequality converting endpoint mismatch into raw variation plus feature-dependent support,
- endpoint-sensitive bounds for conjunction, disjunction, and XOR with a raw mask,
- a theorem-scale sandwich for multi-raw gates over one positive-statistic feature, with an exact single-dependent-slice criterion,
- an address-localization theorem showing when a solved positive-statistic feature can be hidden behind one raw address at no extra head cost,
- a few-run raw-mask theorem converting positive-order raw alternation into concrete mask-gate bounds,
- a shared-statistic slice sandwich for arbitrary raw-slice families, with an optimized endpoint-boundary term,
- a shared-statistic degree sandwich combining slice threshold degree lower bounds with univariate degree upper bounds,
- an addressed common-endpoint direct-sum theorem for placing several solved features at raw addresses with additive head cost,
- an endpoint-variation theorem bounding mixed endpoint coupling by raw endpoint runs and endpoint disagreement,
- a positive-concatenation exactness criterion turning matching threshold degree into exact head complexity,
- an endpoint-coupled slice-cost invariant that sharpens ordered-slice cost and preserves complement and coordinate symmetries,
- a sparse-slice endpoint-coupled theorem controlling functions with few nonconstant raw slices,
- a positive-grid slice sandwich paying by raw statistic levels rather than raw assignments,
- a positive-grid degree and exactness theorem,
- a Hamming-layer positive-grid bound for raw blocks used only through Hamming weight,
- a sparse raw-level positive-grid theorem for functions active on few raw statistic levels,
- a positive-grid cost invariant with complement and coordinate symmetries,
- a lexicographic multigrid theorem for functions of several positive statistics,
- a multi-Hamming-profile bound for functions of several Hamming weights,
- a multigrid run bound for sparse or interval-like behavior on a profile grid,
- a positive multigrid cost invariant for any fixed block partition,
- a block-order Hamming-profile cost for multiblock profile predicates,
- a positive profile-projection collapse theorem for weighted Hamming profiles,
- a singleton parity separation showing multigrid cost can be much larger than $H^{\ast}$,
- a two-head theorem for singleton points in a two-block Hamming grid,
- a two-head theorem for affine line layers in a two-block Hamming grid,
- a two-head theorem for affine strips in a two-block Hamming grid,
- an exact threshold-degree amplification theorem for XOR with a fresh raw bit,
- a local certificate-expansion upper bound,
- ambient-dimension-free upper bounds for small juntas,
- a one-sided certificate-cover upper bound by weighted subcube volume,
- exact resolution of the historical provisional three-head functions at $n=3$,
- a one-head upper bound for symmetric threshold functions,
- a general constructive upper bound via positive weighted sums,
- exact answers for some standard families, including parity,
- a clean separation between threshold-like behavior and checkerboard-like behavior.

## Main Lemma And Theorem Stack

### Lemma 1. One-head two-coordinate restrictions split additively

Fix a single-head model and freeze all but two input coordinates. Then the softmax numerator and denominator at the query token can be written as

$$ N(a,b) = A(a) + B(b) + C, \qquad D(a,b) = \alpha(a) + \beta(b) + \gamma $$

for suitable functions $A, B, \alpha, \beta$ and constants $C, \gamma$.

**Proof.** [theorems/01_foundations_and_normal_form/001_checkerboard_additive_decomposition.md](theorems/01_foundations_and_normal_form/001_checkerboard_additive_decomposition.md)

### Lemma 2. Antipode identities on a restricted 2-cube

Under the same setup,

$$ N(0,0) + N(1,1) = N(0,1) + N(1,0) $$

and

$$ D(0,0) + D(1,1) = D(0,1) + D(1,0). $$

**Proof.** [theorems/01_foundations_and_normal_form/002_antipode_identities.md](theorems/01_foundations_and_normal_form/002_antipode_identities.md)

### Lemma 3. Checkerboard obstruction for one head

If $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$ has a 2-bit checkerboard restriction, then

$$ H^{\ast}(f) \geq 2. $$

> **Equivalently.** One head cannot separate one diagonal of a restricted 2-cube from the other diagonal.

**Proof.** [theorems/01_foundations_and_normal_form/003_checkerboard_obstruction.md](theorems/01_foundations_and_normal_form/003_checkerboard_obstruction.md)

### Lemma 4. One head computes every symmetric threshold

For

$$ T_{n,t}(x) = \mathbf{1} \left[ \lvert x\rvert \geq t \right], \qquad 1 \leq t \leq n, $$

where $\lvert x\rvert$ is the Hamming weight of $x$, namely the number of coordinates of $x$ equal to $1$.

we have

$$ H^{\ast}(T_{n,t}) = 1. $$

In particular,

$$ H^{\ast}(\mathrm{OR}_n) = H^{\ast}(\mathrm{AND}_n) = H^{\ast}(\mathrm{MAJORITY}_n) = 1. $$

**Proof.** [theorems/01_foundations_and_normal_form/004_symmetric_thresholds.md](theorems/01_foundations_and_normal_form/004_symmetric_thresholds.md)

### Lemma 5. Family consequences from the checkerboard obstruction

For $n \geq 2$,

$$ H^{\ast}(\mathrm{PARITY}_n) \geq 2. $$

For $1 \leq k \leq n - 1$,

$$ H^{\ast}(\mathrm{EXACT}_{n,k}) \geq 2. $$

Together with Lemma 4, this gives a first split inside symmetric functions:

- monotone symmetric thresholds have head complexity $1$,
- parity and internal exact-count predicates need at least $2$ heads.

**Proof.** [theorems/01_foundations_and_normal_form/005_family_consequences.md](theorems/01_foundations_and_normal_form/005_family_consequences.md)

### Lemma 6. Threshold degree is bounded by head complexity

If a Boolean function $f$ is computable in the model from [model.md](model.md), then

$$ \deg_{\pm}(f) \leq H^{\ast}(f). $$

Here $\deg_{\pm}(f)$ denotes the threshold degree of $f$, namely the minimum degree of a real polynomial that sign-represents $f$ on the Boolean cube.

**Proof.** [theorems/01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md](theorems/01_foundations_and_normal_form/006_threshold_degree_head_complexity_bound.md)

### Lemma 7. Parity has threshold degree exactly n

For

$$ \mathrm{PARITY}_n(x) = x_1 \oplus \cdots \oplus x_n, $$

we have

$$ \deg_{\pm}(\mathrm{PARITY}_n) = n. $$

**Proof.** [theorems/01_foundations_and_normal_form/007_parity_threshold_degree.md](theorems/01_foundations_and_normal_form/007_parity_threshold_degree.md)

### Lemma 8. Exact parity complexity

For every $n \geq 1$,

$$ H^{\ast}(\mathrm{XOR}_n) = n. $$

> **Equivalently.** In this one-layer attention model, parity needs exactly one head per input bit.

**Proof.** [theorems/01_foundations_and_normal_form/008_exact_parity_complexity.md](theorems/01_foundations_and_normal_form/008_exact_parity_complexity.md)

### Lemma 9. Weighted-sum interpolation upper bound

Suppose there exist positive real numbers

$$ \lambda_1, \ldots, \lambda_n \gt 0 $$

and a function

$$ F : \mathrm{Im}(t) \to \lbrace0,1\rbrace, $$

where

$$ t(x) = \sum_{i=1}^{n} \lambda_i x_i, $$

such that

$$ f(x) = F(t(x)). $$

Let

$$ M := \lvert\mathrm{Im}(t)\rvert. $$

Then

$$ H^{\ast}(f) \leq M - 1. $$

In particular:

- every symmetric Boolean function satisfies $H^{\ast}(f) \leq n$,
- every Boolean function satisfies $H^{\ast}(f) \leq 2^n - 1$.

> **Candidate invariant.** The proof defines a positive weighted-sum image complexity $M_{+}(f)$ and shows
>
> $H^{\ast}(f) \leq M_{+}(f) - 1$.

**Proof.** [theorems/01_foundations_and_normal_form/009_weighted_sum_upper_bound.md](theorems/01_foundations_and_normal_form/009_weighted_sum_upper_bound.md)

### Lemma 10. Exact linear-fractional normal form

Define a one-head atom to be a function of the form

$$ \phi(x) = \frac{ \eta + \sum_{i=1}^{n} \rho_i \alpha^{x_i}(m_i + \delta x_i) }{ \gamma + \sum_{i=1}^{n} \rho_i \alpha^{x_i} }, $$

where

$$ \gamma \gt 0, \qquad \rho_1, \ldots, \rho_n \gt 0, \qquad \alpha \gt 0. $$

Let $L_{\mathrm{frac}}(f)$ be the least $H$ such that $f$ is computed by thresholding a constant plus a sum of $H$ such atoms. Then

$$ H^{\ast}(f) = L_{\mathrm{frac}}(f). $$

> **Interpretation.** The exact model-native invariant is the minimum number of one-head linear-fractional atoms needed before the final threshold.

**Proof.** [theorems/01_foundations_and_normal_form/010_linear_fractional_normal_form.md](theorems/01_foundations_and_normal_form/010_linear_fractional_normal_form.md)

### Lemma 11. Exact one-head characterization

The first two levels of head complexity are:

$$ H^{\ast}(f) = 0 \qquad \Longleftrightarrow \qquad f \text{ is constant}, $$

and

$$ H^{\ast}(f) = 1 \qquad \Longleftrightarrow \qquad f \text{ is a nonconstant linear threshold function}. $$

In particular, every non-linear-threshold Boolean function has

$$ H^{\ast}(f) \geq 2. $$

This strictly strengthens the checkerboard obstruction as a one-head lower bound.

**Proof.** [theorems/01_foundations_and_normal_form/011_one_head_characterization.md](theorems/01_foundations_and_normal_form/011_one_head_characterization.md)

### Lemma 12. Exact symmetric sign-change characterization

Let $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$ be symmetric, so

$$ f(x) = F(\lvert x\rvert) $$

for some

$$ F : \lbrace0,\ldots,n\rbrace \to \lbrace0,1\rbrace. $$

Define

$$ \sigma_k := \begin{cases} +1 & \text{if } F(k) = 1, \cr -1 & \text{if } F(k) = 0, \end{cases} $$

and let $C(F)$ be the number of indices $t \in \lbrace1,\ldots,n\rbrace$ with

$$ \sigma_{t-1} \neq \sigma_t. $$

Then

$$ H^{\ast}(f) = C(F). $$

> **Interpretation.** For symmetric functions, one head buys exactly one sign change along the Hamming-weight axis.

In particular:

- monotone symmetric thresholds have $H^{\ast} = 1$,
- parity has $H^{\ast}(\mathrm{XOR}_n) = n$,
- internal exact-count predicates have $H^{\ast}(\mathrm{EXACT} _{n,k}) = 2$ for $1 \leq k \leq n - 1$.

**Proof.** [theorems/01_foundations_and_normal_form/012_symmetric_sign_changes.md](theorems/01_foundations_and_normal_form/012_symmetric_sign_changes.md)

### Lemma 13. Positive-projection sign-change upper bound

Suppose $f$ factors through a positive weighted sum

$$ t(x) = \sum_{i=1}^{n} \lambda_i x_i, \qquad \lambda_i \gt 0, $$

so

$$ f(x) = F(t(x)). $$

Write the image of $t$ in increasing order as

$$ 0 = \tau_0 \lt \tau_1 \lt \cdots \lt \tau_{M-1}, $$

and count the number $C_t(F)$ of sign changes in the sequence

$$ F(\tau_0),F(\tau_1),\ldots,F(\tau_{M-1}). $$

Then

$$ H^{\ast}(f) \leq C_t(F). $$

Equivalently, if $C_{+}(f)$ is the minimum such sign-change count over all positive weighted sums through which $f$ factors, then

$$ H^{\ast}(f) \leq C_{+}(f) \leq M_{+}(f) - 1. $$

> **Interpretation.** The weighted-sum upper bound depends on label changes along the projection, not on the total number of projection levels.

**Proof.** [theorems/01_foundations_and_normal_form/013_positive_projection_sign_changes.md](theorems/01_foundations_and_normal_form/013_positive_projection_sign_changes.md)

### Lemma 14. Three-bit projection cases

For the three-bit function with bitstring

$$ 00011000, $$

in lexicographic input order, we have

$$ H^{\ast}(00011000) = 2. $$

For the three-bit function with bitstring

$$ 00101001, $$

we have

$$ 2 \leq H^{\ast}(00101001) \leq 3. $$

The lower bounds use the affine lattice-square identity

$$ L(a)+L(b)=L(a\wedge b)+L(a\vee b), $$

which rules out one head via the linear-threshold characterization. The upper bounds use the positive-projection sign-change theorem.

**Proof.** [theorems/01_foundations_and_normal_form/014_three_bit_projection_cases.md](theorems/01_foundations_and_normal_form/014_three_bit_projection_cases.md)

### Lemma 15. Three-bit quadratic thresholds use at most two heads

Let $f : \lbrace0,1\rbrace^3 \to \lbrace0,1\rbrace$. Suppose there is a multilinear polynomial $P$ of degree at most $2$ such that

$$ f(x)=1 \qquad \Longleftrightarrow \qquad P(x)\gt0 $$

for every $x\in\lbrace0,1\rbrace^3$. Then

$$ H^{\ast}(f) \leq 2. $$

In particular, for the three-bit function with bitstring

$$ 00101001, $$

we have the exact value

$$ H^{\ast}(00101001) = 2. $$

> **Interpretation.** On three bits, the threshold-degree lower bound is tight for every function of threshold degree at most $2$.

**Proof.** [theorems/01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md](theorems/01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md)

### Lemma 16. Exact classification of all three-bit functions

For every Boolean function

$$ f : \lbrace0,1\rbrace^3 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) = \deg_{\pm}(f). $$

In particular,

$$ H^{\ast}(f) \leq 3. $$

> **Interpretation.** The $n=3$ empirical surprises are now fully classified in prose. The three non-parity rows were optimization overestimates; the only three-head behavior at $n=3$ is threshold-degree $3$ behavior.

**Proof.** [theorems/01_foundations_and_normal_form/016_three_bit_exact_classification.md](theorems/01_foundations_and_normal_form/016_three_bit_exact_classification.md)

### Lemma 17. Four heads suffice for every four-bit function

For every Boolean function

$$ f : \lbrace0,1\rbrace^4 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 4. $$

> **Interpretation.** The generic weighted-sum bound gives $H^{\ast}(f) \leq 15$ at $n=4$. A determinant decomposition of all four-bit sign polynomials into four affine-over-positive-affine ratios improves this to $4$.

**Proof.** [theorems/01_foundations_and_normal_form/017_four_bit_universal_upper_bound.md](theorems/01_foundations_and_normal_form/017_four_bit_universal_upper_bound.md)

### Lemma 18. Seven heads suffice for every five-bit function

For every Boolean function

$$ f : \lbrace0,1\rbrace^5 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 7. $$

> **Interpretation.** The generic weighted-sum bound gives $H^{\ast}(f) \leq 31$ at $n=5$. A modular determinant certificate for seven affine-over-positive-affine ratios improves this to $7$.

**Proof.** [theorems/01_foundations_and_normal_form/018_five_bit_universal_upper_bound.md](theorems/01_foundations_and_normal_form/018_five_bit_universal_upper_bound.md)

### Lemma 19. Eleven heads suffice for every six-bit function

For every Boolean function

$$ f : \lbrace0,1\rbrace^6 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 11. $$

> **Interpretation.** The generic weighted-sum bound gives $H^{\ast}(f) \leq 63$ at $n=6$. A modular determinant certificate for eleven affine-over-positive-affine ratios improves this to $11$.

**Proof.** [theorems/01_foundations_and_normal_form/019_six_bit_universal_upper_bound.md](theorems/01_foundations_and_normal_form/019_six_bit_universal_upper_bound.md)

### Lemma 20. Nineteen heads suffice for every seven-bit function

For every Boolean function

$$ f : \lbrace0,1\rbrace^7 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 19. $$

> **Interpretation.** The generic weighted-sum bound gives $H^{\ast}(f) \leq 127$ at $n=7$. A modular determinant certificate for nineteen affine-over-positive-affine ratios improves this to $19$. Within this fixed-denominator full-span method, nineteen is the first possible seven-bit head count, since the span dimension is at most $1 + 7H$.

**Proof.** [theorems/01_foundations_and_normal_form/020_seven_bit_universal_upper_bound.md](theorems/01_foundations_and_normal_form/020_seven_bit_universal_upper_bound.md)

### Lemma 21. Determinant-span upper-bound schema

Let $n \geq 1$ and $H \geq 1$. Suppose there are positive affine functions

$$ B_1,\ldots,B_H $$

on $\lbrace0,1\rbrace^n$ such that some $2^n$ functions chosen from

$$ \prod_{j=1}^{H}B_j, \qquad M\prod_{j\neq h}B_j \quad \text{for } h \in \lbrace1,\ldots,H\rbrace, \quad M \in \lbrace1,x_1,\ldots,x_n\rbrace, $$

have linearly independent value vectors on $\lbrace0,1\rbrace^n$. Then every Boolean function

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace $$

satisfies

$$ H^{\ast}(f) \leq H. $$

Moreover, this fixed-denominator full-span method cannot prove a universal bound unless

$$ H \geq \left\lceil \frac{2^n - 1}{n} \right\rceil. $$

> **Interpretation.** The determinant certificates are a reusable upper-bound method, not isolated coincidences. The known certificates meet this method's dimension lower bound for $3 \leq n \leq 12$.

**Proof.** [theorems/01_foundations_and_normal_form/021_determinant_span_schema.md](theorems/01_foundations_and_normal_form/021_determinant_span_schema.md)

### Lemma 22. Thirty-two heads suffice for every eight-bit function

For every Boolean function

$$ f : \lbrace0,1\rbrace^8 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 32. $$

> **Interpretation.** The generic weighted-sum bound gives $H^{\ast}(f) \leq 255$ at $n=8$. A modular determinant certificate for thirty-two affine-over-positive-affine ratios improves this to $32$. This reaches the first head count where the fixed-denominator full-span method can work at $n=8$.

**Proof.** [theorems/01_foundations_and_normal_form/022_eight_bit_universal_upper_bound.md](theorems/01_foundations_and_normal_form/022_eight_bit_universal_upper_bound.md)

### Lemma 23. Fifty-seven heads suffice for every nine-bit function

For every Boolean function

$$ f : \lbrace0,1\rbrace^9 \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 57. $$

> **Interpretation.** The generic weighted-sum bound gives $H^{\ast}(f) \leq 511$ at $n=9$. A modular determinant certificate for fifty-seven affine-over-positive-affine ratios improves this to $57$. This reaches the first head count where the fixed-denominator full-span method can work at $n=9$.

**Proof.** [theorems/01_foundations_and_normal_form/023_nine_bit_universal_upper_bound.md](theorems/01_foundations_and_normal_form/023_nine_bit_universal_upper_bound.md)

### Lemma 24. 103 heads suffice for every ten-bit function

For every Boolean function

$$ f : \lbrace0,1\rbrace^{10} \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq 103. $$

> **Interpretation.** The generic weighted-sum bound gives $H^{\ast}(f) \leq 1023$ at $n=10$. A modular determinant certificate for $103$ affine-over-positive-affine ratios improves this to $103$. This reaches the first head count where the fixed-denominator full-span method can work at $n=10$.

**Proof.** [theorems/01_foundations_and_normal_form/024_ten_bit_universal_upper_bound.md](theorems/01_foundations_and_normal_form/024_ten_bit_universal_upper_bound.md)

### Lemma 25. Compact determinant-threshold certificates through twelve bits

For every

$$ n \in \lbrace3,\ldots,12\rbrace, $$

and every Boolean function

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace, $$

we have

$$ H^{\ast}(f) \leq \left\lceil \frac{2^n - 1}{n} \right\rceil. $$

In particular:

$$ \begin{array}{c|rrrrrrrrrr} n & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 \cr \hline \left\lceil (2^n - 1)/n \right\rceil & 3 & 4 & 7 & 11 & 19 & 32 & 57 & 103 & 187 & 342. \end{array} $$

> **Interpretation.** A single compact denominator formula gives modular determinant certificates meeting the determinant-span dimension lower bound through twelve input bits.

**Proof.** [theorems/01_foundations_and_normal_form/025_compact_threshold_certificates.md](theorems/01_foundations_and_normal_form/025_compact_threshold_certificates.md)

### Lemma 26. Counting lower bound for worst-case head complexity

Let

$$ W(n) := \max_{f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace} H^{\ast}(f). $$

Then

$$ W(n) = \Omega \left(\frac{2^n}{n^2}\right). $$

More quantitatively, for fixed $n$ and $H$, the number of $n$-bit Boolean functions computable with at most $H$ heads is at most

$$ 2^{O(n^2H)} $$

whenever $1 \leq H \leq 2^n$. Hence, for some absolute constant $c\gt0$, the fraction of $n$-bit Boolean functions with

$$ H^{\ast}(f) \leq c\frac{2^n}{n^2} $$

is at most $2^{-\Omega(2^n)}$.

> **Interpretation.** Almost all Boolean functions require exponentially many heads, up to polynomial slack. Thus no polynomial universal head bound can hold.

**Proof.** [theorems/01_foundations_and_normal_form/026_counting_lower_bound.md](theorems/01_foundations_and_normal_form/026_counting_lower_bound.md)

### Lemma 27. Top threshold degree is only parity

For every $n \geq 1$ and every Boolean function

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace, $$

we have

$$ \deg_{\pm}(f)=n $$

if and only if $f$ is parity or the complement of parity.

> **Interpretation.** The threshold-degree lower bound reaches $n$ heads only on parity and anti-parity. Any lower bound beyond $n$ must use information not captured by threshold degree.

**Proof.** [theorems/01_foundations_and_normal_form/027_top_threshold_degree.md](theorems/01_foundations_and_normal_form/027_top_threshold_degree.md)

### Lemma 28. Restrictions, juntas, and sign-rank lower bounds

If $g$ is obtained from

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace $$

by fixing some input coordinates, then

$$ H^{\ast}(g) \leq H^{\ast}(f). $$

Consequently, any $k$-bit parity or anti-parity restriction of $f$ certifies

$$ H^{\ast}(f) \geq k. $$

If $F(x,y)=f(x)$ only adds dummy coordinates, then

$$ H^{\ast}(F)=H^{\ast}(f). $$

Consequently, if $f$ is a $k$-junta, then $H^{\ast}(f)$ is exactly the head complexity of the induced function on its essential $k$ variables.

For a partition $I\sqcup J=\lbrace1,\ldots,n\rbrace$, let $\mathrm{srank}_{I,J}(f)$ be the sign-rank of the corresponding communication matrix of $f$. Then

$$ H^{\ast}(f) \geq \min\left\lbrace H : \mathrm{srank}_{I,J}(f) \leq \sum _{r=0}^{H} \sum _{i=0}^{r} \binom{\lvert I\rvert}{i} \binom{\lvert J\rvert}{r-i} \right\rbrace. $$

> **Interpretation.** Restrictions let known exact hard functions certify larger functions. Dummy variables do not change the answer, so exact small-junta classifications automatically lift. Sign-rank gives a constructive lower-bound route that can use communication-complexity witnesses, not only threshold degree.

**Proof.** [theorems/02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md](theorems/02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md)

### Lemma 29. Monotone DNF and CNF upper bounds

Let

$$ f(x) = \bigvee_{a=1}^{s}\bigwedge_{i\in S_a}x_i $$

be a monotone DNF with $s$ nonempty terms. Then

$$ H^{\ast}(f)\leq s. $$

Equivalently, if $\mathrm{mDNF}(f)$ is the minimum number of nonempty terms in a monotone DNF for $f$, with $\mathrm{mDNF}(0)=\mathrm{mDNF}(1)=0$, then every monotone Boolean function satisfies

$$ H^{\ast}(f)\leq\mathrm{mDNF}(f). $$

The dual bound also holds for monotone CNF:

$$ H^{\ast}(f)\leq\mathrm{mCNF}(f). $$

Therefore

$$ H^{\ast}(f) \leq \min\lbrace\mathrm{mDNF}(f),\mathrm{mCNF}(f)\rbrace. $$

> **Interpretation.** A head can be tuned so a conjunction contributes a fixed positive margin when satisfied and only a tiny negative amount otherwise. Summing one such atom per DNF term computes the monotone OR of the terms. Complement and global bit-flip symmetry give the dual CNF bound.

**Proof.** [theorems/02_complexity_measure_upper_bounds/029_monotone_dnf_upper_bound.md](theorems/02_complexity_measure_upper_bounds/029_monotone_dnf_upper_bound.md)

### Lemma 30. Threshold-degree span upper-bound schema

Let

$$ D(n,d):=\sum_{r=0}^{d}\binom{n}{r}. $$

Suppose there are affine denominators $B_1,\ldots,B_H$ with positive constant and variable coefficients such that $D(n,d)$ denominator-cleared products chosen from

$$ \prod_{j=1}^{H}B_j, \qquad M\prod_{j\neq h}B_j $$

with $M\in\lbrace1,x_1,\ldots,x_n\rbrace$ span all multilinear polynomials of degree at most $d$ on $\lbrace0,1\rbrace^n$. Then every Boolean function with

$$ \deg_{\pm}(f)\leq d $$

satisfies

$$ H^{\ast}(f)\leq H. $$

This degree-restricted fixed-denominator method cannot work unless

$$ H\geq\left\lceil\frac{D(n,d)-1}{n}\right\rceil. $$

> **Interpretation.** The full determinant-span schema is the case $d=n$. This version targets exact classification by threshold degree: if degree $d$ sign polynomials have an $H=d$ span certificate, then threshold degree $d$ is exact for that class.

**Proof.** [theorems/02_complexity_measure_upper_bounds/030_threshold_degree_span_schema.md](theorems/02_complexity_measure_upper_bounds/030_threshold_degree_span_schema.md)

### Lemma 31. Fourier tail threshold-degree criterion

Let $q : \lbrace-1,1\rbrace^n \to \lbrace-1,1\rbrace$ be the sign-valued version of $f$, with Fourier expansion

$$ q(z) = \sum_{S\subseteq[n]}\widehat q(S)\chi_S(z). $$

For $d\in\lbrace0,\ldots,n\rbrace$, define

$$ T_{\gt d}(z) := \sum_{\substack{S\subseteq[n]\cr \lvert S\rvert\gt d}} \widehat q(S)\chi_S(z). $$

If

$$ \lVert T_{\gt d}\rVert_{\infty}\lt1, $$

then

$$ \deg_{\pm}(f)\leq d. $$

In particular, it is enough that

$$ \sum_{\substack{S\subseteq[n]\cr \lvert S\rvert\gt d}} \lvert \widehat q(S)\rvert \lt1. $$

> **Interpretation.** Low Fourier tail gives a low-degree sign representation by truncating the sign function. This is an upper-bound pipeline when combined with the threshold-degree span schema.

**Proof.** [theorems/02_complexity_measure_upper_bounds/031_fourier_tail_threshold_degree.md](theorems/02_complexity_measure_upper_bounds/031_fourier_tail_threshold_degree.md)

### Lemma 32. Denominator orientation for one-head atoms

Every nonconstant one-head atom denominator has all variable coefficients with the same sign. Conversely, if an affine denominator has strictly positive variable coefficients, or strictly negative variable coefficients while remaining positive on the cube, then every affine-over-that-denominator ratio is a one-head atom.

> **Interpretation.** One head has one global denominator orientation. It can make every bit increase the denominator or every bit decrease it, but one head cannot make some variables increase and others decrease the denominator.

**Proof.** [theorems/02_complexity_measure_upper_bounds/032_denominator_orientation.md](theorems/02_complexity_measure_upper_bounds/032_denominator_orientation.md)

### Lemma 33. Shared projection Boolean closure

Suppose $f_1,\ldots,f_m$ all factor through the same positive weighted sum

$$ t(x)=\sum_{i=1}^{n}\lambda_i x_i, \qquad \lambda_i\gt0. $$

For any Boolean operation $G:\lbrace0,1\rbrace^m\to\lbrace0,1\rbrace$, define

$$ g(x):=G(f_1(x),\ldots,f_m(x)). $$

Then

$$ H^{\ast}(g) \leq C_t(g) \leq \sum_{j=1}^{m}C_t(f_j), $$

where $C_t$ is sign-change count along the ordered image of $t$. In particular, if $t$ has $M$ image levels, then

$$ H^{\ast}(g)\leq M-1. $$

> **Interpretation.** Boolean combinations of functions sharing one statistic stay one-dimensional. They should be bounded by label changes along that statistic, not by separately paying for each input function.

**Proof.** [theorems/02_complexity_measure_upper_bounds/033_shared_projection_closure.md](theorems/02_complexity_measure_upper_bounds/033_shared_projection_closure.md)

### Lemma 34. DNF and CNF width give threshold-degree upper bounds

If $f$ has a DNF in which every term has width at most $w$, then

$$ \deg_{\pm}(f)\leq w. $$

If $f$ has a CNF in which every clause has width at most $w$, then

$$ \deg_{\pm}(f)\leq w. $$

Consequently, if a degree $w$ span certificate with $H$ heads is available, then every width $w$ DNF or CNF function satisfies

$$ H^{\ast}(f)\leq H. $$

> **Interpretation.** Mixed-literal DNF is not handled by the monotone one-head-per-term construction, but bounded width still gives a low-degree sign polynomial. The head bound then follows from degree-restricted denominator spans.

**Proof.** [theorems/02_complexity_measure_upper_bounds/034_dnf_cnf_width_threshold_degree.md](theorems/02_complexity_measure_upper_bounds/034_dnf_cnf_width_threshold_degree.md)

### Lemma 35. Monotone antichain upper bound

Let $f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace$ be monotone. Let $\mathcal{M}_1(f)$ be the family of minimal true sets, and let $\mathcal{M}_0(f)$ be the family of maximal false sets. Then

$$ H^{\ast}(f) \leq \min\lbrace\lvert\mathcal{M}_1(f)\rvert,\lvert\mathcal{M}_0(f)\rvert\rbrace. $$

Since both boundary families are antichains,

$$ H^{\ast}(f) \leq \binom{n}{\lfloor n/2\rfloor}. $$

> **Interpretation.** For monotone functions, head complexity is bounded by the size of the monotone boundary, not by the total number of true inputs.

**Proof.** [theorems/02_complexity_measure_upper_bounds/035_monotone_antichain_upper_bound.md](theorems/02_complexity_measure_upper_bounds/035_monotone_antichain_upper_bound.md)

### Lemma 36. Monotone counting lower bound

Let $\mathsf{Mon}_n$ be the set of monotone Boolean functions on $\lbrace0,1\rbrace^n$, and define

$$ W_{\mathrm{mon}}(n) := \max_{f\in\mathsf{Mon}_n} H^{\ast}(f). $$

Then

$$ \Omega \left(\frac{1}{n^2}\binom{n}{\lfloor n/2\rfloor}\right) \leq W_{\mathrm{mon}}(n) \leq \binom{n}{\lfloor n/2\rfloor}. $$

More strongly, almost every monotone $n$-bit Boolean function requires

$$ \Omega \left(\frac{1}{n^2}\binom{n}{\lfloor n/2\rfloor}\right) $$

heads, up to the absolute constant hidden by the Warren-counting argument.

> **Interpretation.** Monotone functions already have exponential worst-case and typical head complexity. The antichain upper bound is therefore near-optimal for the monotone class, modulo polynomial factors.

**Proof.** [theorems/02_complexity_measure_upper_bounds/036_monotone_counting_lower_bound.md](theorems/02_complexity_measure_upper_bounds/036_monotone_counting_lower_bound.md)

### Lemma 37. Sparse support upper bound

For

$$ f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace, $$

define

$$ s(f) := \min\lbrace \lvert f^{-1}(1)\rvert, \lvert f^{-1}(0)\rvert \rbrace. $$

Then

$$ H^{\ast}(f)\leq2s(f). $$

If $s(f)=1$, then

$$ H^{\ast}(f)\leq1. $$

> **Interpretation.** Sparse and co-sparse functions have low head complexity regardless of whether their exceptional inputs have monotone, symmetric, or formula structure.

**Proof.** [theorems/02_complexity_measure_upper_bounds/037_sparse_support_upper_bound.md](theorems/02_complexity_measure_upper_bounds/037_sparse_support_upper_bound.md)

### Lemma 38. DNF and CNF volume upper bounds

Suppose $f$ has a DNF with consistent nonempty terms $T_1,\ldots,T_s$, and let $w_a$ be the width of $T_a$. Then

$$ H^{\ast}(f) \leq 2\sum_{a=1}^{s}2^{n-w_a}. $$

In particular, if every term has width at least $w$, then

$$ H^{\ast}(f)\leq 2s 2^{n-w}. $$

The dual statement holds for CNFs with clause widths $w_a$:

$$ H^{\ast}(f) \leq 2\sum_{a=1}^{s}2^{n-w_a}. $$

> **Interpretation.** Mixed-literal formulas get a support-volume route to head upper bounds. This is weaker than the monotone one-head-per-term theorem, but it applies with arbitrary literal signs.

**Proof.** [theorems/02_complexity_measure_upper_bounds/038_dnf_cnf_volume_upper_bound.md](theorems/02_complexity_measure_upper_bounds/038_dnf_cnf_volume_upper_bound.md)

### Lemma 39. Junta reduction and small-junta upper bounds

Let $f$ be a $k$-junta, and let $f_{\mathrm{ess}}$ be the induced function on its essential variables. Then

$$ H^{\ast}(f)=H^{\ast}(f_{\mathrm{ess}}). $$

Consequently, every $k$-junta satisfies

$$ H^{\ast}(f)\leq2^k-1 $$

for $k\geq1$. For $k\leq12$, the current best universal small-junta bounds are:

$$ \begin{array}{c|rrrrrrrrrrrrr} k & 0 & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 \cr \hline H^{\ast}(f)\leq & 0 & 1 & 2 & 3 & 4 & 7 & 11 & 19 & 32 & 57 & 103 & 187 & 342. \end{array} $$

> **Interpretation.** Small-junta head bounds depend on the number of essential variables, not on the ambient input dimension.

**Proof.** [theorems/02_complexity_measure_upper_bounds/039_junta_upper_bounds.md](theorems/02_complexity_measure_upper_bounds/039_junta_upper_bounds.md)

### Lemma 40. Certificate-cover upper bound

Let $\mathcal{C}_1$ be a family of partial assignments whose cylinders cover exactly the true set of $f$. Then

$$ H^{\ast}(f) \leq 2\sum_{(D,\xi)\in\mathcal{C}_1}2^{n-\lvert D\rvert}. $$

The dual bound holds for a $0$-certificate cover $\mathcal{C}_0$:

$$ H^{\ast}(f) \leq 2\sum_{(D,\xi)\in\mathcal{C}_0}2^{n-\lvert D\rvert}. $$

Equivalently, if $\mathrm{certvol}_b(f)$ is the minimum weighted cylinder volume of a $b$-certificate cover, then

$$ H^{\ast}(f) \leq 2\min\lbrace\mathrm{certvol}_0(f),\mathrm{certvol}_1(f)\rbrace. $$

> **Interpretation.** Sparse support, DNF volume, and CNF volume are all instances of one-sided certificate covers.

**Proof.** [theorems/02_complexity_measure_upper_bounds/040_certificate_cover_upper_bound.md](theorems/02_complexity_measure_upper_bounds/040_certificate_cover_upper_bound.md)

### Lemma 41. Polynomial-threshold sparsity upper bound

Let $\mathrm{ptfsp}(f)$ be the minimum number of nonconstant monomials appearing with nonzero coefficient in a real polynomial that sign-represents $f$ on the Boolean cube. Then

$$ H^{\ast}(f)\leq\mathrm{ptfsp}(f). $$

Consequently, if $\deg_{\pm}(f)\leq d$, then

$$ H^{\ast}(f) \leq \sum_{r=1}^{d}\binom{n}{r}. $$

> **Interpretation.** Sparse sign polynomials give sparse head representations, one approximating head per nonconstant monomial.

**Proof.** [theorems/02_complexity_measure_upper_bounds/041_ptf_sparsity_upper_bound.md](theorems/02_complexity_measure_upper_bounds/041_ptf_sparsity_upper_bound.md)

### Lemma 42. DNF and CNF literal-expansion upper bound

For a mixed-literal DNF

$$ f(x)=\bigvee_{a=1}^{s} \left(\prod_{i\in P_a}x_i\right) \left(\prod_{j\in N_a}(1-x_j)\right) $$

with consistent nonempty terms,

$$ H^{\ast}(f) \leq \min\left\lbrace \sum_{a=1}^{s}2^{\lvert P_a\rvert}, \sum_{a=1}^{s}2^{\lvert N_a\rvert} \right\rbrace. $$

The same bound holds for a mixed-literal CNF with clause positive-literal sets $P_a$ and negative-literal sets $N_a$.

> **Interpretation.** Mixed-literal formulas close to monotone have small head complexity. Lemma 44 sharpens this by choosing the cheaper literal orientation separately for each term or clause.

**Proof.** [theorems/02_complexity_measure_upper_bounds/042_dnf_cnf_literal_expansion_upper_bound.md](theorems/02_complexity_measure_upper_bounds/042_dnf_cnf_literal_expansion_upper_bound.md)

### Lemma 43. Decision-tree leaf-profile upper bound

Let $\mathcal{T}$ be a deterministic decision tree computing $f$. For a leaf $\ell$, let $P_\ell$ be the variables fixed to $1$ on the path to $\ell$, and let $N_\ell$ be the variables fixed to $0$. Let $\mathcal{L}_1$ and $\mathcal{L}_0$ be the accepting and rejecting leaves. Then

$$ H^{\ast}(f) \leq \min\left\lbrace \sum_{\ell\in\mathcal{L}_1}2^{\lvert P _\ell\rvert}, \sum _{\ell\in\mathcal{L}_1}2^{\lvert N _\ell\rvert}, \sum _{\ell\in\mathcal{L}_0}2^{\lvert P _\ell\rvert}, \sum _{\ell\in\mathcal{L}_0}2^{\lvert N _\ell\rvert} \right\rbrace. $$

In particular, if $f$ is nonconstant and has deterministic decision-tree depth $D(f)=d\geq1$, then

$$ H^{\ast}(f)\leq2^{2d-1}. $$

> **Interpretation.** Adaptive decision structure gives head upper bounds from the signed leaf profile, not from the ambient input dimension.

**Proof.** [theorems/02_complexity_measure_upper_bounds/043_decision_tree_upper_bound.md](theorems/02_complexity_measure_upper_bounds/043_decision_tree_upper_bound.md)

### Lemma 44. Local certificate-expansion upper bound

Let $\mathcal{C}_1$ be a $1$-certificate cover by partial assignments $(P,N)$, where $P$ is the set of variables fixed to $1$ and $N$ is the set fixed to $0$. Then

$$ H^{\ast}(f) \leq \sum_{(P,N)\in\mathcal{C}_1} \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace. $$

The same bound holds for a $0$-certificate cover $\mathcal{C}_0$:

$$ H^{\ast}(f) \leq \sum_{(P,N)\in\mathcal{C}_0} \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace. $$

> **Interpretation.** One-sided certificate covers are cheap when each certificate fixes few bits of at least one sign. The cheaper sign may be chosen separately for each certificate.

Consequently, the decision-tree depth corollary from Lemma 43 sharpens to

$$ H^{\ast}(f)\leq2^{D(f)+\lfloor D(f)/2\rfloor-1} $$

for every nonconstant $f$.

**Proof.** [theorems/02_complexity_measure_upper_bounds/044_oriented_certificate_expansion_upper_bound.md](theorems/02_complexity_measure_upper_bounds/044_oriented_certificate_expansion_upper_bound.md)

### Lemma 45. Fourier support-cost upper bound

Let $q:\lbrace0,1\rbrace^n\to\lbrace-1,1\rbrace$ be the sign-valued version of $f$. Suppose

$$ R(x)=\sum_{S\in\mathcal{A}}c_S\chi_S(x), \qquad \chi_S(x)=(-1)^{\sum_{i\in S}x_i}, $$

sign-represents $f$, meaning $q(x)R(x)\gt0$ on the cube.

Define $a_1(R)=1$ if an active singleton set has nonzero coefficient, and define $a_1(R)=0$ otherwise. Then

$$ H^{\ast}(f) \leq a_1(R)+\sum_{\substack{S\in\mathcal{A}\cr \lvert S\rvert\geq2,\ c_S\neq0}}\lvert S\rvert. $$

In particular, if the active sets have size at most $d$, with $m_1$ singleton sets and $m_{\geq2}$ nonsingleton sets, then

$$ H^{\ast}(f)\leq\mathbf{1}[m_1\gt0]+dm_{\geq2}. $$

If a Fourier truncation over $\mathcal{A}$ approximates $q$ uniformly within $1$, then the same bound applies.

> **Interpretation.** Sparse Walsh sign approximants give head upper bounds. The affine portion costs at most one head, and each retained higher character is realized as parity on its active variables.

**Proof.** [theorems/02_complexity_measure_upper_bounds/045_fourier_support_upper_bound.md](theorems/02_complexity_measure_upper_bounds/045_fourier_support_upper_bound.md)

### Lemma 46. Affine parity exact complexity

Let $S\subseteq\lbrace1,\ldots,n\rbrace$ and $b\in\lbrace0,1\rbrace$. Define

$$ f_{S,b}(x) := b\oplus\bigoplus_{i\in S}x_i. $$

Then

$$ H^{\ast}(f_{S,b})=\lvert S\rvert. $$

Consequently, if some restriction of $f$ is affine parity on $k$ free variables, then

$$ H^{\ast}(f)\geq k. $$

> **Interpretation.** Affine-parity subcubes are explicit lower-bound witnesses, and affine parities themselves are exactly one head per essential bit.

**Proof.** [theorems/03_function_families_and_affine_geometry/046_affine_parity_exact.md](theorems/03_function_families_and_affine_geometry/046_affine_parity_exact.md)

### Lemma 47. Inner-product mod two bounds

For $m\geq1$, define

$$ \mathrm{IP}_m(x,y) := \bigoplus _{i=1}^{m}x_i y_i. $$

Then

$$ \deg_{\pm}(\mathrm{IP}_m)=m $$

and therefore

$$ m\leq H^{\ast}(\mathrm{IP}_m)\leq2^m-1. $$

> **Interpretation.** Inner product mod $2$ is a nonsymmetric test family whose threshold degree is exactly the number of pairs. It contains $m$-bit parity as a restriction and has a sparse sign polynomial with $2^m-1$ nonconstant monomials.

**Proof.** [theorems/03_function_families_and_affine_geometry/047_inner_product_bounds.md](theorems/03_function_families_and_affine_geometry/047_inner_product_bounds.md)

### Lemma 48. Affine-free polynomial-threshold sparsity upper bound

Let $\mathrm{afs}_{\pm}(f)$ be the minimum, over all sign-representing multilinear polynomials $P$, of the number of degree at least two monomials in $P$, plus one extra unit if the linear part of $P$ is nonzero. Then

$$ H^{\ast}(f)\leq\mathrm{afs}_{\pm}(f). $$

Consequently, if $f$ is nonconstant and $\deg_{\pm}(f)\leq d$, then

$$ H^{\ast}(f) \leq 1+\sum_{r=2}^{d}\binom{n}{r}. $$

> **Interpretation.** Sparse polynomial threshold representations only need to pay separately for nonlinear monomials. The whole affine part can be bundled into one head.

In particular, the affine-free route gives the preliminary equality bound

$$ H^{\ast}(\mathrm{EQ}_m)\leq m+1. $$

**Proof.** [theorems/03_function_families_and_affine_geometry/048_affine_free_sparsity_upper_bound.md](theorems/03_function_families_and_affine_geometry/048_affine_free_sparsity_upper_bound.md)

### Lemma 49. Equality bounds

For $m\geq1$, define

$$ \mathrm{EQ}_m(x,y) := \mathbf{1}[x=y], \qquad x,y\in\lbrace0,1\rbrace^m. $$

Then

$$ \deg_{\pm}(\mathrm{EQ}_m)=2 $$

and in fact

$$ H^{\ast}(\mathrm{EQ}_m)=2. $$

> **Interpretation.** Equality has constant threshold degree and exact head complexity two. The older affine-free sparsity route gives the weaker constructive bound $m+1$.

**Proof.** [theorems/03_function_families_and_affine_geometry/049_equality_bounds.md](theorems/03_function_families_and_affine_geometry/049_equality_bounds.md)

### Lemma 50. Intersection-profile bounds

Let $F:\lbrace0,1,\ldots,m\rbrace\to\lbrace0,1\rbrace$ and define

$$ f_F(x,y) := F \left(\sum_{i=1}^{m}x_i y_i\right). $$

Let $C(F)$ be the number of sign changes in

$$ F(0),F(1),\ldots,F(m). $$

Then

$$ C(F) \leq H^{\ast}(f_F) \leq \sum_{r=1}^{C(F)}\binom{m}{r}. $$

Consequently, for $m\geq2$,

$$ 2\leq H^{\ast}(\mathrm{INT}_m)\leq m, \qquad 2\leq H^{\ast}(\mathrm{DISJ}_m)\leq m, $$

where $\mathrm{INT}_m(x,y)=\mathbf{1}[\sum_i x_i y_i\geq1]$ and $\mathrm{DISJ}_m=1-\mathrm{INT}_m$. In particular,

$$ H^{\ast}(\mathrm{INT}_2)=H^{\ast}(\mathrm{DISJ}_2)=2. $$

> **Interpretation.** Intersection-profile predicates inherit symmetric sign-change lower bounds from the restriction $y=1^m$, and get sparse-polynomial upper bounds by expanding in the pair monomials $x_i y_i$.

**Proof.** [theorems/03_function_families_and_affine_geometry/050_intersection_profile_bounds.md](theorems/03_function_families_and_affine_geometry/050_intersection_profile_bounds.md)

### Lemma 51. Hamming-distance profile bounds

Let $F:\lbrace0,1,\ldots,m\rbrace\to\lbrace0,1\rbrace$ and define

$$ g_F(x,y) := F(\Delta(x,y)), \qquad \Delta(x,y):=\sum_{i=1}^{m}(x_i\oplus y_i). $$

Let $C(F)$ be the number of sign changes in

$$ F(0),F(1),\ldots,F(m). $$

Define

$$ U_m(C) := \begin{cases} 0 & \text{if } C=0,\cr 1+m+\sum_{r=2}^{C}3^r\binom{m}{r} & \text{if } C\geq1. \end{cases} $$

Then

$$ C(F)\leq H^{\ast}(g_F)\leq U_m(C(F)). $$

Consequently, for $1\leq t\leq m$ and

$$ \mathrm{HDTH}_{m,t}(x,y):=\mathbf{1}[\Delta(x,y)\geq t], $$

we have

$$ H^{\ast}(\mathrm{HDTH}_{1,1})=2, $$

and for $m\geq2$,

$$ 2\leq H^{\ast}(\mathrm{HDTH}_{m,t})\leq m+1. $$

> **Interpretation.** Hamming-distance profiles inherit symmetric sign-change lower bounds from the restriction $y=0^m$. The upper bound expands each distance bit $x_i\oplus y_i$ into three monomials, while bundling all linear terms into one affine head.

**Proof.** [theorems/03_function_families_and_affine_geometry/051_hamming_distance_profile_bounds.md](theorems/03_function_families_and_affine_geometry/051_hamming_distance_profile_bounds.md)

### Lemma 52. Directed-defect profile bounds

Let $F:\lbrace0,1,\ldots,m\rbrace\to\lbrace0,1\rbrace$ and define

$$ h_F(x,y) := F(D(x,y)), \qquad D(x,y):=\sum_{i=1}^{m}x_i(1-y_i). $$

Let $C(F)$ be the number of sign changes in

$$ F(0),F(1),\ldots,F(m). $$

Define

$$ V_m(C) := \begin{cases} 0 & \text{if } C=0,\cr 1+m+\sum_{r=2}^{C}2^r\binom{m}{r} & \text{if } C\geq1. \end{cases} $$

Then

$$ C(F)\leq H^{\ast}(h_F)\leq V_m(C(F)). $$

Consequently, if $\mathrm{SUB}_m(x,y)=\mathbf{1}[x_i\leq y_i\text{ for every }i]$ and $\mathrm{NCON}_m=1-\mathrm{SUB}_m$, then

$$ H^{\ast}(\mathrm{SUB}_1) = H^{\ast}(\mathrm{NCON}_1) =1, $$

and for $m\geq2$,

$$ 2\leq H^{\ast}(\mathrm{SUB}_m)\leq m+1, \qquad 2\leq H^{\ast}(\mathrm{NCON}_m)\leq m+1. $$

> **Interpretation.** Directed-defect profiles count violations of $x_i\leq y_i$. Their expansion cost sits between intersection and Hamming distance: each defect bit is $x_i-x_i y_i$.

**Proof.** [theorems/03_function_families_and_affine_geometry/052_directed_defect_profile_bounds.md](theorems/03_function_families_and_affine_geometry/052_directed_defect_profile_bounds.md)

### Lemma 53. Local-pattern count profile schema

Let $p:\lbrace0,1\rbrace^2\to\lbrace0,1\rbrace$ be a two-bit predicate and define

$$ f_{p,F}(x,y) := F \left(\sum_{i=1}^{m}p(x_i,y_i)\right). $$

Let $C(F)$ be the number of sign changes in

$$ F(0),F(1),\ldots,F(m). $$

Let $\Lambda_{p,m}(C)$ be the affine-free monomial expansion cost of all products

$$ \prod_{i\in S}P_p(x_i,y_i), \qquad 1\leq\lvert S\rvert\leq C, $$

where $P_p$ is the multilinear polynomial for $p$: all degree-one monomials appearing in these products cost one affine head total, and every degree at least two monomial costs one.

If $p$ has a one-bit slice equal to $z$ or $1-z$, then

$$ C(F) \leq H^{\ast}(f_{p,F}) \leq \Lambda_{p,m}(C(F)). $$

> **Interpretation.** This packages the common mechanism behind the intersection, Hamming-distance, and directed-defect profile bounds. A one-bit slice gives the symmetric lower bound, and local polynomial expansion gives the affine-free sparsity upper bound.

**Proof.** [theorems/03_function_families_and_affine_geometry/053_local_pattern_count_profile_schema.md](theorems/03_function_families_and_affine_geometry/053_local_pattern_count_profile_schema.md)

### Lemma 54. Three-bit threshold-vote match

Let $s_{\mathrm{LTF}}(f)$ be the minimum number of linear threshold functions whose weighted vote computes $f$. That is, $s_{\mathrm{LTF}}(f)$ is the least $s$ such that

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{s}c_jT_j(x)\gt0, $$

where each $T_j$ is a linear threshold function.

For every three-bit Boolean function

$$ f:\lbrace0,1\rbrace^3\to\lbrace0,1\rbrace, $$

we have

$$ s_{\mathrm{LTF}}(f)=H^{\ast}(f)=\deg_{\pm}(f). $$

Equivalently:

$$ s_{\mathrm{LTF}}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 3 & \text{if } f \text{ is parity or anti-parity},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** Threshold-vote size agrees exactly with $H^{\ast}$ on all three-bit functions, even though it is not a global invariant. The proof uses a finite enumeration showing that two threshold votes cover $254$ of the $256$ truth tables, missing only parity and anti-parity.

**Proof.** [theorems/03_function_families_and_affine_geometry/054_three_bit_threshold_vote_invariant.md](theorems/03_function_families_and_affine_geometry/054_three_bit_threshold_vote_invariant.md)

### Lemma 55. Equality has threshold-vote size two

Let $s_{\mathrm{LTF}}(f)$ be the minimum number of linear threshold functions in a weighted vote computing $f$. For

$$ \mathrm{EQ}_m(x,y)=\mathbf{1}[x=y], \qquad x,y\in\lbrace0,1\rbrace^m, $$

we have

$$ s_{\mathrm{LTF}}(\mathrm{EQ}_m)=2 $$

for every $m\geq1$.

> **Interpretation.** Equality is a useful family where threshold-vote size still matches head complexity. At this point in the ledger, the head-complexity bracket is $2\leq H^{\ast}(\mathrm{EQ}_m)\leq m+1$, while the threshold-vote calculation predicts the exact value $2$.

**Proof.** [theorems/03_function_families_and_affine_geometry/055_equality_threshold_vote_size.md](theorems/03_function_families_and_affine_geometry/055_equality_threshold_vote_size.md)

### Lemma 56. Two-pair equality is exact

Let

$$ \mathrm{EQ}_2(x_1,x_2,y_1,y_2) := \mathbf{1}[(x_1,x_2)=(y_1,y_2)]. $$

Then

$$ H^{\ast}(\mathrm{EQ}_2)=2. $$

> **Interpretation.** The first nontrivial equality instance achieves the threshold-vote prediction. The proof gives an explicit two-atom rational certificate with same-orientation positive affine denominators.

**Proof.** [theorems/03_function_families_and_affine_geometry/056_two_pair_equality_exact.md](theorems/03_function_families_and_affine_geometry/056_two_pair_equality_exact.md)

### Lemma 57. Two-pair containment is exact

Define

$$ \mathrm{SUB}_2(x,y) := \mathbf{1}[x_i\leq y_i\text{ for }i=1,2], \qquad \mathrm{NCON}_2:=1-\mathrm{SUB}_2. $$

Then

$$ H^{\ast}(\mathrm{SUB}_2)=H^{\ast}(\mathrm{NCON}_2)=2. $$

> **Interpretation.** The first nontrivial directed-defect endpoint achieves the two-head lower bound. The proof gives an explicit two-atom rational certificate for $\mathrm{SUB}_2$, and complementing the readout gives $\mathrm{NCON}_2$.

**Proof.** [theorems/03_function_families_and_affine_geometry/057_two_pair_containment_exact.md](theorems/03_function_families_and_affine_geometry/057_two_pair_containment_exact.md)

### Lemma 58. Two-pair local-count thresholds use at most two heads

Let $p:\lbrace0,1\rbrace^2\to\lbrace0,1\rbrace$ be any two-bit predicate and let $F:\lbrace0,1,2\rbrace\to\lbrace0,1\rbrace$ have exactly one sign change. Define

$$ f_{p,F}(x_1,x_2,y_1,y_2) := F(p(x_1,y_1)+p(x_2,y_2)). $$

Then

$$ H^{\ast}(f_{p,F})\leq2. $$

More precisely:

$$ H^{\ast}(f_{p,F}) = \begin{cases} 0 & \text{if } f_{p,F} \text{ is constant},\cr 1 & \text{if } f_{p,F} \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** Every threshold-like count of two identical local two-bit patterns is exactly classified. The finite certificate enumeration covers $64$ presentations, $30$ unique truth tables, and $12$ non-LTF two-atom certificates.

**Proof.** [theorems/03_function_families_and_affine_geometry/058_two_pair_local_count_thresholds.md](theorems/03_function_families_and_affine_geometry/058_two_pair_local_count_thresholds.md)

### Lemma 59. Three-pair endpoint families are exact

For three pairs of input bits,

$$ H^{\ast}(\mathrm{INT}_3) = H^{\ast}(\mathrm{DISJ}_3) = H^{\ast}(\mathrm{SUB}_3) = H^{\ast}(\mathrm{NCON}_3) = H^{\ast}(\mathrm{EQ}_3) = H^{\ast}(\mathrm{NEQ}_3) =2. $$

> **Interpretation.** The standard one-change profile endpoints remain two-head functions at three pairs. The proof gives exact integer two-atom certificates for $\mathrm{INT}_3$, $\mathrm{SUB}_3$, and $\mathrm{EQ}_3$, then uses complement invariance.

**Proof.** [theorems/03_function_families_and_affine_geometry/059_three_pair_endpoint_exact.md](theorems/03_function_families_and_affine_geometry/059_three_pair_endpoint_exact.md)

### Lemma 60. Equality has exact head complexity two

For every $m\geq1$,

$$ H^{\ast}(\mathrm{EQ}_m)=2. $$

Consequently, if $\mathrm{NEQ}_m:=1-\mathrm{EQ}_m$, then

$$ H^{\ast}(\mathrm{NEQ}_m)=2. $$

> **Interpretation.** Equality is fully solved. The two-head construction compares the binary encodings $X=\sum_i2^{i-1}x_i$ and $Y=\sum_i2^{i-1}y_i$ with a rational score whose cleared numerator is $1-(X-Y)^2$.

**Proof.** [theorems/03_function_families_and_affine_geometry/060_equality_exact_two_heads.md](theorems/03_function_families_and_affine_geometry/060_equality_exact_two_heads.md)

### Lemma 61. Affine level sets use at most two heads

Let

$$ L(x)=c+\sum_{i=1}^{n}a_i x_i $$

be an affine function on $\lbrace0,1\rbrace^n$, and define

$$ E_L(x):=\mathbf{1}[L(x)=0]. $$

Then

$$ H^{\ast}(E_L)\leq2. $$

More precisely,

$$ H^{\ast}(E_L) = \begin{cases} 0 & \text{if } E_L \text{ is constant},\cr 1 & \text{if } E_L \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** Equality to any affine statistic is cheap. This includes internal exact-count predicates and equality of two binary-encoded strings.

**Proof.** [theorems/03_function_families_and_affine_geometry/061_affine_level_set_upper_bound.md](theorems/03_function_families_and_affine_geometry/061_affine_level_set_upper_bound.md)

### Lemma 62. Affine slabs use at most two heads

Let

$$ L(x)=c+\sum_{i=1}^{n}a_i x_i $$

be an affine function on $\lbrace0,1\rbrace^n$, and let $\alpha\leq\beta$. Define

$$ S_{L,\alpha,\beta}(x) := \mathbf{1}[\alpha\leq L(x)\leq\beta]. $$

Then

$$ H^{\ast}(S_{L,\alpha,\beta})\leq2. $$

More precisely,

$$ H^{\ast}(S_{L,\alpha,\beta}) = \begin{cases} 0 & \text{if } S_{L,\alpha,\beta} \text{ is constant},\cr 1 & \text{if } S_{L,\alpha,\beta} \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** Any finite Boolean-cube slice between two parallel affine hyperplanes is a two-head predicate unless it collapses to a constant or one-head LTF. Affine level sets are the zero-width case.

**Proof.** [theorems/03_function_families_and_affine_geometry/062_affine_slab_upper_bound.md](theorems/03_function_families_and_affine_geometry/062_affine_slab_upper_bound.md)

### Lemma 63. Affine statistic sign-change upper bound

Let $L$ be affine on $\lbrace0,1\rbrace^n$, let $G:\mathrm{Im}(L)\to\lbrace0,1\rbrace$, and define

$$ f(x):=G(L(x)). $$

Let $k$ be the number of nonzero variable coefficients of $L$, and let $C_L(G)$ be the number of sign changes in $G$ along the ordered image of $L$.

Then:

1. If $C_L(G)=0$, then $H^{\ast}(f)=0$.

2. If $C_L(G)=1$, then $H^{\ast}(f)=1$.

3. If $C_L(G)=2$, then $H^{\ast}(f)$ is $1$ if $f$ is a nonconstant LTF and $2$ otherwise.

4. If $C_L(G)\geq3$, then

   $H^{\ast}(f) \leq 1+\sum_{r=2}^{\min\lbrace C_L(G),k\rbrace}\binom{k}{r}.$

> **Interpretation.** Positive-projection sign changes give the sharper $C$-head bound when the statistic has positive weights. This lemma is the orientation-free fallback for a single affine statistic with mixed signs.

**Proof.** [theorems/03_function_families_and_affine_geometry/063_affine_statistic_sign_changes.md](theorems/03_function_families_and_affine_geometry/063_affine_statistic_sign_changes.md)

### Lemma 64. Two-point supports use at most two heads

Let

$$ s(f):=\min\lbrace\lvert f^{-1}(1)\rvert,\lvert f^{-1}(0)\rvert\rbrace. $$

If

$$ s(f)\leq2, $$

then

$$ H^{\ast}(f)\leq2. $$

More precisely,

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** The general sparse-support theorem gives $H^{\ast}(f)\leq2s(f)$. This lemma sharpens the first nontrivial sparse case: a one-point or two-point exceptional label class always costs at most two heads.

**Proof.** [theorems/03_function_families_and_affine_geometry/064_two_point_support_exact.md](theorems/03_function_families_and_affine_geometry/064_two_point_support_exact.md)

### Lemma 65. Affine hull clean supports use at most two heads

Let $A\subseteq\lbrace0,1\rbrace^n$ be nonempty and affine hull clean, meaning

$$ \mathrm{aff}(A)\cap\lbrace0,1\rbrace^n=A. $$

Suppose $A$ is a label class of $f$ and

$$ \mathrm{aff}(A)\neq\mathbb{R}^n. $$

Then

$$ H^{\ast}(f)\leq2. $$

More precisely,

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** A label class is two-head easy whenever it is exactly the cube slice cut out by its own proper affine hull. This strictly generalizes the two-point support theorem.

**Proof.** [theorems/03_function_families_and_affine_geometry/065_affine_hull_clean_supports.md](theorems/03_function_families_and_affine_geometry/065_affine_hull_clean_supports.md)

### Lemma 66. Positive run-count upper bound

Let $t$ be an injective positive weighted sum on the Boolean cube, and let $R_t^b(f)$ be the number of contiguous runs of label $b$ in the ordered truth table induced by $t$. Then

$$ H^{\ast}(f) \leq 2\min\lbrace R_t^0(f),R_t^1(f)\rbrace. $$

Consequently, if

$$ R_{+}(f) := \min_t\min\lbrace R_t^0(f),R_t^1(f)\rbrace, $$

where the minimum ranges over injective positive weighted sums, then

$$ H^{\ast}(f)\leq2R_{+}(f). $$

> **Interpretation.** Sparse support pays by the number of minority points. The sharper positive-order invariant pays by the number of minority runs in the best positive ordering.

**Proof.** [theorems/03_function_families_and_affine_geometry/066_positive_run_upper_bound.md](theorems/03_function_families_and_affine_geometry/066_positive_run_upper_bound.md)

### Lemma 67. Degree-based partition sign-rank limitations

The degree-based partition sign-rank lower-bound route from Lemma 28 can certify

$$ H^{\ast}(f)\geq h+1 $$

only if some partition $I\sqcup J=\lbrace1,\ldots,n\rbrace$ satisfies

$$ 2^{\min\lbrace\lvert I\rvert,\lvert J\rvert\rbrace} \gt \sum_{r=0}^{h}\binom{n}{r}. $$

Consequently, this sign-rank route cannot certify

$$ H^{\ast}(f)\geq3 $$

for any Boolean function on at most $13$ input bits.

> **Interpretation.** The rank bound obtained by treating a cleared score as an arbitrary low-degree polynomial is dimension-limited. Sharper factorizations of actual head scores can surpass this ceiling, as Theorem 182 does on twelve bits.

**Proof.** [theorems/03_function_families_and_affine_geometry/067_sign_rank_method_limitations.md](theorems/03_function_families_and_affine_geometry/067_sign_rank_method_limitations.md)

### Lemma 68. Positive one-run classes are exact

Let $t$ be an injective positive weighted sum on the Boolean cube. Suppose one label class of $f$ is a single contiguous block in the ordering induced by $t$. Then

$$ H^{\ast}(f)\leq2. $$

More precisely,

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

In particular, if $R_{+}(f)=1$, then the same exact split holds.

> **Interpretation.** The first nontrivial positive-run case is fully controlled. A single run in a positive ordering is exactly an affine slab after choosing two cutpoints around the run.

**Proof.** [theorems/03_function_families_and_affine_geometry/068_positive_one_run_exact.md](theorems/03_function_families_and_affine_geometry/068_positive_one_run_exact.md)

### Lemma 69. Positive-projection degree-tight exactness

Let $C_{+}(f)$ be the minimum positive-projection sign-change count. Then

$$ \deg_{\pm}(f) \leq H^{\ast}(f) \leq C_{+}(f). $$

Consequently, if

$$ \deg_{\pm}(f)=C_{+}(f), $$

then

$$ H^{\ast}(f)=\deg_{\pm}(f)=C_{+}(f). $$

More generally, if $f$ factors through a positive weighted sum $t$ with sign-change count $C_t(f)$ and

$$ \deg_{\pm}(f)=C_t(f), $$

then

$$ H^{\ast}(f)=C_t(f). $$

Finally, if $C_{+}(f)\leq2$, then $H^{\ast}(f)$ has the exact constant, nonconstant LTF, or otherwise two-head split.

> **Interpretation.** Positive-projection upper bounds become exact as soon as threshold degree meets them. The low-alternation regime $C_{+}(f)\leq2$ is fully classified.

**Proof.** [theorems/03_function_families_and_affine_geometry/069_positive_projection_degree_tight_exact.md](theorems/03_function_families_and_affine_geometry/069_positive_projection_degree_tight_exact.md)

### Lemma 70. Low affine-free support is exact

If

$$ \mathrm{afs}_{\pm}(f)\leq2, $$

then

$$ H^{\ast}(f)\leq2. $$

More precisely,

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

In particular, this applies to every function sign-represented by an affine polynomial plus one nonlinear monomial.

> **Interpretation.** The first nontrivial affine-free sparsity regime is exact. A single nonlinear monomial perturbing an affine threshold either collapses to an LTF or genuinely needs exactly two heads.

**Proof.** [theorems/03_function_families_and_affine_geometry/070_low_affine_free_support_exact.md](theorems/03_function_families_and_affine_geometry/070_low_affine_free_support_exact.md)

### Lemma 71. Depth-two decision trees are exact

If $f$ is computed by a deterministic decision tree of depth at most $2$, then

$$ H^{\ast}(f)\leq2. $$

More precisely,

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** The first adaptive decision-tree case is exact. A depth-two tree can mix different variables on different branches, but it still stays in the two-head regime.

**Proof.** [theorems/03_function_families_and_affine_geometry/071_depth_two_decision_trees_exact.md](theorems/03_function_families_and_affine_geometry/071_depth_two_decision_trees_exact.md)

### Lemma 72. Decision-tree hybrid upper bound

Let $\mathcal{T}$ be a deterministic decision tree computing $f$. Let $d$ be its depth and $v$ the number of distinct variables queried by the tree. Define

$$ \Lambda(\mathcal{T}) := \min\left\lbrace \sum_{\ell\in\mathcal{L}_1}\min\lbrace2^{\lvert P _\ell\rvert},2^{\lvert N _\ell\rvert}\rbrace, \sum _{\ell\in\mathcal{L}_0}\min\lbrace2^{\lvert P _\ell\rvert},2^{\lvert N _\ell\rvert}\rbrace \right\rbrace. $$

If $f$ is nonconstant, then

$$ H^{\ast}(f) \leq \min\left\lbrace \Lambda(\mathcal{T}), 2^v-1, 1+\sum_{r=2}^{\min\lbrace d,v\rbrace}\binom{v}{r} \right\rbrace. $$

> **Interpretation.** Decision trees give three complementary upper-bound certificates: local leaf expansion, junta reduction to the queried variables, and a low-degree sign polynomial from bounded path length.

**Proof.** [theorems/03_function_families_and_affine_geometry/072_decision_tree_hybrid_upper_bound.md](theorems/03_function_families_and_affine_geometry/072_decision_tree_hybrid_upper_bound.md)

### Lemma 73. DNF and CNF hybrid upper bound

Suppose $f$ has a DNF or CNF using $v$ distinct variables, with consistent nonempty terms or clauses indexed by $a$, widths $w_a$, maximum width $w$, and positive-literal and negative-literal sets $P_a,N_a$. If $f$ is nonconstant, then

$$ H^{\ast}(f) \leq \min\left\lbrace 2\sum_a2^{v-w_a}, \sum_a\min\lbrace2^{\lvert P_a\rvert},2^{\lvert N_a\rvert}\rbrace, 2^v-1, 1+\sum_{r=2}^{\min\lbrace w,v\rbrace}\binom{v}{r} \right\rbrace. $$

> **Interpretation.** Mixed-literal formulas have a four-way upper-bound menu: support volume inside the used-variable cube, local literal expansion, junta interpolation, and a width-degree sparse-polynomial bound.

**Proof.** [theorems/03_function_families_and_affine_geometry/073_dnf_cnf_hybrid_upper_bound.md](theorems/03_function_families_and_affine_geometry/073_dnf_cnf_hybrid_upper_bound.md)

### Lemma 74. Cofactor sparse-polynomial recursion

Write inputs as $(z,y)\in\lbrace0,1\rbrace\times\lbrace0,1\rbrace^{n-1}$, and let

$$ f_0(y):=f(0,y), \qquad f_1(y):=f(1,y). $$

Suppose $P_0$ and $P_1$ strictly sign-represent $f_0$ and $f_1$. Let $\mathcal{A}_b$ be the nonconstant monomial support of $P_b$, and let

$$ m_b:=\lvert\mathcal{A}_b\rvert \qquad (b\in\lbrace0,1\rbrace). $$

Then

$$ H^{\ast}(f) \leq m_0 +\lvert\mathcal{A}_0\cup\mathcal{A}_1\rvert +1. $$

In particular,

$$ H^{\ast}(f) \leq 2m_0+m_1+1. $$

Consequently,

$$ H^{\ast}(f) \leq 2\mathrm{ptfsp}(f_0) +\mathrm{ptfsp}(f_1) +1. $$

If both cofactors have threshold degree at most $d$, then

$$ \deg_{\pm}(f)\leq d+1. $$

For nonconstant $f$, this gives

$$ H^{\ast}(f) \leq 1+\sum_{r=2}^{\min\lbrace d+1,n\rbrace}\binom{n}{r}. $$

> **Interpretation.** A direct one-head Shannon recursion is still open, but sparse sign polynomials compose cleanly across cofactors.

**Proof.** [theorems/04_recursions_and_cost_invariants/074_cofactor_sparse_polynomial_recursion.md](theorems/04_recursions_and_cost_invariants/074_cofactor_sparse_polynomial_recursion.md)

### Lemma 75. Affine-free cofactor recursion

Write inputs as $(z,y)\in\lbrace0,1\rbrace\times\lbrace0,1\rbrace^{n-1}$, and let

$$ f_0(y):=f(0,y), \qquad f_1(y):=f(1,y). $$

Suppose $P_0$ and $P_1$ strictly sign-represent $f_0$ and $f_1$. Let $\mathcal{N}_b$ be the set of degree at least two monomials appearing in $P_b$, and let $\mathcal{L} _{\Delta}$ be the set of coordinates whose linear coefficients differ between $P_0$ and $P_1$. Then

$$ H^{\ast}(f) \leq 1 +\lvert\mathcal{N}_0\rvert +\lvert\mathcal{N}_0\cup\mathcal{N}_1\rvert +\lvert\mathcal{L} _{\Delta}\rvert. $$

Consequently, if both cofactors have threshold degree at most $d$, then

$$ H^{\ast}(f) \leq 1+(n-1) +2\sum_{r=2}^{\min\lbrace d,n-1\rbrace}\binom{n-1}{r}. $$

In particular, if both cofactors are constants or linear threshold functions, then

$$ H^{\ast}(f)\leq n. $$

If the two affine cofactor separators can be chosen so their linear coefficient vectors differ in at most one coordinate, then $H^{\ast}(f)\leq2$, with exact value $0$, $1$, or $2$ according as $f$ is constant, a nonconstant LTF, or neither.

> **Interpretation.** Affine-free sparsity sharpens the cofactor recursion by bundling all affine terms into one head and only paying for nonlinear cofactor monomials and changed slopes across the split.

**Proof.** [theorems/04_recursions_and_cost_invariants/075_affine_free_cofactor_recursion.md](theorems/04_recursions_and_cost_invariants/075_affine_free_cofactor_recursion.md)

### Lemma 76. LTF cofactor slope distance

Write inputs as $(z,y)\in\lbrace0,1\rbrace\times\lbrace0,1\rbrace^{n-1}$, and let $f_0(y)=f(0,y)$ and $f_1(y)=f(1,y)$. Suppose $f_0$ and $f_1$ have affine sign representations

$$ L_b(y) = \beta_b+\sum_{i=1}^{n-1}\alpha_{b,i}y_i \qquad (b\in\lbrace0,1\rbrace). $$

Let

$$ \Delta(L_0,L_1) := \lbrace i:\alpha_{0,i}\neq\alpha_{1,i}\rbrace, \qquad t:=\lvert\Delta(L_0,L_1)\rvert. $$

Then

$$ H^{\ast}(f)\leq1+t. $$

In particular, if both cofactors are constants or LTFs, then $H^{\ast}(f)\leq n$. If the affine cofactor separators can be chosen with $t=0$, then $f$ is constant or a nonconstant LTF. If they can be chosen with $t\leq1$, then $H^{\ast}(f)$ has the exact constant, nonconstant LTF, or otherwise two-head split.

> **Interpretation.** For two LTF slices, the useful quantity is not just that both slices are affine threshold functions. It is how many affine slopes must change when crossing the split bit.

**Proof.** [theorems/04_recursions_and_cost_invariants/076_ltf_cofactor_slope_distance.md](theorems/04_recursions_and_cost_invariants/076_ltf_cofactor_slope_distance.md)

### Lemma 77. Split LTF slope invariant

For each coordinate $j$, let $f_{j,0}$ and $f_{j,1}$ be the two cofactors obtained by fixing $x_j=0$ and $x_j=1$. Say $j$ is an LTF split if both cofactors are constants or LTFs.

For an LTF split $j$, let $\sigma_j(f)$ be the minimum number of changed linear coefficients between affine sign representations of $f_{j,0}$ and $f_{j,1}$. If $f$ has at least one LTF split, define

$$ \sigma_{\mathrm{split}}(f) := \min_{j:\ j\text{ is an LTF split}}\sigma_j(f). $$

Then

$$ H^{\ast}(f) \leq 1+\sigma_{\mathrm{split}}(f). $$

In particular, every function with an LTF split satisfies $H^{\ast}(f)\leq n$. If $\sigma_{\mathrm{split}}(f)=0$, then $f$ is constant or a nonconstant LTF. If $\sigma_{\mathrm{split}}(f)\leq1$, then $H^{\ast}(f)$ has the exact constant, nonconstant LTF, or otherwise two-head split.

> **Interpretation.** For functions that become LTFs after fixing one coordinate, the relevant bound is the best slope-change count over all split coordinates and all affine separator choices.

**Proof.** [theorems/04_recursions_and_cost_invariants/077_split_ltf_slope_invariant.md](theorems/04_recursions_and_cost_invariants/077_split_ltf_slope_invariant.md)

### Lemma 78. Split affine-free support invariant

For each split coordinate and each pair of strict cofactor sign polynomials $P_0,P_1$, define

$$ C(P_0,P_1) := \lambda(P_0,P_1) +\lvert\mathcal{N}_0\rvert +\lvert\mathcal{L} _{\Delta}\rvert +\lvert\mathcal{N} _{\Delta}\rvert, $$

where:

- $\lambda(P_0,P_1)$ records whether the glued polynomial has any nonconstant affine part,
- $\mathcal{N}_0$ is the degree at least two support of the $0$-cofactor polynomial,
- $\mathcal{L} _{\Delta}$ is the set of changed linear coefficients,
- $\mathcal{N} _{\Delta}$ is the set of changed degree at least two coefficients.

Let $\mathrm{scafs}_{\pm}(f)$ be the minimum of $C(P_0,P_1)$ over all split coordinates and all strict cofactor sign representations. Then

$$ H^{\ast}(f) \leq \mathrm{scafs}_{\pm}(f). $$

If $\mathrm{scafs}_{\pm}(f)\leq2$, then $H^{\ast}(f)$ has the exact constant, nonconstant LTF, or otherwise two-head split.

> **Interpretation.** This is the cofactor invariant that pays for what is shared in one base slice and for what changes across the split. It can be much smaller than the union-support cofactor bound.

**Proof.** [theorems/04_recursions_and_cost_invariants/078_split_affine_free_support_invariant.md](theorems/04_recursions_and_cost_invariants/078_split_affine_free_support_invariant.md)

### Lemma 79. One-bit LTF branching

Let

$$ L(y)=\beta+\sum_{i\in S}\alpha_i y_i $$

strictly sign-represent an LTF feature $T(y)$, with $\alpha_i\neq0$ for $i\in S$. For any Boolean gate

$$ G:\lbrace0,1\rbrace^2\to\lbrace0,1\rbrace, $$

define

$$ f(z,y):=G(z,T(y)). $$

Then

$$ H^{\ast}(f)\leq1+\lvert S\rvert. $$

If $\lvert S\rvert\leq1$, then $H^{\ast}(f)$ has the exact constant, nonconstant LTF, or otherwise two-head split.

> **Interpretation.** Any two-input Boolean gate applied to one raw bit and one LTF feature has head complexity at most one plus the support size of the LTF separator.

**Proof.** [theorems/04_recursions_and_cost_invariants/079_one_bit_ltf_branching.md](theorems/04_recursions_and_cost_invariants/079_one_bit_ltf_branching.md)

### Lemma 80. One-bit sparse-PTF branching

Let $P(y)$ strictly sign-represent a Boolean feature $T(y)$, and let:

$$ \ell(P):=\lvert\lbrace i:a_i\neq0\rbrace\rvert, \qquad q(P):= \left\lvert \left\lbrace S:\lvert S\rvert\geq2,\ a_S\neq0 \right\rbrace \right\rvert. $$

For any Boolean gate $G:\lbrace0,1\rbrace^2\to\lbrace0,1\rbrace$, define

$$ f(z,y):=G(z,T(y)). $$

For $b\in\lbrace0,1\rbrace$, let $\mu_b=1$ if $G(b,u)=u$, let $\mu_b=-1$ if $G(b,u)=1-u$, and let $\mu_b=0$ if $G(b,u)$ is constant. Then

$$ H^{\ast}(f) \leq 1 +\mathbf{1}[\mu_0\neq0]  q(P) +\mathbf{1}[\mu_1\neq\mu_0]\bigl(\ell(P)+q(P)\bigr). $$

In particular,

$$ H^{\ast}(f)\leq1+\ell(P)+2q(P). $$

If the refined displayed bound is at most $2$, then $H^{\ast}(f)$ has the exact constant, nonconstant LTF, or otherwise two-head split.

> **Interpretation.** The one-bit LTF branching theorem extends to sparse PTF features, paying for the feature's linear support and nonlinear support, with a smaller cost when the two branches are the same function of the feature.

**Proof.** [theorems/04_recursions_and_cost_invariants/080_one_bit_sparse_ptf_branching.md](theorems/04_recursions_and_cost_invariants/080_one_bit_sparse_ptf_branching.md)

### Lemma 81. Fresh-bit XOR raises threshold degree

Let

$$ f:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace, $$

and define

$$ g(z,y):=z\oplus f(y). $$

Then

$$ \deg_{\pm}(g)=\deg_{\pm}(f)+1. $$

Consequently,

$$ H^{\ast}(g)\geq\deg_{\pm}(f)+1. $$

If $P$ is a strict sign polynomial for $f$ with $\ell(P)$ nonzero linear coefficients and $q(P)$ nonlinear monomials, then

$$ \deg_{\pm}(f)+1 \leq H^{\ast}(z\oplus f(y)) \leq 1+\ell(P)+2q(P). $$

> **Interpretation.** XOR with a fresh raw bit is a lower-bound amplifier. It raises threshold degree by exactly one, so any head-level recursion for $z\oplus f$ must pay at least one new head whenever $H^{\ast}$ is already threshold-degree tight.

**Proof.** [theorems/04_recursions_and_cost_invariants/081_fresh_bit_xor_threshold_degree.md](theorems/04_recursions_and_cost_invariants/081_fresh_bit_xor_threshold_degree.md)

### Lemma 82. One-bit gate threshold-degree trichotomy

Let $T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace$ be nonconstant, set $d:=\deg_{\pm}(T)$, and define

$$ F(z,y):=G(z,T(y)) $$

for an arbitrary gate $G:\lbrace0,1\rbrace^{2}\to\lbrace0,1\rbrace$. For $b\in\lbrace0,1\rbrace$, write $G_b(u):=G(b,u)$.

If $G_0$ and $G_1$ are both constant, then

$$ \deg_{\pm}(F) = \begin{cases} 0 & \text{if } G_0=G_1,\cr 1 & \text{if } G_0\neq G_1. \end{cases} $$

If at least one slice is nonconstant and the nonconstant slices, when there are two, are not opposite, then

$$ \deg_{\pm}(F)=d. $$

If $\lbrace G_0,G_1\rbrace=\lbrace u,1-u\rbrace$, then

$$ \deg_{\pm}(F)=d+1. $$

> **Interpretation.** Fresh-bit XOR and XNOR are the only one-bit gates that force threshold degree to rise. Fresh-bit AND, OR, implication, and their complements preserve threshold degree when the feature branch is nonconstant.

**Proof.** [theorems/04_recursions_and_cost_invariants/082_one_bit_gate_threshold_degree_trichotomy.md](theorems/04_recursions_and_cost_invariants/082_one_bit_gate_threshold_degree_trichotomy.md)

### Lemma 83. Parity-block threshold-degree amplifier

Let

$$ \pi_k(z):=\bigoplus_{j=1}^{k}z_j, \qquad F(z,y):=\pi_k(z)\oplus T(y). $$

Then

$$ \deg_{\pm}(F)=\deg_{\pm}(T)+k. $$

Consequently,

$$ H^{\ast}(F)\geq\deg_{\pm}(T)+k. $$

If $P$ is a strict sign polynomial for $T$ with $m(P)$ nonconstant monomials, then

$$ H^{\ast}(F)\leq2^{k}\bigl(m(P)+1\bigr)-1. $$

> **Interpretation.** A block of fresh parity bits is an additive threshold-degree amplifier. It preserves the exact lower-bound increment under iteration, even though the generic sparse-PTF upper bound may be loose.

**Proof.** [theorems/04_recursions_and_cost_invariants/083_parity_block_threshold_degree_amplifier.md](theorems/04_recursions_and_cost_invariants/083_parity_block_threshold_degree_amplifier.md)

### Lemma 84. Parity-block restriction lower bound

Let $f:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace$. Suppose a restriction of $f$ leaves two disjoint sets of free variables $Z$ and $Y$, with $\lvert Z\rvert=k$, and on that restricted subcube has the form

$$ f_{\rho}(z,y) = \left(\bigoplus_{j=1}^{k}z_j\right)\oplus T(y) $$

for some Boolean function $T$ on the $Y$ variables. Then

$$ \deg_{\pm}(f)\geq k+\deg_{\pm}(T), $$

and hence

$$ H^{\ast}(f)\geq k+\deg_{\pm}(T). $$

The same conclusion holds for the complement of the displayed parity-block form.

> **Interpretation.** Pure parity restrictions are not the only additive lower-bound certificates. A parity block modulating any residual hard subfunction contributes its own parity size plus the residual threshold degree.

**Proof.** [theorems/04_recursions_and_cost_invariants/084_parity_block_restriction_lower_bound.md](theorems/04_recursions_and_cost_invariants/084_parity_block_restriction_lower_bound.md)

### Lemma 85. Calibrated threshold-vote upper bound

Let $T_1,\ldots,T_s:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace$ be Boolean features, and define

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{s}c_jT_j(x)\gt0. $$

Let

$$ \mu := \min_{x\in\lbrace0,1\rbrace^{n}} \left\lvert c_0+\sum_{j=1}^{s}c_jT_j(x) \right\rvert \gt 0. $$

Suppose that each $T_j$ has a one-head atom approximation $\phi_j$ with

$$ \lvert\phi_j(x)-T_j(x)\rvert\leq\epsilon_j \qquad \text{for all }x, $$

and

$$ \sum_{j=1}^{s}\lvert c_j\rvert\epsilon_j\lt\mu. $$

Then

$$ H^{\ast}(f)\leq s. $$

> **Interpretation.** The false threshold-vote upper bound becomes true once the raw one-head atoms approximate the inner gate indicators within the outer vote margin.

**Proof.** [theorems/04_recursions_and_cost_invariants/085_calibrated_threshold_vote_upper_bound.md](theorems/04_recursions_and_cost_invariants/085_calibrated_threshold_vote_upper_bound.md)

### Lemma 86. Endpoint affine-threshold vote upper bound

For a nonempty set $S\subseteq\lbrace1,\ldots,n\rbrace$ and positive weights $\lambda_i\gt0$, define

$$ L_S(x):=\sum_{i\in S}\lambda_i x_i, \qquad \Lambda_S:=\sum_{i\in S}\lambda_i. $$

An endpoint affine-threshold feature is either

$$ U_S(x):=\mathbf{1}[L_S(x)\gt0] $$

or

$$ A_S(x):=\mathbf{1}[L_S(x)=\Lambda_S]. $$

If $T_1,\ldots,T_s$ are endpoint affine-threshold features and

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{s}c_jT_j(x)\gt0 $$

with positive vote margin, then

$$ H^{\ast}(f)\leq s. $$

> **Interpretation.** Calibrated threshold votes are automatically valid for endpoint positive affine thresholds. Thus weighted votes over positive OR-type clauses and positive AND-type terms cost at most one head per voted feature.

**Proof.** [theorems/04_recursions_and_cost_invariants/086_endpoint_affine_threshold_vote_upper_bound.md](theorems/04_recursions_and_cost_invariants/086_endpoint_affine_threshold_vote_upper_bound.md)

### Lemma 87. One-bit non-XOR gate recursion

Let $T : \lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace$ be any Boolean function, and let

$$ G : \lbrace0,1\rbrace^{2}\to\lbrace0,1\rbrace $$

be a two-input Boolean gate that is neither XOR nor XNOR. Define

$$ F(z,y):=G(z,T(y)). $$

Then

$$ H^{\ast}(F)\leq H^{\ast}(T)+1. $$

In particular,

$$ H^{\ast}(z\wedge T(y))\leq H^{\ast}(T)+1, \qquad H^{\ast}(z\vee T(y))\leq H^{\ast}(T)+1, $$

and the same bound holds after complementing either input literal or the output.

> **Interpretation.** One fresh raw bit can be combined with an arbitrary already-computed feature through any non-XOR two-input gate at the cost of one additional head. XOR and XNOR remain the exceptional recursive cases.

**Proof.** [theorems/04_recursions_and_cost_invariants/087_one_bit_non_xor_gate_recursion.md](theorems/04_recursions_and_cost_invariants/087_one_bit_non_xor_gate_recursion.md)

### Lemma 88. Literal decision-list upper bound

Let $L_{\mathrm{litDL}}(f)$ be the minimum length of a literal decision list computing $f$, where each test is a literal $x_i$ or $1-x_i$. Then

$$ H^{\ast}(f)\leq L_{\mathrm{litDL}}(f). $$

Equivalently, any literal decision list with $L$ tests gives

$$ H^{\ast}(f)\leq L. $$

> **Interpretation.** Literal decision lists are a proved head-level recursion class. Each tested literal costs at most one head, while the harder linear-threshold decision-list case remains open.

**Proof.** [theorems/04_recursions_and_cost_invariants/088_literal_decision_list_upper_bound.md](theorems/04_recursions_and_cost_invariants/088_literal_decision_list_upper_bound.md)

### Lemma 89. Endpoint decision-list upper bound

Let $f$ be computed by a decision list with $L$ tests, where each test is either an endpoint affine-threshold feature

$$ \mathbf{1}[L_S(x)\gt0] \qquad \text{or} \qquad \mathbf{1}[L_S(x)=\Lambda_S], $$

or the complement of one. Then

$$ H^{\ast}(f)\leq L. $$

> **Interpretation.** Endpoint OR-type and AND-type tests can be used in decision lists at one head per test. This strictly extends the literal decision-list theorem while still avoiding arbitrary LTF tests.

**Proof.** [theorems/04_recursions_and_cost_invariants/089_endpoint_decision_list_upper_bound.md](theorems/04_recursions_and_cost_invariants/089_endpoint_decision_list_upper_bound.md)

### Lemma 90. Calibrated decision-list upper bound

Let $T_1,\ldots,T_L$ be Boolean tests in a decision list for $f$. There are coefficients $c_0,\ldots,c_L$ and a margin $\mu\gt0$ such that

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{L}c_jT_j(x)\gt0, $$

and the absolute value of this vote is always at least $\mu$ on the cube. If the tests have one-head atom approximations $\phi_j$ with errors $\epsilon_j$ satisfying

$$ \sum_{j=1}^{L}\lvert c_j\rvert\epsilon_j\lt\mu, $$

then

$$ H^{\ast}(f)\leq L. $$

In particular, if every test indicator is arbitrarily one-head approximable, then the decision list has $H^{\ast}(f)\leq L$.

> **Interpretation.** Decision-list priority can always be converted into a strict weighted vote. The remaining cost question is whether the test indicators are available as calibrated raw one-head atoms.

**Proof.** [theorems/04_recursions_and_cost_invariants/090_calibrated_decision_list_upper_bound.md](theorems/04_recursions_and_cost_invariants/090_calibrated_decision_list_upper_bound.md)

### Lemma 91. Internal LTF indicator obstruction

Let

$$ T(x_1,x_2,x_3):=x_1\wedge(x_2\vee x_3). $$

Equivalently,

$$ T(x)=1 \qquad\Longleftrightarrow\qquad 2x_1+x_2+x_3\geq3. $$

Thus $T$ is a monotone LTF. However, every one-head atom $\phi$ satisfies

$$ \max_{x\in\lbrace0,1\rbrace^3}\lvert \phi(x)-T(x)\rvert \geq \frac{1}{4}. $$

> **Interpretation.** One head can compute every LTF after a final threshold, but the raw atom need not approximate the LTF indicator. This is a genuine obstruction to extending calibrated decision-list and threshold-vote theorems to arbitrary LTF gates one gate at a time.

**Proof.** [theorems/04_recursions_and_cost_invariants/091_internal_ltf_indicator_obstruction.md](theorems/04_recursions_and_cost_invariants/091_internal_ltf_indicator_obstruction.md)

### Lemma 92. Internal LTF indicator infimum

For

$$ T(x_1,x_2,x_3):=x_1\wedge(x_2\vee x_3), $$

the best uniform approximation error by a single one-head atom has infimum exactly

$$ \inf_{\phi} \max_{x\in\lbrace0,1\rbrace^3}\lvert \phi(x)-T(x)\rvert = \frac{1}{4}. $$

> **Interpretation.** The $1/4$ obstruction in Lemma 91 is sharp. One-head atoms can approach this error, but cannot cross it.

**Proof.** [theorems/04_recursions_and_cost_invariants/092_internal_ltf_indicator_infimum.md](theorems/04_recursions_and_cost_invariants/092_internal_ltf_indicator_infimum.md)

### Lemma 93. Raw-calibrated vote support bound

Let $\rho(T)$ be the least nonnegative number of one-head atoms needed to approximate a Boolean feature $T$ uniformly to arbitrary accuracy, allowing an added constant. If

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{s}c_jT_j(x)\gt0 $$

has positive margin, then

$$ H^{\ast}(f) \leq \sum_{j:c_j\neq0}\rho(T_j). $$

Moreover, if $\mathrm{eafs}(T)$ is the exact affine-free support cost of the unique multilinear expansion of $T$, then

$$ \rho(T)\leq\mathrm{eafs}(T). $$

Consequently,

$$ H^{\ast}(f) \leq \sum_{j:c_j\neq0}\mathrm{eafs}(T_j). $$

> **Interpretation.** Calibrated votes can spend more than one atom on a feature. Exact multilinear sparsity gives a concrete fallback raw-calibration cost.

**Proof.** [theorems/04_recursions_and_cost_invariants/093_raw_calibrated_vote_support_bound.md](theorems/04_recursions_and_cost_invariants/093_raw_calibrated_vote_support_bound.md)

### Lemma 94. Raw-calibrated decision-list support bound

Let $f$ be computed by a decision list with tests $T_1,\ldots,T_L$. Then

$$ H^{\ast}(f) \leq \sum_{j=1}^{L}\rho(T_j). $$

In particular,

$$ H^{\ast}(f) \leq \sum_{j=1}^{L}\mathrm{eafs}(T_j). $$

> **Interpretation.** Arbitrary-test decision lists can be upper-bounded by raw calibration cost per test. The one-head-per-test theorem is the special case $\rho(T_j)\leq1$ for every tested feature.

**Proof.** [theorems/04_recursions_and_cost_invariants/094_raw_calibrated_decision_list_support_bound.md](theorems/04_recursions_and_cost_invariants/094_raw_calibrated_decision_list_support_bound.md)

### Lemma 95. Raw calibration threshold-degree lower bound

Suppose

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{s}c_jT_j(x)\gt0 $$

with positive margin. Then

$$ \deg_{\pm}(f) \leq \sum_{j:c_j\neq0}\rho(T_j). $$

In particular, if $f=T_1\wedge T_2$, then

$$ \rho(T_1)+\rho(T_2)\geq\deg_{\pm}(f), \qquad \max\lbrace\rho(T_1),\rho(T_2)\rbrace\geq\frac{\deg_{\pm}(f)}{2}. $$

> **Interpretation.** Threshold-degree lower bounds for a strict vote force high raw calibration cost in at least one inner feature.

**Proof.** [theorems/04_recursions_and_cost_invariants/095_raw_calibration_threshold_degree_lower_bound.md](theorems/04_recursions_and_cost_invariants/095_raw_calibration_threshold_degree_lower_bound.md)

### Lemma 96. Subcube raw calibration cost

Let $(P,N)$ be a partial assignment and define

$$ C_{P,N}(x) := \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right). $$

If $P=N=\varnothing$, then $\rho(C_{P,N})=0$. Otherwise,

$$ \rho(C_{P,N}) \leq \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace. $$

Consequently, strict weighted votes and decision lists over subcube indicators inherit the same summed local expansion cost through Lemmas 93 and 94.

> **Interpretation.** Local certificate expansion is not only a one-sided cover theorem. Each cylinder indicator has a concrete raw calibration cost that can be reused inside arbitrary strict votes and decision lists.

**Proof.** [theorems/04_recursions_and_cost_invariants/096_subcube_raw_calibration_cost.md](theorems/04_recursions_and_cost_invariants/096_subcube_raw_calibration_cost.md)

### Lemma 97. Raw calibration invariances

The raw calibration cost $\rho(T)$ is invariant under output complement, coordinate permutation, global bit-flip, and dummy-variable extension. It is monotone under restrictions: if $R$ is a restriction of $T$, then

$$ \rho(R)\leq\rho(T). $$

> **Interpretation.** Raw calibration cost can be treated as a robust invariant. Lower-bound searches may pass to canonical representatives and restricted witnesses.

**Proof.** [theorems/04_recursions_and_cost_invariants/097_raw_calibration_invariances.md](theorems/04_recursions_and_cost_invariants/097_raw_calibration_invariances.md)

### Lemma 98. Subcube-threshold vote upper bound

For a partial assignment $(P,N)$, define

$$ C_{P,N}(x) := \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right), $$

and

$$ \kappa(P,N) := \begin{cases} 0, & P=N=\varnothing, \cr \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace, & \text{otherwise}. \end{cases} $$

If

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{a=1}^{s}c_aC_{P_a,N_a}(x)\gt0 $$

has positive margin, then

$$ H^{\ast}(f) \leq \sum_{a:c_a\neq0}\kappa(P_a,N_a). $$

> **Interpretation.** Strict real threshold votes over subcube indicators have head cost bounded by the summed local literal-orientation cost. The cylinders need not be a one-sided cover.

**Proof.** [theorems/04_recursions_and_cost_invariants/098_subcube_threshold_vote_upper_bound.md](theorems/04_recursions_and_cost_invariants/098_subcube_threshold_vote_upper_bound.md)

### Lemma 99. Cylinder-threshold cost invariant

Let $\mathrm{ctc}(f)$ be the minimum, over all strict real threshold representations of $f$ by subcube indicators $C_{P_a,N_a}$, of

$$ \sum_{a:c_a\neq0}\kappa(P_a,N_a), $$

where $\kappa(P,N)=0$ for the vacuous cylinder and otherwise

$$ \kappa(P,N) = \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace. $$

Then

$$ H^{\ast}(f)\leq\mathrm{ctc}(f). $$

Moreover, $\mathrm{ctc}(f)\lt\infty$ for every Boolean function.

> **Interpretation.** The best strict threshold vote over cylinders is itself a head upper-bound invariant. This optimizes the local cylinder cost directly rather than first choosing a normal form such as DNF, CNF, or a certificate cover.

**Proof.** [theorems/04_recursions_and_cost_invariants/099_cylinder_threshold_cost_invariant.md](theorems/04_recursions_and_cost_invariants/099_cylinder_threshold_cost_invariant.md)

### Lemma 100. Cylinder-threshold cost invariances

The cylinder-threshold cost $\mathrm{ctc}(f)$ is invariant under output complement, coordinate permutation, global bit-flip, and dummy-variable extension. It is monotone under restrictions: if $g$ is a restriction of $f$, then

$$ \mathrm{ctc}(g)\leq\mathrm{ctc}(f). $$

> **Interpretation.** The optimized cylinder-threshold upper-bound invariant can be searched on canonical representatives, and lower-bound attempts may use hard restrictions.

**Proof.** [theorems/04_recursions_and_cost_invariants/100_cylinder_threshold_cost_invariances.md](theorems/04_recursions_and_cost_invariants/100_cylinder_threshold_cost_invariances.md)

### Lemma 101. Cylinder-threshold cost subsumes local certificates

If $\mathcal{C}_1$ is a $1$-certificate cover for $f$ by partial assignments $(P,N)$, then

$$ \mathrm{ctc}(f) \leq \sum_{(P,N)\in\mathcal{C}_1}\kappa(P,N). $$

The same bound holds for any $0$-certificate cover. Consequently, any DNF or CNF with local literal sets $(P_a,N_a)$ satisfies

$$ \mathrm{ctc}(f) \leq \sum_a\kappa(P_a,N_a), $$

and any deterministic decision tree satisfies

$$ \mathrm{ctc}(f) \leq \min\left\lbrace \sum_{\ell\in\mathcal{L}_1}\kappa(P _\ell,N _\ell), \sum _{\ell\in\mathcal{L}_0}\kappa(P _\ell,N _\ell) \right\rbrace. $$

> **Interpretation.** The $\mathrm{ctc}$ invariant strictly packages the local certificate-expansion route. One-sided covers and formula normal forms are feasible cylinder-threshold representations, but $\mathrm{ctc}$ can also optimize over signed overlapping cylinder votes.

**Proof.** [theorems/04_recursions_and_cost_invariants/101_cylinder_threshold_cost_subsumes_local_certificates.md](theorems/04_recursions_and_cost_invariants/101_cylinder_threshold_cost_subsumes_local_certificates.md)

### Lemma 102. Cylinder-threshold cost and PTF sparsity

Let $\mathrm{ptfsp}(f)$ be the least number of nonconstant monomials in a real multilinear polynomial that sign-represents $f$. Then

$$ \mathrm{ctc}(f)\leq\mathrm{ptfsp}(f). $$

Consequently, if $\deg_{\pm}(f)\leq d$, then

$$ \mathrm{ctc}(f) \leq \sum_{r=1}^{d}\binom{n}{r}. $$

Thus

$$ H^{\ast}(f) \leq \mathrm{ctc}(f) \leq \mathrm{ptfsp}(f). $$

> **Interpretation.** Sparse polynomial thresholds are a special case of cylinder-threshold representations: each positive monomial is a cylinder with local cost $1$.

**Proof.** [theorems/04_recursions_and_cost_invariants/102_cylinder_threshold_cost_ptf_sparsity.md](theorems/04_recursions_and_cost_invariants/102_cylinder_threshold_cost_ptf_sparsity.md)

### Lemma 103. Affine-cylinder threshold cost

Let $\mathrm{actc}(f)$ be the minimum, over all strict representations

$$ f(x)=1 \qquad\Longleftrightarrow\qquad A(x)+\sum_{a=1}^{s}c_aC_{P_a,N_a}(x)\gt0, $$

of

$$ \lambda(A)+\sum_{a:c_a\neq0}\kappa(P_a,N_a), $$

where $A$ is affine, $\lambda(A)=1$ exactly when $A$ has a nonzero linear part, and $\kappa$ is the cylinder local cost from Lemma 99. Then

$$ H^{\ast}(f)\leq\mathrm{actc}(f). $$

Moreover,

$$ \mathrm{actc}(f)\leq\mathrm{ctc}(f). $$

> **Interpretation.** The best signed cylinder vote may first pull out one dense affine component at cost one. This keeps the local-cylinder optimization but fixes the dense-linear weakness of ordinary $\mathrm{ctc}$.

**Proof.** [theorems/04_recursions_and_cost_invariants/103_affine_cylinder_threshold_cost.md](theorems/04_recursions_and_cost_invariants/103_affine_cylinder_threshold_cost.md)

### Lemma 104. Affine-cylinder cost hierarchy

Let $\mathrm{afs}_{\pm}(f)$ be affine-free polynomial-threshold sparsity. Then

$$ \mathrm{actc}(f) \leq \mathrm{afs}_{\pm}(f) \leq \mathrm{ptfsp}(f). $$

Together with Lemma 103,

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \min\lbrace\mathrm{ctc}(f),\mathrm{afs}_{\pm}(f)\rbrace. $$

Consequently, if $f$ is nonconstant and $\deg_{\pm}(f)\leq d$, then

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq 1+\sum_{r=2}^{d}\binom{n}{r}. $$

> **Interpretation.** The affine-cylinder cost is a common refinement of signed local cylinder votes and affine-free sparse polynomial thresholds.

**Proof.** [theorems/04_recursions_and_cost_invariants/104_affine_cylinder_cost_hierarchy.md](theorems/04_recursions_and_cost_invariants/104_affine_cylinder_cost_hierarchy.md)

### Lemma 105. Halfspace intersections force many heads

There are an absolute constant $c\gt0$ and an infinite family of pairs of linear threshold functions

$$ T_n,U_n:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace $$

such that, for

$$ F_n(x):=T_n(x)\wedge U_n(x), $$

one has

$$ H^{\ast}(F_n)\geq c n. $$

> **Interpretation.** Even the intersection of two halfspaces can require linearly many heads. This is the direct head-complexity translation of Sherstov's optimal threshold-degree lower bound.

**Proof.** [theorems/04_recursions_and_cost_invariants/105_halfspace_intersection_head_lower_bound.md](theorems/04_recursions_and_cost_invariants/105_halfspace_intersection_head_lower_bound.md)

### Lemma 106. Threshold-vote and LTF decision-list separation

Let $s_{\mathrm{LTF}}(f)$ be the minimum number of LTF indicators in a strict weighted vote for $f$. There is an infinite family $F_n:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace$ such that

$$ s_{\mathrm{LTF}}(F_n)\leq2 \qquad \text{but} \qquad H^{\ast}(F_n)\geq c n $$

for an absolute constant $c\gt0$. The same family has LTF decision-list length at most $2$.

Thus neither threshold-vote size nor LTF decision-list length is a constant-factor upper bound for $H^{\ast}$.

> **Interpretation.** Thresholded LTF outputs are not raw attention-head features. A small outer vote of LTF gates gives a head upper bound only with an additional calibration hypothesis.

**Proof.** [theorems/04_recursions_and_cost_invariants/106_threshold_vote_and_ltf_decision_list_separation.md](theorems/04_recursions_and_cost_invariants/106_threshold_vote_and_ltf_decision_list_separation.md)

### Lemma 107. LTF raw calibration has linear worst case

For each $n$, define

$$ R_{\mathrm{LTF}}(n) := \max\lbrace\rho(T):T:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace\text{ is a nonconstant LTF}\rbrace. $$

There is an absolute constant $c\gt0$ and infinitely many $n$ such that

$$ R_{\mathrm{LTF}}(n)\geq c n. $$

Consequently, there are nonconstant LTFs $V_n$ with

$$ H^{\ast}(V_n)=1 \qquad \text{and} \qquad \rho(V_n)\geq c n. $$

> **Interpretation.** One-head computability after thresholding does not imply cheap raw access to the feature indicator. The gap is linear for some LTFs.

**Proof.** [theorems/04_recursions_and_cost_invariants/107_ltf_raw_calibration_linear_lower_bound.md](theorems/04_recursions_and_cost_invariants/107_ltf_raw_calibration_linear_lower_bound.md)

### Lemma 108. Affine-cylinder threshold cost invariances

The affine-cylinder threshold cost $\mathrm{actc}(f)$ is invariant under output complement, coordinate permutation, global bit-flip, and dummy-variable extension. It is monotone under restrictions: if $g$ is a restriction of $f$, then

$$ \mathrm{actc}(g)\leq\mathrm{actc}(f). $$

> **Interpretation.** The stronger optimized upper-bound invariant keeps the same canonical-search behavior as $\mathrm{ctc}$.

**Proof.** [theorems/04_recursions_and_cost_invariants/108_affine_cylinder_threshold_cost_invariances.md](theorems/04_recursions_and_cost_invariants/108_affine_cylinder_threshold_cost_invariances.md)

### Lemma 109. Low affine-cylinder cost is exact

If

$$ \mathrm{actc}(f)\leq2, $$

then

$$ H^{\ast}(f) = \begin{cases} 0, & \text{if } f \text{ is constant},\cr 1, & \text{if } f \text{ is a nonconstant LTF},\cr 2, & \text{otherwise}. \end{cases} $$

> **Interpretation.** A two-head affine-cylinder certificate is automatically exact unless the function collapses to the universal zero-head or one-head classes.

**Proof.** [theorems/04_recursions_and_cost_invariants/109_low_affine_cylinder_cost_exactness.md](theorems/04_recursions_and_cost_invariants/109_low_affine_cylinder_cost_exactness.md)

### Lemma 110. Affine-cylinder threshold-degree sandwich

For every Boolean function $f$,

$$ \deg_{\pm}(f) \leq H^{\ast}(f) \leq \mathrm{actc}(f) \leq \min\lbrace\mathrm{ctc}(f),\mathrm{afs}_{\pm}(f)\rbrace. $$

Consequently,

$$ \deg_{\pm}(f) \leq \mathrm{actc}(f) \leq \mathrm{ctc}(f), $$

and

$$ \deg_{\pm}(f) \leq \mathrm{afs}_{\pm}(f) \leq \mathrm{ptfsp}(f). $$

> **Interpretation.** The optimized affine-cylinder invariant is now bracketed by a classical lower bound and two certificate upper bounds.

**Proof.** [theorems/04_recursions_and_cost_invariants/110_affine_cylinder_threshold_degree_sandwich.md](theorems/04_recursions_and_cost_invariants/110_affine_cylinder_threshold_degree_sandwich.md)

### Lemma 111. Affine-cylinder cofactor interpolation

Let $f(z,y)$ have cofactors $f_0$ and $f_1$. Suppose the cofactors have strict affine-cylinder scores

$$ S_b(y) = A_b(y) + \sum_{\gamma\in\Gamma_b}c_{b,\gamma}C_{\gamma}(y) \qquad (b\in\lbrace0,1\rbrace), $$

with nonvacuous distinct cylinder supports. Write

$$ A_b(y)=a_b+\sum_{i=1}^{m}\alpha_{b,i}y_i. $$

Let $\Delta_{\mathrm{lin}}=\lbrace i:\alpha_{1,i}\neq\alpha_{0,i}\rbrace$ and $\Delta_{\mathrm{cyl}}=\lbrace\gamma:c_{1,\gamma}\neq c_{0,\gamma}\rbrace$ after missing cylinder coefficients are interpreted as $0$. Then

$$ \mathrm{actc}(f) \leq \eta(A_0,A_1) + \lvert\Delta_{\mathrm{lin}}\rvert + \sum_{\gamma=(P,N)\in\Gamma_0}\kappa(P,N) + \sum_{\gamma=(P,N)\in\Delta_{\mathrm{cyl}}}\kappa(P\cup\lbrace z\rbrace,N), $$

where

$$ \eta(A_0,A_1) := \mathbf{1} \left[ a_1\neq a_0 \text{ or } \exists i,\ \alpha_{0,i}\neq0 \right]. $$

> **Interpretation.** Cofactor interpolation for $\mathrm{actc}$ pays for a base affine-cylinder certificate and only for the affine slopes and cylinder coefficients that change across the split.

**Proof.** [theorems/04_recursions_and_cost_invariants/111_affine_cylinder_cofactor_interpolation.md](theorems/04_recursions_and_cost_invariants/111_affine_cylinder_cofactor_interpolation.md)

### Lemma 112. Split affine-cylinder cost

Let $f:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace$ with $n\geq1$. For each split coordinate $j$, write the cofactors as $f_0,f_1$. Given strict affine-cylinder cofactor scores $S_0,S_1$, let $I(S_0,S_1)$ be the interpolation cost from Lemma 111. Define

$$ \mathrm{sactc}_{j}(f) := \min _{S_0,S_1} I(S_0,S_1), \qquad \mathrm{sactc}(f) := \min _{1\leq j\leq n}\mathrm{sactc} _{j}(f). $$

Then

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{sactc}(f). $$

If $\mathrm{sactc}(f)\leq2$, then $H^{\ast}(f)$ has the exact constant, nonconstant LTF, or two-head split.

> **Interpretation.** The split affine-cylinder cost packages cofactor interpolation as a recursive certificate invariant.

**Proof.** [theorems/04_recursions_and_cost_invariants/112_split_affine_cylinder_cost.md](theorems/04_recursions_and_cost_invariants/112_split_affine_cylinder_cost.md)

### Lemma 113. Shared-cylinder split exactness

Let $f(z,y)$ have cofactor scores

$$ S_b(y)=A_b(y)+V(y), \qquad A_b(y)=a_b+\sum_{i=1}^{m}\alpha_{b,i}y_i, $$

with the same cylinder correction $V(y)=\sum_{\gamma\in\Gamma}c_{\gamma}C_{\gamma}(y)$ in both cofactors. Define

$$ K(V):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N), \qquad D(A_0,A_1):=\lbrace i:\alpha_{1,i}\neq\alpha_{0,i}\rbrace. $$

Then

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{sactc}(f) \leq \eta(A_0,A_1) + \lvert D(A_0,A_1)\rvert + K(V). $$

In particular, if the right-hand side is at most $2$, then $H^{\ast}(f)$ has the exact constant, nonconstant LTF, or two-head split.

> **Interpretation.** Shared cylinder corrections are paid once. The split pays only for the shared local cost plus affine changes.

**Proof.** [theorems/04_recursions_and_cost_invariants/113_shared_cylinder_split_exactness.md](theorems/04_recursions_and_cost_invariants/113_shared_cylinder_split_exactness.md)

### Lemma 114. Split affine-cylinder refines split affine-free support

For every Boolean function $f:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace$ with $n\geq1$,

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{sactc}(f) \leq \mathrm{scafs}_{\pm}(f), $$

where $\mathrm{scafs}_{\pm}$ is the split affine-free support invariant from Lemma 78.

> **Interpretation.** The split affine-cylinder invariant keeps every split sparse-PTF certificate and can only improve it when mixed-literal cylinders are cheaper than their monomial expansions.

**Proof.** [theorems/04_recursions_and_cost_invariants/114_split_affine_cylinder_refines_split_affine_free.md](theorems/04_recursions_and_cost_invariants/114_split_affine_cylinder_refines_split_affine_free.md)

### Lemma 115. Affine-cylinder first levels are exact

For every Boolean function $f$,

$$ \mathrm{actc}(f)=0 \qquad\Longleftrightarrow\qquad f \text{ is constant}, $$

and

$$ \mathrm{actc}(f)=1 \qquad\Longleftrightarrow\qquad f \text{ is a nonconstant LTF}. $$

Equivalently, $\mathrm{actc}(f)\geq2$ exactly when $f$ is neither constant nor a nonconstant LTF.

> **Interpretation.** The affine-cylinder cost has the same constant and one-head levels as $H^{\ast}$.

**Proof.** [theorems/04_recursions_and_cost_invariants/115_affine_cylinder_first_levels_exact.md](theorems/04_recursions_and_cost_invariants/115_affine_cylinder_first_levels_exact.md)

### Lemma 116. Split affine-cylinder first levels are exact

For every Boolean function $f:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace$ with $n\geq1$,

$$ \mathrm{sactc}(f)=0 \qquad\Longleftrightarrow\qquad f \text{ is constant}, $$

and

$$ \mathrm{sactc}(f)=1 \qquad\Longleftrightarrow\qquad f \text{ is a nonconstant LTF}. $$

Equivalently, $\mathrm{sactc}(f)\geq2$ exactly when $f$ is neither constant nor a nonconstant LTF.

> **Interpretation.** Optimizing over split affine-cylinder interpolations does not create any spurious zero-cost or one-cost functions.

**Proof.** [theorems/04_recursions_and_cost_invariants/116_split_affine_cylinder_first_levels_exact.md](theorems/04_recursions_and_cost_invariants/116_split_affine_cylinder_first_levels_exact.md)

### Lemma 117. Pure-cylinder affine perturbations are exact

Let $P,N\subseteq\lbrace1,\ldots,n\rbrace$ be disjoint with either $P=\varnothing$ or $N=\varnothing$. Suppose

$$ f(x)=1 \qquad\Longleftrightarrow\qquad A(x)+cC_{P,N}(x)\gt0 $$

strictly on the cube, where $A$ is affine. Then

$$ \mathrm{actc}(f)\leq2. $$

Consequently, $H^{\ast}(f)$ is exactly $0$, $1$, or $2$ according as $f$ is constant, a nonconstant LTF, or neither.

> **Interpretation.** One pure positive or pure negative cylinder can perturb an arbitrary affine score at exact two-head cost.

**Proof.** [theorems/04_recursions_and_cost_invariants/117_pure_cylinder_affine_perturbation_exact.md](theorems/04_recursions_and_cost_invariants/117_pure_cylinder_affine_perturbation_exact.md)

### Lemma 118. One-bit affine-cylinder branching

Let $T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace$ have a strict affine-cylinder score

$$ S(y)=A(y)+\sum_{\gamma\in\Gamma}c_{\gamma}C_{\gamma}(y), \qquad A(y)=a+\sum_{i=1}^{m}\alpha_i y_i. $$

Let $F(z,y)=G(z,T(y))$ for an arbitrary two-input Boolean gate $G$. For $b\in\lbrace0,1\rbrace$, let $\mu_b\in\lbrace-1,0,1\rbrace$ record whether the $b$-th slice of $G$ is $u$, $1-u$, or constant as a function of $u$. Let $\delta_b$ be the strict constant score for the constant slice when $\mu_b=0$, and $0$ otherwise. Define

$$ L(A):=\lbrace i:\alpha_i\neq0\rbrace, $$

and

$$ K(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N), \qquad K_z(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P\cup\lbrace z\rbrace,N). $$

Then

$$ \begin{aligned} H^{\ast}(F) &\leq \mathrm{actc}(F) \leq \mathrm{sactc}(F) \cr &\leq \eta_G(A) + \mathbf{1}[\mu_0\neq0]K(\Gamma) + \mathbf{1}[\mu_1\neq\mu_0] \bigl(\lvert L(A)\rvert+K_z(\Gamma)\bigr), \end{aligned} $$

where

$$ \eta_G(A) := \mathbf{1} \left[ \delta_1+\mu_1 a\neq \delta_0+\mu_0 a \text{ or } \exists i,\ \mu_0\alpha_i\neq0 \right]. $$

If this upper bound is at most $2$, then $H^{\ast}(F)$ has the exact constant, nonconstant LTF, or two-head split.

> **Interpretation.** One-bit gates over affine-cylinder features inherit local cylinder costs, rather than paying for a full monomial expansion.

**Proof.** [theorems/04_recursions_and_cost_invariants/118_one_bit_affine_cylinder_branching.md](theorems/04_recursions_and_cost_invariants/118_one_bit_affine_cylinder_branching.md)

### Lemma 119. Fresh-bit XOR affine-cylinder bound

Let $T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace$ have a strict affine-cylinder score

$$ S(y)=A(y)+\sum_{\gamma\in\Gamma}c_{\gamma}C_{\gamma}(y), \qquad A(y)=a+\sum_{i=1}^{m}\alpha_i y_i. $$

Let

$$ F(z,y):=z\oplus T(y). $$

Define

$$ \eta_{\oplus}(A) := \mathbf{1} \left[ a\neq0 \text{ or } \exists i,\ \alpha_i\neq0 \right], $$

and let

$$ L(A):=\lbrace i:\alpha_i\neq0\rbrace, $$

$$ K(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N), \qquad K_z(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P\cup\lbrace z\rbrace,N). $$

Then

$$ \deg_{\pm}(T)+1 \leq H^{\ast}(F) \leq \mathrm{actc}(F) \leq \mathrm{sactc}(F) \leq \eta_{\oplus}(A) + \lvert L(A)\rvert + K(\Gamma) + K_z(\Gamma). $$

The same bounds hold for XNOR. If the final upper bound equals $\deg_{\pm}(T)+1$, then both fresh-bit XOR and XNOR over $T$ have exact head complexity $\deg_{\pm}(T)+1$.

> **Interpretation.** Fresh-bit XOR has a matching target: threshold degree forces the lower bound, and affine-cylinder branching gives the upper-bound cost to try to match.

**Proof.** [theorems/04_recursions_and_cost_invariants/119_fresh_bit_xor_affine_cylinder_bound.md](theorems/04_recursions_and_cost_invariants/119_fresh_bit_xor_affine_cylinder_bound.md)

### Lemma 120. Affine-cylinder cofactor recursion

Let $f:\lbrace0,1\rbrace\times\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace$ have cofactors $f_0,f_1$, and let

$$ r_b:=\mathrm{actc}(f_b). $$

Then

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{sactc}(f) \leq 1+m+2(r_0+r_1)+\min\lbrace r_0,r_1\rbrace. $$

Equivalently, for either base cofactor $b$,

$$ \mathrm{sactc}(f) \leq 1+m+3r_b+2r_{1-b}. $$

> **Interpretation.** Even when the cofactor certificates do not align, affine-cylinder cost gives a safe Shannon recursion with linear switching overhead and lifted-cylinder costs.

**Proof.** [theorems/04_recursions_and_cost_invariants/120_affine_cylinder_cofactor_recursion.md](theorems/04_recursions_and_cost_invariants/120_affine_cylinder_cofactor_recursion.md)

### Lemma 121. Literal-gated affine-cylinder features

Let $T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace$ have a strict affine-cylinder score

$$ S(y)=A(y)+\sum_{\gamma\in\Gamma}c_{\gamma}C_{\gamma}(y), \qquad A(y)=a+\sum_{i=1}^{m}\alpha_i y_i. $$

Let $r(z)$ be either $z$ or $1-z$, and let $L(A)=\lbrace i:\alpha_i\neq0\rbrace$. Define $K_r(\Gamma)$ by lifting every cylinder through the literal $r$: if $r=z$, use $\kappa(P\cup\lbrace z\rbrace,N)$, and if $r=1-z$, use $\kappa(P,N\cup\lbrace z\rbrace)$.

Then

$$ H^{\ast}(r(z)\wedge T(y)) \leq 1+\lvert L(A)\rvert+K_r(\Gamma), $$

and

$$ H^{\ast}(r(z)\vee T(y)) \leq 1+\lvert L(A)\rvert+K_{1-r}(\Gamma). $$

If either displayed upper bound is at most $2$, then the corresponding gated function has the exact constant, nonconstant LTF, or two-head split.

> **Interpretation.** Literal conjunctions and disjunctions over affine-cylinder features only pay for changed slopes and one direction of lifted cylinder costs.

**Proof.** [theorems/04_recursions_and_cost_invariants/121_literal_gated_affine_cylinder_feature.md](theorems/04_recursions_and_cost_invariants/121_literal_gated_affine_cylinder_feature.md)

### Lemma 122. Lifted literal-gating cost

For a strict affine-cylinder score

$$ S(y)=A(y)+\sum_{\gamma\in\Gamma}c_{\gamma}C_{\gamma}(y), \qquad A(y)=a+\sum_{i=1}^{m}\alpha_i y_i, $$

let $L(A)=\lbrace i:\alpha_i\neq0\rbrace$ and define

$$ K_{+}(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P\cup\lbrace z\rbrace,N), \qquad K_{-}(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N\cup\lbrace z\rbrace). $$

Define

$$ \mathrm{lgactc}(T) := \min_S \left( \lvert L(A)\rvert+\min\lbrace K_{+}(\Gamma),K_{-}(\Gamma)\rbrace \right), $$

where the minimum ranges over strict affine-cylinder scores for $T$. Then for either literal $r(z)\in\lbrace z,1-z\rbrace$,

$$ H^{\ast}(r(z)\wedge T(y)) \leq 1+\mathrm{lgactc}(T), $$

and

$$ H^{\ast}(r(z)\vee T(y)) \leq 1+\mathrm{lgactc}(T). $$

Moreover,

$$ \mathrm{lgactc}(T) \leq m+2\mathrm{actc}(T). $$

If $\mathrm{lgactc}(T)\leq1$, then every literal-gated function here that is neither constant nor a nonconstant LTF is exactly two-head.

> **Interpretation.** Literal gating is controlled by an optimized lifted cost: the affine slopes of the feature plus the cheaper lifted orientation of its cylinder correction.

**Proof.** [theorems/04_recursions_and_cost_invariants/122_lifted_literal_gating_cost.md](theorems/04_recursions_and_cost_invariants/122_lifted_literal_gating_cost.md)

### Lemma 123. Non-XOR gates through lifted cost

Let $T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace$ be any Boolean function, and let $G:\lbrace0,1\rbrace^{2}\to\lbrace0,1\rbrace$ be a two-input Boolean gate that is neither XOR nor XNOR. Define

$$ F(z,y):=G(z,T(y)). $$

Then:

1. If $G$ is constant or depends only on $z$, then $H^{\ast}(F)\leq1$.

2. If $G$ depends only on its second input, then $H^{\ast}(F)\leq\mathrm{actc}(T)$.

3. If $G$ genuinely depends on both inputs, then

$$ H^{\ast}(F) \leq 1+\mathrm{lgactc}(T). $$

In particular,

$$ H^{\ast}(G(z,T(y))) \leq 1+\mathrm{actc}(T)+\mathrm{lgactc}(T), $$

with the sharper case split above whenever the gate form is known.

> **Interpretation.** Among non-XOR gates, the only real fresh-bit interaction cost is literal gating. It is governed by $\mathrm{lgactc}$, not by a full head representation of $T$.

**Proof.** [theorems/04_recursions_and_cost_invariants/123_non_xor_gate_lifted_cost.md](theorems/04_recursions_and_cost_invariants/123_non_xor_gate_lifted_cost.md)

### Lemma 124. Fresh-bit XOR target cost

For a strict affine-cylinder score

$$ S(y)=A(y)+\sum_{\gamma\in\Gamma}c_{\gamma}C_{\gamma}(y), \qquad A(y)=a+\sum_{i=1}^{m}\alpha_i y_i, $$

let $L(A)=\lbrace i:\alpha_i\neq0\rbrace$ and define

$$ K_{0}(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N), \qquad K_{+}(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P\cup\lbrace z\rbrace,N), \qquad K_{-}(\Gamma):=\sum_{\gamma=(P,N)\in\Gamma}\kappa(P,N\cup\lbrace z\rbrace), $$

and define

$$ \eta_{\oplus}(A) := \mathbf{1} \left[ a\neq0 \text{ or } \exists i,\ \alpha_i\neq0 \right]. $$

Set

$$ \mathrm{xactc}(T) := \min_S \left( \eta_{\oplus}(A) + \lvert L(A)\rvert + K_{0}(\Gamma) + \min\lbrace K_{+}(\Gamma),K_{-}(\Gamma)\rbrace \right), $$

where the minimum ranges over strict affine-cylinder scores for $T$. Then

$$ \deg_{\pm}(T)+1 \leq H^{\ast}(z\oplus T(y)) \leq \mathrm{xactc}(T), $$

and the same bounds hold for XNOR. If

$$ \mathrm{xactc}(T)=\deg_{\pm}(T)+1, $$

then fresh-bit XOR and XNOR over $T$ have exact head complexity $\deg_{\pm}(T)+1$. Moreover,

$$ \mathrm{xactc}(T) \leq 1+m+3\mathrm{actc}(T). $$

> **Interpretation.** The exact fresh-bit XOR problem is now the equality problem $\mathrm{xactc}(T)=\deg_{\pm}(T)+1$.

**Proof.** [theorems/04_recursions_and_cost_invariants/124_fresh_bit_xor_target_cost.md](theorems/04_recursions_and_cost_invariants/124_fresh_bit_xor_target_cost.md)

### Lemma 125. Optimized one-bit cost invariances

Let

$$ T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace. $$

The optimized one-bit costs $\mathrm{lgactc}(T)$ and $\mathrm{xactc}(T)$ have the following properties:

1. Output complement does not change either cost:

$$ \mathrm{lgactc}(1-T)=\mathrm{lgactc}(T), \qquad \mathrm{xactc}(1-T)=\mathrm{xactc}(T). $$

2. Coordinate permutations of the feature variables do not change either cost.

3. Global bit-flip of all feature variables does not change either cost.

4. Restrictions of the feature variables cannot increase either cost:

$$ \mathrm{lgactc}(R)\leq\mathrm{lgactc}(T), \qquad \mathrm{xactc}(R)\leq\mathrm{xactc}(T), $$

whenever $R$ is a restriction of $T$.

5. Adding dummy feature variables does not change either cost.

> **Interpretation.** The optimized literal-gating and fresh-XOR targets can be minimized on canonical feature representatives, and hard feature restrictions remain valid witnesses for lower-bound attempts on these costs.

**Proof.** [theorems/04_recursions_and_cost_invariants/125_optimized_one_bit_cost_invariances.md](theorems/04_recursions_and_cost_invariants/125_optimized_one_bit_cost_invariances.md)

### Lemma 126. Endpoint feature fresh-XOR exactness

Let

$$ L(y)=\sum_{i\in S}\lambda_i y_i, \qquad \lambda_i\gt0, $$

with $S\neq\varnothing$, and set

$$ \Lambda:=\sum_{i\in S}\lambda_i. $$

Define

$$ O_L(y):=\mathbf{1}[L(y)\gt0], \qquad A_L(y):=\mathbf{1}[L(y)=\Lambda]. $$

Then

$$ H^{\ast}(z\oplus O_L(y)) = H^{\ast}(1-(z\oplus O_L(y))) = 2, $$

and

$$ H^{\ast}(z\oplus A_L(y)) = H^{\ast}(1-(z\oplus A_L(y))) = 2. $$

> **Interpretation.** Positive endpoint OR-type and AND-type features have exact two-head fresh-bit XOR, even though the generic one-bit LTF branching bound grows with the support size.

**Proof.** [theorems/04_recursions_and_cost_invariants/126_endpoint_feature_fresh_xor_exact.md](theorems/04_recursions_and_cost_invariants/126_endpoint_feature_fresh_xor_exact.md)

### Lemma 127. Affine endpoint fresh-XOR exactness

Let

$$ L(y)=a+\sum_{i=1}^{m}\alpha_i y_i $$

be a nonconstant affine statistic on $\lbrace0,1\rbrace^{m}$. Let

$$ \ell_{\min}:=\min_y L(y), \qquad \ell_{\max}:=\max_y L(y), $$

and define

$$ E_{\min}(y):=\mathbf{1}[L(y)=\ell_{\min}], \qquad E_{\max}(y):=\mathbf{1}[L(y)=\ell_{\max}]. $$

Then

$$ H^{\ast}(z\oplus E_{\min}(y)) = H^{\ast}(1-(z\oplus E_{\min}(y))) = 2, $$

and

$$ H^{\ast}(z\oplus E_{\max}(y)) = H^{\ast}(1-(z\oplus E_{\max}(y))) = 2. $$

> **Interpretation.** Endpoint fresh-XOR exactness is an affine-image endpoint phenomenon, not a positive-coefficient artifact.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/127_affine_endpoint_fresh_xor_exact.md](theorems/05_positive_statistic_gates_and_grids/127_affine_endpoint_fresh_xor_exact.md)

### Lemma 128. Affine endpoint one-bit gate classification

Let

$$ L(y)=a+\sum_{i=1}^{m}\alpha_i y_i $$

be a nonconstant affine statistic on $\lbrace0,1\rbrace^{m}$, and let $E$ be either endpoint predicate $E_{\min}$ or $E_{\max}$. For any two-input Boolean gate $G:\lbrace0,1\rbrace^{2}\to\lbrace0,1\rbrace$, define

$$ F(z,y):=G(z,E(y)). $$

Then

$$ H^{\ast}(F)= \begin{cases} 0 & \text{if } G \text{ is constant},\cr 2 & \text{if } G \text{ is XOR or XNOR},\cr 1 & \text{otherwise}. \end{cases} $$

> **Interpretation.** Affine endpoint features have no hidden one-bit gate complexity: all non-XOR gates are LTFs, and XOR or XNOR are exactly two-head.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/128_affine_endpoint_one_bit_gate_classification.md](theorems/05_positive_statistic_gates_and_grids/128_affine_endpoint_one_bit_gate_classification.md)

### Lemma 129. LTF one-bit gate classification

Let

$$ T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace $$

be a nonconstant LTF, and let $G:\lbrace0,1\rbrace^{2}\to\lbrace0,1\rbrace$ be any Boolean gate. Define

$$ F(z,y):=G(z,T(y)). $$

Then

$$ H^{\ast}(F)= \begin{cases} 0 & \text{if } G \text{ is constant},\cr 2 & \text{if } G \text{ is XOR or XNOR},\cr 1 & \text{otherwise}. \end{cases} $$

> **Interpretation.** A raw bit and one LTF feature have a complete exact gate table. Fresh XOR and XNOR are exactly two-head; every other nonconstant gate is one-head.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/129_ltf_one_bit_gate_classification.md](theorems/05_positive_statistic_gates_and_grids/129_ltf_one_bit_gate_classification.md)

### Lemma 130. Fresh-XOR affine-statistic sign-change bound

Let

$$ L(y)=a+\sum_{i=1}^{m}\alpha_i y_i $$

be an affine statistic on $\lbrace0,1\rbrace^{m}$, let $G:\mathrm{Im}(L)\to\lbrace0,1\rbrace$, and define $T(y):=G(L(y))$. Let $C$ be the number of sign changes of $G$ along the ordered image of $L$, and set

$$ D_{\oplus}(C):= \begin{cases} 2C+1 & \text{if } C \text{ is even},\cr 2C & \text{if } C \text{ is odd}. \end{cases} $$

If $C=0$, then fresh XOR and XNOR over $T$ have exact value $1$. If $C=1$, they have exact value $2$. If $C\geq2$, then

$$ H^{\ast}(z\oplus T(y)) \leq 1+\sum_{r=2}^{\min\lbrace D_{\oplus}(C),k+1\rbrace}\binom{k+1}{r}, $$

where $k$ is the number of nonzero variable coefficients of $L$, and the same upper bound holds for XNOR.

> **Interpretation.** Separating the two fresh-bit slices turns the label sequence into $G$ followed by its complement, so the sign-change count doubles with one possible boundary change.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/130_fresh_xor_affine_statistic_sign_change_bound.md](theorems/05_positive_statistic_gates_and_grids/130_fresh_xor_affine_statistic_sign_change_bound.md)

### Lemma 131. Positive-projection fresh-XOR sign-change bound

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

let $G:\mathrm{Im}(t)\to\lbrace0,1\rbrace$, and define $T(y):=G(t(y))$. Let $C$ be the number of sign changes of $G$ along the ordered image of $t$, and set

$$ D_{\oplus}(C):= \begin{cases} 2C+1 & \text{if } C \text{ is even},\cr 2C & \text{if } C \text{ is odd}. \end{cases} $$

If $C=0$, then fresh XOR and XNOR over $T$ have exact value $1$. If $C=1$, they have exact value $2$. If $C\geq2$, then

$$ H^{\ast}(z\oplus T(y))\leq D_{\oplus}(C), $$

and the same upper bound holds for XNOR. If $\deg_{\pm}(T)+1=D_{\oplus}(C)$, then these values are exact.

> **Interpretation.** Positive projections avoid the affine-free support penalty in Lemma 130: fresh XOR costs at most the sign changes of the separated sequence $G,1-G$.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/131_positive_projection_fresh_xor_sign_change_bound.md](theorems/05_positive_statistic_gates_and_grids/131_positive_projection_fresh_xor_sign_change_bound.md)

### Lemma 132. Positive-projection one-bit gate bound

Let $T(y)=F(t(y))$ for a positive weighted sum

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0. $$

For a two-input Boolean gate $G$, define $H_G(z,y):=G(z,T(y))$. Write the image of $t$ as

$$ 0=\tau_0\lt\tau_1\lt\cdots\lt\tau_{M-1}, $$

and let $C_{G,t}$ be the sign-change count of the concatenated sequence

$$ G(0,F(\tau_0)),\ldots,G(0,F(\tau_{M-1})), G(1,F(\tau_0)),\ldots,G(1,F(\tau_{M-1})). $$

Then

$$ H^{\ast}(H_G)\leq C_{G,t}. $$

The cases $C_{G,t}=0,1,2$ have the exact constant, nonconstant LTF, or two-head split.

> **Interpretation.** Every one-bit gate over a positive-projection feature remains controlled by a one-dimensional sign-change count after separating the two raw-bit slices.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/132_positive_projection_one_bit_gate_bound.md](theorems/05_positive_statistic_gates_and_grids/132_positive_projection_one_bit_gate_bound.md)

### Lemma 133. Internal positive slab literal-gate exactness

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and let $S(y):=\mathbf{1}[\alpha\leq t(y)\leq\beta]$ be an internal non-LTF slab whose ordered label sequence has the form

$$ 0,\ldots,0,1,\ldots,1,0,\ldots,0 $$

with all three displayed blocks nonempty. For either raw literal $r(z)\in\lbrace z,1-z\rbrace$,

$$ H^{\ast}(r(z)\wedge S(y)) = H^{\ast}(1-(r(z)\wedge S(y))) = 2. $$

> **Interpretation.** Literal-gating an internal positive slab through the slab itself is exactly two-head.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/133_internal_positive_slab_literal_gate_exact.md](theorems/05_positive_statistic_gates_and_grids/133_internal_positive_slab_literal_gate_exact.md)

### Lemma 134. Internal positive slab one-bit gate table

Under the same internal positive slab hypotheses as Lemma 133, let $F_G(z,y):=G(z,S(y))$ for any two-input Boolean gate $G$. Then:

1. constants cost $0$;
2. raw-bit literals cost $1$;
3. the feature literals $S$ and $1-S$ cost $2$;
4. gates of the form $r\wedge S$ and their complements cost $2$;
5. gates of the form $r\wedge(1-S)$ and their complements satisfy $2\leq H^{\ast}\leq3$;
6. XOR and XNOR satisfy $3\leq H^{\ast}\leq5$.

These cases exhaust all two-input gates.

> **Interpretation.** Internal positive slabs now have a finite gate table. Only complement-slab literal gates and XOR/XNOR remain unresolved.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/134_internal_positive_slab_gate_table.md](theorems/05_positive_statistic_gates_and_grids/134_internal_positive_slab_gate_table.md)

### Lemma 135. Positive-statistic raw-bit quadratic span

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0. $$

If $P(z,y)$ is a strict sign polynomial for $f(z,y)$ of the form

$$ P(z,y)=p_0+p_1t(y)+p_2t(y)^2+q_0z+q_1z  t(y), $$

then

$$ H^{\ast}(f)\leq2. $$

> **Interpretation.** Any strict quadratic threshold in one positive statistic and one raw bit has a two-head certificate.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/135_positive_statistic_raw_bit_quadratic_span.md](theorems/05_positive_statistic_gates_and_grids/135_positive_statistic_raw_bit_quadratic_span.md)

### Lemma 136. Positive-statistic raw-bit cubic span

Let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0. $$

If $P(z,y)$ is a strict sign polynomial for $f(z,y)$ of the form

$$ P(z,y) = \sum_{r=0}^{3}a_rt(y)^r + z\sum_{r=0}^{2}b_rt(y)^r, $$

then

$$ H^{\ast}(f)\leq3. $$

> **Interpretation.** Any strict cubic threshold in one positive statistic and one raw bit has a three-head certificate.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/136_positive_statistic_raw_bit_cubic_span.md](theorems/05_positive_statistic_gates_and_grids/136_positive_statistic_raw_bit_cubic_span.md)

### Lemma 137. Internal positive slab exact gate table

Under the same internal positive slab hypotheses as Lemma 133, let $F_G(z,y):=G(z,S(y))$ for any two-input Boolean gate $G$. Then

$$ H^{\ast}(F_G)= \begin{cases} 0 & \text{if }G\text{ is constant},\cr 1 & \text{if }G\text{ is a raw-bit literal},\cr 3 & \text{if }G\text{ is XOR or XNOR},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** The remaining internal positive-slab brackets from Lemma 134 collapse to exact values.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/137_internal_positive_slab_exact_gate_table.md](theorems/05_positive_statistic_gates_and_grids/137_internal_positive_slab_exact_gate_table.md)

### Lemma 138. Positive-statistic raw-bit degree span

Let $d\geq1$, let

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0, $$

and suppose $P(z,y)$ is a strict sign polynomial for $f(z,y)$ of the form

$$ P(z,y) = \sum_{r=0}^{d}a_rt(y)^r + z\sum_{r=0}^{d-1}b_rt(y)^r. $$

Then

$$ H^{\ast}(f)\leq d. $$

> **Interpretation.** A one-dimensional positive statistic remains head-efficient after adjoining one raw bit: degree $d$ in $(t,z)$ costs at most $d$ heads.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/138_positive_statistic_raw_bit_degree_span.md](theorems/05_positive_statistic_gates_and_grids/138_positive_statistic_raw_bit_degree_span.md)

### Lemma 139. Positive-statistic fresh-XOR sign-change bound

Let $T(y)=F(t(y))$ be nonconstant for a positive statistic

$$ t(y)=\sum_{i=1}^{m}\lambda_i y_i, \qquad \lambda_i\gt0. $$

Let $C$ be the number of sign changes in the ordered label sequence of $F$ on the image of $t$. Then

$$ \deg_{\pm}(T)+1 \leq H^{\ast}(z\oplus T(y)) \leq C+1, $$

and the same bounds hold for XNOR. If $\deg_{\pm}(T)=C$, then both values are exactly $C+1$.

> **Interpretation.** For positive-statistic features, fresh XOR costs at most one more than the original one-dimensional sign-change count.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/139_positive_statistic_fresh_xor_sign_change_bound.md](theorems/05_positive_statistic_gates_and_grids/139_positive_statistic_fresh_xor_sign_change_bound.md)

### Lemma 140. Positive-statistic non-XOR gate sign-change bound

Under the same hypotheses as Lemma 139, let $G$ be neither XOR nor XNOR and define

$$ H_G(z,y):=G(z,T(y)). $$

Then constants have exact value $0$, raw-bit literals have exact value $1$, and every other gate satisfies

$$ \deg_{\pm}(T) \leq H^{\ast}(H_G) \leq C. $$

If $\deg_{\pm}(T)=C$, then every nonconstant feature-dependent non-XOR and non-XNOR gate has exact value $C$.

> **Interpretation.** Non-XOR one-bit branching over a positive-statistic feature preserves the original sign-change cost.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/140_positive_statistic_non_xor_gate_sign_change_bound.md](theorems/05_positive_statistic_gates_and_grids/140_positive_statistic_non_xor_gate_sign_change_bound.md)

### Lemma 141. Degree-tight positive-statistic gate classification

Under the same hypotheses as Lemma 139, assume

$$ \deg_{\pm}(T)=C. $$

For any two-input Boolean gate $G$, define $H_G(z,y):=G(z,T(y))$. Then

$$ H^{\ast}(H_G)= \begin{cases} 0 & \text{if }G\text{ is constant},\cr 1 & \text{if }G\text{ is a raw-bit literal},\cr C+1 & \text{if }G\text{ is XOR or XNOR},\cr C & \text{otherwise}. \end{cases} $$

> **Interpretation.** Whenever the positive-statistic sign-change upper bound is threshold-degree tight for the feature, the complete one-bit gate table is exact.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/141_degree_tight_positive_statistic_gate_classification.md](theorems/05_positive_statistic_gates_and_grids/141_degree_tight_positive_statistic_gate_classification.md)

### Lemma 142. Symmetric-feature one-bit gate exactness

Let $T:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace$ be a nonconstant symmetric Boolean function, and let $C$ be the number of sign changes in its Hamming-weight sequence. For any two-input Boolean gate $G$, define $H_G(z,y):=G(z,T(y))$. Then

$$ H^{\ast}(H_G)= \begin{cases} 0 & \text{if }G\text{ is constant},\cr 1 & \text{if }G\text{ is a raw-bit literal},\cr C+1 & \text{if }G\text{ is XOR or XNOR},\cr C & \text{otherwise}. \end{cases} $$

> **Interpretation.** The exact symmetric classification is stable under adjoining one raw bit and applying any two-input gate.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/142_symmetric_feature_one_bit_gate_exact.md](theorems/05_positive_statistic_gates_and_grids/142_symmetric_feature_one_bit_gate_exact.md)

### Lemma 143. Positive-statistic one-bit gate sandwich

Let $T(y)=F(t(y))$ be nonconstant for a positive statistic $t$, let $C$ be the sign-change count of $F$ along the ordered image of $t$, and set $d:=\deg_{\pm}(T)$. For any two-input Boolean gate $G$, define $H_G(z,y):=G(z,T(y))$. Then constants cost $0$, raw-bit literals cost $1$, XOR and XNOR satisfy

$$ d+1 \leq H^{\ast}(H_G) \leq C+1, $$

and every other nonconstant gate satisfies

$$ d \leq H^{\ast}(H_G) \leq C. $$

> **Interpretation.** For one-bit gates over a positive-statistic feature, the only possible gap is the original gap between threshold degree and sign-change count.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/143_positive_statistic_one_bit_gate_sandwich.md](theorems/05_positive_statistic_gates_and_grids/143_positive_statistic_one_bit_gate_sandwich.md)

### Lemma 144. Positive-order one-bit gate sandwich

Let $f:\lbrace0,1\rbrace^{m}\to\lbrace0,1\rbrace$, and let $C_{+}(f)$ be the optimized positive-projection sign-change count. For any two-input Boolean gate $G$, define $H_G(z,y):=G(z,f(y))$. Constants cost $0$, raw-bit literals cost $1$, and if $f$ is nonconstant, XOR and XNOR satisfy

$$ \deg_{\pm}(f)+1 \leq H^{\ast}(H_G) \leq C_{+}(f)+1, $$

while every other feature-dependent gate satisfies

$$ \deg_{\pm}(f) \leq H^{\ast}(H_G) \leq C_{+}(f). $$

> **Interpretation.** The positive-order sign-change invariant is stable under one-bit gates, with exactly one extra unit for XOR and XNOR.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/144_positive_order_one_bit_gate_sandwich.md](theorems/05_positive_statistic_gates_and_grids/144_positive_order_one_bit_gate_sandwich.md)

### Lemma 145. Common positive-statistic multi-slice bound

Let $k\geq0$, let $z\in\lbrace0,1\rbrace^{k}$ be raw bits, and let $t(y)=\sum_i\lambda_i y_i$ have positive coefficients. Suppose every raw-bit slice factors through $t$:

$$ f(a,y)=F_a(t(y)). $$

Let $C_a$ be the sign-change count of $F_a$ along the ordered image of $t$. Then

$$ H^{\ast}(f) \leq \sum_{a\in\lbrace0,1\rbrace^{k}} C_a + 2^{k}-1. $$

> **Interpretation.** If all raw-bit slices share one positive statistic, the full function is controlled by the total within-slice variation plus at most one jump between adjacent raw slices.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/145_common_positive_statistic_multi_slice_bound.md](theorems/05_positive_statistic_gates_and_grids/145_common_positive_statistic_multi_slice_bound.md)

### Lemma 146. Multi-raw positive-statistic degree bound

Under the same setup as Lemma 145, suppose $P$ is a strict sign polynomial for $f$ and the raw slice $P(a,\cdot)$ is a univariate polynomial in $t(y)$ of degree at most $d_a$. Then

$$ H^{\ast}(f) \leq \sum_{a\in\lbrace0,1\rbrace^{k}}d_a + 2^{k}-1. $$

In particular, if $P$ has degree at most $d$ in $t(y),z_1,\ldots,z_k$, reduced multilinearly in the raw bits, then

$$ H^{\ast}(f)\leq2^{k}(d+1)-1. $$

> **Interpretation.** A bounded-degree threshold in one positive statistic and $k$ raw bits has a head bound exponential only in $k$, not in the number of feature variables.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/146_multi_raw_positive_statistic_degree_bound.md](theorems/05_positive_statistic_gates_and_grids/146_multi_raw_positive_statistic_degree_bound.md)

### Lemma 147. Ordered common positive-statistic slice bound

Under the same shared-statistic setup as Lemma 145 with $k\geq1$, choose positive raw weights $\rho_1,\ldots,\rho_k$ with distinct subset sums, and order the raw assignments by $\sum_j\rho_ja_j$. Let $J_{\rho}$ be the number of actual label changes between the end of one raw slice and the beginning of the next. Then

$$ H^{\ast}(f) \leq \sum_{a\in\lbrace0,1\rbrace^{k}}C_a+J_{\rho}. $$

> **Interpretation.** The multi-slice construction pays only for boundary label changes that actually occur in the chosen raw-slice order.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/147_ordered_common_positive_statistic_slice_bound.md](theorems/05_positive_statistic_gates_and_grids/147_ordered_common_positive_statistic_slice_bound.md)

### Lemma 148. Multi-raw gate over positive-statistic feature bound

Let $T(y)=F(t(y))$ have $C$ sign changes along a positive statistic $t$, and let

$$ H_G(z,y):=G(z,T(y)) $$

for a Boolean gate $G:\lbrace0,1\rbrace^{k}\times\lbrace0,1\rbrace\to\lbrace0,1\rbrace$. For a chosen positive raw-slice order, let $N_G$ be the number of raw assignments whose slice is $T$ or $1-T$, and let $J_{\rho,G}$ be the number of actual boundary jumps between consecutive raw slices. Then

$$ H^{\ast}(H_G)\leq N_GC+J_{\rho,G}. $$

> **Interpretation.** A multi-raw gate over one positive-statistic feature pays one copy of the feature variation for each raw slice that actually depends on the feature, plus actual boundary jumps.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/148_multi_raw_gate_positive_statistic_feature_bound.md](theorems/05_positive_statistic_gates_and_grids/148_multi_raw_gate_positive_statistic_feature_bound.md)

### Lemma 149. Optimized ordered positive-statistic slice cost

For a split $f(z,y)$ with $k\geq1$ raw bits, define $\mathrm{osc}_{+}^{z\mid y}(f)$ by minimizing, over all common positive-statistic certificates $t(y)$ for the raw slices and all positive raw-slice orders $\rho$, the cost

$$ \Omega_{t,\rho}(f) = \sum_{a\in\lbrace0,1\rbrace^{k}} C_a+J_{t,\rho}(f), $$

where $C_a$ is the within-slice sign-change count and $J_{t,\rho}(f)$ is the actual boundary-jump count in the chosen raw order. Then

$$ H^{\ast}(f)\leq \mathrm{osc}_{+}^{z\mid y}(f). $$

> **Interpretation.** The ordered multi-slice construction becomes an optimized invariant once the common statistic and raw order are minimized.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/149_optimized_ordered_positive_statistic_slice_cost.md](theorems/05_positive_statistic_gates_and_grids/149_optimized_ordered_positive_statistic_slice_cost.md)

### Lemma 150. Ordered slice degree bound

Let $P(z,y)$ be a strict sign polynomial for $f(z,y)$, and suppose every raw slice has the form

$$ P(a,y)=p_a(t(y)), \qquad \deg p_a\leq d_a, $$

for one positive statistic $t(y)$. For any positive raw order $\rho$,

$$ H^{\ast}(f) \leq \sum_{a\in\lbrace0,1\rbrace^{k}}d_a+J_{\rho}(f). $$

In particular, if $P$ has total degree at most $d$ in $t(y),z_1,\ldots,z_k$, then

$$ H^{\ast}(f) \leq 2^k d+\min_{\rho}J_{\rho}(f). $$

> **Interpretation.** Polynomial degree pays for within-slice variation, while the ordered construction keeps the exact boundary price.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/150_ordered_slice_degree_bound.md](theorems/05_positive_statistic_gates_and_grids/150_ordered_slice_degree_bound.md)

### Lemma 151. Positive mixed boundary gate bound

For raw functions $p,q:\lbrace0,1\rbrace^{k}\to\lbrace0,1\rbrace$, let $B_{+}(p,q)$ be the minimum, over positive raw orders, of the number of adjacent mixed transitions $p(a^{(r)})\neq q(a^{(r+1)})$.

Let $T(y)=F(t(y))$ have sign-change count $C$, and let

$$ e_{\min}=F(\tau_0), \qquad e_{\max}=F(\tau_{M-1}). $$

For a gate $G:\lbrace0,1\rbrace^{k}\times\lbrace0,1\rbrace\to\lbrace0,1\rbrace$, put $g_e(a)=G(a,e)$ and $N_G=\lvert\lbrace a:g_0(a)\neq g_1(a)\rbrace\rvert$. Then

$$ H^{\ast}\bigl(G(z,T(y))\bigr) \leq N_G C+B_{+}(g_{e_{\max}},g_{e_{\min}}). $$

> **Interpretation.** The boundary term for a multi-raw gate depends only on the two raw endpoint functions.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/151_positive_mixed_boundary_gate_bound.md](theorems/05_positive_statistic_gates_and_grids/151_positive_mixed_boundary_gate_bound.md)

### Lemma 152. Equal-endpoint multi-raw gate bound

In the setup of Lemma 151, suppose

$$ F(\tau_0)=F(\tau_{M-1})=e. $$

Then

$$ H^{\ast}\bigl(G(z,T(y))\bigr) \leq N_G C+C_{+}(g_e). $$

> **Interpretation.** If the feature starts and ends at the same label, the boundary price is the positive-order variation of a raw endpoint function.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/152_equal_endpoint_multi_raw_gate_bound.md](theorems/05_positive_statistic_gates_and_grids/152_equal_endpoint_multi_raw_gate_bound.md)

### Lemma 153. Mixed boundary inequality

For raw functions $p,q:\lbrace0,1\rbrace^{k}\to\lbrace0,1\rbrace$, let

$$ D(p,q):=\lvert\lbrace a:p(a)\neq q(a)\rbrace\rvert. $$

Then

$$ B_{+}(p,q) \leq \min\lbrace C_{+}(p),C_{+}(q)\rbrace+D(p,q). $$

Consequently, if $F(\tau_0)\neq F(\tau_{M-1})$ in Lemma 151, then

$$ H^{\ast}\bigl(G(z,T(y))\bigr) \leq N_GC+\min\lbrace C_{+}(g_0),C_{+}(g_1)\rbrace+N_G. $$

> **Interpretation.** Opposite feature endpoints cost ordinary raw variation plus one unit for each raw slice where the gate depends on the feature.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/153_mixed_boundary_inequality.md](theorems/05_positive_statistic_gates_and_grids/153_mixed_boundary_inequality.md)

### Lemma 154. Raw-mask gate endpoint bounds

Let $R:\lbrace0,1\rbrace^{k}\to\lbrace0,1\rbrace$ be a raw mask, let $T(y)=F(t(y))$ have sign-change count $C$, and put $e_0=F(\tau_0)$, $e_1=F(\tau_{M-1})$. Let

$$ r_1=\lvert R^{-1}(1)\rvert, \qquad r_0=\lvert R^{-1}(0)\rvert, \qquad C_R=C_{+}(R). $$

For $A=R\wedge T$,

$$ H^{\ast}(A)\leq \begin{cases} r_1C, & e_0=e_1=0,\cr r_1C+C_R, & e_0=e_1=1,\cr r_1(C+1), & e_0\neq e_1. \end{cases} $$

For $O=R\vee T$,

$$ H^{\ast}(O)\leq \begin{cases} r_0C, & e_0=e_1=1,\cr r_0C+C_R, & e_0=e_1=0,\cr r_0(C+1), & e_0\neq e_1. \end{cases} $$

For $X=R\oplus T$,

$$ H^{\ast}(X)\leq \begin{cases} 2^kC+C_R, & e_0=e_1,\cr 2^k(C+1)+C_R, & e_0\neq e_1. \end{cases} $$

> **Interpretation.** For common raw-mask gates, the ordered-slice boundary cost collapses to raw support size or raw positive-order variation.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/154_raw_mask_gate_endpoint_bounds.md](theorems/05_positive_statistic_gates_and_grids/154_raw_mask_gate_endpoint_bounds.md)

### Theorem 155. Multi-raw gate sandwich and single-slice exactness

Let $T(y)=F(t(y))$ be a nonconstant positive-statistic feature with sign-change count $C$, and let $G:\lbrace0,1\rbrace^{k}\times\lbrace0,1\rbrace\to\lbrace0,1\rbrace$. Put $H_G(z,y)=G(z,T(y))$, $g_e(a)=G(a,e)$, and $N_G=\lvert\lbrace a:g_0(a)\neq g_1(a)\rbrace\rvert$. Then

$$ \max\left\lbrace \mathbf{1}_{N_G\gt0}H^{\ast}(T), H^{\ast}(g_0), H^{\ast}(g_1) \right\rbrace \leq H^{\ast}(H_G) \leq N_GC+B _{+}(g _{e _{\max}},g _{e _{\min}}). $$

In particular, if $H^{\ast}(T)=C$, $N_G=1$, and $B_{+}(g_{e_{\max}},g_{e_{\min}})=0$, then

$$ H^{\ast}(H_G)=C. $$

> **Interpretation.** The mixed-boundary upper bound becomes exact as soon as exactly one raw slice depends on an already solved feature and the endpoint boundary is silent.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/155_multi_raw_gate_sandwich_exactness.md](theorems/05_positive_statistic_gates_and_grids/155_multi_raw_gate_sandwich_exactness.md)

### Theorem 156. Address localization exactness

Let $T(y)=F(t(y))$ have sign-change count $C$, threshold degree $d$, and endpoint labels $e_0,e_1$. For a raw address $a$, let $M_a(z)=\mathbf{1}[z=a]$. If $e_0=e_1=0$, then

$$ d \leq H^{\ast}\bigl(M_a(z)\wedge T(y)\bigr) \leq C. $$

If $e_0=e_1=1$, then

$$ d \leq H^{\ast}\bigl((1-M_a(z))\vee T(y)\bigr) \leq C. $$

Thus these localized gates are exact whenever $\deg_{\pm}(T)=C$. More generally, for any raw mask $R$ with $r_1=\lvert R^{-1}(1)\rvert\gt0$ and $e_0=e_1=0$,

$$ d \leq H^{\ast}\bigl(R(z)\wedge T(y)\bigr) \leq r_1C, $$

and for any raw mask with $r_0=\lvert R^{-1}(0)\rvert\gt0$ and $e_0=e_1=1$,

$$ d \leq H^{\ast}\bigl(R(z)\vee T(y)\bigr) \leq r_0C. $$

> **Interpretation.** A solved feature can be localized to one raw address at no extra head cost when the inactive background matches both feature endpoints.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/156_address_localization_exactness.md](theorems/05_positive_statistic_gates_and_grids/156_address_localization_exactness.md)

### Theorem 157. Few-run raw-mask gate theorem

Suppose a raw mask $R$ has $q$ true intervals along some positive raw statistic with distinct subset sums. Let $\epsilon_0$ and $\epsilon_1$ be its first and last labels in that order, and define

$$ K_R= \begin{cases} 0, & q=0,\cr 2q-\epsilon_0-\epsilon_1, & q\geq1. \end{cases} $$

Then

$$ C_{+}(R)\leq K_R\leq2q. $$

Consequently, all raw-mask endpoint bounds from Lemma 154 remain valid with $C_R$ replaced by $K_R$. Explicitly, if $T$ has sign-change count $C$ and endpoint labels $e_0,e_1$, then for $X=R\oplus T$,

$$ H^{\ast}(X)\leq \begin{cases} 2^kC+K_R, & e_0=e_1,\cr 2^k(C+1)+K_R, & e_0\neq e_1, \end{cases} $$

with analogous conjunction and disjunction bounds from the theorem file.

> **Interpretation.** Raw masks with few positive-order runs have small endpoint boundary cost; endpoint masks have $K_R\leq1$ and one-interval masks have $K_R\leq2$.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/157_few_run_raw_mask_gate_theorem.md](theorems/05_positive_statistic_gates_and_grids/157_few_run_raw_mask_gate_theorem.md)

### Theorem 158. Shared-statistic slice sandwich

Let $f(a,y)=F_a(t(y))$ for every raw assignment $a\in\lbrace0,1\rbrace^{k}$, where $t$ is one positive statistic. Let $C_a$ be the sign-change count of $F_a$ along the ordered image of $t$, and define endpoint raw functions

$$ q(a):=F_a(\tau_0), \qquad p(a):=F_a(\tau_{M-1}). $$

Then

$$ \max_a H^{\ast}\bigl(F_a(t(y))\bigr) \leq H^{\ast}(f) \leq \sum_a C_a+B_{+}(p,q). $$

If all slice endpoints are one common label $b$, then

$$ \max_a H^{\ast}\bigl(F_a(t(y))\bigr) \leq H^{\ast}(f) \leq \sum_a C_a. $$

If exactly one raw slice is nonconstant and that slice is exact with value $C_a$, then $H^{\ast}(f)=C_a$.

> **Interpretation.** The optimized mixed endpoint cost is the only coupling term for arbitrary raw slices sharing one positive statistic.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/158_shared_statistic_slice_sandwich.md](theorems/05_positive_statistic_gates_and_grids/158_shared_statistic_slice_sandwich.md)

### Theorem 159. Shared-statistic degree sandwich

Under the setup of Theorem 158, suppose every raw slice has a univariate strict sign polynomial in $t$ of degree at most $d_a$. Let

$$ \delta_a:=\deg_{\pm}\bigl(F_a(t(y))\bigr). $$

Then

$$ \max_a\delta_a \leq H^{\ast}(f) \leq \sum_a d_a+B_{+}(p,q). $$

In particular, if $d_a\leq d$ for all $a$, then

$$ H^{\ast}(f)\leq2^k d+B_{+}(p,q). $$

If all endpoints are common, the $B_{+}(p,q)$ term vanishes.

> **Interpretation.** Slice threshold degree lower-bounds the whole function, and slice sign-polynomial degree upper-bounds it up to endpoint coupling.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/159_shared_statistic_degree_sandwich.md](theorems/05_positive_statistic_gates_and_grids/159_shared_statistic_degree_sandwich.md)

### Theorem 160. Addressed common-endpoint direct sum

Let $A\subseteq\lbrace0,1\rbrace^{k}$ be a set of raw addresses. For each $a\in A$, let

$$ T_a(y)=F_a(t(y)) $$

share one positive statistic $t$ and a common endpoint background label $b$:

$$ F_a(\tau_0)=F_a(\tau_{M-1})=b. $$

Define $f_A(a,y)=T_a(y)$ for $a\in A$ and $f_A(a,y)=b$ for $a\notin A$. If $C_a$ is the sign-change count of $T_a$, then

$$ \max_{a\in A}H^{\ast}(T_a) \leq H^{\ast}(f_A) \leq \sum_{a\in A}C_a. $$

Thus a single addressed exact feature remains exact. If each $T_a$ has univariate sign degree at most $d_a$, then

$$ \max_{a\in A}\deg_{\pm}(T_a) \leq H^{\ast}(f_A) \leq \sum_{a\in A}d_a. $$

> **Interpretation.** Features with the same endpoint background can be placed at raw addresses additively, with no boundary penalty.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/160_addressed_common_endpoint_direct_sum.md](theorems/05_positive_statistic_gates_and_grids/160_addressed_common_endpoint_direct_sum.md)

### Theorem 161. Endpoint variation shared-statistic bound

In the setup of Theorem 158, define endpoint raw functions

$$ q(a):=F_a(\tau_0), \qquad p(a):=F_a(\tau_{M-1}). $$

Then

$$ H^{\ast}(f) \leq \sum_a C_a+\min\lbrace C_{+}(p),C_{+}(q)\rbrace+D(p,q), $$

where $D(p,q)=\lvert\lbrace a:p(a)\neq q(a)\rbrace\rvert$. If $p$ and $q$ have few-run certificates in positive raw orders, with run costs $K_p$ and $K_q$, then

$$ H^{\ast}(f) \leq \sum_a C_a+\min\lbrace K_p,K_q\rbrace+D(p,q). $$

> **Interpretation.** Endpoint coupling can be bounded by ordinary raw endpoint variation plus endpoint disagreement.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/161_endpoint_variation_shared_statistic_bound.md](theorems/05_positive_statistic_gates_and_grids/161_endpoint_variation_shared_statistic_bound.md)

### Theorem 162. Positive concatenation exactness criterion

For a shared positive-statistic certificate and a positive raw order $\rho$, let

$$ L_{\rho}(f):=\sum_a C_a+J_{\rho}(f) $$

be the sign-change count of the concatenated slice sequence. Then

$$ \deg_{\pm}(f) \leq H^{\ast}(f) \leq L_{\rho}(f). $$

Thus if $\deg_{\pm}(f)=L_{\rho}(f)$ for some certificate and order, then

$$ H^{\ast}(f)=\deg_{\pm}(f)=L_{\rho}(f). $$

The same exactness criterion holds with $L_{\rho}(f)$ replaced by the optimized endpoint-coupled cost $\mathrm{eps}_{+}^{z\mid y}(f)$.

> **Interpretation.** Positive concatenation gives exact values whenever threshold degree meets the constructed sign-change cost.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/162_positive_concatenation_exactness_criterion.md](theorems/05_positive_statistic_gates_and_grids/162_positive_concatenation_exactness_criterion.md)

### Theorem 163. Endpoint-coupled slice cost invariant

For a fixed split $(z,y)$, define

$$ \mathrm{eps}_{+}^{z\mid y}(f) := \min_t \left( \sum _{a\in\lbrace0,1\rbrace^{k}} C_a(t)+B _{+}(p_t,q_t) \right), $$

where $t$ ranges over all common positive-statistic certificates for the raw slices. Then

$$ H^{\ast}(f)\leq \mathrm{eps}_{+}^{z\mid y}(f) \leq \mathrm{osc} _{+}^{z\mid y}(f). $$

The cost is invariant under output complement, raw-coordinate permutation, and feature-coordinate permutation.

> **Interpretation.** The endpoint-coupled cost is a sharper split invariant than ordered-slice cost because the endpoint boundary is optimized separately.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/163_endpoint_coupled_slice_cost_invariant.md](theorems/05_positive_statistic_gates_and_grids/163_endpoint_coupled_slice_cost_invariant.md)

### Theorem 164. Sparse-slice endpoint-coupled bound

Let

$$ A:=\lbrace a:F_a(t(y))\text{ is nonconstant}\rbrace $$

be the active raw-slice set for a shared positive-statistic certificate. Then

$$ \max_{a\in A}H^{\ast}\bigl(F_a(t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{a\in A}C_a+B_{+}(p,q). $$

If all active slices have at most $C_{\max}$ sign changes, then

$$ H^{\ast}(f)\leq \lvert A\rvert C_{\max}+B_{+}(p,q). $$

If all slices share one endpoint background label, the $B_{+}$ term vanishes. The analogous degree bound replaces $C_a$ by univariate slice sign degrees $d_a$.

> **Interpretation.** Only nonconstant raw slices contribute to the within-slice cost; the rest of the raw cube appears only through endpoint coupling.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/164_sparse_slice_endpoint_coupled_bound.md](theorems/05_positive_statistic_gates_and_grids/164_sparse_slice_endpoint_coupled_bound.md)

### Theorem 165. Positive grid slice sandwich

Let

$$ u(z)=\sum_j\rho_jz_j, \qquad t(y)=\sum_i\lambda_iy_i, \qquad \rho_j,\lambda_i\gt0, $$

and suppose

$$ f(z,y)=F(u(z),t(y)). $$

Write the image of $u$ as $\nu_0\lt\cdots\lt\nu_{R-1}$. Let $C_r$ be the sign-change count of the slice $\tau\mapsto F(\nu_r,\tau)$, and let $J_{\mathrm{grid}}$ count endpoint jumps between consecutive raw levels. Then

$$ \max_{0\leq r\lt R}H^{\ast}\bigl(F(\nu_r,t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{r=0}^{R-1}C_r+J_{\mathrm{grid}}. $$

> **Interpretation.** If the raw block factors through a positive statistic, the construction pays per raw level rather than per raw assignment.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/165_positive_grid_slice_sandwich.md](theorems/05_positive_statistic_gates_and_grids/165_positive_grid_slice_sandwich.md)

### Theorem 166. Positive grid degree and exactness

In the setup of Theorem 165, suppose each raw-level slice has a univariate sign polynomial in $t$ of degree at most $d_r$. Let

$$ \delta_r:=\deg_{\pm}\bigl(F(\nu_r,t(y))\bigr). $$

Then

$$ \max_r\delta_r \leq H^{\ast}(f) \leq \sum_{r=0}^{R-1}d_r+J_{\mathrm{grid}}. $$

If $d_r\leq d$ for every $r$, then

$$ H^{\ast}(f)\leq Rd+J_{\mathrm{grid}}. $$

If $\deg_{\pm}(f)=\sum_r C_r+J_{\mathrm{grid}}$, then $H^{\ast}(f)=\deg_{\pm}(f)$.

> **Interpretation.** Positive-grid bounds are exact whenever threshold degree reaches the grid concatenation cost.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/166_positive_grid_degree_exactness.md](theorems/05_positive_statistic_gates_and_grids/166_positive_grid_degree_exactness.md)

### Theorem 167. Hamming-layer positive grid bound

Suppose

$$ f(z,y)=F(\lvert z\rvert,t(y)), \qquad t(y)=\sum_i\lambda_i y_i, \qquad \lambda_i\gt0. $$

Let $C_r$ be the sign-change count of the Hamming-layer slice $\tau\mapsto F(r,\tau)$, and let $J_{\mathrm{Ham}}$ count endpoint jumps between consecutive Hamming layers. Then

$$ \max_{0\leq r\leq k}H^{\ast}\bigl(F(r,t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{r=0}^{k}C_r+J_{\mathrm{Ham}}. $$

If each layer has univariate sign degree at most $d$, then

$$ H^{\ast}(f)\leq(k+1)d+J_{\mathrm{Ham}}. $$

> **Interpretation.** Raw Hamming-weight structure costs $k+1$ raw layers, not $2^k$ raw assignments.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/167_hamming_layer_positive_grid_bound.md](theorems/05_positive_statistic_gates_and_grids/167_hamming_layer_positive_grid_bound.md)

### Theorem 168. Sparse raw-level positive grid bound

In the setup of Theorem 165, let

$$ A:=\lbrace r:F(\nu_r,t(y))\text{ is nonconstant}\rbrace $$

be the active raw-level set. Then

$$ \max_{r\in A}H^{\ast}\bigl(F(\nu_r,t(y))\bigr) \leq H^{\ast}(f) \leq \sum_{r\in A}C_r+J_{\mathrm{grid}}. $$

If every active level has at most $C_{\max}$ sign changes, then

$$ H^{\ast}(f)\leq \lvert A\rvert C_{\max}+J_{\mathrm{grid}}. $$

If all raw-level slices have one common endpoint background, then $J_{\mathrm{grid}}=0$.

> **Interpretation.** Sparse active raw levels can be exponentially cheaper than sparse active raw assignments.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/168_sparse_raw_level_positive_grid_bound.md](theorems/05_positive_statistic_gates_and_grids/168_sparse_raw_level_positive_grid_bound.md)

### Theorem 169. Positive grid cost invariant

For a fixed split $(z,y)$, define $\mathrm{pgc}_{+}^{z\mid y}(f)$ by minimizing the positive-grid cost

$$ \sum_{r=0}^{R-1}C_r+J_{\mathrm{grid}} $$

over all certificates $f(z,y)=F(u(z),t(y))$ with positive statistics $u$ and $t$. Then

$$ H^{\ast}(f)\leq\mathrm{pgc}_{+}^{z\mid y}(f), \qquad C _{+}(f)\leq\mathrm{pgc} _{+}^{z\mid y}(f). $$

The cost is invariant under output complement, raw-coordinate permutation, and feature-coordinate permutation. If $\deg_{\pm}(f)=\mathrm{pgc}_{+}^{z\mid y}(f)$, then $H^{\ast}(f)$ is exactly this value.

> **Interpretation.** Positive-grid cost is an optimized split invariant that can be much smaller than raw-assignment slice cost.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/169_positive_grid_cost_invariant.md](theorems/05_positive_statistic_gates_and_grids/169_positive_grid_cost_invariant.md)

### Theorem 170. Positive lexicographic multigrid bound

Let the variables be split into $b\geq2$ blocks, with one positive statistic $t_j$ on each block, and suppose

$$ f(x^{(1)},\ldots,x^{(b)})=F(t_1(x^{(1)}),\ldots,t_b(x^{(b)})). $$

Read the product of the statistic images in lexicographic order, and let $L_{\mathrm{lex}}(F)$ be the number of sign changes in this ordered grid sequence. Then

$$ H^{\ast}(f)\leq L_{\mathrm{lex}}(F). $$

Every one-block grid fiber gives a restriction lower bound, and if $\deg_{\pm}(f)=L_{\mathrm{lex}}(F)$, then

$$ H^{\ast}(f)=\deg_{\pm}(f)=L_{\mathrm{lex}}(F). $$

> **Interpretation.** A function of several positive statistics can be traversed by one positive projection after choosing sufficiently separated scales.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/170_positive_lexicographic_multigrid_bound.md](theorems/05_positive_statistic_gates_and_grids/170_positive_lexicographic_multigrid_bound.md)

### Theorem 171. Multi-Hamming profile bound

If variables are split into blocks of sizes $n_1,\ldots,n_b$ and

$$ f(x^{(1)},\ldots,x^{(b)}) = F(\lvert x^{(1)}\rvert,\ldots,\lvert x^{(b)}\rvert), $$

then reading the Hamming-weight grid lexicographically gives a sign-change count $L_{\mathrm{Ham}}(F)$ with

$$ H^{\ast}(f)\leq L_{\mathrm{Ham}}(F). $$

The one-block symmetric fibers give restriction lower bounds, and equality holds if $\deg_{\pm}(f)=L_{\mathrm{Ham}}(F)$.

> **Interpretation.** Multiblock profile predicates have a direct grid-path upper bound.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/171_multi_hamming_profile_bound.md](theorems/05_positive_statistic_gates_and_grids/171_multi_hamming_profile_bound.md)

### Theorem 172. Multigrid run bound

In the setup of Theorem 170, let $R_b$ be the number of contiguous runs of label $b$ in the lexicographic grid sequence. Then

$$ H^{\ast}(f)\leq2\min\lbrace R_0,R_1\rbrace. $$

More sharply, if label $b$ has first and last membership indicators $\epsilon_0,\epsilon_1$, then

$$ H^{\ast}(f)\leq2R_b-\epsilon_0-\epsilon_1. $$

If this sharper run count equals $\deg_{\pm}(f)$, the value is exact.

> **Interpretation.** Sparse or interval-like behavior on a profile grid can yield head bounds far below support size in the full cube.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/172_multigrid_run_bound.md](theorems/05_positive_statistic_gates_and_grids/172_multigrid_run_bound.md)

### Theorem 173. Positive multigrid cost invariant

Fix a partition $\mathcal{P}$ of the input variables into blocks. Define $\mathrm{mgc}_{+}^{\mathcal{P}}(f)$ as the minimum lexicographic grid-path sign-change count over all positive multigrid certificates for $f$ over $\mathcal{P}$ and all block orders. Then

$$ H^{\ast}(f)\leq\mathrm{mgc}_{+}^{\mathcal{P}}(f), \qquad C _{+}(f)\leq\mathrm{mgc} _{+}^{\mathcal{P}}(f). $$

The invariant is unchanged by output complement and by coordinate permutations preserving the partition up to relabeling. If $\deg_{\pm}(f)=\mathrm{mgc}_{+}^{\mathcal{P}}(f)$, then $H^{\ast}(f)$ equals this value.

> **Interpretation.** Multigrid cost is the partition-level positive-projection invariant behind the lexicographic grid construction.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/173_positive_multigrid_cost_invariant.md](theorems/05_positive_statistic_gates_and_grids/173_positive_multigrid_cost_invariant.md)

### Theorem 174. Block-order Hamming profile cost

For a multiblock Hamming-profile predicate

$$ f(x)=F(\lvert x_{B_1}\rvert,\ldots,\lvert x_{B_b}\rvert), $$

let $\mathrm{mhc}(F)$ be the minimum lexicographic Hamming-grid sign-change count over all block orders. Then

$$ H^{\ast}(f)\leq\mathrm{mhc}(F). $$

If $\deg_{\pm}(f)=\mathrm{mhc}(F)$, then $H^{\ast}(f)=\deg_{\pm}(f)=\mathrm{mhc}(F)$. If $R_{b,\pi}$ is the number of runs of label $b$ in the grid sequence for order $\pi$, then

$$ H^{\ast}(f) \leq 2\min_{\pi}\min\lbrace R_{0,\pi},R_{1,\pi}\rbrace, $$

with the sharper endpoint-adjusted run bound from the theorem file.

> **Interpretation.** For multiblock profile predicates, choosing the block order is part of the head upper-bound certificate.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/174_block_order_hamming_profile_cost.md](theorems/05_positive_statistic_gates_and_grids/174_block_order_hamming_profile_cost.md)

### Theorem 175. Positive profile projection collapse

Let

$$ f(x)=F(\lvert x_{B_1}\rvert,\ldots,\lvert x_{B_b}\rvert). $$

Suppose there are positive coefficients $a_1,\ldots,a_b$ and a Boolean function $G$ such that

$$ F(r_1,\ldots,r_b)=G\left(\sum_{j=1}^{b}a_jr_j\right) $$

on the Hamming-profile grid. Let $C_a(G)$ be the sign-change count of $G$ on the increasing image of $\sum_j a_jr_j$. Then

$$ H^{\ast}(f)\leq C_a(G), \qquad C_{+}(f)\leq C_a(G). $$

If $\deg_{\pm}(f)=C_a(G)$, the value is exact. In the total Hamming-weight case $a_1=\cdots=a_b=1$, this recovers the exact symmetric sign-change value.

> **Interpretation.** Collapse the profile grid first when it factors through a positive weighted sum. The lexicographic multigrid path is not always the sharpest certificate.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/175_positive_profile_projection_collapse.md](theorems/05_positive_statistic_gates_and_grids/175_positive_profile_projection_collapse.md)

### Theorem 176. Singleton parity multigrid separation

For the singleton partition

$$ \mathcal{P}_{\mathrm{sing}}=\lbrace\lbrace1\rbrace,\ldots,\lbrace n\rbrace\rbrace, $$

let $f=\mathrm{XOR}_n$. Then, with $\mathrm{mhc}$ computed for the singleton Hamming profile of parity,

$$ \mathrm{mgc}_{+}^{\mathcal{P} _{\mathrm{sing}}}(\mathrm{XOR}_n) = \mathrm{mhc}(\mathrm{XOR}_n) = L_n, $$

where

$$ L_n= \begin{cases} \dfrac{2^{n+1}-1}{3} & \text{if } n \text{ is odd},\cr[6pt] \dfrac{2^{n+1}-2}{3} & \text{if } n \text{ is even}. \end{cases} $$

But

$$ H^{\ast}(\mathrm{XOR}_n)=n. $$

> **Interpretation.** The singleton multigrid certificate follows a binary odometer path and is exponentially looser than the total Hamming-weight projection for parity.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/176_singleton_parity_multigrid_separation.md](theorems/05_positive_statistic_gates_and_grids/176_singleton_parity_multigrid_separation.md)

### Theorem 177. Two-block singleton grid points are two-head

Let the variables be split into two nonempty blocks $A$ and $B$, and write

$$ s(x)=\sum_{i\in A}x_i, \qquad t(x)=\sum_{j\in B}x_j. $$

For fixed grid levels $r$ and $q$, define

$$ f_{r,q}(x)=\mathbf{1}[s(x)=r \text{ and } t(x)=q]. $$

Then

$$ H^{\ast}(f_{r,q})\leq2. $$

More precisely, its exact value is $1$ if it is a nonconstant LTF and $2$ otherwise. For the associated singleton grid function $G_{r,q}$, this gives

$$ H^{\ast}(f_{r,q})=\delta(G_{r,q}). $$

> **Interpretation.** A two-block Hamming-grid disk whose positive set is one grid point is not a counterexample to the two-block collapse conjecture. A nonresonant linear recombination of the two Hamming weights turns the grid point into an affine level set.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/177_two_block_singleton_grid_point_exact.md](theorems/05_positive_statistic_gates_and_grids/177_two_block_singleton_grid_point_exact.md)

### Theorem 178. Two-block affine grid lines are two-head

Let the variables be split into two nonempty blocks $A$ and $B$, and write

$$ s(x)=\sum_{i\in A}x_i, \qquad t(x)=\sum_{j\in B}x_j. $$

For real $a,b,c$, with $(a,b)\neq(0,0)$, define

$$ f_{a,b,c}(x)=\mathbf{1}[a s(x)+b t(x)+c=0]. $$

Then

$$ H^{\ast}(f_{a,b,c})\leq2. $$

More precisely, the exact value is $0$, $1$, or $2$ according as the predicate is constant, a nonconstant LTF, or neither. If $G_{a,b,c}$ is the corresponding affine-line indicator on the two-block Hamming grid, then

$$ H^{\ast}(f_{a,b,c})=\delta(G_{a,b,c}). $$

> **Interpretation.** A two-block Hamming profile supported on one affine grid line is just an affine level-set predicate after lifting to the cube.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/178_two_block_affine_grid_line_exact.md](theorems/05_positive_statistic_gates_and_grids/178_two_block_affine_grid_line_exact.md)

### Theorem 179. Two-block affine grid strips are two-head

Let the variables be split into two nonempty blocks $A$ and $B$, and write

$$ s(x)=\sum_{i\in A}x_i, \qquad t(x)=\sum_{j\in B}x_j. $$

For real $a,b,c,\alpha,\beta$, with $(a,b)\neq(0,0)$ and $\alpha\leq\beta$, define

$$ f_{a,b,c,\alpha,\beta}(x)=\mathbf{1}[\alpha\leq a s(x)+b t(x)+c\leq\beta]. $$

Then

$$ H^{\ast}(f_{a,b,c,\alpha,\beta})\leq2. $$

More precisely, the exact value is $0$, $1$, or $2$ according as the predicate is constant, a nonconstant LTF, or neither. If $G_{a,b,c,\alpha,\beta}$ is the corresponding affine-strip indicator on the two-block Hamming grid, then

$$ H^{\ast}(f_{a,b,c,\alpha,\beta})=\delta(G_{a,b,c,\alpha,\beta}). $$

> **Interpretation.** A two-block Hamming profile supported between two parallel affine grid lines is exactly an affine slab after lifting to the cube.

**Proof.** [theorems/05_positive_statistic_gates_and_grids/179_two_block_affine_grid_strips_exact.md](theorems/05_positive_statistic_gates_and_grids/179_two_block_affine_grid_strips_exact.md)

### Theorem 180. A quadratic hypercube-path threshold needs at least three heads

Let $\mathcal{R}$ contain the $48$ even-parity strings $r\in\lbrace0,1\rbrace^8$ with $r_8=0$ that also satisfy $r_4=0$ or $r_1+r_2+r_3\equiv1\pmod2$. Define $S_{r,j}=(-1)^{r_j}$. For Boolean variables $x_r$, where $r\in\mathcal{R}$, and $y_1,\ldots,y_8$, define

$$ P(x,y):=\frac{1}{2}+\sum_{r\in\mathcal{R}}\sum_{j=1}^{8}S_{r,j}x_r y_j. $$

Let $f_{\mathrm{HC}}(x,y)=1$ exactly when $P(x,y)\gt0$. Then

$$ \deg_{\pm}(f_{\mathrm{HC}})=2 \qquad\text{and}\qquad H^{\ast}(f_{\mathrm{HC}})\geq3. $$

Consequently,

$$ \deg_{\pm}(f_{\mathrm{HC}})\lt H^{\ast}(f_{\mathrm{HC}}). $$

> **Interpretation.** The threshold-degree lower bound is not universally exact. The strict gap is certified by a two-block singleton slice whose hypercube-path sign matrix has sign-rank at least seven, while every two-head score has singleton-slice sign-rank at most six.

**Proof.** [theorems/06_strict_separations/180_hypercube_path_strict_separation.md](theorems/06_strict_separations/180_hypercube_path_strict_separation.md)

### Theorem 181. A compact 43-bit hypercube-path threshold needs at least three heads

For $r\in\lbrace0,1\rbrace^8$, let $\mathrm{code}(r)=\sum_{j=1}^{8}2^{j-1}r_j$.
Let $\mathcal{R}_{35}$ contain the strings whose codes belong to

$$ \lbrace0,3,5,10,12,15,18,20,23,30,34,36,39,46,54,65,72,75,77,80,83,85,90,92,95,96,99,101,106,108,111,114,116,119,126\rbrace. $$

Define $S^{(35)}_{r,j}=(-1)^{r_j}$. For Boolean variables $x_r$, where $r\in\mathcal{R} _{35}$, and $y_1,\ldots,y_8$, define

$$ P_{35}(x,y):=\frac{1}{2}+\sum_{r\in\mathcal{R}_{35}}\sum _{j=1}^{8}S^{(35)} _{r,j}x_r y_j. $$

Let $f_{35}(x,y)=1$ exactly when $P_{35}(x,y)\gt0$. Then

$$ \deg_{\pm}(f_{35})=2 \qquad\text{and}\qquad H^{\ast}(f_{35})\geq3. $$

Consequently,

$$ \deg_{\pm}(f_{35})\lt H^{\ast}(f_{35}). $$

> **Interpretation.** A deterministic exhaustive certificate compresses the structured construction from $56$ bits to $43$ bits while preserving the sign-rank-seven singleton-slice obstruction.

**Proof.** [theorems/06_strict_separations/181_compact_hypercube_path_strict_separation.md](theorems/06_strict_separations/181_compact_hypercube_path_strict_separation.md)

### Theorem 182. A twelve-bit Hamming threshold needs at least three heads

For $x,y\in\lbrace0,1\rbrace^6$, let

$$ \Delta(x,y):=\sum_{i=1}^{6}(x_i+y_i-2x_i y_i), $$

and define $f_{\mathrm{Ham}}(x,y)=1$ exactly when $\Delta(x,y)\geq3$. Then

$$ \deg_{\pm}(f_{\mathrm{Ham}})=2 \qquad\text{and}\qquad H^{\ast}(f_{\mathrm{Ham}})\geq3. $$

Consequently,

$$ \deg_{\pm}(f_{\mathrm{Ham}})\lt H^{\ast}(f_{\mathrm{Ham}}). $$

> **Interpretation.** A natural Hamming-distance threshold gives a strict separation on twelve bits. An explicit eight-column restriction has sign-rank at least seven, while every two-head partition sign matrix has sign-rank at most six.

**Proof.** [theorems/06_strict_separations/182_hamming_threshold_strict_separation.md](theorems/06_strict_separations/182_hamming_threshold_strict_separation.md)

### Theorem 183. Head complexity equals threshold degree through four bits

For every integer $n$ with $0\leq n\leq4$ and every Boolean function $f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace$,

$$ H^{\ast}(f)=\deg_{\pm}(f). $$

> **Interpretation.** An exact integer certificate classifies all $65536$ four-bit truth tables. It verifies two-head scores for every function of threshold degree at most two, three-head scores for every degree-three function, and leaves only parity and its complement at degree and head complexity four.

**Proof.** [theorems/06_strict_separations/183_small_dimension_exact_classification.md](theorems/06_strict_separations/183_small_dimension_exact_classification.md)

### Theorem 184. An eleven-bit quadratic threshold needs at least three heads

Let $x\in\lbrace0,1\rbrace^6$ and $y\in\lbrace0,1\rbrace^5$. Define

$$ \begin{aligned} Q(x,y):={}&1-2x_3+8y_5-16x_1y_2+14x_1y_4-14x_1y_5-22x_2y_4+16x_2y_5 \cr &+2x_3y_1+12x_3y_2+6x_3y_5-18x_4y_3-2x_5y_1-14x_5y_3-16x_6y_5 \cr &+16y_1y_3+22y_2y_5-12y_3y_5. \end{aligned} $$

Let $f_{11}(x,y)=1$ exactly when $Q(x,y)\gt0$. Then

$$ \deg_{\pm}(f_{11})=2\lt3\leq H^{\ast}(f_{11}). $$

> **Interpretation.** This six-bit by five-bit quadratic embeds the compact hypercube-path obstruction as an exact $35\times8$ submatrix. Its certificate is deterministic and uses only integer arithmetic.

**Proof.** [theorems/06_strict_separations/184_eleven_bit_quadratic_strict_separation.md](theorems/06_strict_separations/184_eleven_bit_quadratic_strict_separation.md)

### Theorem 185. A nine-bit antipodal-slice threshold needs at least three heads

Let $x\in\lbrace-1,1\rbrace^4$ and $y\in\lbrace-1,1\rbrace^5$. Define

$$ Q(x,y):=\left(\sum_{j=0}^{4}y_j\right)\left(1+\sum_{i=1}^{4}x_i\right)-3\left(y_0+\sum_{i=1}^{4}x_i y_i\right), $$

and let $f_9(x,y)=1$ exactly when $Q(x,y)\gt0$. Then

$$ \deg_{\pm}(f_9)=2\lt3\leq H^{\ast}(f_9). $$

> **Interpretation.** Five antipodal pairs force a nonsingular $5\times5$ cross-coefficient block in every quadratic sign representation. Clearing two heads gives a sum of two affine products, whose corresponding block has rank at most four.

**Proof.** [theorems/06_strict_separations/185_nine_bit_antipodal_slice_strict_separation.md](theorems/06_strict_separations/185_nine_bit_antipodal_slice_strict_separation.md)

### Theorem 186. Five-bit degree-four functions need exactly four heads

For every Boolean function $f : \lbrace0,1\rbrace^5 \to \lbrace0,1\rbrace$,

$$ \deg_{\pm}(f)=4 \qquad\Longrightarrow\qquad H^{\ast}(f)=4. $$

> **Interpretation.** An exact affine-cocircuit reduction gives $65$ normal orbits. Uniform four-head shattering certificates cover $60$ orbits, and exact finite archives cover every target in the five residual orbits.

**Proof.** [theorems/06_strict_separations/186_five_bit_degree_four_exact.md](theorems/06_strict_separations/186_five_bit_degree_four_exact.md)

### Theorem 187. Five-bit degree-two functions need exactly two heads

For every Boolean function $f : \lbrace0,1\rbrace^5 \to \lbrace0,1\rbrace$,

$$ \deg_{\pm}(f)=2 \qquad\Longrightarrow\qquad H^{\ast}(f)=2. $$

> **Interpretation.** An analytic matrix-completion reduction leaves only fully locked complementary-five-cycle sign cells. An exhaustive exact cocircuit and tangent-tope certificate reduces every such cell to $380$ archived symmetry classes, all of which have exact rational two-head certificates.

**Proof.** [theorems/06_strict_separations/187_five_bit_degree_two_exact.md](theorems/06_strict_separations/187_five_bit_degree_two_exact.md)

### Theorem 189. An eight-bit Hamming threshold has head complexity three

For $x,y\in\lbrace0,1\rbrace^4$, define

$$ \Delta(x,y):=\sum_{i=1}^4(x_i+y_i-2x_i y_i), $$

and let $f_8(x,y)=1$ exactly when $\Delta(x,y)\geq2$. Then

$$ \deg_{\pm}(f_8)=2\lt3=H^{\ast}(f_8). $$

> **Interpretation.** The radius-one Hamming-ball threshold is an explicit eight-bit strict separation. Checkerboard curvature and shell transitions rule out two heads, while an exact integer linear-fractional certificate gives three heads.

**Proof.** [theorems/06_strict_separations/189_eight_bit_hamming_threshold_strict_separation.md](theorems/06_strict_separations/189_eight_bit_hamming_threshold_strict_separation.md)

### Theorem 190. Cleared head scores have slice rank at most two

Let $H\geq2$. Every homogeneous cleared numerator of an $H$-head score has real polynomial slice rank at most two:

$$ P=L_1Q_1+L_2Q_2. $$

The linear generator $L_2$ can be chosen as an actual admissible denominator. Thus $V(P)$ contains a real linear space of codimension at most two. For a fixed two-plane $U$, the degree $H$ coefficient space has dimension

$$ 2\binom{n+H-1}{H-1}-\binom{n+H-2}{H-2}, $$

and the outer search is over a Grassmannian of dimension $2(n-1)$.

> **Interpretation.** Slice rank gives a general algebraic lower layer that retains more structure than degree alone. A largest-Plücker-pivot atlas reduces its nonlinear search to bounded charts whose fixed-rank feature rows are affine in the chart variables.

**Proof.** [theorems/02_complexity_measure_upper_bounds/190_slice_rank_two_obstruction.md](theorems/02_complexity_measure_upper_bounds/190_slice_rank_two_obstruction.md)

### Theorem 191. Boolean-cube ceiling for the slice relaxation

Let

$$ D_d=\sum_{j=0}^{d}\binom{n}{j}. $$

For degree $H$, the maximum dimension of a fixed two-plane slice space after evaluation on $\lbrace0,1\rbrace^n$ is

$$ \min\left\lbrace D_H,2D_{H-1}-D_{H-2}\right\rbrace. $$

It is attained by the plane $\mathrm{span}(1,x_1+\cdots+x_n)$. Therefore, when $H\geq\lceil(n+1)/2\rceil$, both the plain and positivity-aware slice-rank-two sign relaxations are exactly threshold degree at most $H$.

> **Interpretation.** Formal slice rank is a useful truth-table lower layer only below the Boolean middle-level collapse. A dimension screen must precede any Grassmann atlas computation.

**Proof.** [theorems/02_complexity_measure_upper_bounds/191_boolean_cube_slice_relaxation_ceiling.md](theorems/02_complexity_measure_upper_bounds/191_boolean_cube_slice_relaxation_ceiling.md)

### Theorem 192. Multiway sign tensor rank and its input-count ceiling

For every partition of the input coordinates into $k\geq2$ nonempty blocks, an $H$-head function satisfies

$$ \mathrm{srank}_{\mathrm{CP}}\left(\Sigma_f^{I_1,\ldots,I_k}\right)\leq k\left(k^H-(k-1)^H\right). $$

If $H\geq2$ and $n\leq2H+1$, the ambient CP-rank ceiling is already no larger than this tangent cap for every $k$. Thus multiway sign CP rank alone cannot improve the balanced matrix input-count screen.

> **Interpretation.** Higher-order tensors can contribute only through compatibility equations, positivity, or other structure beyond rank size. Adding more coordinate blocks cannot move the universal rank-method frontier below $2H+2$ bits.

**Proof.** [theorems/02_complexity_measure_upper_bounds/192_multiway_sign_tensor_rank.md](theorems/02_complexity_measure_upper_bounds/192_multiway_sign_tensor_rank.md)

### Theorem 193. Exact positive-secant diagonal blow-up

For paired orientation-compatible denominator products $Q_{\theta^{(0)}}$ and $Q_{\theta^{(1)}}$, positive-secant ranking is equivalent to strict positivity of all positive-negative pair gaps

$$ G_{p,q}\left(\theta^{(0)},\theta^{(1)}\right)=Q_{\theta^{(0)}}(q)Q_{\theta^{(1)}}(p)-Q_{\theta^{(0)}}(p)Q_{\theta^{(1)}}(q). $$

Write $\theta^{(1)}=\theta+tv$, normalize $\lVert v\rVert_{\infty}=1$, and impose the one-sided simplex tangent-cone conditions on $v$. Every pair gap is divisible by $t$:

$$ G_{p,q}(\theta,\theta+tv)=t\widetilde G_{p,q}(\theta,v,t). $$

Allowing $t=0$ in the divided system introduces no spurious strict solution. A strict point at $t=0$ opens into a genuine strict secant for sufficiently small $t\gt0$. The normalization is covered by $2H(n+1)$ bounded maximal-coordinate charts, and the divided gap has scalar degree at most $H-1$.

> **Interpretation.** The positive-secant relaxation no longer has an identically zero endpoint diagonal. Its exact compactification records normalized tangent directions, including one-sided directions on denominator-simplex faces.

**Proof.** [theorems/02_complexity_measure_upper_bounds/193_positive_secant_diagonal_blowup.md](theorems/02_complexity_measure_upper_bounds/193_positive_secant_diagonal_blowup.md)

### Theorem 194. Exact signed-secant diagonal blow-up

Retain the positive-secant mixture scalar and write

$$ \theta^{(1)}=\theta+tv,\qquad 2s-1=ta,qquad \max\lbrace\lVert v\rVert_{\infty},\lvert a\rvert\rbrace=1. $$

The signed score at vertex $x$ is divisible by $t$. Its quotient is

$$ \widetilde{\mathcal S}_x=\frac12\left(\frac{Q _{\theta+tv}(x)-Q _\theta(x)}{t}+a\left(Q _{\theta+tv}(x)+Q _\theta(x)\right)\right). $$

Strict feasibility of the quotient system for $t\in[0,1]$ is equivalent to strict signed-secant feasibility. At $t=0$, an arbitrary zero-block-sum direction introduces no spurious strict solution: perturb the base tuple into the simplex interior, then open a sufficiently short secant. The chart domains are closed and compact.

The signed system has $2^n$ inequalities, rather than one inequality per oppositely labeled pair. It has $2H(n+1)+2$ raw charts, at most $4(n+1)+2$ chart types per orientation-count branch after head symmetry, scalar degree at most $H$, total degree at most $2H+1$, and block multidegree one.

> **Interpretation.** The signed compactification is the preferred target for spatial branch-and-bound. The original unblown signed system has lower degree and remains preferable for CAD, NLSAT, or direct Positivstellensatz refutation.

**Proof.** [theorems/02_complexity_measure_upper_bounds/194_signed_secant_diagonal_blowup.md](theorems/02_complexity_measure_upper_bounds/194_signed_secant_diagonal_blowup.md)

### Theorem 195. Output-normalized atomic-margin sparsification

Let $\mathcal A_n$ be the symmetric set of valid one-head score vectors normalized by $\lVert a\rVert_{\infty}\leq1$. If

$$ y_x(c+\Lambda u_x)\geq\gamma\gt0\qquad\text{for every }x,\qquad u\in\mathrm{conv}(\mathcal A_n), $$

then approximate Carathéodory in $\ell_p$, with $p=\Theta(n)$, sparsifies $u$ without losing its signs. For an absolute constant $C$,

$$ H^{\ast}(f)\leq C(n+1)\left(\frac{\Lambda}{\gamma}\right)^2. $$

Consequently the output-normalized atomic condition number $\kappa_{\mathrm{atom}}(f)$ satisfies

$$ H^{\ast}(f)\leq C(n+1)\kappa_{\mathrm{atom}}(f)^2. $$

> **Interpretation.** Denominator-group boosting has a principled width target when its margin is measured in actual score space. A finite rational atomic decomposition with positive exact margin is already a direct upper certificate.

**Proof.** [theorems/02_complexity_measure_upper_bounds/195_atomic_margin_sparsification.md](theorems/02_complexity_measure_upper_bounds/195_atomic_margin_sparsification.md)

### Theorem 196. Optimal Fourier-tail knapsack

Let $c_S$ be the unnormalized Walsh coefficients of the sign table $q$, so

$$ q(x)=2^{-n}\sum_S c_S\chi_S(x). $$

Retain the constant coefficient for free. Bundle all singleton coefficients into one item of cost one and value $\sum_{\lvert S\rvert=1}\lvert c_S\rvert$. Give every nonzero nonsingleton coefficient one item of cost $\lvert S\rvert$ and value $\lvert c_S\rvert$. Any retained item set whose omitted value is below $2^n$ gives a strict Fourier sign certificate and therefore a head upper bound equal to its total item cost.

The minimum cost obtainable from this absolute Fourier-tail criterion is an exact zero-one knapsack problem. Since there are at most $2^n$ items and total compiler cost at most $n2^n+1$, dynamic programming takes

$$ O\left(n4^n\right) $$

integer-arithmetic operations, polynomial in the truth-table length.

> **Interpretation.** The greedy Fourier-tail seed has an exact escalation path. The dynamic program optimizes this sufficient tail criterion, not arbitrary sparse sign polynomials and not $H^{\ast}$ itself.

**Proof.** [theorems/02_complexity_measure_upper_bounds/196_optimal_fourier_tail_knapsack.md](theorems/02_complexity_measure_upper_bounds/196_optimal_fourier_tail_knapsack.md)

### Theorem 197. Greedy affine bounds on a box with one sum constraint

Let $\ell_i\leq x_i\leq u_i$ and $\sum_ix_i=T$. To minimize $c^{\top}x$, start at the lower bounds and allocate the remaining mass $T-\sum_i\ell_i$ greedily in nondecreasing order of $c_i$, subject to capacities $u_i-\ell_i$. Reversing the coefficient order gives the maximum.

Both endpoints are exact rational values and require $O(m\log m)$ comparisons. Applied to simplex factors and zero-sum direction blocks, this gives exact affine intervals before McCormick product envelopes are formed. In particular, every base and endpoint denominator factor remains in $[0,1]$.

> **Interpretation.** Sum equations should be used before generic interval multiplication. This elementary tightening changes some full-cube signed-secant charts from spuriously positive relaxations into short exact dual leaves.

**Proof.** [theorems/02_complexity_measure_upper_bounds/197_box_sum_greedy_affine_bounds.md](theorems/02_complexity_measure_upper_bounds/197_box_sum_greedy_affine_bounds.md)

### Theorem 190. Cleared head scores have slice rank at most two

Let $H\geq2$. Every homogeneous cleared numerator of an $H$-head score has real polynomial slice rank at most two:

$$ P=L_1Q_1+L_2Q_2. $$

The linear generator $L_2$ can be chosen as an actual admissible denominator. Thus $V(P)$ contains a real linear space of codimension at most two. For a fixed two-plane $U$, the degree $H$ coefficient space has dimension

$$ 2\binom{n+H-1}{H-1}-\binom{n+H-2}{H-2}, $$

and the outer search is over a Grassmannian of dimension $2(n-1)$.

> **Interpretation.** Slice rank gives a general algebraic lower layer that retains more structure than degree alone. A largest-Plücker-pivot atlas reduces its nonlinear search to bounded charts whose fixed-rank feature rows are affine in the chart variables.

**Proof.** [theorems/02_complexity_measure_upper_bounds/190_slice_rank_two_obstruction.md](theorems/02_complexity_measure_upper_bounds/190_slice_rank_two_obstruction.md)

### Theorem 191. Boolean-cube ceiling for the slice relaxation

Let

$$ D_d=\sum_{j=0}^{d}\binom{n}{j}. $$

For degree $H$, the maximum dimension of a fixed two-plane slice space after evaluation on $\lbrace0,1\rbrace^n$ is

$$ \min\left\lbrace D_H,2D_{H-1}-D_{H-2}\right\rbrace. $$

It is attained by the plane $\mathrm{span}(1,x_1+\cdots+x_n)$. Therefore, when $H\geq\lceil(n+1)/2\rceil$, both the plain and positivity-aware slice-rank-two sign relaxations are exactly threshold degree at most $H$.

> **Interpretation.** Formal slice rank is a useful truth-table lower layer only below the Boolean middle-level collapse. A dimension screen must precede any Grassmann atlas computation.

**Proof.** [theorems/02_complexity_measure_upper_bounds/191_boolean_cube_slice_relaxation_ceiling.md](theorems/02_complexity_measure_upper_bounds/191_boolean_cube_slice_relaxation_ceiling.md)

### Theorem 192. Multiway sign tensor rank and its input-count ceiling

For every partition of the input coordinates into $k\geq2$ nonempty blocks, an $H$-head function satisfies

$$ \mathrm{srank}_{\mathrm{CP}}\left(\Sigma_f^{I_1,\ldots,I_k}\right)\leq k\left(k^H-(k-1)^H\right). $$

If $H\geq2$ and $n\leq2H+1$, the ambient CP-rank ceiling is already no larger than this tangent cap for every $k$. Thus multiway sign CP rank alone cannot improve the balanced matrix input-count screen.

> **Interpretation.** Higher-order tensors can contribute only through compatibility equations, positivity, or other structure beyond rank size. Adding more coordinate blocks cannot move the universal rank-method frontier below $2H+2$ bits.

**Proof.** [theorems/02_complexity_measure_upper_bounds/192_multiway_sign_tensor_rank.md](theorems/02_complexity_measure_upper_bounds/192_multiway_sign_tensor_rank.md)

### Theorem 193. Exact positive-secant diagonal blow-up

For paired orientation-compatible denominator products $Q_{\theta^{(0)}}$ and $Q_{\theta^{(1)}}$, positive-secant ranking is equivalent to strict positivity of all positive-negative pair gaps

$$ G_{p,q}\left(\theta^{(0)},\theta^{(1)}\right)=Q_{\theta^{(0)}}(q)Q_{\theta^{(1)}}(p)-Q_{\theta^{(0)}}(p)Q_{\theta^{(1)}}(q). $$

Write $\theta^{(1)}=\theta+tv$, normalize $\lVert v\rVert_{\infty}=1$, and impose the one-sided simplex tangent-cone conditions on $v$. Every pair gap is divisible by $t$:

$$ G_{p,q}(\theta,\theta+tv)=t\widetilde G_{p,q}(\theta,v,t). $$

Allowing $t=0$ in the divided system introduces no spurious strict solution. A strict point at $t=0$ opens into a genuine strict secant for sufficiently small $t\gt0$. The normalization is covered by $2H(n+1)$ bounded maximal-coordinate charts, and the divided gap has scalar degree at most $H-1$.

> **Interpretation.** The positive-secant relaxation no longer has an identically zero endpoint diagonal. Its exact compactification records normalized tangent directions, including one-sided directions on denominator-simplex faces.

**Proof.** [theorems/02_complexity_measure_upper_bounds/193_positive_secant_diagonal_blowup.md](theorems/02_complexity_measure_upper_bounds/193_positive_secant_diagonal_blowup.md)

### Theorem 194. Exact signed-secant diagonal blow-up

Retain the positive-secant mixture scalar and write

$$ \theta^{(1)}=\theta+tv,\qquad 2s-1=ta,qquad \max\lbrace\lVert v\rVert_{\infty},\lvert a\rvert\rbrace=1. $$

The signed score at vertex $x$ is divisible by $t$. Its quotient is

$$ \widetilde{\mathcal S}_x=\frac12\left(\frac{Q _{\theta+tv}(x)-Q _\theta(x)}{t}+a\left(Q _{\theta+tv}(x)+Q _\theta(x)\right)\right). $$

Strict feasibility of the quotient system for $t\in[0,1]$ is equivalent to strict signed-secant feasibility. At $t=0$, an arbitrary zero-block-sum direction introduces no spurious strict solution: perturb the base tuple into the simplex interior, then open a sufficiently short secant. The chart domains are closed and compact.

The signed system has $2^n$ inequalities, rather than one inequality per oppositely labeled pair. It has $2H(n+1)+2$ raw charts, at most $4(n+1)+2$ chart types per orientation-count branch after head symmetry, scalar degree at most $H$, total degree at most $2H+1$, and block multidegree one.

> **Interpretation.** The signed compactification is the preferred target for spatial branch-and-bound. The original unblown signed system has lower degree and remains preferable for CAD, NLSAT, or direct Positivstellensatz refutation.

**Proof.** [theorems/02_complexity_measure_upper_bounds/194_signed_secant_diagonal_blowup.md](theorems/02_complexity_measure_upper_bounds/194_signed_secant_diagonal_blowup.md)

### Theorem 195. Output-normalized atomic-margin sparsification

Let $\mathcal A_n$ be the symmetric set of valid one-head score vectors normalized by $\lVert a\rVert_{\infty}\leq1$. If

$$ y_x(c+\Lambda u_x)\geq\gamma\gt0\qquad\text{for every }x,\qquad u\in\mathrm{conv}(\mathcal A_n), $$

then approximate Carathéodory in $\ell_p$, with $p=\Theta(n)$, sparsifies $u$ without losing its signs. For an absolute constant $C$,

$$ H^{\ast}(f)\leq C(n+1)\left(\frac{\Lambda}{\gamma}\right)^2. $$

Consequently the output-normalized atomic condition number $\kappa_{\mathrm{atom}}(f)$ satisfies

$$ H^{\ast}(f)\leq C(n+1)\kappa_{\mathrm{atom}}(f)^2. $$

> **Interpretation.** Denominator-group boosting has a principled width target when its margin is measured in actual score space. A finite rational atomic decomposition with positive exact margin is already a direct upper certificate.

**Proof.** [theorems/02_complexity_measure_upper_bounds/195_atomic_margin_sparsification.md](theorems/02_complexity_measure_upper_bounds/195_atomic_margin_sparsification.md)

### Theorem 196. Optimal Fourier-tail knapsack

Let $c_S$ be the unnormalized Walsh coefficients of the sign table $q$, so

$$ q(x)=2^{-n}\sum_S c_S\chi_S(x). $$

Retain the constant coefficient for free. Bundle all singleton coefficients into one item of cost one and value $\sum_{\lvert S\rvert=1}\lvert c_S\rvert$. Give every nonzero nonsingleton coefficient one item of cost $\lvert S\rvert$ and value $\lvert c_S\rvert$. Any retained item set whose omitted value is below $2^n$ gives a strict Fourier sign certificate and therefore a head upper bound equal to its total item cost.

The minimum cost obtainable from this absolute Fourier-tail criterion is an exact zero-one knapsack problem. Since there are at most $2^n$ items and total compiler cost at most $n2^n+1$, dynamic programming takes

$$ O\left(n4^n\right) $$

integer-arithmetic operations, polynomial in the truth-table length.

> **Interpretation.** The greedy Fourier-tail seed has an exact escalation path. The dynamic program optimizes this sufficient tail criterion, not arbitrary sparse sign polynomials and not $H^{\ast}$ itself.

**Proof.** [theorems/02_complexity_measure_upper_bounds/196_optimal_fourier_tail_knapsack.md](theorems/02_complexity_measure_upper_bounds/196_optimal_fourier_tail_knapsack.md)

### Theorem 197. Greedy affine bounds on a box with one sum constraint

Let $\ell_i\leq x_i\leq u_i$ and $\sum_ix_i=T$. To minimize $c^{\top}x$, start at the lower bounds and allocate the remaining mass $T-\sum_i\ell_i$ greedily in nondecreasing order of $c_i$, subject to capacities $u_i-\ell_i$. Reversing the coefficient order gives the maximum.

Both endpoints are exact rational values and require $O(m\log m)$ comparisons. Applied to simplex factors and zero-sum direction blocks, this gives exact affine intervals before McCormick product envelopes are formed. In particular, every base and endpoint denominator factor remains in $[0,1]$.

> **Interpretation.** Sum equations should be used before generic interval multiplication. This elementary tightening changes some full-cube signed-secant charts from spuriously positive relaxations into short exact dual leaves.

**Proof.** [theorems/02_complexity_measure_upper_bounds/197_box_sum_greedy_affine_bounds.md](theorems/02_complexity_measure_upper_bounds/197_box_sum_greedy_affine_bounds.md)

## Dependency Order

The current dependency structure is:

1. Lemma 1 gives the additive decomposition.
2. Lemma 2 converts that decomposition into antipode identities.
3. Lemma 3 turns the antipode identities into a one-head lower bound.
4. Lemma 4 gives an independent one-head upper bound family.
5. Lemma 5 combines Lemmas 3 and 4 to answer standard-family cases.
6. Lemma 6 converts head complexity into a threshold-degree upper bound.
7. Lemma 7 computes the threshold degree of parity exactly.
8. Lemma 8 combines Lemmas 6 and 7 with an explicit $n$-head construction for parity.
9. Lemma 9 gives a broader constructive upper-bound route by interpolating over the image of a positive weighted sum.
10. Lemma 10 gives an exact normal form for the full model in terms of one-head linear-fractional atoms.
11. Lemma 11 follows from Lemma 10 and identifies exactly what happens at head counts $0$ and $1$.
12. Lemma 12 uses Lemmas 6 and 10 to characterize every symmetric Boolean function exactly.
13. Lemma 13 generalizes the symmetric upper-bound construction from Hamming weight to arbitrary positive projections.
14. Lemma 14 applies Lemmas 11 and 13 to resolve `00011000` and give first bounds for `00101001`.
15. Lemma 15 uses Lemma 10 to convert three-bit quadratic sign representations into two-head constructions, closing the `00101001` case.
16. Lemma 16 combines Lemmas 6, 11, 15, and a three-head cubic upper bound to classify every three-bit Boolean function exactly.
17. Lemma 17 uses Lemma 10 and a four-bit determinant decomposition to show that every four-bit Boolean function has $H^{\ast}(f) \leq 4$.
18. Lemma 18 uses Lemma 10 and a five-bit modular determinant certificate to show that every five-bit Boolean function has $H^{\ast}(f) \leq 7$.
19. Lemma 19 uses Lemma 10 and a six-bit modular determinant certificate to show that every six-bit Boolean function has $H^{\ast}(f) \leq 11$.
20. Lemma 20 uses Lemma 10 and a seven-bit modular determinant certificate to show that every seven-bit Boolean function has $H^{\ast}(f) \leq 19$.
21. Lemma 21 abstracts the determinant-span method behind Lemmas 17 to 20 and proves the method's dimension lower bound.
22. Lemma 22 applies Lemma 21 with an eight-bit modular determinant certificate to show that every eight-bit Boolean function has $H^{\ast}(f) \leq 32$.
23. Lemma 23 applies Lemma 21 with a nine-bit modular determinant certificate to show that every nine-bit Boolean function has $H^{\ast}(f) \leq 57$.
24. Lemma 24 applies Lemma 21 with a ten-bit modular determinant certificate to show that every ten-bit Boolean function has $H^{\ast}(f) \leq 103$.
25. Lemma 25 gives a compact formula for determinant-span certificates at the threshold value $\left\lceil(2^n - 1)/n\right\rceil$ for every $3 \leq n \leq 12$.
26. Lemma 26 uses Lemma 10 and Warren's sign-pattern bound to show that almost all $n$-bit functions need $\Omega(2^n/n^2)$ heads.
27. Lemma 27 sharpens Lemma 7 by showing that parity and its complement are the only functions with threshold degree $n$.
28. Lemma 28 uses Lemmas 6, 8, and 10 to prove restriction monotonicity, parity-restriction lower bounds, dummy-variable invariance, global symmetries, and sign-rank lower bounds under input partitions.
29. Lemma 29 uses Lemmas 10 and 28 with a one-head same-sign-denominator construction to show that monotone DNF and CNF size upper-bound $H^{\ast}$ for monotone functions.
30. Lemma 30 abstracts the degree-restricted determinant-span method behind the three-bit quadratic theorem and the full universal determinant-span certificates.
31. Lemma 31 generalizes Lemma 27 by using Fourier-tail truncation to certify low threshold degree, which can then feed into Lemma 30.
32. Lemma 32 characterizes the shared orientation of one-head denominators and explains the same-sign denominator construction used by Lemma 29.
33. Lemma 33 packages the Boolean-closure property of the positive-projection sign-change theorem from Lemma 13.
34. Lemma 34 records the standard DNF/CNF width upper bound on threshold degree and routes it through Lemma 30 when a degree-restricted span certificate is available.
35. Lemma 35 combines Lemma 29 with the minimal-true and maximal-false antichain descriptions of monotone functions.
36. Lemma 36 combines Lemmas 26 and 35 with the middle-layer lower bound on the number of monotone Boolean functions.
37. Lemma 37 applies the positive-projection sign-change theorem from Lemma 13 to an injective positive ordering of the cube.
38. Lemma 38 combines Lemma 37 with the elementary support-volume bound for DNF terms and CNF clauses.
39. Lemma 39 combines the junta invariance from Lemma 28 with the compact determinant certificates from Lemma 25 and the two-bit parity theorem.
40. Lemma 40 abstracts Lemmas 37 and 38 to arbitrary one-sided subcube certificate covers.
41. Lemma 41 combines the denominator-orientation lemma from Lemma 32 with a margin approximation argument and the linear-fractional normal form from Lemma 10.
42. Lemma 42 combines the polynomial-threshold sparsity upper bound from Lemma 41 with complement and global bit-flip invariance from Lemma 28.
43. Lemma 43 applies the DNF literal-expansion upper bound from Lemma 42 to the accepting and rejecting leaves of a deterministic decision tree.
44. Lemma 44 sharpens Lemmas 42 and 43 using local positive-monomial or negative-monomial expansions, the polynomial-threshold sparsity upper bound from Lemma 41, and complement invariance from Lemma 28.
45. Lemma 45 combines Fourier-tail sign approximation with the polynomial-threshold sparsity upper bound from Lemma 41.
46. Lemma 46 combines the exact parity theorem from Lemma 8 with dummy-variable, permutation, complement, and restriction monotonicity from Lemma 28.
47. Lemma 47 combines the affine-parity restriction lower bound from Lemma 46, an explicit degree $m$ sign polynomial for inner product mod $2$, and the polynomial-threshold sparsity upper bound from Lemma 41.
48. Lemma 48 sharpens the polynomial-threshold sparsity upper bound from Lemma 41 by using one affine-over-positive-affine atom for the whole linear part of a sign polynomial.
49. Lemma 49 combines the two-bit parity threshold-degree lower bound with the affine-free polynomial-threshold sparsity upper bound from Lemma 48.
50. Lemma 50 combines the symmetric sign-change theorem from Lemma 12, restriction monotonicity from Lemma 28, polynomial-threshold sparsity from Lemma 41, and the one-head linear-threshold characterization from Lemma 10.
51. Lemma 51 combines the symmetric sign-change theorem from Lemma 12, restriction monotonicity from Lemma 28, affine-free polynomial-threshold sparsity from Lemma 48, and exact parity from Lemma 8.
52. Lemma 52 combines the symmetric sign-change theorem from Lemma 12, restriction monotonicity from Lemma 28, affine-free polynomial-threshold sparsity from Lemma 48, and the one-head characterization from Lemma 10.
53. Lemma 53 abstracts Lemmas 50 to 52 using symmetric one-bit slices and affine-free local polynomial expansion.
54. Lemma 54 combines the exact three-bit classification from Lemma 16, the top threshold-degree theorem from Lemma 27, and a finite threshold-vote enumeration.
55. Lemma 55 compares two binary encodings with two LTF gates and uses a one-pair equality restriction to prove optimality.
56. Lemma 56 combines the affine-over-positive-affine atom construction from Lemma 15 with the one-pair equality lower bound from Lemma 49.
57. Lemma 57 combines an explicit two-ratio certificate with the directed-defect one-head lower bound from Lemma 52.
58. Lemma 58 performs a finite certificate enumeration for every one-change two-pair local-count profile.
59. Lemma 59 verifies explicit two-ratio certificates for the three-pair intersection, containment, and equality endpoints.
60. Lemma 60 gives a uniform two-atom construction for equality using the binary encodings of the two strings.
61. Lemma 61 abstracts the equality construction by splitting an affine statistic into two positive affine parts.
62. Lemma 62 extends Lemma 61 from affine level sets to affine slabs by choosing a separating radius around the target interval and using the same two-atom numerator.
63. Lemma 63 combines the affine-slab theorem from Lemma 62 with the affine-free polynomial-threshold sparsity upper bound from Lemma 48.
64. Lemma 64 combines complement invariance from Lemma 28, the affine level-set theorem from Lemma 61, and the one-head characterization from Lemma 10.
65. Lemma 65 generalizes Lemma 64 by using finite hyperplane avoidance inside the vector space of affine functions vanishing on a proper affine hull.
66. Lemma 66 is a direct corollary of the positive-projection sign-change theorem from Lemma 13.
67. Lemma 67 combines the degree-based sign-rank lower-bound schema from Lemma 28 with the trivial rank ceiling of a communication matrix. Its limitation does not apply to the sharper two-head factorization in Theorem 182.
68. Lemma 68 combines the positive run-count setup from Lemma 66, the affine-slab theorem from Lemma 62, complement invariance from Lemma 28, and the one-head characterization from Lemma 10.
69. Lemma 69 combines the threshold-degree lower bound from Lemma 6, the positive-projection sign-change theorem from Lemma 13, and the one-head characterization from Lemma 10.
70. Lemma 70 combines the affine-free sparsity upper bound from Lemma 48 with the one-head characterization from Lemma 10.
71. Lemma 71 combines junta reduction from Lemma 39, the three-bit quadratic upper bound from Lemma 15, and the one-head characterization from Lemma 10.
72. Lemma 72 combines the local certificate-expansion bound from Lemma 44, junta reduction from Lemma 39, and the affine-free sparsity upper bound from Lemma 48.
73. Lemma 73 combines the sparse-support upper bound from Lemma 37, the local certificate-expansion bound from Lemma 44, junta reduction from Lemma 39, and the affine-free sparsity upper bound from Lemma 48.
74. Lemma 74 combines the polynomial-threshold sparsity upper bound from Lemma 41 with the cofactor interpolation polynomial.
75. Lemma 75 combines the affine-free sparsity upper bound from Lemma 48, the cofactor interpolation polynomial, and the low affine-free support exactness theorem from Lemma 70.
76. Lemma 76 is the affine-cofactor specialization of Lemma 75, with exactness at slope distance at most one from Lemma 70 and the one-head characterization from Lemma 10.
77. Lemma 77 minimizes Lemma 76 over split coordinates and affine separator choices, using coordinate permutation invariance from Lemma 28.
78. Lemma 78 sharpens Lemma 75 by counting actual coefficient changes in the cofactor interpolation polynomial, then applying affine-free sparsity from Lemma 48 and the one-head characterization from Lemma 10.
79. Lemma 79 applies the LTF cofactor slope-distance theorem from Lemma 76 to the four possible one-bit functions of a shared LTF feature.
80. Lemma 80 applies the split affine-free support invariant from Lemma 78 to the four possible one-bit functions of a shared sparse PTF feature.
81. Lemma 81 uses the threshold-degree lower bound from Lemma 6 and the one-bit sparse-PTF branching upper bound from Lemma 80.
82. Lemma 82 combines Lemma 81 with elementary slice interpolation for gates whose two one-bit slices are not opposite.
83. Lemma 83 iterates Lemma 81 and uses the polynomial-threshold sparsity upper bound from Lemma 41.
84. Lemma 84 combines threshold-degree monotonicity under restrictions, Lemma 83, and the threshold-degree lower bound from Lemma 6.
85. Lemma 85 uses the linear-fractional normal form from Lemma 10 and a margin perturbation argument.
86. Lemma 86 combines denominator orientation from Lemma 32 with the calibrated threshold-vote theorem from Lemma 85.
87. Lemma 87 combines the linear-fractional normal form from Lemma 10, dummy-variable approximation from Lemma 28, and complement invariance from Lemma 28.
88. Lemma 88 iterates the one-bit non-XOR recursion from Lemma 87 along a literal decision list.
89. Lemma 89 combines the calibrated threshold-vote theorem from Lemma 85 with endpoint one-head approximability from Lemma 86 and the fact that decision lists are strict weighted votes of their tests.
90. Lemma 90 combines the decision-list weighted-vote construction from Lemma 89 with the calibrated threshold-vote theorem from Lemma 85.
91. Lemma 91 combines affine square identities with denominator orientation from Lemma 32.
92. Lemma 92 combines the lower bound from Lemma 91 with an explicit negative-orientation one-head atom family.
93. Lemma 93 combines the calibrated threshold-vote perturbation argument from Lemma 85 with the raw approximation constructions from Lemmas 41 and 48.
94. Lemma 94 combines the strict decision-list vote from Lemma 90 with the raw-calibrated vote bound from Lemma 93.
95. Lemma 95 combines the threshold-degree lower bound from Lemma 6 with the raw-calibrated vote upper bound from Lemma 93.
96. Lemma 96 reuses the local certificate-expansion identities and signed pure-monomial approximation step from Lemma 44.
97. Lemma 97 uses the one-head atom normal form from Lemma 10 and the restriction argument from Lemma 28.
98. Lemma 98 combines the raw-calibrated vote support bound from Lemma 93 with the subcube raw calibration cost from Lemma 96.
99. Lemma 99 optimizes Lemma 98 over all strict cylinder-threshold representations.
100. Lemma 100 uses the cylinder transformations behind Lemma 99 to prove symmetry invariance, dummy-variable invariance, and restriction monotonicity for $\mathrm{ctc}$.
101. Lemma 101 shows that the local certificate-cover construction from Lemma 44 is a feasible point in the cylinder-threshold cost invariant from Lemma 99.
102. Lemma 102 observes that every positive monomial is a cylinder of $\mathrm{ctc}$ cost $1$, so sparse PTF representations are feasible cylinder-threshold representations.
103. Lemma 103 combines affine approximation from Lemma 48 with the subcube raw calibration construction from Lemma 96.
104. Lemma 104 compares Lemma 103 with affine-free sparsity from Lemma 48, polynomial-threshold sparsity from Lemma 102, and $\mathrm{ctc}$ from Lemma 99.
105. Lemma 105 combines Sherstov's optimal threshold-degree lower bound for intersections of two halfspaces with the threshold-degree lower bound from Lemma 6.
106. Lemma 106 applies Lemma 105 to the trivial two-gate threshold vote and length-two LTF decision list for the conjunction of two LTFs.
107. Lemma 107 combines the raw-calibrated vote upper bound from Lemma 93 with the halfspace-intersection lower-bound family from Lemma 105.
108. Lemma 108 adapts the cylinder transformations from Lemma 100 to affine-cylinder representations, tracking the affine cost under symmetries and restrictions.
109. Lemma 109 combines the affine-cylinder upper bound from Lemma 103 with the zero-head and one-head characterization from Lemma 10.
110. Lemma 110 combines the threshold-degree lower bound from Lemma 6, the affine-cylinder upper bound from Lemma 103, and the hierarchy comparison from Lemma 104.
111. Lemma 111 interpolates two affine-cylinder cofactor scores and rewrites the result as one affine block plus base and changed cylinder supports.
112. Lemma 112 optimizes Lemma 111 over cofactor scores and split coordinates, then uses low affine-cylinder exactness from Lemma 109.
113. Lemma 113 specializes Lemma 112 to cofactors with a shared cylinder correction.
114. Lemma 114 compares the split affine-cylinder invariant from Lemma 112 with the split affine-free support invariant from Lemma 78.
115. Lemma 115 combines the affine-cylinder upper bound from Lemma 103 with the one-head characterization from Lemma 10.
116. Lemma 116 combines the split affine-cylinder invariant from Lemma 112 with the first affine-cylinder levels from Lemma 115.
117. Lemma 117 applies low affine-cylinder exactness from Lemma 109 to one pure-cylinder affine perturbation.
118. Lemma 118 applies the split affine-cylinder interpolation invariant from Lemma 112 to the two cofactors of one-bit gates over an affine-cylinder feature.
119. Lemma 119 specializes Lemma 118 to fresh-bit XOR and combines it with the fresh-bit XOR threshold-degree lower bound from Lemma 81.
120. Lemma 120 combines the cofactor interpolation rule from Lemma 111 with optimal cofactor affine-cylinder costs and the elementary inequality $\kappa(P\cup\lbrace z\rbrace,N)\leq2\kappa(P,N)$.
121. Lemma 121 specializes one-bit affine-cylinder branching from Lemma 118 to literal conjunctions and uses complement duality for literal disjunctions.
122. Lemma 122 optimizes Lemma 121 over affine-cylinder scores and the two lifted literal orientations, using global bit-flip invariance from Lemma 28.
123. Lemma 123 classifies the non-XOR and non-XNOR two-input gates into degenerate, feature-only, and literal-gated cases, then applies Lemma 122.
124. Lemma 124 optimizes the fresh-bit XOR affine-cylinder bound from Lemma 119 and compares it with the fresh-bit XOR threshold-degree lower bound from Lemma 81.
125. Lemma 125 applies the affine-cylinder transformations from Lemma 108 to the optimized lifted costs from Lemmas 122 and 124.
126. Lemma 126 combines the fresh-bit XOR threshold-degree lower bound from Lemma 81 with the affine-slab exactness theorem from Lemma 62.
127. Lemma 127 generalizes Lemma 126 by applying the fresh-bit XOR threshold-degree lower bound from Lemma 81 and the affine-slab exactness theorem from Lemma 62 to the endpoint gap of an arbitrary affine statistic.
128. Lemma 128 combines the affine endpoint structure from Lemma 127, the fresh-bit XOR exactness from Lemma 127, and the one-head characterization from Lemma 10.
129. Lemma 129 combines the affine-slab theorem from Lemma 62, the fresh-bit XOR threshold-degree theorem from Lemma 81, and the one-head characterization from Lemma 10.
130. Lemma 130 combines the affine-statistic sign-change theorem from Lemma 63 with the LTF one-bit gate classification from Lemma 129.
131. Lemma 131 combines the positive-projection sign-change theorem from Lemma 13 with the LTF one-bit gate classification from Lemma 129 and the fresh-bit XOR threshold-degree theorem from Lemma 81.
132. Lemma 132 applies the positive-projection sign-change theorem from Lemma 13 to the separated two-slice projection.
133. Lemma 133 combines the internal positive-slab sign sequence with Lemma 132 and the one-bit gate threshold-degree trichotomy from Lemma 82.
134. Lemma 134 packages Lemmas 131, 132, and 133 with the one-bit gate threshold-degree trichotomy from Lemma 82.
135. Lemma 135 combines the affine-over-positive-affine atom lemma from Lemma 15 with a determinant span over one positive statistic and one raw bit.
136. Lemma 136 combines the affine-over-positive-affine atom lemma from Lemma 15 with a cubic determinant span over one positive statistic and one raw bit.
137. Lemma 137 combines Lemmas 133, 135, and 136 with the fresh-bit XOR theorem from Lemma 81, the one-bit gate trichotomy from Lemma 82, and the affine-slab theorem from Lemma 62.
138. Lemma 138 generalizes Lemmas 135 and 136 by using one-dimensional slice interpolation for the two raw-bit slices and positive affine denominators with shifted roots.
139. Lemma 139 combines the sign-change root polynomial for one positive statistic with Lemma 138 and the fresh-bit XOR threshold-degree theorem from Lemma 81.
140. Lemma 140 combines the same sign-change root polynomial with Lemma 138 and the non-XOR cases of the one-bit gate threshold-degree trichotomy from Lemma 82.
141. Lemma 141 packages Lemmas 139 and 140 with the one-bit gate threshold-degree trichotomy from Lemma 82 under the equality condition $\deg_{\pm}(T)=C$.
142. Lemma 142 combines the symmetric exactness theorem from Lemma 12 with the degree-tight positive-statistic gate classification from Lemma 141.
143. Lemma 143 packages Lemmas 139 and 140 with the full one-bit gate threshold-degree trichotomy from Lemma 82.
144. Lemma 144 optimizes Lemma 143 over positive projections using the invariant $C_{+}(f)$ from Lemma 13.
145. Lemma 145 embeds the shared positive statistic and the raw-bit binary code into one larger positive statistic, then applies the positive-projection sign-change theorem from Lemma 13.
146. Lemma 146 combines Lemma 145 with the elementary root bound that a univariate degree $d$ polynomial has at most $d$ strict sign changes along an ordered real sequence.
147. Lemma 147 refines Lemma 145 by ordering raw slices with arbitrary positive raw weights and counting the actual boundary sign changes.
148. Lemma 148 specializes Lemma 147 to gates over several raw bits and one positive-statistic feature.
149. Lemma 149 optimizes Lemma 147 over the common positive statistic and the positive raw order.
150. Lemma 150 combines Lemma 147 with the univariate root bound used in Lemma 146, preserving the actual boundary-jump term.
151. Lemma 151 specializes Lemma 147 to multi-raw gates and optimizes the endpoint boundary term over positive raw orders.
152. Lemma 152 is the equal-endpoint specialization of Lemma 151, where the mixed boundary cost becomes the raw positive-order sign-change count.
153. Lemma 153 proves a combinatorial upper bound on the mixed boundary cost and applies it to the opposite-endpoint case of Lemma 151.
154. Lemma 154 applies Lemmas 152 and 153 to conjunction, disjunction, and XOR with an arbitrary raw mask.
155. Theorem 155 combines the mixed-boundary upper bound from Lemma 151 with restriction monotonicity and complement invariance from Lemma 28.
156. Theorem 156 combines the raw-mask endpoint bounds from Lemma 154 with restriction monotonicity and the threshold-degree lower bound.
157. Theorem 157 bounds $C_{+}(R)$ by the actual run count in one positive raw order, then substitutes that bound into Lemma 154.
158. Theorem 158 combines the ordered common positive-statistic slice bound from Lemma 147 with restriction monotonicity and the mixed endpoint cost from Lemma 151.
159. Theorem 159 combines Theorem 158 with the univariate root-count argument from Lemma 146 and the threshold-degree lower bound.
160. Theorem 160 specializes Theorems 158 and 159 to addressed slice families with one common endpoint background.
161. Theorem 161 combines Theorem 158 with the mixed boundary inequality from Lemma 153 and the few-run raw-mask theorem from Theorem 157.
162. Theorem 162 combines the ordered-slice upper bound from Lemma 147, the endpoint-coupled upper bound from Theorem 158, and the threshold-degree lower bound.
163. Theorem 163 optimizes Theorem 158 over all shared positive-statistic certificates and compares the resulting cost with Lemma 149.
164. Theorem 164 specializes Theorems 158 and 159 to sparse active raw-slice sets.
165. Theorem 165 applies the positive-projection sign-change theorem from Lemma 13 to the combined statistic $Ku(z)+t(y)$ and uses restriction monotonicity for the lower bound.
166. Theorem 166 combines Theorem 165 with the univariate root-count argument and the threshold-degree lower bound.
167. Theorem 167 specializes Theorems 165 and 166 to the raw Hamming-weight statistic.
168. Theorem 168 specializes Theorems 165 and 166 to sparse active raw-level sets.
169. Theorem 169 optimizes Theorem 165 over positive-grid certificates and uses the positive-projection sign-change theorem from Lemma 13 for comparison with $C_{+}$.
170. Theorem 170 extends the positive-grid construction by choosing separated positive scales for several block statistics.
171. Theorem 171 specializes Theorem 170 to Hamming-weight statistics on several blocks.
172. Theorem 172 combines Theorem 170 with the elementary run-count formula for sign changes in a Boolean sequence.
173. Theorem 173 optimizes Theorem 170 over positive multigrid certificates and block orders, and compares the resulting cost with $C_{+}$.
174. Theorem 174 specializes Theorems 171 and 172 to the best block order for multiblock Hamming-profile predicates.
175. Theorem 175 applies the positive-projection sign-change theorem from Lemma 13 to weighted sums of block Hamming weights.
176. Theorem 176 combines Theorem 175 and the exact symmetric parity value with an explicit lexicographic parity-transition count for singleton partitions.
177. Theorem 177 reduces a singleton two-block Hamming grid point to the affine level-set theorem by a nonresonant linear recombination of the two block weights.
178. Theorem 178 applies the affine level-set theorem directly to any affine line layer in the two-block Hamming grid and compares it with bivariate grid sign degree.
179. Theorem 179 applies the affine slab theorem directly to any affine strip in the two-block Hamming grid and compares it with bivariate grid sign degree.
180. Theorem 180 combines the linear-fractional normal form from Lemma 10 with an explicit $48\times8$ sign matrix whose rows hit every generic two-dimensional tope cycle. Clearing two positive denominators gives a sum of two affine products, whose two-block singleton-slice matrix has rank at most six.
181. Theorem 181 compresses the tope-cycle hitting set in Theorem 180 from $48$ rows to $35$ rows and verifies all $5160960$ antipodal coordinate-flip paths by exhaustive enumeration.
182. Theorem 182 applies the same tope-cycle obstruction to an eight-column restriction of the six-bit Hamming-distance threshold matrix. It also strengthens the two-head rank bound from singleton slices to arbitrary Cartesian partitions.
183. Theorem 183 exhaustively classifies all four-bit functions using exact integer two-head and three-head scores, exact positive-circuit obstructions to degree two, and the analytic parity theorem.
184. Theorem 184 embeds the compact path obstruction from Theorem 181 into the partition sign matrix of an explicit quadratic polynomial on a six-bit by five-bit split.
185. Theorem 185 uses five antipodal slice pairs to force strict diagonal dominance in a $5\times5$ quadratic cross block. Every cleared two-head score has cross-block rank at most four.
186. Theorem 186 reduces every five-bit degree-four sign table to an affine-cocircuit extension, then covers all $65$ normal orbits by exact four-head shattering and finite residual certificates.
187. Theorem 187 combines the monochromatic-triangle matrix-completion theorem and the sign-cell locking reduction with an exhaustive exact cocircuit tangent cover and $380$ rational two-head archive certificates.
189. Theorem 189 combines the linear-fractional normal form and denominator orientation with a fourteen-rectangle mixed-curvature certificate, a normalized shell-transition reduction, and a four-dimensional column-max spectral inequality. An exact integer three-head score gives the matching upper bound.
190. Theorem 190 is the direct two-slice factorization of the cleared linear-fractional numerator. Its Grassmann dimension and bounded atlas follow from the Koszul overlap and maximal Plücker charts.
191. Theorem 191 combines the Boolean-cube filtration with the full-rank Boolean-lattice up map to compute the exact generic evaluated slice dimension and its middle-level collapse.
192. Theorem 192 expands the cleared Chow tangent across arbitrary coordinate blocks, counts its rank-one terms by used blocks, and compares the resulting cap with the ambient CP-rank ceiling.
193. Theorem 193 eliminates the positive-secant mixture scalar, blows up the endpoint diagonal, and uses simplex tangent cones plus continuity to prove that strict feasibility is unchanged.
194. Theorem 194 retains the mixture scalar, jointly blows up the endpoint and scalar diagonal, and uses interior strictification to obtain a closed compact system with one signed constraint per cube vertex.
195. Theorem 195 applies approximate Carathéodory in an $\ell_p$ space with $p=\Theta(n)$ to the convex hull of output-normalized one-head score vectors.
196. Theorem 196 combines the Fourier support-cost compiler with the absolute Walsh-tail test and solves the resulting bounded integer-cost cover problem by exact knapsack dynamic programming.
197. Theorem 197 is the exact fractional-knapsack solution of linear optimization over a rational box intersected with one sum equality.

## What This Currently Says About The First Core Question

The current evidence gives a precise first-level characterization: one head is exactly linear threshold power. It also gives an explicit strict separation at the next level. The Hamming threshold from Theorem 189 satisfies

$$ \deg_{\pm}(f_8)=2\lt3=H^{\ast}(f_8). $$

Thus the full problem cannot be reduced to threshold degree. It can instead be reframed as understanding the minimum number of linear-fractional attention atoms needed before the final threshold:

$$ \deg_{\pm}(f) \leq H^{\ast}(f) = L_{\mathrm{frac}}(f) \leq C_{+}(f) \leq M_{+}(f) - 1. $$

Whenever the left and right sides of the first sandwich meet, the value is exact:

$$ \deg_{\pm}(f)=C_{+}(f) \qquad\Longrightarrow\qquad H^{\ast}(f)=\deg_{\pm}(f)=C_{+}(f). $$

The same applies to any particular positive projection. If its sign-change count is $C$ and threshold degree is also $C$, then $H^{\ast}(f)=C$. In particular, every function with $C_{+}(f)\leq2$ has exact value $0$, $1$, or $2$ by the constant, nonconstant LTF, or non-LTF split.

There is also an independent sparse-polynomial route:

$$ \deg_{\pm}(f) \leq H^{\ast}(f) \leq \mathrm{afs}_{\pm}(f) \leq \mathrm{ptfsp}(f), $$

and therefore

$$ \deg_{\pm}(f)\leq d \qquad\Longrightarrow\qquad H^{\ast}(f) \leq 1+\sum_{r=2}^{d}\binom{n}{r} $$

for nonconstant $f$.

The first nontrivial affine-free support regime is exact:

$$ \mathrm{afs}_{\pm}(f)\leq2 \qquad\Longrightarrow\qquad H^{\ast}(f)\in\lbrace0,1,2\rbrace, $$

with the same constant, nonconstant LTF, or non-LTF split. In particular, any affine threshold perturbed by one nonlinear monomial is either still one-head or exactly two-head.

A recursive sparse-polynomial route is now available. If the two cofactors have sparse sign polynomials with nonconstant supports $\mathcal{A}_0,\mathcal{A}_1$, then

$$ H^{\ast}(f) \leq m_0 +\lvert\mathcal{A}_0\cup\mathcal{A}_1\rvert +1. $$

This does not yet compose head representations directly, but it gives a clean inductive upper-bound method for decision-tree, formula, and branching-style arguments whenever cofactor sign polynomials stay sparse.

The affine-free version is sharper when the cofactors have large affine parts. If both cofactors across one split are LTFs, then

$$ H^{\ast}(f)\leq n. $$

If their affine separators differ in at most one slope coordinate, then the exact constant, LTF, or two-head split applies.

Equivalently, for LTF cofactors one can define a slope-distance cost $t$ between the two affine cofactor separators. The direct bound is

$$ H^{\ast}(f)\leq1+t. $$

This gives a concrete invariant to optimize over separator choices before falling back to the coarser $n$-head bound.

Minimizing the slope distance over all split coordinates gives a coordinate-free version:

$$ H^{\ast}(f) \leq 1+\sigma_{\mathrm{split}}(f). $$

This applies whenever fixing some coordinate leaves two LTF cofactors.

For arbitrary sparse cofactor sign polynomials, the stronger split affine-free support invariant gives

$$ H^{\ast}(f) \leq \mathrm{scafs}_{\pm}(f). $$

It pays for the affine-free support of one base cofactor and for coefficients that change across the split, so shared nonlinear terms are not paid twice.

For any inner feature $T$, every non-XOR two-input gate with one fresh raw bit satisfies

$$ H^{\ast}(G(z,T(y)))\leq H^{\ast}(T)+1. $$

This settles the $z\wedge T$ and $z\vee T$ recursive cases for arbitrary $T$. The same argument covers implications, NAND, NOR, literal variants, and output complements. XOR and XNOR are the remaining one-bit gates not covered by this recursion theorem.

Iterating the non-XOR recursion along a literal decision list gives

$$ H^{\ast}(f)\leq L_{\mathrm{litDL}}(f). $$

This proves the literal-test case of the decision-list upper-bound program. Linear-threshold decision lists remain harder because their tests are not raw literals exposed to Lemma 87.

The calibrated-vote route extends the decision-list theorem from raw literals to endpoint affine-threshold tests. If a length $L$ decision list tests positive OR-type features $\mathbf{1}[L_S\gt0]$, positive AND-type features $\mathbf{1}[L_S=\Lambda_S]$, or their complements, then

$$ H^{\ast}(f)\leq L. $$

The proof first writes the decision list as a strict weighted vote over its tests, then applies calibrated endpoint approximations.

More generally, every length $L$ decision list is a strict weighted vote over its tests. If each test indicator has a calibrated one-head atom approximation with total weighted error below the vote margin, then

$$ H^{\ast}(f)\leq L. $$

This isolates the remaining obstacle for linear-threshold decision lists: one must approximate the raw test indicators as one-head atoms, not merely compute each test after thresholding a one-head score.

That obstacle is real already for monotone three-bit LTFs. The internal threshold

$$ T(x)=x_1\wedge(x_2\vee x_3) $$

has $H^{\ast}(T)=1$, but every one-head atom is at uniform distance at least $1/4$ from the raw $0/1$ indicator of $T$. Thus calibrated LTF-test bounds must use extra structure of the whole vote or list, not independent one-atom indicator replacements for arbitrary inner LTFs.

This $1/4$ barrier is sharp as an infimum: a negative-orientation denominator family approaches uniform error $1/4$ from above. So the obstruction is not a loose estimate, but the exact one-atom geometry of this internal LTF indicator.

A multi-atom fallback remains available. If $\rho(T)$ is the raw atom approximation cost of a feature, then any strict weighted vote over features $T_j$ satisfies

$$ H^{\ast}(f) \leq \sum_{j:c_j\neq0}\rho(T_j). $$

The exact multilinear expansion of $T$ gives $\rho(T)\leq\mathrm{eafs}(T)$. For the internal LTF $x_1\wedge(x_2\vee x_3)$, this gives $\rho(T)\leq3$, while the one-atom obstruction gives $\rho(T)\neq1$.

Combining the same raw-cost theorem with the decision-list vote construction gives

$$ H^{\ast}(f) \leq \sum_{j=1}^{L}\rho(T_j) \leq \sum_{j=1}^{L}\mathrm{eafs}(T_j) $$

for every length $L$ decision list with tests $T_j$. Thus LTF decision lists now have a concrete fallback through the exact multilinear expansions of the tests, even though a length $L$ bound for arbitrary LTF tests remains open.

The raw calibration cost also has a lower-bound route. If a strict weighted vote over features $T_j$ has high threshold degree, then

$$ \sum_j\rho(T_j)\geq\deg_{\pm}(f). $$

In particular, high threshold degree for an intersection $T_1\wedge T_2$ forces at least one of $T_1,T_2$ to have raw calibration cost at least half that threshold degree. This is the repo-native form of the Sherstov halfspace-intersection warning.

The direct head-complexity version is now explicit. There are pairs of halfspaces $T_n,U_n$ whose intersection

$$ F_n=T_n\wedge U_n $$

satisfies

$$ H^{\ast}(F_n)\geq c n. $$

At the same time, this family has threshold-vote size at most $2$ and LTF decision-list length at most $2$. Therefore neither of those classical-looking sizes can upper-bound $H^{\ast}$, even up to a constant factor. The surviving threshold-vote theorem is necessarily calibrated: it must control the raw atom scores, not only the thresholded inner gates.

This also proves a direct worst-case lower bound for raw calibration of LTF indicators. If

$$ R_{\mathrm{LTF}}(n) := \max\lbrace\rho(T):T:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace\text{ is a nonconstant LTF}\rbrace, $$

then

$$ R_{\mathrm{LTF}}(n)\geq c n $$

for infinitely many $n$. Equivalently, there are nonconstant LTFs $V_n$ with

$$ H^{\ast}(V_n)=1 \qquad \text{but} \qquad \rho(V_n)\geq c n. $$

Thus raw calibration cost is not controlled by head complexity alone, even inside the one-head class.

The affine-cylinder invariant also has the expected structural behavior: it is invariant under output complement, coordinate permutation, global bit-flip, and dummy-variable extension, and it is monotone under restrictions. Consequently, searches for low $\mathrm{actc}$ can quotient by the same standard symmetries used for $H^{\ast}$ and $\mathrm{ctc}$.

At the first nontrivial level, $\mathrm{actc}$ gives exact head counts. If

$$ \mathrm{actc}(f)\leq2, $$

then $H^{\ast}(f)$ is exactly $0$, $1$, or $2$ according as $f$ is constant, a nonconstant LTF, or neither. This packages the low affine-free support exactness result and gives the same conclusion to any function with a two-cost affine-cylinder certificate.

The invariant is also lower-bounded by threshold degree:

$$ \deg_{\pm}(f) \leq H^{\ast}(f) \leq \mathrm{actc}(f) \leq \min\lbrace\mathrm{ctc}(f),\mathrm{afs}_{\pm}(f)\rbrace. $$

Thus high-threshold-degree families force high $\mathrm{actc}$. In particular,

$$ \mathrm{actc}(\mathrm{XOR}_n)\geq n, $$

and Sherstov's hard intersections of two halfspaces satisfy $\mathrm{actc}(F_n)\geq c n$.

There is also a cofactor interpolation rule for $\mathrm{actc}$. If two cofactors have affine-cylinder scores, one can glue them by

$$ S(z,y)=(1-z)S_0(y)+zS_1(y). $$

The resulting cost pays for the base affine-cylinder certificate, for affine slopes that change across the split as cylinders $zy_i$, and for cylinder coefficients that change across the split as cylinders $zC_{P,N}$. Thus $\mathrm{actc}$ has a recursive search rule analogous to the split affine-free support invariant, but with mixed-literal cylinders replacing monomials.

Subcube indicators now have an explicit raw-cost certificate. For

$$ C_{P,N}(x) = \left(\prod_{i\in P}x_i\right) \left(\prod_{j\in N}(1-x_j)\right), $$

Lemma 96 gives

$$ \rho(C_{P,N}) \leq \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace $$

unless the cylinder is vacuous, in which case the cost is $0$. Thus the local certificate-expansion theorem can be used as a per-feature raw calibration theorem inside votes and decision lists, not only as a one-sided cover of a label class.

The raw calibration cost also has the expected structural invariances:

$$ \rho(1-T)=\rho(T), \qquad \rho(T^{\pi})=\rho(T), \qquad \rho(T^{\mathrm{flip}})=\rho(T). $$

It is unchanged by dummy-variable extension, and restrictions can only decrease it. Thus lower-bound searches for $\rho$ may use canonical representatives and restricted witnesses without changing the target invariant.

Combining raw-calibrated votes with the subcube cost gives a direct cylinder-threshold upper bound. If $f$ is a strict real threshold of subcube indicators $C_{P_a,N_a}$, then

$$ H^{\ast}(f) \leq \sum_{a:c_a\neq0}\kappa(P_a,N_a), $$

where $\kappa(P,N)=0$ for the vacuous cylinder and otherwise equals

$$ \min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace. $$

This extends local certificate expansion from one-sided covers to arbitrary strict real votes over partial-assignment cylinders.

Optimizing this certificate gives the cylinder-threshold cost invariant $\mathrm{ctc}(f)$:

$$ H^{\ast}(f)\leq\mathrm{ctc}(f). $$

This invariant is finite for every Boolean function by the singleton-cylinder representation. It packages local certificate covers, signed overlapping cylinder votes, and any future low-cost cylinder-threshold normal form into one upper-bound target.

The invariant $\mathrm{ctc}$ has the same basic structural behavior expected of a reusable Boolean-function cost. It is invariant under output complement, coordinate permutation, global bit-flip, and dummy-variable extension, and it is monotone under restrictions:

$$ \mathrm{ctc}(g)\leq\mathrm{ctc}(f) $$

whenever $g$ is a restriction of $f$. Thus upper-bound searches may quotient by the standard symmetries, while lower-bound attempts may pass to restrictions.

The $\mathrm{ctc}$ invariant also subsumes the local certificate-expansion route. A one-sided certificate cover gives a feasible strict cylinder-threshold score, so

$$ \mathrm{ctc}(f) \leq \sum_{(P,N)\in\mathcal{C}_b}\kappa(P,N) $$

for $b\in\lbrace0,1\rbrace$. Thus the DNF/CNF local-expansion and decision-tree leaf-profile costs are upper bounds on $\mathrm{ctc}(f)$ before converting to heads.

The ordinary sparse-PTF route also factors through $\mathrm{ctc}$. Every positive monomial $\prod_{i\in S}x_i$ is the cylinder $C_{S,\varnothing}$ with $\kappa(S,\varnothing)=1$, so

$$ H^{\ast}(f) \leq \mathrm{ctc}(f) \leq \mathrm{ptfsp}(f). $$

Thus $\mathrm{ctc}$ is a common refinement of local cylinder covers and sparse monomial sign-polynomial certificates, although affine-free sparsity can still be sharper for dense affine threshold pieces.

The dense-affine caveat is now captured by a stronger invariant. The affine-cylinder threshold cost $\mathrm{actc}(f)$ allows one arbitrary affine part at cost one when its linear part is nonzero, then pays the same local cylinder cost for the remaining strict signed cylinder vote:

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{ctc}(f). $$

It also refines affine-free sparse sign-polynomial certificates:

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \mathrm{afs}_{\pm}(f) \leq \mathrm{ptfsp}(f). $$

Hence the current best optimized upper-bound hierarchy is

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq \min\lbrace\mathrm{ctc}(f),\mathrm{afs}_{\pm}(f)\rbrace. $$

For nonconstant functions with $\deg_{\pm}(f)\leq d$, this recovers the affine-free degree bound through $\mathrm{actc}$:

$$ H^{\ast}(f) \leq \mathrm{actc}(f) \leq 1+\sum_{r=2}^{d}\binom{n}{r}. $$

For any Boolean gate $G$ of one raw bit and one LTF feature $T$ with separator support $S$,

$$ H^{\ast}(G(z,T(y)))\leq1+\lvert S\rvert. $$

This gives a concrete upper bound for $z\wedge T(y)$, $z\vee T(y)$, $z\oplus T(y)$, and their complements.

For a sparse PTF feature $T$ with sign polynomial $P$, the analogous one-bit branching bound is

$$ H^{\ast}(G(z,T(y)))\leq1+\ell(P)+2q(P), $$

where $\ell(P)$ is the number of nonzero linear coefficients and $q(P)$ is the number of nonlinear monomials. Gates such as $z\wedge T(y)$ can use the sharper branch-dependent form and only pay $1+\ell(P)+q(P)$.

The XOR gate has a matching threshold-degree amplifier:

$$ \deg_{\pm}(z\oplus f(y))=\deg_{\pm}(f)+1. $$

Thus recursive upper-bound attempts for $z\oplus f$ are forced to pay at least one new head whenever the lower bound is tight for $f$.

More generally, the threshold-degree behavior of every one-bit gate $G(z,T(y))$ is now classified. Constant-slice gates have degree $0$ or $1$, non-XOR gates that genuinely use $T$ have degree $\deg_{\pm}(T)$, and XOR or XNOR has degree $\deg_{\pm}(T)+1$.

The XOR amplifier iterates over parity blocks:

$$ \deg_{\pm} \left(\left(\bigoplus_{j=1}^{k}z_j\right)\oplus T(y)\right) = k+\deg_{\pm}(T). $$

Consequently, restrictions of this parity-block form certify

$$ H^{\ast}(f)\geq k+\deg_{\pm}(T). $$

For symmetric functions, the exact answer is now the sign-change count of the Hamming-weight truth table. More generally, positive-projection sign-change count gives a sharper upper bound than positive weighted-sum image size. Parity is the maximally alternating symmetric case, giving $H^{\ast}(\mathrm{XOR}_n) = n$.

For all functions on at most four bits, threshold degree is now exact:

$$ H^{\ast}(f) = \deg_{\pm}(f) \qquad (n \leq 4). $$

This also solves the first adaptive decision-tree layer: if $D(f)\leq2$, then $f$ is a three-junta with a quadratic sign representation, so $H^{\ast}(f)$ is $0$, $1$, or $2$ according as it is constant, a nonconstant LTF, or neither.

For four-bit functions, the current best universal bound is much sharper than the generic interpolation bound:

$$ f : \lbrace0,1\rbrace^4 \to \lbrace0,1\rbrace \qquad \Longrightarrow \qquad H^{\ast}(f) \leq 4. $$

For five-bit functions, a larger determinant certificate gives

$$ f : \lbrace0,1\rbrace^5 \to \lbrace0,1\rbrace \qquad \Longrightarrow \qquad H^{\ast}(f) \leq 7. $$

For six-bit functions, the current determinant certificate gives

$$ f : \lbrace0,1\rbrace^6 \to \lbrace0,1\rbrace \qquad \Longrightarrow \qquad H^{\ast}(f) \leq 11. $$

For seven-bit functions, the current determinant certificate gives

$$ f : \lbrace0,1\rbrace^7 \to \lbrace0,1\rbrace \qquad \Longrightarrow \qquad H^{\ast}(f) \leq 19. $$

For eight-bit functions, the current determinant certificate gives

$$ f : \lbrace0,1\rbrace^8 \to \lbrace0,1\rbrace \qquad \Longrightarrow \qquad H^{\ast}(f) \leq 32. $$

For nine-bit functions, the current determinant certificate gives

$$ f : \lbrace0,1\rbrace^9 \to \lbrace0,1\rbrace \qquad \Longrightarrow \qquad H^{\ast}(f) \leq 57. $$

For ten-bit functions, the current determinant certificate gives

$$ f : \lbrace0,1\rbrace^{10} \to \lbrace0,1\rbrace \qquad \Longrightarrow \qquad H^{\ast}(f) \leq 103. $$

The compact threshold certificate further gives

$$ f : \lbrace0,1\rbrace^{11} \to \lbrace0,1\rbrace \qquad \Longrightarrow \qquad H^{\ast}(f) \leq 187, $$

and

$$ f : \lbrace0,1\rbrace^{12} \to \lbrace0,1\rbrace \qquad \Longrightarrow \qquad H^{\ast}(f) \leq 342. $$

The determinant-span schema also explains why the numbers

$$ 3,4,7,11,19,32,57,103,187,342 $$

are natural for this method: for $n$ input bits, the method cannot span all $2^n$ sign patterns unless

$$ H \geq \left\lceil \frac{2^n - 1}{n} \right\rceil. $$

The certificates through $n=12$ meet that dimension threshold.

On the lower-bound side, the counting lemma gives a worst-case exponential lower bound:

$$ \max_{f : \lbrace0,1\rbrace^n \to \lbrace0,1\rbrace} H^{\ast}(f) = \Omega \left(\frac{2^n}{n^2}\right). $$

Moreover, this is a typical-function statement: for some absolute constant $c\gt0$, all but a $2^{-\Omega(2^n)}$ fraction of $n$-bit Boolean functions have

$$ H^{\ast}(f) \gt c\frac{2^n}{n^2}. $$

The threshold-degree method itself has a sharp ceiling: parity and anti-parity are the only functions with $\deg_{\pm}(f)=n$. Thus threshold degree cannot explain the exponential typical lower bound.

For upper bounds, Fourier tails give a quick threshold-degree certificate: if the high-degree tail of the sign function is uniformly smaller than $1$, truncation gives a low-degree sign representation. Degree-restricted span certificates can then convert that low threshold degree into a head upper bound.

The one-head atom denominator has a built-in orientation constraint: all variable coefficients point in the same direction unless the denominator is constant. This explains why monotone DNF and CNF have clean one-head-per-term constructions, and why arbitrary mixed-literal DNF is not handled by the same proof.

Affine level sets are now uniformly controlled: every predicate of the form $\mathbf{1}[L(x)=0]$ for affine $L$ has $H^{\ast}\leq2$, and its exact value is $0$, $1$, or $2$ according as it is constant, a nonconstant LTF, or neither. This recovers internal exact-count predicates and binary-encoded equality as special cases.

The same two-head mechanism controls affine slabs: every predicate $\mathbf{1}[\alpha\leq L(x)\leq\beta]$ has exact value $0$, $1$, or $2$ according as it is constant, a nonconstant LTF, or neither. This includes tolerance predicates around equality of binary encodings.

For any function of one affine statistic $G(L(x))$, the ordered sign-change count of $G$ gives an orientation-free upper bound. Zero, one, and two changes are exactly handled by constants, LTFs, and affine slabs; three or more changes have the explicit bound $1+\sum_{r=2}^{\min\lbrace C,k\rbrace}\binom{k}{r}$, where $k$ is the support size of $L$.

Sparse-support structure is also sharper at the first nontrivial level: if the smaller label class has size at most two, then the exact value is $0$, $1$, or $2$ according as the function is constant, a nonconstant LTF, or neither.

More generally, any affine-hull clean label class with proper affine hull gives the same $0$, $1$, or $2$ exact split. This upgrades a geometric class of sparse and structured supports from the generic support-volume bound to a two-head certificate.

Between positive-projection structure and raw sparse support sits the positive run-count invariant $R_{+}(f)$. It gives $H^{\ast}(f)\leq2R_{+}(f)$, recovering sparse support because the number of minority runs is at most the number of minority points, but improving it whenever the minority label class clusters in a positive ordering.

The first nontrivial run-count case is exact: if $R_{+}(f)=1$, then $H^{\ast}(f)$ is $0$, $1$, or $2$ according as $f$ is constant, a nonconstant LTF, or neither. The reason is that one positive-order run is an affine slab after inserting cutpoints around the run.

There are also reusable lower-bound closure tools. If $f$ has a restriction equal to $k$-bit parity or anti-parity, then $H^{\ast}(f)\geq k$. Dummy variables do not change $H^{\ast}$, so every exact classification for $k$ variables automatically applies to $k$-juntas inside larger cubes. More generally, a high-sign-rank communication matrix under any input partition forces enough heads to support a degree $H$ sign matrix of that rank.

The degree-based sign-rank route from Lemma 28 has a small-dimension ceiling: it cannot certify $H^{\ast}\geq3$ for any function on at most $13$ input bits. Theorem 182 surpasses that ceiling by retaining the exact sum-of-two-affine-products form of a cleared two-head score, which forces partition sign-rank at most $6$.

That is not yet a full invariant. It is only a partial answer:

- checkerboard structure certifies $H^{\ast}(f) \geq 2$,
- counting structure certifies that worst-case and typical head complexity are exponential up to polynomial slack,
- restriction and sign-rank structure certify additional explicit lower bounds,
- sign-rank dimension structure shows that the degree-only route cannot certify three heads below fourteen input bits, while exact two-head factorization gives the sharper rank-six obstruction used in Theorem 182,
- multiway sign CP rank is at most $k(k^H-(k-1)^H)$ for every $k$-block coordinate partition of an $H$-head function, but its ambient rank ceiling cannot rule out $H$ heads when $n\leq2H+1$,
- positive-secant feasibility has an exact diagonal blow-up whose $t=0$ boundary consists of normalized tangent directions rather than trivial equal endpoints,
- signed-secant feasibility has a closed compact diagonal blow-up with only $2^n$ signed inequalities and no simplex-face case split,
- output-normalized atomic margin certifies $H^{\ast}(f)=O(n\kappa_{\mathrm{atom}}(f)^2)$ and motivates denominator-group boosting,
- affine-parity restrictions certify $H^{\ast}(f)\geq\pi_{\oplus}(f)$, where $\pi_{\oplus}(f)$ is the largest affine-parity subcube dimension,
- inner-product mod $2$ has the explicit bracket $m\leq H^{\ast}(\mathrm{IP}_m)\leq2^m-1$,
- equality on two $m$-bit strings is fully exact: $\deg _{\pm}(\mathrm{EQ}_m)=H^{\ast}(\mathrm{EQ}_m)=2$ and $s _{\mathrm{LTF}}(\mathrm{EQ}_m)=2$,
- positive-projection sign-change count is exact whenever it equals threshold degree, and all functions with $C _{+}(f)\leq2$ have exact value $0$, $1$, or $2$ according as they are constant, nonconstant LTFs, or neither,
- affine level-set predicates $\mathbf{1}[L(x)=0]$ have exact value $0$, $1$, or $2$ according as they are constant, nonconstant LTFs, or neither,
- affine slab predicates $\mathbf{1}[\alpha\leq L(x)\leq\beta]$ have exact value $0$, $1$, or $2$ according as they are constant, nonconstant LTFs, or neither,
- affine-statistic predicates $G(L(x))$ have an orientation-free sign-change upper bound $H^{\ast}\leq1+\sum _{r=2}^{\min\lbrace C,k\rbrace}\binom{k}{r}$ for $C\geq3$, with exact handling for $C\leq2$,
- functions with minority support size at most two have exact value $0$, $1$, or $2$ according as they are constant, nonconstant LTFs, or neither,
- affine-hull clean label classes with proper affine hull have exact value $0$, $1$, or $2$ according as the function is constant, a nonconstant LTF, or neither,
- the standard three-pair endpoint families $\mathrm{INT}_3,\mathrm{DISJ}_3,\mathrm{SUB}_3,\mathrm{NCON}_3,\mathrm{NEQ}_3$ also have exact value $2$,
- intersection-profile predicates $F(\sum_i x_i y_i)$ have the explicit bracket $C(F)\leq H^{\ast}\leq\sum _{r=1}^{C(F)}\binom{m}{r}$,
- Hamming-distance profile predicates $F(\Delta(x,y))$ have the explicit bracket $C(F)\leq H^{\ast}\leq U_m(C(F))$, with $2\leq H^{\ast}(\mathrm{HDTH} _{m,t})\leq m+1$ for distance thresholds when $m\geq2$,
- directed-defect profile predicates $F(\sum_i x_i(1-y_i))$ have the explicit bracket $C(F)\leq H^{\ast}\leq V_m(C(F))$, with $2\leq H^{\ast}(\mathrm{SUB}_m)\leq m+1$ and $2\leq H^{\ast}(\mathrm{NCON}_m)\leq m+1$ when $m\geq2$,
- the directed-defect endpoint is exact at $m=2$: $H^{\ast}(\mathrm{SUB}_2)=H^{\ast}(\mathrm{NCON}_2)=2$,
- every two-pair local-count profile with one sign change has $H^{\ast}\leq2$, and is exact at $0$, $1$, or $2$ according as it is constant, an LTF, or neither,
- local-pattern count profile structure gives the generic schema $C(F)\leq H^{\ast}\leq\Lambda _{p,m}(C(F))$ whenever the local two-bit predicate has a symmetric one-bit slice,
- symmetric threshold structure certifies $H^{\ast}(f) = 1$,
- symmetric sign-change count gives exact $H^{\ast}(f)$ for every symmetric $f$,
- positive-projection sign-change structure certifies $H^{\ast}(f) \leq C _{+}(f)$,
- positive-order minority-run structure certifies $H^{\ast}(f)\leq2R _{+}(f)$,
- the one-run positive-order case $R _{+}(f)=1$ has exact value $0$, $1$, or $2$ according as the function is constant, a nonconstant LTF, or neither,
- shared positive-projection structure certifies low head complexity for Boolean combinations with the same statistic,
- degree-restricted determinant-span structure certifies upper bounds for every function with $\deg _{\pm}(f)\leq d$,
- Fourier-tail structure certifies $\deg _{\pm}(f)\leq d$, which can feed into degree-restricted span upper bounds,
- Fourier support-cost structure certifies direct head upper bounds from sparse Walsh sign approximants,
- bounded DNF/CNF width certifies $\deg _{\pm}(f)\leq w$, which can feed into degree-restricted span upper bounds,
- polynomial-threshold sparsity certifies $H^{\ast}(f)\leq\mathrm{ptfsp}(f)$, and affine-free sparsity sharpens this to $H^{\ast}(f)\leq1+\sum _{r=2}^{d}\binom{n}{r}$ for nonconstant functions with $\deg _{\pm}(f)\leq d$,
- cofactor sparse-polynomial recursion certifies $H^{\ast}(f)\leq m_0+\lvert\mathcal{A}_0\cup\mathcal{A}_1\rvert+1$ from sparse sign polynomials for the two cofactors,
- affine-free cofactor recursion certifies $H^{\ast}(f)\leq n$ whenever some split has constant or LTF cofactors, and gives exact two-head control when the two affine cofactor separators differ in at most one slope,
- LTF cofactor slope distance certifies $H^{\ast}(f)\leq1+t$ when $t$ affine slopes change across a split with LTF cofactors,
- the split LTF slope invariant certifies $H^{\ast}(f)\leq1+\sigma _{\mathrm{split}}(f)$ after minimizing over split coordinates and affine separator choices,
- the split affine-free support invariant certifies $H^{\ast}(f)\leq\mathrm{scafs} _{\pm}(f)$ by paying for one base cofactor and the coefficient changes across a split,
- one-bit LTF branching certifies $H^{\ast}(G(z,T(y)))\leq1+\lvert\mathrm{supp}(L)\rvert$ for every Boolean gate $G$,
- one-bit sparse-PTF branching certifies $H^{\ast}(G(z,T(y)))\leq1+\ell(P)+2q(P)$, with sharper branch-dependent costs when one slice is constant,
- one-bit non-XOR recursion certifies $H^{\ast}(G(z,T(y)))\leq H^{\ast}(T)+1$ for every inner feature $T$ whenever $G$ is neither XOR nor XNOR,
- literal decision lists certify $H^{\ast}(f)\leq L _{\mathrm{litDL}}(f)$ by iterating the non-XOR recursion one tested literal at a time,
- endpoint decision lists certify $H^{\ast}(f)\leq L$ for decision lists over positive OR-type tests, positive AND-type tests, and complements of those tests,
- calibrated decision lists certify $H^{\ast}(f)\leq L$ whenever their test indicators have one-head atom approximations accurate enough for the strict decision-list vote margin,
- the internal LTF $x_1\wedge(x_2\vee x_3)$ cannot have its raw indicator approximated within error below $1/4$ by any one-head atom, even though it is itself one-head computable after thresholding,
- this $1/4$ barrier is the exact infimum of the one-atom uniform approximation error for that internal LTF indicator,
- raw-calibrated votes certify $H^{\ast}$ upper bounds by summing the raw atom approximation costs $\rho(T_j)$ of their inner features, with $\rho(T)\leq\mathrm{eafs}(T)$ as a concrete exact-polynomial fallback,
- raw-calibrated decision lists certify $H^{\ast}(f)\leq\sum_j\rho(T_j)\leq\sum_j\mathrm{eafs}(T_j)$ for tests $T_j$,
- threshold degree lower-bounds raw calibration cost in strict votes: $\deg _{\pm}(f)\leq\sum_j\rho(T_j)$,
- subcube tests satisfy $\rho(C _{P,N})\leq\min\lbrace2^{\lvert P\rvert},2^{\lvert N\rvert}\rbrace$, with cost $0$ for the vacuous cylinder,
- raw calibration cost is invariant under complements, coordinate permutations, global bit-flips, and dummy variables, and it is monotone under restrictions,
- strict threshold votes over subcube indicators certify $H^{\ast}$ upper bounds by summing the local costs $\kappa(P,N)$,
- the optimized cylinder-threshold cost $\mathrm{ctc}(f)$ is a finite direct upper-bound invariant for every Boolean function,
- $\mathrm{ctc}$ is invariant under complements, coordinate permutations, global bit-flips, and dummy variables, and it is monotone under restrictions,
- $\mathrm{ctc}$ subsumes one-sided local certificate covers, mixed-literal DNF/CNF local expansion, and decision-tree leaf-profile costs,
- $\mathrm{ctc}(f)\leq\mathrm{ptfsp}(f)$, so sparse PTF upper bounds factor through the cylinder-threshold invariant,
- affine-cylinder threshold cost certifies $H^{\ast}(f)\leq\mathrm{actc}(f)\leq\mathrm{ctc}(f)$ by allowing one dense affine component at cost one,
- $\mathrm{actc}(f)\leq\mathrm{afs} _{\pm}(f)\leq\mathrm{ptfsp}(f)$, so affine-free sparse PTF bounds also factor through the affine-cylinder invariant,
- intersections of two halfspaces can have $H^{\ast}(f)\geq c n$, by threshold-degree lower bounds,
- threshold-vote size and LTF decision-list length can both be at most $2$ while $H^{\ast}$ grows linearly,
- one-head computable LTFs can have raw calibration cost $\rho(T)\geq c n$,
- $\mathrm{actc}$ is invariant under complements, coordinate permutations, global bit-flips, and dummy variables, and it is monotone under restrictions,
- functions with $\mathrm{actc}(f)\leq2$ have exact value $0$, $1$, or $2$ according as they are constant, nonconstant LTFs, or neither,
- threshold degree lower-bounds $\mathrm{actc}$, $\mathrm{ctc}$, $\mathrm{afs} _{\pm}$, and $\mathrm{ptfsp}$ through the head-complexity sandwich,
- affine-cylinder cofactor interpolation certifies $\mathrm{actc}$ upper bounds by paying only for base cylinder supports and changed affine or cylinder coefficients across a split,
- fresh-bit XOR certifies $\deg _{\pm}(z\oplus f)=\deg _{\pm}(f)+1$ and hence $H^{\ast}(z\oplus f)\geq\deg _{\pm}(f)+1$,
- one-bit gate threshold-degree trichotomy says XOR and XNOR are the only one-bit gates that raise threshold degree, while non-XOR gates using the feature preserve it,
- parity-block XOR certifies $\deg _{\pm}((\bigoplus _{j=1}^{k}z_j)\oplus f)=k+\deg _{\pm}(f)$,
- parity-block restrictions certify $H^{\ast}(f)\geq k+\deg _{\pm}(T)$ whenever a restriction equals a parity block XOR a residual feature $T$,
- calibrated threshold-vote certificates prove $H^{\ast}\leq s$ when $s$ one-head atoms approximate the inner vote features within the outer vote margin,
- endpoint affine-threshold votes certify $H^{\ast}\leq s$ for strict weighted votes over positive OR-type and AND-type features,
- affine-free support cost at most two has exact value $0$, $1$, or $2$ according as the function is constant, a nonconstant LTF, or neither,
- denominator-orientation structure characterizes which affine denominators a single head can realize directly,
- monotone normal-form structure certifies $H^{\ast}(f)\leq\min\lbrace\mathrm{mDNF}(f),\mathrm{mCNF}(f)\rbrace$,
- monotone boundary structure certifies $H^{\ast}(f)\leq\binom{n}{\lfloor n/2\rfloor}$ for every monotone $f$,
- monotone counting structure certifies that this monotone upper bound is polynomially sharp in the worst case and for almost all monotone functions,
- sparse-support structure certifies $H^{\ast}(f)\leq2\min\lbrace\lvert f^{-1}(1)\rvert,\lvert f^{-1}(0)\rvert\rbrace$,
- mixed-literal formula volume certifies $H^{\ast}(f)\leq2\sum_a2^{n-w_a}$ for DNF or CNF widths $w_a$,
- mixed-literal formula literal imbalance certifies $H^{\ast}(f)\leq\sum_a\min\lbrace2^{\lvert P_a\rvert},2^{\lvert N_a\rvert}\rbrace$ for DNF or CNF normal forms,
- mixed-literal formulas also certify the hybrid used-variable bound $\min\lbrace2\sum_a2^{v-w_a},\sum_a\min\lbrace2^{\lvert P_a\rvert},2^{\lvert N_a\rvert}\rbrace,2^v-1,1+\sum _{r=2}^{\min\lbrace w,v\rbrace}\binom{v}{r}\rbrace$,
- decision-tree leaf profiles certify ambient-dimension-free upper bounds, in particular $H^{\ast}(f)\leq2^{D(f)+\lfloor D(f)/2\rfloor-1}$ for nonconstant $f$,
- depth-two decision trees have exact value $0$, $1$, or $2$ according as the function is constant, a nonconstant LTF, or neither,
- decision trees also certify the hybrid bound $H^{\ast}(f)\leq\min\lbrace\Lambda(\mathcal{T}),2^v-1,1+\sum _{r=2}^{\min\lbrace d,v\rbrace}\binom{v}{r}\rbrace$, where $d$ is tree depth and $v$ is the number of queried variables,
- local certificate-expansion structure certifies $H^{\ast}(f)$ from one-sided certificate covers whose cylinders each fix few bits of at least one sign,
- junta structure certifies ambient-dimension-free bounds depending only on $\mathrm{ess}(f)$,
- certificate-cover structure certifies upper bounds from one-sided weighted subcube covers,
- three-bit quadratic threshold structure certifies $H^{\ast}(f) \leq 2$,
- five-bit quadratic threshold structure certifies $H^{\ast}(f) \leq 2$,
- three-bit arbitrary threshold structure certifies $H^{\ast}(f) \leq 3$, closing the full $n=3$ classification,
- three-bit threshold-vote structure certifies $s _{\mathrm{LTF}}(f)=H^{\ast}(f)=\deg _{\pm}(f)$ for every three-bit Boolean function,
- four-bit arbitrary threshold structure certifies $H^{\ast}(f) \leq 4$,
- five-bit arbitrary threshold structure certifies $H^{\ast}(f) \leq 7$,
- six-bit arbitrary threshold structure certifies $H^{\ast}(f) \leq 11$,
- seven-bit arbitrary threshold structure certifies $H^{\ast}(f) \leq 19$,
- eight-bit arbitrary threshold structure certifies $H^{\ast}(f) \leq 32$,
- nine-bit arbitrary threshold structure certifies $H^{\ast}(f) \leq 57$,
- ten-bit arbitrary threshold structure certifies $H^{\ast}(f) \leq 103$,
- eleven-bit arbitrary threshold structure certifies $H^{\ast}(f) \leq 187$,
- twelve-bit arbitrary threshold structure certifies $H^{\ast}(f) \leq 342$,
- positive weighted-sum image structure certifies $H^{\ast}(f) \leq M _{+}(f) - 1$,
- for parity, threshold degree gives the exact value $H^{\ast}(\mathrm{XOR}_n) = n$.
