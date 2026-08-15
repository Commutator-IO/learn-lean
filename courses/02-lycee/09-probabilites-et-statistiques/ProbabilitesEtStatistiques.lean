/-
Lycée — section « Probabilités et statistiques ».
Les probabilités sont celles de Mathlib : une mesure `μ` de masse totale `1` sur un
espace mesurable, un événement est une partie mesurable, l'espérance est l'intégrale
`μ[X]` et la variance `Var[X; μ]`.
Les séries statistiques sont des familles finies `x : Fin n → ℝ`, dont ce fichier pose la
moyenne, la variance et l'écart-type.
Trois énoncés du programme ne sont pas traités : le théorème de Moivre–Laplace,
l'intervalle de fluctuation asymptotique et l'intervalle de confiance. Voir la note en fin
de fichier.
Énoncés et démonstrations en français : voir ProbabilitesEtStatistiques.tex.
-/
import Mathlib

namespace Lycee.Probabilites

open MeasureTheory ProbabilityTheory Finset Filter Topology

/-! ## Définitions : séries statistiques -/

/- Toutes les définitions du fichier sont posées ici, avant les démonstrations. -/

/-- La moyenne d'une série statistique de `n` valeurs. -/
noncomputable def moyenne {n : ℕ} (x : Fin n → ℝ) : ℝ := (∑ i, x i) / n

/-- La variance d'une série statistique : moyenne des carrés des écarts à la moyenne. -/
noncomputable def varianceStat {n : ℕ} (x : Fin n → ℝ) : ℝ :=
  (∑ i, (x i - moyenne x) ^ 2) / n

/-- L'écart-type : racine carrée de la variance. -/
noncomputable def ecartType {n : ℕ} (x : Fin n → ℝ) : ℝ := Real.sqrt (varianceStat x)

/-- La médiane d'une série ordonnée de taille impaire : la valeur centrale. -/
def mediane {m : ℕ} (x : Fin (2 * m + 1) → ℝ) : ℝ := x ⟨m, by omega⟩

/-! ## Moyenne, médiane, écart-type -/

/-- La médiane partage la série ordonnée : les valeurs de rang inférieur lui sont
inférieures, celles de rang supérieur lui sont supérieures. -/
theorem mediane_partage {m : ℕ} {x : Fin (2 * m + 1) → ℝ} (hx : Monotone x)
    (i : Fin (2 * m + 1)) :
    (i ≤ ⟨m, by omega⟩ → x i ≤ mediane x) ∧ (⟨m, by omega⟩ ≤ i → mediane x ≤ x i) :=
  ⟨fun h => hx h, fun h => hx h⟩

