/-
Baccalauréat, épreuve de spécialité — voie générale, Métropole, 17 juin 2026 (jour 2).

Même principe que le jour 1 : chaque question qui porte une proposition devient un
théorème, et l'index du dossier dit lesquelles n'en portent pas.

La géométrie dans l'espace est traitée en coordonnées, comme le sujet la traite : les
points sont des triplets, l'orthogonalité un produit scalaire nul. C'est fidèle à ce
que l'élève écrit, et suffisant pour tout ce que l'exercice demande.
-/
import Mathlib

namespace Bac.Metropole2026.Jour2

/-! ## Exercice 1 — géométrie dans l'espace -/

/-- Question 2a : le vecteur `n(1 ; −1 ; 4)` est normal au plan `(ABC)`, car il est
orthogonal à `AB(1 ; −3 ; −1)` et à `AC(−2 ; −2 ; 0)`.

Deux produits scalaires nuls suffisent : `AB` et `AC` ne sont pas colinéaires, donc ils
engendrent la direction du plan. -/
theorem ex1_vecteur_normal :
    (1 * 1 + (-1) * (-3) + 4 * (-1) : ℚ) = 0 ∧ (1 * (-2) + (-1) * (-2) + 4 * 0 : ℚ) = 0 := by
  norm_num

/-- Question 2b : l'équation cartésienne du plan est `x − y + 4z − 5 = 0`.

Les coefficients sont ceux du vecteur normal ; la constante se règle pour que `A` soit
sur le plan, et l'on vérifie que `B` et `C` y sont aussi. -/
theorem ex1_equation_du_plan :
    (2 - 1 + 4 * 1 - 5 : ℚ) = 0 ∧ (3 - (-2) + 4 * 0 - 5 : ℚ) = 0 ∧
      (0 - (-1) + 4 * 1 - 5 : ℚ) = 0 := by
  norm_num

/-- Question 4 : le projeté orthogonal de `D(0 ; 0 ; 2)` sur `(ABC)` est
`H(−1/6 ; 1/6 ; 4/3)`.

Deux choses à vérifier, et deux seulement : `H` appartient au plan, et le vecteur `DH`
est colinéaire au vecteur normal — ici `DH = −(1/6) n`. -/
theorem ex1_projete_orthogonal :
    (-1 / 6 - 1 / 6 + 4 * (4 / 3) - 5 : ℚ) = 0 ∧
      ((-1 / 6 - 0 : ℚ), (1 / 6 - 0 : ℚ), (4 / 3 - 2 : ℚ))
        = (-(1 / 6) * 1, -(1 / 6) * (-1), -(1 / 6) * 4) := by
  norm_num

/-- Question 5a : le triangle `ABC` est isocèle en `B`, car `BA` et `BC` ont le même
carré scalaire, `11`. -/
theorem ex1_isocele :
    ((2 - 3) ^ 2 + (1 - (-2)) ^ 2 + (1 - 0) ^ 2 : ℚ)
      = ((0 - 3) ^ 2 + ((-1) - (-2)) ^ 2 + (1 - 0) ^ 2 : ℚ) := by
  norm_num

/-- Question 5b : l'aire du triangle `ABC` vaut `3√2`.

Elle est la moitié de la norme du produit vectoriel `AB ∧ AC = (−2 ; 2 ; −8)`, dont le
carré scalaire vaut `72` ; et `√72 = 6√2`. -/
theorem ex1_aire :
    ((-2 : ℚ) ^ 2 + 2 ^ 2 + (-8) ^ 2) = 72 ∧
      Real.sqrt 72 / 2 = 3 * Real.sqrt 2 := by
  refine ⟨by norm_num, ?_⟩
  rw [show (72 : ℝ) = 6 ^ 2 * 2 by norm_num, Real.sqrt_mul (by positivity),
    Real.sqrt_sq (by norm_num)]
  ring

