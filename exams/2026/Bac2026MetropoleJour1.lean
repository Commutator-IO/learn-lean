/-
Baccalauréat, épreuve de spécialité — voie générale, Métropole, 16 juin 2026 (jour 1).

Chaque question du sujet qui porte une proposition mathématique devient ici un
théorème. Celles qui n'en portent pas — compléter un arbre, lire une pente sur un
graphique, écrire un programme — n'ont pas d'énoncé, et l'index du dossier dit
lesquelles et pourquoi.

Les probabilités sont traitées comme le sujet les traite : sur les nombres. La
construction de l'espace probabilisé n'apporterait rien à des calculs qui portent
sur une loi donnée par un tableau, et le chapitre « Probabilités et statistiques »
du cours fait ce travail-là pour ses propres énoncés.
-/
import Mathlib

namespace Bac.Metropole2026.Jour1

/-! ## Exercice 1 — probabilités conditionnelles, espérance, Bienaymé-Tchebychev -/

/-- Partie A, question 1a : la probabilité de l'évènement contraire est le
complément à `1` — si `75 %` des familles réservent une cabine, `25 %` n'en
réservent pas. -/
theorem ex1_evenement_contraire {p : ℚ} (h : p = 0.75) : 1 - p = 0.25 := by
  rw [h]; norm_num

/-- Partie A, question 2 : `P(V ∩ C) = P(V) × P_V(C) = 0,3 × 0,8 = 0,24`. C'est la
lecture d'un chemin de l'arbre : les probabilités s'y multiplient. -/
theorem ex1_intersection : (0.3 : ℚ) * 0.8 = 0.24 := by norm_num

/-- Partie A, question 3 : `P_C(V) = P(V ∩ C) / P(C) = 0,24 / 0,75 = 0,32`. -/
theorem ex1_conditionnelle : (0.24 : ℚ) / 0.75 = 0.32 := by norm_num

/-- Partie A, question 4 : `P_V̄(C) = (P(C) − P(V ∩ C)) / P(V̄)`, soit `0,51/0,7`,
c'est-à-dire `0,73` à `10⁻²` près.

La formule des probabilités totales donne `P(V̄ ∩ C) = P(C) − P(V ∩ C)` : une famille
qui réserve une cabine réserve ou non un véhicule, et les deux cas s'excluent. -/
theorem ex1_conditionnelle_contraire :
    |((0.75 : ℚ) - 0.24) / 0.7 - 0.73| < 0.005 := by
  rw [abs_lt]; norm_num

/-- Partie B, question 1 : `E(X) = 96` et `V(X) = 3 114`.

L'espérance est la moyenne des valeurs pondérée par leurs probabilités ; la variance
s'obtient par König–Huygens, `V(X) = E(X²) − E(X)²`, ici `12 330 − 9 216`. -/
theorem ex1_esperance_variance :
    (0 * 0.19 + 70 * 0.06 + 100 * 0.51 + 170 * 0.24 : ℚ) = 96 ∧
      (0 ^ 2 * 0.19 + 70 ^ 2 * 0.06 + 100 ^ 2 * 0.51 + 170 ^ 2 * 0.24 : ℚ) - 96 ^ 2 = 3114 := by
  norm_num

/-- Partie B, question 2b : `E(Z) = 120` et `V(Z) = 1 728`.

L'espérance est linéaire, donc se multiplie par `0,6` ; la variance, quadratique, se
multiplie par `0,6² = 0,36`. Les variables `X` et `Y` étant indépendantes, leurs
variances s'ajoutent — c'est là que l'hypothèse d'indépendance sert, et nulle part
ailleurs. -/
theorem ex1_reduction :
    (0.6 : ℚ) * (96 + 104) = 120 ∧ (0.6 : ℚ) ^ 2 * (3114 + 1686) = 1728 := by
  norm_num

/-- Partie B, question 3a : la moyenne de `n` variables indépendantes de même loi a
pour espérance celle de la loi, et pour variance la sienne divisée par `n`. C'est ce
qui fait qu'une moyenne se resserre quand l'échantillon grandit. -/
theorem ex1_moyenne_empirique {n : ℚ} (hn : n ≠ 0) :
    n * 120 / n = 120 ∧ n * 1728 / n ^ 2 = 1728 / n := by
  constructor
  · field_simp
  · field_simp

