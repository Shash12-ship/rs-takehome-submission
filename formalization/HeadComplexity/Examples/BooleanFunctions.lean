import HeadComplexity.Examples.TwoHeads

set_option linter.style.header false

/-!
# Boolean-function examples in the head-complexity model.

This file keeps a compact two-bit example layer: named Boolean functions,
explicit one- and two-head constructions, and the exact head-complexity
table for all symmetric two-bit functions.
-/

namespace HeadComplexity

open scoped InnerProductSpace

variable {d : ℕ}

/-- A vector-valued two-bit function computes a Boolean target under a linear
readout. -/
def computesBool (f : (Fin 2 → Bool) → Bool) (g : (Fin 2 → Bool) → Vec d) : Prop :=
  computesPred f g

/-- Named versions of the standard 2-bit Boolean functions. -/
def falseFn : (Fin 2 → Bool) → Bool := fun _ => false
def trueFn : (Fin 2 → Bool) → Bool := fun _ => true
def orFn : (Fin 2 → Bool) → Bool := fun bits => bits 0 || bits 1
def andFn : (Fin 2 → Bool) → Bool := fun bits => bits 0 && bits 1
def norFn : (Fin 2 → Bool) → Bool := fun bits => !(orFn bits)
def nandFn : (Fin 2 → Bool) → Bool := fun bits => !(andFn bits)
def xnorFn : (Fin 2 → Bool) → Bool := fun bits => !(xorFn bits)

/-- The 2-bit symmetric Boolean function determined by its values on Hamming
weights `0`, `1`, and `2`. -/
def symmFn (c0 c1 c2 : Bool) : (Fin 2 → Bool) → Bool := fun bits =>
  match bits 0, bits 1 with
  | false, false => c0
  | false, true => c1
  | true, false => c1
  | true, true => c2

/-- Two-bit head families are just the model specialized to `n = 2`. -/
abbrev TwoBitHeadFamily (d H : ℕ) : Type := HeadFamily 2 d H

/-- The summed attention update of a two-bit head family. -/
noncomputable def twoBitHeadFamilyAttnUpdate {H : ℕ} (Hs : TwoBitHeadFamily d H) :
    (Fin 2 → Bool) → Vec d :=
  headFamilyAttnUpdate Hs

/-- Two-bit computability with `H` heads. -/
abbrev computableWithHeads (f : (Fin 2 → Bool) → Bool) (H : ℕ) : Prop :=
  computableWithHeadsN 2 H f

/-- Exact two-bit head complexity. -/
abbrev exactHeadComplexity (f : (Fin 2 → Bool) → Bool) (k : ℕ) : Prop :=
  exactHeadComplexityN 2 f k

/-- Explicit two-bit head complexity value. -/
noncomputable def HStar2 (f : (Fin 2 → Bool) → Bool) : ℕ :=
  HStar 2 f

@[simp] theorem twoBitHeadFamilyAttnUpdate_zero {Hs : TwoBitHeadFamily d 0} (bits : Fin 2 → Bool) :
    twoBitHeadFamilyAttnUpdate Hs bits = 0 := by
  simp [twoBitHeadFamilyAttnUpdate]

@[simp] theorem twoBitHeadFamilyAttnUpdate_one {Hs : TwoBitHeadFamily d 1} (bits : Fin 2 → Bool) :
    twoBitHeadFamilyAttnUpdate Hs bits = (Hs 0).attnUpdate bits := by
  simp [twoBitHeadFamilyAttnUpdate]

@[simp] theorem computesXor_iff_computesBool_xor (g : (Fin 2 → Bool) → Vec d) :
    computesXor g ↔ computesBool xorFn g := by
  rfl

@[simp] theorem falseFn_apply (bits : Fin 2 → Bool) : falseFn bits = false := rfl
@[simp] theorem trueFn_apply (bits : Fin 2 → Bool) : trueFn bits = true := rfl
@[simp] theorem norFn_apply (bits : Fin 2 → Bool) : norFn bits = !(orFn bits) := rfl
@[simp] theorem nandFn_apply (bits : Fin 2 → Bool) : nandFn bits = !(andFn bits) := rfl
@[simp] theorem xnorFn_apply (bits : Fin 2 → Bool) : xnorFn bits = !(xorFn bits) := rfl

