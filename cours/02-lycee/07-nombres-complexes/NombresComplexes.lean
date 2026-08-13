/-
Lycée — section « Nombres complexes ».
Le corps ℂ est celui de Mathlib, où un complexe est un couple de réels : `z.re` et `z.im`
sont sa partie réelle et sa partie imaginaire, et `Complex.I` le couple `(0, 1)`.
Le conjugué s'écrit `starRingEnd ℂ z`, le module `‖z‖`, l'argument `Complex.arg z`.
Énoncés et démonstrations en français : voir NombresComplexes.tex.
-/
import Mathlib

namespace Lycee.Complexes

open Complex

attribute [local instance] Complex.finrank_real_complex_fact

/-! ## Forme algébrique -/

/-- Tout complexe s'écrit `a + ib` avec `a` et `b` réels, cette écriture est unique, et
`i² = −1`. -/
theorem forme_algebrique (z : ℂ) :
    (z.re : ℂ) + z.im * Complex.I = z ∧ Complex.I ^ 2 = -1 ∧
      ∀ a b : ℝ, (a : ℂ) + b * Complex.I = 0 → a = 0 ∧ b = 0 := by
  refine ⟨Complex.re_add_im z, Complex.I_sq, fun a b h => ?_⟩
  rw [Complex.ext_iff] at h
  simpa using h

/-! ## Conjugué -/

