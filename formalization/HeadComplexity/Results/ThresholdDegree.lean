import HeadComplexity.Polynomial.ModelToPolynomial
import HeadComplexity.Polynomial.ParityThresholdDegree

set_option linter.style.header false

/-!
# Result-facing threshold-degree bounds.

The polynomial modules define threshold degree and prove polynomial facts. This
module exposes the parts of that machinery that are headline results for head
complexity: heads imply low threshold degree, and parity has threshold degree `n`.
-/

namespace HeadComplexity

/-- **Theorem 6.** `H` heads give a degree-`≤ H` sign representation. -/
alias degree_le_of_computableWithHeadsN := signReprDegLe_of_computableWithHeadsN

/-- **Theorem 7.** Parity has threshold degree exactly `n`. -/
alias parity_thresholdDeg := thresholdDeg_parity

end HeadComplexity
