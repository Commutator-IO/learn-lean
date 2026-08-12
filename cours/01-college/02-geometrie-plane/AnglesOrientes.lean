/-
Collège — angles alternes-internes et correspondants.

Ces énoncés demandent des angles *orientés* : deux angles alternes-internes ont même
mesure non orientée sans être le même angle, et la réciproque — l'égalité des angles
entraîne le parallélisme — est fausse si l'on oublie l'orientation. On travaille donc dans
un plan orienté, ce qu'impose l'hypothèse `Fact (finrank ℝ V = 2)` : elle vaut pour tout
le fichier, d'où sa séparation d'avec GeometriePlane.lean.
Énoncés et démonstrations en français : voir GeometriePlane.tex.
-/
import Mathlib

namespace College.Geometrie

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
  [Fact (Module.finrank ℝ V = 2)] (o : Orientation ℝ V (Fin 2))

/-! ## Deux parallèles coupées par une sécante : angles correspondants -/

/-- Deux droites parallèles coupées par une sécante font avec elle des angles
correspondants égaux : changer la droite pour une parallèle de même sens ne change pas
l'angle orienté qu'elle fait avec la sécante. -/
theorem angles_correspondants (u w : V) {k : ℝ} (hk : 0 < k) :
    o.oangle (k • u) w = o.oangle u w :=
  o.oangle_smul_left_of_pos u w hk

/-! ## Angles alternes-internes -/

/-- Les angles alternes-internes sont égaux : ils se déduisent des angles correspondants
en retournant les deux demi-droites, ce qui laisse l'angle orienté inchangé. -/
theorem angles_alternes_internes (u w : V) {k : ℝ} (hk : 0 < k) :
    o.oangle (k • u) w = o.oangle (-u) (-w) := by
  rw [o.oangle_smul_left_of_pos u w hk, o.oangle_neg_neg]

/-! ## Réciproque : égalité des angles alternes-internes ⟹ parallélisme -/

/-- Réciproque : si deux droites font le même angle orienté avec une sécante, elles sont
parallèles. C'est ce sens qui sert à démontrer qu'un quadrilatère est un parallélogramme,
ou qu'une droite est parallèle à une autre. -/
theorem paralleles_de_angles_egaux {u v w : V} (hu : u ≠ 0) (hv : v ≠ 0) (hw : w ≠ 0)
    (h : o.oangle u w = o.oangle v w) : ∃ k : ℝ, v = k • u := by
  have hsomme : o.oangle u w + o.oangle w v = o.oangle u v := o.oangle_add hu hw hv
  have hrev : o.oangle v w + o.oangle w v = 0 := o.oangle_add_oangle_rev v w
  have hzero : o.oangle u v = 0 := by
    rw [← hsomme, h]
    exact hrev
  rcases (o.oangle_eq_zero_or_eq_pi_iff_right_eq_smul).mp (Or.inl hzero) with h0 | h1
  · exact absurd h0 hu
  · exact h1

/-- Sous la forme du cours : les deux droites ont des directions colinéaires, donc elles
sont parallèles. -/
theorem paralleles_de_angles_alternes_internes {u v w : V} (hu : u ≠ 0) (hv : v ≠ 0)
    (hw : w ≠ 0) (h : o.oangle u w = o.oangle (-v) (-w)) : ∃ k : ℝ, v = k • u := by
  rw [o.oangle_neg_neg] at h
  exact paralleles_de_angles_egaux o hu hv hw h

end College.Geometrie
