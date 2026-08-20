import Mathlib.Algebra.Group.Basic
import Mathlib.Tactic.Abel

set_option linter.style.header false

/-!
# Boolean-square additive decompositions.

This module contains model-independent algebra for functions on a two-dimensional
Boolean cube. A function on `Bool × Bool` has an additive decomposition
`row a + col b + c` exactly when its diagonal and off-diagonal sums agree.
-/

namespace HeadComplexity

/-- If the diagonal and off-diagonal sums of a `Bool × Bool` function agree, then
the function decomposes additively into a term depending only on the first bit, a
term depending only on the second bit, and a constant. -/
theorem boolSquare_additive_split_of_antipode {A : Type*} [AddCommGroup A]
    (f : Bool → Bool → A)
    (hanti : f false false + f true true = f false true + f true false) :
    ∃ (row col : Bool → A) (c : A), ∀ a b : Bool, f a b = row a + col b + c := by
  refine ⟨fun a => f a false, fun b => f false b, -f false false, ?_⟩
  intro a b
  cases a <;> cases b <;> dsimp only
  · abel
  · abel
  · abel
  · have hsum : f true true + f false false = f false true + f true false := by
      rw [add_comm (f true true)]
      exact hanti
    rw [eq_sub_of_add_eq hsum]
    abel

/-- An additive decomposition on a `Bool × Bool` function implies equality of
the diagonal and off-diagonal sums. -/
theorem boolSquare_antipode_of_additive_split {A : Type*} [AddCommGroup A]
    (f : Bool → Bool → A)
    (hsplit : ∃ (row col : Bool → A) (c : A),
      ∀ a b : Bool, f a b = row a + col b + c) :
    f false false + f true true = f false true + f true false := by
  rcases hsplit with ⟨row, col, c, h⟩
  rw [h false false, h true true, h false true, h true false]
  abel

end HeadComplexity
