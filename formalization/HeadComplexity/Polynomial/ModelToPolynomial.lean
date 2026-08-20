import HeadComplexity.Polynomial.ThresholdDegree

set_option linter.style.header false

/-!
# Model → polynomial bridge (Theorem 6 / L12 lower bound, Phase 2).

`computableWithHeadsN n H f → ThresholdDegLE f H`: any function computed by `H`
attention heads has a real polynomial of total degree `≤ H` whose sign matches
`f` on the cube.

The mechanism is purely Boolean-finite: each softmax weight `σ_p` and each value
readout depends, under a fixed head, on **one** input bit (or none, for the query
token), and any `{0,1} → ℝ` function is its own affine (degree ≤ 1) interpolant.
So each head's numerator readout and denominator are affine (degree ≤ 1) in the
bits, with denominator `> 0`. Clearing the positive product of denominators turns
the `H`-head thresholded score into a single polynomial of total degree `≤ H`.
-/

namespace HeadComplexity

open MvPolynomial
open scoped InnerProductSpace BigOperators

variable {n d : ℕ}

/-! ## Affine (degree ≤ 1) gadget -/

/-- Affine polynomial matching a 2-valued function at position `p`. -/
noncomputable def affineAt (p : Fin n) (vf vt : ℝ) : MvPolynomial (Fin n) ℝ :=
  C vf + C (vt - vf) * X p

theorem affineAt_eval (p : Fin n) (vf vt : ℝ) (bits : Fin n → Bool) :
    eval (cubePoint bits) (affineAt p vf vt) = if bits p then vt else vf := by
  unfold affineAt cubePoint boolToReal
  simp only [map_add, map_mul, eval_C, eval_X]
  by_cases h : bits p
  · simp [h]
  · simp [h]

theorem affineAt_totalDegree_le (p : Fin n) (vf vt : ℝ) :
    (affineAt p vf vt).totalDegree ≤ 1 := by
  unfold affineAt
  refine (totalDegree_add _ _).trans ?_
  rw [totalDegree_C]
  refine max_le (Nat.zero_le _) ?_
  refine (totalDegree_mul _ _).trans ?_
  rw [totalDegree_C, totalDegree_X]

/-- A function depending only on bit `p` has a degree ≤ 1 representing polynomial. -/
theorem exists_affine_of_single_pos (s : (Fin n → Bool) → ℝ) (p : Fin n)
    (hdep : ∀ b₁ b₂ : Fin n → Bool, b₁ p = b₂ p → s b₁ = s b₂) :
    ∃ P : MvPolynomial (Fin n) ℝ, P.totalDegree ≤ 1 ∧
      ∀ bits, eval (cubePoint bits) P = s bits := by
  classical
  refine ⟨affineAt p (s (fun _ => false)) (s (Function.update (fun _ => false) p true)),
    affineAt_totalDegree_le _ _ _, ?_⟩
  intro bits
  rw [affineAt_eval]
  by_cases h : bits p
  · have hb : bits p = (Function.update (fun _ : Fin n => false) p true) p := by
      simp [Function.update_self, h]
    rw [if_pos h]; exact (hdep bits _ hb).symm
  · have hb : bits p = (fun _ : Fin n => false) p := by simp [h]
    rw [if_neg h]; exact (hdep bits _ hb).symm

/-- A constant function has a degree 0 representing polynomial. -/
theorem exists_const_poly (c : ℝ) :
    ∃ P : MvPolynomial (Fin n) ℝ, P.totalDegree ≤ 1 ∧
      ∀ bits, eval (cubePoint bits) P = c := by
  refine ⟨C c, ?_, ?_⟩
  · rw [totalDegree_C]; exact Nat.zero_le 1
  · intro bits; rw [eval_C]

/-! ## Single-position dependence of one head -/

variable (H : Head n d)

/-- The query position embedding is bit-independent. -/
theorem Head_x_none_const (b₁ b₂ : Fin n → Bool) : H.x b₁ none = H.x b₂ none := by
  simp [Head.x, Head.seqTok]

/-- `σ` at an input position depends only on that bit. -/
theorem Head_sigma_single (i : Fin n) (b₁ b₂ : Fin n → Bool) (h : b₁ i = b₂ i) :
    H.sigma b₁ (some i) = H.sigma b₂ (some i) := by
  unfold Head.sigma
  rw [show H.x b₁ (some i) = H.x b₂ (some i) by simp [Head.x, Head.seqTok, h],
      Head_x_none_const H b₁ b₂]

