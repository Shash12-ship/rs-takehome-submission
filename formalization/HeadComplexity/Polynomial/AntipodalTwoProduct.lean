import Mathlib.Data.Fin.VecNotation
import Mathlib.LinearAlgebra.Matrix.Gershgorin
import Mathlib.LinearAlgebra.Matrix.Rank
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

set_option linter.style.header false

/-!
# Antipodal two-product obstruction

This file isolates the linear-algebra argument used by the strict-separation
result about antipodal slices ruling out every two-product affine sign representation.
-/

namespace HeadComplexity

namespace AntipodalTwoProduct

open Finset
open scoped BigOperators

abbrev FiveBits := Fin 5 → Bool

/-- The centered real encoding of a bit. -/
def bitSign (b : Bool) : ℝ := if b then -1 else 1

@[simp] theorem bitSign_false : bitSign false = 1 := rfl
@[simp] theorem bitSign_true : bitSign true = -1 := rfl

/-- Flip every bit. -/
def bitAntipode (x : FiveBits) : FiveBits := fun i ↦ !(x i)

@[simp] theorem bitSign_antipode (x : FiveBits) (i : Fin 5) :
    bitSign (bitAntipode x i) = -bitSign (x i) := by
  cases h : x i <;> simp [bitAntipode, bitSign, h]

/-- The sign vector with a single negative coordinate. -/
def antipodalSlice (j : Fin 5) : FiveBits := fun i ↦ decide (i = j)

@[simp] theorem antipodalSlice_self (j : Fin 5) : antipodalSlice j j = true := by
  simp [antipodalSlice]

/-- An affine form on two blocks of five centered Boolean variables. -/
structure BiAffine where
  const : ℝ
  xCoeff : Fin 5 → ℝ
  yCoeff : Fin 5 → ℝ

namespace BiAffine

/-- Evaluation of a two-block affine form. -/
def eval (L : BiAffine) (x y : FiveBits) : ℝ :=
  L.const + ∑ i, L.xCoeff i * bitSign (x i) + ∑ j, L.yCoeff j * bitSign (y j)

/-- The homogeneous part in the first block. -/
def xPart (L : BiAffine) (x : FiveBits) : ℝ :=
  ∑ i, L.xCoeff i * bitSign (x i)

/-- The homogeneous part in the second block. -/
def yPart (L : BiAffine) (y : FiveBits) : ℝ :=
  ∑ j, L.yCoeff j * bitSign (y j)

theorem eval_eq (L : BiAffine) (x y : FiveBits) :
    L.eval x y = L.const + L.xPart x + L.yPart y := by
  rfl

theorem xPart_antipode (L : BiAffine) (x : FiveBits) :
    L.xPart (bitAntipode x) = -L.xPart x := by
  simp only [xPart, bitSign_antipode, mul_neg, Finset.sum_neg_distrib]

theorem yPart_antipode (L : BiAffine) (y : FiveBits) :
    L.yPart (bitAntipode y) = -L.yPart y := by
  simp only [yPart, bitSign_antipode, mul_neg, Finset.sum_neg_distrib]

end BiAffine

/-- A sum of two products of affine forms. -/
def twoProductScore (L₁ R₁ L₂ R₂ : BiAffine) (x y : FiveBits) : ℝ :=
  L₁.eval x y * R₁.eval x y + L₂.eval x y * R₂.eval x y

/-- The mixed antipodal difference of a two-block function. -/
def mixedAntipodalDifference (g : FiveBits → FiveBits → ℝ)
    (x y : FiveBits) : ℝ :=
  g x y - g x (bitAntipode y) - g (bitAntipode x) y
    + g (bitAntipode x) (bitAntipode y)