theorem HStar2_eq_of_exact {f : (Fin 2 → Bool) → Bool} {k : ℕ}
    (hk : exactHeadComplexity f k) : HStar2 f = k := by
  exact HStar_eq_of_exact hk

/-- Adding a constant vector only shifts the probe threshold. -/
theorem computesBool_iff_of_add_const
    (f : (Fin 2 → Bool) → Bool) (g : (Fin 2 → Bool) → Vec d) (c : Vec d) :
    computesBool f g ↔ computesBool f (fun bits => c + g bits) := by
  simpa [computesBool] using computesPred_iff_of_add_const f g c

/-- Generic skip-connection reduction for two-bit Boolean classification. -/
theorem computesBool_residual_iff_attnUpdate
    (f : (Fin 2 → Bool) → Bool) (H : Head 2 d) :
    computesBool f H.residual ↔ computesBool f H.attnUpdate := by
  simpa [computesBool] using Head.computesPred_residual_iff_attnUpdate H f

private theorem bits_eq_bits2_of_cases
    (bits : Fin 2 → Bool) (a b : Bool) (h0 : bits 0 = a) (h1 : bits 1 = b) :
    bits = bits2 a b := by
  funext i
  fin_cases i <;> simp [bits2, h0, h1]

/-- Head 1 separates `OR` on the bare attention update. -/
theorem head1_computes_or_attnUpdate :
    computesBool orFn head1.attnUpdate := by
  let τ : ℝ := head1LowScore / 2
  have hτ_pos : 0 < τ := by
    dsimp [τ]
    linarith [head1LowScore_pos]
  have hτ_lt_low : τ < head1LowScore := by
    dsimp [τ]
    linarith [head1LowScore_pos]
  refine ⟨head1Probe, τ, ?_⟩
  intro bits
  cases h0 : bits 0 <;> cases h1 : bits 1
  · rw [bits_eq_bits2_of_cases bits false false h0 h1, head1_score_ff_ff]
    have hnot : ¬ 0 > τ := by linarith
    simp [orFn, τ, hnot]
  · rw [bits_eq_bits2_of_cases bits false true h0 h1, head1_score_ff_tt]
    have hgt : head1LowScore > τ := by linarith
    simp [orFn, τ, hgt]
  · rw [bits_eq_bits2_of_cases bits true false h0 h1, head1_score_tt_ff]
    have hgt : head1LowScore > τ := by linarith
    simp [orFn, τ, hgt]
  · rw [bits_eq_bits2_of_cases bits true true h0 h1, head1_score_tt_tt]
    have hgt : head1HighScore > τ := by
      linarith [hτ_lt_low, head1LowScore_lt_head1HighScore]
    simp [orFn, τ, hgt]

/-- Head 1 also separates `AND` on the bare attention update. -/
theorem head1_computes_and_attnUpdate :
    computesBool andFn head1.attnUpdate := by
  let lo : ℝ := head1LowScore
  let hi : ℝ := head1HighScore
  let τ : ℝ := (lo + hi) / 2
  have hgap : lo < hi := by
    dsimp [lo, hi]
    exact head1LowScore_lt_head1HighScore
  have hlo : lo < τ := by
    dsimp [τ]
    linarith
  have hhi : τ < hi := by
    dsimp [τ]
    linarith
  have hzero : (0 : ℝ) < τ := by
    linarith [head1LowScore_pos, hlo]
  refine ⟨head1Probe, τ, ?_⟩
  intro bits
  cases h0 : bits 0 <;> cases h1 : bits 1
  · rw [bits_eq_bits2_of_cases bits false false h0 h1, head1_score_ff_ff]
    have hnot : ¬ 0 > τ := by linarith
    simp [andFn, τ, hnot]
  · rw [bits_eq_bits2_of_cases bits false true h0 h1, head1_score_ff_tt]
    have hnot : ¬ lo > τ := by linarith
    simp [andFn, lo, τ, hnot]
  · rw [bits_eq_bits2_of_cases bits true false h0 h1, head1_score_tt_ff]
    have hnot : ¬ lo > τ := by linarith
    simp [andFn, lo, τ, hnot]
  · rw [bits_eq_bits2_of_cases bits true true h0 h1, head1_score_tt_tt]
    have hgt : hi > τ := by linarith
    simp [andFn, hi, τ, hgt]

