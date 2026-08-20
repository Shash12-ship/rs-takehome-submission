import Mathlib.Data.Fintype.Option
import HeadComplexity.Examples.OneHead

set_option linter.style.header false

/-!
# Theorem 2: two attention heads suffice to compute XOR.

We give construct two `Head 2 3` terms. Both heads use the standard token
embeddings `e_0`, `e_1`, `e_=` and no positional embeddings. The first head
attends to token `0` and writes in the `e_0` direction; the second attends to
token `1` and writes in the `e_1` direction. Their sum places the four
attention outputs into a configuration where the linear probe `e_0 + e_1`
separates the XOR-positive inputs from the XOR-negative inputs.
-/

namespace HeadComplexity

open scoped InnerProductSpace

/-- Outer product of two vectors as a linear map: `(u v^T)(w) = ⟪v, w⟫ u`. -/
noncomputable def outerProduct {n : ℕ} (u v : Vec n) : Vec n →ₗ[ℝ] Vec n where
  toFun w := ⟪v, w⟫_ℝ • u
  map_add' x y := by
    simp only [inner_add_right, add_smul]
  map_smul' c x := by
    simp only [inner_smul_right, RingHom.id_apply, smul_smul]

@[simp] theorem outerProduct_apply {n : ℕ} (u v w : Vec n) :
    outerProduct u v w = ⟪v, w⟫_ℝ • u := rfl

/-- The standard token embedding for the construction:
    `e_0 = (1,0,0)`, `e_1 = (0,1,0)`, `e_= = (0,0,1)`. -/
noncomputable def stdTokenEmbed : Fin 3 → Vec 3 := fun i => EuclideanSpace.single i 1

/-- **Head 0**: attends to token `0`, writes in the `e_0` direction. -/
noncomputable def head0 : Head 2 3 where
  tokenEmbed := stdTokenEmbed
  posEmbed := fun _ => 0
  WQ := LinearMap.id
  WK := outerProduct (EuclideanSpace.single 2 1) (EuclideanSpace.single 0 1)
  WV := outerProduct (EuclideanSpace.single 0 1) (EuclideanSpace.single 0 1)

/-- **Head 1**: attends to token `1`, writes in the `e_1` direction. -/
noncomputable def head1 : Head 2 3 where
  tokenEmbed := stdTokenEmbed
  posEmbed := fun _ => 0
  WQ := LinearMap.id
  WK := outerProduct (EuclideanSpace.single 2 1) (EuclideanSpace.single 1 1)
  WV := outerProduct (EuclideanSpace.single 1 1) (EuclideanSpace.single 1 1)

/-- The combined two-head attention update used in the `computesXor` target. -/
noncomputable def twoHeadUpdate (bits : Fin 2 → Bool) : Vec 3 :=
  head0.attnUpdate bits + head1.attnUpdate bits

@[simp] theorem stdTokenEmbed_apply (i : Fin 3) :
    stdTokenEmbed i = EuclideanSpace.single i 1 := rfl

@[simp] theorem head0_tokenEmbed : head0.tokenEmbed = stdTokenEmbed := rfl
@[simp] theorem head0_posEmbed : head0.posEmbed = (fun _ : SeqPos 2 => (0 : Vec 3)) := rfl
@[simp] theorem head0_WQ : head0.WQ = LinearMap.id := rfl
@[simp] theorem head0_WK :
    head0.WK = outerProduct (EuclideanSpace.single 2 1) (EuclideanSpace.single 0 1) := rfl
@[simp] theorem head0_WV :
    head0.WV = outerProduct (EuclideanSpace.single 0 1) (EuclideanSpace.single 0 1) := rfl

@[simp] theorem head1_tokenEmbed : head1.tokenEmbed = stdTokenEmbed := rfl
@[simp] theorem head1_posEmbed : head1.posEmbed = (fun _ : SeqPos 2 => (0 : Vec 3)) := rfl
@[simp] theorem head1_WQ : head1.WQ = LinearMap.id := rfl
@[simp] theorem head1_WK :
    head1.WK = outerProduct (EuclideanSpace.single 2 1) (EuclideanSpace.single 1 1) := rfl
@[simp] theorem head1_WV :
    head1.WV = outerProduct (EuclideanSpace.single 1 1) (EuclideanSpace.single 1 1) := rfl

@[simp] theorem head0_x_apply (bits : Fin 2 → Bool) (p : SeqPos 2) :
    head0.x bits p = EuclideanSpace.single (Head.seqTok bits p) 1 := by
  change head0.tokenEmbed (Head.seqTok bits p) + head0.posEmbed p = _
  simp

