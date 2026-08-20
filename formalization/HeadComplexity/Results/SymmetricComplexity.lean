import HeadComplexity.Atoms.HammingAtom
import HeadComplexity.Atoms.PartialFraction
import HeadComplexity.Atoms.SignPolynomial
import HeadComplexity.Polynomial.UnivariateReduction

set_option linter.style.header false

/-!
# L12 — the unconditional equality.

Assembling the pieces:
* `exists_sign_poly` — a degree-`≤ signChanges` polynomial whose sign tracks `F`;
* `real_partial_fraction` — its quotient by `∏ (X + a_h)` is `A + ∑ b_h/(k+a_h)`;
* `atomHead_readout` / `atomFamily_readout` — one head per `b_h/(k+a_h)` atom.

This yields `computableWithHeadsN n (signChanges n F) (symmetricFn F)` (the upper
bound), which with the verified lower bound gives the full, unconditional Theorem 12:
`HStar n (symmetricFn F) = signChanges n F`.
-/

namespace HeadComplexity

open Finset
open scoped BigOperators InnerProductSpace

/-- Hamming weight never exceeds `n`. -/
theorem hammingWeight_le (n : ℕ) (bits : Fin n → Bool) : hammingWeight bits ≤ n := by
  unfold hammingWeight
  calc (Finset.univ.filter fun i => bits i = true).card ≤ (Finset.univ : Finset (Fin n)).card :=
        Finset.card_filter_le _ _
    _ = n := by rw [Finset.card_univ, Fintype.card_fin]

/-- **Rational atoms.** There are `signChanges n F` shifts/coefficients and a
threshold realising `F` on the Hamming-weight axis. -/
theorem exists_rational_atoms (F : ℕ → Bool) (n : ℕ) :
    ∃ (av bv : Fin (signChanges n F) → ℝ) (τ : ℝ),
      (∀ h, (n : ℝ) + 1 < av h) ∧
      ∀ k : ℕ, k ≤ n → ((∑ h, bv h / ((k : ℝ) + av h)) > τ ↔ F k = true) := by
  classical
  obtain ⟨P, hPdeg, hPsign⟩ := exists_sign_poly F n
  set av : Fin (signChanges n F) → ℝ := fun h => (n : ℝ) + 2 + (h : ℕ) with hav
  have havinj : Function.Injective av := by
    intro a b hab
    rw [hav] at hab
    simp only [add_right_inj, Nat.cast_inj] at hab
    exact Fin.ext hab
  have havpos : ∀ h, (n : ℝ) + 1 < av h := by
    intro h; rw [hav]; have : (0 : ℝ) ≤ (h : ℕ) := Nat.cast_nonneg _; linarith
  obtain ⟨A, bv, hpf⟩ := real_partial_fraction P av havinj hPdeg
  refine ⟨av, bv, -A, havpos, ?_⟩
  intro k hk
  have hfacpos : ∀ h : Fin (signChanges n F), (0 : ℝ) < (k : ℝ) + av h := by
    intro h; rw [hav]; have : (0 : ℝ) ≤ (h : ℕ) := Nat.cast_nonneg _; positivity
  have hQpos : 0 < ∏ h : Fin (signChanges n F), ((k : ℝ) + av h) :=
    Finset.prod_pos (fun h _ => hfacpos h)
  have hQne : (∏ h : Fin (signChanges n F), ((k : ℝ) + av h)) ≠ 0 := ne_of_gt hQpos
  have herase_ne : ∀ h : Fin (signChanges n F),
      (∏ j ∈ Finset.univ.erase h, ((k : ℝ) + av j)) ≠ 0 :=
    fun h => Finset.prod_ne_zero_iff.mpr (fun j _ => ne_of_gt (hfacpos j))
  have hQfac : ∀ h : Fin (signChanges n F),
      (∏ j, ((k : ℝ) + av j)) = ((k : ℝ) + av h) * ∏ j ∈ Finset.univ.erase h, ((k : ℝ) + av j) :=
    fun h => (Finset.mul_prod_erase Finset.univ (fun j => (k : ℝ) + av j) (Finset.mem_univ h)).symm
  -- the key identity: `∑ b_h/(k+a_h) = P(k)/Q(k) - A`
  have hkey : (∑ h, bv h / ((k : ℝ) + av h))
      = P.eval (k : ℝ) / (∏ h, ((k : ℝ) + av h)) - A := by
    have h1 : (∑ h, bv h / ((k : ℝ) + av h))
        = (∑ h, bv h * ∏ j ∈ Finset.univ.erase h, ((k : ℝ) + av j))
          / (∏ h, ((k : ℝ) + av h)) := by
      rw [Finset.sum_div]
      refine Finset.sum_congr rfl (fun h _ => ?_)
      rw [hQfac h, mul_div_mul_right _ _ (herase_ne h)]
    rw [h1, hpf (k : ℝ)]
    field_simp
    ring
  rw [gt_iff_lt, hkey, lt_sub_iff_add_lt, neg_add_cancel, lt_div_iff₀ hQpos, zero_mul]
  exact hPsign k hk

/-- **L12 upper bound.** `symmetricFn F` is computable with `signChanges n F` heads. -/
theorem symmetricFn_computable (F : ℕ → Bool) (n : ℕ) :
    computableWithHeadsN n (signChanges n F) (symmetricFn F) := by
  classical
  rcases Nat.eq_zero_or_pos n with hn0 | hn
  · subst hn0
    have hsc : signChanges 0 F = 0 := by simp [signChanges]
    rw [hsc]
    refine ⟨2, (Fin.elim0 : HeadFamily 0 2 0), (0 : Vec 2), (if F 0 then -1 else 1), ?_⟩
    intro bits
    rw [headFamilyAttnUpdate_zero, inner_zero_right]
    have hw0 : hammingWeight bits = 0 := Nat.le_zero.mp (hammingWeight_le 0 bits)
    simp only [symmetricFn, hw0]
    cases F 0 <;> norm_num
  · obtain ⟨av, bv, τ, hav, hatom⟩ := exists_rational_atoms F n
    refine ⟨2, fun h => atomHead n (av h) (bv h), atomReadout, τ, ?_⟩
    intro bits
    change ⟪atomReadout, ∑ h, (atomHead n (av h) (bv h)).attnUpdate bits⟫_ℝ > τ ↔ _
    rw [atomFamily_readout hn av bv hav bits]
    simp only [symmetricFn]
    exact hatom (hammingWeight bits) (hammingWeight_le n bits)

/-- **Theorem 12 (conditional form).** If the sign-change upper-bound
construction computes `symmetricFn F`, then the head complexity is exactly the
number of sign changes of `F`. -/
theorem HStar_symmetricFn_eq_signChanges {n : ℕ} {F : ℕ → Bool}
    (hub : computableWithHeadsN n (signChanges n F) (symmetricFn F)) :
    HStar n (symmetricFn F) = signChanges n F := by
  classical
  have hExists : ∃ k, computableWithHeadsN n k (symmetricFn F) := ⟨_, hub⟩
  unfold HStar
  rw [dif_pos hExists]
  apply le_antisymm
  · exact Nat.find_min' hExists hub
  · exact signChanges_le_of_computableWithHeadsN (Nat.find_spec hExists)

/-- **Theorem 12 (unconditional).** For a symmetric Boolean function, the head
complexity equals the number of sign changes of its weight profile. -/
theorem HStar_symmetricFn (F : ℕ → Bool) (n : ℕ) :
    HStar n (symmetricFn F) = signChanges n F :=
  HStar_symmetricFn_eq_signChanges (symmetricFn_computable F n)

end HeadComplexity