/-- Question 6a : le volume du tétraèdre `ABCD` vaut `1`.

La hauteur issue de `D` est la distance `DH`, de norme `(1/6)√18 = √2/2`, et la base
`ABC` a pour aire `3√2` : le produit `(1/3) × 3√2 × (√2/2)` vaut bien `1`. -/
theorem ex1_volume : (1 / 3 : ℝ) * (3 * Real.sqrt 2) * (Real.sqrt 2 / 2) = 1 := by
  have h : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  nlinarith [h]

/-- Question 6b : l'aire du triangle `BCD` vaut `3√2/2`.

Le volume ne dépend pas de la face choisie comme base : en prenant `BCD` et la hauteur
issue de `A`, qui vaut `√2`, on retrouve `1`, ce qui détermine l'aire. -/
theorem ex1_aire_bcd {a : ℝ} (h : (1 / 3 : ℝ) * a * Real.sqrt 2 = 1) :
    a = 3 * Real.sqrt 2 / 2 := by
  have h2 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have hpos : (0 : ℝ) < Real.sqrt 2 := Real.sqrt_pos.2 (by norm_num)
  field_simp at h ⊢
  nlinarith [h, h2]

/-- Question 7a : les points `A`, `B`, `C` et `Dₖ(0 ; 0 ; k)` sont coplanaires pour
`k = 5/4` — c'est la valeur qui place `Dₖ` sur le plan `(ABC)`. Le projeté orthogonal
de `Dₖ` est alors `Dₖ` lui-même. -/
theorem ex1_coplanarite {k : ℚ} (h : 0 - 0 + 4 * k - 5 = 0) : k = 5 / 4 := by linarith

/-! ## Exercice 2 — pollution d'un bassin : modèle discret et modèle continu -/

/-- Partie A, question 1 : `V₁ = 6` et `V₂ = 11,97`. -/
theorem ex2_premiers_termes :
    (0.995 : ℚ) * 0 + 6 = 6 ∧ (0.995 : ℚ) * 6 + 6 = 11.97 := by norm_num

/-- Partie A, question 3 : par récurrence, `Vₙ ≤ Vₙ₊₁ ≤ 1 200`.

L'encadrement est stable parce que `1 200` est le point fixe de la récurrence :
`0,995 × 1 200 + 6 = 1 200`. Et l'écart `Vₙ₊₁ − Vₙ = 6 − 0,005 Vₙ` reste positif tant
que `Vₙ` ne dépasse pas `1 200`. -/
theorem ex2_croissance_majoree (V : ℕ → ℝ) (h0 : V 0 = 0)
    (hrec : ∀ n, V (n + 1) = 0.995 * V n + 6) :
    ∀ n, 0 ≤ V n ∧ V n ≤ V (n + 1) ∧ V (n + 1) ≤ 1200 := by
  have cle : ∀ n, 0 ≤ V n ∧ V n ≤ 1200 := by
    intro n
    induction n with
    | zero => rw [h0]; norm_num
    | succ k hk =>
        obtain ⟨h1, h2⟩ := hk
        rw [hrec k]
        constructor <;> nlinarith
  intro n
  obtain ⟨h1, h2⟩ := cle n
  refine ⟨h1, ?_, ?_⟩ <;> rw [hrec n] <;> nlinarith

/-- Partie B, question 1b : la fonction `v(t) = 1 200(1 − e^{−0,005t})` est solution de
`y' = −0,005y + 6`.

