/-
Collège — section « Calculs et calcul littéral ».
Énoncés et démonstrations en français : voir NombresEtCalculs.tex.
-/
import Mathlib

namespace College.NombresEtCalculs

/-! ## Priorités opératoires ; rôle des parenthèses -/

/-- La multiplication est prioritaire sur l'addition : sans parenthèses, `2 + 3 × 4`
vaut `14`, et non `20`. La priorité est une convention d'écriture, pas un théorème ;
ce qui se démontre, c'est que les deux expressions diffèrent. -/
theorem priorites_operatoires : 2 + 3 * 4 = 14 ∧ (2 + 3) * 4 = 20 ∧ (14 : ℕ) ≠ 20 := by
  norm_num

/-! ## Addition et soustraction des relatifs ; `a − b = a + (−b)` -/

/-- Soustraire, c'est ajouter l'opposé. -/
theorem soustraire_c_est_ajouter_l_oppose (a b : ℤ) : a - b = a + (-b) := sub_eq_add_neg a b

/-- L'opposé d'une somme est la somme des opposés. -/
theorem oppose_d_une_somme (a b : ℤ) : -(a + b) = -a + -b := neg_add a b

/-! ## Règle des signes pour la multiplication et la division -/

/-- Le produit de deux nombres de signes contraires est négatif. -/
theorem regle_des_signes_produit (a b : ℤ) : (-a) * b = -(a * b) := neg_mul a b

/-- Le produit de deux nombres négatifs est positif. -/
theorem regle_des_signes_deux_negatifs (a b : ℤ) : (-a) * (-b) = a * b := neg_mul_neg a b

/-- Même règle pour le quotient. -/
theorem regle_des_signes_quotient (a b : ℚ) : (-a) / b = -(a / b) := neg_div b a

/-! ## Somme, produit, quotient de fractions ; diviser = multiplier par l'inverse -/

/-- Somme de deux fractions. -/
theorem somme_de_fractions (a b c d : ℚ) (hb : b ≠ 0) (hd : d ≠ 0) :
    a / b + c / d = (a * d + c * b) / (b * d) := by
  field_simp

/-- Produit de deux fractions. -/
theorem produit_de_fractions (a b c d : ℚ) : (a / b) * (c / d) = (a * c) / (b * d) :=
  div_mul_div_comm a b c d

/-- Diviser par une fraction, c'est multiplier par son inverse. -/
theorem diviser_c_est_multiplier_par_l_inverse (a b c d : ℚ) :
    (a / b) / (c / d) = (a / b) * (d / c) := by
  rw [div_div_eq_mul_div, div_mul_eq_mul_div, div_mul_div_comm, div_div]

/-! ## Distributivité simple : `k(a + b) = ka + kb` -/

/-- Distributivité de la multiplication sur l'addition. -/
theorem distributivite_simple (k a b : ℚ) : k * (a + b) = k * a + k * b := mul_add k a b

/-! ## Double distributivité : `(a + b)(c + d) = ac + ad + bc + bd` -/

/-- Développement d'un produit de deux sommes. -/
theorem double_distributivite (a b c d : ℚ) :
    (a + b) * (c + d) = a * c + a * d + b * c + b * d := by ring

/-! ## Factorisation d'une expression à facteur commun -/

/-- Factoriser, c'est lire la distributivité de droite à gauche. -/
theorem factorisation_facteur_commun (k a b : ℚ) : k * a + k * b = k * (a + b) :=
  (mul_add k a b).symm

/-! ## Un produit est nul ⟺ l'un des facteurs est nul -/

/-- L'équation produit : un produit de deux nombres est nul si et seulement si l'un des
deux est nul. -/
theorem produit_nul (a b : ℚ) : a * b = 0 ↔ a = 0 ∨ b = 0 := mul_eq_zero

/-! ## Puissances : `aᵐ × aⁿ = aᵐ⁺ⁿ`, `aᵐ / aⁿ = aᵐ⁻ⁿ`, `(aᵐ)ⁿ = aᵐⁿ`, `(ab)ⁿ = aⁿbⁿ` -/

/-- Produit de deux puissances d'un même nombre. -/
theorem produit_de_puissances (a : ℚ) (m n : ℕ) : a ^ m * a ^ n = a ^ (m + n) :=
  (pow_add a m n).symm