/-- Negating the probe for Head 1 separates `NOR`. -/
theorem head1_computes_nor_attnUpdate :
    computesBool norFn head1.attnUpdate := by
  let lo : ℝ := head1LowScore
  let hi : ℝ := head1HighScore
  let τ : ℝ := -(lo / 2)
  have hlo : 0 < lo := by
    dsimp [lo]
    exact head1LowScore_pos
  have hτneg : τ < 0 := by
    dsimp [τ]
    linarith
  have hlow : -lo ≤ τ := by
    dsimp [τ]
    linarith
  have hhigh : -hi ≤ τ := by
    dsimp [τ]
    linarith [head1LowScore_lt_head1HighScore]
  refine ⟨-head1Probe, τ, ?_⟩
  intro bits
  cases h0 : bits 0 <;> cases h1 : bits 1
  · rw [bits_eq_bits2_of_cases bits false false h0 h1, neg_head1_score_ff_ff]
    have hgt : (0 : ℝ) > τ := by linarith
    simp [norFn, orFn, τ, hgt]
  · rw [bits_eq_bits2_of_cases bits false true h0 h1, neg_head1_score_ff_tt]
    have hnot : ¬ -lo > τ := by linarith
    simp [norFn, orFn, lo, τ, hnot]
  · rw [bits_eq_bits2_of_cases bits true false h0 h1, neg_head1_score_tt_ff]
    have hnot : ¬ -lo > τ := by linarith
    simp [norFn, orFn, lo, τ, hnot]
  · rw [bits_eq_bits2_of_cases bits true true h0 h1, neg_head1_score_tt_tt]
    have hnot : ¬ -hi > τ := by linarith
    simp [norFn, orFn, hi, τ, hnot]

/-- Negating the probe for Head 1 separates `NAND`. -/
theorem head1_computes_nand_attnUpdate :
    computesBool nandFn head1.attnUpdate := by
  let lo : ℝ := head1LowScore
  let hi : ℝ := head1HighScore
  let τ : ℝ := -((lo + hi) / 2)
  have hgap : lo < hi := by
    dsimp [lo, hi]
    exact head1LowScore_lt_head1HighScore
  have hτ0 : τ < 0 := by
    dsimp [τ]
    linarith [head1LowScore_pos]
  have hmixed : τ < -lo := by
    dsimp [τ]
    linarith
  have htt : -(hi) ≤ τ := by
    dsimp [τ]
    linarith
  refine ⟨-head1Probe, τ, ?_⟩
  intro bits
  cases h0 : bits 0 <;> cases h1 : bits 1
  · rw [bits_eq_bits2_of_cases bits false false h0 h1, neg_head1_score_ff_ff]
    have hgt : (0 : ℝ) > τ := by linarith
    simp [nandFn, andFn, τ, hgt]
  · rw [bits_eq_bits2_of_cases bits false true h0 h1, neg_head1_score_ff_tt]
    have hgt : -lo > τ := by linarith
    simp [nandFn, andFn, lo, τ, hgt]
  · rw [bits_eq_bits2_of_cases bits true false h0 h1, neg_head1_score_tt_ff]
    have hgt : -lo > τ := by linarith
    simp [nandFn, andFn, lo, τ, hgt]
  · rw [bits_eq_bits2_of_cases bits true true h0 h1, neg_head1_score_tt_tt]
    have hnot : ¬ -hi > τ := by linarith
    simp [nandFn, andFn, hi, τ, hnot]

