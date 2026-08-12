/-
Collège — section « Transformations du plan ».
Le plan est vu comme un espace vectoriel euclidien : un point est un vecteur, une droite
est l'ensemble des `a + t • u`, et les transformations s'écrivent avec les opérations
vectorielles. C'est le prix à payer pour parler de figures sans dessin.
Énoncés et démonstrations en français : voir TransformationsDuPlan.tex.
-/
import Mathlib

namespace College.Transformations

open EuclideanGeometry

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

/-! ## Définitions -/

/- Toutes les définitions du fichier sont posées ici, avant les démonstrations. -/

/-- Translation de vecteur `v`. -/
def translation (v : V) : V → V := fun x => x + v

/-- Symétrie centrale de centre `c`, ou demi-tour. -/
def symetrieCentrale (c : V) : V → V := fun x => 2 • c - x

/-- Homothétie de centre `c` et de rapport `k`. -/
def homothetie (c : V) (k : ℝ) : V → V := fun x => c + k • (x - c)

/-- La droite passant par `a` et dirigée par `u`. -/
def droite (a u : V) : Set V := {x | ∃ t : ℝ, x = a + t • u}

/-! ## Conservation des longueurs, des angles et de l'alignement -/

/-- La translation conserve les distances. -/
theorem translation_conserve_distances (v x y : V) :
    dist (translation v x) (translation v y) = dist x y := by
  simp [translation, dist_eq_norm]

/-- La symétrie centrale conserve les distances. -/
theorem symetrie_centrale_conserve_distances (c x y : V) :
    dist (symetrieCentrale c x) (symetrieCentrale c y) = dist x y := by
  simp only [symetrieCentrale, dist_eq_norm]
  rw [show 2 • c - x - (2 • c - y) = y - x by abel, norm_sub_rev]

/-- La translation conserve les angles : les vecteurs qui les portent sont inchangés. -/
theorem translation_conserve_angles (v x y z : V) :
    ∠ (translation v x) (translation v y) (translation v z) = ∠ x y z := by
  simp only [translation, EuclideanGeometry.angle, vsub_eq_sub]
  rw [show x + v - (y + v) = x - y by abel, show z + v - (y + v) = z - y by abel]

/-- La symétrie centrale conserve les angles : elle change les deux vecteurs en leurs
opposés, ce qui laisse l'angle inchangé. -/
theorem symetrie_centrale_conserve_angles (c x y z : V) :
    ∠ (symetrieCentrale c x) (symetrieCentrale c y) (symetrieCentrale c z) = ∠ x y z := by
  simp only [symetrieCentrale, EuclideanGeometry.angle, vsub_eq_sub]
  rw [show 2 • c - x - (2 • c - y) = -(x - y) by abel,
      show 2 • c - z - (2 • c - y) = -(z - y) by abel,
      InnerProductGeometry.angle_neg_neg]

/-- La translation conserve l'alignement : l'image d'un point d'une droite est sur
l'image de la droite. -/
theorem translation_conserve_alignement (v a u x : V) (h : x ∈ droite a u) :
    translation v x ∈ droite (a + v) u := by
  obtain ⟨t, ht⟩ := h
  exact ⟨t, by rw [translation, ht]; abel⟩

/-! ## La symétrie centrale transforme une droite en une droite parallèle -/

/-- L'image d'une droite par une symétrie centrale est une droite de vecteur directeur
opposé : les deux droites sont donc parallèles. -/
theorem symetrie_centrale_image_droite (c a u : V) :
    symetrieCentrale c '' droite a u = droite (symetrieCentrale c a) (-u) := by
  ext y
  constructor
  · rintro ⟨x, ⟨t, rfl⟩, rfl⟩
    exact ⟨t, by simp [symetrieCentrale]; abel⟩
  · rintro ⟨t, rfl⟩
    exact ⟨a + t • u, ⟨t, rfl⟩, by simp [symetrieCentrale]; abel⟩

/-! ## Composition de deux symétries centrales = translation -/

/-- Composer deux demi-tours donne une translation, de vecteur le double de celui qui
joint les deux centres. -/
theorem composition_symetries_centrales (c c' x : V) :
    symetrieCentrale c' (symetrieCentrale c x) = translation (2 • (c' - c)) x := by
  simp [symetrieCentrale, translation, smul_sub]
  abel

/-- En particulier, deux demi-tours de même centre se compensent. -/
theorem symetrie_centrale_involutive (c x : V) :
    symetrieCentrale c (symetrieCentrale c x) = x := by
  simp [symetrieCentrale]

/-! ## Homothétie de rapport `k` : longueurs multipliées par `|k|` -/

/-- Une homothétie de rapport `k` multiplie les distances par `|k|`. -/
theorem homothetie_multiplie_distances (c : V) (k : ℝ) (x y : V) :
    dist (homothetie c k x) (homothetie c k y) = |k| * dist x y := by
  simp only [homothetie, dist_eq_norm]
  rw [show c + k • (x - c) - (c + k • (y - c)) = k • (x - y) by
        rw [smul_sub, smul_sub, smul_sub]; abel]
  rw [norm_smul, Real.norm_eq_abs]

/-- Une homothétie de rapport strictement positif conserve les angles. -/
theorem homothetie_conserve_angles (c : V) {k : ℝ} (hk : 0 < k) (x y z : V) :
    ∠ (homothetie c k x) (homothetie c k y) (homothetie c k z) = ∠ x y z := by
  simp only [homothetie, EuclideanGeometry.angle, vsub_eq_sub]
  rw [show c + k • (x - c) - (c + k • (y - c)) = k • (x - y) by
        rw [smul_sub, smul_sub, smul_sub]; abel,
      show c + k • (z - c) - (c + k • (y - c)) = k • (z - y) by
        rw [smul_sub, smul_sub, smul_sub]; abel,
      InnerProductGeometry.angle_smul_left_of_pos _ _ hk,
      InnerProductGeometry.angle_smul_right_of_pos _ _ hk]

/-- L'image d'une droite par une homothétie est une droite de vecteur directeur
proportionnel : les deux droites sont parallèles. -/
theorem homothetie_image_droite (c : V) (k : ℝ) (a u : V) :
    homothetie c k '' droite a u = droite (homothetie c k a) (k • u) := by
  ext y
  constructor
  · rintro ⟨x, ⟨t, rfl⟩, rfl⟩
    refine ⟨t, ?_⟩
    simp only [homothetie, smul_smul, smul_sub, smul_add]
    rw [mul_comm t k, ← smul_smul]
    abel
  · rintro ⟨t, rfl⟩
    refine ⟨a + t • u, ⟨t, rfl⟩, ?_⟩
    simp only [homothetie, smul_smul, smul_sub, smul_add]
    rw [mul_comm k t, ← smul_smul]
    abel

/-! ## Figures semblables : angles égaux et longueurs proportionnelles -/

/-- Dans une figure agrandie par une homothétie de rapport `k`, le rapport de deux
longueurs est inchangé : c'est la proportionnalité des longueurs des figures
semblables. -/
theorem homothetie_conserve_rapports (c : V) {k : ℝ} (hk : k ≠ 0) (x y z w : V)
    (h : dist z w ≠ 0) :
    dist (homothetie c k x) (homothetie c k y) / dist (homothetie c k z) (homothetie c k w)
      = dist x y / dist z w := by
  rw [homothetie_multiplie_distances, homothetie_multiplie_distances]
  rw [mul_div_mul_left _ _ (abs_ne_zero.mpr hk)]

end College.Transformations
