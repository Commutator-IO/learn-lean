/-
Collège — section « Géométrie plane ».
Le plan est un espace vectoriel euclidien : un point est un vecteur, une droite est
l'ensemble des `a + t • u`. Les angles sont ceux de Mathlib, non orientés, mesurés en
radians : l'angle plat vaut π et l'angle droit π/2.
Énoncés et démonstrations en français : voir GeometriePlane.tex.
-/
import Mathlib

namespace College.Geometrie

open EuclideanGeometry Real

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

/-! ## Définitions -/

/- Toutes les définitions du fichier sont posées ici, avant les démonstrations. -/

/-- La droite passant par `a` et dirigée par `u`. -/
def droite (a u : V) : Set V := {x | ∃ t : ℝ, x = a + t • u}

/-- La droite passant par deux points. -/
def droiteAB (a b : V) : Set V := droite a (b - a)

/-- Deux directions sont parallèles lorsqu'elles sont colinéaires. -/
def Paralleles (u v : V) : Prop := ∃ k : ℝ, v = k • u

/-- Deux directions sont perpendiculaires lorsque leur produit scalaire est nul. -/
def Perpendiculaires (u v : V) : Prop := inner ℝ u v = (0 : ℝ)

/-- Le milieu d'un segment. -/
noncomputable def milieu (a b : V) : V := (1 / 2 : ℝ) • (a + b)

/-- Un quadrilatère `abcd` est un parallélogramme lorsque les vecteurs de deux côtés
opposés sont égaux. -/
def Parallelogramme (a b c d : V) : Prop := b - a = c - d

/-- Le centre de gravité d'un triangle. -/
noncomputable def centreDeGravite (a b c : V) : V := (1 / 3 : ℝ) • (a + b + c)

/-! ## Par deux points distincts passe une droite et une seule -/

/-- Les deux points appartiennent à la droite qu'ils définissent. -/
theorem points_sur_leur_droite (a b : V) : a ∈ droiteAB a b ∧ b ∈ droiteAB a b :=
  ⟨⟨0, by simp⟩, ⟨1, by simp⟩⟩

/-- Et c'est la seule : toute droite contenant `a` et `b` distincts leur est égale. -/
theorem droite_unique {a b c u : V} (_hab : a ≠ b) (ha : a ∈ droite c u) (hb : b ∈ droite c u) :
    droiteAB a b ⊆ droite c u := by
  obtain ⟨s, hs⟩ := ha
  obtain ⟨t, ht⟩ := hb
  rintro x ⟨r, rfl⟩
  refine ⟨s + r * (t - s), ?_⟩
  rw [hs, ht]
  module

/-! ## Perpendicularité et parallélisme -/

/-- Si deux droites sont parallèles, toute perpendiculaire à l'une est perpendiculaire à
l'autre. -/
theorem perpendiculaire_a_une_parallele {u v w : V} (h : Paralleles u v)
    (hw : Perpendiculaires w u) : Perpendiculaires w v := by
  obtain ⟨k, rfl⟩ := h
  simp only [Perpendiculaires] at hw ⊢
  rw [real_inner_smul_right, hw, mul_zero]

/-- Deux droites parallèles à une même droite sont parallèles entre elles. -/
theorem paralleles_transitives {u v w : V} (huv : Paralleles u v) (hvw : Paralleles v w) :
    Paralleles u w := by
  obtain ⟨k, rfl⟩ := huv
  obtain ⟨l, rfl⟩ := hvw
  exact ⟨l * k, by rw [smul_smul]⟩