/-- The skip connection does not change `OR` computability for Head 1. -/
theorem head1_computes_or_residual :
    computesBool orFn head1.residual := by
  rw [computesBool_residual_iff_attnUpdate]
  exact head1_computes_or_attnUpdate

/-- The skip connection does not change `AND` computability for Head 1. -/
theorem head1_computes_and_residual :
    computesBool andFn head1.residual := by
  rw [computesBool_residual_iff_attnUpdate]
  exact head1_computes_and_attnUpdate

/-- The skip connection does not change `NOR` computability for Head 1. -/
theorem head1_computes_nor_residual :
    computesBool norFn head1.residual := by
  rw [computesBool_residual_iff_attnUpdate]
  exact head1_computes_nor_attnUpdate

/-- The skip connection does not change `NAND` computability for Head 1. -/
theorem head1_computes_nand_residual :
    computesBool nandFn head1.residual := by
  rw [computesBool_residual_iff_attnUpdate]
  exact head1_computes_nand_attnUpdate

/-- The 0-head model computes the constantly-false function. -/
theorem false_computable_with_zero_heads :
    computableWithHeads falseFn 0 := by
  refine ⟨1, (Fin.elim0 : TwoBitHeadFamily 1 0), ?_⟩
  refine ⟨0, 0, ?_⟩
  intro bits
  simp [falseFn, headFamilyAttnUpdate]

/-- The 0-head model also computes the constantly-true function. -/
theorem true_computable_with_zero_heads :
    computableWithHeads trueFn 0 := by
  refine ⟨1, (Fin.elim0 : TwoBitHeadFamily 1 0), ?_⟩
  refine ⟨0, -1, ?_⟩
  intro bits
  simp [trueFn, headFamilyAttnUpdate]

/-- A single head suffices to compute `OR` in the query residual. -/
theorem or_computable_with_one_head :
    ∃ H : Head 2 3, computesBool orFn H.residual := by
  exact ⟨head1, head1_computes_or_residual⟩

/-- A single head suffices to compute `AND` in the query residual. -/
theorem and_computable_with_one_head :
    ∃ H : Head 2 3, computesBool andFn H.residual := by
  exact ⟨head1, head1_computes_and_residual⟩

/-- A single head suffices to compute `NOR` in the query residual. -/
theorem nor_computable_with_one_head :
    ∃ H : Head 2 3, computesBool norFn H.residual := by
  exact ⟨head1, head1_computes_nor_residual⟩

/-- A single head suffices to compute `NAND` in the query residual. -/
theorem nand_computable_with_one_head :
    ∃ H : Head 2 3, computesBool nandFn H.residual := by
  exact ⟨head1, head1_computes_nand_residual⟩

private theorem one_head_count_of_attnUpdate
    {f : (Fin 2 → Bool) → Bool} {H : Head 2 3}
    (h : computesBool f H.attnUpdate) : computableWithHeads f 1 := by
  refine ⟨3, (fun _ => H), ?_⟩
  rcases h with ⟨w, τ, hw⟩
  refine ⟨w, τ, ?_⟩
  intro bits
  simpa [computesBool, headFamilyAttnUpdate] using hw bits

/-- `OR` is computable with one head in the uniform multi-head model. -/
theorem or_computable_with_one_head_count :
    computableWithHeads orFn 1 :=
  one_head_count_of_attnUpdate head1_computes_or_attnUpdate

/-- `AND` is computable with one head in the uniform multi-head model. -/
theorem and_computable_with_one_head_count :
    computableWithHeads andFn 1 :=
  one_head_count_of_attnUpdate head1_computes_and_attnUpdate

/-- `NOR` is computable with one head in the uniform multi-head model. -/
theorem nor_computable_with_one_head_count :
    computableWithHeads norFn 1 :=
  one_head_count_of_attnUpdate head1_computes_nor_attnUpdate