@[simp] theorem head1_x_apply (bits : Fin 2 → Bool) (p : SeqPos 2) :
    head1.x bits p = EuclideanSpace.single (Head.seqTok bits p) 1 := by
  change head1.tokenEmbed (Head.seqTok bits p) + head1.posEmbed p = _
  simp

/-- Inner product of two standard basis vectors of `Vec n`: `1` on the
diagonal and `0` off-diagonal. -/
@[simp] theorem inner_single_single {n : ℕ} (i j : Fin n) :
    ⟪(EuclideanSpace.single i (1 : ℝ)), EuclideanSpace.single j (1 : ℝ)⟫_ℝ
    = if i = j then (1 : ℝ) else 0 := by
  rw [← EuclideanSpace.basisFun_apply (Fin n) ℝ i,
      ← EuclideanSpace.basisFun_apply (Fin n) ℝ j]
  exact (EuclideanSpace.basisFun (Fin n) ℝ).inner_eq_ite i j

private theorem exp_pos' : (0 : ℝ) < Real.exp 1 := Real.exp_pos _

private theorem two_exp_one_add_one_pos : (0 : ℝ) < 2 * Real.exp 1 + 1 := by
  have := exp_pos'
  linarith

private theorem exp_one_add_two_pos : (0 : ℝ) < Real.exp 1 + 2 := by
  have := exp_pos'
  linarith

/-- The scalar read from `head1` on mixed inputs. -/
noncomputable def head1LowScore : ℝ :=
  Real.exp 1 / (Real.exp 1 + 2)

/-- The scalar read from `head1` on the `(true, true)` input. -/
noncomputable def head1HighScore : ℝ :=
  2 * Real.exp 1 / (2 * Real.exp 1 + 1)

/-- The probe reading the value channel written by `head1`. -/
noncomputable def head1Probe : Vec 3 :=
  EuclideanSpace.single (1 : Fin 3) 1

@[simp] theorem head1Probe_apply :
    head1Probe = EuclideanSpace.single (1 : Fin 3) 1 := rfl

/-- The mixed `head1` score is positive. -/
theorem head1LowScore_pos : (0 : ℝ) < head1LowScore := by
  unfold head1LowScore
  exact div_pos (Real.exp_pos _) exp_one_add_two_pos