En dérivant, `v'(t) = 6 e^{−0,005t}` ; et `−0,005 v(t) + 6 = −6 + 6e^{−0,005t} + 6`. -/
theorem ex2_solution (t : ℝ) :
    HasDerivAt (fun s : ℝ => 1200 * (1 - Real.exp (-0.005 * s)))
      (-0.005 * (1200 * (1 - Real.exp (-0.005 * t))) + 6) t := by
  have h : HasDerivAt (fun s : ℝ => -0.005 * s) (-0.005) t := by
    simpa using (hasDerivAt_id t).const_mul (-0.005 : ℝ)
  have h2 : HasDerivAt (fun s : ℝ => 1200 * (1 - Real.exp (-0.005 * s)))
      (1200 * (0 - Real.exp (-0.005 * t) * (-0.005))) t :=
    (((hasDerivAt_const t (1 : ℝ)).sub h.exp).const_mul (1200 : ℝ))
  convert h2 using 1
  ring

/-- Partie B, question 2 : le taux de substance polluante plafonne à
`1 200 / 30 000 = 4 %`, en deçà des `5 %` qui imposeraient un nettoyage complet.

Le volume ne dépasse jamais `1 200` litres, puisque l'exponentielle est positive. -/
theorem ex2_taux_maximal :
    (1200 : ℚ) / 30000 = 4 / 100 ∧ (4 : ℚ) / 100 < 5 / 100 := by norm_num

/-- Partie B, question 3 : le volume dépasse `50` litres à partir de
`t = 200 ln(24/23)` heures.

L'équation `1 200(1 − e^{−0,005t}) = 50` donne `e^{−0,005t} = 23/24`, d'où le
logarithme. -/
theorem ex2_seuil {t : ℝ} (h : 1200 * (1 - Real.exp (-0.005 * t)) = 50) :
    t = 200 * Real.log (24 / 23) := by
  have hexp : Real.exp (-0.005 * t) = 23 / 24 := by linarith
  have := congrArg Real.log hexp
  rw [Real.log_exp] at this
  rw [show (24 : ℝ) / 23 = (23 / 24)⁻¹ by norm_num, Real.log_inv]
  linarith [this]

/-! ## Exercice 3 — vrai ou faux : probabilités et dénombrement -/

/-- Affirmation 1, **vraie**. La formule de Bayes donne
`P_F(O) = P(O) × P_O(F) / P(F) = 0,52 × 0,32 / 0,20 = 0,832`. -/
theorem ex3_affirmation_1 : (0.52 : ℚ) * 0.32 / 0.20 = 0.832 := by norm_num

/-- Affirmation 2, **fausse** : la valeur vraie est proche de `0,96`, non de `0,4`.

L'espérance vaut `310` et l'écart type environ `17` ; le seuil `340` est donc à près de
deux écarts types au-dessus de la moyenne, ce qui laisse largement plus de `40 %` en
dessous.

Énoncé admis. Le vérifier demande d'évaluer une somme de `341` coefficients binomiaux
de rang `5 000` : c'est un calcul numérique que ni `decide` ni `norm_num` ne mènent, et
que le sujet fait faire à la calculatrice. -/
theorem ex3_affirmation_2 :
    ¬ |(∑ k ∈ Finset.range 341,
        (Nat.choose 5000 k : ℝ) * 0.062 ^ k * 0.938 ^ (5000 - k)) - 0.4| < 0.05 := by
  sorry

/-- Affirmation 3, **vraie**. Avec `E(X) = 310` et
`V(X) = 5 000 × 0,062 × 0,938 = 290,78`, l'inégalité de Bienaymé-Tchebychev majore
`P(|X − 310| ≥ 80)` par `290,78/6 400 ≈ 0,045`, donc en deçà de `5 %`. -/
theorem ex3_affirmation_3 : (5000 * 0.062 * 0.938 : ℚ) / 80 ^ 2 < 5 / 100 := by
  norm_num

/-- Affirmation 4, **vraie**. Constituer une équipe, c'est choisir `2` musiciens parmi
`4` et `3` non-musiciens parmi `6`, soit `6 × 20 = 120` équipes.

L'ordre ne compte pas : ce sont bien des combinaisons. -/
theorem ex3_affirmation_4 : Nat.choose 4 2 * Nat.choose 6 3 = 120 := by decide

/-! ## Exercice 4 — la fonction du logo -/