/-- `NAND` is computable with one head in the uniform multi-head model. -/
theorem nand_computable_with_one_head_count :
    computableWithHeads nandFn 1 :=
  one_head_count_of_attnUpdate head1_computes_nand_attnUpdate

/-- A `0`-head model has constant output, so it cannot realize a target that is
false on one input and true on another. -/
theorem not_computableWithHeads_zero_of_false_true
    (f : (Fin 2 → Bool) → Bool) (bitsFalse bitsTrue : Fin 2 → Bool)
    (hFalse : f bitsFalse = false) (hTrue : f bitsTrue = true) :
    ¬ computableWithHeads f 0 :=
  not_computableWithHeadsN_zero_of_false_true f bitsFalse bitsTrue hFalse hTrue

/-- `OR` is not computable with zero heads. -/
theorem or_not_computable_with_zero_heads :
    ¬ computableWithHeads orFn 0 := by
  exact not_computableWithHeads_zero_of_false_true orFn
    (bits2 false false) (bits2 false true) rfl rfl

/-- `AND` is not computable with zero heads. -/
theorem and_not_computable_with_zero_heads :
    ¬ computableWithHeads andFn 0 := by
  exact not_computableWithHeads_zero_of_false_true andFn
    (bits2 false false) (bits2 true true) rfl rfl

/-- `NOR` is not computable with zero heads. -/
theorem nor_not_computable_with_zero_heads :
    ¬ computableWithHeads norFn 0 := by
  exact not_computableWithHeads_zero_of_false_true norFn
    (bits2 false true) (bits2 false false) rfl rfl

/-- `NAND` is not computable with zero heads. -/
theorem nand_not_computable_with_zero_heads :
    ¬ computableWithHeads nandFn 0 := by
  exact not_computableWithHeads_zero_of_false_true nandFn
    (bits2 true true) (bits2 false false) rfl rfl

/-- No single head computes `XOR` in this model. -/
theorem xor_not_computable_with_one_head :
    ¬ ∃ (d : ℕ) (H : Head 2 d), computesBool xorFn H.residual := by
  rintro ⟨d, H, hH⟩
  exact one_head_cannot_xor_residual H (by simpa [computesXor, computesBool] using hH)

/-- General one-head lower bound for checkerboard truth tables. -/
theorem checkerboard_not_computable_with_one_head_attnUpdate
    {d : ℕ} (H : Head 2 d) (f : (Fin 2 → Bool) → Bool) (c : Bool)
    (h00 : f (bits2 false false) = c)
    (h11 : f (bits2 true true) = c)
    (h01 : f (bits2 false true) = !c)
    (h10 : f (bits2 true false) = !c) :
    ¬ computesBool f H.attnUpdate := by
  intro hComp
  have hCompN : computableWithHeadsN 2 1 f := by
    refine ⟨d, fun _ => H, ?_⟩
    rcases hComp with ⟨w, τ, hw⟩
    refine ⟨w, τ, ?_⟩
    intro bits
    simpa [computesBool, headFamilyAttnUpdate] using hw bits
  have h00N : f (Head.restrictBits (fun _ => false) 0 1 (false, false)) = c := by
    simpa [restrictBits_zero_one] using h00
  have h11N : f (Head.restrictBits (fun _ => false) 0 1 (true, true)) = c := by
    simpa [restrictBits_zero_one] using h11
  have h01N : f (Head.restrictBits (fun _ => false) 0 1 (false, true)) = !c := by
    simpa [restrictBits_zero_one] using h01
  have h10N : f (Head.restrictBits (fun _ => false) 0 1 (true, false)) = !c := by
    simpa [restrictBits_zero_one] using h10
  exact (checkerboard_restriction_not_computable_with_one_head
    f (fun _ => false) 0 1 (by decide) c h00N h11N h01N h10N) hCompN

