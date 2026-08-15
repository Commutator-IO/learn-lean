/-
Lycée — section « Limites, continuité, dérivation ».
Les limites sont celles de Mathlib : `Tendsto f (nhds a) (nhds l)` pour la limite en un
point, `Tendsto f atTop (nhds l)` pour la limite en `+∞`. Les deux premiers énoncés
vérifient que ces écritures sont bien les définitions « ε–δ » et « ε–A » du programme.
La dérivabilité s'écrit `HasDerivAt f d a` : « `f` admet le nombre dérivé `d` en `a` ».
Énoncés et démonstrations en français : voir LimitesContinuiteDerivation.tex.
-/
import Mathlib

namespace Lycee.Limites

open Filter Topology

/-! ## Définitions -/

/- Toutes les définitions du fichier sont posées ici, avant les démonstrations. -/

/-- La tangente à la courbe de `f` au point d'abscisse `a`, lorsque le nombre dérivé en
`a` vaut `d` : la fonction affine `x ↦ f(a) + d(x − a)`. -/
def tangente (f : ℝ → ℝ) (d a : ℝ) : ℝ → ℝ := fun x => f a + d * (x - a)

/-! ## Limite en un point, limite en l'infini -/

/-- La limite en un point est la définition du programme : tout intervalle ouvert centré
en `l` contient les images de tous les points assez proches de `a`, autrement dit
`∀ ε > 0, ∃ δ > 0, |x − a| < δ ⟹ |f(x) − l| < ε`. -/
theorem limite_en_un_point (f : ℝ → ℝ) (a l : ℝ) :
    Tendsto f (nhds a) (nhds l) ↔ ∀ ε > 0, ∃ δ > 0, ∀ x, |x - a| < δ → |f x - l| < ε := by
  rw [Metric.tendsto_nhds_nhds]
  constructor
  · intro h ε hε
    obtain ⟨δ, hδ, hδ'⟩ := h ε hε
    exact ⟨δ, hδ, fun x hx => by simpa [Real.dist_eq] using hδ' (by simpa [Real.dist_eq] using hx)⟩
  · intro h ε hε
    obtain ⟨δ, hδ, hδ'⟩ := h ε hε
    exact ⟨δ, hδ, fun x hx => by
      simpa [Real.dist_eq] using hδ' x (by simpa [Real.dist_eq] using hx)⟩

/-- La limite en `+∞` est la définition avec `A` : tout intervalle ouvert centré en `l`
contient les images de tous les points assez grands, autrement dit
`∀ ε > 0, ∃ A, x ≥ A ⟹ |f(x) − l| < ε`. -/
theorem limite_en_plus_infini (f : ℝ → ℝ) (l : ℝ) :
    Tendsto f atTop (nhds l) ↔ ∀ ε > 0, ∃ A : ℝ, ∀ x ≥ A, |f x - l| < ε := by
  rw [Metric.tendsto_atTop]
  simp only [Real.dist_eq]

/-- Asymptote horizontale : si `f` tend vers `l` en `+∞`, l'écart entre la courbe et la
droite d'équation `y = l` tend vers zéro, c'est-à-dire `f(x) − l → 0`. -/
theorem asymptote_horizontale {f : ℝ → ℝ} {l : ℝ} (h : Tendsto f atTop (nhds l)) :
    Tendsto (fun x => f x - l) atTop (nhds 0) := by
  simpa using h.sub_const l

/-- Asymptote verticale : `1/x → +∞` lorsque `x → 0` par valeurs strictement positives ;
l'axe des ordonnées est asymptote à l'hyperbole de la fonction inverse. -/
theorem asymptote_verticale :
    Tendsto (fun x : ℝ => 1 / x) (nhdsWithin 0 (Set.Ioi 0)) atTop := by
  simpa [one_div] using tendsto_inv_nhdsGT_zero (𝕜 := ℝ)

/-- Asymptote oblique : l'écart entre la courbe de `x ↦ ax + b + 1/x` et la droite
d'équation `y = ax + b` tend vers zéro en `+∞`. -/
theorem asymptote_oblique (a b : ℝ) :
    Tendsto (fun x : ℝ => a * x + b + 1 / x - (a * x + b)) atTop (nhds 0) := by
  simpa using tendsto_inv_atTop_zero

/-! ## Opérations sur les limites -/

