import HeadComplexity.Atoms.FracAtom
import HeadComplexity.Atoms.HammingAtom
import Mathlib.Analysis.SpecialFunctions.Log.Basic

set_option linter.style.header false

/-!
# Theorem 10 (one direction) — every linear-fractional atom is one head.

Given a `FracAtom φ` over `n` bits we build a single attention head
`atomHead' φ : Head n 3` whose readout under `w = e₁` is exactly `φ.eval`.
Summing such heads (all sharing the readout `e₁`) realizes any
`fracComputable` function, giving

```
computable_of_fracComputable : fracComputable n H f → computableWithHeadsN n H f
```

The construction uses `d = 3`.  Coordinate `0` is the **score** channel,
coordinate `1` the **value** channel, coordinate `2` a **query marker**.  The
value map is the identity `W_V = id`, while `W_K` and `W_Q` are coordinate
projections back into the score channel (using the identity for both would let
the value channel pollute the scores):

* `W_K x = single 0 (x 0)`  (read coordinate `0`),
* `W_Q x = single 0 (x 2)`  (read coordinate `2`).

The embeddings carry the atom's parameters in log-space so that the softmax
weights reproduce `φ.wt` and `φ.γ`:

* `tokenEmbed 0 = 0`,
  `tokenEmbed 1 = single 0 (log α) + single 1 δ`,
  `tokenEmbed 2 = single 0 (log γ) + single 1 (η/γ) + single 2 1`;
* `posEmbed (some i) = single 0 (log ρ_i) + single 1 (m_i)`, `posEmbed none = 0`.

The query marker `x_= 2 = 1`, so the score at position `p` is `(x_p) 0`, giving
softmax weight `ρ_i α^{x_i} = φ.wt` at a bit and `γ` at the query.  The readout
of the numerator is `η + ∑ φ.wt·(m_i + δ x_i)` and the denominator is
`γ + ∑ φ.wt`, so `⟪e₁, attnUpdate⟫ = φ.eval`.
-/

namespace HeadComplexity

open Finset Head
open scoped BigOperators InnerProductSpace

variable {n : ℕ}

/-- Real inner product on `Vec d` as a coordinate sum. -/
private theorem vecN_inner' {d : ℕ} (x y : Vec d) : ⟪x, y⟫_ℝ = ∑ i, x i * y i := by
  change dotProduct (y.ofLp) (star x.ofLp) = _
  simp only [dotProduct, Pi.star_apply, star_trivial]
  exact Finset.sum_congr rfl (fun i _ => mul_comm _ _)

/-- A coordinate projection back into the score channel:
`projTo0 j x = single 0 (x j)` as a linear map on `Vec 3`. -/
noncomputable def projTo0 (j : Fin 3) : Vec 3 →ₗ[ℝ] Vec 3 :=
  (LinearMap.toSpanSingleton ℝ (Vec 3) (EuclideanSpace.single 0 1)).comp
    (EuclideanSpace.projₗ j)

@[simp] theorem projTo0_apply (j : Fin 3) (x : Vec 3) :
    projTo0 j x = EuclideanSpace.single 0 (x j) := by
  unfold projTo0
  rw [LinearMap.comp_apply, LinearMap.toSpanSingleton_apply]
  ext k
  rw [PiLp.smul_apply, PiLp.single_apply, PiLp.single_apply]
  simp only [EuclideanSpace.projₗ, PiLp.projₗ_apply, smul_eq_mul]
  split <;> simp

/-! ## The atom head -/

/-- Token embedding of the one-atom head for the atom `φ` (`d = 3`). -/
noncomputable def fracTok (φ : FracAtom n) : Fin 3 → Vec 3 :=
  ![ 0,
     EuclideanSpace.single 0 (Real.log φ.α) + EuclideanSpace.single 1 φ.δ,
     EuclideanSpace.single 0 (Real.log φ.γ) + EuclideanSpace.single 1 (φ.η / φ.γ)
       + EuclideanSpace.single 2 1 ]

/-- Positional embedding of the one-atom head: position `i` carries
`log ρ_i` in the score channel and `m_i` in the value channel. -/
noncomputable def fracPos (φ : FracAtom n) : SeqPos n → Vec 3
  | some i => EuclideanSpace.single 0 (Real.log (φ.ρ i)) + EuclideanSpace.single 1 (φ.m i)
  | none => 0

/-- **One head realizing one atom.** -/
noncomputable def atomHead' (φ : FracAtom n) : Head n 3 where
  tokenEmbed := fracTok φ
  posEmbed := fracPos φ
  WQ := projTo0 2
  WK := projTo0 0
  WV := LinearMap.id