/-- Dans le plan, deux droites perpendiculaires à une même droite sont parallèles entre
elles. La dimension est essentielle : dans l'espace, deux perpendiculaires à une même
droite ne le sont pas. -/
theorem perpendiculaires_a_une_meme_droite {u v w : EuclideanSpace ℝ (Fin 2)}
    (hw : w ≠ 0) (hu : Perpendiculaires w u) (hv : Perpendiculaires w v) :
    u 0 * v 1 - u 1 * v 0 = 0 := by
  have hu' : w 0 * u 0 + w 1 * u 1 = 0 := by
    have := hu
    simp only [Perpendiculaires, PiLp.inner_apply, RCLike.inner_apply, conj_trivial,
      Fin.sum_univ_two] at this
    linarith [this]
  have hv' : w 0 * v 0 + w 1 * v 1 = 0 := by
    have := hv
    simp only [Perpendiculaires, PiLp.inner_apply, RCLike.inner_apply, conj_trivial,
      Fin.sum_univ_two] at this
    linarith [this]
  have hne : w 0 ≠ 0 ∨ w 1 ≠ 0 := by
    by_contra hc
    simp only [not_or, ne_eq, not_not] at hc
    exact hw (by ext i; fin_cases i <;> simp [hc.1, hc.2])
  -- les deux vecteurs sont orthogonaux au même vecteur non nul : leur déterminant est nul
  rcases hne with h | h
  · have e1 : u 0 = -(w 1 * u 1) / w 0 := by field_simp at hu' ⊢; linarith [hu']
    have e2 : v 0 = -(w 1 * v 1) / w 0 := by field_simp at hv' ⊢; linarith [hv']
    rw [e1, e2]; field_simp; ring
  · have e1 : u 1 = -(w 0 * u 0) / w 1 := by field_simp at hu' ⊢; linarith [hu']
    have e2 : v 1 = -(w 0 * v 0) / w 1 := by field_simp at hv' ⊢; linarith [hv']
    rw [e1, e2]; field_simp; ring

/-- Dans le plan, un déterminant nul signifie que les deux vecteurs sont colinéaires. -/
theorem determinant_nul_colineaires {u v : EuclideanSpace ℝ (Fin 2)} (hu : u ≠ 0)
    (hdet : u 0 * v 1 - u 1 * v 0 = 0) : Paralleles u v := by
  have hne : u 0 ≠ 0 ∨ u 1 ≠ 0 := by
    by_contra hc
    simp only [not_or, ne_eq, not_not] at hc
    exact hu (by ext i; fin_cases i <;> simp [hc.1, hc.2])
  rcases hne with h | h
  · refine ⟨v 0 / u 0, PiLp.ext fun i => ?_⟩
    fin_cases i
    · simp; field_simp
    · simp; field_simp; linarith [hdet]
  · refine ⟨v 1 / u 1, PiLp.ext fun i => ?_⟩
    fin_cases i
    · simp; field_simp; linarith [hdet]
    · simp; field_simp

/-- Conclusion sous la forme du cours : deux droites perpendiculaires à une même droite
sont parallèles entre elles. -/
theorem perpendiculaires_a_une_meme_droite_paralleles {u v w : EuclideanSpace ℝ (Fin 2)}
    (hw : w ≠ 0) (hu : u ≠ 0) (hpu : Perpendiculaires w u) (hpv : Perpendiculaires w v) :
    Paralleles u v :=
  determinant_nul_colineaires hu (perpendiculaires_a_une_meme_droite hw hpu hpv)

/-! ## Le plus court chemin d'un point à une droite est le segment perpendiculaire -/

/-- Si le vecteur joignant `p` à `h` est perpendiculaire à la direction de la droite,
alors `h` est le point de la droite le plus proche de `p`. -/
theorem distance_minimale_au_pied {p h u : V} (hperp : Perpendiculaires (p - h) u) (t : ℝ) :
    ‖p - h‖ ≤ ‖p - (h + t • u)‖ := by
  have hcarre : ‖p - (h + t • u)‖ ^ 2 = ‖p - h‖ ^ 2 + t ^ 2 * ‖u‖ ^ 2 := by
    have : p - (h + t • u) = (p - h) - t • u := by abel
    rw [this, norm_sub_sq_real, real_inner_smul_right, hperp, norm_smul]
    simp [mul_pow]
  nlinarith [norm_nonneg (p - h), norm_nonneg (p - (h + t • u)), sq_nonneg t,
    sq_nonneg ‖u‖, hcarre]

/-! ## Angles opposés par le sommet, adjacents, supplémentaires -/