/-- `σ` at the query position is bit-independent. -/
theorem Head_sigma_none_const (b₁ b₂ : Fin n → Bool) :
    H.sigma b₁ none = H.sigma b₂ none := by
  unfold Head.sigma
  rw [Head_x_none_const H b₁ b₂]

/-- The readout score term `σ_p · ⟪w, value_p⟫` at an input position depends only
on that bit. -/
theorem Head_scoreTerm_single (w : Vec d) (i : Fin n) (b₁ b₂ : Fin n → Bool)
    (h : b₁ i = b₂ i) :
    H.sigma b₁ (some i) * ⟪w, H.value b₁ (some i)⟫_ℝ
      = H.sigma b₂ (some i) * ⟪w, H.value b₂ (some i)⟫_ℝ := by
  have hx : H.x b₁ (some i) = H.x b₂ (some i) := by simp [Head.x, Head.seqTok, h]
  rw [Head_sigma_single H i b₁ b₂ h]
  congr 2
  unfold Head.value
  rw [hx]

theorem Head_scoreTerm_none_const (w : Vec d) (b₁ b₂ : Fin n → Bool) :
    H.sigma b₁ none * ⟪w, H.value b₁ none⟫_ℝ
      = H.sigma b₂ none * ⟪w, H.value b₂ none⟫_ℝ := by
  have hv : H.value b₁ none = H.value b₂ none := by
    unfold Head.value; rw [Head_x_none_const H b₁ b₂]
  rw [Head_sigma_none_const H b₁ b₂, hv]

/-! ## Per-head denominator and numerator-readout polynomials -/

/-- The denominator of one head as a degree ≤ 1 polynomial. -/
theorem Head.exists_denomPoly :
    ∃ D : MvPolynomial (Fin n) ℝ, D.totalDegree ≤ 1 ∧
      ∀ bits, eval (cubePoint bits) D = H.denominator bits := by
  classical
  have hp : ∀ p : SeqPos n, ∃ Dp : MvPolynomial (Fin n) ℝ, Dp.totalDegree ≤ 1 ∧
      ∀ bits, eval (cubePoint bits) Dp = H.sigma bits p := by
    intro p
    cases p with
    | none =>
        obtain ⟨P, hP1, hP2⟩ := exists_const_poly (n := n) (H.sigma (fun _ => false) none)
        exact ⟨P, hP1, fun bits => (hP2 bits).trans (Head_sigma_none_const H _ bits)⟩
    | some i =>
        exact exists_affine_of_single_pos (fun bits => H.sigma bits (some i)) i
          (fun b₁ b₂ h => Head_sigma_single H i b₁ b₂ h)
  choose Dp hDp1 hDp2 using hp
  refine ⟨∑ p, Dp p, totalDegree_finsetSum_le (fun p _ => hDp1 p), ?_⟩
  intro bits
  rw [map_sum]
  simp_rw [hDp2]
  rfl

/-- The numerator readout `⟪w, numerator⟫` of one head as a degree ≤ 1 polynomial. -/
theorem Head.exists_numPoly (w : Vec d) :
    ∃ Nm : MvPolynomial (Fin n) ℝ, Nm.totalDegree ≤ 1 ∧
      ∀ bits, eval (cubePoint bits) Nm = ⟪w, H.numerator bits⟫_ℝ := by
  classical
  have hp : ∀ p : SeqPos n, ∃ Np : MvPolynomial (Fin n) ℝ, Np.totalDegree ≤ 1 ∧
      ∀ bits, eval (cubePoint bits) Np
        = H.sigma bits p * ⟪w, H.value bits p⟫_ℝ := by
    intro p
    cases p with
    | none =>
        obtain ⟨P, hP1, hP2⟩ := exists_const_poly (n := n)
          (H.sigma (fun _ => false) none * ⟪w, H.value (fun _ => false) none⟫_ℝ)
        exact ⟨P, hP1, fun bits => (hP2 bits).trans (Head_scoreTerm_none_const H w _ bits)⟩
    | some i =>
        exact exists_affine_of_single_pos
          (fun bits => H.sigma bits (some i) * ⟪w, H.value bits (some i)⟫_ℝ) i
          (fun b₁ b₂ h => Head_scoreTerm_single H w i b₁ b₂ h)
  choose Np hNp1 hNp2 using hp
  refine ⟨∑ p, Np p, totalDegree_finsetSum_le (fun p _ => hNp1 p), ?_⟩
  intro bits
  rw [map_sum]
  simp_rw [hNp2]
  rw [show H.numerator bits = ∑ p, H.sigma bits p • H.value bits p from rfl, inner_sum]
  exact Finset.sum_congr rfl
    (fun p _ => (inner_smul_right w (H.value bits p) (H.sigma bits p)).symm)