/-- The mixed `head1` score is strictly below the `(true, true)` score. -/
theorem head1LowScore_lt_head1HighScore :
    head1LowScore < head1HighScore := by
  unfold head1LowScore head1HighScore
  rw [div_lt_div_iff₀ exp_one_add_two_pos two_exp_one_add_one_pos]
  nlinarith [exp_pos']

/-- The probe score on XOR-negative inputs in the two-head construction. -/
noncomputable def twoHeadLowScore : ℝ :=
  2 * Real.exp 1 / (2 * Real.exp 1 + 1)

/-- The probe score on XOR-positive inputs in the two-head construction. -/
noncomputable def twoHeadHighScore : ℝ :=
  2 * Real.exp 1 / (Real.exp 1 + 2)

/-- The two-head construction separates XOR-positive scores from
XOR-negative scores. -/
theorem twoHeadLowScore_lt_twoHeadHighScore :
    twoHeadLowScore < twoHeadHighScore := by
  unfold twoHeadLowScore twoHeadHighScore
  rw [div_lt_div_iff₀ two_exp_one_add_one_pos exp_one_add_two_pos]
  nlinarith [exp_pos', Real.one_lt_exp_iff.mpr one_pos]

/-- `head0.attnUpdate (false, false) = (2e / (2e + 1)) • e_0`. -/
private theorem head0_attnUpdate_ff_ff :
    head0.attnUpdate (bits2 false false) =
    (2 * Real.exp 1 / (2 * Real.exp 1 + 1)) • EuclideanSpace.single (0 : Fin 3) 1 := by
  have hD : head0.denominator (bits2 false false) = 2 * Real.exp 1 + 1 := by
    unfold Head.denominator Head.sigma
    simp [Head.seqTok, univ_option]
    ring
  have hN : head0.numerator (bits2 false false)
      = (2 * Real.exp 1) • EuclideanSpace.single (0 : Fin 3) 1 := by
    unfold Head.numerator Head.sigma Head.value
    simp [Head.seqTok, univ_option]
    module
  unfold Head.attnUpdate
  rw [hD, hN, smul_smul]
  congr 1
  rw [div_eq_mul_inv, mul_comm]

/-- `head0.attnUpdate (false, true) = (e / (e + 2)) • e_0`. -/
private theorem head0_attnUpdate_ff_tt :
    head0.attnUpdate (bits2 false true) =
    (Real.exp 1 / (Real.exp 1 + 2)) • EuclideanSpace.single (0 : Fin 3) 1 := by
  have hD : head0.denominator (bits2 false true) = Real.exp 1 + 2 := by
    unfold Head.denominator Head.sigma
    simp [Head.seqTok, univ_option]
    ring
  have hN : head0.numerator (bits2 false true)
      = (Real.exp 1) • EuclideanSpace.single (0 : Fin 3) 1 := by
    unfold Head.numerator Head.sigma Head.value
    simp [Head.seqTok, univ_option]
  unfold Head.attnUpdate
  rw [hD, hN, smul_smul]
  congr 1
  rw [div_eq_mul_inv, mul_comm]

/-- `head0.attnUpdate (true, false) = (e / (e + 2)) • e_0`. -/
private theorem head0_attnUpdate_tt_ff :
    head0.attnUpdate (bits2 true false) =
    (Real.exp 1 / (Real.exp 1 + 2)) • EuclideanSpace.single (0 : Fin 3) 1 := by
  have hD : head0.denominator (bits2 true false) = Real.exp 1 + 2 := by
    unfold Head.denominator Head.sigma
    simp [Head.seqTok, univ_option]
    ring
  have hN : head0.numerator (bits2 true false)
      = (Real.exp 1) • EuclideanSpace.single (0 : Fin 3) 1 := by
    unfold Head.numerator Head.sigma Head.value
    simp [Head.seqTok, univ_option]
  unfold Head.attnUpdate
  rw [hD, hN, smul_smul]
  congr 1
  rw [div_eq_mul_inv, mul_comm]

/-- `head0.attnUpdate (true, true) = 0`. -/
private theorem head0_attnUpdate_tt_tt :
    head0.attnUpdate (bits2 true true) = (0 : Vec 3) := by
  have hN : head0.numerator (bits2 true true) = (0 : Vec 3) := by
    unfold Head.numerator Head.sigma Head.value
    simp [Head.seqTok, univ_option]
  unfold Head.attnUpdate
  rw [hN, smul_zero]

/-- `head1.attnUpdate (false, false) = 0`. -/
private theorem head1_attnUpdate_ff_ff :
    head1.attnUpdate (bits2 false false) = (0 : Vec 3) := by
  have hN : head1.numerator (bits2 false false) = (0 : Vec 3) := by
    unfold Head.numerator Head.sigma Head.value
    simp [Head.seqTok, univ_option]
  unfold Head.attnUpdate
  rw [hN, smul_zero]

/-- `head1.attnUpdate (false, true) = (e /(e + 2)) • e_1`. -/
private theorem head1_attnUpdate_ff_tt :
    head1.attnUpdate (bits2 false true) =
    (Real.exp 1 / (Real.exp 1 + 2)) • EuclideanSpace.single (1 : Fin 3) 1 := by
  have hD : head1.denominator (bits2 false true) = Real.exp 1 + 2 := by
    unfold Head.denominator Head.sigma
    simp [Head.seqTok, univ_option]
    ring
  have hN : head1.numerator (bits2 false true)
      = (Real.exp 1) • EuclideanSpace.single (1 : Fin 3) 1 := by
    unfold Head.numerator Head.sigma Head.value
    simp [Head.seqTok, univ_option]
  unfold Head.attnUpdate
  rw [hD, hN, smul_smul]
  congr 1
  rw [div_eq_mul_inv, mul_comm]

/-- `head1.attnUpdate (true, false) = (e /(e + 2)) • e_1`. -/
private theorem head1_attnUpdate_tt_ff :
    head1.attnUpdate (bits2 true false) =
    (Real.exp 1 / (Real.exp 1 + 2)) • EuclideanSpace.single (1 : Fin 3) 1 := by
  have hD : head1.denominator (bits2 true false) = Real.exp 1 + 2 := by
    unfold Head.denominator Head.sigma
    simp [Head.seqTok, univ_option]
    ring
  have hN : head1.numerator (bits2 true false)
      = (Real.exp 1) • EuclideanSpace.single (1 : Fin 3) 1 := by
    unfold Head.numerator Head.sigma Head.value
    simp [Head.seqTok, univ_option]
  unfold Head.attnUpdate
  rw [hD, hN, smul_smul]
  congr 1
  rw [div_eq_mul_inv, mul_comm]

/-- `head1.attnUpdate (true, true) = (2e / (2e + 1)) • e_1`. -/
private theorem head1_attnUpdate_tt_tt :
    head1.attnUpdate (bits2 true true) =
    (2 * Real.exp 1 / (2 * Real.exp 1 + 1)) • EuclideanSpace.single (1 : Fin 3) 1 := by
  have hD : head1.denominator (bits2 true true) = 2 * Real.exp 1 + 1 := by
    unfold Head.denominator Head.sigma
    simp [Head.seqTok, univ_option]
    ring
  have hN : head1.numerator (bits2 true true)
      = (2 * Real.exp 1) • EuclideanSpace.single (1 : Fin 3) 1 := by
    unfold Head.numerator Head.sigma Head.value
    simp [Head.seqTok, univ_option]
    module
  unfold Head.attnUpdate
  rw [hD, hN, smul_smul]
  congr 1
  rw [div_eq_mul_inv, mul_comm]

/-- `head1Probe` reads zero on `(false, false)`. -/
theorem head1_score_ff_ff :
    ⟪head1Probe, head1.attnUpdate (bits2 false false)⟫_ℝ = 0 := by
  rw [head1_attnUpdate_ff_ff]
  simp [head1Probe]

/-- `head1Probe` reads the low score on `(false, true)`. -/
theorem head1_score_ff_tt :
    ⟪head1Probe, head1.attnUpdate (bits2 false true)⟫_ℝ = head1LowScore := by
  rw [head1_attnUpdate_ff_tt]
  rw [inner_smul_right, head1Probe_apply, inner_single_single]
  simp [head1LowScore, div_eq_mul_inv]

/-- `head1Probe` reads the low score on `(true, false)`. -/
theorem head1_score_tt_ff :
    ⟪head1Probe, head1.attnUpdate (bits2 true false)⟫_ℝ = head1LowScore := by
  rw [head1_attnUpdate_tt_ff]
  rw [inner_smul_right, head1Probe_apply, inner_single_single]
  simp [head1LowScore, div_eq_mul_inv]

/-- `head1Probe` reads the high score on `(true, true)`. -/
theorem head1_score_tt_tt :
    ⟪head1Probe, head1.attnUpdate (bits2 true true)⟫_ℝ = head1HighScore := by
  rw [head1_attnUpdate_tt_tt]
  rw [inner_smul_right, head1Probe_apply, inner_single_single]
  simp [head1HighScore, div_eq_mul_inv]

/-- The negated `head1Probe` reads zero on `(false, false)`. -/
theorem neg_head1_score_ff_ff :
    ⟪-head1Probe, head1.attnUpdate (bits2 false false)⟫_ℝ = 0 := by
  simpa [inner_neg_left] using congrArg Neg.neg head1_score_ff_ff

/-- The negated `head1Probe` reads the negated low score on `(false, true)`. -/
theorem neg_head1_score_ff_tt :
    ⟪-head1Probe, head1.attnUpdate (bits2 false true)⟫_ℝ = -head1LowScore := by
  simpa [inner_neg_left] using congrArg Neg.neg head1_score_ff_tt

/-- The negated `head1Probe` reads the negated low score on `(true, false)`. -/
theorem neg_head1_score_tt_ff :
    ⟪-head1Probe, head1.attnUpdate (bits2 true false)⟫_ℝ = -head1LowScore := by
  simpa [inner_neg_left] using congrArg Neg.neg head1_score_tt_ff

/-- The negated `head1Probe` reads the negated high score on `(true, true)`. -/
theorem neg_head1_score_tt_tt :
    ⟪-head1Probe, head1.attnUpdate (bits2 true true)⟫_ℝ = -head1HighScore := by
  simpa [inner_neg_left] using congrArg Neg.neg head1_score_tt_tt

/-- The combined update on `(false, false)`: only `head0` contributes. -/
private theorem twoHead_ff_ff :
    twoHeadUpdate (bits2 false false) =
    (2 * Real.exp 1 / (2 * Real.exp 1 + 1)) • EuclideanSpace.single (0 : Fin 3) 1 := by
  unfold twoHeadUpdate
  rw [head0_attnUpdate_ff_ff, head1_attnUpdate_ff_ff, add_zero]

/-- The combined update on `(false, true)`: both heads contribute. -/
private theorem twoHead_ff_tt :
    twoHeadUpdate (bits2 false true) =
    (Real.exp 1 / (Real.exp 1 + 2)) •
      (EuclideanSpace.single (0 : Fin 3) 1 + EuclideanSpace.single (1 : Fin 3) 1) := by
  unfold twoHeadUpdate
  rw [head0_attnUpdate_ff_tt, head1_attnUpdate_ff_tt, smul_add]

/-- The combined update on `(true, false)`: both heads contribute. -/
private theorem twoHead_tt_ff :
    twoHeadUpdate (bits2 true false) =
    (Real.exp 1 / (Real.exp 1 + 2)) •
      (EuclideanSpace.single (0 : Fin 3) 1 + EuclideanSpace.single (1 : Fin 3) 1) := by
  unfold twoHeadUpdate
  rw [head0_attnUpdate_tt_ff, head1_attnUpdate_tt_ff, smul_add]

/-- The combined update on `(true, true)`: only `head1` contributes. -/
private theorem twoHead_tt_tt :
    twoHeadUpdate (bits2 true true) =
    (2 * Real.exp 1 / (2 * Real.exp 1 + 1)) • EuclideanSpace.single (1 : Fin 3) 1 := by
  unfold twoHeadUpdate
  rw [head0_attnUpdate_tt_tt, head1_attnUpdate_tt_tt, zero_add]

/-- The linear probe `e_0 + e_1` evaluated on `twoHeadUpdate`. -/
theorem probe_score (bits : Fin 2 → Bool) :
    ⟪EuclideanSpace.single (0 : Fin 3) 1 + EuclideanSpace.single (1 : Fin 3) 1,
      twoHeadUpdate bits⟫_ℝ =
    if xorFn bits = true then twoHeadHighScore else twoHeadLowScore := by
  cases h0 : bits 0 <;> cases h1 : bits 1
  · have hbits : bits = bits2 false false := by
      funext i
      fin_cases i <;> simp [bits2, h0, h1]
    rw [hbits, twoHead_ff_ff]
    simp [xorFn, twoHeadLowScore, inner_add_left, inner_smul_right]
  · have hbits : bits = bits2 false true := by
      funext i
      fin_cases i <;> simp [bits2, h0, h1]
    rw [hbits, twoHead_ff_tt]
    simp [xorFn, twoHeadHighScore, inner_add_left, inner_smul_right, inner_add_right]
    ring
  · have hbits : bits = bits2 true false := by
      funext i
      fin_cases i <;> simp [bits2, h0, h1]
    rw [hbits, twoHead_tt_ff]
    simp [xorFn, twoHeadHighScore, inner_add_left, inner_smul_right, inner_add_right]
    ring
  · have hbits : bits = bits2 true true := by
      funext i
      fin_cases i <;> simp [bits2, h0, h1]
    rw [hbits, twoHead_tt_tt]
    simp [xorFn, twoHeadLowScore, inner_add_left, inner_smul_right]

/-- The strict gap between the two probe values. -/
theorem xor_gap : twoHeadLowScore < twoHeadHighScore :=
  twoHeadLowScore_lt_twoHeadHighScore

/-- The probe used by both the XOR and XNOR endpoint examples. -/
noncomputable def twoProbe : Vec 3 :=
  EuclideanSpace.single (0 : Fin 3) 1 + EuclideanSpace.single (1 : Fin 3) 1

/-- **Theorem 2.** The two-head construction computes XOR. -/
theorem two_heads_suffice :
    computesXor (twoHeadUpdate : (Fin 2 → Bool) → Vec 3) := by
  set τ := (twoHeadLowScore + twoHeadHighScore) / 2 with hτ_def
  have hgap := xor_gap
  have h_lo : twoHeadLowScore < τ := by
    rw [hτ_def]; linarith
  have h_hi : τ < twoHeadHighScore := by
    rw [hτ_def]; linarith
  refine ⟨twoProbe, τ, fun bits => ?_⟩
  unfold twoProbe
  rw [probe_score]
  by_cases hx : xorFn bits = true
  · rw [hx]
    simp only [↓reduceIte, gt_iff_lt, iff_true]
    exact h_hi
  · have hfalse : xorFn bits = false := by
      cases h : xorFn bits
      · rfl
      · exact False.elim (hx h)
    rw [hfalse]
    simp only [Bool.false_eq_true, ↓reduceIte]
    exact iff_false_intro (by linarith)

end HeadComplexity
