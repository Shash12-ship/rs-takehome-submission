import HeadComplexity.Model.Head

set_option linter.style.header false

/-!
# Skip-connection reduction in the generalized model.

The query token embedding in `Head.residual` is independent of the input bits.
For linear readouts, adding such a constant vector only shifts the threshold.
This module records that model-level fact once, so example-specific predicates
can specialize it without reproving the threshold algebra.
-/

namespace HeadComplexity

open scoped InnerProductSpace

variable {α : Type*} {d n : ℕ}

/-- Adding a constant vector to the representation only shifts the readout
threshold, so it does not change `computesPred`. -/
theorem computesPred_iff_of_add_const
    (f : α → Bool) (g : α → Vec d) (c : Vec d) :
    computesPred f g ↔ computesPred f (fun a => c + g a) := by
  constructor
  · rintro ⟨w, τ, h⟩
    refine ⟨w, τ + ⟪w, c⟫_ℝ, fun a => ?_⟩
    simp only [inner_add_right]
    constructor
    · intro hgt
      exact (h a).mp (by linarith)
    · intro hf
      have := (h a).mpr hf
      linarith
  · rintro ⟨w, τ, h⟩
    refine ⟨w, τ - ⟪w, c⟫_ℝ, fun a => ?_⟩
    have key := h a
    simp only [inner_add_right] at key
    constructor
    · intro hgt
      exact key.mp (by linarith)
    · intro hf
      have := key.mpr hf
      linarith

namespace Head

/-- The query-position residual is a constant query embedding plus the attention
update. -/
theorem residual_eq_const_add_attnUpdate
    (H : Head n d) (base : Fin n → Bool) :
    H.residual = fun bits => H.x base none + H.attnUpdate bits := by
  funext bits
  change H.x bits none + H.attnUpdate bits = H.x base none + H.attnUpdate bits
  rfl

/-- The skip connection does not change computability by a linear readout:
the constant query embedding is absorbed into the threshold. -/
theorem computesPred_residual_iff_attnUpdate
    (H : Head n d) (f : (Fin n → Bool) → Bool) :
    computesPred f H.residual ↔ computesPred f H.attnUpdate := by
  rw [H.residual_eq_const_add_attnUpdate (fun _ => false)]
  exact (computesPred_iff_of_add_const f H.attnUpdate (H.x (fun _ => false) none)).symm

end Head

end HeadComplexity
