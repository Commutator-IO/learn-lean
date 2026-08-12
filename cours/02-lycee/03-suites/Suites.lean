/-
Lycée — section « Suites ».
Une suite est une application de ℕ dans ℝ. Les limites sont celles de Mathlib :
`Tendsto u atTop (nhds ℓ)` pour la convergence vers `ℓ`, `Tendsto u atTop atTop` pour la
divergence vers `+∞`. Les deux se déplient en la définition avec `ε` et avec `A` du
programme, ce que le premier énoncé vérifie.
Énoncés et démonstrations en français : voir Suites.tex.
-/
import Mathlib

namespace Lycee.Suites

open Filter Topology

/-! ## Définitions -/

/- Toutes les définitions du fichier sont posées ici, avant les démonstrations. -/

/-- La suite arithmétique de premier terme `u₀` et de raison `r`. -/
def arithmetique (u₀ r : ℝ) : ℕ → ℝ := fun n => u₀ + n * r

/-- La suite géométrique de premier terme `u₀` et de raison `q`. -/
def geometrique (u₀ q : ℝ) : ℕ → ℝ := fun n => u₀ * q ^ n

/-- Deux suites sont adjacentes lorsque l'une croît, l'autre décroît, et que leur
différence tend vers zéro. -/
def Adjacentes (u v : ℕ → ℝ) : Prop :=
  Monotone u ∧ Antitone v ∧ Tendsto (fun n => v n - u n) atTop (nhds 0)

/-! ## Suites arithmétiques et géométriques : terme général -/

/-- Le terme général d'une suite arithmétique : on ajoute `n` fois la raison. -/
theorem terme_general_arithmetique (u₀ r : ℝ) (n : ℕ) :
    arithmetique u₀ r n = u₀ + n * r := rfl

/-- Une suite arithmétique passe d'un terme au suivant en ajoutant la raison. -/
theorem recurrence_arithmetique (u₀ r : ℝ) (n : ℕ) :
    arithmetique u₀ r (n + 1) = arithmetique u₀ r n + r := by
  simp only [arithmetique]
  push_cast
  ring

/-- Le terme général d'une suite géométrique : on multiplie `n` fois par la raison. -/
theorem terme_general_geometrique (u₀ q : ℝ) (n : ℕ) :
    geometrique u₀ q n = u₀ * q ^ n := rfl

/-- Une suite géométrique passe d'un terme au suivant en multipliant par la raison. -/
theorem recurrence_geometrique (u₀ q : ℝ) (n : ℕ) :
    geometrique u₀ q (n + 1) = geometrique u₀ q n * q := by
  simp only [geometrique, pow_succ]
  ring

/-! ## Sens de variation -/

/-- Une suite arithmétique de raison positive est croissante. -/
theorem arithmetique_croissante {r : ℝ} (hr : 0 ≤ r) (u₀ : ℝ) :
    Monotone (arithmetique u₀ r) := by
  intro m n hmn
  simp only [arithmetique]
  have : (m : ℝ) ≤ n := by exact_mod_cast hmn
  nlinarith

/-- De raison négative, elle est décroissante. -/
theorem arithmetique_decroissante {r : ℝ} (hr : r ≤ 0) (u₀ : ℝ) :
    Antitone (arithmetique u₀ r) := by
  intro m n hmn
  simp only [arithmetique]
  have : (m : ℝ) ≤ n := by exact_mod_cast hmn
  nlinarith

/-- Une suite géométrique de premier terme positif et de raison au moins un est
croissante : c'est le signe de `q − 1` qui décide. -/
theorem geometrique_croissante {u₀ q : ℝ} (hu : 0 ≤ u₀) (hq : 1 ≤ q) :
    Monotone (geometrique u₀ q) := by
  intro m n hmn
  simp only [geometrique]
  have hq0 : (0 : ℝ) ≤ q := le_trans zero_le_one hq
  exact mul_le_mul_of_nonneg_left (pow_le_pow_right₀ hq hmn) hu

/-- De raison comprise entre zéro et un, elle est décroissante. -/
theorem geometrique_decroissante {u₀ q : ℝ} (hu : 0 ≤ u₀) (hq0 : 0 ≤ q) (hq1 : q ≤ 1) :
    Antitone (geometrique u₀ q) := by
  intro m n hmn
  simp only [geometrique]
  exact mul_le_mul_of_nonneg_left (pow_le_pow_of_le_one hq0 hq1 hmn) hu

/-! ## Limite d'une suite : la définition avec `ε` -/