/-- Partie B, question 1a : `f(x) = (2x − 1)e^{−2x+3}` s'écrit aussi
`e² × (2x − 1)/e^{2x−1}`.

C'est la même chose lue autrement : `e^{−2x+3} = e² × e^{−(2x−1)}`. Cette écriture est
celle qui donne la limite, en faisant apparaître le quotient d'un polynôme par une
exponentielle. -/
theorem ex4_forme_pour_la_limite (x : ℝ) :
    (2 * x - 1) * Real.exp (-2 * x + 3)
      = Real.exp 2 * ((2 * x - 1) / Real.exp (2 * x - 1)) := by
  have h : Real.exp (-2 * x + 3) = Real.exp 2 / Real.exp (2 * x - 1) := by
    rw [← Real.exp_sub]
    congr 1
    ring
  rw [h]
  ring

/-- Partie B, question 2a : `f'(x) = (−4x + 4)e^{−2x+3}`.

C'est la dérivée d'un produit : `2 e^{−2x+3} + (2x − 1)(−2)e^{−2x+3}`, dont le facteur
commun se met en évidence. Le signe de `f'` est donc celui de `1 − x`. -/
theorem ex4_derivee (x : ℝ) :
    HasDerivAt (fun t : ℝ => (2 * t - 1) * Real.exp (-2 * t + 3))
      ((-4 * x + 4) * Real.exp (-2 * x + 3)) x := by
  have hu : HasDerivAt (fun t : ℝ => 2 * t - 1) 2 x := by
    simpa using ((hasDerivAt_id x).const_mul (2 : ℝ)).sub_const (1 : ℝ)
  have hv : HasDerivAt (fun t : ℝ => -2 * t + 3) (-2) x := by
    simpa using ((hasDerivAt_id x).const_mul (-2 : ℝ)).add_const (3 : ℝ)
  have h2 : HasDerivAt (fun t : ℝ => (2 * t - 1) * Real.exp (-2 * t + 3))
      (2 * Real.exp (-2 * x + 3) + (2 * x - 1) * (Real.exp (-2 * x + 3) * (-2))) x :=
    hu.mul hv.exp
  convert h2 using 1
  ring

/-- Partie C, question 1 : l'intégrale de `f` entre `0,5` et `3,3` vaut
`0,5 e² − 3,3 e^{−3,6}`, soit `3,6` au dixième.

L'intégration par parties que demande le sujet revient à reconnaître la primitive
`F(x) = −x e^{−2x+3}` : en dérivant, `−e^{−2x+3} + 2x e^{−2x+3} = (2x − 1)e^{−2x+3}`. -/
theorem ex4_integrale :
    ∫ x in (0.5 : ℝ)..3.3, (2 * x - 1) * Real.exp (-2 * x + 3)
      = 0.5 * Real.exp 2 - 3.3 * Real.exp (-3.6) := by
  have deriv : ∀ x ∈ Set.uIcc (0.5 : ℝ) 3.3,
      HasDerivAt (fun t : ℝ => -(t * Real.exp (-2 * t + 3)))
        ((2 * x - 1) * Real.exp (-2 * x + 3)) x := by
    intro x _
    have hv : HasDerivAt (fun t : ℝ => -2 * t + 3) (-2) x := by
      simpa using ((hasDerivAt_id x).const_mul (-2 : ℝ)).add_const (3 : ℝ)
    have h2 : HasDerivAt (fun t : ℝ => -(t * Real.exp (-2 * t + 3)))
        (-(1 * Real.exp (-2 * x + 3) + x * (Real.exp (-2 * x + 3) * (-2)))) x :=
      ((hasDerivAt_id x).mul hv.exp).neg
    convert h2 using 1
    ring
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt deriv]
  · norm_num; ring
  · exact Continuous.intervalIntegrable (by fun_prop) _ _

end Bac.Metropole2026.Jour2
