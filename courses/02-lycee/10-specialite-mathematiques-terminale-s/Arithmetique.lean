/-
Lycée — spécialité de terminale S, section « Arithmétique ».
Les entiers relatifs sont ceux de Mathlib ; `a ∣ b` se lit « `a` divise `b` », `a % b` est
le reste de la division euclidienne, et `a ≡ b [ZMOD n]` la congruence modulo `n`.
Le chiffrement RSA n'est pas formalisé : voir la note en fin de fichier.
Énoncés et démonstrations en français : voir Arithmetique.tex.
-/
import Mathlib

namespace Lycee.Specialite

/-! ## Division euclidienne -/

/-- Division euclidienne dans `ℤ` : pour `b > 0`, tout entier `a` s'écrit d'une seule
façon `a = bq + r` avec `0 ≤ r < b`. -/
theorem division_euclidienne {a b : ℤ} (hb : 0 < b) :
    ∃! qr : ℤ × ℤ, a = b * qr.1 + qr.2 ∧ 0 ≤ qr.2 ∧ qr.2 < b := by
  have hb0 : b ≠ 0 := ne_of_gt hb
  have habs : |b| = b := abs_of_pos hb
  refine ⟨(a / b, a % b), ⟨by linarith [Int.emod_add_mul_ediv a b], Int.emod_nonneg a hb0,
    Int.emod_lt_of_pos a hb⟩, ?_⟩
  rintro ⟨q, r⟩ ⟨heq, hr0, hrb⟩
  have h := (Int.ediv_emod_unique'' (a := a) (b := b) (r := r) (q := q) hb0).mpr
    ⟨by linarith, hr0, by rw [habs]; exact hrb⟩
  simp only [Prod.mk.injEq]
  exact ⟨h.1.symm, h.2.symm⟩

/-! ## Congruences -/

/-- Les congruences sont compatibles avec la somme et le produit. -/
theorem congruences_compatibles {a b c d n : ℤ} (h₁ : a ≡ b [ZMOD n]) (h₂ : c ≡ d [ZMOD n]) :
    a + c ≡ b + d [ZMOD n] ∧ a * c ≡ b * d [ZMOD n] :=
  ⟨h₁.add h₂, h₁.mul h₂⟩

/-- Critère de divisibilité par `9`, revisité par les congruences : un entier est congru à
la somme de ses chiffres modulo `9`, parce que `10 ≡ 1 [9]`. -/
theorem critere_par_neuf (n : ℕ) :
    n ≡ (Nat.digits 10 n).sum [MOD 9] ∧ (9 ∣ n ↔ 9 ∣ (Nat.digits 10 n).sum) :=
  ⟨Nat.modEq_digits_sum 9 10 (by norm_num) n,
    Nat.nine_dvd_iff n⟩

/-! ## PGCD et algorithme d'Euclide -/

/-- Algorithme d'Euclide : `pgcd(a, b) = pgcd(b mod a, a)`, ce qui fait décroître les
arguments jusqu'à zéro. -/
theorem algorithme_d_euclide (a b : ℕ) : Nat.gcd a b = Nat.gcd (b % a) a := by
  rcases Nat.eq_zero_or_pos a with rfl | ha
  · simp
  · rw [Nat.gcd_rec]

/-! ## Théorèmes de Bézout et de Gauss -/

/-- Théorème de Bézout : deux entiers sont premiers entre eux si et seulement s'il existe
des entiers `u` et `v` tels que `au + bv = 1`. -/
theorem theoreme_de_bezout (a b : ℤ) :
    Int.gcd a b = 1 ↔ ∃ u v : ℤ, u * a + v * b = 1 := by
  rw [← Int.isCoprime_iff_gcd_eq_one]
  exact ⟨fun ⟨u, v, h⟩ => ⟨u, v, h⟩, fun ⟨u, v, h⟩ => ⟨u, v, h⟩⟩

/-- Théorème de Gauss : si `a` divise `bc` et si `a` et `b` sont premiers entre eux, alors
`a` divise `c`. -/
theorem theoreme_de_gauss {a b c : ℤ} (hab : Int.gcd a b = 1) (h : a ∣ b * c) : a ∣ c :=
  (Int.isCoprime_iff_gcd_eq_one.mpr hab).dvd_of_dvd_mul_left h

/-! ## Équations diophantiennes -/

/-- L'équation `ax + by = c` a une solution si et seulement si `pgcd(a, b)` divise `c`. -/
theorem diophantienne_condition (a b c : ℤ) :
    (∃ x y : ℤ, a * x + b * y = c) ↔ (Int.gcd a b : ℤ) ∣ c := by
  constructor
  · rintro ⟨x, y, rfl⟩
    exact dvd_add ((Int.gcd_dvd_left a b).mul_right x) ((Int.gcd_dvd_right a b).mul_right y)
  · rintro ⟨k, rfl⟩
    refine ⟨Int.gcdA a b * k, Int.gcdB a b * k, ?_⟩
    have h := Int.gcd_eq_gcd_ab a b
    linear_combination (-k) * h

