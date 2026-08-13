/-
Collège — section « Statistiques et probabilités ».
Une série statistique est une liste de nombres, une expérience aléatoire est donnée par
la probabilité de chacune de ses issues.
Énoncés et démonstrations en français : voir StatistiquesEtProbabilites.tex.
-/
import Mathlib.Tactic
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Analysis.SpecificLimits.Basic

namespace College.Statistiques

open Finset

/-! ## Définitions -/

/- Toutes les définitions du fichier sont posées ici, avant les démonstrations. -/

/-- Moyenne d'une série statistique, donnée comme une liste non vide de nombres. -/
noncomputable def moyenne (s : List ℝ) : ℝ := s.sum / s.length

/-- Série obtenue en ajoutant `c` à chaque valeur. -/
def translatee (c : ℝ) (s : List ℝ) : List ℝ := s.map (· + c)

/-- Moyenne pondérée de valeurs `v` affectées d'effectifs `n`. -/
noncomputable def moyennePonderee {k : ℕ} (v n : Fin k → ℝ) : ℝ :=
  (∑ i, n i * v i) / (∑ i, n i)

/-- `m` est une médiane de la série `s` : au moins la moitié des valeurs lui sont
inférieures ou égales, et au moins la moitié lui sont supérieures ou égales. -/
def EstMediane (s : List ℝ) (m : ℝ) : Prop :=
  2 * (s.filter (· ≤ m)).length ≥ s.length ∧ 2 * (s.filter (m ≤ ·)).length ≥ s.length

/-- Une loi de probabilité sur un ensemble fini d'issues : chaque issue a une probabilité
positive, et leur somme vaut un. -/
structure Loi (Ω : Type*) [Fintype Ω] where
  p : Ω → ℝ
  positive : ∀ ω, 0 ≤ p ω
  somme_un : ∑ ω, p ω = 1

/-- Probabilité d'un événement, somme des probabilités de ses issues. -/
noncomputable def proba {Ω : Type*} [Fintype Ω] [DecidableEq Ω] (L : Loi Ω)
    (A : Finset Ω) : ℝ := ∑ ω ∈ A, L.p ω

/-! ## Moyenne : linéarité et moyenne pondérée -/

/-- Ajouter un même nombre à toutes les valeurs ajoute ce nombre à la moyenne. -/
theorem moyenne_translatee {s : List ℝ} (hs : s ≠ []) (c : ℝ) :
    moyenne (translatee c s) = moyenne s + c := by
  have hlen : (0 : ℝ) < s.length := by
    have := List.length_pos_of_ne_nil hs
    exact_mod_cast this
  simp only [moyenne, translatee, List.length_map]
  rw [List.sum_map_add]
  simp only [List.map_id', List.map_const', List.sum_replicate, nsmul_eq_mul]
  field_simp

/-- La moyenne pondérée est la moyenne des valeurs répétées selon leurs effectifs :
c'est la même quantité, écrite sans répéter les valeurs identiques. -/
theorem moyenne_ponderee_effectifs_egaux {k : ℕ} (_hk : 0 < k) (v : Fin k → ℝ) :
    moyennePonderee v (fun _ => 1) = (∑ i, v i) / k := by
  simp only [moyennePonderee, one_mul, sum_const, card_univ, Fintype.card_fin,
    nsmul_eq_mul, mul_one]

/-! ## La moyenne est comprise entre le minimum et le maximum -/

