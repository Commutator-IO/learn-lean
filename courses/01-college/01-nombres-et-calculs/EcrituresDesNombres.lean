/-
Collège — section « Écritures des nombres ». Mathlib est nécessaire ici : les réels,
la racine carrée et l'irrationalité de √2 n'existent pas dans Lean core.
Énoncés et démonstrations en français : voir NombresEtCalculs.tex.
-/
import Mathlib

namespace College.NombresEtCalculs

/-! ## Numération décimale de position ; valeur d'un chiffre selon son rang -/

/-- Un entier vaut la somme de ses chiffres pondérés par les puissances de dix. -/
theorem numeration_decimale_de_position (n : ℕ) :
    Nat.ofDigits 10 (Nat.digits 10 n) = n :=
  Nat.ofDigits_digits 10 n

/-- Le chiffre de rang `i` s'obtient en supprimant les `i` premiers chiffres, puis en
prenant le reste modulo dix. -/
theorem valeur_d_un_chiffre_selon_son_rang (n i : ℕ) :
    (n % 10 ^ (i + 1)) / 10 ^ i = (n / 10 ^ i) % 10 := by
  rw [pow_succ, Nat.mod_mul_right_div_self]

/-! ## Ordre sur les décimaux ; comparaison, encadrement, intercalation -/

/-- Entre deux décimaux distincts s'intercale toujours un troisième nombre. -/
theorem intercalation {x y : ℚ} (h : x < y) : ∃ z, x < z ∧ z < y :=
  exists_between h

/-- Encadrement d'un rationnel par deux entiers consécutifs. -/
theorem encadrement (x : ℚ) : (⌊x⌋ : ℚ) ≤ x ∧ x < ⌊x⌋ + 1 :=
  ⟨Int.floor_le x, Int.lt_floor_add_one x⟩

/-! ## Ordre sur les relatifs ; opposé, distance à zéro -/

/-- Prendre l'opposé renverse l'ordre. -/
theorem ordre_et_oppose (a b : ℤ) : a < b ↔ -b < -a := neg_lt_neg_iff.symm

/-- La distance à zéro est le plus grand des deux nombres opposés. -/
theorem distance_a_zero (a : ℤ) : |a| = max a (-a) := abs_eq_max_neg

/-! ## Égalité de fractions : `a/b = (ka)/(kb)` pour `k ≠ 0` -/

/-- Multiplier numérateur et dénominateur par un même nombre non nul ne change pas la
fraction. -/
theorem egalite_de_fractions (a b : ℚ) {k : ℚ} (hk : k ≠ 0) : (k * a) / (k * b) = a / b :=
  mul_div_mul_left a b hk

/-! ## Comparaison de fractions ; mise au même dénominateur -/

/-- Deux fractions de dénominateurs positifs se comparent par produits croisés. -/
theorem comparaison_de_fractions {a b c d : ℚ} (hb : 0 < b) (hd : 0 < d) :
    a / b < c / d ↔ a * d < c * b := div_lt_div_iff₀ hb hd

/-- Mise au même dénominateur. -/
theorem meme_denominateur (a b c d : ℚ) (hb : b ≠ 0) (hd : d ≠ 0) :
    a / b + c / d = (a * d + c * b) / (b * d) := by
  field_simp

/-! ## Une fraction n'a pas toujours d'écriture décimale exacte (`1/3`) -/

/-- `1/3` ne s'écrit avec aucun nombre fini de décimales : sinon `3` diviserait une
puissance de dix. -/
theorem un_tiers_n_est_pas_decimal : ¬ ∃ a n : ℕ, 10 ^ n = 3 * a := by
  rintro ⟨a, n, h⟩
  have h3 : (3 : ℕ) ∣ 10 ^ n := ⟨a, h⟩
  have := (Nat.prime_three).dvd_of_dvd_pow h3
  omega

/-! ## Arrondi, troncature, valeur approchée à `10⁻ⁿ` près, encadrement -/

/-- La troncature à l'unité est le plancher : elle encadre le nombre à moins de un. -/
theorem troncature (x : ℚ) : (⌊x⌋ : ℚ) ≤ x ∧ x - ⌊x⌋ < 1 :=
  ⟨Int.floor_le x, by linarith [Int.lt_floor_add_one x]⟩

