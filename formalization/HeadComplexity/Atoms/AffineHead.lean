import HeadComplexity.Atoms.WeightedAtom

set_option linter.style.header false

/-!
# Affine functionals are computable with one head.

If a Boolean function `f` is sign-represented by an affine functional
`c + ∑ i, cs i * x i` (with `x i = boolToReal (bits i)`), then `f` is computed by
a single attention head.

The construction uses `d = n + 1` with `W_Q = W_K = W_V = id`:

* coordinate `0` is the **score** channel;
* coordinate `i.succ` is the **private value** channel of input position `i`.

With `a i := cs i + τ` and `τ := (∑ j, cs j - c) / Real.exp 1`:

* `tokenEmbed 0 = 0`, `tokenEmbed 1 = single 0 (log 2)`, `tokenEmbed 2 = single 0 1`;
* `posEmbed (some i) = single i.succ (a i)`, `posEmbed none = 0`.

The query `x_=` is `single 0 1`, so its only nonzero coordinate is the score
channel.  Hence the softmax weight at position `i` is `2` (bit set) or `1`
(bit clear), and `exp 1` at the query.  The readout
`w = ∑ i, single i.succ 1` reads value channel `i.succ`, which holds `a i`, so
`⟪w, numerator⟫ = ∑ j, a j * (1 + boolToReal (bits j))`.  The sign identity
`⟪w, numerator⟫ - τ * denominator = c + ∑ i, cs i * boolToReal (bits i)`
then transfers the affine sign condition to the head readout.
-/

namespace HeadComplexity

open Finset Head
open scoped BigOperators InnerProductSpace

variable {n : ℕ}

/-- Real inner product on `Vec d` as a coordinate sum. -/
theorem vecN_inner {d : ℕ} (x y : Vec d) : ⟪x, y⟫_ℝ = ∑ i, x i * y i := by
  change dotProduct (y.ofLp) (star x.ofLp) = _
  simp only [dotProduct, Pi.star_apply, star_trivial]
  exact Finset.sum_congr rfl (fun i _ => mul_comm _ _)

/-- The affine coefficients `a i = cs i + τ`. -/
noncomputable def affCoeff (cs : Fin n → ℝ) (c : ℝ) : Fin n → ℝ :=
  fun i => cs i + (∑ j, cs j - c) / Real.exp 1

/-- The threshold `τ = (∑ j, cs j - c) / exp 1`. -/
noncomputable def affTau (cs : Fin n → ℝ) (c : ℝ) : ℝ :=
  (∑ j, cs j - c) / Real.exp 1

/-- Token embedding of the affine head. -/
noncomputable def affTok : Fin 3 → Vec (n + 1) :=
  ![ 0,
     EuclideanSpace.single 0 (Real.log 2),
     EuclideanSpace.single 0 1 ]

/-- Positional embedding: position `i` carries `a i` in its private value channel. -/
noncomputable def affPos (cs : Fin n → ℝ) (c : ℝ) : SeqPos n → Vec (n + 1)
  | some i => EuclideanSpace.single i.succ (affCoeff cs c i)
  | none => 0

/-- The affine head over `n` bits. -/
noncomputable def affHead (cs : Fin n → ℝ) (c : ℝ) : Head n (n + 1) where
  tokenEmbed := affTok
  posEmbed := affPos cs c
  WQ := LinearMap.id
  WK := LinearMap.id
  WV := LinearMap.id

/-- The readout vector `w = ∑ i, single i.succ 1`. -/
noncomputable def affReadout (n : ℕ) : Vec (n + 1) := ∑ i : Fin n, EuclideanSpace.single i.succ 1

section
variable (cs : Fin n → ℝ) (c : ℝ)

@[simp] theorem affHead_WK : (affHead cs c).WK = LinearMap.id := rfl
@[simp] theorem affHead_WQ : (affHead cs c).WQ = LinearMap.id := rfl
@[simp] theorem affHead_WV : (affHead cs c).WV = LinearMap.id := rfl

