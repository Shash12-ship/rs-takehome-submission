# Raw-Calibrated Decision-List Support Bound

## Statement

Let $f$ be computed by a decision list with tests

$$ T_1,\ldots,T_L:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace. $$

Then

$$ H^{\ast}(f) \leq \sum_{j=1}^{L}\rho(T_j), $$

where $\rho(T_j)$ is the raw atom approximation cost from [093_raw_calibrated_vote_support_bound.md](093_raw_calibrated_vote_support_bound.md).

In particular,

$$ H^{\ast}(f) \leq \sum_{j=1}^{L}\mathrm{eafs}(T_j), $$

where $\mathrm{eafs}(T_j)$ is the exact affine-free support cost of the unique multilinear expansion of $T_j$.

> **Interpretation.** Decision lists do not require one raw atom per test. They require the raw calibration cost of each test. Endpoint and literal tests have cost at most one; internal threshold tests may cost more.

## Proof

By the calibrated decision-list theorem [090_calibrated_decision_list_upper_bound.md](090_calibrated_decision_list_upper_bound.md), every decision list with tests $T_1,\ldots,T_L$ has a strict weighted-vote representation

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{L}c_jT_j(x)\gt0 $$

with positive margin on the Boolean cube.

The raw-calibrated vote support bound [093_raw_calibrated_vote_support_bound.md](093_raw_calibrated_vote_support_bound.md) applied to this strict vote gives

$$ H^{\ast}(f) \leq \sum_{j:c_j\neq0}\rho(T_j) \leq \sum_{j=1}^{L}\rho(T_j). $$

The same theorem also gives

$$ \rho(T_j)\leq\mathrm{eafs}(T_j) $$

for every test $T_j$. Therefore

$$ H^{\ast}(f) \leq \sum_{j=1}^{L}\mathrm{eafs}(T_j). $$

$\blacksquare$

## Consequences

If every test has $\rho(T_j)\leq1$, this recovers the one-head-per-test calibrated decision-list theorem.

For a decision list whose tests are internal LTFs, the theorem gives a concrete route through exact multilinear support. It does not prove a length $L$ bound for arbitrary LTF tests, but it turns the problem into bounding the raw calibration costs $\rho(T_j)$.
