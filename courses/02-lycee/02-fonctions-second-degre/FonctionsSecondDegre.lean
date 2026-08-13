/-
Lycée — section « Fonctions, second degré ».
Énoncés et démonstrations en français : voir FonctionsSecondDegre.tex.
-/
import Mathlib

namespace Lycee.SecondDegre

open Real

/-! ## Définitions -/

/- Toutes les définitions du fichier sont posées ici, avant les démonstrations. -/

/-- La fonction polynôme du second degré de coefficients `a`, `b`, `c`. -/
def trinome (a b c : ℝ) : ℝ → ℝ := fun x => a * x ^ 2 + b * x + c

/-- Le discriminant du trinôme. -/
def discriminant (a b c : ℝ) : ℝ := b ^ 2 - 4 * a * c

/-- La fonction homographique `x ↦ (ax + b)/(cx + d)`. -/
noncomputable def homographique (a b c d : ℝ) : ℝ → ℝ := fun x => (a * x + b) / (c * x + d)

/-! ## Image, antécédent, sens de variation -/

/-- Une fonction croissante conserve l'ordre : c'est sa définition. -/
theorem croissante_conserve_ordre {f : ℝ → ℝ} (hf : Monotone f) {x y : ℝ} (h : x ≤ y) :
    f x ≤ f y := hf h

/-- Composer une fonction croissante avec une fonction décroissante renverse l'ordre. -/
theorem composee_croissante_decroissante {f g : ℝ → ℝ} (hf : Monotone f) (hg : Antitone g) :
    Antitone (g ∘ f) := fun _ _ h => hg (hf h)

/-- Composer deux fonctions décroissantes donne une fonction croissante. -/
theorem composee_deux_decroissantes {f g : ℝ → ℝ} (hf : Antitone f) (hg : Antitone g) :
    Monotone (g ∘ f) := fun _ _ h => hg (hf h)

/-! ## Fonctions de référence -/

/-- La fonction carré est décroissante sur les négatifs et croissante sur les positifs. -/
theorem carre_variations :
    AntitoneOn (fun x : ℝ => x ^ 2) (Set.Iic 0) ∧ MonotoneOn (fun x : ℝ => x ^ 2) (Set.Ici 0) := by
  constructor
  · intro x hx y hy hxy
    simp only [Set.mem_Iic] at hx hy
    nlinarith
  · intro x hx y hy hxy
    simp only [Set.mem_Ici] at hx hy
    nlinarith

/-- La fonction inverse est décroissante sur les réels strictement positifs. -/
theorem inverse_decroissante : AntitoneOn (fun x : ℝ => 1 / x) (Set.Ioi 0) := by
  intro x hx y hy hxy
  simp only [Set.mem_Ioi] at hx hy
  rw [div_le_div_iff₀ hy hx]
  linarith

/-- La fonction racine carrée est croissante. -/
theorem racine_croissante : Monotone (fun x : ℝ => Real.sqrt x) :=
  fun _ _ h => Real.sqrt_le_sqrt h

/-- La fonction cube est croissante sur tout ℝ, contrairement à la fonction carré. -/
theorem cube_croissante : StrictMono (fun x : ℝ => x ^ 3) := fun _ _ h => by
  simpa using Odd.strictMono_pow (R := ℝ) (by decide) h

/-! ## Forme canonique -/

/-- Forme canonique : tout trinôme s'écrit avec un carré et une constante. -/
theorem forme_canonique {a : ℝ} (ha : a ≠ 0) (b c x : ℝ) :
    trinome a b c x = a * (x + b / (2 * a)) ^ 2 - discriminant a b c / (4 * a) := by
  simp only [trinome, discriminant]
  field_simp
  ring

/-! ## Discriminant et racines -/

