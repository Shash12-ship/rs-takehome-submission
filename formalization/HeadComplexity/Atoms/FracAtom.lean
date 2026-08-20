import HeadComplexity.Atoms.AffineHead

set_option linter.style.header false

/-!
# Theorem 10 — exact linear-fractional normal form.

A **one-head atom** is a function
`φ(x) = (η + ∑ ρ_i α^{x_i}(m_i + δ x_i)) / (γ + ∑ ρ_i α^{x_i})` with `γ, ρ_i, α > 0`.
`L_frac(f)` is the least number of atoms whose sum, plus a constant, sign-represents
`f`.  Then `H*(f) = L_frac(f)`:

* every attention head's readout `⟪w, attnUpdate⟫ = (∑_p σ_p ⟪w, WV x_p⟫)/(∑_p σ_p)`
  is such an atom (Theorem 1, `fracComputable_of_computable`);
* every atom is realized by one head (Theorem 2, `computable_of_fracComputable`).

`α^{x_i}` is interpreted on the cube: `1` when `x_i = 0`, `α` when `x_i = 1`.
-/

namespace HeadComplexity

open Finset
open scoped BigOperators InnerProductSpace

variable {n : ℕ}

/-- A one-head linear-fractional atom. -/
structure FracAtom (n : ℕ) where
  η : ℝ
  δ : ℝ
  γ : ℝ
  α : ℝ
  ρ : Fin n → ℝ
  m : Fin n → ℝ
  hγ : 0 < γ
  hα : 0 < α
  hρ : ∀ i, 0 < ρ i

namespace FracAtom

/-- Unnormalized attention weight of the atom at position `i`. -/
noncomputable def wt (φ : FracAtom n) (x : Fin n → Bool) (i : Fin n) : ℝ :=
  φ.ρ i * (if x i then φ.α else 1)

/-- The value of the atom on an input. -/
noncomputable def eval (φ : FracAtom n) (x : Fin n → Bool) : ℝ :=
  (φ.η + ∑ i, φ.wt x i * (φ.m i + (if x i then φ.δ else 0)))
    / (φ.γ + ∑ i, φ.wt x i)

theorem wt_pos (φ : FracAtom n) (x : Fin n → Bool) (i : Fin n) : 0 < φ.wt x i := by
  have hr := φ.hρ i; have ha := φ.hα
  unfold wt; split <;> positivity

/-- The atom's denominator is positive. -/
theorem denom_pos (φ : FracAtom n) (x : Fin n → Bool) : 0 < φ.γ + ∑ i, φ.wt x i :=
  add_pos_of_pos_of_nonneg φ.hγ (Finset.sum_nonneg fun i _ => (φ.wt_pos x i).le)

end FracAtom

/-- `f` is computed by `H` atoms plus a constant. -/
def fracComputable (n H : ℕ) (f : (Fin n → Bool) → Bool) : Prop :=
  ∃ (φ : Fin H → FracAtom n) (c : ℝ),
    ∀ x : Fin n → Bool, (0 < c + ∑ h, (φ h).eval x ↔ f x = true)

/-- The linear-fractional complexity: least number of atoms representing `f`. -/
noncomputable def Lfrac (n : ℕ) (f : (Fin n → Bool) → Bool) : ℕ := by
  classical
  exact if h : ∃ H, fracComputable n H f then Nat.find h else 0

end HeadComplexity
