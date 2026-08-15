/-
Collège — section « Grandeurs et mesures ».
Les formules d'aire et de volume sont ici des définitions, comme au collège où elles sont
données : les démontrer demanderait une théorie de la mesure. Ce qui se démontre, ce sont
les relations entre elles, et leur comportement par agrandissement.
Énoncés et démonstrations en français : voir GrandeursEtMesures.tex.
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Tactic

namespace College.Grandeurs

open Real

/-! ## Définitions -/

/- Toutes les définitions du fichier sont posées ici, avant les démonstrations. -/

/-- Périmètre du cercle de rayon `r`. -/
noncomputable def perimetreCercle (r : ℝ) : ℝ := 2 * π * r

/-- Aire du disque de rayon `r`. -/
noncomputable def aireDisque (r : ℝ) : ℝ := π * r ^ 2

/-- Aire d'un rectangle de côtés `L` et `l`. -/
def aireRectangle (L l : ℝ) : ℝ := L * l

/-- Périmètre d'un rectangle de côtés `L` et `l`. -/
def perimetreRectangle (L l : ℝ) : ℝ := 2 * (L + l)

/-- Aire d'un triangle de base `b` et de hauteur `h`. -/
noncomputable def aireTriangle (b h : ℝ) : ℝ := b * h / 2

/-- Aire d'un parallélogramme de base `b` et de hauteur `h`. -/
def aireParallelogramme (b h : ℝ) : ℝ := b * h

/-- Aire d'un trapèze de bases `B` et `b` et de hauteur `h`. -/
noncomputable def aireTrapeze (B b h : ℝ) : ℝ := (B + b) * h / 2

/-- Volume d'un pavé droit de dimensions `L`, `l`, `H`. -/
def volumePave (L l H : ℝ) : ℝ := L * l * H

/-- Volume d'un prisme ou d'un cylindre : aire de base par hauteur. -/
def volumePrisme (aireBase H : ℝ) : ℝ := aireBase * H

/-- Volume d'une pyramide ou d'un cône : le tiers du prisme de mêmes base et hauteur. -/
noncomputable def volumePyramide (aireBase H : ℝ) : ℝ := aireBase * H / 3

/-- Volume de la boule de rayon `r`. -/
noncomputable def volumeBoule (r : ℝ) : ℝ := 4 / 3 * π * r ^ 3

/-! ## Périmètre du cercle et aire du disque -/

/-- Le périmètre du cercle est proportionnel au rayon, de coefficient `2π`. -/
theorem perimetre_cercle_proportionnel (r : ℝ) : perimetreCercle r = 2 * π * r := rfl

/-- L'aire du disque n'est pas proportionnelle au rayon mais à son carré : doubler le
rayon quadruple l'aire. -/
theorem aire_disque_double_rayon (r : ℝ) : aireDisque (2 * r) = 4 * aireDisque r := by
  simp only [aireDisque]
  ring

/-! ## Aires du rectangle, du triangle, du parallélogramme et du trapèze -/

/-- Le triangle a pour aire la moitié de celle du parallélogramme de mêmes base et
hauteur. -/
theorem aire_triangle_demi_parallelogramme (b h : ℝ) :
    aireTriangle b h = aireParallelogramme b h / 2 := by
  simp only [aireTriangle, aireParallelogramme]

/-- Un parallélogramme et un rectangle de mêmes base et hauteur ont la même aire. -/
theorem aire_parallelogramme_eq_rectangle (b h : ℝ) :
    aireParallelogramme b h = aireRectangle b h := rfl

/-- Un trapèze dont les deux bases sont égales est un parallélogramme, et la formule du
trapèze redonne alors celle du parallélogramme. -/
theorem aire_trapeze_bases_egales (b h : ℝ) : aireTrapeze b b h = aireParallelogramme b h := by
  simp only [aireTrapeze, aireParallelogramme]
  ring

/-- Le trapèze a pour aire celle du rectangle construit sur la moyenne de ses bases. -/
theorem aire_trapeze_moyenne (B b h : ℝ) : aireTrapeze B b h = aireRectangle ((B + b) / 2) h := by
  simp only [aireTrapeze, aireRectangle]
  ring

/-! ## Deux figures de même aire peuvent avoir des périmètres différents -/

/-- Deux rectangles de même aire peuvent avoir des périmètres différents : `1 × 12` et
`3 × 4` ont tous deux pour aire `12`, mais leurs périmètres valent `26` et `14`. -/
example :
    aireRectangle 1 12 = aireRectangle 3 4 ∧
      perimetreRectangle 1 12 ≠ perimetreRectangle 3 4 := by
  constructor <;> simp [aireRectangle, perimetreRectangle] <;> norm_num

/-- Et réciproquement, deux rectangles de même périmètre peuvent avoir des aires
différentes : `1 × 5` et `3 × 3` ont pour périmètre `12`, pour aires `5` et `9`. -/
example :
    perimetreRectangle 1 5 = perimetreRectangle 3 3 ∧
      aireRectangle 1 5 ≠ aireRectangle 3 3 := by
  constructor <;> simp [aireRectangle, perimetreRectangle] <;> norm_num

/-! ## Volumes -/

/-- La pyramide a pour volume le tiers de celui du prisme de mêmes base et hauteur. -/
theorem volume_pyramide_tiers_prisme (aireBase H : ℝ) :
    volumePyramide aireBase H = volumePrisme aireBase H / 3 := by
  simp only [volumePyramide, volumePrisme]

/-- Le pavé droit est le prisme de base rectangulaire. -/
theorem volume_pave_eq_prisme (L l H : ℝ) :
    volumePave L l H = volumePrisme (aireRectangle L l) H := rfl

/-! ## Agrandissement-réduction de rapport `k` : longueurs `× k`, aires `× k²`, volumes `× k³` -/

/-- Un agrandissement de rapport `k` multiplie les longueurs par `k`. -/
theorem agrandissement_perimetre (k L l : ℝ) :
    perimetreRectangle (k * L) (k * l) = k * perimetreRectangle L l := by
  simp only [perimetreRectangle]
  ring

/-- Il multiplie les aires par `k²`. -/
theorem agrandissement_aire (k L l : ℝ) :
    aireRectangle (k * L) (k * l) = k ^ 2 * aireRectangle L l := by
  simp only [aireRectangle]
  ring

/-- Même chose pour le disque, où le rapport porte sur le rayon. -/
theorem agrandissement_aire_disque (k r : ℝ) : aireDisque (k * r) = k ^ 2 * aireDisque r := by
  simp only [aireDisque]
  ring

/-- Il multiplie les volumes par `k³`. -/
theorem agrandissement_volume (k L l H : ℝ) :
    volumePave (k * L) (k * l) (k * H) = k ^ 3 * volumePave L l H := by
  simp only [volumePave]
  ring

/-- Même chose pour la boule. -/
theorem agrandissement_volume_boule (k r : ℝ) :
    volumeBoule (k * r) = k ^ 3 * volumeBoule r := by
  simp only [volumeBoule]
  ring

end College.Grandeurs
