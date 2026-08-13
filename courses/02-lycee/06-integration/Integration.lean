/-
Lycée — section « Intégration ».
Le programme définit l'intégrale d'une fonction continue positive comme l'aire sous la
courbe, et admet que cette aire existe. Mathlib définit l'intégrale par la théorie de la
mesure ; le premier énoncé rétablit le lien en démontrant que la mesure de la partie du
plan comprise entre l'axe et la courbe vaut l'intégrale.
Le volume d'un solide de révolution n'est pas traité : voir la note en fin de fichier.
Énoncés et démonstrations en français : voir Integration.tex.
-/
import Mathlib

namespace Lycee.Integration

open MeasureTheory

/-! ## L'intégrale est l'aire sous la courbe -/

/-- L'intégrale d'une fonction continue positive est l'aire sous la courbe : la mesure de
la partie du plan comprise entre l'axe des abscisses et la courbe, au-dessus de
`]a ; b]`, vaut `∫ₐᵇ f`. -/
theorem integrale_aire_sous_la_courbe {f : ℝ → ℝ} {a b : ℝ} (hf : Continuous f)
    (hpos : ∀ x, 0 ≤ f x) (hab : a ≤ b) :
    volume (regionBetween (fun _ => 0) f (Set.Ioc a b)) =
      ENNReal.ofReal (∫ x in a..b, f x) := by
  rw [MeasureTheory.Measure.volume_eq_prod,
    volume_regionBetween_eq_integral integrableOn_zero hf.integrableOn_Ioc
      measurableSet_Ioc (fun x _ => hpos x), intervalIntegral.integral_of_le hab]
  simp

/-! ## Primitives -/

/-- Toute fonction continue admet des primitives, et `x ↦ ∫ₐˣ f(t)dt` est celle qui
s'annule en `a` : sa dérivée est `f`, et elle vaut zéro en `a`. -/
theorem primitive_par_integrale {f : ℝ → ℝ} (hf : Continuous f) (a : ℝ) :
    (∀ x : ℝ, HasDerivAt (fun u => ∫ t in a..u, f t) (f x) x) ∧ (∫ t in a..a, f t) = 0 :=
  ⟨fun x => (hf.integral_hasStrictDerivAt a x).hasDerivAt, intervalIntegral.integral_same⟩

/-- Deux primitives d'une même fonction diffèrent d'une constante. -/
theorem primitives_differe_d_une_constante {f F G : ℝ → ℝ}
    (hF : ∀ x, HasDerivAt F (f x) x) (hG : ∀ x, HasDerivAt G (f x) x) :
    ∃ c : ℝ, ∀ x, F x - G x = c := by
  refine ⟨F 0 - G 0, fun x => ?_⟩
  have h : ∀ y : ℝ, HasDerivAt (fun t => F t - G t) 0 y := by
    intro y
    have hd := (hF y).sub (hG y)
    have e : f y - f y = 0 := by ring
    rw [e] at hd
    exact hd
  exact is_const_of_deriv_eq_zero (fun y => (h y).differentiableAt) (fun y => (h y).deriv) x 0

/-! ## Théorème fondamental de l'analyse -/

/-- Théorème fondamental : si `F` est une primitive de `f` continue, alors
`∫ₐᵇ f = F(b) − F(a)`. -/
theorem theoreme_fondamental {f F : ℝ → ℝ} {a b : ℝ} (hf : Continuous f)
    (hF : ∀ x, HasDerivAt F (f x) x) : (∫ x in a..b, f x) = F b - F a :=
  intervalIntegral.integral_eq_sub_of_hasDerivAt (fun x _ => hF x) (hf.intervalIntegrable a b)

/-! ## Linéarité -/

/-- Linéarité de l'intégrale : `∫(f + g) = ∫f + ∫g` et `∫kf = k∫f`. -/
theorem linearite {f g : ℝ → ℝ} {a b : ℝ} (hf : Continuous f) (hg : Continuous g) (k : ℝ) :
    (∫ x in a..b, (f x + g x)) = (∫ x in a..b, f x) + ∫ x in a..b, g x ∧
      (∫ x in a..b, k * f x) = k * ∫ x in a..b, f x :=
  ⟨intervalIntegral.integral_add (hf.intervalIntegrable a b) (hg.intervalIntegrable a b),
    intervalIntegral.integral_const_mul k f⟩

/-! ## Relation de Chasles -/

/-- Relation de Chasles : `∫ₐᵇ f + ∫_b^c f = ∫ₐ^c f`, quel que soit l'ordre des trois
bornes. -/
theorem relation_de_chasles {f : ℝ → ℝ} {a b c : ℝ} (hf : Continuous f) :
    (∫ x in a..b, f x) + (∫ x in b..c, f x) = ∫ x in a..c, f x :=
  intervalIntegral.integral_add_adjacent_intervals (hf.intervalIntegrable a b)
    (hf.intervalIntegrable b c)

/-! ## Positivité et croissance -/

