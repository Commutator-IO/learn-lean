/-
Collège — section « Proportionnalité et fonctions ».
Énoncés et démonstrations en français : voir ProportionnaliteEtFonctions.tex.
-/
import Mathlib.Tactic
import Mathlib.Order.Monotone.Basic

namespace College.Proportionnalite

/-! ## Définitions -/

/- Toutes les définitions du fichier sont posées ici, avant les démonstrations. -/

/-- Une fonction linéaire de coefficient `a`. -/
def lineaire (a : ℝ) : ℝ → ℝ := fun x => a * x

/-- Une fonction affine de coefficient directeur `a` et d'ordonnée à l'origine `b`. -/
def affine (a b : ℝ) : ℝ → ℝ := fun x => a * x + b

/-- Deux grandeurs sont proportionnelles lorsqu'on passe de l'une à l'autre en
multipliant par un même coefficient. -/
def Proportionnelles (f : ℝ → ℝ) : Prop := ∃ a : ℝ, ∀ x, f x = a * x

/-- Appliquer une évolution de taux `p`. -/
def evolution (p : ℝ) : ℝ → ℝ := fun x => x * (1 + p)

/-! ## Un tableau est proportionnel ⟺ les produits en croix sont égaux -/

/-- Deux colonnes d'un tableau de proportionnalité vérifient l'égalité des produits en
croix, et cette égalité les caractérise dès qu'aucune valeur n'est nulle. -/
theorem produits_en_croix {a b c d : ℝ} (hb : b ≠ 0) (hd : d ≠ 0) :
    a / b = c / d ↔ a * d = c * b := div_eq_div_iff hb hd

/-- Une fonction proportionnelle conserve les rapports : c'est la lecture « en ligne » du
tableau. -/
theorem proportionnelle_conserve_rapports {f : ℝ → ℝ} (h : Proportionnelles f) (x y : ℝ) :
    f x * y = f y * x := by
  obtain ⟨a, ha⟩ := h
  rw [ha, ha]
  ring

/-! ## Composition de deux évolutions -/

/-- Appliquer une évolution de taux `p` puis une de taux `q` revient à multiplier par
`(1 + p)(1 + q)`. -/
theorem composition_evolutions (p q x : ℝ) :
    evolution q (evolution p x) = x * ((1 + p) * (1 + q)) := by
  simp only [evolution]
  ring

/-- Une hausse puis une baisse du même taux ne ramènent pas à la valeur initiale : il
manque `p²` fois la valeur de départ. -/
theorem hausse_puis_baisse (p x : ℝ) :
    evolution (-p) (evolution p x) = x - x * p ^ 2 := by
  simp only [evolution]
  ring

/-- En particulier, pour une valeur et un taux non nuls, on ne retrouve pas le point de
départ : `+20 %` puis `−20 %` laisse `96 %` de la valeur initiale. -/
theorem hausse_puis_baisse_contre_exemple :
    evolution (-(1/5)) (evolution (1/5) 100) = 96 := by
  simp only [evolution]
  norm_num

/-! ## Une image est unique, un antécédent ne l'est pas nécessairement -/

/-- Une fonction associe à chaque nombre une seule image : c'est la définition même
d'une fonction. -/
theorem image_unique (f : ℝ → ℝ) (x y₁ y₂ : ℝ) (h₁ : f x = y₁) (h₂ : f x = y₂) : y₁ = y₂ := by
  rw [← h₁, ← h₂]

/-- Un nombre peut en revanche avoir plusieurs antécédents : par la fonction carré, `4`
a pour antécédents `2` et `−2`. -/
theorem antecedent_non_unique :
    (fun x : ℝ => x ^ 2) 2 = 4 ∧ (fun x : ℝ => x ^ 2) (-2) = 4 ∧ (2 : ℝ) ≠ -2 := by
  norm_num

/-! ## Fonction linéaire : traduit exactement la proportionnalité -/

/-- Les fonctions linéaires sont exactement celles qui traduisent une situation de
proportionnalité. -/
theorem lineaire_ssi_proportionnelle (f : ℝ → ℝ) :
    Proportionnelles f ↔ ∃ a, f = lineaire a := by
  constructor
  · rintro ⟨a, ha⟩
    exact ⟨a, funext ha⟩
  · rintro ⟨a, rfl⟩
    exact ⟨a, fun x => rfl⟩

/-- Le graphe d'une fonction linéaire passe par l'origine. -/
theorem lineaire_passe_par_origine (a : ℝ) : lineaire a 0 = 0 := by
  simp [lineaire]

/-- Une fonction affine passe par l'origine si et seulement si elle est linéaire. -/
theorem affine_par_origine_ssi_lineaire (a b : ℝ) : affine a b 0 = 0 ↔ b = 0 := by
  simp [affine]

/-! ## Fonction affine : coefficient directeur et ordonnée à l'origine -/

/-- L'ordonnée à l'origine d'une fonction affine est son image de zéro. -/
theorem ordonnee_a_l_origine (a b : ℝ) : affine a b 0 = b := by
  simp [affine]

/-- Le coefficient directeur se lit sur deux points quelconques du graphe. -/
theorem coefficient_directeur {a b x₁ x₂ : ℝ} (h : x₁ ≠ x₂) :
    (affine a b x₂ - affine a b x₁) / (x₂ - x₁) = a := by
  simp only [affine]
  have hx : x₂ - x₁ ≠ 0 := sub_ne_zero.mpr (Ne.symm h)
  field_simp
  ring

/-- Deux points distincts déterminent une fonction affine et une seule. -/
theorem affine_determinee_par_deux_points {x₁ x₂ y₁ y₂ : ℝ} (h : x₁ ≠ x₂) :
    ∃! ab : ℝ × ℝ, affine ab.1 ab.2 x₁ = y₁ ∧ affine ab.1 ab.2 x₂ = y₂ := by
  have hx : x₂ - x₁ ≠ 0 := sub_ne_zero.mpr (Ne.symm h)
  refine ⟨((y₂ - y₁) / (x₂ - x₁), y₁ - (y₂ - y₁) / (x₂ - x₁) * x₁), ⟨by simp [affine], ?_⟩, ?_⟩
  · simp only [affine]
    field_simp
    ring
  · rintro ⟨a, b⟩ ⟨h₁, h₂⟩
    simp only [affine] at h₁ h₂
    have ha : a = (y₂ - y₁) / (x₂ - x₁) := by
      field_simp
      linarith [h₁, h₂]
    subst ha
    have hb : b = y₁ - (y₂ - y₁) / (x₂ - x₁) * x₁ := by linarith [h₁]
    simp [hb]

/-! ## Sens de variation d'une fonction affine selon le signe de `a` -/

/-- Une fonction affine de coefficient directeur strictement positif est croissante. -/
theorem affine_croissante {a : ℝ} (ha : 0 < a) (b : ℝ) : StrictMono (affine a b) := by
  intro x y hxy
  simp only [affine]
  nlinarith

/-- De coefficient directeur strictement négatif, elle est décroissante. -/
theorem affine_decroissante {a : ℝ} (ha : a < 0) (b : ℝ) : StrictAnti (affine a b) := by
  intro x y hxy
  simp only [affine]
  nlinarith

/-- De coefficient directeur nul, elle est constante. -/
theorem affine_constante (b : ℝ) : affine 0 b = fun _ => b := by
  funext x
  simp [affine]

end College.Proportionnalite