/-- Residual-form checkerboard lower bound. -/
theorem checkerboard_not_computable_with_one_head_residual
    {d : ℕ} (H : Head 2 d) (f : (Fin 2 → Bool) → Bool) (c : Bool)
    (h00 : f (bits2 false false) = c)
    (h11 : f (bits2 true true) = c)
    (h01 : f (bits2 false true) = !c)
    (h10 : f (bits2 true false) = !c) :
    ¬ computesBool f H.residual := by
  rw [computesBool_residual_iff_attnUpdate]
  exact checkerboard_not_computable_with_one_head_attnUpdate H f c h00 h11 h01 h10

/-- `XOR` is not computable with zero heads. -/
theorem xor_not_computable_with_zero_heads :
    ¬ computableWithHeads xorFn 0 := by
  exact not_computableWithHeads_zero_of_false_true xorFn
    (bits2 false false) (bits2 false true) rfl rfl

/-- `XOR` is not computable with a single head in the uniform multi-head model. -/
theorem xor_not_computable_with_one_head_count :
    ¬ computableWithHeads xorFn 1 := by
  rintro ⟨d, Hs, hH⟩
  have hSingle : computesBool xorFn (twoBitHeadFamilyAttnUpdate Hs) := hH
  rw [show twoBitHeadFamilyAttnUpdate Hs = (Hs 0).attnUpdate by
    funext bits
    simp [twoBitHeadFamilyAttnUpdate]] at hSingle
  exact one_head_cannot_xor_attnUpdate (Hs 0)
    (by simpa [computesXor, computesBool] using hSingle)

/-- Two heads suffice to compute `XOR`. -/
theorem xor_computable_with_two_heads :
    computesBool xorFn (twoHeadUpdate : (Fin 2 → Bool) → Vec 3) := by
  simpa [computesXor, computesBool] using two_heads_suffice

/-- Negating the two-head probe separates `XNOR`. -/
theorem xnor_computable_with_two_heads :
    computesBool xnorFn (twoHeadUpdate : (Fin 2 → Bool) → Vec 3) := by
  let lo : ℝ := twoHeadLowScore
  let hi : ℝ := twoHeadHighScore
  let τ : ℝ := -((lo + hi) / 2)
  have hgap : lo < hi := by
    dsimp [lo, hi]
    exact xor_gap
  refine ⟨-twoProbe, τ, ?_⟩
  intro bits
  unfold twoProbe
  rw [inner_neg_left, probe_score]
  by_cases hx : xorFn bits = true
  · rw [hx]
    have hnot : ¬ -hi > τ := by
      dsimp [τ]
      linarith
    simp [xnorFn, hx, hi, hnot]
  · have hfalse : xorFn bits = false := by
      cases h : xorFn bits
      · rfl
      · exact False.elim (hx h)
    rw [hfalse]
    have hgt : -lo > τ := by
      dsimp [τ]
      linarith
    simp [xnorFn, hfalse, lo, hgt]

/-- A concrete 2-head family realizing the existing XOR construction. -/
noncomputable def xorTwoHeadFamily : TwoBitHeadFamily 3 2
  | 0 => head0
  | 1 => head1

theorem xorTwoHeadFamily_attnUpdate (bits : Fin 2 → Bool) :
    twoBitHeadFamilyAttnUpdate xorTwoHeadFamily bits = twoHeadUpdate bits := by
  simp [twoBitHeadFamilyAttnUpdate, headFamilyAttnUpdate, xorTwoHeadFamily,
    twoHeadUpdate]

/-- `XOR` is computable with two heads in the uniform multi-head model. -/
theorem xor_computable_with_two_heads_count :
    computableWithHeads xorFn 2 := by
  refine ⟨3, xorTwoHeadFamily, ?_⟩
  rcases xor_computable_with_two_heads with ⟨w, τ, hw⟩
  refine ⟨w, τ, ?_⟩
  intro bits
  have hupdate : headFamilyAttnUpdate xorTwoHeadFamily bits = twoHeadUpdate bits := by
    simpa [twoBitHeadFamilyAttnUpdate] using xorTwoHeadFamily_attnUpdate bits
  rw [hupdate]
  exact hw bits