/-- Partie B, question 3b : l'inégalité de Bienaymé-Tchebychev donne
`P(|Mₙ − 120| ≥ 6) ≤ V(Mₙ)/6² = 48/n`. Pour que la probabilité complémentaire
atteigne `0,85`, il faut `48/n ≤ 0,15`, c'est-à-dire `n ≥ 320`. -/
theorem ex1_bienayme_tchebychev {n : ℕ} (hn : 0 < n) :
    (1728 : ℚ) / (n * 6 ^ 2) ≤ 0.15 ↔ 320 ≤ n := by
  have hpos : (0 : ℚ) < (n : ℚ) := by exact_mod_cast hn
  rw [div_le_iff₀ (by positivity)]
  constructor
  · intro h
    have h320 : (320 : ℚ) ≤ (n : ℚ) := by linarith
    exact_mod_cast h320
  · intro h
    have h320 : (320 : ℚ) ≤ (n : ℚ) := by exact_mod_cast h
    linarith

/-! ## Exercice 2 — vrai ou faux : espace et dénombrement -/

/-- Affirmation 1, **vraie**. Le plan a pour vecteur normal `(−1 ; 1 ; −5)`, qui est
exactement le vecteur `AB` : le plan est donc orthogonal à la droite `(AB)`. Et le
milieu de `[AB]`, de coordonnées `(2,5 ; 0,5 ; −0,5)`, vérifie son équation. C'est
le plan médiateur de `[AB]`. -/
theorem ex2_affirmation_1 :
    ((2 : ℚ) - 3, (1 : ℚ) - 0, (-3 : ℚ) - 2) = (-1, 1, -5) ∧
      -((3 + 2) / 2 : ℚ) + (0 + 1) / 2 - 5 * ((2 + -3) / 2) - 0.5 = 0 := by
  norm_num

/-- Affirmation 2, **fausse**. Chercher un point commun aux deux droites revient à
résoudre un système de trois équations à deux inconnues. Les première et troisième
donnent `s = 6/7` ; la deuxième est alors fausse. Les droites ne se coupent pas —
elles ne sont pas non plus parallèles, donc elles sont non coplanaires. -/
theorem ex2_affirmation_2 :
    ¬ ∃ t s : ℚ, t = 3 - s ∧ -1.5 - t = s ∧ 2 - 2 * t = 2 - 5 * s := by
  rintro ⟨t, s, h1, h2, h3⟩
  norm_num at h1 h2 h3
  linarith

/-- Affirmation 3, **vraie**. Les vecteurs `CA` et `CB` ont la même norme, `4,5`, et
leur produit scalaire vaut `6,75` : le cosinus de l'angle en `C` vaut donc `1/3`, et
`arccos(1/3)` vaut `70,5°` à un dixième près.

Ce qui se démontre ici est le cosinus ; la conversion en degrés arrondis est une
évaluation numérique, que le sujet demande à la calculatrice. -/
theorem ex2_affirmation_3 :
    (1.5 * 0.5 + 3 * 4 + 3 * (-2) : ℚ) = 6.75 ∧
      (1.5 ^ 2 + 3 ^ 2 + 3 ^ 2 : ℚ) = 20.25 ∧
      (0.5 ^ 2 + 4 ^ 2 + 2 ^ 2 : ℚ) = 20.25 ∧
      (6.75 : ℚ) / 20.25 = 1 / 3 := by
  norm_num

/-- Affirmation 4, **vraie**. Le code de la porte `A` est un arrangement de `3`
symboles parmi `8`, soit `8 × 7 × 6 = 336` possibilités ; celui de la porte `B` est
une combinaison de `4` parmi `8`, soit `70`. Titouan a une chance sur `70`, Clotilde
une sur `336`.

L'ordre est ce qui sépare les deux comptages, et c'est tout l'objet de la question. -/
theorem ex2_affirmation_4 :
    8 * 7 * 6 = 336 ∧ Nat.choose 8 4 = 70 ∧ (1 : ℚ) / 70 > 1 / 336 := by
  refine ⟨by norm_num, by decide, by norm_num⟩

/-! ## Exercice 3 — équation différentielle et suite -/

