import HeadComplexity.Atoms.FracAtom
import HeadComplexity.Model.Head

set_option linter.style.header false

/-!
# Theorem 10 (one direction): every head's readout is a linear-fractional atom.

A single attention head's readout `⟪w, attnUpdate⟫` is exactly the value of a
one-head linear-fractional atom (`FracAtom`).  Summing over a family of heads and
transferring the sign condition gives

`fracComputable_of_computable :
  computableWithHeadsN n H f → fracComputable n H f`.

The construction `headToAtom` reads off the atom parameters from the head and the
readout vector `w`.  The query embedding `x none = tokenEmbed 2 + posEmbed none`
is independent of the input bits, so the atom's `γ`, `η` (which reference it) are
well defined.
-/

namespace HeadComplexity

open Finset Head
open scoped BigOperators InnerProductSpace

variable {n d : ℕ}

/-- The (bits-independent) query-side embedding `tokenEmbed 2 + posEmbed none`. -/
noncomputable def Head.queryVec (H : Head n d) : Vec d :=
  H.tokenEmbed 2 + H.posEmbed none

/-- The query vector after `W_Q`. -/
noncomputable def Head.queryQ (H : Head n d) : Vec d := H.WQ H.queryVec

theorem Head.x_none_eq_queryVec (H : Head n d) (bits : Fin n → Bool) :
    H.x bits none = H.queryVec := by
  simp [Head.x, Head.seqTok, Head.queryVec]

/-- The linear-fractional atom realized by head `H` under readout `w`. -/
noncomputable def headToAtom (H : Head n d) (w : Vec d) : FracAtom n where
  η := Real.exp ⟪H.WK H.queryVec, H.queryQ⟫_ℝ * ⟪w, H.WV H.queryVec⟫_ℝ
  δ := ⟪w, H.WV (H.tokenEmbed 1 - H.tokenEmbed 0)⟫_ℝ
  γ := Real.exp ⟪H.WK H.queryVec, H.queryQ⟫_ℝ
  α := Real.exp ⟪H.WK (H.tokenEmbed 1 - H.tokenEmbed 0), H.queryQ⟫_ℝ
  ρ := fun i => Real.exp ⟪H.WK (H.tokenEmbed 0 + H.posEmbed (some i)), H.queryQ⟫_ℝ
  m := fun i => ⟪w, H.WV (H.tokenEmbed 0 + H.posEmbed (some i))⟫_ℝ
  hγ := Real.exp_pos _
  hα := Real.exp_pos _
  hρ := fun _ => Real.exp_pos _

section
variable (H : Head n d) (w : Vec d) (bits : Fin n → Bool)

/-- `sigma` at the query token equals the atom's `γ`. -/
theorem sigma_none_eq_gamma : H.sigma bits none = (headToAtom H w).γ := by
  unfold Head.sigma headToAtom
  rw [H.x_none_eq_queryVec bits]
  rfl

/-- `sigma` at an input position factors as `ρ i * (if bits i then α else 1)`. -/
theorem sigma_some_eq_wt (i : Fin n) :
    H.sigma bits (some i) = (headToAtom H w).wt bits i := by
  unfold Head.sigma headToAtom FracAtom.wt
  have hx : H.x bits (some i)
      = H.tokenEmbed (cond (bits i) 1 0) + H.posEmbed (some i) := by
    simp [Head.x, Head.seqTok]
  rw [hx]
  have hq : H.WQ (H.x bits none) = H.queryQ := by
    rw [H.x_none_eq_queryVec bits]; rfl
  rw [hq]
  cases hbi : bits i with
  | false => simp
  | true =>
      simp only [cond_true, if_true]
      have hsplit : H.tokenEmbed 1 + H.posEmbed (some i)
          = (H.tokenEmbed 0 + H.posEmbed (some i)) + (H.tokenEmbed 1 - H.tokenEmbed 0) := by
        abel
      rw [hsplit, map_add, inner_add_left, Real.exp_add]

/-- The atom's `value` reading at the query token equals `⟪w, WV (x none)⟫`. -/
theorem value_none_eq :
    ⟪w, H.WV (H.x bits none)⟫_ℝ = ⟪w, H.WV H.queryVec⟫_ℝ := by
  rw [H.x_none_eq_queryVec bits]

