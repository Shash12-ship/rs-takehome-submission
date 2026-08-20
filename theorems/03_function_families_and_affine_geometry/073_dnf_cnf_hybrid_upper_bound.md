# DNF And CNF Hybrid Upper Bound

## Statement

Let

$$ f:\lbrace0,1\rbrace^n\to\lbrace0,1\rbrace. $$

Suppose $f$ has a DNF with consistent nonempty terms

$$ T_a(x) = \left(\prod_{i\in P_a}x_i\right) \left(\prod_{j\in N_a}(1-x_j)\right), \qquad 1\leq a\leq s, $$

where $P_a$ and $N_a$ are disjoint. Let

$$ w_a:=\lvert P_a\rvert+\lvert N_a\rvert, \qquad w:=\max_a w_a, $$

and let $v$ be the number of distinct variables appearing in the DNF.

If $f$ is nonconstant, then

$$ H^{\ast}(f) \leq \min\left\lbrace 2\sum_{a=1}^{s}2^{v-w_a}, \sum_{a=1}^{s}\min\lbrace2^{\lvert P_a\rvert},2^{\lvert N_a\rvert}\rbrace, 2^v-1, 1+\sum_{r=2}^{\min\lbrace w,v\rbrace}\binom{v}{r} \right\rbrace. $$

The dual statement holds for CNFs with consistent nonempty clauses

$$ C_a(x) = \left(\bigvee_{i\in P_a}x_i\right) \vee \left(\bigvee_{j\in N_a}(1-x_j)\right), $$

with the same definitions of $w_a$, $w$, and $v$.

If $f$ is constant, then $H^{\ast}(f)=0$.

> **Interpretation.** Mixed-literal formulas have several incomparable head certificates. Volume rewards high-width rare terms, local expansion rewards formulas close to monotone term by term, junta reduction rewards few used variables, and the width-degree route rewards low-width formulas on a moderate variable set.

## Proof

We prove the DNF statement first. Let $V$ be the set of variables appearing in the DNF, so $\lvert V\rvert=v$. The function $f$ is a $v$-junta. Let

$$ g:\lbrace0,1\rbrace^{V}\to\lbrace0,1\rbrace $$

be the induced function. By junta reduction [039_junta_upper_bounds.md](../02_complexity_measure_upper_bounds/039_junta_upper_bounds.md),

$$ H^{\ast}(f)=H^{\ast}(g). $$

### Lemma 1. Volume on the used variables

Inside the $v$-variable cube, term $T_a$ fixes $w_a$ coordinates and leaves $v-w_a$ free. Hence it covers

$$ 2^{v-w_a} $$

points of the $v$-cube. The true set of $g$ is covered by these term cylinders, so

$$ \lvert g^{-1}(1)\rvert \leq \sum_{a=1}^{s}2^{v-w_a}. $$

The sparse-support upper bound [037_sparse_support_upper_bound.md](../02_complexity_measure_upper_bounds/037_sparse_support_upper_bound.md) gives

$$ H^{\ast}(g) \leq 2\lvert g^{-1}(1)\rvert \leq 2\sum_{a=1}^{s}2^{v-w_a}. $$

### Lemma 2. Local literal expansion

The terms form a $1$-certificate cover of $g$. The local certificate-expansion theorem [044_oriented_certificate_expansion_upper_bound.md](../02_complexity_measure_upper_bounds/044_oriented_certificate_expansion_upper_bound.md) gives

$$ H^{\ast}(g) \leq \sum_{a=1}^{s}\min\lbrace2^{\lvert P_a\rvert},2^{\lvert N_a\rvert}\rbrace. $$

### Lemma 3. Junta interpolation

The generic small-junta bound [039_junta_upper_bounds.md](../02_complexity_measure_upper_bounds/039_junta_upper_bounds.md) gives

$$ H^{\ast}(g)\leq2^v-1 $$

for nonconstant $g$.

### Lemma 4. Width-degree sparsity

The polynomial

$$ Q(x) := \sum_{a=1}^{s}T_a(x)-\frac{1}{2} $$

strictly sign-represents $g$. After multilinear expansion, it uses only variables in $V$ and has degree at most

$$ \min\lbrace w,v\rbrace. $$

Since $g$ is nonconstant, the affine-free sparsity theorem [048_affine_free_sparsity_upper_bound.md](048_affine_free_sparsity_upper_bound.md) gives

$$ H^{\ast}(g) \leq 1+\sum_{r=2}^{\min\lbrace w,v\rbrace}\binom{v}{r}. $$

Combining Lemmas 1 through 4 and using $H^{\ast}(f)=H^{\ast}(g)$ proves the DNF bound.

For a CNF, the false inputs are covered by the cylinders that falsify one clause:

$$ C_a(x)=0 \qquad\Longleftrightarrow\qquad \left(\prod_{i\in P_a}(1-x_i)\right) \left(\prod_{j\in N_a}x_j\right) =1. $$

Thus the volume proof applies to $g^{-1}(0)$ instead of $g^{-1}(1)$. The local expansion proof applies to the corresponding $0$-certificate cover. The junta proof is unchanged. For the degree route, the polynomial

$$ Q(x) := \frac{1}{2} - \sum_{a=1}^{s} \left(\prod_{i\in P_a}(1-x_i)\right) \left(\prod_{j\in N_a}x_j\right) $$

strictly sign-represents the CNF and has degree at most $\min\lbrace w,v\rbrace$. This gives the same four bounds for CNFs. $\blacksquare$

## Consequences

If the formula has width at most $w$ and uses $v$ variables, then every nonconstant function it computes satisfies

$$ H^{\ast}(f) \leq 1+\sum_{r=2}^{\min\lbrace w,v\rbrace}\binom{v}{r}. $$

For fixed width $w$, this is polynomial in the number of variables used by the formula. It is independent of the number of terms, unlike the volume and local-expansion bounds.

If the formula is monotone, then every term has one literal sign, so the local-expansion term gives the monotone one-head-per-term bound. If every term has high width inside a small used-variable set, the volume term may be better. If the formula uses only a few variables, the junta term may be best.
