import HeadComplexity.Atoms.WeightedAtom

set_option linter.style.header false

/-!
# Result-facing weighted upper bounds.

The atom module contains the construction. This module is the public result layer
for the weighted-sum and universal upper bounds on `H*`.
-/

namespace HeadComplexity

private theorem HStar_le_of_computable {n k : ℕ} {f : (Fin n → Bool) → Bool}
    (h : computableWithHeadsN n k f) : HStar n f ≤ k := by
  classical
  have hex : ∃ k, computableWithHeadsN n k f := ⟨k, h⟩
  unfold HStar
  rw [dif_pos hex]
  exact Nat.find_min' hex h

/-- **Theorem 9.** Weighted-sum upper bound `H* ≤ M - 1`. -/
theorem HStar_le_weighted_sum (lam : Fin n → ℝ) (hlam : ∀ i, 0 < lam i)
    (f : (Fin n → Bool) → Bool) (G : ℝ → Bool)
    (hf : ∀ bits, f bits = G (wT lam bits)) :
    HStar n f ≤ (Finset.univ.image (wT lam)).card - 1 :=
  HStar_le_of_computable (weighted_computable lam hlam f G hf)

/-- **Theorem 9.** Universal upper bound `H* ≤ 2^n - 1`. -/
theorem HStar_le_universal_boolean (f : (Fin n → Bool) → Bool) :
    HStar n f ≤ 2 ^ n - 1 :=
  HStar_le_of_computable (universal_computable f)

end HeadComplexity