/-- Positivité et croissance de l'intégrale : si `f ≥ 0` alors `∫f ≥ 0` ; si `f ≤ g`
alors `∫f ≤ ∫g`. Les deux réclament `a ≤ b`. -/
theorem positivite_et_croissance {f g : ℝ → ℝ} {a b : ℝ} (hab : a ≤ b) (hf : Continuous f)
    (hg : Continuous g) :
    ((∀ x ∈ Set.Icc a b, 0 ≤ f x) → 0 ≤ ∫ x in a..b, f x) ∧
      ((∀ x ∈ Set.Icc a b, f x ≤ g x) → (∫ x in a..b, f x) ≤ ∫ x in a..b, g x) :=
  ⟨fun h => intervalIntegral.integral_nonneg hab h,
    fun h => intervalIntegral.integral_mono_on hab (hf.intervalIntegrable a b)
      (hg.intervalIntegrable a b) h⟩

/-! ## Inégalité de la moyenne -/

/-- Inégalité de la moyenne : si `m ≤ f ≤ M` sur `[a ; b]`, alors
`m(b − a) ≤ ∫ₐᵇ f ≤ M(b − a)`, et la valeur moyenne `(1/(b − a))∫ₐᵇ f` est comprise
entre `m` et `M`. -/
theorem inegalite_de_la_moyenne {f : ℝ → ℝ} {a b m M : ℝ} (hab : a ≤ b) (hf : Continuous f)
    (hm : ∀ x ∈ Set.Icc a b, m ≤ f x) (hM : ∀ x ∈ Set.Icc a b, f x ≤ M) :
    m * (b - a) ≤ (∫ x in a..b, f x) ∧ (∫ x in a..b, f x) ≤ M * (b - a) ∧
      (a < b → m ≤ (1 / (b - a)) * ∫ x in a..b, f x ∧
        (1 / (b - a)) * (∫ x in a..b, f x) ≤ M) := by
  have h1 : (∫ _x in a..b, m) ≤ ∫ x in a..b, f x :=
    intervalIntegral.integral_mono_on hab intervalIntegrable_const
      (hf.intervalIntegrable a b) hm
  have h2 : (∫ x in a..b, f x) ≤ ∫ _x in a..b, M :=
    intervalIntegral.integral_mono_on hab (hf.intervalIntegrable a b)
      intervalIntegrable_const hM
  simp only [intervalIntegral.integral_const, smul_eq_mul] at h1 h2
  refine ⟨by linarith, by linarith, fun hlt => ?_⟩
  have hba : 0 < b - a := by linarith
  have hcm : m * (b - a) = (b - a) * m := mul_comm _ _
  have hcM : M * (b - a) = (b - a) * M := mul_comm _ _
  constructor
  · rw [one_div, inv_mul_eq_div, le_div_iff₀ hba]
    linarith
  · rw [one_div, inv_mul_eq_div, div_le_iff₀ hba]
    linarith

/-! ## Intégration par parties -/

/-- Intégration par parties : `∫ₐᵇ u v' = [uv]ₐᵇ − ∫ₐᵇ u' v`. -/
theorem integration_par_parties {u v u' v' : ℝ → ℝ} {a b : ℝ}
    (hu : ∀ x, HasDerivAt u (u' x) x) (hv : ∀ x, HasDerivAt v (v' x) x)
    (hu' : Continuous u') (hv' : Continuous v') :
    (∫ x in a..b, u x * v' x) =
      u b * v b - u a * v a - ∫ x in a..b, u' x * v x :=
  intervalIntegral.integral_mul_deriv_eq_deriv_mul (fun x _ => hu x) (fun x _ => hv x)
    (hu'.intervalIntegrable a b) (hv'.intervalIntegrable a b)

/-! ## Aire entre deux courbes -/

/-- Aire entre deux courbes : si `f ≤ g`, la mesure de la partie du plan comprise entre
les deux courbes au-dessus de `]a ; b]` vaut `∫ₐᵇ (g − f)`. -/
theorem aire_entre_deux_courbes {f g : ℝ → ℝ} {a b : ℝ} (hf : Continuous f)
    (hg : Continuous g) (hfg : ∀ x, f x ≤ g x) (hab : a ≤ b) :
    volume (regionBetween f g (Set.Ioc a b)) =
      ENNReal.ofReal (∫ x in a..b, (g x - f x)) := by
  rw [MeasureTheory.Measure.volume_eq_prod, volume_regionBetween_eq_integral hf.integrableOn_Ioc hg.integrableOn_Ioc
    measurableSet_Ioc (fun x _ => hfg x), intervalIntegral.integral_of_le hab]
  simp

/- Le volume d'un solide de révolution n'est pas formalisé ici. L'énoncé du lycée,
`V = π ∫ₐᵇ f(x)² dx`, demanderait de mesurer dans ℝ³ la partie
`{(x, y, z) | a ≤ x ≤ b et y² + z² ≤ f(x)²}`, donc le théorème de Fubini et l'aire du
disque : un appareillage sans commune mesure avec l'approche du programme, qui se contente
d'empiler des cylindres. -/

end Lycee.Integration