/-- La limite d'une somme est la somme des limites : `f + g → l + l'`. -/
theorem limite_somme {f g : ℝ → ℝ} {a l l' : ℝ} (hf : Tendsto f (nhds a) (nhds l))
    (hg : Tendsto g (nhds a) (nhds l')) :
    Tendsto (fun x => f x + g x) (nhds a) (nhds (l + l')) := hf.add hg

/-- Celle d'un produit est le produit des limites : `f × g → l l'`. -/
theorem limite_produit {f g : ℝ → ℝ} {a l l' : ℝ} (hf : Tendsto f (nhds a) (nhds l))
    (hg : Tendsto g (nhds a) (nhds l')) :
    Tendsto (fun x => f x * g x) (nhds a) (nhds (l * l')) := hf.mul hg

/-- Celle d'un quotient est le quotient des limites, `f / g → l / l'`, tant que la limite
du dénominateur n'est pas nulle : `l' ≠ 0`. -/
theorem limite_quotient {f g : ℝ → ℝ} {a l l' : ℝ} (hf : Tendsto f (nhds a) (nhds l))
    (hg : Tendsto g (nhds a) (nhds l')) (hl' : l' ≠ 0) :
    Tendsto (fun x => f x / g x) (nhds a) (nhds (l / l')) := hf.div hg hl'

/-- Limite d'une composée : les limites s'enchaînent. Si `f → b` en `a` et `g → c` en `b`,
alors `g ∘ f → c` en `a`. -/
theorem limite_composee {f g : ℝ → ℝ} {a b c : ℝ} (hf : Tendsto f (nhds a) (nhds b))
    (hg : Tendsto g (nhds b) (nhds c)) : Tendsto (g ∘ f) (nhds a) (nhds c) := hg.comp hf

/-! ## Croissances comparées -/

/-- L'exponentielle l'emporte sur toute puissance : `eˣ/xⁿ → +∞`. -/
theorem croissance_comparee_exp (n : ℕ) :
    Tendsto (fun x : ℝ => Real.exp x / x ^ n) atTop atTop :=
  Real.tendsto_exp_div_pow_atTop n

/-- Le logarithme est négligeable devant l'identité : `ln x / x → 0` en `+∞`. -/
theorem croissance_comparee_log :
    Tendsto (fun x : ℝ => Real.log x / x) atTop (nhds 0) := by
  simpa using Real.isLittleO_log_id_atTop.tendsto_div_nhds_zero

/-- En zéro, le facteur `x` l'emporte sur le logarithme : `x ln x → 0`. -/
theorem croissance_comparee_x_log_x :
    Tendsto (fun x : ℝ => x * Real.log x) (nhdsWithin 0 (Set.Ioi 0)) (nhds 0) := by
  have h := tendsto_log_mul_rpow_nhdsGT_zero (r := 1) one_pos
  simpa [Real.rpow_one, mul_comm] using h

/-! ## Continuité -/

/-- La continuité en un point : la limite y existe et vaut l'image du point, autrement dit
`f(x) → f(a)` quand `x → a`. -/
theorem continuite_en_un_point (f : ℝ → ℝ) (a : ℝ) :
    ContinuousAt f a ↔ Tendsto f (nhds a) (nhds (f a)) := Iff.rfl

/-- Toute fonction dérivable en un point y est continue. La réciproque est fausse : la
valeur absolue est continue en zéro sans y être dérivable. -/
theorem derivable_implique_continue {f : ℝ → ℝ} {d a : ℝ} (h : HasDerivAt f d a) :
    ContinuousAt f a := h.continuousAt

/-! ## Théorème des valeurs intermédiaires -/

/-- Théorème des valeurs intermédiaires : une fonction continue sur `[a ; b]` prend toute
valeur comprise entre `f(a)` et `f(b)`. -/
theorem theoreme_des_valeurs_intermediaires {f : ℝ → ℝ} {a b : ℝ} (hab : a ≤ b)
    (hf : ContinuousOn f (Set.Icc a b)) {k : ℝ} (hk : k ∈ Set.Icc (f a) (f b)) :
    ∃ c ∈ Set.Icc a b, f c = k := by
  obtain ⟨c, hc, hfc⟩ := intermediate_value_Icc hab hf hk
  exact ⟨c, hc, hfc⟩

/-- Corollaire : si de plus `f` est strictement croissante, la solution est unique. -/
theorem corollaire_solution_unique {f : ℝ → ℝ} {a b : ℝ} (hab : a ≤ b)
    (hf : ContinuousOn f (Set.Icc a b)) (hmono : StrictMonoOn f (Set.Icc a b))
    {k : ℝ} (hk : k ∈ Set.Icc (f a) (f b)) :
    ∃! c : ℝ, c ∈ Set.Icc a b ∧ f c = k := by
  obtain ⟨c, hc, hfc⟩ := intermediate_value_Icc hab hf hk
  refine ⟨c, ⟨hc, hfc⟩, ?_⟩
  rintro y ⟨hy, hfy⟩
  exact hmono.injOn hy hc (by rw [hfy, hfc])

/-! ## Nombre dérivé et tangente -/

/-- Le nombre dérivé est la limite du taux d'accroissement :
`(f(x) − f(a))/(x − a) → f'(a)` quand `x → a`, `x ≠ a`. -/
theorem nombre_derive_taux_d_accroissement (f : ℝ → ℝ) (d a : ℝ) :
    HasDerivAt f d a ↔
      Tendsto (fun x => (f x - f a) / (x - a)) (nhdsWithin a {a}ᶜ) (nhds d) := by
  have h : (fun x => (f x - f a) / (x - a)) = slope f a := by
    funext x
    simp [slope, div_eq_inv_mul]
  rw [hasDerivAt_iff_tendsto_slope, h]

/-- Équation de la tangente : la droite d'équation `y = f(a) + f'(a)(x − a)` passe par le
point de la courbe d'abscisse `a` et a le nombre dérivé pour coefficient directeur. -/
theorem equation_de_la_tangente (f : ℝ → ℝ) (d a : ℝ) :
    tangente f d a a = f a ∧ ∀ x, HasDerivAt (tangente f d a) d x := by
  constructor
  · simp [tangente]
  · intro x
    show HasDerivAt (fun y : ℝ => f a + d * (y - a)) d x
    simpa using (((hasDerivAt_id x).sub_const a).const_mul d).const_add (f a)

/-! ## Dérivées usuelles -/

/-- Dérivées des fonctions de référence : `(xⁿ)' = n xⁿ⁻¹`, `(1/x)' = −1/x²`,
`(√x)' = 1/(2√x)`, `sin' = cos`, `cos' = −sin`, `exp' = exp`, `ln' = 1/x`. -/
theorem derivees_usuelles (x : ℝ) (n : ℕ) :
    HasDerivAt (fun t : ℝ => t ^ n) (n * x ^ (n - 1)) x ∧
      (x ≠ 0 → HasDerivAt (fun t : ℝ => 1 / t) (-1 / x ^ 2) x) ∧
      (0 < x → HasDerivAt Real.sqrt (1 / (2 * Real.sqrt x)) x) ∧
      HasDerivAt Real.sin (Real.cos x) x ∧
      HasDerivAt Real.cos (-Real.sin x) x ∧
      HasDerivAt Real.exp (Real.exp x) x ∧
      (x ≠ 0 → HasDerivAt Real.log (1 / x) x) := by
  refine ⟨hasDerivAt_pow n x, fun hx => ?_, fun hx => ?_, Real.hasDerivAt_sin x,
    Real.hasDerivAt_cos x, Real.hasDerivAt_exp x, fun hx => ?_⟩
  · simpa [one_div, neg_div] using hasDerivAt_inv hx
  · exact Real.hasDerivAt_sqrt (ne_of_gt hx)
  · simpa [one_div] using Real.hasDerivAt_log hx

/-! ## Opérations sur les dérivées -/

/-- Dérivée d'une somme, d'un produit, d'un inverse et d'un quotient :
`(u + v)' = u' + v'`, `(uv)' = u'v + uv'`, `(1/v)' = −v'/v²`, `(u/v)' = (u'v − uv')/v²`,
les deux dernières là où `v` ne s'annule pas. -/
theorem operations_sur_les_derivees {u v : ℝ → ℝ} {u' v' x : ℝ}
    (hu : HasDerivAt u u' x) (hv : HasDerivAt v v' x) :
    HasDerivAt (fun t => u t + v t) (u' + v') x ∧
      HasDerivAt (fun t => u t * v t) (u' * v x + u x * v') x ∧
      (v x ≠ 0 → HasDerivAt (fun t => 1 / v t) (-v' / v x ^ 2) x) ∧
      (v x ≠ 0 → HasDerivAt (fun t => u t / v t) ((u' * v x - u x * v') / v x ^ 2) x) := by
  refine ⟨hu.add hv, hu.mul hv, fun hvx => ?_, fun hvx => hu.div hv hvx⟩
  have h := (hasDerivAt_const x (1 : ℝ)).div hv hvx
  have e : (0 * v x - 1 * v') / v x ^ 2 = -v' / v x ^ 2 := by ring
  rw [e] at h
  exact h

/-! ## Dérivée d'une composée -/

/-- Dérivée d'une composée : `(v ∘ u)' = u' × (v' ∘ u)`. -/
theorem derivee_d_une_composee {u v : ℝ → ℝ} {u' v' x : ℝ} (hu : HasDerivAt u u' x)
    (hv : HasDerivAt v v' (u x)) : HasDerivAt (v ∘ u) (v' * u') x := hv.comp x hu

/-- Cas particulier `x ↦ u(ax + b)`, dont la dérivée est `a u'(ax + b)`. -/
theorem derivee_de_u_affine {u : ℝ → ℝ} {u' a b x : ℝ} (hu : HasDerivAt u u' (a * x + b)) :
    HasDerivAt (fun t => u (a * t + b)) (a * u') x := by
  have h : HasDerivAt (fun t : ℝ => a * t + b) a x := by
    simpa using ((hasDerivAt_id x).const_mul a).add_const b
  have h2 := hu.comp x h
  rw [mul_comm u' a] at h2
  exact h2

/-! ## Signe de la dérivée et sens de variation -/

/-- Une dérivée strictement positive sur un intervalle y rend la fonction strictement
croissante. -/
theorem derivee_positive_croissante {f : ℝ → ℝ} {a b : ℝ}
    (hf : ContinuousOn f (Set.Icc a b)) (hpos : ∀ x ∈ Set.Ioo a b, 0 < deriv f x) :
    StrictMonoOn f (Set.Icc a b) := by
  refine strictMonoOn_of_deriv_pos (convex_Icc a b) hf ?_
  simpa [interior_Icc] using hpos

/-- Une dérivée strictement négative la rend strictement décroissante. -/
theorem derivee_negative_decroissante {f : ℝ → ℝ} {a b : ℝ}
    (hf : ContinuousOn f (Set.Icc a b)) (hneg : ∀ x ∈ Set.Ioo a b, deriv f x < 0) :
    StrictAntiOn f (Set.Icc a b) := by
  refine strictAntiOn_of_deriv_neg (convex_Icc a b) hf ?_
  simpa [interior_Icc] using hneg

/-! ## Extremum local -/

/-- En un point intérieur où la fonction est dérivable, un extremum local annule la
dérivée : `f'(a) = 0`. -/
theorem extremum_local_annule_la_derivee {f : ℝ → ℝ} {d a : ℝ} (hd : HasDerivAt f d a)
    (hmax : IsLocalMax f a) : d = 0 := hmax.hasDerivAt_eq_zero hd

/-- La réciproque est fausse : la dérivée de la fonction cube s'annule en zéro sans que
la fonction y présente d'extremum, puisqu'elle est strictement croissante. -/
example :
    HasDerivAt (fun x : ℝ => x ^ 3) 0 0 ∧ ¬ IsLocalMax (fun x : ℝ => x ^ 3) 0 := by
  constructor
  · simpa using hasDerivAt_pow 3 (0 : ℝ)
  · intro h
    have h1 : ∀ᶠ x in nhdsWithin (0 : ℝ) (Set.Ioi 0), x ^ 3 ≤ (0 : ℝ) ^ 3 :=
      h.filter_mono nhdsWithin_le_nhds
    have h2 : ∀ᶠ x in nhdsWithin (0 : ℝ) (Set.Ioi 0), (0 : ℝ) < x := self_mem_nhdsWithin
    obtain ⟨x, hx1, hx2⟩ := (h1.and h2).exists
    have hpos : 0 < x ^ 3 := pow_pos hx2 3
    simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow] at hx1
    linarith

/-! ## Dérivée seconde, convexité, point d'inflexion -/

/-- Une dérivée seconde positive rend la fonction convexe : si `f'' ≥ 0` sur un
intervalle, `f` y est convexe. -/
theorem derivee_seconde_positive_convexe {f : ℝ → ℝ} {a b : ℝ}
    (hf : DifferentiableOn ℝ f (Set.Icc a b))
    (hf' : DifferentiableOn ℝ (deriv f) (Set.Icc a b))
    (hpos : ∀ x ∈ Set.Icc a b, 0 ≤ deriv (deriv f) x) : ConvexOn ℝ (Set.Icc a b) f := by
  refine convexOn_of_deriv2_nonneg' (convex_Icc a b) hf hf' ?_
  simpa using hpos

/-- Point d'inflexion : la dérivée de la fonction cube vaut `3x²`, sa dérivée seconde
vaut `6x`, qui s'annule en zéro en changeant de signe ; la fonction est convexe sur les
positifs, et le point d'abscisse zéro est un point d'inflexion. -/
theorem point_d_inflexion_du_cube :
    (∀ x : ℝ, HasDerivAt (fun t : ℝ => t ^ 3) (3 * x ^ 2) x) ∧
      (∀ x : ℝ, HasDerivAt (fun t : ℝ => 3 * t ^ 2) (6 * x) x) ∧
      ConvexOn ℝ (Set.Ici 0) (fun t : ℝ => t ^ 3) := by
  refine ⟨fun x => ?_, fun x => ?_, convexOn_pow 3⟩
  · have h := hasDerivAt_pow 3 x
    have e : ((3 : ℕ) : ℝ) * x ^ (3 - 1) = 3 * x ^ 2 := by push_cast; ring
    rw [e] at h
    exact h
  · have h := (hasDerivAt_pow 2 x).const_mul (3 : ℝ)
    have e : (3 : ℝ) * (((2 : ℕ) : ℝ) * x ^ (2 - 1)) = 6 * x := by push_cast; ring
    rw [e] at h
    exact h

end Lycee.Limites