/-- Si le discriminant est strictement positif, le trinôme a deux racines distinctes. -/
theorem deux_racines {a b c : ℝ} (ha : a ≠ 0) (hd : 0 < discriminant a b c) :
    ∃ x₁ x₂ : ℝ, x₁ ≠ x₂ ∧ trinome a b c x₁ = 0 ∧ trinome a b c x₂ = 0 := by
  set d := Real.sqrt (discriminant a b c) with hdef
  have hd0 : 0 < d := Real.sqrt_pos.mpr hd
  have hcarre : d ^ 2 = discriminant a b c := Real.sq_sqrt hd.le
  refine ⟨(-b + d) / (2 * a), (-b - d) / (2 * a), ?_, ?_, ?_⟩
  · intro h
    field_simp at h
    linarith
  · simp only [trinome, discriminant] at hcarre ⊢
    field_simp
    nlinarith [hcarre]
  · simp only [trinome, discriminant] at hcarre ⊢
    field_simp
    nlinarith [hcarre]

/-- Si le discriminant est strictement négatif, le trinôme ne s'annule jamais : il garde
le signe de `a`. -/
theorem aucune_racine {a b c : ℝ} (ha : a ≠ 0) (hd : discriminant a b c < 0) (x : ℝ) :
    trinome a b c x ≠ 0 := by
  rw [forme_canonique ha]
  have hcarre : 0 ≤ (x + b / (2 * a)) ^ 2 := sq_nonneg _
  rcases lt_or_gt_of_ne ha with hneg | hpos
  · have h1 : a * (x + b / (2 * a)) ^ 2 ≤ 0 := mul_nonpos_of_nonpos_of_nonneg hneg.le hcarre
    have h2 : 0 < discriminant a b c / (4 * a) := div_pos_of_neg_of_neg hd (by linarith)
    intro h
    linarith
  · have h1 : 0 ≤ a * (x + b / (2 * a)) ^ 2 := mul_nonneg hpos.le hcarre
    have h2 : discriminant a b c / (4 * a) < 0 := div_neg_of_neg_of_pos hd (by linarith)
    intro h
    linarith

/-- Si le discriminant est nul, le trinôme a une racine double. -/
theorem racine_double {a b c : ℝ} (ha : a ≠ 0) (hd : discriminant a b c = 0) :
    trinome a b c (-b / (2 * a)) = 0 ∧ ∀ x, trinome a b c x = a * (x + b / (2 * a)) ^ 2 := by
  constructor
  · rw [forme_canonique ha, hd]
    have h0 : -b / (2 * a) + b / (2 * a) = 0 := by ring
    rw [h0]
    simp
  · intro x
    rw [forme_canonique ha, hd]
    simp

/-! ## Factorisation et signe du trinôme -/

/-- Factorisation par les racines : le trinôme s'écrit `a(x − x₁)(x − x₂)`. -/
theorem factorisation {a b c x₁ x₂ : ℝ} (ha : a ≠ 0)
    (hsomme : x₁ + x₂ = -b / a) (hproduit : x₁ * x₂ = c / a) (x : ℝ) :
    trinome a b c x = a * (x - x₁) * (x - x₂) := by
  simp only [trinome]
  have hb : b = -a * (x₁ + x₂) := by
    field_simp at hsomme
    linear_combination hsomme
  have hc : c = a * (x₁ * x₂) := by
    field_simp at hproduit
    linear_combination -hproduit
  rw [hb, hc]
  ring

/-- Signe du trinôme : entre les racines il est du signe contraire à `a`, à l'extérieur du
signe de `a`. -/
theorem signe_du_trinome {a x₁ x₂ x : ℝ} (ha : 0 < a) (hx : x₁ < x₂) :
    (x₁ < x ∧ x < x₂ → a * (x - x₁) * (x - x₂) < 0) ∧
      (x < x₁ ∨ x₂ < x → 0 < a * (x - x₁) * (x - x₂)) := by
  constructor
  · rintro ⟨h1, h2⟩
    have hp : 0 < x - x₁ := by linarith
    have hn : x - x₂ < 0 := by linarith
    have hprod : (x - x₁) * (x - x₂) < 0 := mul_neg_of_pos_of_neg hp hn
    nlinarith [hprod]
  · rintro (h | h)
    · have h1 : x - x₁ < 0 := by linarith
      have h2 : x - x₂ < 0 := by linarith
      have hprod : 0 < (x - x₁) * (x - x₂) := mul_pos_of_neg_of_neg h1 h2
      nlinarith [hprod]
    · have h1 : 0 < x - x₁ := by linarith
      have h2 : 0 < x - x₂ := by linarith
      have hprod : 0 < (x - x₁) * (x - x₂) := mul_pos h1 h2
      nlinarith [hprod]