/-- The query embedding equals `single 0 1`. -/
theorem affHead_x_none (bits : Fin n → Bool) :
    (affHead cs c).x bits none = EuclideanSpace.single (0 : Fin (n + 1)) 1 := by
  simp [Head.x, Head.seqTok, affHead, affTok, affPos]

/-- The embedding at position `i`. -/
theorem affHead_x_some (bits : Fin n → Bool) (i : Fin n) :
    (affHead cs c).x bits (some i)
      = affTok (cond (bits i) 1 0) + EuclideanSpace.single i.succ (affCoeff cs c i) := by
  simp [Head.x, Head.seqTok, affHead, affPos]

end

/-! ## Coordinate readings -/

section
variable (cs : Fin n → ℝ) (c : ℝ)

/-- The query `single 0 1` reads coordinate `0` of any vector. -/
theorem affReadout_query_inner (v : Vec (n + 1)) :
    ⟪v, EuclideanSpace.single (0 : Fin (n + 1)) 1⟫_ℝ = v 0 := by
  rw [vecN_inner]
  rw [Finset.sum_eq_single (0 : Fin (n + 1))]
  · simp
  · intro b _ hb
    simp [hb]
  · intro h; exact absurd (Finset.mem_univ _) h

/-- Score-channel value at position `i`: `log 2` if bit set, else `0`. -/
theorem affHead_score_some (bits : Fin n → Bool) (i : Fin n) :
    ((affHead cs c).x bits (some i)) 0 = if bits i then Real.log 2 else 0 := by
  rw [affHead_x_some]
  rw [PiLp.add_apply]
  have hsucc : (EuclideanSpace.single i.succ (affCoeff cs c i) : Vec (n + 1)) 0 = 0 := by
    rw [PiLp.single_apply]
    rw [if_neg (Fin.succ_ne_zero i).symm]
  rw [hsucc, add_zero]
  cases bits i with
  | false => simp [affTok]
  | true => simp [affTok]

/-- Softmax weight at the query token is `exp 1`. -/
theorem affHead_sigma_none (bits : Fin n → Bool) :
    (affHead cs c).sigma bits none = Real.exp 1 := by
  unfold Head.sigma
  rw [affHead_x_none]
  simp only [affHead_WK, affHead_WQ, LinearMap.id_coe, id_eq]
  rw [affReadout_query_inner]
  rw [PiLp.single_apply, if_pos rfl]

/-- Softmax weight at position `i`: `2` if bit set, else `1`. -/
theorem affHead_sigma_some (bits : Fin n → Bool) (i : Fin n) :
    (affHead cs c).sigma bits (some i) = if bits i then 2 else 1 := by
  unfold Head.sigma
  rw [affHead_x_none]
  simp only [affHead_WK, affHead_WQ, LinearMap.id_coe, id_eq]
  rw [affReadout_query_inner, affHead_score_some]
  cases bits i with
  | false => simp
  | true =>
      simp only [if_true]
      rw [Real.exp_log (by norm_num : (0:ℝ) < 2)]

end

/-! ## Readout of value channels -/

section
variable (cs : Fin n → ℝ) (c : ℝ)

/-- The readout reads value channel `i.succ` of a vector, i.e. `⟪w, v⟫ = ∑ i, v i.succ`. -/
theorem affReadout_inner (v : Vec (n + 1)) :
    ⟪affReadout n, v⟫_ℝ = ∑ i : Fin n, v i.succ := by
  unfold affReadout
  rw [sum_inner]
  refine Finset.sum_congr rfl (fun i _ => ?_)
  rw [vecN_inner]
  rw [Finset.sum_eq_single i.succ]
  · simp
  · intro b _ hb
    simp [(Ne.symm hb)]
  · intro h; exact absurd (Finset.mem_univ _) h