/-- L'arrondi à `10⁻ⁿ` près approche le nombre à `10⁻ⁿ / 2` près. -/
theorem valeur_approchee (x : ℝ) (n : ℕ) :
    |x - (round (x * 10 ^ n) : ℝ) / 10 ^ n| ≤ 1 / (2 * 10 ^ n) := by
  have hpos : (0 : ℝ) < 10 ^ n := by positivity
  have h := abs_sub_round (x * 10 ^ n)
  rw [show x - (round (x * 10 ^ n) : ℝ) / 10 ^ n
        = (x * 10 ^ n - round (x * 10 ^ n)) / 10 ^ n by field_simp,
      abs_div, abs_of_pos hpos]
  rw [div_le_div_iff₀ hpos (by positivity)]
  nlinarith [h, hpos]

/-! ## Ordre de grandeur d'un résultat ; contrôle de la vraisemblance d'un calcul -/

/-- Le produit de deux nombres d'ordres de grandeur donnés a son ordre de grandeur
encadré : c'est ce qui permet de contrôler un calcul à vue. -/
theorem ordre_de_grandeur {x y : ℝ} {p q : ℕ}
    (hx : 10 ^ p ≤ x) (hx' : x < 10 ^ (p + 1))
    (hy : 10 ^ q ≤ y) (hy' : y < 10 ^ (q + 1)) :
    (10 : ℝ) ^ (p + q) ≤ x * y ∧ x * y < 10 ^ (p + q + 2) := by
  have hx0 : (0 : ℝ) < 10 ^ p := by positivity
  have hy0 : (0 : ℝ) < 10 ^ q := by positivity
  constructor
  · calc (10 : ℝ) ^ (p + q) = 10 ^ p * 10 ^ q := by rw [pow_add]
      _ ≤ x * y := by nlinarith
  · calc x * y < 10 ^ (p + 1) * 10 ^ (q + 1) := by nlinarith
      _ = 10 ^ (p + q + 2) := by rw [← pow_add]; ring_nf

/-! ## Écriture scientifique : existence et unicité de `a × 10ⁿ` avec `1 ≤ |a| < 10` -/

/-- Tout réel non nul s'écrit `a × 10ⁿ` avec `1 ≤ |a| < 10`. -/
theorem ecriture_scientifique_existence {x : ℝ} (hx : x ≠ 0) :
    ∃ (a : ℝ) (n : ℤ), x = a * 10 ^ n ∧ 1 ≤ |a| ∧ |a| < 10 := by
  have h0 : 0 < |x| := abs_pos.mpr hx
  set n := Int.log 10 |x| with hn
  have hle : (10 : ℝ) ^ n ≤ |x| := Int.zpow_log_le_self (by norm_num) h0
  have hlt : |x| < (10 : ℝ) ^ (n + 1) := Int.lt_zpow_succ_log_self (by norm_num) |x|
  have hpos : (0 : ℝ) < 10 ^ n := by positivity
  refine ⟨x / 10 ^ n, n, by field_simp, ?_, ?_⟩
  · rw [abs_div, abs_of_pos hpos, le_div_iff₀ hpos]
    simpa using hle
  · rw [abs_div, abs_of_pos hpos, div_lt_iff₀ hpos]
    calc |x| < (10 : ℝ) ^ (n + 1) := hlt
      _ = 10 * 10 ^ n := by rw [zpow_add₀ (by norm_num : (10:ℝ) ≠ 0)]; ring

/-- Unicité de l'exposant, donc de l'écriture. -/
theorem ecriture_scientifique_unicite {a a' : ℝ} {n n' : ℤ}
    (h : a * 10 ^ n = a' * 10 ^ n')
    (ha : 1 ≤ |a|) (ha' : |a| < 10) (hb : 1 ≤ |a'|) (hb' : |a'| < 10) :
    n = n' ∧ a = a' := by
  have hx : ∀ m : ℤ, (0 : ℝ) < 10 ^ m := fun m => by positivity
  have ha0 : (0 : ℝ) < |a| := lt_of_lt_of_le zero_lt_one ha
  have hb0 : (0 : ℝ) < |a'| := lt_of_lt_of_le zero_lt_one hb
  have habs : |a| * 10 ^ n = |a'| * 10 ^ n' := by
    have := congrArg abs h
    rwa [abs_mul, abs_mul, abs_of_pos (hx n), abs_of_pos (hx n')] at this
  -- le rapport des deux mantisses est une puissance de dix strictement comprise
  -- entre 10⁻¹ et 10, donc d'exposant nul
  have hratio : (10 : ℝ) ^ (n - n') = |a'| / |a| := by
    rw [zpow_sub₀ (by norm_num : (10:ℝ) ≠ 0)]
    field_simp at habs ⊢
    linarith [habs]
  have hlt : (10 : ℝ) ^ (n - n') < 10 ^ (1 : ℤ) := by
    rw [hratio]
    rw [div_lt_iff₀ ha0]
    calc |a'| < 10 := hb'
      _ ≤ 10 ^ (1 : ℤ) * |a| := by
          rw [zpow_one]; nlinarith
  have hgt : (10 : ℝ) ^ (-1 : ℤ) < 10 ^ (n - n') := by
    rw [hratio, zpow_neg, zpow_one, lt_div_iff₀ ha0]
    calc (10 : ℝ)⁻¹ * |a| < (10 : ℝ)⁻¹ * 10 := by nlinarith
      _ = 1 := by norm_num
      _ ≤ |a'| := hb
  have h1 : n - n' < 1 := by
    have := (zpow_lt_zpow_iff_right₀ (by norm_num : (1:ℝ) < 10)).mp hlt
    exact_mod_cast this
  have h2 : (-1 : ℤ) < n - n' := by
    have := (zpow_lt_zpow_iff_right₀ (by norm_num : (1:ℝ) < 10)).mp hgt
    exact_mod_cast this
  have hn : n = n' := by omega
  subst hn
  refine ⟨rfl, ?_⟩
  have := hx n
  field_simp at h
  exact h

/-! ## Racine carrée : `(√a)² = a` et `√(a²) = a` pour `a ≥ 0` -/

/-- Élever au carré annule la racine. -/
theorem racine_carree_au_carre {a : ℝ} (ha : 0 ≤ a) : Real.sqrt a ^ 2 = a :=
  Real.sq_sqrt ha

/-- Et réciproquement, pour un nombre positif. -/
theorem racine_du_carre {a : ℝ} (ha : 0 ≤ a) : Real.sqrt (a ^ 2) = a :=
  Real.sqrt_sq ha

/-! ## `√(ab) = √a × √b` et `√(a/b) = √a / √b` (`a ≥ 0`, `b > 0`) -/

/-- La racine d'un produit est le produit des racines. -/
theorem racine_d_un_produit {a : ℝ} (ha : 0 ≤ a) (b : ℝ) :
    Real.sqrt (a * b) = Real.sqrt a * Real.sqrt b := Real.sqrt_mul ha b

/-- La racine d'un quotient est le quotient des racines. -/
theorem racine_d_un_quotient (a : ℝ) {b : ℝ} (hb : 0 ≤ b) :
    Real.sqrt (a / b) = Real.sqrt a / Real.sqrt b := Real.sqrt_div' a hb

/-! ## Contre-exemple : `√(a + b) ≠ √a + √b` en général -/

/-- La racine d'une somme n'est pas la somme des racines : `√2 ≠ 2`. -/
example :
    Real.sqrt (1 + 1) ≠ Real.sqrt 1 + Real.sqrt 1 := by
  intro h
  rw [Real.sqrt_one, show (1 : ℝ) + 1 = 2 by norm_num] at h
  have hcarre := Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)
  rw [h] at hcarre
  norm_num at hcarre

/-! ## Rationnels et irrationnels : `√2` n'est pas rationnel -/

/-- `√2` est irrationnel. Au collège, le résultat est mentionné sans démonstration. -/
theorem racine_de_deux_irrationnelle : Irrational (Real.sqrt 2) := irrational_sqrt_two

end College.NombresEtCalculs
