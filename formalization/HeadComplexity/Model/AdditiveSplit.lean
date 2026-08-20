import HeadComplexity.BooleanCube.Square
import HeadComplexity.Model.Head

set_option linter.style.header false

/-!
# Additive decomposition of a restricted one-head attention map (Theorem 1).

Theorem 1 states that, after freezing all but two input coordinates `i, j`, the
softmax numerator and denominator of a single head split additively:

$$ N(a,b) = A(a) + B(b) + C, \qquad D(a,b) = \alpha(a) + \beta(b) + \gamma. $$

For a two-valued domain `Bool × Bool` this additive form is *equivalent* to the
antipode (balance) identity `N(0,0)+N(1,1) = N(0,1)+N(1,0)`. The Bool-square
algebra is proved in `BooleanCube/Square.lean`; this file specializes it to the
numerator and denominator antipode identities established for `Head` in
`Model/Head.lean`.
-/

namespace HeadComplexity

namespace Head

variable {n d : ℕ}

/-- **Theorem 1 (numerator).** On a two-coordinate restriction, the softmax
numerator of a single head decomposes additively as `A a + B b + C`, with `A`
depending only on `a`, `B` only on `b`, and `C` constant. -/
theorem numerator_additive_split (H : Head n d) (base : Fin n → Bool)
    (i j : Fin n) (hij : i ≠ j) :
    ∃ (A B : Bool → Vec d) (C : Vec d), ∀ a b : Bool,
      H.numerator (restrictBits base i j (a, b)) = A a + B b + C := by
  exact boolSquare_additive_split_of_antipode
    (fun a b => H.numerator (restrictBits base i j (a, b)))
    (H.restricted_numerator_antipode base i j hij)

/-- **Theorem 1 (denominator).** On a two-coordinate restriction, the softmax
denominator decomposes additively as `α a + β b + γ`. -/
theorem denominator_additive_split (H : Head n d) (base : Fin n → Bool)
    (i j : Fin n) (hij : i ≠ j) :
    ∃ (α β : Bool → ℝ) (γ : ℝ), ∀ a b : Bool,
      H.denominator (restrictBits base i j (a, b)) = α a + β b + γ := by
  exact boolSquare_additive_split_of_antipode
    (fun a b => H.denominator (restrictBits base i j (a, b)))
    (H.restricted_denominator_antipode base i j hij)

end Head

end HeadComplexity
