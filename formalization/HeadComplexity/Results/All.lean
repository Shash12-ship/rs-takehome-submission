import HeadComplexity.Results.RestrictionLowerBounds
import HeadComplexity.Results.ExactFamilies
import HeadComplexity.Results.ThresholdDegree
import HeadComplexity.Results.WeightedUpperBound
import HeadComplexity.Results.FractionalNormalForm
import HeadComplexity.Results.LowComplexity
import HeadComplexity.Results.SymmetricComplexity
import HeadComplexity.Results.StrictSeparation

set_option linter.style.header false

/-!
# Main results: the stack of entry points to the theory developed so far

A machine-checked table of contents. Each foundational `alias` below names the
headline Lean statement for one theorem writeup in `theorems/`. Because the build
elaborates these aliases, this file *verifies* every result. These results must be
axiom-clean (`[propext, Classical.choice, Quot.sound]`).

See `README.md` for the theorem↔file map and `PROOF_OVERVIEW.md` for the proof
architecture.
-/

namespace HeadComplexity

/-! ## Results regarding softmax beyond the H* -/

/-- **Theorem 1.** The numerator, restricted to two coordinates, splits additively. -/
alias theorem1_additive_split := restricted_numerator_additive_split

/-- **Theorem 2.** Antipode identity for the restricted numerator. -/
alias theorem2_antipode := restricted_numerator_antipode

/-! ## Lower bound results for H* -/

/-- **Theorem 3.** A checkerboard restriction forces `H* ≥ 2`. -/
alias theorem3_checkerboard := checkerboard_restriction_HStar_ge_two

/-! ## Results for H* for specific boolean functions -/

/-- **Theorem 4.** Every monotone symmetric threshold has `H* = 1`. -/
alias theorem4_threshold := HStar_threshold

/-- **Theorem 5.** Internal exact-count predicates have `H* = 2`. -/
alias theorem5_exact := HStar_exact

/-- **Theorem 8.** Parity needs one head per bit: `H*(XOR_n) = n`. -/
alias theorem8_parity := HStar_parity

/-! ## Results regarding threshold degree beyond the H* -/

/-- **Theorem 6.** Threshold degree is bounded by head complexity:
`computableWithHeadsN n H f → ThresholdDegLE f H`. -/
alias theorem6_degree_le := degree_le_of_computableWithHeadsN

/-- **Theorem 7.** Parity has threshold degree exactly `n`. -/
alias theorem7_parity_degree := parity_thresholdDeg

/-! ## Upper bound results for H* -/

/-- **Theorem 9.** Weighted-sum upper bound `H* ≤ M − 1` … -/
alias theorem9_weighted := HStar_le_weighted_sum

/-- … and the universal bound `H* ≤ 2ⁿ − 1`. -/
alias theorem9_universal := HStar_le_universal_boolean

/-! ## Exact results for H* -/

/-- **Theorem 10.** Exact linear-fractional normal form: `H*(f) = L_frac(f)`. -/
alias theorem10_normal_form := HStar_eq_Lfrac

/-- **Theorem 11.** `H* = 0` iff `f` is constant … -/
alias theorem11_level0 := HStar_eq_zero_iff

/-- … and `H* = 1` iff `f` is a nonconstant linear threshold function. -/
alias theorem11_level1 := HStar_eq_one_iff

/-- **Theorem 12.** Symmetric sign-change characterization:
`H*(symmetricFn F) = signChanges n F`. -/
alias theorem12_symmetric := HStar_symmetricFn

/-! ## Separation results for H* -/

/-- **Theorem 13.** Threshold degree can be strictly smaller than head
complexity. -/
alias theorem13_strict_separation := f10_strict_separation

end HeadComplexity
