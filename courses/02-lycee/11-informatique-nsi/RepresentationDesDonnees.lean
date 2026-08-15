/-
Lycée — spécialité NSI, section « Représentation des données ».
Un ordinateur ne manipule que des suites de bits ; tout le reste est convention.
Ce fichier démontre ces conventions : l'écriture binaire d'un entier existe et est
unique, elle se relit comme une somme de puissances de deux, un chiffre hexadécimal
vaut quatre bits, et un dixième n'a pas d'écriture binaire finie — d'où les surprises
du calcul flottant.
Énoncés et démonstrations en français : voir InformatiqueNsi.tex.
-/
import Mathlib

namespace Lycee.Nsi

open Finset

/-! ## Algèbre de Boole -/

/-- Lois de De Morgan : la négation échange « et » et « ou ». -/
theorem de_morgan (a b : Bool) :
    (!(a && b)) = (!a || !b) ∧ (!(a || b)) = (!a && !b) := by
  cases a <;> cases b <;> simp

/-- Distributivité de chaque opération sur l'autre, et involutivité de la négation. -/
theorem distributivite_et_double_negation (a b c : Bool) :
    (a && (b || c)) = ((a && b) || (a && c)) ∧
      (a || (b && c)) = ((a || b) && (a || c)) ∧ (!!a) = a := by
  cases a <;> cases b <;> cases c <;> simp

/-! ## Écriture binaire -/

/-- Tout entier naturel a une écriture binaire : la suite de ses chiffres, lue de
droite à gauche, ne contient que des `0` et des `1`, et le dernier chiffre — celui de
poids fort — n'est pas nul. -/
theorem ecriture_binaire_existence {n : ℕ} (hn : n ≠ 0) :
    (∀ c ∈ Nat.digits 2 n, c < 2) ∧ (Nat.digits 2 n).getLast? ≠ some 0 := by
  refine ⟨fun c hc => Nat.digits_lt_base (by norm_num) hc, ?_⟩
  intro h
  exact absurd (Nat.getLast_digit_ne_zero 2 hn) (by simpa using h)

/-- La valeur d'une écriture binaire est la somme des `bᵢ 2ⁱ` : relire les chiffres
rend le nombre de départ. -/
theorem valeur_d_une_ecriture_binaire (n : ℕ) :
    Nat.ofDigits 2 (Nat.digits 2 n) = n :=
  Nat.ofDigits_digits 2 n

/-- L'écriture binaire est unique : deux suites de chiffres valides qui ont la même
valeur sont la même suite. -/
theorem ecriture_binaire_unicite {L : List ℕ} (hL : ∀ c ∈ L, c < 2)
    (hlast : L ≠ [] → L.getLast? ≠ some 0) :
    Nat.digits 2 (Nat.ofDigits 2 L) = L :=
  Nat.digits_ofDigits 2 (by norm_num) L hL fun h => by
    have := hlast (by rintro rfl; simp at h)
    have hne : L.getLast? = some (L.getLast (by rintro rfl; simp at h)) :=
      List.getLast?_eq_getLast _ _
    omega_nat <;> skip
    all_goals
      rcases Nat.eq_zero_or_pos (L.getLast (by rintro rfl; simp at h)) with h0 | h0
      · exact absurd (hne.trans (by rw [h0])) this
      · exact h0

/-- Le nombre de bits d'un entier non nul est `⌊log₂ n⌋ + 1`. -/
theorem nombre_de_bits {n : ℕ} (hn : n ≠ 0) :
    (Nat.digits 2 n).length = Nat.log 2 n + 1 :=
  Nat.digits_len 2 n (by norm_num) hn

/-! ## Hexadécimal -/

/-- Un chiffre hexadécimal vaut quatre bits : les nombres de moins de `k` chiffres
hexadécimaux sont exactement ceux de moins de `4k` bits. -/
theorem hexadecimal_vaut_quatre_bits (n k : ℕ) : n < 16 ^ k ↔ n < 2 ^ (4 * k) := by
  have : (16 : ℕ) ^ k = 2 ^ (4 * k) := by
    rw [pow_mul]
    norm_num
  rw [this]

/-! ## Nombres à virgule flottante -/

/-- `1/10` n'a pas d'écriture binaire finie : aucun quotient d'un entier par une
puissance de deux ne vaut un dixième. C'est la raison pour laquelle `0,1 + 0,2` ne
rend pas exactement `0,3` en machine. -/
theorem un_dixieme_n_est_pas_binaire : ¬ ∃ a : ℤ, ∃ n : ℕ, (1 : ℚ) / 10 = a / 2 ^ n := by
  rintro ⟨a, n, h⟩
  have h2 : ((2 : ℚ) ^ n) ≠ 0 := by positivity
  have key : (2 : ℚ) ^ n = 10 * a := by
    field_simp at h
    linarith
  -- Le membre de gauche est une puissance de deux, celui de droite est divisible par 5.
  have h5 : (5 : ℤ) ∣ 2 ^ n := by
    have : ((2 : ℤ) ^ n : ℚ) = 10 * a := by exact_mod_cast key
    have hz : (2 : ℤ) ^ n = 10 * a := by exact_mod_cast this
    exact ⟨2 * a, by linarith⟩
  have : (5 : ℕ) ∣ 2 ^ n := by exact_mod_cast h5
  have hp : Nat.Prime 5 := by norm_num
  have := (Nat.Prime.dvd_of_dvd_pow hp this)
  omega

/-! ## Chaînes de caractères -/

/-- La concaténation est associative, et sa longueur est la somme des longueurs. -/
theorem concatenation (u v w : List Char) :
    (u ++ v) ++ w = u ++ (v ++ w) ∧ (u ++ v).length = u.length + v.length :=
  ⟨List.append_assoc u v w, List.length_append u v⟩

end Lycee.Nsi