/-- Quotient de deux puissances d'un même nombre non nul. -/
theorem quotient_de_puissances {a : ℚ} (ha : a ≠ 0) (m n : ℤ) :
    a ^ m / a ^ n = a ^ (m - n) := (zpow_sub₀ ha m n).symm

/-- Puissance d'une puissance. -/
theorem puissance_d_une_puissance (a : ℚ) (m n : ℕ) : (a ^ m) ^ n = a ^ (m * n) :=
  (pow_mul a m n).symm

/-- Puissance d'un produit. -/
theorem puissance_d_un_produit (a b : ℚ) (n : ℕ) : (a * b) ^ n = a ^ n * b ^ n :=
  mul_pow a b n

/-! ## `a⁻ⁿ = 1/aⁿ` pour `a ≠ 0` ; `a⁰ = 1` -/

/-- Exposant négatif. -/
theorem exposant_negatif (a : ℚ) (n : ℤ) : a ^ (-n) = 1 / a ^ n := by
  rw [zpow_neg, one_div]

/-- Exposant nul. -/
theorem exposant_nul' (a : ℚ) : a ^ (0 : ℤ) = 1 := zpow_zero a

/-- Exposant nul. -/
theorem exposant_nul (a : ℚ) : a ^ (0 : ℕ) = 1 := pow_zero a

/-! ## Conservation des inégalités -/

/-- Ajouter un même nombre aux deux membres conserve l'inégalité. -/
theorem inegalite_et_addition {a b : ℚ} (h : a ≤ b) (c : ℚ) : a + c ≤ b + c := by
  linarith

/-- Multiplier par un nombre strictement positif conserve l'inégalité. -/
theorem inegalite_et_multiplication_positive {a b c : ℚ} (h : a ≤ b) (hc : 0 < c) :
    a * c ≤ b * c := mul_le_mul_of_nonneg_right h hc.le

/-- Multiplier par un nombre strictement négatif renverse l'inégalité. -/
theorem inegalite_et_multiplication_negative {a b c : ℚ} (h : a ≤ b) (hc : c < 0) :
    b * c ≤ a * c := mul_le_mul_of_nonpos_right h hc.le

/-! ## Équation du premier degré `ax + b = 0` : solution unique si `a ≠ 0` -/

/-- Une équation du premier degré à coefficient directeur non nul a une solution, et une
seule : `x = -b/a`. -/
theorem equation_du_premier_degre {a b : ℚ} (ha : a ≠ 0) : ∃! x : ℚ, a * x + b = 0 := by
  refine ⟨-b / a, by field_simp; ring, ?_⟩
  intro y hy
  have hy' : a * y = -b := by linarith [hy]
  have : a * y = a * (-b / a) := by
    rw [hy', mul_div_cancel₀ _ ha]
  exact mul_left_cancel₀ ha this

/-! ## Équation produit `(ax + b)(cx + d) = 0` -/

/-- Une équation produit se ramène à deux équations du premier degré. -/
theorem equation_produit (a b c d x : ℚ) :
    (a * x + b) * (c * x + d) = 0 ↔ a * x + b = 0 ∨ c * x + d = 0 := mul_eq_zero

/-! ## Tester si un nombre est solution ; démontrer qu'une égalité est vraie pour tout `x` -/

/-- Tester une valeur : `2` est solution de `x² − 5x + 6 = 0`, `1` ne l'est pas. -/
theorem tester_une_solution :
    (2 : ℚ) ^ 2 - 5 * 2 + 6 = 0 ∧ (1 : ℚ) ^ 2 - 5 * 1 + 6 ≠ 0 := by norm_num

/-- Démontrer une identité, c'est l'établir pour tout `x` à la fois — ce qu'aucun test de
valeurs ne remplace. -/
theorem identite_pour_tout_x (x : ℚ) : (x + 1) ^ 2 = x ^ 2 + 2 * x + 1 := by ring

/-! ## Programme de calcul : deux programmes donnent le même résultat pour toute entrée -/

/-- « Ajouter 1, élever au carré, retrancher 1 » et « multiplier par le nombre augmenté
de 2 » donnent toujours le même résultat. -/
theorem deux_programmes_de_calcul (x : ℚ) : (x + 1) ^ 2 - 1 = x * (x + 2) := by ring

end College.NombresEtCalculs