/-- Linéarité de la moyenne : `moyenne(aX + b) = a moyenne(X) + b`. -/
theorem moyenne_affine {n : ℕ} (hn : n ≠ 0) (a b : ℝ) (x : Fin n → ℝ) :
    moyenne (fun i => a * x i + b) = a * moyenne x + b := by
  have hn' : (n : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hn
  simp only [moyenne, Finset.sum_add_distrib, ← Finset.mul_sum, Finset.sum_const,
    Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  field_simp

/-- La variance d'une série translatée et dilatée : `V(aX + b) = a²V(X)`. -/
theorem varianceStat_affine {n : ℕ} (hn : n ≠ 0) (a b : ℝ) (x : Fin n → ℝ) :
    varianceStat (fun i => a * x i + b) = a ^ 2 * varianceStat x := by
  have hn' : (n : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hn
  simp only [varianceStat, moyenne_affine hn a b x]
  have h : ∀ i : Fin n, (a * x i + b - (a * moyenne x + b)) ^ 2
      = a ^ 2 * (x i - moyenne x) ^ 2 := by
    intro i
    ring
  simp only [h, ← Finset.mul_sum]
  ring

/-- L'écart-type d'une série translatée et dilatée : `σ(aX + b) = |a| σ(X)`. -/
theorem ecartType_affine {n : ℕ} (hn : n ≠ 0) (a b : ℝ) (x : Fin n → ℝ) :
    ecartType (fun i => a * x i + b) = |a| * ecartType x := by
  have hpos : 0 ≤ varianceStat x := by
    unfold varianceStat
    positivity
  simp only [ecartType, varianceStat_affine hn a b x]
  rw [Real.sqrt_mul (sq_nonneg a), Real.sqrt_sq_eq_abs]

/-- Formule de König–Huygens : la variance est la moyenne des carrés moins le carré de la
moyenne. -/
theorem koenig_huygens {n : ℕ} (hn : n ≠ 0) (x : Fin n → ℝ) :
    varianceStat x = moyenne (fun i => (x i) ^ 2) - (moyenne x) ^ 2 := by
  have hn' : (n : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hn
  have hsum : ∑ i, x i = n * moyenne x := by
    rw [moyenne]
    field_simp
  simp only [varianceStat, moyenne]
  have h : ∀ i : Fin n, (x i - (∑ j, x j) / n) ^ 2
      = (x i) ^ 2 - 2 * ((∑ j, x j) / n) * x i + ((∑ j, x j) / n) ^ 2 := by
    intro i
    ring
  simp only [h, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum,
    Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  field_simp
  ring

/-! ## Probabilité d'une réunion, d'un complémentaire -/

/-- Probabilité d'une réunion et d'un complémentaire :
`P(A ∪ B) + P(A ∩ B) = P(A) + P(B)` et `P(A) + P(Ā) = 1`. -/
theorem probabilite_union_et_complementaire {Ω : Type*} [MeasurableSpace Ω]
    (μ : Measure Ω) [IsProbabilityMeasure μ] {A B : Set Ω} (hA : MeasurableSet A)
    (hB : MeasurableSet B) :
    μ (A ∪ B) + μ (A ∩ B) = μ A + μ B ∧ μ A + μ Aᶜ = 1 := by
  refine ⟨measure_union_add_inter A hB, ?_⟩
  rw [measure_add_measure_compl hA, measure_univ]

/-! ## Espérance et variance d'une variable aléatoire -/

/-- Espérance et variance d'une variable aléatoire affine :
`E(aX + b) = aE(X) + b` et `V(aX + b) = a²V(X)` ; et la formule de König–Huygens
`V(X) = E(X²) − E(X)²`. -/
theorem esperance_et_variance_affines {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}
    [IsProbabilityMeasure μ] {X : Ω → ℝ} (hX : MemLp X 2 μ) (a b : ℝ) :
    μ[fun ω => a * X ω + b] = a * μ[X] + b ∧
      Var[fun ω => a * X ω + b; μ] = a ^ 2 * Var[X; μ] ∧
      Var[X; μ] = μ[fun ω => (X ω) ^ 2] - (μ[X]) ^ 2 := by
  have hint : Integrable X μ := hX.integrable (by norm_num)
  refine ⟨?_, ?_, ?_⟩
  · rw [integral_add (hint.const_mul a) (integrable_const b), integral_const_mul,
      integral_const]
    simp
  · rw [variance_add_const (hX.aestronglyMeasurable.const_mul a) b, variance_const_mul]
  · exact variance_eq_sub hX

/-- Variance et écart-type d'une variable aléatoire : la variance est positive, et
l'écart-type, sa racine carrée, redonne la variance quand on l'élève au carré. -/
theorem variance_positive_et_ecart_type {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω)
    (X : Ω → ℝ) :
    0 ≤ Var[X; μ] ∧ Real.sqrt (Var[X; μ]) ^ 2 = Var[X; μ] :=
  ⟨variance_nonneg X μ, Real.sq_sqrt (variance_nonneg X μ)⟩

/-! ## Loi binomiale -/

/-- Loi binomiale : la probabilité d'obtenir `k` succès en `n` épreuves de Bernoulli
indépendantes de paramètre `p` vaut `C(n, k) pᵏ (1 − p)ⁿ⁻ᵏ`. -/
theorem loi_binomiale (n k : ℕ) (p : unitInterval) :
    (binomial n p).real {k} = (n.choose k) * (p : ℝ) ^ k * (1 - p) ^ (n - k) :=
  binomial_real_singleton n k p

/-- Identité combinatoire qui donne l'espérance d'une loi binomiale :
`∑ k C(n,k) pᵏ qⁿ⁻ᵏ = n p (p + q)ⁿ⁻¹`. -/
theorem somme_ponderee_binomiale (n : ℕ) (p q : ℝ) :
    ∑ k ∈ Finset.range (n + 1), (k : ℝ) * (n.choose k) * p ^ k * q ^ (n - k)
      = n * p * (p + q) ^ (n - 1) := by
  cases n with
  | zero => simp
  | succ m =>
    rw [Finset.sum_range_succ']
    have key : ∀ j ∈ Finset.range (m + 1),
        ((j + 1 : ℕ) : ℝ) * ((m + 1).choose (j + 1)) * p ^ (j + 1) * q ^ (m + 1 - (j + 1))
          = (m + 1 : ℝ) * p * ((m.choose j : ℝ) * p ^ j * q ^ (m - j)) := by
      intro j _
      have h : ((m + 1) * m.choose j : ℕ) = ((m + 1).choose (j + 1) * (j + 1) : ℕ) :=
        Nat.add_one_mul_choose_eq m j
      have hcast : ((m : ℝ) + 1) * (m.choose j) = ((m + 1).choose (j + 1)) * ((j : ℝ) + 1) := by
        exact_mod_cast h
      simp only [Nat.add_sub_add_right]
      push_cast
      linear_combination (-(p ^ (j + 1) * q ^ (m - j))) * hcast
    rw [Finset.sum_congr rfl key, ← Finset.mul_sum]
    have hsum : ∑ j ∈ Finset.range (m + 1), ((m.choose j : ℝ) * p ^ j * q ^ (m - j))
        = (p + q) ^ m := by
      rw [add_pow]
      exact Finset.sum_congr rfl fun j _ => by ring
    rw [hsum]
    simp

/-- Espérance d'une loi binomiale : `E(X) = np`. -/
theorem esperance_binomiale (n : ℕ) (p : unitInterval) :
    ∫ k, (k : ℝ) ∂(binomial n p) = n * (p : ℝ) := by
  rw [integral_binomial]
  have hIic : Finset.Iic n = Finset.range (n + 1) := by
    ext j
    simp
  rw [hIic]
  have h : ∀ k ∈ Finset.range (n + 1),
      ((n.choose k : ℝ) * (p : ℝ) ^ k * (1 - p) ^ (n - k)) • (k : ℝ)
        = (k : ℝ) * (n.choose k) * (p : ℝ) ^ k * (1 - p) ^ (n - k) := by
    intro k _
    simp only [smul_eq_mul]
    ring
  rw [Finset.sum_congr rfl h, somme_ponderee_binomiale n (p : ℝ) (1 - p)]
  simp

/-! ## Probabilités conditionnelles -/

/-- Probabilité conditionnelle : `P_A(B) = P(A ∩ B)/P(A)`, et formule des probabilités
composées `P(A ∩ B) = P(A) P_A(B)`. -/
theorem probabilite_conditionnelle {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω)
    [IsProbabilityMeasure μ] {A : Set Ω} (hA : MeasurableSet A) (B : Set Ω) :
    μ[B|A] = (μ A)⁻¹ * μ (A ∩ B) ∧ μ A * μ[B|A] = μ (A ∩ B) :=
  ⟨cond_apply hA μ B, by rw [mul_comm]; exact cond_mul_eq_inter hA B μ⟩

/-- Formule des probabilités totales, sur la partition `{A, Ā}` : c'est le calcul que fait
un arbre pondéré. -/
theorem probabilites_totales {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω)
    [IsProbabilityMeasure μ] {A : Set Ω} (hA : MeasurableSet A) (B : Set Ω) :
    μ B = μ A * μ[B|A] + μ Aᶜ * μ[B|Aᶜ] := by
  rw [mul_comm (μ A), mul_comm (μ Aᶜ), cond_mul_eq_inter hA B μ, cond_mul_eq_inter hA.compl B μ,
    Set.inter_comm A B, Set.inter_comm Aᶜ B]
  have h := measure_inter_add_sdiff (μ := μ) B hA
  rw [Set.sdiff_eq] at h
  exact h.symm

/-! ## Indépendance -/

/-- Deux événements sont indépendants si et seulement si la probabilité de leur
intersection est le produit de leurs probabilités ; et l'indépendance passe au
complémentaire. -/
theorem independance {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω)
    [IsProbabilityMeasure μ] {A B : Set Ω} (hA : MeasurableSet A) (hB : MeasurableSet B) :
    (IndepSet A B μ ↔ μ (A ∩ B) = μ A * μ B) ∧
      (μ (A ∩ B) = μ A * μ B → μ (A ∩ Bᶜ) = μ A * μ Bᶜ) := by
  refine ⟨indepSet_iff_measure_inter_eq_mul hA hB μ, fun h => ?_⟩
  have h1 : μ (A ∩ Bᶜ) + μ A * μ B = μ A := by
    rw [← h, add_comm]
    have hd := measure_inter_add_sdiff (μ := μ) A hB
    rw [Set.sdiff_eq] at hd
    exact hd
  have h2 : μ A * μ Bᶜ + μ A * μ B = μ A := by
    rw [← mul_add, add_comm (μ Bᶜ), measure_add_measure_compl hB, measure_univ, mul_one]
  exact (ENNReal.add_left_inj
    (ENNReal.mul_ne_top (measure_ne_top μ A) (measure_ne_top μ B))).mp (h1.trans h2.symm)

/-! ## Loi uniforme -/

/-- Loi uniforme sur `[a ; b]` : la densité constante `1/(b − a)` est bien une densité de
probabilité, et l'espérance vaut `(a + b)/2`. -/
theorem loi_uniforme {a b : ℝ} (hab : a < b) :
    (∫ _x in a..b, (b - a)⁻¹) = 1 ∧ (∫ x in a..b, x * (b - a)⁻¹) = (a + b) / 2 := by
  have hne : b - a ≠ 0 := by linarith
  constructor
  · rw [intervalIntegral.integral_const, smul_eq_mul]
    field_simp
  · rw [intervalIntegral.integral_mul_const, integral_id]
    field_simp
    ring

/-! ## Loi exponentielle -/

/-- Loi exponentielle de paramètre `r > 0` : sa fonction de répartition vaut
`1 − e^{−rt}` pour `t ≥ 0`, de sorte que `P(X > t) = e^{−rt}` ; l'absence de mémoire en
découle, `P(X > s + t) = P(X > s) P(X > t)`. -/
theorem loi_exponentielle {r : ℝ} (hr : 0 < r) {t : ℝ} (ht : 0 ≤ t) (s : ℝ) :
    exponentialPDF r t = ENNReal.ofReal (r * Real.exp (-(r * t))) ∧
      cdf (expMeasure r) t = 1 - Real.exp (-(r * t)) ∧
      Real.exp (-(r * (s + t))) = Real.exp (-(r * s)) * Real.exp (-(r * t)) := by
  refine ⟨exponentialPDF_of_nonneg ht, ?_, ?_⟩
  · rw [cdf_expMeasure_eq hr t, if_pos ht]
  · rw [← Real.exp_add]
    ring_nf

/-! ## Loi normale -/

/-- Loi normale `N(μ, σ²)` : son espérance vaut `μ` et sa variance `σ²`. -/
theorem loi_normale (m : ℝ) (v : NNReal) :
    (∫ x, x ∂(gaussianReal m v) = m) ∧ Var[id; gaussianReal m v] = v :=
  ⟨integral_id_gaussianReal, variance_id_gaussianReal⟩

/-! ## Énoncés admis -/

/-
Ce que le programme demande et que ce dépôt ne démontre pas. Les énoncés sont écrits pour
que le manque se voie et se compte ; leur démonstration est admise.

Un mot sur chacun. La variance d'une binomiale et l'espérance d'une exponentielle
sont à portée, mais demandent un calcul de somme et une intégration par parties que ce
fichier n'a pas menés. Le théorème de Moivre–Laplace est un cas particulier du théorème
central limite : Mathlib le possède, mais l'écart entre son énoncé et la forme scolaire,
qui parle d'intervalles et de valeurs numériques, est un travail de traduction à part
entière. Les intervalles `1σ`, `2σ`, `3σ` réclament un encadrement de la fonction
d'erreur que Mathlib ne fournit pas à cette précision. L'intervalle de fluctuation et
l'intervalle de confiance reposent sur Moivre–Laplace, et tombent avec lui.

Les quartiles et l'écart interquartile manquent aussi, mais il leur manque une définition,
pas une démonstration : rien à admettre tant qu'ils ne sont pas définis.
-/

/-- Variance d'une loi binomiale : `V(X) = np(1 − p)`. -/
theorem variance_binomiale (n : ℕ) (p : unitInterval) :
    Var[fun k : ℕ => (k : ℝ); binomial n p] = n * (p : ℝ) * (1 - (p : ℝ)) := by
  sorry

/-- Espérance d'une loi exponentielle de paramètre `r` : elle vaut `1/r`. -/
theorem esperance_exponentielle {r : ℝ} (hr : 0 < r) :
    ∫ t, t ∂(expMeasure r) = 1 / r := by
  sorry

/-- Théorème de Moivre–Laplace : la loi binomiale centrée réduite converge vers la loi
normale centrée réduite. -/
theorem moivre_laplace {p : unitInterval} (hp : 0 < (p : ℝ)) (hp1 : (p : ℝ) < 1) (x : ℝ) :
    Tendsto (fun n : ℕ => ((binomial n p)
        {k : ℕ | ((k : ℝ) - n * p) / Real.sqrt (n * (p : ℝ) * (1 - p)) ≤ x}).toReal)
      atTop (nhds (cdf (gaussianReal 0 1) x)) := by
  sorry

/-- Intervalles `1σ`, `2σ` et `3σ` d'une loi normale : environ 68 %, 95 % et 99,7 %. -/
theorem intervalles_sigma (m : ℝ) (σ : NNReal) (hσ : 0 < σ) :
    |((gaussianReal m (σ ^ 2)) (Set.Icc (m - σ) (m + σ))).toReal - 0.68| ≤ 0.005 ∧
      |((gaussianReal m (σ ^ 2)) (Set.Icc (m - 2 * σ) (m + 2 * σ))).toReal - 0.95| ≤ 0.005 ∧
      |((gaussianReal m (σ ^ 2)) (Set.Icc (m - 3 * σ) (m + 3 * σ))).toReal - 0.997| ≤ 0.005 := by
  sorry

/-- Intervalle de fluctuation asymptotique au seuil de 95 % : la fréquence observée tombe
dans `[p ± 1,96 √(p(1−p)/n)]` avec une probabilité qui tend vers celle que la loi normale
donne à `[−1,96 ; 1,96]`. -/
theorem intervalle_de_fluctuation {p : unitInterval} (hp : 0 < (p : ℝ)) (hp1 : (p : ℝ) < 1) :
    Tendsto (fun n : ℕ => ((binomial n p)
        {k : ℕ | |(k : ℝ) / n - p| ≤ 1.96 * Real.sqrt ((p : ℝ) * (1 - p) / n)}).toReal)
      atTop (nhds (cdf (gaussianReal 0 1) 1.96 - cdf (gaussianReal 0 1) (-1.96))) := by
  sorry

/-- Intervalle de confiance : à partir d'un certain rang, la fréquence observée est à
moins de `1/√n` de la probabilité cherchée dans au moins 95 % des cas. -/
theorem intervalle_de_confiance {p : unitInterval} (hp : 0 < (p : ℝ)) (hp1 : (p : ℝ) < 1) :
    ∀ᶠ n : ℕ in atTop,
      0.95 ≤ ((binomial n p) {k : ℕ | |(k : ℝ) / n - p| ≤ 1 / Real.sqrt n}).toReal := by
  sorry

end Lycee.Probabilites