/-- `XNOR` is not computable with one head. -/
theorem xnor_not_computable_with_one_head_count :
    ¬ computableWithHeads xnorFn 1 := by
  rintro ⟨d, Hs, hH⟩
  have hSingle : computesBool xnorFn (twoBitHeadFamilyAttnUpdate Hs) := hH
  rw [show twoBitHeadFamilyAttnUpdate Hs = (Hs 0).attnUpdate by
    funext bits
    simp [twoBitHeadFamilyAttnUpdate]] at hSingle
  exact (checkerboard_not_computable_with_one_head_attnUpdate
    (Hs 0) xnorFn true rfl rfl rfl rfl) hSingle

/-- `XNOR` is computable with two heads. -/
theorem xnor_computable_with_two_heads_count :
    computableWithHeads xnorFn 2 := by
  refine ⟨3, xorTwoHeadFamily, ?_⟩
  rcases xnor_computable_with_two_heads with ⟨w, τ, hw⟩
  refine ⟨w, τ, ?_⟩
  intro bits
  have hupdate : headFamilyAttnUpdate xorTwoHeadFamily bits = twoHeadUpdate bits := by
    simpa [twoBitHeadFamilyAttnUpdate] using xorTwoHeadFamily_attnUpdate bits
  rw [hupdate]
  exact hw bits

/-- Exact head complexity of `OR` in the current formalization. -/
theorem exactHeadComplexity_or :
    exactHeadComplexity orFn 1 := by
  constructor
  · exact or_computable_with_one_head_count
  · intro h hk
    have : h = 0 := by omega
    subst this
    exact or_not_computable_with_zero_heads

/-- Exact head complexity of `AND` in the current formalization. -/
theorem exactHeadComplexity_and :
    exactHeadComplexity andFn 1 := by
  constructor
  · exact and_computable_with_one_head_count
  · intro h hk
    have : h = 0 := by omega
    subst this
    exact and_not_computable_with_zero_heads

/-- Exact head complexity of `XOR` in the current formalization. -/
theorem exactHeadComplexity_xor :
    exactHeadComplexity xorFn 2 := by
  constructor
  · exact xor_computable_with_two_heads_count
  · intro h hk
    have hCases : h = 0 ∨ h = 1 := by omega
    rcases hCases with h0 | h1
    · subst h0
      exact xor_not_computable_with_zero_heads
    · subst h1
      exact xor_not_computable_with_one_head_count

/-- Exact head complexity of the constantly-false function. -/
theorem exactHeadComplexity_false :
    exactHeadComplexity falseFn 0 := by
  constructor
  · exact false_computable_with_zero_heads
  · intro h hh
    omega

/-- Exact head complexity of the constantly-true function. -/
theorem exactHeadComplexity_true :
    exactHeadComplexity trueFn 0 := by
  constructor
  · exact true_computable_with_zero_heads
  · intro h hh
    omega

/-- Exact head complexity of `NOR`. -/
theorem exactHeadComplexity_nor :
    exactHeadComplexity norFn 1 := by
  constructor
  · exact nor_computable_with_one_head_count
  · intro h hk
    have : h = 0 := by omega
    subst this
    exact nor_not_computable_with_zero_heads

/-- Exact head complexity of `NAND`. -/
theorem exactHeadComplexity_nand :
    exactHeadComplexity nandFn 1 := by
  constructor
  · exact nand_computable_with_one_head_count
  · intro h hk
    have : h = 0 := by omega
    subst this
    exact nand_not_computable_with_zero_heads

/-- Exact head complexity of `XNOR`. -/
theorem exactHeadComplexity_xnor :
    exactHeadComplexity xnorFn 2 := by
  constructor
  · exact xnor_computable_with_two_heads_count
  · intro h hk
    have hCases : h = 0 ∨ h = 1 := by omega
    rcases hCases with h0 | h1
    · subst h0
      exact not_computableWithHeads_zero_of_false_true xnorFn
        (bits2 false true) (bits2 false false) rfl rfl
    · subst h1
      exact xnor_not_computable_with_one_head_count

