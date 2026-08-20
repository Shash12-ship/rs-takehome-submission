import HeadComplexity.Atoms.WeightedAtom
import HeadComplexity.Atoms.AffineHead

set_option linter.style.header false

/-!
# Theorem 11 — exact characterization of the zero- and one-head levels.

`H*(f) = 0 ⟺ f constant`, and `H*(f) = 1 ⟺ f is a nonconstant linear threshold
function`.  A linear threshold function is one sign-represented by an affine
functional (`isLTF`); this coincides with `ThresholdDegLE f 1`.

This file proves the parts not needing the affine-head construction: the
zero-head characterization (using that every function is computable, from the
Theorem 9 universal bound) and `isLTF`.  The one-head converse uses
`affine_computable` (the affine head, `Atoms/AffineHead.lean`).
-/

namespace HeadComplexity

open Finset
open scoped BigOperators InnerProductSpace

variable {n : ℕ}

/-- `f` is a **linear threshold function**: its truth is the sign of an affine
functional of the bits. -/
def isLTF (f : (Fin n → Bool) → Bool) : Prop :=
  ∃ (c : ℝ) (cs : Fin n → ℝ),
    ∀ x : Fin n → Bool, (0 < c + ∑ i, cs i * boolToReal (x i)) ↔ f x = true

/-- **Every Boolean function is computable** (with some number of heads), from the
binary-weight universal construction of Theorem 9. -/
theorem exists_computable (f : (Fin n → Bool) → Bool) :
    ∃ k, computableWithHeadsN n k f := by
  classical
  set lam : Fin n → ℝ := fun i => (2 : ℝ) ^ (i : ℕ) with hlamdef
  have hlam : ∀ i, 0 < lam i := fun i => by rw [hlamdef]; positivity
  have hinj : Function.Injective (wT lam) := by rw [hlamdef]; exact wT_two_pow_injective
  refine ⟨_, weighted_computable lam hlam f (f ∘ Function.invFun (wT lam)) ?_⟩
  intro bits
  change f bits = f (Function.invFun (wT lam) (wT lam bits))
  rw [Function.leftInverse_invFun hinj bits]

/-- The minimum in `HStar` is attained. -/
theorem HStar_computable (f : (Fin n → Bool) → Bool) :
    computableWithHeadsN n (HStar n f) f := by
  classical
  have hex : ∃ k, computableWithHeadsN n k f := exists_computable f
  unfold HStar
  rw [dif_pos hex]
  exact Nat.find_spec hex

/-! ## Zero heads ⟺ constant -/

/-- A zero-head model computes exactly the constant functions. -/
theorem computableWithHeadsN_zero_iff (f : (Fin n → Bool) → Bool) :
    computableWithHeadsN n 0 f ↔ ∀ x y, f x = f y := by
  constructor
  · rintro ⟨d, Hs, w, τ, hsep⟩ x y
    have hx := hsep x
    have hy := hsep y
    rw [headFamilyAttnUpdate_zero, inner_zero_right] at hx hy
    have key : f x = true ↔ f y = true := hx.symm.trans hy
    cases hfx : f x <;> cases hfy : f y <;> simp_all
  · intro hconst
    refine ⟨2, Fin.elim0, 0, (if f default then -1 else 1), ?_⟩
    intro bits
    rw [headFamilyAttnUpdate_zero, inner_zero_right, hconst bits default]
    cases f default <;> norm_num

/-- **Theorem 11 (level 0).** `H*(f) = 0` iff `f` is constant. -/
theorem HStar_eq_zero_iff (f : (Fin n → Bool) → Bool) :
    HStar n f = 0 ↔ ∀ x y, f x = f y := by
  classical
  have hex : ∃ k, computableWithHeadsN n k f := exists_computable f
  unfold HStar
  rw [dif_pos hex, Nat.find_eq_zero hex]
  exact computableWithHeadsN_zero_iff f

/-! ## Threshold degree `≤ 1` is exactly LTF -/

open MvPolynomial in
/-- A monomial exponent vector with exponent-sum `≤ 1` is `0` or `single i 1`. -/
private theorem finsupp_sum_le_one (d : Fin n →₀ ℕ) (h : d.sum (fun _ e => e) ≤ 1) :
    d = 0 ∨ ∃ i, d = Finsupp.single i 1 := by
  classical
  by_cases h0 : d = 0
  · exact Or.inl h0
  · rcases Finsupp.support_nonempty_iff.mpr h0 with ⟨i, hi⟩
    have hcard : d.support.card ≤ 1 := by
      calc d.support.card = ∑ _j ∈ d.support, 1 := by simp
        _ ≤ ∑ j ∈ d.support, d j :=
            Finset.sum_le_sum fun j hj =>
              Nat.succ_le_of_lt (Nat.pos_of_ne_zero (Finsupp.mem_support_iff.mp hj))
        _ = d.sum (fun _ e => e) := rfl
        _ ≤ 1 := h
    have hsub : d.support ⊆ {i} := fun j hj => by
      simpa using Finset.card_le_one.mp hcard j hj i hi
    have hd : d = Finsupp.single i (d i) := Finsupp.support_subset_singleton.mp hsub
    have hdi : d i = 1 := by
      have hpos : 0 < d i := Nat.pos_of_ne_zero (Finsupp.mem_support_iff.mp hi)
      have hle : d i ≤ 1 := (Finset.single_le_sum (fun j _ => Nat.zero_le _) hi).trans h
      omega
    exact Or.inr ⟨i, by rw [hd, hdi]⟩