/-- Forme des solutions dans le cas où `a` et `b` sont premiers entre eux : à partir d'une
solution particulière, on les obtient toutes en ajoutant un multiple de `b` à `x` et en
retranchant le même multiple de `a` à `y`. -/
theorem diophantienne_solutions {a b c x₀ y₀ x y : ℤ} (hab : Int.gcd a b = 1)
    (hb : b ≠ 0) (h₀ : a * x₀ + b * y₀ = c) (h : a * x + b * y = c) :
    ∃ k : ℤ, x = x₀ + k * b ∧ y = y₀ - k * a := by
  have hdiff : b * (y₀ - y) = a * (x - x₀) := by linarith
  have hba : Int.gcd b a = 1 := by rwa [Int.gcd_comm]
  have hdvd : b ∣ (x - x₀) :=
    (Int.isCoprime_iff_gcd_eq_one.mpr hba).dvd_of_dvd_mul_left
      ⟨y₀ - y, by linear_combination -hdiff⟩
  obtain ⟨k, hk⟩ := hdvd
  refine ⟨k, by linarith, ?_⟩
  have h2 : b * (y₀ - y) = b * (k * a) := by rw [hdiff, hk]; ring
  have h3 := mul_left_cancel₀ hb h2
  linarith

/-! ## Nombres premiers -/

/-- Il existe une infinité de nombres premiers : au-delà de tout entier `n`, il y en a
encore un. -/
theorem infinite_des_premiers (n : ℕ) : ∃ p, n ≤ p ∧ Nat.Prime p :=
  Nat.exists_infinite_primes n

/-- Décomposition en facteurs premiers : tout entier `n ≥ 1` est le produit de sa liste de
facteurs premiers, et cette liste est unique à l'ordre près. -/
theorem decomposition_en_facteurs_premiers {n : ℕ} (hn : n ≠ 0) :
    (Nat.primeFactorsList n).prod = n ∧
      ∀ l : List ℕ, (∀ p ∈ l, Nat.Prime p) → l.prod = n →
        l.Perm (Nat.primeFactorsList n) :=
  ⟨Nat.prod_primeFactorsList hn, fun _l hl hprod =>
    Nat.primeFactorsList_unique hprod hl⟩

/-! ## Petit théorème de Fermat -/

/-- Petit théorème de Fermat : si `p` est premier et ne divise pas `a`, alors
`a^{p−1} ≡ 1 [p]`. -/
theorem petit_theoreme_de_fermat {p : ℕ} [Fact (Nat.Prime p)] {a : ZMod p} (ha : a ≠ 0) :
    a ^ (p - 1) = 1 :=
  ZMod.pow_card_sub_one_eq_one ha

/-! ## Chiffrement affine -/

/-- Chiffrement affine `x ↦ ax + b` modulo `n` : il est déchiffrable si et seulement si
`a` est inversible modulo `n`, et le déchiffrement est `y ↦ a⁻¹(y − b)`. -/
theorem chiffrement_affine {n : ℕ} [NeZero n] (u : (ZMod n)ˣ) (b : ZMod n) :
    Function.Bijective (fun x : ZMod n => (u : ZMod n) * x + b) ∧
      ∀ x : ZMod n, (↑u⁻¹ : ZMod n) * (((u : ZMod n) * x + b) - b) = x := by
  constructor
  · refine Function.bijective_iff_has_inverse.mpr
      ⟨fun y => (↑u⁻¹ : ZMod n) * (y - b), fun x => ?_, fun y => ?_⟩
    · simp [Units.inv_mul_cancel_left]
    · simp [Units.mul_inv_cancel_left]
  · intro x
    simp [Units.inv_mul_cancel_left]

/- Le chiffrement **RSA** n'est pas formalisé. Sa correction — si `ed ≡ 1` modulo
`(p−1)(q−1)`, alors `m^{ed} ≡ m` modulo `pq` — se démontre en appliquant le petit théorème
de Fermat modulo `p` puis modulo `q`, et en recollant par le théorème des restes chinois.
Chacune de ces trois pièces existe dans Mathlib ; c'est leur assemblage, et la gestion des
cas où `p` ou `q` divise `m`, qui demandent un travail à part entière. -/

/-! ## Énoncés admis -/

/-
Ce que le programme demande et que ce dépôt ne démontre pas. L'énoncé est écrit, sa
démonstration est admise.
-/

/-- Le chiffrement RSA rend bien le message : si `e d ≡ 1` modulo `(p−1)(q−1)`, alors
élever à la puissance `e` puis à la puissance `d` ramène au message de départ. -/
theorem chiffrement_rsa {p q : ℕ} (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q) {e d : ℕ}
    (hed : e * d ≡ 1 [MOD (p - 1) * (q - 1)]) (m : ℕ) :
    (m ^ e) ^ d ≡ m [MOD p * q] := by
  sorry

end Lycee.Specialite