/-! ## Degree helpers -/

theorem totalDegree_prod_le_card {ι : Type*} (s : Finset ι)
    (D : ι → MvPolynomial (Fin n) ℝ) (hD : ∀ g, (D g).totalDegree ≤ 1) :
    (∏ g ∈ s, D g).totalDegree ≤ s.card := by
  refine (totalDegree_finsetProd _ _).trans ?_
  refine (Finset.sum_le_card_nsmul _ _ 1 (fun g _ => hD g)).trans ?_
  rw [smul_eq_mul, mul_one]

/-! ## Main theorem (Theorem 6): `H` heads give a degree-≤H sign representation. -/

theorem signReprDegLe_of_computableWithHeadsN {n H : ℕ} {f : (Fin n → Bool) → Bool}
    (hf : computableWithHeadsN n H f) : ThresholdDegLE f H := by
  classical
  obtain ⟨dim, Hs, w, τ, hsep⟩ := hf
  choose D hD1 hDeval using fun h : Fin H => (Hs h).exists_denomPoly
  choose N hN1 hNeval using fun h : Fin H => (Hs h).exists_numPoly w
  refine ⟨(∑ h, N h * ∏ g ∈ Finset.univ.erase h, D g) - C τ * ∏ g, D g, ?_, ?_⟩
  · -- total degree ≤ H
    refine (totalDegree_sub _ _).trans (max_le ?_ ?_)
    · refine totalDegree_finsetSum_le (fun h _ => ?_)
      refine (totalDegree_mul _ _).trans ?_
      have he : (∏ g ∈ Finset.univ.erase h, D g).totalDegree ≤ H - 1 := by
        refine (totalDegree_prod_le_card _ D hD1).trans ?_
        rw [Finset.card_erase_of_mem (Finset.mem_univ h), Finset.card_fin]
      have hH : 0 < H := Nat.pos_of_ne_zero (by rintro rfl; exact h.elim0)
      have := Nat.add_le_add (hN1 h) he
      omega
    · refine (totalDegree_mul _ _).trans ?_
      rw [totalDegree_C, Nat.zero_add]
      refine (totalDegree_prod_le_card _ D hD1).trans ?_
      rw [Finset.card_fin]
  · -- sign representation
    intro bits
    have hdpos : ∀ h, 0 < (Hs h).denominator bits := fun h => (Hs h).denominator_pos bits
    have hprodpos : 0 < ∏ g, (Hs g).denominator bits := Finset.prod_pos (fun g _ => hdpos g)
    -- score in cleared form
    have hU : ⟪w, headFamilyAttnUpdate Hs bits⟫_ℝ
        = ∑ h, ((Hs h).denominator bits)⁻¹ * ⟪w, (Hs h).numerator bits⟫_ℝ := by
      rw [show headFamilyAttnUpdate Hs bits = ∑ h, (Hs h).attnUpdate bits from rfl, inner_sum]
      refine Finset.sum_congr rfl (fun h _ => ?_)
      rw [show (Hs h).attnUpdate bits
            = ((Hs h).denominator bits)⁻¹ • (Hs h).numerator bits from rfl, inner_smul_right]
    -- eval of the cleared polynomial
    have hPeval : eval (cubePoint bits)
          ((∑ h, N h * ∏ g ∈ Finset.univ.erase h, D g) - C τ * ∏ g, D g)
        = (∑ h, ⟪w, (Hs h).numerator bits⟫_ℝ
              * ∏ g ∈ Finset.univ.erase h, (Hs g).denominator bits)
          - τ * ∏ g, (Hs g).denominator bits := by
      simp only [map_sub, map_mul, map_sum, map_prod, eval_C, hNeval, hDeval]
    -- the algebraic identity
    have hid : (∑ h, ⟪w, (Hs h).numerator bits⟫_ℝ
              * ∏ g ∈ Finset.univ.erase h, (Hs g).denominator bits)
          - τ * ∏ g, (Hs g).denominator bits
        = (∏ g, (Hs g).denominator bits) * (⟪w, headFamilyAttnUpdate Hs bits⟫_ℝ - τ) := by
      rw [hU, mul_sub, Finset.mul_sum]
      congr 1
      · refine Finset.sum_congr rfl (fun h _ => ?_)
        rw [← Finset.mul_prod_erase Finset.univ (fun g => (Hs g).denominator bits)
              (Finset.mem_univ h)]
        have hne : (Hs h).denominator bits ≠ 0 := (hdpos h).ne'
        field_simp
      · ring
    rw [hPeval, hid, mul_pos_iff_of_pos_left hprodpos, sub_pos]
    exact hsep bits

end HeadComplexity