/-- Le conjugué respecte la somme et le produit, et `z conj z = |z|²`. -/
theorem conjugue_proprietes (z z' : ℂ) :
    starRingEnd ℂ (z + z') = starRingEnd ℂ z + starRingEnd ℂ z' ∧
      starRingEnd ℂ (z * z') = starRingEnd ℂ z * starRingEnd ℂ z' ∧
      z * starRingEnd ℂ z = (‖z‖ : ℂ) ^ 2 := by
  refine ⟨map_add _ _ _, map_mul _ _ _, ?_⟩
  rw [Complex.mul_conj, Complex.normSq_eq_norm_sq]
  push_cast
  ring

/-- Un complexe est réel si et seulement s'il est égal à son conjugué, imaginaire pur si
et seulement s'il est l'opposé de son conjugué. -/
theorem reel_et_imaginaire_pur (z : ℂ) :
    (z.im = 0 ↔ starRingEnd ℂ z = z) ∧ (z.re = 0 ↔ starRingEnd ℂ z = -z) := by
  constructor
  · rw [Complex.ext_iff]
    simp only [Complex.conj_re, Complex.conj_im, true_and]
    constructor <;> intro h <;> linarith
  · rw [Complex.ext_iff]
    simp only [Complex.conj_re, Complex.conj_im, Complex.neg_re, Complex.neg_im]
    constructor
    · intro h
      exact ⟨by linarith, trivial⟩
    · rintro ⟨h, -⟩
      linarith

/-! ## Module -/

/-- Le module est multiplicatif et vérifie l'inégalité triangulaire. -/
theorem module_proprietes (z z' : ℂ) :
    ‖z * z'‖ = ‖z‖ * ‖z'‖ ∧ ‖z + z'‖ ≤ ‖z‖ + ‖z'‖ :=
  ⟨norm_mul z z', norm_add_le z z'⟩

/-! ## Argument et forme trigonométrique -/

/-- Forme trigonométrique : `z = |z|(cos θ + i sin θ)` où `θ` est un argument de `z`. -/
theorem forme_trigonometrique (z : ℂ) :
    (‖z‖ : ℂ) * (Real.cos (Complex.arg z) + Real.sin (Complex.arg z) * Complex.I) = z := by
  simp

/-- L'argument d'un produit est la somme des arguments, mais seulement modulo `2π` :
l'égalité a lieu dans le groupe des angles, pas dans ℝ. -/
theorem argument_d_un_produit {z z' : ℂ} (hz : z ≠ 0) (hz' : z' ≠ 0) :
    ((z * z').arg : Real.Angle) = (z.arg : Real.Angle) + (z'.arg : Real.Angle) :=
  Complex.arg_mul_coe_angle hz hz'

/-! ## Forme exponentielle, formules d'Euler et de Moivre -/

/-- Forme exponentielle : `e^{iθ} = cos θ + i sin θ`, donc `z = |z| e^{iθ}`. -/
theorem forme_exponentielle (θ : ℝ) :
    Complex.exp (θ * Complex.I) = Real.cos θ + Real.sin θ * Complex.I := by
  simpa using Complex.exp_mul_I (θ : ℂ)

/-- Formules d'Euler : le cosinus et le sinus s'expriment par des exponentielles. -/
theorem formules_d_euler (t : ℂ) :
    Complex.cos t = (Complex.exp (t * Complex.I) + Complex.exp (-t * Complex.I)) / 2 ∧
      Complex.sin t =
        (Complex.exp (t * Complex.I) - Complex.exp (-t * Complex.I)) / (2 * Complex.I) := by
  have h1 : Complex.exp (t * Complex.I) = Complex.cos t + Complex.sin t * Complex.I :=
    Complex.exp_mul_I t
  have h2 : Complex.exp (-t * Complex.I) = Complex.cos t - Complex.sin t * Complex.I := by
    have h := Complex.exp_mul_I (-t)
    rw [Complex.cos_neg, Complex.sin_neg] at h
    rw [h]
    ring
  constructor
  · rw [h1, h2]
    ring
  · rw [h1, h2]
    field_simp
    ring

/-- Formule de Moivre : `(cos θ + i sin θ)ⁿ = cos nθ + i sin nθ`. -/
theorem formule_de_moivre (θ : ℝ) (n : ℕ) :
    (Real.cos θ + Real.sin θ * Complex.I) ^ n =
      Real.cos (n * θ) + Real.sin (n * θ) * Complex.I := by
  rw [← forme_exponentielle, ← Complex.exp_nat_mul, ← forme_exponentielle]
  push_cast
  ring_nf

/-! ## Équation du second degré à discriminant négatif -/

/-- Une équation du second degré à coefficients réels de discriminant strictement négatif
a deux racines complexes conjuguées et distinctes. -/
theorem second_degre_discriminant_negatif {a b c : ℝ} (ha : a ≠ 0)
    (hd : b ^ 2 - 4 * a * c < 0) :
    ∃ z : ℂ, (a * z ^ 2 + b * z + c = 0) ∧
      (a * (starRingEnd ℂ z) ^ 2 + b * (starRingEnd ℂ z) + c = 0) ∧
      z ≠ starRingEnd ℂ z := by
  have hpos : 0 < 4 * a * c - b ^ 2 := by linarith
  set r : ℝ := Real.sqrt (4 * a * c - b ^ 2) with hrdef
  have hr2 : r ^ 2 = 4 * a * c - b ^ 2 := Real.sq_sqrt hpos.le
  have hrpos : 0 < r := Real.sqrt_pos.mpr hpos
  have ha' : (a : ℂ) ≠ 0 := by exact_mod_cast ha
  have hr2' : (r : ℂ) ^ 2 = 4 * a * c - b ^ 2 := by exact_mod_cast hr2
  have hconj : starRingEnd ℂ ((-b + (r : ℂ) * Complex.I) / (2 * a))
      = (-b - (r : ℂ) * Complex.I) / (2 * a) := by
    rw [map_div₀]
    simp only [map_add, map_neg, map_mul, Complex.conj_ofReal, Complex.conj_I, map_ofNat]
    ring
  refine ⟨(-b + (r : ℂ) * Complex.I) / (2 * a), ?_, ?_, ?_⟩
  · field_simp
    linear_combination (-(1 : ℂ)) * hr2' + (r : ℂ) ^ 2 * Complex.I_sq
  · rw [hconj]
    field_simp
    linear_combination (-(1 : ℂ)) * hr2' + (r : ℂ) ^ 2 * Complex.I_sq
  · rw [hconj]
    intro h
    rw [div_eq_div_iff (by simpa using ha') (by simpa using ha')] at h
    have h4 : (4 : ℂ) * (a : ℂ) * ((r : ℂ) * Complex.I) = 0 := by linear_combination h
    have h4a : (4 : ℂ) * (a : ℂ) ≠ 0 := by simpa using ha'
    have hzz : (r : ℂ) * Complex.I ≠ 0 :=
      mul_ne_zero (by exact_mod_cast ne_of_gt hrpos) Complex.I_ne_zero
    exact hzz ((mul_eq_zero.mp h4).resolve_left h4a)

/-! ## Interprétation géométrique -/

/-- La distance de deux points est le module de la différence de leurs affixes. -/
theorem distance_par_module (za zb : ℂ) : dist za zb = ‖zb - za‖ := by
  rw [dist_comm, Complex.dist_eq]

/-- L'angle orienté entre deux vecteurs est l'argument du quotient de leurs affixes. -/
theorem angle_par_argument {a b c : ℂ} (hb : b ≠ a) :
    Complex.orientation.oangle (b - a) (c - a) = Complex.arg ((c - a) / (b - a)) := by
  have hw : b - a ≠ 0 := sub_ne_zero.mpr hb
  have hn : (0 : ℝ) < (Complex.normSq (b - a))⁻¹ :=
    inv_pos.mpr (Complex.normSq_pos.mpr hw)
  have h : (c - a) / (b - a)
      = ((Complex.normSq (b - a))⁻¹ : ℝ) * (starRingEnd ℂ (b - a) * (c - a)) := by
    rw [div_eq_mul_inv, Complex.inv_def]
    push_cast
    ring
  rw [Complex.oangle, h, Complex.arg_real_mul _ hn]

/-! ## Alignement, orthogonalité, cercle -/

/-- Trois points sont alignés si et seulement si le quotient des affixes est réel ; les
droites `(AB)` et `(AC)` sont perpendiculaires si et seulement s'il est imaginaire pur. -/
theorem alignement_et_orthogonalite {a b c : ℂ} (hb : b ≠ a) :
    ((∃ k : ℝ, c - a = k * (b - a)) ↔ ((c - a) / (b - a)).im = 0) ∧
      ((b - a).re * (c - a).re + (b - a).im * (c - a).im = 0 ↔ ((c - a) / (b - a)).re = 0) := by
  have hw : b - a ≠ 0 := sub_ne_zero.mpr hb
  have hn : Complex.normSq (b - a) ≠ 0 := ne_of_gt (Complex.normSq_pos.mpr hw)
  constructor
  · constructor
    · rintro ⟨k, hk⟩
      rw [hk, mul_div_assoc, div_self hw, mul_one]
      simp
    · intro h
      refine ⟨((c - a) / (b - a)).re, ?_⟩
      have : ((c - a) / (b - a) : ℂ) = (((c - a) / (b - a)).re : ℂ) := by
        rw [Complex.ext_iff]
        simp [h]
      rw [← this, div_mul_cancel₀ _ hw]
  · rw [Complex.div_re]
    constructor <;> intro h
    · field_simp
      linarith [h]
    · field_simp at h
      linarith [h]

/-- Équation cartésienne d'un cercle : `|z − ω| = r` équivaut à
`(x − ω₁)² + (y − ω₂)² = r²`. -/
theorem equation_du_cercle (ω z : ℂ) {r : ℝ} (hr : 0 ≤ r) :
    ‖z - ω‖ = r ↔ (z.re - ω.re) ^ 2 + (z.im - ω.im) ^ 2 = r ^ 2 := by
  have hnorm : ‖z - ω‖ ^ 2 = (z.re - ω.re) ^ 2 + (z.im - ω.im) ^ 2 := by
    rw [← Complex.normSq_eq_norm_sq]
    simp [Complex.normSq_apply, Complex.sub_re, Complex.sub_im]
    ring
  constructor
  · intro h
    rw [← hnorm, h]
  · intro h
    have hsq : ‖z - ω‖ ^ 2 = r ^ 2 := by rw [hnorm, h]
    nlinarith [norm_nonneg (z - ω), hr, hsq]

/-! ## Écriture complexe des transformations -/

/-- Écriture complexe des transformations : la translation `z ↦ z + b` conserve les
distances, la rotation de centre `ω` et d'angle `θ` aussi, et l'homothétie de centre `ω`
et de rapport `k` multiplie les distances par `|k|`. -/
theorem ecriture_complexe_des_transformations (ω b : ℂ) (θ k : ℝ) (z z' : ℂ) :
    dist (z + b) (z' + b) = dist z z' ∧
      dist (ω + Complex.exp (θ * Complex.I) * (z - ω))
        (ω + Complex.exp (θ * Complex.I) * (z' - ω)) = dist z z' ∧
      dist (ω + k * (z - ω)) (ω + k * (z' - ω)) = |k| * dist z z' := by
  refine ⟨by simp [Complex.dist_eq], ?_, ?_⟩
  · rw [Complex.dist_eq, Complex.dist_eq]
    have : ω + Complex.exp (θ * Complex.I) * (z - ω) -
        (ω + Complex.exp (θ * Complex.I) * (z' - ω))
        = Complex.exp (θ * Complex.I) * (z - z') := by ring
    rw [this, norm_mul, Complex.norm_exp_ofReal_mul_I, one_mul]
  · rw [Complex.dist_eq, Complex.dist_eq]
    have : ω + (k : ℂ) * (z - ω) - (ω + (k : ℂ) * (z' - ω)) = (k : ℂ) * (z - z') := by ring
    rw [this, norm_mul, Complex.norm_real, Real.norm_eq_abs]

end Lycee.Complexes
