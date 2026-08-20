import HeadComplexity.Results.SymmetricComplexity

set_option linter.style.header false

/-!
# Exact head complexity of the standard symmetric families (L4, L5, L8).

Corollaries of the symmetric sign-change characterization
`HStar_symmetricFn : HStar n (symmetricFn F) = signChanges n F` (Theorem 12):
once the head complexity of a symmetric function is its profile's sign-change
count, the standard families reduce to a sign-change computation.

* **Theorem 8** `HStar n (PARITY n) = n` — parity's profile alternates, so `C = n`.
* **Theorem 4** `HStar n (THRESHOLD n t) = 1` for `1 ≤ t ≤ n` — a monotone threshold
  profile has a single sign change at `t-1`.
* **Theorem 5 (exact)** `HStar n (EXACT n k) = 2` for `1 ≤ k ≤ n-1` — an internal
  spike profile changes sign twice, at `k-1` and `k`.
-/

namespace HeadComplexity

open Finset

variable {n : ℕ}

/-- The monotone symmetric threshold `T_{n,t}(x) = [|x| ≥ t]` as a symmetric function. -/
def THRESHOLD (n t : ℕ) : (Fin n → Bool) → Bool := symmetricFn (fun k => decide (t ≤ k))

/-! ## Sign-change counts of the standard profiles -/

/-- A monotone threshold profile `[t ≤ ·]` changes sign exactly once (at `t-1`)
along `0, …, n`, provided `1 ≤ t ≤ n`. -/
theorem signChanges_threshold (t : ℕ) (ht1 : 1 ≤ t) (htn : t ≤ n) :
    signChanges n (fun k => decide (t ≤ k)) = 1 := by
  rw [signChanges]
  have hset : ((range n).filter fun s => decide (t ≤ s) ≠ decide (t ≤ s + 1)) = {t - 1} := by
    ext s
    simp only [mem_filter, mem_range, mem_singleton, ne_eq, decide_eq_decide]
    omega
  rw [hset, card_singleton]

/-- An internal exact-count profile `[· = k]` changes sign exactly twice (at `k-1`
and `k`) along `0, …, n`, provided `1 ≤ k ≤ n-1`. -/
theorem signChanges_exact (k : ℕ) (hk1 : 1 ≤ k) (hkn : k ≤ n - 1) :
    signChanges n (fun m => decide (m = k)) = 2 := by
  rw [signChanges]
  have hset : ((range n).filter fun s => decide (s = k) ≠ decide (s + 1 = k)) = {k - 1, k} := by
    ext s
    simp only [mem_filter, mem_range, mem_insert, mem_singleton, ne_eq, decide_eq_decide]
    omega
  rw [hset, card_pair (by omega)]

/-! ## Exact head complexities -/

/-- **Theorem 8.** Parity needs exactly one head per bit: `H*(XOR_n) = n`. -/
theorem HStar_parity (n : ℕ) : HStar n (PARITY n) = n := by
  rw [PARITY_eq_symmetricFn, HStar_symmetricFn, signChanges_parity]

/-- **Theorem 4.** Every monotone symmetric threshold has head complexity one. -/
theorem HStar_threshold (t : ℕ) (ht1 : 1 ≤ t) (htn : t ≤ n) :
    HStar n (THRESHOLD n t) = 1 := by
  rw [THRESHOLD, HStar_symmetricFn, signChanges_threshold t ht1 htn]

/-- **Theorem 5 (exact).** Every internal exact-count predicate needs exactly two heads. -/
theorem HStar_exact (k : ℕ) (hk1 : 1 ≤ k) (hkn : k ≤ n - 1) :
    HStar n (EXACT n k) = 2 := by
  rw [EXACT_eq_symmetricFn, HStar_symmetricFn, signChanges_exact k hk1 hkn]

end HeadComplexity
