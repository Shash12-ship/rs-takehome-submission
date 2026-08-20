import HeadComplexity.Atoms.WeightedAtom
import HeadComplexity.Model.AdditiveSplit

set_option linter.style.header false

/-!
# Result-facing lower bounds from two-coordinate restrictions.

This module is the public entry point for lower bounds from two-coordinate
restrictions. The implementation modules keep the algebraic and model-level
obstruction theorems close to `Head`; this file adds the `H*` layer for the
checkerboard result.
-/

namespace HeadComplexity

/-- **Theorem 1.** The numerator, restricted to two coordinates, splits additively. -/
alias restricted_numerator_additive_split := Head.numerator_additive_split

/-- **Theorem 2.** Antipode identity for the restricted numerator. -/
alias restricted_numerator_antipode := Head.restricted_numerator_antipode

private theorem HStar_ge_two_of_not_computable_zero_one {n : ℕ}
    {f : (Fin n → Bool) → Bool} (hex : ∃ k, computableWithHeadsN n k f)
    (h0 : ¬ computableWithHeadsN n 0 f) (h1 : ¬ computableWithHeadsN n 1 f) :
    2 ≤ HStar n f := by
  classical
  unfold HStar
  rw [dif_pos hex]
  by_contra hlt
  have hcases : Nat.find hex = 0 ∨ Nat.find hex = 1 := by omega
  rcases hcases with hzero | hone
  · exact h0 (by simpa [hzero] using Nat.find_spec hex)
  · exact h1 (by simpa [hone] using Nat.find_spec hex)

/-- **Theorem 3.** A checkerboard restriction forces `H* ≥ 2`. -/
theorem checkerboard_restriction_HStar_ge_two
    {n : ℕ} (f : (Fin n → Bool) → Bool) (base : Fin n → Bool)
    (i j : Fin n) (hij : i ≠ j)
    (h00 : f (Head.restrictBits base i j (false, false)) = false)
    (h11 : f (Head.restrictBits base i j (true, true)) = false)
    (h01 : f (Head.restrictBits base i j (false, true)) = true)
    (h10 : f (Head.restrictBits base i j (true, false)) = true) :
    2 ≤ HStar n f := by
  have h0 : ¬ computableWithHeadsN n 0 f :=
    not_computableWithHeadsN_zero_of_false_true f
      (Head.restrictBits base i j (false, false))
      (Head.restrictBits base i j (false, true)) h00 h01
  have h1 : ¬ computableWithHeadsN n 1 f :=
    parity_restriction_not_computable_with_one_head f base i j hij h00 h11 h01 h10
  exact HStar_ge_two_of_not_computable_zero_one
    ⟨2 ^ n - 1, universal_computable f⟩ h0 h1

end HeadComplexity