/-- The `value` reading at an input position equals `m i + (if bits i then δ else 0)`. -/
theorem value_some_eq (i : Fin n) :
    ⟪w, H.WV (H.x bits (some i))⟫_ℝ
      = (headToAtom H w).m i + (if bits i then (headToAtom H w).δ else 0) := by
  unfold headToAtom
  have hx : H.x bits (some i)
      = H.tokenEmbed (cond (bits i) 1 0) + H.posEmbed (some i) := by
    simp [Head.x, Head.seqTok]
  rw [hx]
  cases hbi : bits i with
  | false => simp
  | true =>
      simp only [cond_true, if_true]
      have hsplit : H.tokenEmbed 1 + H.posEmbed (some i)
          = (H.tokenEmbed 0 + H.posEmbed (some i)) + (H.tokenEmbed 1 - H.tokenEmbed 0) := by
        abel
      rw [hsplit, map_add, inner_add_right]

/-- The denominator equals the atom's denominator `γ + ∑ i, wt`. -/
theorem denominator_eq_atom_denom :
    H.denominator bits = (headToAtom H w).γ + ∑ i, (headToAtom H w).wt bits i := by
  unfold Head.denominator
  rw [Fintype.sum_option]
  rw [sigma_none_eq_gamma H w bits]
  refine congrArg _ ?_
  exact Finset.sum_congr rfl (fun i _ => sigma_some_eq_wt H w bits i)

/-- Readout of the numerator equals the atom's numerator
`η + ∑ i, wt i * (m i + …)`. -/
theorem numerator_readout_eq :
    ⟪w, H.numerator bits⟫_ℝ
      = (headToAtom H w).η
        + ∑ i, (headToAtom H w).wt bits i
            * ((headToAtom H w).m i + (if bits i then (headToAtom H w).δ else 0)) := by
  unfold Head.numerator
  rw [inner_sum, Fintype.sum_option]
  simp_rw [inner_smul_right, Head.value]
  have hnone : H.sigma bits none * ⟪w, H.WV (H.x bits none)⟫_ℝ = (headToAtom H w).η := by
    rw [sigma_none_eq_gamma H w bits, value_none_eq H w bits]
    unfold headToAtom
    rfl
  have hsome : (∑ i, H.sigma bits (some i) * ⟪w, H.WV (H.x bits (some i))⟫_ℝ)
      = ∑ i, (headToAtom H w).wt bits i
          * ((headToAtom H w).m i + (if bits i then (headToAtom H w).δ else 0)) := by
    refine Finset.sum_congr rfl (fun i _ => ?_)
    rw [sigma_some_eq_wt H w bits i, value_some_eq H w bits i]
  rw [hnone, hsome]

/-- **The readout identity:** one head's readout is the atom's value. -/
theorem head_readout_eq_eval :
    ⟪w, H.attnUpdate bits⟫_ℝ = (headToAtom H w).eval bits := by
  unfold Head.attnUpdate FracAtom.eval
  rw [inner_smul_right]
  rw [numerator_readout_eq H w bits, denominator_eq_atom_denom H w bits]
  rw [div_eq_inv_mul]

end

/-- **Theorem 10 (one direction).** If `f` is computable with `H` attention heads,
then `f` is computable by `H` linear-fractional atoms. -/
theorem fracComputable_of_computable {n H : ℕ} {f : (Fin n → Bool) → Bool}
    (h : computableWithHeadsN n H f) : fracComputable n H f := by
  obtain ⟨d, Hs, w, τ, hsep⟩ := h
  refine ⟨fun h => headToAtom (Hs h) w, -τ, ?_⟩
  intro bits
  have hsum : ⟪w, headFamilyAttnUpdate Hs bits⟫_ℝ
      = ∑ h, (headToAtom (Hs h) w).eval bits := by
    rw [show headFamilyAttnUpdate Hs bits = ∑ h, (Hs h).attnUpdate bits from rfl, inner_sum]
    exact Finset.sum_congr rfl (fun h _ => head_readout_eq_eval (Hs h) w bits)
  have hsep' := hsep bits
  rw [gt_iff_lt, hsum] at hsep'
  rw [← hsep']
  constructor
  · intro hlt; linarith
  · intro hlt; linarith

end HeadComplexity
