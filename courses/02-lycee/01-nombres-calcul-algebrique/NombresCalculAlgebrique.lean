/-
Lycée — section « Nombres, calcul algébrique ».
Énoncés et démonstrations en français : voir NombresCalculAlgebrique.tex.
-/
import Mathlib

namespace Lycee.Nombres

open Finset

/-! ## Inclusions des ensembles de nombres -/

/-- Les entiers naturels sont des entiers relatifs, et l'inclusion est stricte : `-1`
n'est pas un entier naturel. -/
theorem inclusion_nat_int : (∀ n : ℕ, ∃ k : ℤ, (k : ℤ) = n) ∧ ¬ ∃ n : ℕ, (n : ℤ) = -1 := by
  refine ⟨fun n => ⟨n, rfl⟩, ?_⟩
  rintro ⟨n, hn⟩
  omega

/-- Les rationnels ne sont pas tous décimaux : `1/3` n'a pas d'écriture décimale finie. -/
theorem inclusion_decimaux_rationnels : ¬ ∃ a : ℤ, ∃ n : ℕ, (1 : ℚ) / 3 = a / 10 ^ n := by
  rintro ⟨a, n, h⟩
  have h10 : ((10 : ℚ) ^ n) ≠ 0 := by positivity
  have key : (10 : ℚ) ^ n = 3 * a := by field_simp at h; linarith [h]
  have hint : (10 : ℤ) ^ n = 3 * a := by exact_mod_cast key
  have h3 : (3 : ℤ) ∣ 10 ^ n := ⟨a, hint⟩
  have : (3 : ℤ) ∣ 10 := Int.Prime.dvd_pow' (by norm_num) h3
  omega

/-- Les réels ne sont pas tous rationnels : c'est l'objet de l'énoncé suivant. -/
theorem inclusion_rationnels_reels : ∃ x : ℝ, Irrational x := ⟨Real.sqrt 2, irrational_sqrt_two⟩

/-! ## `√2` est irrationnel -/

/-- `√2` n'est pas rationnel : aucune fraction d'entiers n'a `2` pour carré. -/
theorem racine_de_deux_irrationnelle : Irrational (Real.sqrt 2) := irrational_sqrt_two

/-! ## Valeur absolue et inégalité triangulaire -/

/-- La valeur absolue mesure une distance : `|x − a| ≤ r` équivaut à l'encadrement de `x`
entre `a − r` et `a + r`. -/
theorem valeur_absolue_encadrement (x a r : ℝ) : |x - a| ≤ r ↔ a - r ≤ x ∧ x ≤ a + r := by
  rw [abs_sub_le_iff]
  constructor <;> intro h <;> constructor <;> linarith [h.1, h.2]

/-- Inégalité triangulaire. -/
theorem inegalite_triangulaire (x y : ℝ) : |x + y| ≤ |x| + |y| := abs_add_le x y

/-! ## Identités remarquables -/