/-- The value vector equals the embedding (since `W_V = id`). -/
theorem affHead_value (bits : Fin n → Bool) (p : SeqPos n) :
    (affHead cs c).value bits p = (affHead cs c).x bits p := by
  simp [Head.value, affHead]

/-- Readout of the query embedding is `0` (query has no value channels). -/
theorem affReadout_x_none (bits : Fin n → Bool) :
    ⟪affReadout n, (affHead cs c).x bits none⟫_ℝ = 0 := by
  rw [affHead_x_none, affReadout_inner]
  refine Finset.sum_eq_zero (fun i _ => ?_)
  rw [PiLp.single_apply, if_neg (Fin.succ_ne_zero i)]

/-- Readout of the embedding at position `i` is `a i`. -/
theorem affReadout_x_some (bits : Fin n → Bool) (i : Fin n) :
    ⟪affReadout n, (affHead cs c).x bits (some i)⟫_ℝ = affCoeff cs c i := by
  rw [affHead_x_some, affReadout_inner]
  rw [Finset.sum_eq_single i]
  · rw [PiLp.add_apply, PiLp.single_apply, if_pos rfl]
    have htok : (affTok (cond (bits i) 1 0) : Vec (n + 1)) i.succ = 0 := by
      cases bits i with
      | false => simp [affTok]
      | true =>
          simp only [cond_true]
          rw [show (affTok 1 : Vec (n + 1)) = EuclideanSpace.single 0 (Real.log 2) from rfl]
          rw [PiLp.single_apply, if_neg (Fin.succ_ne_zero i)]
    rw [htok, zero_add]
  · intro j _ hj
    rw [PiLp.add_apply]
    have htok : (affTok (cond (bits i) 1 0) : Vec (n + 1)) j.succ = 0 := by
      cases bits i with
      | false => simp [affTok]
      | true =>
          simp only [cond_true]
          rw [show (affTok 1 : Vec (n + 1)) = EuclideanSpace.single 0 (Real.log 2) from rfl]
          rw [PiLp.single_apply, if_neg (Fin.succ_ne_zero j)]
    rw [htok, zero_add, PiLp.single_apply, if_neg (fun h => hj (Fin.succ_inj.mp h))]
  · intro h; exact absurd (Finset.mem_univ _) h

end

/-! ## Denominator, numerator readout, and the sign identity -/

section
variable (cs : Fin n → ℝ) (c : ℝ)

/-- Hamming weight as a real sum of `boolToReal`. -/
theorem hammingWeight_eq_sum (bits : Fin n → Bool) :
    (hammingWeight bits : ℝ) = ∑ i, boolToReal (bits i) := by
  unfold hammingWeight boolToReal
  rw [Finset.card_filter, Nat.cast_sum]
  refine Finset.sum_congr rfl (fun i _ => ?_)
  cases bits i <;> simp

/-- Denominator is `exp 1 + n + |x|`. -/
theorem affHead_denom (bits : Fin n → Bool) :
    (affHead cs c).denominator bits
      = Real.exp 1 + (n : ℝ) + ∑ i, boolToReal (bits i) := by
  unfold Head.denominator
  rw [Fintype.sum_option, affHead_sigma_none]
  have hsome : ∀ i, (affHead cs c).sigma bits (some i)
      = 1 + boolToReal (bits i) := by
    intro i; rw [affHead_sigma_some]; cases bits i with
    | false => simp [boolToReal]
    | true => simp [boolToReal]; ring
  simp_rw [hsome]
  rw [Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ, Fintype.card_fin,
    nsmul_eq_mul, mul_one]
  ring