/-- Partie A, question 2 : la fonction `T(t) = 26 − 8e^{−0,035t}` est solution de
l'équation différentielle `y' = −0,035y + 0,91`, et vaut `18` en `0`.

En dérivant, `T'(t) = 0,28 e^{−0,035t}` ; et
`−0,035 T(t) + 0,91 = −0,91 + 0,28 e^{−0,035t} + 0,91`, qui est la même chose. -/
theorem ex3_solution (t : ℝ) :
    HasDerivAt (fun s : ℝ => 26 - 8 * Real.exp (-0.035 * s))
      (-0.035 * (26 - 8 * Real.exp (-0.035 * t)) + 0.91) t := by
  have h : HasDerivAt (fun s : ℝ => -0.035 * s) (-0.035) t := by
    simpa using (hasDerivAt_id t).const_mul (-0.035 : ℝ)
  have h2 : HasDerivAt (fun s : ℝ => 26 - 8 * Real.exp (-0.035 * s))
      (0 - 8 * (Real.exp (-0.035 * t) * (-0.035))) t :=
    (hasDerivAt_const t (26 : ℝ)).sub ((h.exp).const_mul (8 : ℝ))
  convert h2 using 1
  ring

/-- Partie A, question 4 : la température ne dépassera jamais `28 °C`, ni même
`26 °C` : l'exponentielle est strictement positive, donc `26 − 8e^{−0,035t} < 26`.

La valeur `26` est la limite du modèle, et le système n'y arrive jamais. -/
theorem ex3_majoration (t : ℝ) : 26 - 8 * Real.exp (-0.035 * t) < 28 := by
  have := Real.exp_pos (-0.035 * t)
  linarith

/-- Partie B, question 1 : `u₁ = 19,72`. -/
theorem ex3_u1 : (0.965 : ℝ) * 20 + 0.35 + 0.07 * Real.exp (-0.1 * 0) = 19.72 := by
  norm_num

/-- Partie B, question 2 : par récurrence, `uₙ > 10` pour tout `n`.

L'hérédité tient à ce que `0,965 × 10 + 0,35 = 10` exactement : la borne `10` est le
point fixe de la partie affine de la récurrence, et le terme exponentiel, positif, ne
peut que l'écarter vers le haut. -/
theorem ex3_minoration (u : ℕ → ℝ) (h0 : u 0 = 20)
    (hrec : ∀ n, u (n + 1) = 0.965 * u n + 0.35 + 0.07 * Real.exp (-0.1 * n)) :
    ∀ n, 10 < u n := by
  intro n
  induction n with
  | zero => rw [h0]; norm_num
  | succ k hk =>
      rw [hrec k]
      have := Real.exp_pos (-0.1 * (k : ℝ))
      nlinarith

/-- Partie B, question 4 : la limite vérifie `x = 0,965x + 0,35`, donc vaut `10`.

La suite étant décroissante et minorée par `10`, elle converge ; sa limite est point
fixe de la relation de récurrence, dont le terme exponentiel tend vers zéro. -/
theorem ex3_limite {l : ℝ} (h : l = 0.965 * l + 0.35) : l = 10 := by linarith

/-! ## Exercice 4 — une fonction avec un logarithme -/

/-- Partie A, question 1 : la courbe passe par `A(0 ; 1)`, et `f(0) = a` puisque
`ln 1 = 0` : donc `a = 1`. -/
theorem ex4_valeur_de_a {a b : ℝ} (h : a + b * Real.log (0 + 1) / (0 + 1) = 1) : a = 1 := by
  simpa using h

/-- Partie A, question 3a : `f'(x) = b(1 − ln(x+1))/(x+1)²`.

C'est la dérivée d'un quotient : `(u/v)' = (u'v − uv')/v²` avec `u = b ln(x+1)` et
`v = x+1`, ce qui donne `(b/(x+1) × (x+1) − b ln(x+1))/(x+1)²`. -/
theorem ex4_derivee {b x : ℝ} (hx : -1 < x) :
    HasDerivAt (fun t : ℝ => 1 + b * Real.log (t + 1) / (t + 1))
      (b * (1 - Real.log (x + 1)) / (x + 1) ^ 2) x := by
  have hpos : (0 : ℝ) < x + 1 := by linarith
  have hne : x + 1 ≠ 0 := hpos.ne'
  have hid : HasDerivAt (fun t : ℝ => t + 1) 1 x := by
    simpa using (hasDerivAt_id x).add_const (1 : ℝ)
  have hlog : HasDerivAt (fun t : ℝ => Real.log (t + 1)) (1 / (x + 1)) x := by
    simpa [div_eq_inv_mul] using hid.log hne
  have h2 := ((hlog.const_mul b).div hid hne).const_add (1 : ℝ)
  have heq : (b * (1 / (x + 1)) * (x + 1) - b * Real.log (x + 1) * 1) / (x + 1) ^ 2
      = b * (1 - Real.log (x + 1)) / (x + 1) ^ 2 := by
    field_simp
  rw [heq] at h2
  simpa using h2