theorem HStar_false : HStar2 falseFn = 0 := HStar_eq_of_exact exactHeadComplexity_false
theorem HStar_true : HStar2 trueFn = 0 := HStar_eq_of_exact exactHeadComplexity_true
theorem HStar_or : HStar2 orFn = 1 := HStar_eq_of_exact exactHeadComplexity_or
theorem HStar_and : HStar2 andFn = 1 := HStar_eq_of_exact exactHeadComplexity_and
theorem HStar_nor : HStar2 norFn = 1 := HStar_eq_of_exact exactHeadComplexity_nor
theorem HStar_nand : HStar2 nandFn = 1 := HStar_eq_of_exact exactHeadComplexity_nand
theorem HStar_xor : HStar2 xorFn = 2 := HStar_eq_of_exact exactHeadComplexity_xor
theorem HStar_xnor : HStar2 xnorFn = 2 := HStar_eq_of_exact exactHeadComplexity_xnor

private theorem funext_two_bit
    {f g : (Fin 2 → Bool) → Bool}
    (h : ∀ a b, f (bits2 a b) = g (bits2 a b)) : f = g := by
  funext bits
  have hbits : bits = bits2 (bits 0) (bits 1) := by
    funext i
    fin_cases i <;> rfl
  rw [hbits]
  exact h (bits 0) (bits 1)

private theorem ext_by_cases
    {f g : (Fin 2 → Bool) → Bool}
    (hff : f (bits2 false false) = g (bits2 false false))
    (hft : f (bits2 false true) = g (bits2 false true))
    (htf : f (bits2 true false) = g (bits2 true false))
    (htt : f (bits2 true true) = g (bits2 true true)) : f = g := by
  apply funext_two_bit
  intro a b
  cases a <;> cases b <;> assumption

/-- Classification of all symmetric 2-bit Boolean functions by exact head
complexity. -/
theorem exactHeadComplexity_symmFn (c0 c1 c2 : Bool) :
    exactHeadComplexity (symmFn c0 c1 c2)
      (if c0 = c1 then if c1 = c2 then 0 else 1 else if c0 = c2 then 2 else 1) := by
  cases c0 <;> cases c1 <;> cases c2 <;>
    simp only [Bool.false_eq_true, Bool.true_eq_false, ↓reduceIte]
  · have hs : symmFn false false false = falseFn := by
      apply ext_by_cases <;> rfl
    rw [hs]
    exact exactHeadComplexity_false
  · have hs : symmFn false false true = andFn := by
      apply ext_by_cases <;> rfl
    rw [hs]
    exact exactHeadComplexity_and
  · have hs : symmFn false true false = xorFn := by
      apply ext_by_cases <;> rfl
    rw [hs]
    exact exactHeadComplexity_xor
  · have hs : symmFn false true true = orFn := by
      apply ext_by_cases <;> rfl
    rw [hs]
    exact exactHeadComplexity_or
  · have hs : symmFn true false false = norFn := by
      apply ext_by_cases <;> rfl
    rw [hs]
    exact exactHeadComplexity_nor
  · have hs : symmFn true false true = xnorFn := by
      apply ext_by_cases <;> rfl
    rw [hs]
    exact exactHeadComplexity_xnor
  · have hs : symmFn true true false = nandFn := by
      apply ext_by_cases <;> rfl
    rw [hs]
    exact exactHeadComplexity_nand
  · have hs : symmFn true true true = trueFn := by
      apply ext_by_cases <;> rfl
    rw [hs]
    exact exactHeadComplexity_true

/-- Equivalent explicit `HStar` classification for the symmetric 2-bit family. -/
theorem HStar_symmFn (c0 c1 c2 : Bool) :
    HStar2 (symmFn c0 c1 c2)
      = (if c0 = c1 then if c1 = c2 then 0 else 1 else if c0 = c2 then 2 else 1) := by
  have := exactHeadComplexity_symmFn c0 c1 c2
  exact HStar_eq_of_exact this

end HeadComplexity