/-- La moyenne d'une série est comprise entre deux bornes qui encadrent toutes ses
valeurs. -/
theorem moyenne_entre_bornes {s : List ℝ} (hs : s ≠ []) {a b : ℝ}
    (hmin : ∀ x ∈ s, a ≤ x) (hmax : ∀ x ∈ s, x ≤ b) :
    a ≤ moyenne s ∧ moyenne s ≤ b := by
  have hlen : (0 : ℝ) < s.length := by
    have := List.length_pos_of_ne_nil hs
    exact_mod_cast this
  constructor
  · rw [moyenne, le_div_iff₀ hlen]
    calc a * s.length = (s.map (fun _ => a)).sum := by
          simp [List.map_const', List.sum_replicate, mul_comm]
      _ ≤ (s.map id).sum := List.sum_le_sum (by intro x hx; simpa using hmin x hx)
      _ = s.sum := by simp
  · rw [moyenne, div_le_iff₀ hlen]
    calc s.sum = (s.map id).sum := by simp
      _ ≤ (s.map (fun _ => b)).sum := List.sum_le_sum (by intro x hx; simpa using hmax x hx)
      _ = b * s.length := by simp [List.map_const', List.sum_replicate, mul_comm]

/-! ## La moyenne de plusieurs moyennes n'est pas la moyenne de la série globale -/

/-- Contre-exemple : une série de trois valeurs et une d'une seule valeur. La moyenne des
deux moyennes vaut `3`, alors que la série réunie a pour moyenne `1,5`. -/
theorem moyenne_des_moyennes_contre_exemple :
    moyenne [moyenne [0, 0, 0], moyenne [6]] ≠ moyenne [0, 0, 0, 6] := by
  simp only [moyenne]
  norm_num

/-! ## Médiane : au moins la moitié des valeurs lui sont inférieures ou égales -/

/-- Sur une série de cinq valeurs rangées, la valeur centrale est bien une médiane. -/
theorem mediane_serie_impaire : EstMediane [1, 2, 3, 4, 5] 3 := by
  constructor <;> norm_num [EstMediane, List.filter]

/-- Une médiane sépare la série en deux moitiés : au moins la moitié des valeurs lui sont
inférieures ou égales, par définition. -/
theorem mediane_moitie_inferieure {s : List ℝ} {m : ℝ} (h : EstMediane s m) :
    2 * (s.filter (· ≤ m)).length ≥ s.length := h.1

/-! ## Probabilité : `0 ≤ P(A) ≤ 1` et somme des probabilités des issues = 1 -/

variable {Ω : Type*} [Fintype Ω] [DecidableEq Ω]

/-- Une probabilité est positive. -/
theorem proba_nonneg (L : Loi Ω) (A : Finset Ω) : 0 ≤ proba L A :=
  Finset.sum_nonneg fun ω _ => L.positive ω

/-- Une probabilité ne dépasse pas un. -/
theorem proba_le_un (L : Loi Ω) (A : Finset Ω) : proba L A ≤ 1 := by
  rw [← L.somme_un]
  exact Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ A)
    fun ω _ _ => L.positive ω

/-- La probabilité de l'événement certain vaut un : c'est la somme des probabilités de
toutes les issues. -/
theorem proba_univ (L : Loi Ω) : proba L Finset.univ = 1 := L.somme_un

/-! ## Événement contraire : `P(Ā) = 1 − P(A)` -/

/-- La probabilité de l'événement contraire est le complément à un. -/
theorem proba_complement (L : Loi Ω) (A : Finset Ω) : proba L Aᶜ = 1 - proba L A := by
  have : proba L A + proba L Aᶜ = 1 := by
    rw [proba, proba, Finset.sum_add_sum_compl]
    exact L.somme_un
  linarith

/-! ## Équiprobabilité : `P(A) = card(A) / card(Ω)` -/

/-- Sous l'hypothèse d'équiprobabilité, la probabilité d'un événement est le quotient du
nombre de cas favorables par le nombre de cas possibles. -/
theorem proba_equiprobable (L : Loi Ω) (hL : ∀ ω, L.p ω = 1 / Fintype.card Ω)
    (A : Finset Ω) : proba L A = A.card / Fintype.card Ω := by
  simp only [proba, hL, Finset.sum_const, nsmul_eq_mul]
  ring

/-! ## Expérience à deux épreuves : produit des probabilités le long d'une branche -/

/-- Deux épreuves indépendantes : la probabilité d'une branche de l'arbre est le produit
des probabilités rencontrées. La loi produit est bien une loi de probabilité. -/
noncomputable def loiProduit {Ω' : Type*} [Fintype Ω'] (L : Loi Ω) (L' : Loi Ω') :
    Loi (Ω × Ω') where
  p := fun c => L.p c.1 * L'.p c.2
  positive := fun c => mul_nonneg (L.positive c.1) (L'.positive c.2)
  somme_un := by
    rw [Fintype.sum_prod_type]
    simp only [← Finset.mul_sum, L'.somme_un, mul_one, L.somme_un]

omit [DecidableEq Ω] in
/-- Le long d'une branche, les probabilités se multiplient. -/
theorem proba_branche {Ω' : Type*} [Fintype Ω'] (L : Loi Ω) (L' : Loi Ω') (a : Ω) (b : Ω') :
    (loiProduit L L').p (a, b) = L.p a * L'.p b := rfl

/-! ## Fréquence observée et probabilité : stabilisation quand `n` grandit -/

/-- L'écart type d'une fréquence observée sur `n` tirages est de l'ordre de `1/√n` : il
tend vers zéro, ce qui est la forme quantitative de la stabilisation des fréquences.
On l'énonce ici sur la suite `1/√n` elle-même, dont la limite est nulle. -/
theorem fluctuation_tend_vers_zero :
    Filter.Tendsto (fun n : ℕ => 1 / Real.sqrt n) Filter.atTop (nhds 0) := by
  have h : Filter.Tendsto (fun n : ℕ => Real.sqrt n) Filter.atTop Filter.atTop :=
    Real.tendsto_sqrt_atTop.comp tendsto_natCast_atTop_atTop
  simpa [Pi.inv_def, one_div] using h.inv_tendsto_atTop

end College.Statistiques
