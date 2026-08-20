# Calibrated Decision-List Upper Bound

## Statement

Let $T_1,\ldots,T_L:\lbrace0,1\rbrace^{n}\to\lbrace0,1\rbrace$ be Boolean tests, and let $f$ be computed by a decision list with tests $T_1,\ldots,T_L$, branch labels

$$ b_1,\ldots,b_L\in\lbrace0,1\rbrace, $$

and default label $b_{L+1}\in\lbrace0,1\rbrace$.

There are coefficients $c_0,c_1,\ldots,c_L$ and a margin $\mu\gt0$ such that

$$ f(x)=1 \qquad\Longleftrightarrow\qquad c_0+\sum_{j=1}^{L}c_jT_j(x)\gt0, $$

and

$$ \left\lvert c_0+\sum_{j=1}^{L}c_jT_j(x)\right\rvert\geq\mu \qquad \text{for every }x. $$

Consequently, if each test $T_j$ has a one-head atom approximation $\phi_j$ with

$$ \lvert\phi_j(x)-T_j(x)\rvert\leq\epsilon_j \qquad \text{for every }x, $$

and

$$ \sum_{j=1}^{L}\lvert c_j\rvert\epsilon_j\lt\mu, $$

then

$$ H^{\ast}(f)\leq L. $$

In particular, if every test $T_j$ admits arbitrarily accurate one-head atom approximations, then

$$ H^{\ast}(f)\leq L. $$

> **Interpretation.** Decision-list priority is not itself expensive. The cost is one head per test whenever the test indicators are available as calibrated raw atoms.

## Proof

For $j\in\lbrace1,\ldots,L+1\rbrace$, let $F_j$ be the suffix decision-list function beginning at test $j$, with $F_{L+1}\equiv b_{L+1}$.

We first build a strict weighted vote for each suffix. Start with

$$ V_{L+1} := \begin{cases} 1 & \text{if } b_{L+1}=1,\cr -1 & \text{if } b_{L+1}=0. \end{cases} $$

Thus $V_{L+1}$ sign-represents $F_{L+1}$ with margin $1$.

Suppose $V_{j+1}$ sign-represents $F_{j+1}$ with positive margin and has the form

$$ V_{j+1} = c_{j+1,0} +\sum_{k=j+1}^{L}c_{j+1,k}T_k. $$

Let

$$ M_j:=\max_x\lvert V_{j+1}(x)\rvert, $$

and choose $A_j\gt M_j$. If $b_j=1$, set

$$ V_j:=A_jT_j+V_{j+1}. $$

When $T_j(x)=1$, we have

$$ V_j(x)\geq A_j-M_j\gt0, $$

so the decision list returns $1$. When $T_j(x)=0$, the sign of $V_j(x)$ is the sign of $V_{j+1}(x)$, matching the suffix.

If $b_j=0$, set

$$ V_j:=-A_jT_j+V_{j+1}. $$

When $T_j(x)=1$, we have

$$ V_j(x)\leq -A_j+M_j\lt0, $$

so the decision list returns $0$. When $T_j(x)=0$, the sign again matches the suffix.

Thus $V_j$ sign-represents $F_j$ with positive margin. Induction gives a strict weighted vote

$$ V_1(x)=c_0+\sum_{j=1}^{L}c_jT_j(x) $$

for $f$. Since the Boolean cube is finite and the inequalities are strict, the margin

$$ \mu:=\min_x\lvert V_1(x)\rvert $$

is positive.

Now assume test approximations $\phi_j$ with errors $\epsilon_j$ satisfy

$$ \sum_{j=1}^{L}\lvert c_j\rvert\epsilon_j\lt\mu. $$

The calibrated threshold-vote theorem [085_calibrated_threshold_vote_upper_bound.md](085_calibrated_threshold_vote_upper_bound.md) applies to the strict vote $V_1$, and yields

$$ H^{\ast}(f)\leq L. $$

If each test is arbitrarily one-head approximable, choose the errors small enough to satisfy the displayed inequality. $\blacksquare$

## Consequences

This theorem isolates the exact missing hypothesis for linear-threshold decision lists: it is not enough that each test is itself one-head computable as a thresholded score. The raw test indicators must be approximable by one-head atoms with enough uniform accuracy for the priority-vote margin.

Endpoint decision lists satisfy this hypothesis by the endpoint approximation construction. Literal decision lists satisfy it as the one-variable endpoint special case.
