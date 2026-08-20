import HeadComplexity.Foundation.Softmax
import HeadComplexity.Foundation.SegmentCrossing

set_option linter.style.header false

/-!
# Generalized `n`-bit one-layer attention model.

This file lifts the 2-bit XOR setup to inputs `Fin n → Bool` with a
dedicated query token. It also proves a reusable checkerboard
restriction theorem: if, after fixing all but two coordinates, a target
function exhibits the 2-bit checkerboard pattern, then one head cannot
compute it. As a first application, `n`-bit parity requires at least two
heads whenever `n ≥ 2`.
-/

namespace HeadComplexity

open scoped InnerProductSpace

/-- Generic linear-readout computability over an arbitrary finite input
    domain. -/
def computesPred {α : Type*} (f : α → Bool) (g : α → Vec d) : Prop :=
  ∃ (w : Vec d) (τ : ℝ), ∀ a : α, ⟪w, g a⟫_ℝ > τ ↔ f a = true

/-- The real-inner-product map `inner w : Vec d → ℝ` packaged as a
linear functional so it can be passed to segment-separation theorems. -/
noncomputable def innerLeftLin {d : ℕ} (w : Vec d) : Vec d →ₗ[ℝ] ℝ where
  toFun v := ⟪w, v⟫_ℝ
  map_add' x y := inner_add_right w x y
  map_smul' c x := by
    simp [inner_smul_right, smul_eq_mul]

@[simp] theorem innerLeftLin_apply {d : ℕ} (w v : Vec d) :
    innerLeftLin w v = ⟪w, v⟫_ℝ := rfl

/-- Sequence positions for the `n`-bit generalized model: `some i` is an
    input-bit position and `none` is the dedicated query token. -/
abbrev SeqPos (n : ℕ) := Option (Fin n)

/-- Parameters of a single attention head over `n` input bits plus a
    query token. -/
structure Head (n d : ℕ) where
  tokenEmbed : Fin 3 → Vec d
  posEmbed   : SeqPos n → Vec d
  WQ : Vec d →ₗ[ℝ] Vec d
  WK : Vec d →ₗ[ℝ] Vec d
  WV : Vec d →ₗ[ℝ] Vec d

namespace Head

variable {n d : ℕ}

/-- Token IDs on a generalized input: each bit position holds token `0`
    or `1`, and the query position holds token `=`. -/
def seqTok (bits : Fin n → Bool) : SeqPos n → Fin 3
  | some i => cond (bits i) 1 0
  | none => 2

/-- Embedded vector at a sequence position. -/
noncomputable def x (H : Head n d) (bits : Fin n → Bool) (p : SeqPos n) : Vec d :=
  H.tokenEmbed (seqTok bits p) + H.posEmbed p

/-- Unnormalized attention weights to the query token. -/
noncomputable def sigma (H : Head n d) (bits : Fin n → Bool) (p : SeqPos n) : ℝ :=
  Real.exp ⟪H.WK (H.x bits p), H.WQ (H.x bits none)⟫_ℝ

/-- Value vector at position `p`. -/
noncomputable def value (H : Head n d) (bits : Fin n → Bool) (p : SeqPos n) : Vec d :=
  H.WV (H.x bits p)

/-- Attention numerator at the query token. -/
noncomputable def numerator (H : Head n d) (bits : Fin n → Bool) : Vec d :=
  ∑ p, H.sigma bits p • H.value bits p

/-- Attention denominator at the query token. -/
noncomputable def denominator (H : Head n d) (bits : Fin n → Bool) : ℝ :=
  ∑ p, H.sigma bits p

/-- One-head attention update at the query token. -/
noncomputable def attnUpdate (H : Head n d) (bits : Fin n → Bool) : Vec d :=
  (H.denominator bits)⁻¹ • H.numerator bits

/-- Full residual stream at the query token. -/
noncomputable def residual (H : Head n d) (bits : Fin n → Bool) : Vec d :=
  H.x bits none + H.attnUpdate bits

theorem sigma_pos (H : Head n d) (bits : Fin n → Bool) (p : SeqPos n) :
    0 < H.sigma bits p :=
  Real.exp_pos _

theorem denominator_pos (H : Head n d) (bits : Fin n → Bool) :
    0 < H.denominator bits := by
  unfold denominator
  exact positiveNormalizer_pos (H.sigma bits) (fun p => H.sigma_pos bits p)

