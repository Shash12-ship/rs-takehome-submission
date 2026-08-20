# Two-Pair Containment Is Exact

## Statement

Define two-pair containment and noncontainment by

$$ \mathrm{SUB}_2(x,y) := \mathbf{1}[x_i\leq y_i\text{ for }i=1,2], \qquad \mathrm{NCON}_2:=1-\mathrm{SUB}_2. $$

Then

$$ H^{\ast}(\mathrm{SUB}_2)=H^{\ast}(\mathrm{NCON}_2)=2. $$

> **Interpretation.** The first nontrivial directed-defect endpoint has exact value $2$. This sharpens the general directed-defect bound $2\leq H^{\ast}\leq m+1$ at $m=2$.

## Proof

### Lemma 1. A two-atom rational certificate for containment

Write the four input bits as

$$ x_1,x_2,y_1,y_2. $$

Define positive affine denominators

$$ B_1:=1+x_1+x_2+y_1+y_2, \qquad B_2:=1+x_1+x_2+2y_1+3y_2. $$

Define affine numerators

$$ A_1:=-4+8x_2, \qquad A_2:=6-3x_1-15x_2+3y_1+3y_2. $$

Let

$$ S:=\frac{A_1}{B_1}+\frac{A_2}{B_2}. $$

Since $B_1,B_2\gt0$ on the Boolean cube, the sign of $S$ is the sign of

$$ P:=A_1B_2+A_2B_1. $$

On the nine containment inputs, listed in lexicographic order, the values of $P$ are

$$ 2,\ 2,\ 6,\ 12,\ 2,\ 16,\ 2,\ 8,\ 2. $$

On the seven noncontainment inputs, listed in lexicographic order, the values of $P$ are

$$ -10,\ -2,\ -2,\ -2,\ -24,\ -12,\ -16. $$

Thus

$$ S\gt0 \qquad\Longleftrightarrow\qquad \mathrm{SUB}_2(x,y)=1. $$

Both denominators have positive constant term and positive variable coefficients. By the affine-over-positive-affine atom lemma [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md), each ratio $A_i/B_i$ is a single one-head atom. Therefore

$$ H^{\ast}(\mathrm{SUB}_2)\leq2. $$

### Lemma 2. Lower bound and complement

The directed-defect profile bound [052_directed_defect_profile_bounds.md](052_directed_defect_profile_bounds.md) proves that for $m\geq2$,

$$ H^{\ast}(\mathrm{SUB}_m)\geq2, \qquad H^{\ast}(\mathrm{NCON}_m)\geq2. $$

In particular,

$$ H^{\ast}(\mathrm{SUB}_2)\geq2. $$

Together with Lemma 1 this gives

$$ H^{\ast}(\mathrm{SUB}_2)=2. $$

Complementing the final threshold computes $\mathrm{NCON}_2$ with the same two atoms, so

$$ H^{\ast}(\mathrm{NCON}_2)\leq2. $$

The lower bound above gives

$$ H^{\ast}(\mathrm{NCON}_2)=2. $$

$\blacksquare$

## Consequence

The directed-defect endpoint is exact at the first two string lengths:

$$ H^{\ast}(\mathrm{SUB}_1)=H^{\ast}(\mathrm{NCON}_1)=1, $$

and

$$ H^{\ast}(\mathrm{SUB}_2)=H^{\ast}(\mathrm{NCON}_2)=2. $$

For $m\geq3$, the current notes still record the general bracket

$$ 2\leq H^{\ast}(\mathrm{SUB}_m)\leq m+1, \qquad 2\leq H^{\ast}(\mathrm{NCON}_m)\leq m+1. $$