/-- Readout of the numerator is `∑ j, a j * (1 + boolToReal (bits j))`. -/
theorem affHead_numread (bits : Fin n → Bool) :
    ⟪affReadout n, (affHead cs c).numerator bits⟫_ℝ
      = ∑ j, affCoeff cs c j * (1 + boolToReal (bits j)) := by
  unfold Head.numerator
  rw [inner_sum, Fintype.sum_option]
  simp_rw [inner_smul_right, affHead_value]
  rw [affReadout_x_none, mul_zero, zero_add]
  refine Finset.sum_congr rfl (fun i _ => ?_)
  rw [affHead_sigma_some, affReadout_x_some]
  cases bits i with
  | false => simp [boolToReal]
  | true => simp [boolToReal]; ring

/-- **The key sign identity.** -/
theorem affHead_sign_identity (bits : Fin n → Bool) :
    ⟪affReadout n, (affHead cs c).numerator bits⟫_ℝ
        - affTau cs c * (affHead cs c).denominator bits
      = c + ∑ i, cs i * boolToReal (bits i) := by
  rw [affHead_numread, affHead_denom]
  unfold affCoeff affTau
  set τ : ℝ := (∑ j, cs j - c) / Real.exp 1 with hτ
  have he : Real.exp 1 ≠ 0 := (Real.exp_pos 1).ne'
  -- expand the numerator sum
  have hnum : ∑ j, (cs j + τ) * (1 + boolToReal (bits j))
      = (∑ j, cs j) + (∑ j, cs j * boolToReal (bits j))
        + τ * (n : ℝ) + τ * ∑ j, boolToReal (bits j) := by
    rw [Finset.sum_congr rfl (fun j _ =>
      show (cs j + τ) * (1 + boolToReal (bits j))
        = cs j + cs j * boolToReal (bits j) + τ + τ * boolToReal (bits j) by ring)]
    rw [Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.sum_add_distrib]
    rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul,
      ← Finset.mul_sum]
    ring
  rw [hnum]
  -- τ * exp 1 = ∑ cs - c
  have hτe : τ * Real.exp 1 = ∑ j, cs j - c := by
    rw [hτ]; field_simp
  -- expand and cancel
  have : τ * (Real.exp 1 + (n : ℝ) + ∑ i, boolToReal (bits i))
      = (∑ j, cs j - c) + τ * (n : ℝ) + τ * ∑ i, boolToReal (bits i) := by
    rw [mul_add, mul_add, hτe]
  rw [this]
  ring

end

/-! ## Assembly -/

/-- **Affine functionals are computable with one head.** Any Boolean function
sign-represented by an affine functional `c + ∑ i, cs i * boolToReal (x i)` is
computed by a single attention head. -/
theorem affine_computable {n : ℕ} (f : (Fin n → Bool) → Bool) (c : ℝ) (cs : Fin n → ℝ)
    (hsign : ∀ x, (0 < c + ∑ i, cs i * boolToReal (x i)) ↔ f x = true) :
    computableWithHeadsN n 1 f := by
  refine ⟨n + 1, fun _ : Fin 1 => affHead cs c, affReadout n, affTau cs c, ?_⟩
  intro bits
  change ⟪affReadout n, ∑ h : Fin 1, (affHead cs c).attnUpdate bits⟫_ℝ > affTau cs c ↔ _
  rw [Fintype.sum_unique]
  unfold Head.attnUpdate
  rw [inner_smul_right]
  set D := (affHead cs c).denominator bits with hD
  set N := ⟪affReadout n, (affHead cs c).numerator bits⟫_ℝ with hN
  have hDpos : 0 < D := (affHead cs c).denominator_pos bits
  -- ⟪w, D⁻¹ • num⟫ = D⁻¹ * N
  have hupdate : D⁻¹ * N > affTau cs c ↔ N > affTau cs c * D := by
    rw [gt_iff_lt, gt_iff_lt, mul_comm D⁻¹ N, ← div_eq_mul_inv, lt_div_iff₀ hDpos]
  rw [hupdate]
  rw [gt_iff_lt, ← sub_pos]
  rw [show N - affTau cs c * D = c + ∑ i, cs i * boolToReal (bits i) from
    affHead_sign_identity cs c bits]
  exact hsign bits

end HeadComplexity