theorem mixedAntipodalDifference_product (L R : BiAffine) (x y : FiveBits) :
    mixedAntipodalDifference (fun x y ↦ L.eval x y * R.eval x y) x y
      = 4 * (L.xPart x * R.yPart y + R.xPart x * L.yPart y) := by
  rw [mixedAntipodalDifference]
  simp only [BiAffine.eval_eq, BiAffine.xPart_antipode, BiAffine.yPart_antipode]
  ring_nf

theorem mixedAntipodalDifference_twoProduct (L₁ R₁ L₂ R₂ : BiAffine)
    (x y : FiveBits) :
    mixedAntipodalDifference (twoProductScore L₁ R₁ L₂ R₂) x y
      = 4 * (L₁.xPart x * R₁.yPart y + R₁.xPart x * L₁.yPart y
        + L₂.xPart x * R₂.yPart y + R₂.xPart x * L₂.yPart y) := by
  rw [show mixedAntipodalDifference (twoProductScore L₁ R₁ L₂ R₂) x y
      = mixedAntipodalDifference (fun x y ↦ L₁.eval x y * R₁.eval x y) x y
        + mixedAntipodalDifference (fun x y ↦ L₂.eval x y * R₂.eval x y) x y by
      simp [mixedAntipodalDifference, twoProductScore]; ring]
  rw [mixedAntipodalDifference_product, mixedAntipodalDifference_product]
  ring

/-- The coefficient matrix of the five mixed slice differences. -/
def mixedCoefficientMatrix (L₁ R₁ L₂ R₂ : BiAffine) : Matrix (Fin 5) (Fin 5) ℝ :=
  fun i j ↦ 4 * (L₁.xCoeff i * R₁.yPart (antipodalSlice j)
    + R₁.xCoeff i * L₁.yPart (antipodalSlice j)
    + L₂.xCoeff i * R₂.yPart (antipodalSlice j)
    + R₂.xCoeff i * L₂.yPart (antipodalSlice j))

theorem mixedAntipodalDifference_eq_matrix (L₁ R₁ L₂ R₂ : BiAffine)
    (x : FiveBits) (j : Fin 5) :
    mixedAntipodalDifference (twoProductScore L₁ R₁ L₂ R₂)
        x (antipodalSlice j)
      = ∑ i, mixedCoefficientMatrix L₁ R₁ L₂ R₂ i j * bitSign (x i) := by
  rw [mixedAntipodalDifference_twoProduct]
  simp only [BiAffine.xPart, mixedCoefficientMatrix]
  simp only [mul_add, add_mul, Finset.sum_add_distrib, Finset.sum_mul]
  rw [Finset.mul_sum, Finset.mul_sum, Finset.mul_sum, Finset.mul_sum]
  simp only [mul_comm, mul_left_comm]

/-- The five-by-four matrix containing the four first-block coefficient vectors. -/
def mixedLeftFactor (L₁ R₁ L₂ R₂ : BiAffine) : Matrix (Fin 5) (Fin 4) ℝ :=
  fun i ↦ ![L₁.xCoeff i, R₁.xCoeff i, L₂.xCoeff i, R₂.xCoeff i]

/-- The four-by-five matrix of slice-dependent coefficients. -/
def mixedRightFactor (L₁ R₁ L₂ R₂ : BiAffine) : Matrix (Fin 4) (Fin 5) ℝ :=
  fun h j ↦ ![4 * R₁.yPart (antipodalSlice j), 4 * L₁.yPart (antipodalSlice j),
    4 * R₂.yPart (antipodalSlice j), 4 * L₂.yPart (antipodalSlice j)] h

theorem mixedCoefficientMatrix_factor (L₁ R₁ L₂ R₂ : BiAffine) :
    mixedCoefficientMatrix L₁ R₁ L₂ R₂
      = mixedLeftFactor L₁ R₁ L₂ R₂ * mixedRightFactor L₁ R₁ L₂ R₂ := by
  ext i j
  simp [mixedCoefficientMatrix, mixedLeftFactor, mixedRightFactor, Matrix.mul_apply,
    Fin.sum_univ_four]
  ring

