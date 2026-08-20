# Depth-Two Decision Trees Are Exact

## Statement

Let

$$ f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace $$

be computed by a deterministic decision tree of depth at most $2$. Then

$$ H^{\ast}(f)\leq2. $$

More precisely,

$$ H^{\ast}(f) = \begin{cases} 0 & \text{if } f \text{ is constant},\cr 1 & \text{if } f \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** The first adaptive decision-tree case is fully controlled. A depth-two tree can be nonsymmetric and can mix different variables on different branches, but it still never needs more than two heads.

## Proof

If the tree has depth $0$, then $f$ is constant. Assume the depth is at most $2$.

A depth-two decision tree queries at most one root variable and at most one additional variable on each branch. Hence $f$ depends on at most three variables. Let

$$ g:\lbrace0,1\rbrace^k\to\lbrace0,1\rbrace, \qquad k\leq3, $$

be the induced function on the essential variables. By junta reduction [039_junta_upper_bounds.md](../02_complexity_measure_upper_bounds/039_junta_upper_bounds.md),

$$ H^{\ast}(f)=H^{\ast}(g). $$

The accepting leaves of the decision tree give an exact DNF for $g$:

$$ g(x) = \sum_{\ell\in\mathcal{L}_1} \left(\prod_{i\in P_\ell}x_i\right) \left(\prod_{j\in N_\ell}(1-x_j)\right), $$

where each root-to-leaf path fixes at most two variables. Thus this exact polynomial has degree at most $2$. Therefore

$$ g(x)=1 \qquad\Longleftrightarrow\qquad g(x)-\frac{1}{2}\gt0 $$

is a quadratic sign representation.

If $k\lt3$, add dummy variables. Dummy-variable invariance from [039_junta_upper_bounds.md](../02_complexity_measure_upper_bounds/039_junta_upper_bounds.md) preserves $H^{\ast}$, and the quadratic sign representation remains quadratic. The three-bit quadratic upper-bound theorem [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md) gives

$$ H^{\ast}(g)\leq2. $$

Thus $H^{\ast}(f)\leq2$.

The exact case split now follows from the zero-head and one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md). Constants have value $0$, nonconstant LTFs have value $1$, and nonconstant non-LTFs have value at least $2$. Together with the two-head upper bound, this proves the theorem. $\blacksquare$

## Consequence

Decision-tree depth two is a complete exact class:

$$ D(f)\leq2 \qquad\Longrightarrow\qquad H^{\ast}(f)\in\lbrace0,1,2\rbrace, $$

with the value determined only by whether $f$ is constant, an LTF, or neither.

This is a small but useful anchor for recursive upper-bound attempts: the first adaptive branching layer does not create any functions beyond the two-head regime.
