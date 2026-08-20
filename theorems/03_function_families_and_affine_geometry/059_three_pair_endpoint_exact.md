# Three-Pair Endpoint Families Are Exact

## Statement

For three pairs of input bits, define

$$ \mathrm{INT}_3(x,y):=\mathbf{1} \left[\sum_{i=1}^{3}x_i y_i\geq1\right], \qquad \mathrm{DISJ}_3:=1-\mathrm{INT}_3, $$

$$ \mathrm{SUB}_3(x,y):=\mathbf{1}[x_i\leq y_i\text{ for }i=1,2,3], \qquad \mathrm{NCON}_3:=1-\mathrm{SUB}_3, $$

and

$$ \mathrm{EQ}_3(x,y):=\mathbf{1}[x=y], \qquad \mathrm{NEQ}_3:=1-\mathrm{EQ}_3. $$

Then

$$ H^{\ast}(\mathrm{INT}_3) = H^{\ast}(\mathrm{DISJ}_3) = H^{\ast}(\mathrm{SUB}_3) = H^{\ast}(\mathrm{NCON}_3) = H^{\ast}(\mathrm{EQ}_3) = H^{\ast}(\mathrm{NEQ}_3) =2. $$

> **Interpretation.** The standard one-change profile endpoints remain two-head functions at three pairs. This pushes the exact frontier one step beyond the finite two-pair local-count classification.

## Proof

### Lemma 1. Exact two-atom certificates

The verifier `src/hstar/three_pair_certificates.py` records explicit integer certificates of the form

$$ S(x)=\frac{A_1(x)}{B_1(x)}+\frac{A_2(x)}{B_2(x)}, $$

where $A_1,A_2$ are affine and $B_1,B_2$ are positive affine functions on the six-bit Boolean cube. For each of $\mathrm{INT}_3$, $\mathrm{SUB}_3$, and $\mathrm{EQ}_3$, it verifies exactly on all $64$ inputs that

$$ S(x)\gt0 \qquad\Longleftrightarrow\qquad f(x)=1. $$

Running

```bash
python -m src.hstar.three_pair_certificates
```

returns

```json
{
  "input_bits": 6,
  "certificate_count": 3,
  "certificates": {
    "INT3": {
      "min_true_numerator": 440,
      "max_false_numerator": -440,
      "true_input_count": 37,
      "false_input_count": 27
    },
    "SUB3": {
      "min_true_numerator": 2244,
      "max_false_numerator": -2244,
      "true_input_count": 27,
      "false_input_count": 37
    },
    "EQ3": {
      "min_true_numerator": 16336320,
      "max_false_numerator": -16336300,
      "true_input_count": 8,
      "false_input_count": 56
    }
  },
  "all_certificates_verify": true
}
```

Since each denominator is positive affine, each ratio is a single one-head atom by the affine-over-positive-affine atom lemma [015_three_bit_quadratic_upper_bound.md](../01_foundations_and_normal_form/015_three_bit_quadratic_upper_bound.md). Hence

$$ H^{\ast}(\mathrm{INT}_3)\leq2, \qquad H^{\ast}(\mathrm{SUB}_3)\leq2, \qquad H^{\ast}(\mathrm{EQ}_3)\leq2. $$

Complementing the final threshold gives

$$ H^{\ast}(\mathrm{DISJ}_3)\leq2, \qquad H^{\ast}(\mathrm{NCON}_3)\leq2, \qquad H^{\ast}(\mathrm{NEQ}_3)\leq2. $$

### Lemma 2. Lower bounds

The intersection-profile bound [050_intersection_profile_bounds.md](050_intersection_profile_bounds.md) proves that for $m\geq2$,

$$ H^{\ast}(\mathrm{INT}_m)\geq2, \qquad H^{\ast}(\mathrm{DISJ}_m)\geq2. $$

The directed-defect profile bound [052_directed_defect_profile_bounds.md](052_directed_defect_profile_bounds.md) proves that for $m\geq2$,

$$ H^{\ast}(\mathrm{SUB}_m)\geq2, \qquad H^{\ast}(\mathrm{NCON}_m)\geq2. $$

For equality, restricting all but one pair gives $\mathrm{EQ}_1$, which is not an LTF. Thus the one-head characterization [011_one_head_characterization.md](../01_foundations_and_normal_form/011_one_head_characterization.md) gives

$$ H^{\ast}(\mathrm{EQ}_3)\geq2. $$

Complement invariance from [028_restrictions_and_sign_rank.md](../02_complexity_measure_upper_bounds/028_restrictions_and_sign_rank.md) gives

$$ H^{\ast}(\mathrm{NEQ}_3)\geq2. $$

Combining these lower bounds with Lemma 1 proves all six exact values. $\blacksquare$

## Consequence

The currently known equality endpoint values are

$$ H^{\ast}(\mathrm{EQ}_1) = H^{\ast}(\mathrm{EQ}_2) = H^{\ast}(\mathrm{EQ}_3) =2. $$

For intersection, disjointness, containment, and noncontainment, the exact value $2$ is now known at $m=2$ and $m=3$. The general $m$ case remains open in these notes.