/-! ## Somme et produit des racines -/

/-- Somme et produit des racines : `x₁ + x₂ = −b/a` et `x₁x₂ = c/a`. -/
theorem somme_et_produit_des_racines {a b c x₁ x₂ : ℝ} (ha : a ≠ 0)
    (hfact : ∀ x, trinome a b c x = a * (x - x₁) * (x - x₂)) :
    x₁ + x₂ = -b / a ∧ x₁ * x₂ = c / a := by
  have h0 := hfact 0
  have h1 := hfact 1
  have hm1 := hfact (-1)
  simp only [trinome] at h0 h1 hm1
  constructor
  · field_simp
    linear_combination (h1 - hm1) / 2
  · field_simp
    linear_combination -h0

/-! ## Sommet de la parabole et axe de symétrie -/

/-- Le sommet de la parabole est atteint en `−b/(2a)`, et c'est un minimum lorsque
`a > 0`. -/
theorem sommet_minimum {a b c : ℝ} (ha : 0 < a) (x : ℝ) :
    trinome a b c (-b / (2 * a)) ≤ trinome a b c x := by
  have hane : a ≠ 0 := ne_of_gt ha
  rw [forme_canonique hane, forme_canonique hane]
  have h1 : (-b / (2 * a) + b / (2 * a)) ^ 2 = 0 := by ring
  rw [h1]
  have : 0 ≤ a * (x + b / (2 * a)) ^ 2 := mul_nonneg ha.le (sq_nonneg _)
  linarith

/-- La parabole est symétrique par rapport à la droite verticale passant par le sommet. -/
theorem axe_de_symetrie {a b c : ℝ} (ha : a ≠ 0) (t : ℝ) :
    trinome a b c (-b / (2 * a) + t) = trinome a b c (-b / (2 * a) - t) := by
  rw [forme_canonique ha, forme_canonique ha]
  have h1 : (-b / (2 * a) + t + b / (2 * a)) ^ 2 = t ^ 2 := by ring
  have h2 : (-b / (2 * a) - t + b / (2 * a)) ^ 2 = t ^ 2 := by ring
  rw [h1, h2]

/-! ## Fonction homographique -/

/-- La fonction homographique n'est pas définie là où son dénominateur s'annule. -/
theorem homographique_valeur_interdite {c d : ℝ} (hc : c ≠ 0) :
    c * (-d / c) + d = 0 := by
  field_simp
  ring

/-- Elle s'écrit comme la somme d'une constante et d'un terme en `1/(cx + d)` : c'est ce
qui donne son asymptote horizontale `y = a/c`. -/
theorem homographique_forme_reduite {a b c d x : ℝ} (hc : c ≠ 0) (hx : c * x + d ≠ 0) :
    homographique a b c d x = a / c + (b * c - a * d) / (c * (c * x + d)) := by
  simp only [homographique]
  rw [div_add_div _ _ (by exact hc) (by positivity), div_eq_div_iff hx (by positivity)]
  ring

/-! ## Parité -/

/-- Une fonction paire a une courbe symétrique par rapport à l'axe des ordonnées. -/
theorem fonction_paire_symetrie {f : ℝ → ℝ} (h : ∀ x, f (-x) = f x) (x : ℝ) :
    f (-x) = f x := h x

/-- Une fonction impaire a une courbe symétrique par rapport à l'origine. -/
theorem fonction_impaire_symetrie {f : ℝ → ℝ} (h : ∀ x, f (-x) = -f x) (x : ℝ) :
    f (-x) = -f x := h x

/-- La fonction carré est paire, la fonction cube est impaire. -/
theorem parite_des_fonctions_de_reference :
    (∀ x : ℝ, (-x) ^ 2 = x ^ 2) ∧ (∀ x : ℝ, (-x) ^ 3 = -x ^ 3) := by
  constructor <;> intro x <;> ring

end Lycee.SecondDegre