/-- The shared readout vector `e₁`. -/
noncomputable def fracReadout : Vec 3 := EuclideanSpace.single 1 1

section
variable (φ : FracAtom n)

@[simp] theorem atomHead'_WK : (atomHead' φ).WK = projTo0 0 := rfl
@[simp] theorem atomHead'_WQ : (atomHead' φ).WQ = projTo0 2 := rfl
@[simp] theorem atomHead'_WV : (atomHead' φ).WV = LinearMap.id := rfl

/-! ### Coordinate readings of the embedded vectors -/

/-- Score channel (coord 0) of the query embedding `x_=`. -/
theorem fracTok_two_coord0 : fracTok φ 2 0 = Real.log φ.γ := by
  simp [fracTok]

/-- Query-marker channel (coord 2) of the query embedding `x_=` is `1`. -/
theorem fracTok_two_coord2 : fracTok φ 2 2 = 1 := by
  simp [fracTok]

/-- Value channel (coord 1) of the query embedding `x_=` is `η/γ`. -/
theorem fracTok_two_coord1 : fracTok φ 2 1 = φ.η / φ.γ := by
  simp [fracTok]

/-- The query embedding equals `tokenEmbed 2` (positional part is zero). -/
theorem atomHead'_x_none (bits : Fin n → Bool) :
    (atomHead' φ).x bits none = fracTok φ 2 := by
  simp [Head.x, Head.seqTok, atomHead', fracPos]

/-- Score-channel coordinate (coord 0) of position `i`. -/
theorem atomHead'_x_some_coord0 (bits : Fin n → Bool) (i : Fin n) :
    ((atomHead' φ).x bits (some i)) 0
      = fracTok φ (cond (bits i) 1 0) 0 + Real.log (φ.ρ i) := by
  simp only [Head.x, Head.seqTok, atomHead', fracPos]
  rw [PiLp.add_apply, PiLp.add_apply, PiLp.single_apply, PiLp.single_apply]
  simp

/-- Value-channel coordinate (coord 1) of position `i`. -/
theorem atomHead'_x_some_coord1 (bits : Fin n → Bool) (i : Fin n) :
    ((atomHead' φ).x bits (some i)) 1
      = fracTok φ (cond (bits i) 1 0) 1 + φ.m i := by
  simp only [Head.x, Head.seqTok, atomHead', fracPos]
  rw [PiLp.add_apply, PiLp.add_apply, PiLp.single_apply, PiLp.single_apply]
  simp

/-- Readout `⟪e₁, ·⟫` reads the value channel (coordinate `1`). -/
theorem fracReadout_inner (v : Vec 3) : ⟪fracReadout, v⟫_ℝ = v 1 := by
  rw [fracReadout, vecN_inner']
  rw [Finset.sum_eq_single (1 : Fin 3)]
  · rw [PiLp.single_apply, if_pos rfl, one_mul]
  · intro b _ hb
    rw [PiLp.single_apply, if_neg hb, zero_mul]
  · intro h; exact absurd (Finset.mem_univ _) h

end

/-! ## Softmax weights -/

section
variable (φ : FracAtom n)

/-- The score `⟪W_K x_p, W_Q x_=⟫ = (x_p) 0`, since the query marker is `1`. -/
theorem atomHead'_score (bits : Fin n → Bool) (p : SeqPos n) :
    ⟪(atomHead' φ).WK ((atomHead' φ).x bits p),
        (atomHead' φ).WQ ((atomHead' φ).x bits none)⟫_ℝ
      = ((atomHead' φ).x bits p) 0 := by
  rw [atomHead'_WK, atomHead'_WQ, projTo0_apply, projTo0_apply, vecN_inner']
  rw [Finset.sum_eq_single (0 : Fin 3)]
  · rw [PiLp.single_apply, PiLp.single_apply, if_pos rfl, if_pos rfl,
      atomHead'_x_none, fracTok_two_coord2, mul_one]
  · intro b _ hb
    rw [PiLp.single_apply, if_neg hb, zero_mul]
  · intro h; exact absurd (Finset.mem_univ _) h

/-- Softmax weight at the query token is `γ`. -/
theorem atomHead'_sigma_none (bits : Fin n → Bool) :
    (atomHead' φ).sigma bits none = φ.γ := by
  unfold Head.sigma
  rw [atomHead'_score, atomHead'_x_none, fracTok_two_coord0, Real.exp_log φ.hγ]

/-- Softmax weight at a bit position equals `φ.wt`. -/
theorem atomHead'_sigma_some (bits : Fin n → Bool) (i : Fin n) :
    (atomHead' φ).sigma bits (some i) = φ.wt bits i := by
  unfold Head.sigma
  rw [atomHead'_score, atomHead'_x_some_coord0]
  unfold FracAtom.wt
  cases hb : bits i with
  | false =>
      simp only [cond_false, Bool.false_eq_true, if_false]
      have h0 : fracTok φ 0 0 = 0 := by simp [fracTok]
      rw [h0, zero_add, Real.exp_log (φ.hρ i), mul_one]
  | true =>
      simp only [cond_true, if_true]
      have h1 : fracTok φ 1 0 = Real.log φ.α := by simp [fracTok]
      rw [h1, ← Real.log_mul (φ.hα).ne' (φ.hρ i).ne',
        Real.exp_log (mul_pos φ.hα (φ.hρ i)), mul_comm]

/-- The value vector equals the embedding (since `W_V = id`). -/
theorem atomHead'_value (bits : Fin n → Bool) (p : SeqPos n) :
    (atomHead' φ).value bits p = (atomHead' φ).x bits p := by
  simp [Head.value, atomHead']

end

/-! ## Denominator and numerator readout -/

section
variable (φ : FracAtom n)

/-- Denominator is `γ + ∑ i, φ.wt`. -/
theorem atomHead'_denom (bits : Fin n → Bool) :
    (atomHead' φ).denominator bits = φ.γ + ∑ i, φ.wt bits i := by
  unfold Head.denominator
  rw [Fintype.sum_option, atomHead'_sigma_none]
  congr 1
  exact Finset.sum_congr rfl (fun i _ => atomHead'_sigma_some φ bits i)

/-- Readout `⟪e₁, ·⟫` of the numerator is
`η + ∑ i, φ.wt · (m_i + δ x_i)`. -/
theorem atomHead'_numread (bits : Fin n → Bool) :
    ⟪fracReadout, (atomHead' φ).numerator bits⟫_ℝ
      = φ.η + ∑ i, φ.wt bits i * (φ.m i + if bits i then φ.δ else 0) := by
  unfold Head.numerator
  rw [inner_sum, Fintype.sum_option]
  simp_rw [inner_smul_right, atomHead'_value, fracReadout_inner]
  -- query term: γ * (η/γ) = η
  rw [atomHead'_sigma_none, atomHead'_x_none, fracTok_two_coord1,
    mul_div_cancel₀ _ φ.hγ.ne']
  congr 1
  refine Finset.sum_congr rfl (fun i _ => ?_)
  rw [atomHead'_sigma_some, atomHead'_x_some_coord1]
  cases hb : bits i with
  | false =>
      have h0 : fracTok φ 0 1 = 0 := by simp [fracTok]
      simp only [cond_false, Bool.false_eq_true, if_false]
      rw [h0, zero_add, add_zero]
  | true =>
      have h1 : fracTok φ 1 1 = φ.δ := by simp [fracTok]
      simp only [cond_true, if_true]
      rw [h1, add_comm φ.δ (φ.m i)]

/-- **`⟪e₁, attnUpdate⟫ = φ.eval`.** -/
theorem atomHead'_readout (bits : Fin n → Bool) :
    ⟪fracReadout, (atomHead' φ).attnUpdate bits⟫_ℝ = φ.eval bits := by
  unfold Head.attnUpdate FracAtom.eval
  rw [inner_smul_right, atomHead'_numread, atomHead'_denom, div_eq_inv_mul]

end

/-- **A family of `H` atom heads, shared readout.** The summed readout is
`∑ h, (φ h).eval`. -/
theorem atomFamily'_readout {H : ℕ} (φ : Fin H → FracAtom n) (bits : Fin n → Bool) :
    ⟪fracReadout, ∑ h, (atomHead' (φ h)).attnUpdate bits⟫_ℝ
      = ∑ h, (φ h).eval bits := by
  rw [inner_sum]
  exact Finset.sum_congr rfl (fun h _ => atomHead'_readout (φ h) bits)

/-- **Theorem 10 (one direction).** Every `fracComputable` function is computable
with the same number of attention heads. -/
theorem computable_of_fracComputable {n H : ℕ} {f : (Fin n → Bool) → Bool}
    (h : fracComputable n H f) : computableWithHeadsN n H f := by
  obtain ⟨φ, c, hc⟩ := h
  refine ⟨3, fun h => atomHead' (φ h), fracReadout, -c, ?_⟩
  intro bits
  change ⟪fracReadout, ∑ h, (atomHead' (φ h)).attnUpdate bits⟫_ℝ > -c ↔ _
  rw [atomFamily'_readout]
  rw [← hc bits]
  constructor
  · intro h; linarith
  · intro h; linarith

end HeadComplexity