/-- Partie A, question 3b : la valeur `b = 4` se lit sur la tangente en `A`, puisque
`f'(0) = b(1 − ln 1)/1² = b`. La pente, elle, est lue sur le graphique. -/
theorem ex4_valeur_de_b {b : ℝ} (h : b * (1 - Real.log (0 + 1)) / (0 + 1) ^ 2 = 4) : b = 4 := by
  simpa using h

/-- Partie B, question 2 : sur `]−1 ; +∞[`, l'inéquation `1 − ln(x+1) > 0` équivaut à
`x < e − 1`. Le logarithme étant strictement croissant, il suffit de composer par
l'exponentielle. -/
theorem ex4_inequation {x : ℝ} (hx : -1 < x) :
    1 - Real.log (x + 1) > 0 ↔ x < Real.exp 1 - 1 := by
  have hpos : (0 : ℝ) < x + 1 := by linarith
  constructor
  · intro h
    have hl : Real.log (x + 1) < 1 := by linarith
    have := (Real.log_lt_iff_lt_exp hpos).1 hl
    linarith
  · intro h
    have hlt : x + 1 < Real.exp 1 := by linarith
    have := (Real.log_lt_iff_lt_exp hpos).2 hlt
    linarith

/-- Partie B, question 5a : `∫₀² ln(x+1)/(x+1) dx = (ln 3)²/2`.

L'intégrande est de la forme `u'u` avec `u = ln(x+1)` : une primitive est `u²/2`, et
il ne reste qu'à évaluer entre les bornes, où `ln 1 = 0` et `ln 3` restent. -/
theorem ex4_integrale :
    ∫ x in (0 : ℝ)..2, Real.log (x + 1) / (x + 1) = (Real.log 3) ^ 2 / 2 := by
  have deriv : ∀ x ∈ Set.uIcc (0 : ℝ) 2,
      HasDerivAt (fun t : ℝ => Real.log (t + 1) * Real.log (t + 1) / 2)
        (Real.log (x + 1) / (x + 1)) x := by
    intro x hx
    rw [Set.uIcc_of_le (by norm_num)] at hx
    have hpos : (0 : ℝ) < x + 1 := by linarith [hx.1]
    have hne : x + 1 ≠ 0 := hpos.ne'
    have hid : HasDerivAt (fun t : ℝ => t + 1) 1 x := by
      simpa using (hasDerivAt_id x).add_const (1 : ℝ)
    have hlog : HasDerivAt (fun t : ℝ => Real.log (t + 1)) (1 / (x + 1)) x := by
      simpa [div_eq_inv_mul] using hid.log hne
    -- `log² = log × log` : le produit évite la puissance entière, dont la dérivée
    -- fait apparaître un entier converti en réel qu'il faudrait ensuite simplifier.
    have h2 := (hlog.mul hlog).div_const 2
    have heq : (1 / (x + 1) * Real.log (x + 1) + Real.log (x + 1) * (1 / (x + 1))) / 2
        = Real.log (x + 1) / (x + 1) := by
      field_simp; ring
    rw [heq] at h2
    exact h2
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt deriv]
  · norm_num [pow_two]
  · apply ContinuousOn.intervalIntegrable
    have h1 : ContinuousOn (fun x : ℝ => x + 1) (Set.uIcc (0 : ℝ) 2) := by fun_prop
    have hne : ∀ x ∈ Set.uIcc (0 : ℝ) 2, x + 1 ≠ 0 := by
      intro x hx
      rw [Set.uIcc_of_le (by norm_num)] at hx
      have : (0 : ℝ) < x + 1 := by linarith [hx.1]
      exact this.ne'
    exact (h1.log hne).div h1 hne

end Bac.Metropole2026.Jour1