theorem denominator_ne_zero (H : Head n d) (bits : Fin n → Bool) :
    H.denominator bits ≠ 0 :=
  (H.denominator_pos bits).ne'

theorem denom_smul_attn (H : Head n d) (bits : Fin n → Bool) :
    H.denominator bits • H.attnUpdate bits = H.numerator bits := by
  unfold attnUpdate
  rw [smul_inv_smul₀ (H.denominator_ne_zero bits)]

/-- Restrict an `n`-bit input to a 2-dimensional affine subcube by
    varying coordinates `i` and `j` and keeping the remaining bits fixed
    by `base`. -/
def restrictBits (base : Fin n → Bool) (i j : Fin n) (ab : Bool × Bool) :
    Fin n → Bool :=
  fun k => if k = i then ab.1 else if k = j then ab.2 else base k

/-- The restricted attention-update map on the chosen 2-bit subcube. -/
noncomputable def restrictedUpdate
    (H : Head n d) (base : Fin n → Bool) (i j : Fin n) :
    Bool × Bool → Vec d :=
  fun ab => H.attnUpdate (restrictBits base i j ab)

private theorem restrict_term_antipode
    (H : Head n d) (base : Fin n → Bool) (i j : Fin n) (hij : i ≠ j)
    (p : SeqPos n) :
    H.sigma (restrictBits base i j (false, false)) p •
        H.value (restrictBits base i j (false, false)) p
      + H.sigma (restrictBits base i j (true, true)) p •
        H.value (restrictBits base i j (true, true)) p
      =
    H.sigma (restrictBits base i j (false, true)) p •
        H.value (restrictBits base i j (false, true)) p
      + H.sigma (restrictBits base i j (true, false)) p •
        H.value (restrictBits base i j (true, false)) p := by
  cases p with
  | none =>
      simp [sigma, value, x, seqTok]
  | some k =>
      by_cases hk : k = i
      · subst hk
        simp [sigma, value, x, seqTok, restrictBits]
      · by_cases hj : k = j
        · subst hj
          simp [sigma, value, x, seqTok, restrictBits, hk]
          abel
        · simp [sigma, value, x, seqTok, restrictBits, hk, hj]

private theorem restrict_sigma_antipode
    (H : Head n d) (base : Fin n → Bool) (i j : Fin n) (hij : i ≠ j)
    (p : SeqPos n) :
    H.sigma (restrictBits base i j (false, false)) p
      + H.sigma (restrictBits base i j (true, true)) p
      =
    H.sigma (restrictBits base i j (false, true)) p
      + H.sigma (restrictBits base i j (true, false)) p := by
  cases p with
  | none =>
      simp [sigma, x, seqTok]
  | some k =>
      by_cases hk : k = i
      · subst hk
        simp [sigma, x, seqTok, restrictBits]
      · by_cases hj : k = j
        · subst hj
          simp [sigma, x, seqTok, restrictBits, hk]
          ring
        · simp [sigma, x, seqTok, restrictBits, hk, hj]

theorem restricted_numerator_antipode
    (H : Head n d) (base : Fin n → Bool) (i j : Fin n) (hij : i ≠ j) :
    H.numerator (restrictBits base i j (false, false))
      + H.numerator (restrictBits base i j (true, true))
      =
    H.numerator (restrictBits base i j (false, true))
      + H.numerator (restrictBits base i j (true, false)) := by
  have hsum := congrArg (fun u : SeqPos n → Vec d => ∑ p, u p)
    (funext (restrict_term_antipode H base i j hij))
  simpa [numerator, Finset.sum_add_distrib] using hsum

theorem restricted_denominator_antipode
    (H : Head n d) (base : Fin n → Bool) (i j : Fin n) (hij : i ≠ j) :
    H.denominator (restrictBits base i j (false, false))
      + H.denominator (restrictBits base i j (true, true))
      =
    H.denominator (restrictBits base i j (false, true))
      + H.denominator (restrictBits base i j (true, false)) := by
  have hsum := congrArg (fun u : SeqPos n → ℝ => ∑ p, u p)
    (funext (restrict_sigma_antipode H base i j hij))
  simpa [denominator, Finset.sum_add_distrib] using hsum

/-- The intersection point of the diagonal and off-diagonal segments on
    a 2-bit restriction. -/