/-- La convergence de la bibliothèque est exactement la définition du programme : tout
intervalle ouvert centré en `ℓ` contient tous les termes à partir d'un certain rang. -/
theorem limite_definition_epsilon (u : ℕ → ℝ) (l : ℝ) :
    Tendsto u atTop (nhds l) ↔ ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - l| < ε :=
  Metric.tendsto_atTop.trans (by
    constructor <;> intro h ε hε <;> obtain ⟨N, hN⟩ := h ε hε <;>
      exact ⟨N, fun n hn => by simpa [Real.dist_eq] using hN n hn⟩)

/-- Et la divergence vers `+∞` est la définition avec `A` : tout intervalle `[A ; +∞[`
contient tous les termes à partir d'un certain rang. -/
theorem limite_definition_A (u : ℕ → ℝ) :
    Tendsto u atTop atTop ↔ ∀ A : ℝ, ∃ N, ∀ n ≥ N, A ≤ u n :=
  tendsto_atTop_atTop

/-! ## Unicité de la limite -/

/-- Une suite a au plus une limite. -/
theorem unicite_de_la_limite {u : ℕ → ℝ} {l l' : ℝ} (h : Tendsto u atTop (nhds l))
    (h' : Tendsto u atTop (nhds l')) : l = l' :=
  tendsto_nhds_unique h h'

/-! ## Opérations sur les limites -/

