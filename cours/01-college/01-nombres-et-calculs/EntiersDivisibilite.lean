/-
Collège, 6e — parity and divisibility on natural numbers.

Theorem names follow the chapter index and stay in French; comments are in English.
Only Lean core is used here: no Mathlib import, so `Pair` and `Impair` are defined
from scratch rather than reusing `Even` / `Odd`.
-/

namespace College.NombresEtCalculs

/-- `n` is even: it is twice some natural number. -/
def Pair (n : Nat) : Prop := ∃ k, n = 2 * k

/-- `n` is odd: it is twice some natural number, plus one. -/
def Impair (n : Nat) : Prop := ∃ k, n = 2 * k + 1

/-! ## Un entier est pair ou impair, jamais les deux -/

/-- Every natural number is even or odd. The witness is `n / 2` in both cases;
which one applies is decided by `n % 2`, which core arithmetic pins to `0` or `1`. -/
theorem pair_ou_impair (n : Nat) : Pair n ∨ Impair n := by
  cases Nat.mod_two_eq_zero_or_one n with
  | inl h => exact Or.inl ⟨n / 2, by omega⟩
  | inr h => exact Or.inr ⟨n / 2, by omega⟩

/-- No natural number is both even and odd: `2 * k = 2 * l + 1` is impossible. -/
theorem pas_pair_et_impair (n : Nat) : ¬(Pair n ∧ Impair n) := by
  intro ⟨⟨k, hk⟩, ⟨l, hl⟩⟩
  omega

/-- The two statements together: exactly one of the two holds. -/
theorem un_entier_est_pair_ou_impair_jamais_les_deux (n : Nat) :
    (Pair n ∨ Impair n) ∧ ¬(Pair n ∧ Impair n) :=
  ⟨pair_ou_impair n, pas_pair_et_impair n⟩

/-! ## Somme de deux pairs = pair ; pair + impair = impair ; impair + impair = pair -/

/-- even + even = even. -/
theorem somme_de_deux_pairs_est_paire {m n : Nat} (hm : Pair m) (hn : Pair n) :
    Pair (m + n) := by
  obtain ⟨k, hk⟩ := hm
  obtain ⟨l, hl⟩ := hn
  exact ⟨k + l, by omega⟩

/-- even + odd = odd. -/
theorem somme_pair_impair_est_impaire {m n : Nat} (hm : Pair m) (hn : Impair n) :
    Impair (m + n) := by
  obtain ⟨k, hk⟩ := hm
  obtain ⟨l, hl⟩ := hn
  exact ⟨k + l, by omega⟩

/-- odd + odd = even. This is the case pupils find surprising, and the one where the
carried `+ 1`s combine into the factor `2`. -/
theorem somme_de_deux_impairs_est_paire {m n : Nat} (hm : Impair m) (hn : Impair n) :
    Pair (m + n) := by
  obtain ⟨k, hk⟩ := hm
  obtain ⟨l, hl⟩ := hn
  exact ⟨k + l + 1, by omega⟩

/-! ## Notion de multiple et de diviseur ; un diviseur de `n` est inférieur ou égal à `n` -/

/-- "`n` is a multiple of `a`" and "`a` divides `n`" are the same statement:
`Dvd` on `Nat` unfolds to exactly this existential. -/
theorem multiple_ssi_divise {a n : Nat} : (∃ k, n = a * k) ↔ a ∣ n := Iff.rfl

/-- A divisor of a nonzero `n` is at most `n`. The school statement leaves the
hypothesis implicit, because `0` is not considered there. -/
theorem diviseur_le_de_pos {a n : Nat} (hn : 0 < n) (h : a ∣ n) : a ≤ n :=
  Nat.le_of_dvd hn h

/-- The hypothesis `0 < n` cannot be dropped: `0` is a multiple of every number, so its
divisors are unbounded. This is the gap between the classroom statement and the formal
one — at school, `n` is always a "real" number of objects to share. -/
theorem diviseur_de_zero_non_borne (a : Nat) : a ∣ 0 :=
  ⟨0, by omega⟩

end College.NombresEtCalculs
