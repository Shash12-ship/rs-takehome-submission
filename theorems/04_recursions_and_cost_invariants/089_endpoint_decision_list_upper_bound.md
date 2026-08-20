# Endpoint Decision-List Upper Bound

## Statement

For a nonempty set $S\subseteq\lbrace1,\ldots,n\rbrace$ and positive weights $\lambda_i\gt0$, write

$$ L_S(x):=\sum_{i\in S}\lambda_i x_i, \qquad \Lambda_S:=\sum_{i\in S}\lambda_i. $$

An endpoint affine-threshold feature is either

$$ U_S(x):=\mathbf{1}[L_S(x)\gt0] $$

or

$$ A_S(x):=\mathbf{1}[L_S(x)=\Lambda_S]. $$

Let $f$ be computed by a decision list with $L$ tests, where each test is either an endpoint affine-threshold feature or the complement of one. Then

$$ H^{\ast}(f)\leq L. $$

> **Interpretation.** The one-head-per-test decision-list theorem extends from raw literals to endpoint OR-type and AND-type affine thresholds, including their complements.

## Proof

We use two ingredients.

### Lemma 1. Decision lists are strict weighted votes of their tests

Let $T_1,\ldots,T_L$ be arbitrary Boolean tests, let $b_1,\ldots,b_L\in\lbrace0,1\rbrace$ be branch labels, and let $b_{L+1}$ be the default label. The decision list returns $b_j$ at the first index $j$ with $T_j(x)=1$, and returns $b_{L+1}$ if no test fires.

We show that the decision-list output is a strict weighted vote over the indicators $T_1,\ldots,T_L$.

For the suffix beginning after the last test, choose

$$ V_{L+1}:= \begin{cases} 1 & \text{if } b_{L+1}=1,\cr -1 & \text{if } b_{L+1}=0. \end{cases} $$

This constant has positive sign margin. Suppose by backward induction that the suffix beginning at $j+1$ is sign-represented by a linear score

$$ V_{j+1} = c_{j+1}+\sum_{k=j+1}^{L}a_kT_k $$

with nonzero margin on the Boolean cube. Let

$$ M_j:=\max_x\lvert V_{j+1}(x)\rvert. $$

Choose $A_j\gt M_j$. If $b_j=1$, define

$$ V_j:=A_jT_j+V_{j+1}. $$

When $T_j=1$, the value is at least $A_j-M_j\gt0$, so the output is $1$. When $T_j=0$, the sign is exactly the sign of the suffix score $V_{j+1}$.

If $b_j=0$, define

$$ V_j:=-A_jT_j+V_{j+1}. $$

When $T_j=1$, the value is at most $-A_j+M_j\lt0$, so the output is $0$. When $T_j=0$, the sign is again the sign of $V_{j+1}$.

Thus $V_j$ sign-represents the suffix beginning at $j$ with positive margin. Iterating to $j=1$ gives a strict weighted vote

$$ V_1(x)=c_0+\sum_{j=1}^{L}c_jT_j(x) $$

for the full decision list.

### Lemma 2. Endpoint tests and their complements are one-head approximable

The proof of the endpoint affine-threshold vote theorem [086_endpoint_affine_threshold_vote_upper_bound.md](086_endpoint_affine_threshold_vote_upper_bound.md) constructs one-head atom approximations with arbitrarily small uniform error for each endpoint affine-threshold feature $T$.

If $\phi$ is a one-head atom approximating $T$, then

$$ 1-\phi $$

is also a one-head atom: it has the same positive oriented denominator, with numerator replaced by denominator minus numerator. It approximates $1-T$ with the same uniform error. Hence complements of endpoint features are also arbitrarily one-head approximable.

### Conclusion

Apply Lemma 1 to the decision list and obtain a strict weighted vote

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{L}c_jT_j(x)\gt0 $$

with positive margin $\mu$. By Lemma 2, choose one-head atom approximations $\phi_j$ to the tests $T_j$ with errors $\epsilon_j$ small enough that

$$ \sum_{j=1}^{L}\lvert c_j\rvert\epsilon_j\lt\mu. $$

The calibrated threshold-vote theorem [085_calibrated_threshold_vote_upper_bound.md](085_calibrated_threshold_vote_upper_bound.md) gives

$$ H^{\ast}(f)\leq L. $$

$\blacksquare$

## Consequences

Literal decision lists are a special case, because $x_i$ is an endpoint feature and $1-x_i$ is its complement. Thus this theorem recovers

$$ H^{\ast}(f)\leq L_{\mathrm{litDL}}(f). $$

It also covers decision lists whose tests are positive disjunctions $\mathbf{1}[\sum_{i\in S}\lambda_i x_i\gt0]$, positive conjunctions $\mathbf{1}[\sum_{i\in S}\lambda_i x_i=\Lambda_S]$, and complements of either kind.