noncomputable def restrictedMidpoint
    (H : Head n d) (base : Fin n → Bool) (i j : Fin n) : Vec d :=
  (H.denominator (restrictBits base i j (false, false))
      + H.denominator (restrictBits base i j (true, true)))⁻¹ •
    (H.numerator (restrictBits base i j (false, false))
      + H.numerator (restrictBits base i j (true, true)))

theorem restricted_midpoint_in_diag_segment
    (H : Head n d) (base : Fin n → Bool) (i j : Fin n) :
    H.restrictedMidpoint base i j
      ∈ segment ℝ (H.restrictedUpdate base i j (false, false))
          (H.restrictedUpdate base i j (true, true)) := by
  set D0 := H.denominator (restrictBits base i j (false, false))
  set D1 := H.denominator (restrictBits base i j (true, true))
  have hpos : (0 : ℝ) < D0 + D1 := add_pos (H.denominator_pos _) (H.denominator_pos _)
  refine ⟨D0 / (D0 + D1), D1 / (D0 + D1), ?_, ?_, ?_, ?_⟩
  · exact div_nonneg (H.denominator_pos _).le hpos.le
  · exact div_nonneg (H.denominator_pos _).le hpos.le
  · rw [← add_div, div_self hpos.ne']
  · unfold restrictedMidpoint restrictedUpdate
    rw [← H.denom_smul_attn (restrictBits base i j (false, false)),
        ← H.denom_smul_attn (restrictBits base i j (true, true))]
    exact twoTermWeightedAverage_eq_inv_smul_sum _ _ _ _

theorem restricted_midpoint_in_offdiag_segment
    (H : Head n d) (base : Fin n → Bool) (i j : Fin n) (hij : i ≠ j) :
    H.restrictedMidpoint base i j
      ∈ segment ℝ (H.restrictedUpdate base i j (false, true))
          (H.restrictedUpdate base i j (true, false)) := by
  set D0 := H.denominator (restrictBits base i j (false, true))
  set D1 := H.denominator (restrictBits base i j (true, false))
  have hpos : (0 : ℝ) < D0 + D1 := add_pos (H.denominator_pos _) (H.denominator_pos _)
  refine ⟨D0 / (D0 + D1), D1 / (D0 + D1), ?_, ?_, ?_, ?_⟩
  · exact div_nonneg (H.denominator_pos _).le hpos.le
  · exact div_nonneg (H.denominator_pos _).le hpos.le
  · rw [← add_div, div_self hpos.ne']
  · unfold restrictedMidpoint restrictedUpdate
    rw [H.restricted_numerator_antipode base i j hij,
        H.restricted_denominator_antipode base i j hij,
        ← H.denom_smul_attn (restrictBits base i j (false, true)),
        ← H.denom_smul_attn (restrictBits base i j (true, false))]
    exact twoTermWeightedAverage_eq_inv_smul_sum _ _ _ _

/-- The restricted 2-bit attention map of a single head can
    never realize the checkerboard pattern. -/
theorem checkerboard_not_computable_on_restriction
    (H : Head n d) (base : Fin n → Bool) (i j : Fin n) (hij : i ≠ j)
    (f : Bool × Bool → Bool) (c : Bool)
    (h00 : f (false, false) = c)
    (h11 : f (true, true) = c)
    (h01 : f (false, true) = !c)
    (h10 : f (true, false) = !c) :
    ¬ computesPred f (H.restrictedUpdate base i j) := by
  rintro ⟨w, τ, hw⟩
  cases c
  · have h00' : ⟪w, H.restrictedUpdate base i j (false, false)⟫_ℝ ≤ τ := by
      by_contra h
      have hfalse : f (false, false) = false := by simpa using h00
      exact Bool.false_ne_true (hfalse.symm.trans ((hw (false, false)).mp (lt_of_not_ge h)))
    have h11' : ⟪w, H.restrictedUpdate base i j (true, true)⟫_ℝ ≤ τ := by
      by_contra h
      have hfalse : f (true, true) = false := by simpa using h11
      exact Bool.false_ne_true (hfalse.symm.trans ((hw (true, true)).mp (lt_of_not_ge h)))
    have h01' : τ < ⟪w, H.restrictedUpdate base i j (false, true)⟫_ℝ := by
      have htrue : f (false, true) = true := by simpa using h01
      exact (hw (false, true)).mpr htrue
    have h10' : τ < ⟪w, H.restrictedUpdate base i j (true, false)⟫_ℝ := by
      have htrue : f (true, false) = true := by simpa using h10
      exact (hw (true, false)).mpr htrue
    exact segment_cross_not_separable (innerLeftLin w) h00' h11' h01' h10'
      (H.restricted_midpoint_in_diag_segment base i j)
      (H.restricted_midpoint_in_offdiag_segment base i j hij)
  · have h01' : ⟪w, H.restrictedUpdate base i j (false, true)⟫_ℝ ≤ τ := by
      by_contra h
      have hfalse : f (false, true) = false := by simpa using h01
      exact Bool.false_ne_true (hfalse.symm.trans ((hw (false, true)).mp (lt_of_not_ge h)))
    have h10' : ⟪w, H.restrictedUpdate base i j (true, false)⟫_ℝ ≤ τ := by
      by_contra h
      have hfalse : f (true, false) = false := by simpa using h10
      exact Bool.false_ne_true (hfalse.symm.trans ((hw (true, false)).mp (lt_of_not_ge h)))
    have h00' : τ < ⟪w, H.restrictedUpdate base i j (false, false)⟫_ℝ := by
      have htrue : f (false, false) = true := by simpa using h00
      exact (hw (false, false)).mpr htrue
    have h11' : τ < ⟪w, H.restrictedUpdate base i j (true, true)⟫_ℝ := by
      have htrue : f (true, true) = true := by simpa using h11
      exact (hw (true, true)).mpr htrue
    exact segment_cross_not_separable (innerLeftLin w) h01' h10' h00' h11'
      (H.restricted_midpoint_in_offdiag_segment base i j hij)
      (H.restricted_midpoint_in_diag_segment base i j)

end Head

/-- A family of `H` heads over `n` input bits. -/
abbrev HeadFamily (n d H : ℕ) : Type := Fin H → Head n d

/-- Summed multi-head attention update for the generalized model. -/
noncomputable def headFamilyAttnUpdate {n d H : ℕ} (Hs : HeadFamily n d H) :
    (Fin n → Bool) → Vec d :=
  fun bits => ∑ h, (Hs h).attnUpdate bits

/-- `n`-bit head computability with `H` heads. -/
def computableWithHeadsN (n H : ℕ) (f : (Fin n → Bool) → Bool) : Prop :=
  ∃ d, ∃ Hs : HeadFamily n d H, computesPred f (headFamilyAttnUpdate Hs)

/-- Exact head complexity in the generalized `n`-bit model. -/
def exactHeadComplexityN (n : ℕ) (f : (Fin n → Bool) → Bool) (k : ℕ) : Prop :=
  computableWithHeadsN n k f ∧ ∀ h < k, ¬ computableWithHeadsN n h f

/-- Head complexity on `n`-bit Boolean functions. -/
noncomputable def HStar (n : ℕ) (f : (Fin n → Bool) → Bool) : ℕ :=
  by
    classical
    exact if h : ∃ k, computableWithHeadsN n k f then Nat.find h else 0

@[simp] theorem headFamilyAttnUpdate_zero {n d : ℕ} {Hs : HeadFamily n d 0}
    (bits : Fin n → Bool) : headFamilyAttnUpdate Hs bits = 0 := by
  simp [headFamilyAttnUpdate]

@[simp] theorem headFamilyAttnUpdate_one {n d : ℕ} {Hs : HeadFamily n d 1}
    (bits : Fin n → Bool) : headFamilyAttnUpdate Hs bits = (Hs 0).attnUpdate bits := by
  simp [headFamilyAttnUpdate]

theorem HStar_eq_of_exact {n k : ℕ} {f : (Fin n → Bool) → Bool}
    (hk : exactHeadComplexityN n f k) : HStar n f = k := by
  classical
  unfold HStar
  split_ifs with hExists
  · apply le_antisymm
    · exact Nat.find_min' hExists hk.1
    · by_contra hlt
      exact (hk.2 (Nat.find hExists) (Nat.lt_of_not_ge hlt)) (Nat.find_spec hExists)
  · exfalso
    exact hExists ⟨k, hk.1⟩

theorem not_computableWithHeadsN_zero_of_false_true
    {n : ℕ} (f : (Fin n → Bool) → Bool) (bitsFalse bitsTrue : Fin n → Bool)
    (hFalse : f bitsFalse = false) (hTrue : f bitsTrue = true) :
    ¬ computableWithHeadsN n 0 f := by
  rintro ⟨d, Hs, w, τ, h⟩
  have h0 : (0 : ℝ) > τ ↔ f bitsFalse = true := by
    simpa [headFamilyAttnUpdate] using (h bitsFalse)
  have h1 : (0 : ℝ) > τ ↔ f bitsTrue = true := by
    simpa [headFamilyAttnUpdate] using (h bitsTrue)
  have hs : f bitsFalse = true ↔ f bitsTrue = true := h0.symm.trans h1
  have hF : f bitsFalse = true := hs.mpr hTrue
  exact Bool.false_ne_true (hFalse.symm.trans hF)

def firstIndex {n : ℕ} (hn : 2 ≤ n) : Fin n :=
  ⟨0, Nat.lt_of_lt_of_le (by decide : 0 < 2) hn⟩

def secondIndex {n : ℕ} (hn : 2 ≤ n) : Fin n :=
  ⟨1, by omega⟩

/-- A reusable checkerboard restriction lower bound: if an `n`-bit
    target contains a 2-coordinate checkerboard restriction, one head is
    impossible. -/
theorem checkerboard_restriction_not_computable_with_one_head
    {n : ℕ} (f : (Fin n → Bool) → Bool) (base : Fin n → Bool)
    (i j : Fin n) (hij : i ≠ j) (c : Bool)
    (h00 : f (Head.restrictBits base i j (false, false)) = c)
    (h11 : f (Head.restrictBits base i j (true, true)) = c)
    (h01 : f (Head.restrictBits base i j (false, true)) = !c)
    (h10 : f (Head.restrictBits base i j (true, false)) = !c) :
    ¬ computableWithHeadsN n 1 f := by
  rintro ⟨d, Hs, hH⟩
  let gBool : Bool × Bool → Bool := fun ab => f (Head.restrictBits base i j ab)
  have hg : computesPred gBool ((Hs 0).restrictedUpdate base i j) := by
    rcases hH with ⟨w, τ, hw⟩
    refine ⟨w, τ, ?_⟩
    intro ab
    simpa [gBool, Head.restrictedUpdate, headFamilyAttnUpdate]
      using hw (Head.restrictBits base i j ab)
  exact (Head.checkerboard_not_computable_on_restriction (Hs 0) base i j hij gBool c
    h00 h11 h01 h10) hg

/-- A named corollary for the parity-pattern case: any function whose
    restriction to two coordinates has the XOR checkerboard pattern
    requires at least two heads. -/
theorem parity_restriction_not_computable_with_one_head
    {n : ℕ} (f : (Fin n → Bool) → Bool) (base : Fin n → Bool)
    (i j : Fin n) (hij : i ≠ j)
    (h00 : f (Head.restrictBits base i j (false, false)) = false)
    (h11 : f (Head.restrictBits base i j (true, true)) = false)
    (h01 : f (Head.restrictBits base i j (false, true)) = true)
    (h10 : f (Head.restrictBits base i j (true, false)) = true) :
    ¬ computableWithHeadsN n 1 f := by
  exact checkerboard_restriction_not_computable_with_one_head
    f base i j hij false h00 h11 h01 h10

theorem parity_restriction_exactHeadComplexity_ge_two
    {n k : ℕ} (f : (Fin n → Bool) → Bool) (base : Fin n → Bool)
    (i j : Fin n) (hij : i ≠ j)
    (h00 : f (Head.restrictBits base i j (false, false)) = false)
    (h11 : f (Head.restrictBits base i j (true, true)) = false)
    (h01 : f (Head.restrictBits base i j (false, true)) = true)
    (h10 : f (Head.restrictBits base i j (true, false)) = true)
    (hk : exactHeadComplexityN n f k) :
    2 ≤ k := by
  have h0 : ¬ computableWithHeadsN n 0 f := by
    exact not_computableWithHeadsN_zero_of_false_true f
      (Head.restrictBits base i j (false, false))
      (Head.restrictBits base i j (false, true))
      h00 h01
  have h1 : ¬ computableWithHeadsN n 1 f := by
    exact parity_restriction_not_computable_with_one_head f base i j hij h00 h11 h01 h10
  by_contra hklt
  have hkCases : k = 0 ∨ k = 1 := by omega
  rcases hkCases with rfl | rfl
  · exact h0 hk.1
  · exact h1 hk.1

end HeadComplexity