/-- Carré d'une somme, carré d'une différence, différence de deux carrés. -/
theorem identites_remarquables (a b : ℝ) :
    (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2 ∧
      (a - b) ^ 2 = a ^ 2 - 2 * a * b + b ^ 2 ∧
      (a + b) * (a - b) = a ^ 2 - b ^ 2 := by
  refine ⟨by ring, by ring, by ring⟩

/-! ## Produit nul et règle des signes -/

/-- Un produit est nul si et seulement si l'un des facteurs est nul. -/
theorem produit_nul (a b : ℝ) : a * b = 0 ↔ a = 0 ∨ b = 0 := mul_eq_zero

/-- Un quotient est positif si et seulement si ses deux termes ont le même signe. -/
theorem signe_du_quotient {a b : ℝ} (hb : 0 < b) : 0 < a / b ↔ 0 < a := div_pos_iff_of_pos_right hb

/-! ## Signe de `ax + b` -/

/-- Signe d'une expression du premier degré : pour `a > 0`, elle est positive après sa
racine et négative avant. -/
theorem signe_premier_degre {a b x : ℝ} (ha : 0 < a) :
    (0 < a * x + b ↔ -b / a < x) ∧ (a * x + b < 0 ↔ x < -b / a) := by
  constructor
  · rw [div_lt_iff₀ ha]
    constructor <;> intro h <;> nlinarith
  · rw [lt_div_iff₀ ha]
    constructor <;> intro h <;> nlinarith

/-! ## Puissances et racines -/

/-- La racine d'un produit de nombres positifs est le produit des racines. -/
theorem racine_produit {a : ℝ} (ha : 0 ≤ a) (b : ℝ) :
    Real.sqrt (a * b) = Real.sqrt a * Real.sqrt b := Real.sqrt_mul ha b

/-- Puissance d'une puissance : les exposants se multiplient. -/
theorem puissance_de_puissance (a : ℝ) (n m : ℕ) : (a ^ n) ^ m = a ^ (n * m) :=
  (pow_mul a n m).symm

/-! ## Comparaison de `x`, `x²` et `√x` -/

/-- Sur `[0 ; 1]`, élever au carré diminue et prendre la racine augmente. -/
theorem comparaison_petit {x : ℝ} (h0 : 0 ≤ x) (h1 : x ≤ 1) :
    x ^ 2 ≤ x ∧ x ≤ Real.sqrt x := by
  refine ⟨by nlinarith, ?_⟩
  have hs : Real.sqrt x * Real.sqrt x = x := Real.mul_self_sqrt h0
  have hsn : 0 ≤ Real.sqrt x := Real.sqrt_nonneg x
  have hle : Real.sqrt x ≤ 1 := by
    rw [show (1 : ℝ) = Real.sqrt 1 by simp]
    exact Real.sqrt_le_sqrt h1
  nlinarith

/-- Au-delà de `1`, c'est l'inverse : élever au carré augmente et prendre la racine
diminue. -/
theorem comparaison_grand {x : ℝ} (h1 : 1 ≤ x) : x ≤ x ^ 2 ∧ Real.sqrt x ≤ x := by
  refine ⟨by nlinarith, ?_⟩
  have hx : (0 : ℝ) ≤ x := by linarith
  have hs : Real.sqrt x * Real.sqrt x = x := Real.mul_self_sqrt hx
  have hsn : 0 ≤ Real.sqrt x := Real.sqrt_nonneg x
  have hge : 1 ≤ Real.sqrt x := by
    rw [show (1 : ℝ) = Real.sqrt 1 by simp]
    exact Real.sqrt_le_sqrt h1
  nlinarith

/-! ## Sommes -/

/-- Somme des `n` premiers entiers : `1 + 2 + ⋯ + n = n(n+1)/2`. -/
theorem somme_des_entiers (n : ℕ) : 2 * (∑ i ∈ range (n + 1), i) = n * (n + 1) := by
  have h := Finset.sum_range_id_mul_two (n + 1)
  simp only [Nat.add_sub_cancel] at h
  linarith [h]

/-- Somme géométrique : `1 + q + ⋯ + qⁿ = (1 − qⁿ⁺¹)/(1 − q)` pour `q ≠ 1`. -/
theorem somme_geometrique {q : ℝ} (hq : q ≠ 1) (n : ℕ) :
    (∑ i ∈ range (n + 1), q ^ i) = (1 - q ^ (n + 1)) / (1 - q) := by
  have h : (1 : ℝ) - q ≠ 0 := sub_ne_zero.mpr (Ne.symm hq)
  rw [geom_sum_eq hq]
  rw [div_eq_div_iff (sub_ne_zero.mpr hq) h]
  ring

/-! ## Coefficients binomiaux et binôme de Newton -/

/-- Relation de Pascal : chaque coefficient est la somme des deux au-dessus de lui. -/
theorem relation_de_pascal (n k : ℕ) :
    Nat.choose n k + Nat.choose n (k + 1) = Nat.choose (n + 1) (k + 1) :=
  (Nat.choose_succ_succ n k).symm

/-- Formule du binôme de Newton. -/
theorem binome_de_newton (a b : ℝ) (n : ℕ) :
    (a + b) ^ n = ∑ k ∈ range (n + 1), (Nat.choose n k : ℝ) * a ^ k * b ^ (n - k) := by
  rw [add_pow]
  exact Finset.sum_congr rfl fun k _ => by ring

/-! ## Raisonnement par récurrence -/

/-- Principe de récurrence : une propriété vraie au rang zéro et héréditaire est vraie à
tout rang. -/
theorem principe_de_recurrence (P : ℕ → Prop) (h0 : P 0) (hered : ∀ n, P n → P (n + 1)) :
    ∀ n, P n := fun n => Nat.rec h0 hered n

/-! ## Inégalité de Bernoulli -/

/-- Inégalité de Bernoulli : `(1 + a)ⁿ ≥ 1 + na` pour `a ≥ −1`. C'est l'exemple canonique
de démonstration par récurrence du programme. -/
theorem inegalite_de_bernoulli {a : ℝ} (ha : -1 ≤ a) (n : ℕ) : 1 + n * a ≤ (1 + a) ^ n := by
  induction n with
  | zero => simp
  | succ n hn =>
    have hpos : (0 : ℝ) ≤ 1 + a := by linarith
    have : (1 + a) ^ (n + 1) = (1 + a) ^ n * (1 + a) := pow_succ (1 + a) n
    rw [this]
    push_cast
    have hprod : (1 + n * a) * (1 + a) ≤ (1 + a) ^ n * (1 + a) :=
      mul_le_mul_of_nonneg_right hn hpos
    nlinarith [hprod, sq_nonneg a, Nat.cast_nonneg (α := ℝ) n]

/-! ## Énoncés admis

Ce que le programme demande et que ce dépôt ne démontre pas. L'énoncé est écrit, sa
démonstration est admise. -/

/-- Le développement décimal d'un rationnel est périodique à partir d'un certain rang : le
chiffre de rang `n` se répète de période `p`. -/
theorem developpement_decimal_periodique (q : ℚ) (hq : 0 ≤ q) :
    ∃ p > 0, ∃ n₀ : ℕ, ∀ n ≥ n₀,
      ⌊(q : ℝ) * 10 ^ (n + p)⌋ % 10 = ⌊(q : ℝ) * 10 ^ n⌋ % 10 := by
  sorry

end Lycee.Nombres