/-- Choose signs that make every off-diagonal contribution nonpositive. -/
noncomputable def oppositeColumnInput (A : Matrix (Fin 5) (Fin 5) ℝ) (j : Fin 5) :
    FiveBits := fun i ↦ if i = j then false else decide (0 ≤ A i j)

@[simp] theorem oppositeColumnInput_self (A : Matrix (Fin 5) (Fin 5) ℝ) (j : Fin 5) :
    oppositeColumnInput A j j = false := by
  simp [oppositeColumnInput]

theorem oppositeColumnInput_off_diagonal (A : Matrix (Fin 5) (Fin 5) ℝ)
    {i j : Fin 5} (hij : i ≠ j) :
    A i j * bitSign (oppositeColumnInput A j i) = -|A i j| := by
  by_cases hnonneg : 0 ≤ A i j
  · simp [oppositeColumnInput, hij, hnonneg, bitSign, abs_of_nonneg]
  · have hneg : A i j < 0 := lt_of_not_ge hnonneg
    simp [oppositeColumnInput, hij, hnonneg, bitSign, abs_of_neg hneg]

/-- Sign forcing on all Boolean vectors implies strict column diagonal dominance. -/
theorem strictColumnDominant_of_forcedSigns (A : Matrix (Fin 5) (Fin 5) ℝ)
    (hforce : ∀ (x : FiveBits) (j : Fin 5),
      0 < bitSign (x j) * ∑ i, A i j * bitSign (x i)) :
    ∀ j, ∑ i ∈ Finset.univ.erase j, ‖A i j‖ < ‖A j j‖ := by
  intro j
  have hmin := hforce (oppositeColumnInput A j) j
  simp only [oppositeColumnInput_self, bitSign_false, one_mul] at hmin
  rw [← Finset.add_sum_erase Finset.univ
    (fun i ↦ A i j * bitSign (oppositeColumnInput A j i)) (Finset.mem_univ j)] at hmin
  have hoff :
      ∑ i ∈ Finset.univ.erase j, A i j * bitSign (oppositeColumnInput A j i)
        = -∑ i ∈ Finset.univ.erase j, |A i j| := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun i hi ↦
      oppositeColumnInput_off_diagonal A (Finset.ne_of_mem_erase hi)
  rw [oppositeColumnInput_self, bitSign_false, mul_one, hoff] at hmin
  have hdiag : 0 < A j j := by
    have hnonneg : 0 ≤ ∑ i ∈ Finset.univ.erase j, |A i j| :=
      Finset.sum_nonneg fun i _ ↦ abs_nonneg _
    linarith
  simp only [Real.norm_eq_abs, abs_of_pos hdiag]
  linarith

theorem mixedCoefficientMatrix_rank_le_four (L₁ R₁ L₂ R₂ : BiAffine) :
    (mixedCoefficientMatrix L₁ R₁ L₂ R₂).rank ≤ 4 := by
  rw [mixedCoefficientMatrix_factor]
  exact (Matrix.rank_mul_le_left
      (mixedLeftFactor L₁ R₁ L₂ R₂)
      (mixedRightFactor L₁ R₁ L₂ R₂)).trans
    (by simpa using Matrix.rank_le_card_width (mixedLeftFactor L₁ R₁ L₂ R₂))