open MvPolynomial in
/-- A polynomial of total degree `≤ 1` evaluates on the cube to its affine part. -/
theorem eval_cubePoint_affine (P : MvPolynomial (Fin n) ℝ) (hP : P.totalDegree ≤ 1)
    (x : Fin n → Bool) :
    eval (cubePoint x) P
      = P.coeff 0 + ∑ i, P.coeff (Finsupp.single i 1) * boolToReal (x i) := by
  classical
  rw [eval_eq]
  have hsupp : P.support ⊆
      insert (0 : Fin n →₀ ℕ) (Finset.univ.image fun i : Fin n => Finsupp.single i 1) := by
    intro d hd
    have hd1 : d.sum (fun _ e => e) ≤ 1 := (le_totalDegree hd).trans hP
    rcases finsupp_sum_le_one d hd1 with rfl | ⟨i, rfl⟩
    · exact Finset.mem_insert_self _ _
    · exact Finset.mem_insert_of_mem (Finset.mem_image_of_mem _ (Finset.mem_univ i))
  rw [Finset.sum_subset hsupp
    (fun d _ hdnot => by rw [MvPolynomial.notMem_support_iff.mp hdnot, zero_mul])]
  have h0not : (0 : Fin n →₀ ℕ) ∉ (Finset.univ.image fun i : Fin n => Finsupp.single i 1) := by
    rw [Finset.mem_image]
    rintro ⟨i, -, hi⟩
    exact (Finsupp.single_ne_zero.mpr one_ne_zero) hi
  rw [Finset.sum_insert h0not,
    Finset.sum_image (fun i _ j _ h => Finsupp.single_left_injective one_ne_zero h)]
  congr 1
  · simp
  · refine Finset.sum_congr rfl (fun i _ => ?_)
    rw [Finsupp.support_single i one_ne_zero, Finset.prod_singleton,
      Finsupp.single_eq_same]
    simp [cubePoint]

/-! ## The level-1 characterization -/

/-- `H*(f) = 1` heads give a linear threshold function (via Theorem 6). -/
theorem isLTF_of_computable_one (f : (Fin n → Bool) → Bool)
    (h : computableWithHeadsN n 1 f) : isLTF f := by
  obtain ⟨P, hPdeg, hPsign⟩ := signReprDegLe_of_computableWithHeadsN h
  refine ⟨P.coeff 0, fun i => P.coeff (Finsupp.single i 1), fun x => ?_⟩
  rw [← eval_cubePoint_affine P hPdeg x]
  exact hPsign x

/-- A linear threshold function is computed by one head (the affine head). -/
theorem computable_one_of_isLTF (f : (Fin n → Bool) → Bool) (h : isLTF f) :
    computableWithHeadsN n 1 f := by
  obtain ⟨c, cs, hsign⟩ := h
  exact affine_computable f c cs hsign

/-- Threshold degree at most one is equivalent to being a linear threshold
function. -/
theorem ThresholdDegLE_one_iff_isLTF (f : (Fin n → Bool) → Bool) :
    ThresholdDegLE f 1 ↔ isLTF f := by
  constructor
  · intro h
    obtain ⟨P, hPdeg, hPsign⟩ := h
    refine ⟨P.coeff 0, fun i => P.coeff (Finsupp.single i 1), fun x => ?_⟩
    rw [← eval_cubePoint_affine P hPdeg x]
    exact hPsign x
  · intro h
    exact signReprDegLe_of_computableWithHeadsN (computable_one_of_isLTF f h)

/-- **Theorem 11 (level 1).** `H*(f) = 1` iff `f` is a nonconstant linear threshold
function. -/
theorem HStar_eq_one_iff (f : (Fin n → Bool) → Bool) :
    HStar n f = 1 ↔ (¬ (∀ x y, f x = f y) ∧ isLTF f) := by
  classical
  have hex : ∃ k, computableWithHeadsN n k f := exists_computable f
  have hfind : HStar n f = Nat.find hex := by unfold HStar; rw [dif_pos hex]
  constructor
  · intro h1
    have hne : HStar n f ≠ 0 := by omega
    refine ⟨fun hc => hne ((HStar_eq_zero_iff f).mpr hc), ?_⟩
    have hfind1 : Nat.find hex = 1 := by rw [← hfind]; exact h1
    exact isLTF_of_computable_one f (hfind1 ▸ Nat.find_spec hex)
  · rintro ⟨hnc, hLTF⟩
    have hle : HStar n f ≤ 1 := by
      rw [hfind]; exact Nat.find_min' hex (computable_one_of_isLTF f hLTF)
    have hne : HStar n f ≠ 0 := fun h0 => hnc ((HStar_eq_zero_iff f).mp h0)
    omega

end HeadComplexity