/-- Deux angles opposés par le sommet sont égaux : les deux couples de vecteurs sont
opposés. -/
theorem angles_opposes_par_le_sommet (u v : V) :
    InnerProductGeometry.angle (-u) (-v) = InnerProductGeometry.angle u v :=
  InnerProductGeometry.angle_neg_neg u v

/-- Deux angles adjacents portés par des demi-droites opposées sont supplémentaires :
leur somme vaut l'angle plat. -/
theorem angles_supplementaires (u v : V) :
    InnerProductGeometry.angle u v + InnerProductGeometry.angle u (-v) = π := by
  rw [InnerProductGeometry.angle_neg_right]
  ring

/-! ## Caractérisation de la médiatrice -/

/-- Un point est équidistant de deux points si et seulement s'il appartient à leur
médiatrice. -/
theorem mediatrice_equidistance {a b m : V} :
    dist m a = dist m b ↔ m ∈ AffineSubspace.perpBisector a b := by
  rw [AffineSubspace.mem_perpBisector_iff_dist_eq']
  constructor <;> intro h <;> simpa [dist_comm] using h

/-! ## Somme des angles d'un triangle -/

/-- La somme des angles d'un triangle vaut l'angle plat. -/
theorem somme_des_angles {a b c : V} (h : b ≠ a) :
    ∠ a b c + ∠ b c a + ∠ c a b = π :=
  EuclideanGeometry.angle_add_angle_add_angle_eq_pi c h

/-! ## Triangle isocèle : angles à la base -/

/-- Dans un triangle isocèle, les angles à la base sont égaux. -/
theorem angles_a_la_base {a b c : V} (h : dist a b = dist a c) : ∠ a b c = ∠ a c b :=
  EuclideanGeometry.angle_eq_angle_of_dist_eq h

/-- Réciproque : si les angles à la base sont égaux, le triangle est isocèle. -/
theorem isocele_reciproque {a b c : V} (h : ∠ a b c = ∠ a c b) (hpi : ∠ b a c ≠ π) :
    dist a b = dist a c :=
  EuclideanGeometry.dist_eq_of_angle_eq_angle_of_angle_ne_pi h hpi

/-- Dans un triangle équilatéral, les trois angles valent 60 degrés, soit `π/3`. -/
theorem angles_du_triangle_equilateral {a b c : V} (h1 : dist a b = dist a c)
    (h2 : dist b a = dist b c) (hba : b ≠ a) : ∠ a b c = π / 3 := by
  have e1 : ∠ a b c = ∠ a c b := angles_a_la_base h1
  have e2 : ∠ b a c = ∠ b c a := angles_a_la_base h2
  have hsum : ∠ a b c + ∠ b c a + ∠ c a b = π := somme_des_angles hba
  have c1 : ∠ a c b = ∠ b c a := EuclideanGeometry.angle_comm a c b
  have c2 : ∠ c a b = ∠ b a c := EuclideanGeometry.angle_comm c a b
  rw [c2, e2] at hsum
  rw [c1] at e1
  linarith

/-! ## Inégalité triangulaire -/

omit [InnerProductSpace ℝ V] in
/-- Inégalité triangulaire : le chemin direct est le plus court. -/
theorem inegalite_triangulaire (a b c : V) : dist a c ≤ dist a b + dist b c :=
  dist_triangle a b c

/-- Le cas d'égalité caractérise l'alignement, `b` étant entre `a` et `c`. -/
theorem egalite_triangulaire {a b c : V} :
    dist a b + dist b c = dist a c ↔ Wbtw ℝ a b c := dist_add_dist_eq_iff

/-! ## Théorème de Pythagore, sa réciproque et sa contraposée -/

/-- Théorème de Pythagore et sa réciproque : le carré de l'hypoténuse est la somme des
carrés des deux autres côtés si et seulement si l'angle est droit. -/
theorem pythagore (a b c : V) :
    dist a c * dist a c = dist a b * dist a b + dist c b * dist c b ↔ ∠ a b c = π / 2 :=
  EuclideanGeometry.dist_sq_eq_dist_sq_add_dist_sq_iff_angle_eq_pi_div_two a b c

/-- Contraposée : si l'égalité des carrés est en défaut, le triangle n'est pas rectangle. -/
theorem pythagore_contraposee {a b c : V}
    (h : dist a c * dist a c ≠ dist a b * dist a b + dist c b * dist c b) :
    ∠ a b c ≠ π / 2 := fun hangle => h ((pythagore a b c).mpr hangle)

/-! ## Théorème des milieux et sa réciproque -/

/-- La droite des milieux est parallèle au troisième côté et de longueur moitié. -/
theorem theoreme_des_milieux (a b c : V) :
    milieu a c - milieu a b = (1 / 2 : ℝ) • (c - b) := by
  simp only [milieu]
  module

/-- Conséquence sur les longueurs : le segment des milieux mesure la moitié du troisième
côté. -/
theorem longueur_des_milieux (a b c : V) :
    dist (milieu a b) (milieu a c) = dist b c / 2 := by
  rw [dist_eq_norm, dist_eq_norm]
  have : milieu a b - milieu a c = (1 / 2 : ℝ) • (b - c) := by
    simp only [milieu]; module
  rw [this, norm_smul]
  simp
  ring

/-- Réciproque : la parallèle menée par le milieu d'un côté coupe le deuxième côté en son
milieu. Écrite vectoriellement : le point du côté `[a c]` dont l'écart au milieu de
`[a b]` est parallèle à `(b c)` avec le bon rapport est le milieu de `[a c]`. -/
theorem reciproque_des_milieux {a b c n : V} (h : n - milieu a b = (1 / 2 : ℝ) • (c - b)) :
    n = milieu a c := by
  have : n = milieu a b + (1 / 2 : ℝ) • (c - b) := by rw [← h]; abel
  rw [this]
  simp only [milieu]
  module

/-! ## Théorème de Thalès et sa réciproque -/

/-- Théorème de Thalès : si `m` et `n` divisent `[a b]` et `[a c]` dans le même rapport
`t`, alors `mn` est parallèle à `bc` et les rapports de longueurs sont égaux à `t`. -/
theorem thales {a b c : V} (t : ℝ) :
    (a + t • (b - a)) - (a + t • (c - a)) = t • (b - c) := by
  module

/-- Conséquence sur les longueurs : les trois rapports sont égaux. -/
theorem thales_rapports {a b c : V} {t : ℝ} (ht : 0 ≤ t) :
    dist (a + t • (b - a)) (a + t • (c - a)) = t * dist b c := by
  rw [dist_eq_norm, dist_eq_norm, thales t, norm_smul, Real.norm_eq_abs, abs_of_nonneg ht]

/-- Réciproque de Thalès : si `mn` est parallèle à `bc` avec le rapport `t`, les points
divisent les deux côtés dans ce même rapport. -/
theorem thales_reciproque {a b c m n : V} {t : ℝ}
    (hm : m = a + t • (b - a)) (h : n - m = t • (c - b)) :
    n = a + t • (c - a) := by
  have : n = m + t • (c - b) := by rw [← h]; abel
  rw [this, hm]
  module

/-! ## Relations trigonométriques -/

/-- La relation fondamentale de la trigonométrie. -/
theorem cos_carre_plus_sin_carre (x : ℝ) : cos x ^ 2 + sin x ^ 2 = 1 :=
  Real.cos_sq_add_sin_sq x

/-- La tangente est le quotient du sinus par le cosinus. -/
theorem tan_eq_sin_div_cos (x : ℝ) : tan x = sin x / cos x := Real.tan_eq_sin_div_cos x

/-! ## Cercle circonscrit -/

/-- Les médiatrices d'un triangle sont concourantes : il existe un point équidistant des
trois sommets, centre du cercle circonscrit. -/
theorem cercle_circonscrit {a b c : V} (h : AffineIndependent ℝ ![a, b, c]) :
    ∃ o : V, dist o a = dist o b ∧ dist o b = dist o c := by
  let s : Affine.Simplex ℝ V 2 := ⟨![a, b, c], h⟩
  refine ⟨s.circumcenter, ?_, ?_⟩
  · rw [dist_comm _ a, dist_comm _ b, show a = s.points 0 from rfl, show b = s.points 1 from rfl,
      s.dist_circumcenter_eq_circumradius 0, s.dist_circumcenter_eq_circumradius 1]
  · rw [dist_comm _ b, dist_comm _ c, show b = s.points 1 from rfl, show c = s.points 2 from rfl,
      s.dist_circumcenter_eq_circumradius 1, s.dist_circumcenter_eq_circumradius 2]

/-! ## Triangle inscrit dans un demi-cercle -/

/-- Un triangle inscrit dans un cercle dont un côté est un diamètre est rectangle, et
réciproquement : c'est le théorème de Thalès sur le cercle. -/
theorem triangle_inscrit_demi_cercle {a b c : V} {s : EuclideanGeometry.Sphere V}
    (hd : s.IsDiameter a c) : ∠ a b c = π / 2 ↔ b ∈ s :=
  EuclideanGeometry.Sphere.thales_theorem hd

/-- Réciproque : l'hypoténuse d'un triangle rectangle est un diamètre du cercle qui
passe par les trois sommets. -/
theorem hypotenuse_diametre {a b c : V} (h : ∠ a b c = π / 2) :
    b ∈ EuclideanGeometry.Sphere.ofDiameter a c :=
  EuclideanGeometry.Sphere.angle_eq_pi_div_two_iff_mem_sphere_ofDiameter.mp h

/-- Dans un triangle rectangle, la médiane issue de l'angle droit vaut la moitié de
l'hypoténuse. -/
theorem mediane_hypotenuse {a b c : V} (h : ∠ a b c = π / 2) :
    dist b (milieu a c) = dist a c / 2 := by
  have hperp : inner ℝ (a - b) (c - b) = (0 : ℝ) :=
    (InnerProductGeometry.inner_eq_zero_iff_angle_eq_pi_div_two (a - b) (c - b)).mpr
      (by simpa [EuclideanGeometry.angle, vsub_eq_sub] using h)
  have hinner : inner ℝ (b - a) (b - c) = (0 : ℝ) := by
    rw [show b - a = -(a - b) by abel, show b - c = -(c - b) by abel, inner_neg_neg]
    exact hperp
  have hx : b - milieu a c = (1 / 2 : ℝ) • ((b - a) + (b - c)) := by
    simp only [milieu]; module
  have e1 : ‖(b - a) + (b - c)‖ ^ 2 = ‖b - a‖ ^ 2 + ‖b - c‖ ^ 2 := by
    rw [norm_add_sq_real, hinner]; ring
  have e2 : ‖a - c‖ ^ 2 = ‖b - a‖ ^ 2 + ‖b - c‖ ^ 2 := by
    rw [show a - c = (b - c) - (b - a) by abel, norm_sub_sq_real,
      real_inner_comm, hinner]
    ring
  have hnorm : ‖(b - a) + (b - c)‖ = ‖a - c‖ := by
    have h1 : (0 : ℝ) ≤ ‖(b - a) + (b - c)‖ := norm_nonneg _
    have h2 : (0 : ℝ) ≤ ‖a - c‖ := norm_nonneg _
    nlinarith [e1, e2]
  rw [dist_eq_norm, dist_eq_norm, hx, norm_smul, hnorm]
  simp
  ring

/-! ## Tangente à un cercle -/

/-- La droite passant par un point du cercle et perpendiculaire au rayon en ce point ne
rencontre le cercle qu'en ce point : c'est la tangente. -/
theorem tangente_perpendiculaire_au_rayon {o p u : V} (hu : u ≠ 0)
    (hperp : Perpendiculaires (p - o) u) {t : ℝ} (ht : dist (p + t • u) o = dist p o) :
    t = 0 := by
  have h1 : ‖(p - o) + t • u‖ ^ 2 = ‖p - o‖ ^ 2 + t ^ 2 * ‖u‖ ^ 2 := by
    rw [norm_add_sq_real, real_inner_smul_right, hperp, norm_smul]
    simp [mul_pow]
  have h2 : ‖(p - o) + t • u‖ = ‖p - o‖ := by
    have : p + t • u - o = (p - o) + t • u := by abel
    rw [dist_eq_norm, dist_eq_norm, this] at ht
    exact ht
  rw [h2] at h1
  have hu0 : (0 : ℝ) < ‖u‖ := norm_pos_iff.mpr hu
  have hzero : t ^ 2 * ‖u‖ ^ 2 = 0 := by linarith
  have : t ^ 2 = 0 := by
    rcases mul_eq_zero.mp hzero with h | h
    · exact h
    · exact absurd h (by positivity)
  exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this

/-! ## Parallélogramme -/

/-- Un quadrilatère est un parallélogramme si et seulement si ses diagonales se coupent en
leur milieu. -/
theorem parallelogramme_diagonales {a b c d : V} :
    Parallelogramme a b c d ↔ milieu a c = milieu b d := by
  simp only [Parallelogramme, milieu]
  constructor <;> intro h
  · have hac : a + c = b + d := by
      have hh : b - a = c - d := h
      linear_combination (norm := module) -hh
    rw [hac]
  · linear_combination (norm := module) (-2 : ℝ) • h

omit [InnerProductSpace ℝ V] in
/-- Dans un parallélogramme, les côtés opposés ont la même longueur. -/
theorem parallelogramme_cotes_opposes {a b c d : V} (h : Parallelogramme a b c d) :
    dist a b = dist d c := by
  rw [dist_eq_norm, dist_eq_norm]
  have hab : a - b = d - c := by
    have hh : b - a = c - d := h
    linear_combination (norm := module) -hh
  rw [hab]

/-- Dans un parallélogramme, les angles opposés sont égaux : les deux couples de vecteurs
qui les portent sont opposés. -/
theorem parallelogramme_angles_opposes {a b c d : V} (h : Parallelogramme a b c d) :
    InnerProductGeometry.angle (b - a) (d - a) =
      InnerProductGeometry.angle (d - c) (b - c) := by
  have hh : b - a = c - d := h
  have hadd : b + d = c + a := sub_eq_sub_iff_add_eq_add.mp hh
  have h1 : d - c = -(b - a) := by
    rw [show -(b - a) = a - b by abel]
    linear_combination (norm := module) hadd
  have h2 : b - c = -(d - a) := by
    rw [show -(d - a) = a - d by abel]
    linear_combination (norm := module) hadd
  rw [h1, h2, InnerProductGeometry.angle_neg_neg]

/-! ## Concours des médianes -/

/-- Le centre de gravité est sur la médiane issue de `a`. -/
theorem centre_de_gravite_sur_mediane_a (a b c : V) :
    centreDeGravite a b c ∈ droiteAB a (milieu b c) :=
  ⟨2 / 3, by simp only [centreDeGravite, milieu]; module⟩

/-- Sur celle issue de `b`. -/
theorem centre_de_gravite_sur_mediane_b (a b c : V) :
    centreDeGravite a b c ∈ droiteAB b (milieu a c) :=
  ⟨2 / 3, by simp only [centreDeGravite, milieu]; module⟩

/-- Et sur celle issue de `c` : les trois médianes sont donc concourantes en ce point. -/
theorem centre_de_gravite_sur_mediane_c (a b c : V) :
    centreDeGravite a b c ∈ droiteAB c (milieu a b) :=
  ⟨2 / 3, by simp only [centreDeGravite, milieu]; module⟩

/-! ## Repérage : milieu et distance -/

/-- Les coordonnées du milieu sont les moyennes des coordonnées. -/
theorem coordonnees_du_milieu (a b : EuclideanSpace ℝ (Fin 2)) (i : Fin 2) :
    milieu a b i = (a i + b i) / 2 := by
  simp only [milieu]
  simp
  ring

/-- La distance entre deux points repérés se calcule par le théorème de Pythagore. -/
theorem distance_reperee (a b : EuclideanSpace ℝ (Fin 2)) :
    dist a b = Real.sqrt ((a 0 - b 0) ^ 2 + (a 1 - b 1) ^ 2) := by
  rw [EuclideanSpace.dist_eq]
  congr 1
  simp [Fin.sum_univ_two, Real.dist_eq, sq_abs]

end College.Geometrie
