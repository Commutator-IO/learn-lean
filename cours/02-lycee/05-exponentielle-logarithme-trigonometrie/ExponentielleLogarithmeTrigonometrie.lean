/-
Lycée — section « Exponentielle, logarithme, trigonométrie ».
L'exponentielle et le logarithme sont ceux de Mathlib, construits par les séries entières
et non par l'équation différentielle du programme ; le premier énoncé rétablit le lien en
démontrant l'unicité de la solution de `f' = f`, `f(0) = 1`.
Les angles sont en radians, `Real.pi` étant la demi-période de `cos` et `sin`.
Énoncés et démonstrations en français : voir ExponentielleLogarithmeTrigonometrie.tex.
-/
import Mathlib

namespace Lycee.ExpLogTrigo

open Filter Topology

/-! ## Exponentielle : équation différentielle -/

/-- L'exponentielle est solution de l'équation différentielle du programme : elle est
dérivable, égale à sa dérivée, et vaut `1` en zéro. -/
theorem exponentielle_existence :
    (∀ x : ℝ, HasDerivAt Real.exp (Real.exp x) x) ∧ Real.exp 0 = 1 :=
  ⟨Real.hasDerivAt_exp, Real.exp_zero⟩

/-- Et c'est la seule : toute fonction dérivable égale à sa dérivée et valant `1` en zéro
est l'exponentielle. -/
theorem exponentielle_unicite {f : ℝ → ℝ} (hf : ∀ x, HasDerivAt f (f x) x) (h0 : f 0 = 1)
    (x : ℝ) : f x = Real.exp x := by
  have hg : ∀ y : ℝ, HasDerivAt (fun t => f t * Real.exp (-t)) 0 y := by
    intro y
    have h1 : HasDerivAt (fun t : ℝ => Real.exp (-t)) (-Real.exp (-y)) y := by
      simpa using (hasDerivAt_neg y).exp
    have h2 := (hf y).mul h1
    have e : f y * Real.exp (-y) + f y * -Real.exp (-y) = 0 := by ring
    rw [e] at h2
    exact h2
  have hconst : (fun t => f t * Real.exp (-t)) x = (fun t => f t * Real.exp (-t)) 0 :=
    is_const_of_deriv_eq_zero (fun y => (hg y).differentiableAt) (fun y => (hg y).deriv) x 0
  simp only [h0, neg_zero, Real.exp_zero, mul_one, Real.exp_neg] at hconst
  field_simp at hconst
  exact hconst

/-! ## Propriétés algébriques de l'exponentielle -/

/-- L'exponentielle transforme les sommes en produits : `exp(a + b) = exp(a)exp(b)`,
`exp(−a) = 1/exp(a)`, `exp(na) = exp(a)ⁿ`. -/
theorem exponentielle_proprietes_algebriques (a b : ℝ) (n : ℕ) :
    Real.exp (a + b) = Real.exp a * Real.exp b ∧
      Real.exp (-a) = 1 / Real.exp a ∧
      Real.exp (n * a) = Real.exp a ^ n := by
  refine ⟨Real.exp_add a b, ?_, ?_⟩
  · rw [Real.exp_neg, one_div]
  · rw [← Real.exp_nat_mul]

/-- L'exponentielle est strictement positive et strictement croissante. -/
theorem exponentielle_signe_et_variation :
    (∀ x : ℝ, 0 < Real.exp x) ∧ StrictMono Real.exp :=
  ⟨Real.exp_pos, Real.exp_strictMono⟩

/-! ## Limites de l'exponentielle -/

/-- `eˣ → +∞` en `+∞` et `eˣ → 0` en `−∞`. -/
theorem exponentielle_limites :
    Tendsto Real.exp atTop atTop ∧ Tendsto Real.exp atBot (nhds 0) :=
  ⟨Real.tendsto_exp_atTop, Real.tendsto_exp_atBot⟩

/-! ## Logarithme népérien -/

/-- Le logarithme est la fonction réciproque de l'exponentielle : `ln(exp x) = x` pour
tout `x`, et `exp(ln x) = x` pour `x > 0`. -/
theorem logarithme_reciproque (x : ℝ) :
    Real.log (Real.exp x) = x ∧ (0 < x → Real.exp (Real.log x) = x) :=
  ⟨Real.log_exp x, fun hx => Real.exp_log hx⟩

/-- Le logarithme transforme les produits en sommes : `ln(ab) = ln a + ln b`,
`ln(a/b) = ln a − ln b`, `ln(aⁿ) = n ln a`, `ln √a = ½ ln a`. -/
theorem logarithme_proprietes_algebriques {a b : ℝ} (ha : 0 < a) (hb : 0 < b) (n : ℕ) :
    Real.log (a * b) = Real.log a + Real.log b ∧
      Real.log (a / b) = Real.log a - Real.log b ∧
      Real.log (a ^ n) = n * Real.log a ∧
      Real.log (Real.sqrt a) = Real.log a / 2 :=
  ⟨Real.log_mul (ne_of_gt ha) (ne_of_gt hb), Real.log_div (ne_of_gt ha) (ne_of_gt hb),
    Real.log_pow a n, Real.log_sqrt ha.le⟩

/-- Le logarithme est dérivable sur les réels non nuls, de dérivée `1/x`, et strictement
croissant sur les réels strictement positifs. -/
theorem logarithme_derivee_et_variation :
    (∀ x : ℝ, x ≠ 0 → HasDerivAt Real.log (1 / x) x) ∧
      StrictMonoOn Real.log (Set.Ioi 0) := by
  refine ⟨fun x hx => by simpa [one_div] using Real.hasDerivAt_log hx, ?_⟩
  intro x hx y _ hxy
  exact Real.log_lt_log hx hxy

/-- Limites du logarithme : `ln x → −∞` en `0⁺` et `ln x → +∞` en `+∞`. -/
theorem logarithme_limites :
    Tendsto Real.log (nhdsWithin 0 (Set.Ioi 0)) atBot ∧ Tendsto Real.log atTop atTop :=
  ⟨Real.tendsto_log_nhdsGT_zero, Real.tendsto_log_atTop⟩

/-! ## Cercle trigonométrique -/

/-- Le point de coordonnées `(cos x, sin x)` est sur le cercle de centre l'origine et de
rayon `1` : `cos²x + sin²x = 1`. Les deux coordonnées sont donc comprises entre `−1` et
`1`. -/
theorem cercle_trigonometrique (x : ℝ) :
    Real.cos x ^ 2 + Real.sin x ^ 2 = 1 ∧ |Real.cos x| ≤ 1 ∧ |Real.sin x| ≤ 1 :=
  ⟨Real.cos_sq_add_sin_sq x, Real.abs_cos_le_one x, Real.abs_sin_le_one x⟩

/-- Un tour complet vaut `2π` radians : le cosinus et le sinus sont `2π`-périodiques. -/
theorem periodicite (x : ℝ) :
    Real.cos (x + 2 * Real.pi) = Real.cos x ∧ Real.sin (x + 2 * Real.pi) = Real.sin x :=
  ⟨Real.cos_add_two_pi x, Real.sin_add_two_pi x⟩

/-! ## Valeurs remarquables et angles associés -/

/-- Valeurs remarquables du cosinus et du sinus sur le premier quadrant. -/
theorem valeurs_remarquables :
    Real.cos 0 = 1 ∧ Real.sin 0 = 0 ∧
      Real.cos (Real.pi / 6) = Real.sqrt 3 / 2 ∧ Real.sin (Real.pi / 6) = 1 / 2 ∧
      Real.cos (Real.pi / 4) = Real.sqrt 2 / 2 ∧ Real.sin (Real.pi / 4) = Real.sqrt 2 / 2 ∧
      Real.cos (Real.pi / 3) = 1 / 2 ∧ Real.sin (Real.pi / 3) = Real.sqrt 3 / 2 ∧
      Real.cos (Real.pi / 2) = 0 ∧ Real.sin (Real.pi / 2) = 1 :=
  ⟨Real.cos_zero, Real.sin_zero, Real.cos_pi_div_six, Real.sin_pi_div_six,
    Real.cos_pi_div_four, Real.sin_pi_div_four, Real.cos_pi_div_three, Real.sin_pi_div_three,
    Real.cos_pi_div_two, Real.sin_pi_div_two⟩

/-- Angles associés : `−x`, `π − x`, `π/2 − x` se lisent par symétrie sur le cercle. -/
theorem angles_associes (x : ℝ) :
    (Real.cos (-x) = Real.cos x ∧ Real.sin (-x) = -Real.sin x) ∧
      (Real.cos (Real.pi - x) = -Real.cos x ∧ Real.sin (Real.pi - x) = Real.sin x) ∧
      (Real.cos (Real.pi / 2 - x) = Real.sin x ∧ Real.sin (Real.pi / 2 - x) = Real.cos x) :=
  ⟨⟨Real.cos_neg x, Real.sin_neg x⟩, ⟨Real.cos_pi_sub x, Real.sin_pi_sub x⟩,
    ⟨Real.cos_pi_div_two_sub x, Real.sin_pi_div_two_sub x⟩⟩

/-! ## Formules d'addition et de duplication -/

/-- Formules d'addition et de duplication du cosinus et du sinus. -/
theorem addition_et_duplication (a b : ℝ) :
    Real.cos (a + b) = Real.cos a * Real.cos b - Real.sin a * Real.sin b ∧
      Real.sin (a + b) = Real.sin a * Real.cos b + Real.cos a * Real.sin b ∧
      Real.cos (2 * a) = Real.cos a ^ 2 - Real.sin a ^ 2 ∧
      Real.sin (2 * a) = 2 * Real.sin a * Real.cos a :=
  ⟨Real.cos_add a b, Real.sin_add a b, Real.cos_two_mul' a, Real.sin_two_mul a⟩

/-! ## Résolution des équations trigonométriques -/

/-- Résolution de `cos x = a` pour `a` compris entre `−1` et `1` : `arccos a` est une
solution, et les solutions sont exactement `±arccos a` à un nombre entier de tours près. -/
theorem equation_cosinus {a : ℝ} (h1 : -1 ≤ a) (h2 : a ≤ 1) (x : ℝ) :
    Real.cos (Real.arccos a) = a ∧
      (Real.cos x = a ↔ ∃ k : ℤ,
        x = 2 * k * Real.pi + Real.arccos a ∨ x = 2 * k * Real.pi - Real.arccos a) := by
  have ha : Real.cos (Real.arccos a) = a := Real.cos_arccos h1 h2
  refine ⟨ha, ?_, ?_⟩
  · intro hx
    exact Real.cos_eq_cos_iff.mp (ha.trans hx.symm)
  · intro hk
    have h := Real.cos_eq_cos_iff.mpr hk
    rw [ha] at h
    exact h.symm

/-- Résolution de `sin x = a` pour `a` compris entre `−1` et `1` : `arcsin a` est une
solution, et les solutions sont exactement `arcsin a` et `π − arcsin a` à un nombre entier
de tours près. -/
theorem equation_sinus {a : ℝ} (h1 : -1 ≤ a) (h2 : a ≤ 1) (x : ℝ) :
    Real.sin (Real.arcsin a) = a ∧
      (Real.sin x = a ↔ ∃ k : ℤ,
        x = 2 * k * Real.pi + Real.arcsin a ∨ x = (2 * k + 1) * Real.pi - Real.arcsin a) := by
  have ha : Real.sin (Real.arcsin a) = a := Real.sin_arcsin h1 h2
  refine ⟨ha, ?_, ?_⟩
  · intro hx
    exact Real.sin_eq_sin_iff.mp (ha.trans hx.symm)
  · intro hk
    have h := Real.sin_eq_sin_iff.mpr hk
    rw [ha] at h
    exact h.symm

/-- Une équation trigonométrique a donc une infinité de solutions : à toute solution on
peut ajouter un nombre entier de tours. -/
theorem solutions_modulo_deux_pi (x : ℝ) (k : ℤ) :
    Real.cos (x + 2 * k * Real.pi) = Real.cos x ∧
      Real.sin (x + 2 * k * Real.pi) = Real.sin x := by
  have e : (2 : ℝ) * k * Real.pi = (k : ℝ) * (2 * Real.pi) := by ring
  rw [e]
  exact ⟨Real.cos_add_int_mul_two_pi x k, Real.sin_add_int_mul_two_pi x k⟩

/-! ## Dérivées du sinus et du cosinus -/

/-- `sin' = cos` et `cos' = −sin`. -/
theorem derivees_sin_cos (x : ℝ) :
    HasDerivAt Real.sin (Real.cos x) x ∧ HasDerivAt Real.cos (-Real.sin x) x :=
  ⟨Real.hasDerivAt_sin x, Real.hasDerivAt_cos x⟩

/-- La limite `(sin x)/x → 1` en zéro : c'est le nombre dérivé du sinus en zéro. -/
theorem limite_sin_sur_x :
    Tendsto (fun x : ℝ => Real.sin x / x) (nhdsWithin 0 {0}ᶜ) (nhds 1) := by
  have h := Real.hasDerivAt_sin 0
  rw [hasDerivAt_iff_tendsto_slope, Real.cos_zero] at h
  have hs : slope Real.sin 0 = fun x : ℝ => Real.sin x / x := by
    funext x
    simp [slope, div_eq_inv_mul]
  rwa [hs] at h

end Lycee.ExpLogTrigo