/-- La limite d'une somme est la somme des limites. -/
theorem limite_somme {u v : ℕ → ℝ} {l l' : ℝ} (hu : Tendsto u atTop (nhds l))
    (hv : Tendsto v atTop (nhds l')) : Tendsto (fun n => u n + v n) atTop (nhds (l + l')) :=
  hu.add hv

/-- Celle d'un produit est le produit des limites. -/
theorem limite_produit {u v : ℕ → ℝ} {l l' : ℝ} (hu : Tendsto u atTop (nhds l))
    (hv : Tendsto v atTop (nhds l')) : Tendsto (fun n => u n * v n) atTop (nhds (l * l')) :=
  hu.mul hv

/-- Celle d'un quotient est le quotient des limites, à condition que le dénominateur ne
tende pas vers zéro : c'est là que naissent les formes indéterminées. -/
theorem limite_quotient {u v : ℕ → ℝ} {l l' : ℝ} (hu : Tendsto u atTop (nhds l))
    (hv : Tendsto v atTop (nhds l')) (hl' : l' ≠ 0) :
    Tendsto (fun n => u n / v n) atTop (nhds (l / l')) :=
  hu.div hv hl'

/-- Forme indéterminée : deux suites tendant toutes deux vers `+∞` peuvent avoir une
différence de limite quelconque. Ici la différence tend vers `c`, choisi à l'avance. -/
theorem forme_indeterminee (c : ℝ) :
    Tendsto (fun n : ℕ => (n : ℝ) + c) atTop atTop ∧
      Tendsto (fun n : ℕ => (n : ℝ)) atTop atTop ∧
      Tendsto (fun n : ℕ => ((n : ℝ) + c) - n) atTop (nhds c) := by
  refine ⟨tendsto_natCast_atTop_atTop.atTop_add tendsto_const_nhds, tendsto_natCast_atTop_atTop, ?_⟩
  simp only [add_sub_cancel_left]
  exact tendsto_const_nhds

/-! ## Limite de `qⁿ` -/

/-- Si `|q| < 1`, la suite `qⁿ` tend vers zéro. -/
theorem limite_puissance_lt_un {q : ℝ} (hq : |q| < 1) :
    Tendsto (fun n : ℕ => q ^ n) atTop (nhds 0) :=
  tendsto_pow_atTop_nhds_zero_of_abs_lt_one hq

/-- Si `q > 1`, elle tend vers `+∞`. -/
theorem limite_puissance_gt_un {q : ℝ} (hq : 1 < q) :
    Tendsto (fun n : ℕ => q ^ n) atTop atTop :=
  tendsto_pow_atTop_atTop_of_one_lt hq

/-- Si `q = 1`, elle est constante égale à un. -/
theorem limite_puissance_eq_un : Tendsto (fun n : ℕ => (1 : ℝ) ^ n) atTop (nhds 1) := by
  simp only [one_pow]
  exact tendsto_const_nhds

/-! ## Théorèmes de comparaison et théorème des gendarmes -/

/-- Théorème des gendarmes : une suite encadrée par deux suites de même limite converge
vers cette limite. -/
theorem theoreme_des_gendarmes {u v w : ℕ → ℝ} {l : ℝ}
    (hvu : ∀ n, v n ≤ u n) (huw : ∀ n, u n ≤ w n)
    (hv : Tendsto v atTop (nhds l)) (hw : Tendsto w atTop (nhds l)) :
    Tendsto u atTop (nhds l) :=
  tendsto_of_tendsto_of_tendsto_of_le_of_le hv hw hvu huw

/-- Comparaison : une suite minorée par une suite qui tend vers `+∞` tend vers `+∞`. -/
theorem comparaison_infini {u v : ℕ → ℝ} (h : ∀ n, v n ≤ u n)
    (hv : Tendsto v atTop atTop) : Tendsto u atTop atTop :=
  tendsto_atTop_mono h hv

/-! ## Convergence monotone -/

/-- Toute suite croissante majorée converge. Le programme l'admet ; la démonstration
repose sur la propriété de la borne supérieure des réels. -/
theorem convergence_monotone {u : ℕ → ℝ} (hmono : Monotone u) {M : ℝ} (hmaj : ∀ n, u n ≤ M) :
    ∃ l : ℝ, Tendsto u atTop (nhds l) :=
  ⟨_, tendsto_atTop_ciSup hmono ⟨M, fun _ ⟨n, hn⟩ => hn ▸ hmaj n⟩⟩

/-- Une suite croissante non majorée tend vers `+∞`. -/
theorem croissante_non_majoree {u : ℕ → ℝ} (hmono : Monotone u)
    (hnon : ∀ M : ℝ, ∃ n, M < u n) : Tendsto u atTop atTop := by
  refine tendsto_atTop_atTop.mpr fun A => ?_
  obtain ⟨n, hn⟩ := hnon A
  exact ⟨n, fun m hm => le_trans hn.le (hmono hm)⟩

/-! ## Toute suite convergente est bornée -/

/-- Une suite qui converge est bornée : au-delà d'un certain rang elle reste dans un
intervalle, et avant ce rang il n'y a qu'un nombre fini de termes. -/
theorem convergente_bornee {u : ℕ → ℝ} {l : ℝ} (h : Tendsto u atTop (nhds l)) :
    ∃ M : ℝ, ∀ n, |u n| ≤ M := by
  obtain ⟨M, hM⟩ := h.norm.bddAbove_range
  exact ⟨M, fun n => hM ⟨n, rfl⟩⟩

/-! ## Suites adjacentes -/

/-- Deux suites adjacentes convergent vers une même limite. -/
theorem suites_adjacentes_convergent {u v : ℕ → ℝ} (h : Adjacentes u v) :
    ∃ l : ℝ, Tendsto u atTop (nhds l) ∧ Tendsto v atTop (nhds l) := by
  obtain ⟨hu, hv, hdiff⟩ := h
  have hle : ∀ n, u n ≤ v n := by
    intro n
    by_contra hlt
    simp only [not_le] at hlt
    have hpos : 0 < u n - v n := by linarith
    have hev : ∀ᶠ m in atTop, v m - u m ≤ v n - u n :=
      eventually_atTop.mpr ⟨n, fun m hm => by
        have h1 : u n ≤ u m := hu hm
        have h2 : v m ≤ v n := hv hm
        linarith⟩
    have h0 : (0 : ℝ) ≤ v n - u n := le_of_tendsto hdiff hev
    linarith
  obtain ⟨l, hl⟩ := convergence_monotone hu (M := v 0) fun n => le_trans (hle n) (hv (Nat.zero_le n))
  refine ⟨l, hl, ?_⟩
  have : Tendsto (fun n => (v n - u n) + u n) atTop (nhds (0 + l)) := hdiff.add hl
  simpa using this

/-! ## Suites définies par récurrence `uₙ₊₁ = f(uₙ)` -/

/-- Si une suite définie par `uₙ₊₁ = f(uₙ)` converge et que `f` est continue, la limite
est un point fixe de `f`. C'est ce qui permet de trouver la limite en résolvant
`f(ℓ) = ℓ`. -/
theorem limite_point_fixe {f : ℝ → ℝ} {u : ℕ → ℝ} {l : ℝ} (hf : Continuous f)
    (hrec : ∀ n, u (n + 1) = f (u n)) (hu : Tendsto u atTop (nhds l)) : f l = l := by
  have h1 : Tendsto (fun n => u (n + 1)) atTop (nhds l) := hu.comp (tendsto_add_atTop_nat 1)
  have h2 : Tendsto (fun n => f (u n)) atTop (nhds (f l)) := (hf.tendsto l).comp hu
  have h3 : Tendsto (fun n => u (n + 1)) atTop (nhds (f l)) := by
    simpa [hrec] using h2
  exact unicite_de_la_limite h3 h1

end Lycee.Suites