/-- No sum of two products of affine forms can have the five forced mixed signs. -/
theorem no_twoProductScore_of_forcedSigns (L₁ R₁ L₂ R₂ : BiAffine) :
    ¬ (∀ x j,
      0 < bitSign (x j) *
        mixedAntipodalDifference (twoProductScore L₁ R₁ L₂ R₂)
          x (antipodalSlice j)) := by
  intro hforce
  let A := mixedCoefficientMatrix L₁ R₁ L₂ R₂
  have hforceA : ∀ (x : FiveBits) (j : Fin 5),
      0 < bitSign (x j) * ∑ i, A i j * bitSign (x i) := by
    intro x j
    rw [← mixedAntipodalDifference_eq_matrix]
    exact hforce x j
  have hdet : A.det ≠ 0 :=
    det_ne_zero_of_sum_col_lt_diag (strictColumnDominant_of_forcedSigns A hforceA)
  have hunitDet : IsUnit A.det := isUnit_iff_ne_zero.mpr hdet
  have hunit : IsUnit A := (Matrix.isUnit_iff_isUnit_det A).mpr hunitDet
  have hrankFive : A.rank = 5 := by
    simpa [A] using Matrix.rank_of_isUnit A hunit
  have hrankFour : A.rank ≤ 4 := by
    simpa [A] using mixedCoefficientMatrix_rank_le_four L₁ R₁ L₂ R₂
  omega

/-- The antipodal-slice truth pattern used by the obstruction. -/
def HasFiveAntipodalSlices (f : FiveBits → FiveBits → Bool) : Prop :=
  ∀ x j,
    f x (antipodalSlice j) = !x j ∧
    f x (bitAntipode (antipodalSlice j)) = x j ∧
    f (bitAntipode x) (antipodalSlice j) = x j ∧
    f (bitAntipode x) (bitAntipode (antipodalSlice j)) = !x j

/-- The target slice pattern forces the sign condition used by the rank argument. -/
theorem forcedSigns_of_signRepresentation
    (f : FiveBits → FiveBits → Bool) (L₁ R₁ L₂ R₂ : BiAffine)
    (hslices : HasFiveAntipodalSlices f)
    (hsign : ∀ x y, 0 < twoProductScore L₁ R₁ L₂ R₂ x y ↔ f x y = true) :
    ∀ x j,
      0 < bitSign (x j) *
        mixedAntipodalDifference (twoProductScore L₁ R₁ L₂ R₂)
          x (antipodalSlice j) := by
  intro x j
  rcases hslices x j with ⟨h₁, h₂, h₃, h₄⟩
  have score_pos {u v : FiveBits} (htrue : f u v = true) :
      0 < twoProductScore L₁ R₁ L₂ R₂ u v :=
    (hsign u v).mpr htrue
  have score_nonpos {u v : FiveBits} (hfalse : f u v = false) :
      twoProductScore L₁ R₁ L₂ R₂ u v ≤ 0 := by
    exact le_of_not_gt fun hpos ↦ Bool.false_ne_true (hfalse.symm.trans ((hsign u v).mp hpos))
  cases hx : x j with
  | false =>
      have hp₁ := score_pos (h₁.trans (by simp [hx]))
      have hn₂ := score_nonpos (h₂.trans hx)
      have hn₃ := score_nonpos (h₃.trans hx)
      have hp₄ := score_pos (h₄.trans (by simp [hx]))
      simp [bitSign, mixedAntipodalDifference]
      linarith
  | true =>
      have hn₁ := score_nonpos (h₁.trans (by simp [hx]))
      have hp₂ := score_pos (h₂.trans hx)
      have hp₃ := score_pos (h₃.trans hx)
      have hn₄ := score_nonpos (h₄.trans (by simp [hx]))
      simp [bitSign, mixedAntipodalDifference]
      linarith

/-- Antipodal slices rule out every two-product affine sign representation. -/
theorem no_twoProduct_signRepresentation
    (f : FiveBits → FiveBits → Bool) (hslices : HasFiveAntipodalSlices f)
    (L₁ R₁ L₂ R₂ : BiAffine) :
    ¬ (∀ x y, 0 < twoProductScore L₁ R₁ L₂ R₂ x y ↔ f x y = true) := by
  intro hsign
  exact no_twoProductScore_of_forcedSigns L₁ R₁ L₂ R₂
    (forcedSigns_of_signRepresentation f L₁ R₁ L₂ R₂ hslices hsign)

end AntipodalTwoProduct

end HeadComplexity
