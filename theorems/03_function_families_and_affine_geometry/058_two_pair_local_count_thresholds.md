# Two-Pair Local-Count Thresholds Use At Most Two Heads

## Statement

Let $p:\lbrace0,1\rbrace^2\to\lbrace0,1\rbrace$ be any two-bit predicate. For a profile

$$ F:\lbrace0,1,2\rbrace\to\lbrace0,1\rbrace, $$

define the two-pair local-count function

$$ f_{p,F}(x_1,x_2,y_1,y_2) := F(p(x_1,y_1)+p(x_2,y_2)). $$

Assume $F(0),F(1),F(2)$ has exactly one sign change. Then

$$ H^{\ast}(f_{p,F})\leq2. $$

More precisely:

$$ H^{\ast}(f_{p,F}) = \begin{cases} 0 & \text{if } f_{p,F} \text{ is constant},\cr 1 & \text{if } f_{p,F} \text{ is a nonconstant linear threshold function},\cr 2 & \text{otherwise}. \end{cases} $$

> **Interpretation.** Every threshold-like count of two identical local patterns is settled exactly. This packages the two-pair endpoint cases for intersection, disjointness, equality, nonequality, containment, and noncontainment.

## Proof

There are only finitely many cases. The two-bit predicate $p$ has $16$ truth tables, and a profile on $\lbrace0,1,2\rbrace$ with one sign change has one of the four label sequences

$$ 001,\quad 011,\quad 100,\quad 110. $$

Thus there are $64$ presentations before identifying duplicate four-bit truth tables.

### Lemma 1. Finite certificate enumeration

The verifier `src/hstar/local_count_profiles.py` enumerates all $64$ presentations. For each resulting truth table, it first checks whether the table is constant, then checks strict affine separability by solving the margin feasibility problem for a linear threshold function.

For every remaining unique table, the verifier checks a hardcoded integer two-atom certificate of the form

$$ S(x)=\frac{A_1(x)}{B_1(x)}+\frac{A_2(x)}{B_2(x)}, $$

where $A_1,A_2$ are affine and $B_1,B_2$ are positive affine functions on the Boolean cube. It verifies directly on all $16$ inputs that

$$ S(x)\gt0 \qquad\Longleftrightarrow\qquad f_{p,F}(x)=1. $$

Running

```bash
python -m src.hstar.local_count_profiles
```

returns

```json
{
  "total_one_change_profiles_with_duplicates": 64,
  "unique_tables": 30,
  "constant_unique_tables": 2,
  "ltf_unique_tables": 16,
  "two_atom_unique_tables": 12,
  "missing_unique_tables": [],
  "certificate_count": 12,
  "all_certificates_verify": true
}
```

Therefore every nonconstant non-LTF truth table arising from a one-change two-pair local-count profile has a two-atom rational certificate with positive affine denominators.

By the affine-over-positive-affine atom lemma [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md), each ratio $A_i/B_i$ is a single one-head atom. Hence every such table has

$$ H^{\ast}(f_{p,F})\leq2. $$

### Lemma 2. Exactness of the cases

If $f_{p,F}$ is constant, then $H^{\ast}(f_{p,F})=0$.

If $f_{p,F}$ is a nonconstant LTF, then the one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) gives

$$ H^{\ast}(f_{p,F})=1. $$

If $f_{p,F}$ is nonconstant and not an LTF, then the same one-head characterization gives

$$ H^{\ast}(f_{p,F})\geq2. $$

Lemma 1 gives the matching upper bound, so

$$ H^{\ast}(f_{p,F})=2. $$

$\blacksquare$

## Consequence

The first nontrivial endpoints of the main two-pair profile families are all exact:

$$ H^{\ast}(\mathrm{INT}_2) = H^{\ast}(\mathrm{DISJ}_2) = H^{\ast}(\mathrm{EQ}_2) = H^{\ast}(\mathrm{NEQ}_2) = H^{\ast}(\mathrm{SUB}_2) = H^{\ast}(\mathrm{NCON}_2) =2. $$

This lemma does not cover alternating two-level profiles such as four-bit parity, where $F(0),F(1),F(2)$ has two sign changes. In that case the threshold-degree lower bound can force more than two heads.
