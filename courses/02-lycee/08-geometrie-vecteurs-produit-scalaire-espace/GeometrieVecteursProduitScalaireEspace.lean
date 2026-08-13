/-
Lycée — section « Géométrie : vecteurs, produit scalaire, espace ».
Le plan repéré est `EuclideanSpace ℝ (Fin 2)` et l'espace `EuclideanSpace ℝ (Fin 3)` :
un point y est la fonction de ses coordonnées, `a 0` et `a 1` (et `a 2` dans l'espace),
et la distance est la distance euclidienne. Les énoncés qui ne parlent pas de coordonnées
sont écrits dans un espace préhilbertien quelconque, comme au programme.
Le produit scalaire est celui de Mathlib, `inner ℝ u v`, noté `⟪u, v⟫` dans les
transcriptions.
Énoncés et démonstrations en français : voir GeometrieVecteursProduitScalaireEspace.tex.
-/
import Mathlib

namespace Lycee.Geometrie

open EuclideanGeometry InnerProductGeometry

/-! ## Vecteurs : Chasles et colinéarité -/

/-- Relation de Chasles pour les vecteurs. -/
theorem relation_de_chasles {V : Type*} [AddCommGroup V] (a b c : V) :
    (b - a) + (c - b) = c - a := by abel

/-- Deux vecteurs sont colinéaires si et seulement si l'un appartient à la droite
vectorielle engendrée par l'autre : c'est la traduction vectorielle du parallélisme. -/
theorem colinearite_et_parallelisme {V : Type*} [AddCommGroup V] [Module ℝ V] (u v : V) :
    (∃ k : ℝ, v = k • u) ↔ v ∈ Submodule.span ℝ ({u} : Set V) := by
  rw [Submodule.mem_span_singleton]
  constructor
  · rintro ⟨k, rfl⟩
    exact ⟨k, rfl⟩
  · rintro ⟨k, rfl⟩
    exact ⟨k, rfl⟩

/-- Critère de colinéarité par le déterminant : deux vecteurs du plan sont colinéaires si
et seulement si `xy' − x'y = 0`. -/
theorem critere_de_colinearite {u v : EuclideanSpace ℝ (Fin 2)} (hu : u ≠ 0) :
    (∃ k : ℝ, v = k • u) ↔ u 0 * v 1 - u 1 * v 0 = 0 := by
  have hne : u 0 ≠ 0 ∨ u 1 ≠ 0 := by
    by_contra hc
    simp only [not_or, ne_eq, not_not] at hc
    exact hu (by ext i; fin_cases i <;> simp [hc.1, hc.2])
  constructor
  · rintro ⟨k, rfl⟩
    simp only [PiLp.smul_apply, smul_eq_mul]
    ring
  · intro hdet
    rcases hne with h | h
    · refine ⟨v 0 / u 0, PiLp.ext fun i => ?_⟩
      fin_cases i
      · simp; field_simp
      · simp; field_simp; linarith [hdet]
    · refine ⟨v 1 / u 1, PiLp.ext fun i => ?_⟩
      fin_cases i
      · simp; field_simp; linarith [hdet]
      · simp; field_simp

/-! ## Système linéaire et base du plan -/

/-- Un système linéaire `2 × 2` de déterminant non nul a une solution et une seule, donnée
par les formules de Cramer. -/
theorem systeme_lineaire_2x2 {a b c d e f : ℝ} (h : a * d - b * c ≠ 0) :
    ∃! p : ℝ × ℝ, a * p.1 + b * p.2 = e ∧ c * p.1 + d * p.2 = f := by
  have h1 : d * a - c * b ≠ 0 := fun hc => h (by linarith)
  have h2 : -(c * b) + d * a ≠ 0 := fun hc => h (by linarith)
  have h3 : a * d - c * b ≠ 0 := fun hc => h (by linarith)
  refine ⟨((e * d - b * f) / (a * d - b * c), (a * f - e * c) / (a * d - b * c)), ⟨?_, ?_⟩, ?_⟩
  · field_simp
    ring
  · field_simp
    ring
  · rintro ⟨u, v⟩ ⟨hu, hv⟩
    simp only at hu hv
    have eu : u * (a * d - b * c) = e * d - b * f := by linear_combination d * hu - b * hv
    have ev : v * (a * d - b * c) = a * f - e * c := by linear_combination a * hv - c * hu
    simp only [Prod.mk.injEq]
    constructor
    · rw [eq_div_iff h]
      linear_combination eu
    · rw [eq_div_iff h]
      linear_combination ev

/-- Décomposition unique d'un vecteur du plan dans une base : si le déterminant de deux
vecteurs est non nul, tout vecteur s'écrit d'une seule façon comme combinaison des deux. -/
theorem decomposition_dans_une_base {u v : EuclideanSpace ℝ (Fin 2)}
    (hdet : u 0 * v 1 - v 0 * u 1 ≠ 0) (w : EuclideanSpace ℝ (Fin 2)) :
    ∃! p : ℝ × ℝ, w = p.1 • u + p.2 • v := by
  obtain ⟨p, hp, huniq⟩ := systeme_lineaire_2x2 (a := u 0) (b := v 0) (c := u 1) (d := v 1)
    (e := w 0) (f := w 1) hdet
  refine ⟨p, ?_, ?_⟩
  · refine PiLp.ext fun i => ?_
    fin_cases i
    · simp
      linarith [hp.1]
    · simp
      linarith [hp.2]
  · intro q hq
    have h0 := congrArg (fun z : EuclideanSpace ℝ (Fin 2) => z 0) hq
    have h1 := congrArg (fun z : EuclideanSpace ℝ (Fin 2) => z 1) hq
    simp only [PiLp.add_apply, PiLp.smul_apply, smul_eq_mul] at h0 h1
    exact huniq q ⟨by linarith [h0], by linarith [h1]⟩

/-! ## Milieu et distance -/

/-- Coordonnées du milieu de deux points, et distance de deux points. -/
theorem milieu_et_distance (a b : EuclideanSpace ℝ (Fin 2)) :
    (∀ i, midpoint ℝ a b i = (a i + b i) / 2) ∧
      dist a b = Real.sqrt ((b 0 - a 0) ^ 2 + (b 1 - a 1) ^ 2) := by
  constructor
  · intro i
    simp [midpoint_eq_smul_add, invOf_eq_inv]
    ring
  · rw [EuclideanSpace.dist_eq]
    congr 1
    simp [Fin.sum_univ_two, Real.dist_eq, sq_abs]
    ring

/-! ## Équation de droite -/

/-- Une droite non verticale d'équation `y = mx + p` a aussi une équation cartésienne
`mx − y + p = 0` ; deux telles droites sont strictement parallèles si et seulement si
elles ont même coefficient directeur et des ordonnées à l'origine différentes. -/
theorem equation_de_droite (m p : ℝ) :
    (∀ x y : ℝ, y = m * x + p ↔ m * x - y + p = 0) ∧
      ∀ m' p' : ℝ, ((∀ x : ℝ, m * x + p ≠ m' * x + p') ↔ m = m' ∧ p ≠ p') := by
  constructor
  · intro x y
    constructor <;> intro h <;> linarith
  · intro m' p'
    constructor
    · intro h
      constructor
      · by_contra hm
        refine h ((p' - p) / (m - m')) ?_
        have hmm : m - m' ≠ 0 := sub_ne_zero.mpr hm
        field_simp
        ring
      · intro hp
        exact h 0 (by simp [hp])
    · rintro ⟨rfl, hp⟩ x h
      exact hp (by linarith)

/-! ## Produit scalaire -/

/-- Définitions équivalentes du produit scalaire : par les normes (identité de
polarisation), par les coordonnées, et par le cosinus de l'angle. -/
theorem produit_scalaire_definitions {V : Type*} [NormedAddCommGroup V]
    [InnerProductSpace ℝ V] (u v : V) (a b : EuclideanSpace ℝ (Fin 2)) :
    inner ℝ u v = (‖u + v‖ ^ 2 - ‖u‖ ^ 2 - ‖v‖ ^ 2) / 2 ∧
      inner ℝ a b = a 0 * b 0 + a 1 * b 1 ∧
      inner ℝ u v = ‖u‖ * ‖v‖ * Real.cos (angle u v) := by
  refine ⟨?_, ?_, ?_⟩
  · rw [@norm_add_sq_real V]
    ring
  · simp only [PiLp.inner_apply, RCLike.inner_apply, conj_trivial, Fin.sum_univ_two]
    ring
  · rw [← InnerProductGeometry.cos_angle_mul_norm_mul_norm]
    ring

/-- Symétrie et bilinéarité du produit scalaire. -/
theorem produit_scalaire_bilineaire {V : Type*} [NormedAddCommGroup V]
    [InnerProductSpace ℝ V] (u v w : V) (k : ℝ) :
    inner ℝ u v = inner ℝ v u ∧
      inner ℝ (u + v) w = inner ℝ u w + inner ℝ v w ∧
      inner ℝ (k • u) w = k * inner ℝ u w :=
  ⟨real_inner_comm v u, inner_add_left u v w, real_inner_smul_left u w k⟩

/-- Deux vecteurs sont orthogonaux si et seulement si leur produit scalaire est nul, ce
qui équivaut à l'égalité des diagonales du parallélogramme qu'ils construisent. -/
theorem orthogonalite {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] (u v : V) :
    inner ℝ u v = 0 ↔ ‖u + v‖ = ‖u - v‖ := by
  rw [← sq_eq_sq₀ (norm_nonneg _) (norm_nonneg _), @norm_add_sq_real V, @norm_sub_sq_real V]
  constructor <;> intro h <;> linarith

/-! ## Al-Kashi, médiane, loi des sinus, aire -/

/-- Théorème d'Al-Kashi. -/
theorem al_kashi {V P : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [MetricSpace P]
    [NormedAddTorsor V P] (a b c : P) :
    dist a c ^ 2 =
      dist a b ^ 2 + dist b c ^ 2 - 2 * dist a b * dist b c * Real.cos (∠ a b c) := by
  have h := EuclideanGeometry.law_cos a b c
  rw [dist_comm c b] at h
  nlinarith [h]

/-- Formule des trois normes (identité du parallélogramme) et théorème de la médiane. -/
theorem mediane_et_trois_normes {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    (u v : V) :
    ‖u + v‖ ^ 2 + ‖u - v‖ ^ 2 = 2 * (‖u‖ ^ 2 + ‖v‖ ^ 2) ∧
      ‖u‖ ^ 2 + ‖v‖ ^ 2 = 2 * ‖(2 : ℝ)⁻¹ • (u + v)‖ ^ 2 + ‖u - v‖ ^ 2 / 2 := by
  have h1 : ‖u + v‖ ^ 2 + ‖u - v‖ ^ 2 = 2 * (‖u‖ ^ 2 + ‖v‖ ^ 2) := by
    rw [@norm_add_sq_real V, @norm_sub_sq_real V]
    ring
  refine ⟨h1, ?_⟩
  rw [norm_smul]
  simp only [Real.norm_eq_abs, abs_of_nonneg (by norm_num : (0 : ℝ) ≤ (2 : ℝ)⁻¹)]
  nlinarith [h1]

/-- Loi des sinus. -/
theorem loi_des_sinus {V P : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [MetricSpace P] [NormedAddTorsor V P] (a b c : P) :
    Real.sin (∠ a b c) * dist b c = Real.sin (∠ c a b) * dist c a :=
  EuclideanGeometry.law_sin a b c

/-- Aire d'un triangle : la valeur absolue du déterminant de deux vecteurs du plan vaut le
produit de leurs normes par le sinus de leur angle ; l'aire du triangle qu'ils portent est
donc `½ ab sin C`. -/
theorem aire_du_triangle {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [Fact (Module.finrank ℝ E = 2)] (o : Orientation ℝ E (Fin 2)) (u v : E) :
    |o.areaForm u v| = ‖u‖ * ‖v‖ * Real.sin (angle u v) := by
  have hcos : inner ℝ u v = ‖u‖ * ‖v‖ * Real.cos (angle u v) := by
    rw [← InnerProductGeometry.cos_angle_mul_norm_mul_norm]
    ring
  have hpyth := o.inner_sq_add_areaForm_sq u v
  have hsin : 0 ≤ Real.sin (angle u v) :=
    Real.sin_nonneg_of_nonneg_of_le_pi (angle_nonneg u v) (angle_le_pi u v)
  have hnn : 0 ≤ ‖u‖ * ‖v‖ * Real.sin (angle u v) := by positivity
  have hc : Real.cos (angle u v) ^ 2 + Real.sin (angle u v) ^ 2 = 1 := Real.cos_sq_add_sin_sq _
  rw [hcos] at hpyth
  rw [← sq_eq_sq₀ (abs_nonneg _) hnn, sq_abs]
  nlinarith [hpyth, hc]

/-! ## Cercle -/

/-- Équation cartésienne d'un cercle : `M` est sur le cercle de centre `Ω` et de rayon `r`
si et seulement si `(x − xΩ)² + (y − yΩ)² = r²`. -/
theorem equation_du_cercle (ω m : EuclideanSpace ℝ (Fin 2)) {r : ℝ} (hr : 0 ≤ r) :
    dist m ω = r ↔ (m 0 - ω 0) ^ 2 + (m 1 - ω 1) ^ 2 = r ^ 2 := by
  rw [EuclideanSpace.dist_eq]
  have hsum : ∑ i, dist (m i) (ω i) ^ 2 = (m 0 - ω 0) ^ 2 + (m 1 - ω 1) ^ 2 := by
    simp [Fin.sum_univ_two, Real.dist_eq, sq_abs]
  rw [hsum]
  constructor
  · intro h
    rw [← h, Real.sq_sqrt (by positivity)]
  · intro h
    rw [h]
    exact Real.sqrt_sq hr

/-- Caractérisation du cercle de diamètre `[AB]` : `M` y appartient si et seulement si
`MA · MB = 0`. -/
theorem cercle_de_diametre {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    (a b m : V) :
    inner ℝ (a - m) (b - m) = 0 ↔ dist m (midpoint ℝ a b) = dist a b / 2 := by
  have hmid : m - midpoint ℝ a b = (2 : ℝ)⁻¹ • ((m - a) + (m - b)) := by
    rw [midpoint_eq_smul_add, invOf_eq_inv]
    module
  have hab : a - b = (m - b) - (m - a) := by abel
  have hinner : inner ℝ (a - m) (b - m) = inner ℝ (m - a) (m - b) := by
    rw [show a - m = -(m - a) by abel, show b - m = -(m - b) by abel, inner_neg_neg]
  have e1 := @norm_add_sq_real V _ _ (m - a) (m - b)
  have e2 := @norm_sub_sq_real V _ _ (m - b) (m - a)
  have hcomm : inner ℝ (m - b) (m - a) = inner ℝ (m - a) (m - b) := real_inner_comm _ _
  rw [dist_eq_norm, dist_eq_norm, hmid, hab, norm_smul, hinner]
  simp only [Real.norm_eq_abs, abs_of_nonneg (by norm_num : (0 : ℝ) ≤ (2 : ℝ)⁻¹)]
  have hnn1 : (0 : ℝ) ≤ ‖(m - a) + (m - b)‖ := norm_nonneg _
  have hnn2 : (0 : ℝ) ≤ ‖(m - b) - (m - a)‖ := norm_nonneg _
  constructor
  · intro h
    have hsq : ‖(m - a) + (m - b)‖ ^ 2 = ‖(m - b) - (m - a)‖ ^ 2 := by nlinarith [e1, e2, hcomm]
    have : ‖(m - a) + (m - b)‖ = ‖(m - b) - (m - a)‖ := by nlinarith [hsq]
    rw [this]
    ring
  · intro h
    have hsq : ‖(m - a) + (m - b)‖ ^ 2 = ‖(m - b) - (m - a)‖ ^ 2 := by nlinarith [h]
    nlinarith [e1, e2, hcomm, hsq]

/-! ## Géométrie dans l'espace : droites et plans -/

/-- Si deux points distincts d'une droite appartiennent à un plan, la droite entière y est
incluse. Une droite non incluse dans un plan le coupe donc en au plus un point. -/
theorem droite_incluse_dans_un_plan {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (Q : AffineSubspace ℝ E) {a b : E} (ha : a ∈ Q) (hb : b ∈ Q) :
    line[ℝ, a, b] ≤ Q := by
  rw [affineSpan_le, Set.insert_subset_iff, Set.singleton_subset_iff]
  exact ⟨ha, hb⟩

/-- Représentation paramétrique d'une droite : la droite passant par `a` et dirigée par
`u` est l'ensemble des points `a + tu`, `t` parcourant ℝ. -/
theorem representation_parametrique_droite {E : Type*} [NormedAddCommGroup E]
    [NormedSpace ℝ E] (a u m : E) :
    m ∈ AffineSubspace.mk' a (Submodule.span ℝ ({u} : Set E)) ↔ ∃ t : ℝ, m = a + t • u := by
  rw [AffineSubspace.mem_mk', vsub_eq_sub, Submodule.mem_span_singleton]
  constructor
  · rintro ⟨t, ht⟩
    exact ⟨t, by rw [ht]; abel⟩
  · rintro ⟨t, rfl⟩
    exact ⟨t, by abel⟩

/-- Représentation paramétrique d'un plan : le plan passant par `a` et dirigé par `u` et
`v` est l'ensemble des points `a + su + tv`. -/
theorem representation_parametrique_plan {E : Type*} [NormedAddCommGroup E]
    [NormedSpace ℝ E] (a u v m : E) :
    m ∈ AffineSubspace.mk' a (Submodule.span ℝ ({u, v} : Set E)) ↔
      ∃ s t : ℝ, m = a + s • u + t • v := by
  rw [AffineSubspace.mem_mk', vsub_eq_sub, Submodule.mem_span_pair]
  constructor
  · rintro ⟨s, t, hst⟩
    refine ⟨s, t, ?_⟩
    have h : m - a = s • u + t • v := hst.symm
    linear_combination (norm := module) h
  · rintro ⟨s, t, rfl⟩
    exact ⟨s, t, by abel⟩

/-- Coplanarité : un vecteur est coplanaire à deux autres si et seulement s'il est leur
combinaison linéaire. -/
theorem coplanarite {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] (u v w : E) :
    w ∈ Submodule.span ℝ ({u, v} : Set E) ↔ ∃ s t : ℝ, w = s • u + t • v := by
  rw [Submodule.mem_span_pair]
  constructor
  · rintro ⟨s, t, hst⟩
    exact ⟨s, t, hst.symm⟩
  · rintro ⟨s, t, rfl⟩
    exact ⟨s, t, rfl⟩

/-- Base de l'espace : trois vecteurs linéairement indépendants de l'espace en forment une
base, et tout vecteur s'y décompose d'une seule façon. -/
theorem base_de_l_espace {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (hdim : Module.finrank ℝ E = 3) {u v w : E} (hind : LinearIndependent ℝ ![u, v, w])
    (x : E) : ∃! p : ℝ × ℝ × ℝ, x = p.1 • u + p.2.1 • v + p.2.2 • w := by
  have hcard : Fintype.card (Fin 3) = Module.finrank ℝ E := by simp [hdim]
  let B := basisOfLinearIndependentOfCardEqFinrank hind hcard
  have hB : ⇑B = ![u, v, w] := coe_basisOfLinearIndependentOfCardEqFinrank hind hcard
  have hx : x = B.repr x 0 • u + B.repr x 1 • v + B.repr x 2 • w := by
    have h := B.sum_repr x
    rw [Fin.sum_univ_three, hB] at h
    simpa using h.symm
  refine ⟨(B.repr x 0, B.repr x 1, B.repr x 2), hx, ?_⟩
  rintro ⟨a, b, c⟩ h
  simp only at h
  have hz : (a - B.repr x 0) • u + (b - B.repr x 1) • v + (c - B.repr x 2) • w = 0 := by
    linear_combination (norm := module) hx - h
  have hlin := Fintype.linearIndependent_iff.mp hind
    ![a - B.repr x 0, b - B.repr x 1, c - B.repr x 2] (by simpa [Fin.sum_univ_three] using hz)
  have h0 := hlin 0
  have h1 := hlin 1
  have h2 := hlin 2
  simp only [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.tail_cons] at h0 h1 h2
  simp only [Prod.mk.injEq]
  exact ⟨by linarith, by linarith, by linarith⟩

/-! ## Produit scalaire dans l'espace : vecteur normal et équation cartésienne -/

/-- Équation cartésienne d'un plan de vecteur normal `n(a, b, c)` passant par `p` :
`ax + by + cz + d = 0` avec `d = −(a x_p + b y_p + c z_p)`. -/
theorem equation_cartesienne_du_plan (n p m : EuclideanSpace ℝ (Fin 3)) :
    inner ℝ n (m - p) = 0 ↔
      n 0 * m 0 + n 1 * m 1 + n 2 * m 2 - (n 0 * p 0 + n 1 * p 1 + n 2 * p 2) = 0 := by
  simp only [PiLp.inner_apply, RCLike.inner_apply, conj_trivial, Fin.sum_univ_three,
    PiLp.sub_apply]
  have e : (m 0 - p 0) * n 0 + (m 1 - p 1) * n 1 + (m 2 - p 2) * n 2
      = n 0 * m 0 + n 1 * m 1 + n 2 * m 2 - (n 0 * p 0 + n 1 * p 1 + n 2 * p 2) := by ring
  rw [e]

/-- Distance d'un point à un plan : tout point du plan est au moins à la distance
`|⟪n, m − p⟫| / ‖n‖` de `m`, et le projeté orthogonal réalise cette distance. -/
theorem distance_a_un_plan {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    {n : E} (hn : n ≠ 0) (p m : E) :
    (∀ x : E, inner ℝ n (x - p) = 0 → |inner ℝ n (m - p)| / ‖n‖ ≤ dist m x) ∧
      inner ℝ n ((m - (inner ℝ n (m - p) / ‖n‖ ^ 2) • n) - p) = 0 ∧
      dist m (m - (inner ℝ n (m - p) / ‖n‖ ^ 2) • n) = |inner ℝ n (m - p)| / ‖n‖ := by
  have hnpos : 0 < ‖n‖ := norm_pos_iff.mpr hn
  have hself : inner ℝ n n = ‖n‖ ^ 2 := real_inner_self_eq_norm_sq n
  refine ⟨?_, ?_, ?_⟩
  · intro x hx
    have hmx : inner ℝ n (m - x) = inner ℝ n (m - p) := by
      rw [show m - x = (m - p) - (x - p) by abel, inner_sub_right, hx, sub_zero]
    rw [dist_eq_norm, div_le_iff₀ hnpos, ← hmx]
    calc |inner ℝ n (m - x)| ≤ ‖n‖ * ‖m - x‖ := abs_real_inner_le_norm n (m - x)
      _ = ‖m - x‖ * ‖n‖ := by ring
  · rw [show m - (inner ℝ n (m - p) / ‖n‖ ^ 2) • n - p
        = (m - p) - (inner ℝ n (m - p) / ‖n‖ ^ 2) • n by abel,
      inner_sub_right, real_inner_smul_right, hself]
    field_simp
    ring
  · rw [dist_eq_norm, show m - (m - (inner ℝ n (m - p) / ‖n‖ ^ 2) • n)
        = (inner ℝ n (m - p) / ‖n‖ ^ 2) • n by abel,
      norm_smul, Real.norm_eq_abs, abs_div,
      abs_of_nonneg (by positivity : (0 : ℝ) ≤ ‖n‖ ^ 2)]
    field_simp

end Lycee.Geometrie
