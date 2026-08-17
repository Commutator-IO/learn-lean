/-
Baccalauréat, épreuve de spécialité — voie générale, Métropole, 18 juin 2025 (jour 2).

Chaque question du sujet qui porte une proposition mathématique devient ici un
théorème. Celles qui n'en portent pas — représenter un arbre pondéré, lire une durée
ou une asymptote sur un graphique, justifier une modélisation — n'ont pas d'énoncé, et
l'index du dossier dit lesquelles et pourquoi.

Les probabilités sont traitées comme le sujet les traite : sur les nombres. La
géométrie de l'espace, elle, est traitée sur les coordonnées : c'est ce que le repère
orthonormé permet, et le produit scalaire y est la somme des produits des coordonnées.
-/
import Mathlib

namespace Bac.Metropole2025.Jour2

/-! ## Exercice 1 — chutes au roller, temps d'attente -/

/-- Partie A, question 2 : `P(Ā ∩ B̄) = 0,4 × 0,6 = 0,24`.

C'est la lecture d'un chemin de l'arbre : `24 %` des personnes ne chutent à aucune des
deux séances. -/
theorem ex1_aucune_chute : (0.4 : ℚ) * 0.6 = 0.24 := by norm_num

/-- Partie A, question 3 : `P(B) = 0,34`.

La formule des probabilités totales décompose `B` selon qu'il y a eu chute ou non à la
première séance : `0,6 × 0,3 + 0,4 × 0,4`. Les deux chemins ne s'excluent pas par
hasard : `A` et `Ā` forment une partition. -/
theorem ex1_chute_deuxieme : (0.6 : ℚ) * 0.3 + 0.4 * 0.4 = 0.34 := by norm_num

/-- Partie A, question 4 : `P_B̄(Ā) = 0,24/0,66 = 4/11`, soit `0,364` au millième près.

La probabilité conditionnelle renverse le conditionnement : on connaît la probabilité
de chuter sachant qu'on a chuté avant, on cherche celle de n'avoir pas chuté avant
sachant qu'on ne chute pas maintenant. -/
theorem ex1_conditionnelle :
    (0.24 : ℚ) / (1 - 0.34) = 4 / 11 ∧ |(4 : ℚ) / 11 - 0.364| < 0.0005 := by
  refine ⟨by norm_num, ?_⟩
  rw [abs_lt]
  norm_num

/-- Partie A, question 5c : `E(X) = 100 × 0,24 = 24`.

Sur un échantillon de `100` personnes, on en attend `24` qui ne chutent à aucune des
deux séances : l'espérance d'une loi binomiale est `np`, et c'est la proportion
retrouvée à l'échelle de l'échantillon. -/
theorem ex1_esperance : (100 : ℚ) * 0.24 = 24 := by norm_num

/-- Partie B, question 1 : `E(T) = E(T₁) + E(T₂) = 100` minutes.

L'espérance est additive sans autre hypothèse : l'indépendance ne sert pas ici. -/
theorem ex1_esperance_totale : (40 : ℚ) + 60 = 100 := by norm_num

/-- Partie B, question 2 : `V(T) = 10² + 16² = 356`.

Les variances s'ajoutent parce que les deux variables sont indépendantes, et ce sont
les variances qui s'ajoutent, non les écarts-types : `10 + 16 = 26` n'a pas de sens
ici, et `√356 ≈ 18,9` est l'écart-type de la somme. -/
theorem ex1_variance_totale : (10 : ℚ) ^ 2 + 16 ^ 2 = 356 := by norm_num

/-- Partie B, question 3 : `P(60 < T < 140) > 0,77`.

L'évènement `60 < T < 140` est exactement `|T − 100| < 40`. Bienaymé-Tchebychev majore
la probabilité contraire par `V(T)/40² = 356/1 600 = 0,222 5`, donc minore celle
cherchée par `0,777 5`, qui dépasse `0,77`.

L'inégalité est très large — la vraie probabilité est sans doute bien plus grande —
mais elle ne demande aucune hypothèse sur la loi, et c'est là son intérêt. -/
theorem ex1_bienayme_tchebychev :
    (356 : ℚ) / 40 ^ 2 = 0.2225 ∧ (0.77 : ℚ) < 1 - 356 / 40 ^ 2 := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## Exercice 2 — droites, plan et projeté orthogonal -/

/-- Partie A, question 1 : les droites `d` et `d′` sont sécantes au point
`S(−1/2 ; 1 ; 4)`.

Le paramètre `t = −1` place le point de `d` en `S`, le paramètre `s = −1/2` place celui
de `d′` au même endroit : le point est commun. Les vecteurs directeurs `(2 ; 1 ; −1)` et
`(1 ; 1 ; −2)` n'étant pas colinéaires, les droites sont bien sécantes et non
confondues. -/
theorem ex2_secantes :
    ∃ t s : ℚ, (3 / 2 + 2 * t, 2 + t, 3 - t) = ((-1 / 2 : ℚ), (1 : ℚ), (4 : ℚ)) ∧
      (s, 3 / 2 + s, 3 - 2 * s) = ((-1 / 2 : ℚ), (1 : ℚ), (4 : ℚ)) :=
  ⟨-1, -1 / 2, by norm_num, by norm_num⟩

/-- Partie A, question 2a : le vecteur `n(1 ; 2 ; 4)` est normal au plan `(ABC)`.

Il est orthogonal à `AB(2 ; −3 ; 1)` et à `AC(2 ; −1 ; 0)`, qui ne sont pas colinéaires :
deux orthogonalités à deux vecteurs non colinéaires du plan, c'est la définition d'un
vecteur normal. -/
theorem ex2_vecteur_normal :
    (1 * 2 + 2 * (-3) + 4 * 1 : ℚ) = 0 ∧ (1 * 2 + 2 * (-1) + 4 * 0 : ℚ) = 0 := by
  norm_num

/-- Partie A, question 2b : une équation cartésienne du plan `(ABC)` est
`x + 2y + 4z − 7 = 0`.

Les coefficients sont les coordonnées du vecteur normal ; le terme constant se
détermine en écrivant qu'un point du plan vérifie l'équation. Les trois points la
vérifient, ce qui la confirme. -/
theorem ex2_equation_du_plan :
    ((-1 : ℚ) + 2 * 2 + 4 * 1 - 7 = 0) ∧ ((1 : ℚ) + 2 * (-1) + 4 * 2 - 7 = 0) ∧
      ((1 : ℚ) + 2 * 1 + 4 * 1 - 7 = 0) := by
  norm_num

/-- Partie A, question 3 : les points `A`, `B`, `C` et `S` ne sont pas coplanaires.

Il suffit que `S` ne vérifie pas l'équation du plan `(ABC)` : la valeur `21/2` obtenue
est l'écart, non nul. Les quatre points forment donc un tétraèdre. -/
theorem ex2_non_coplanaires : (-1 / 2 : ℚ) + 2 * 1 + 4 * 4 - 7 ≠ 0 := by norm_num

/-- Partie A, question 4a : `H(−1 ; 0 ; 2)` est le projeté orthogonal de `S` sur le
plan `(ABC)`.

Deux vérifications : `H` appartient au plan, et `SH(−1/2 ; −1 ; −2)` est colinéaire au
vecteur normal — c'est `−1/2 × n`. Le projeté orthogonal est le seul point du plan tel
que la droite `(SH)` soit orthogonale au plan. -/
theorem ex2_projete_orthogonal :
    ((-1 : ℚ) + 2 * 0 + 4 * 2 - 7 = 0) ∧
      (((-1 : ℚ) - -1 / 2, (0 : ℚ) - 1, (2 : ℚ) - 4) = (-1 / 2 * 1, -1 / 2 * 2, -1 / 2 * 4)) := by
  norm_num

/-- Partie A, question 4b : aucun point `M` du plan `(ABC)` ne vérifie `SM < √21/2`.

La distance de `S` au plan est `SH = √(1/4 + 1 + 4) = √21/2`, et le projeté orthogonal
réalise le minimum. Plutôt que d'invoquer ce minimum, on le démontre : pour tout point
`M(x ; y ; z)` du plan, l'inégalité de Cauchy-Schwarz appliquée à
`(x + 1/2) + 2(y − 1) + 4(z − 4) = −21/2` donne `(21/2)² ≤ 21 × SM²`, soit
`SM² ≥ 21/4`.

C'est le carré de la distance qui est comparé, jamais la distance elle-même : la
racine carrée n'apparaît pas dans la démonstration. -/
theorem ex2_distance_minimale {x y z : ℝ} (h : x + 2 * y + 4 * z = 7) :
    21 / 4 ≤ (x - -1 / 2) ^ 2 + (y - 1) ^ 2 + (z - 4) ^ 2 := by
  nlinarith [sq_nonneg (2 * (x + 1 / 2) - (y - 1)), sq_nonneg (4 * (x + 1 / 2) - (z - 4)),
    sq_nonneg (4 * (y - 1) - 2 * (z - 4))]

/-- Partie B, question 1 : le point `M` de `[CS]` tel que `CM = k CS` a pour
coordonnées `(1 − 3k/2 ; 1 ; 1 + 3k)`.

L'ordonnée ne dépend pas de `k` : `C` et `S` ont la même, et le segment est donc
contenu dans le plan `y = 1`. -/
theorem ex2_coordonnees_de_M (k : ℚ) :
    1 + k * (-1 / 2 - 1) = 1 - 3 / 2 * k ∧ 1 + k * (1 - 1) = 1 ∧ 1 + k * (4 - 1) = 1 + 3 * k := by
  refine ⟨by ring, by ring, by ring⟩

/-- Partie B, question 2 : oui, il existe un point `M` de `[CS]` tel que le triangle
`MAB` soit rectangle en `M`.

Le produit scalaire `MA · MB` vaut `11,25k² − 6k − 2`. Il s'annule pour
`k = (12 + 2√126)/45 ≈ 0,766`, qui appartient bien à `[0 ; 1]` — l'autre racine est
négative, donc hors du segment. Le point cherché existe et il est unique.

La racine est irrationnelle : le sujet demande une existence, non une valeur, et c'est
tout l'intérêt de la question. -/
theorem ex2_triangle_rectangle :
    ∃ k : ℝ, 0 ≤ k ∧ k ≤ 1 ∧
      (-2 + 1.5 * k) * (1.5 * k) + 1 * (-2) + (-3 * k) * (1 - 3 * k) = 0 := by
  have hcarre : Real.sqrt 126 ^ 2 = 126 := Real.sq_sqrt (by norm_num)
  have hnn : 0 ≤ Real.sqrt 126 := Real.sqrt_nonneg 126
  have hub : Real.sqrt 126 ≤ 12 := by nlinarith
  refine ⟨(12 + 2 * Real.sqrt 126) / 45, by positivity, by linarith, ?_⟩
  field_simp
  nlinarith

/-! ## Exercice 3 — vrai ou faux : suites, convexité, logarithme -/

/-- Affirmation 1, **vraie** : la suite `u_n = (1 + 5n)/(2 + 3n)` converge vers `5/3`.

La forme `5/3 − 7/(9n + 6)` rend la limite immédiate : l'écart à `5/3` est un quotient
de constante par une quantité qui tend vers `+∞`. C'est le rapport des coefficients
dominants, et l'écriture le démontre au lieu de l'invoquer. -/
theorem ex3_affirmation_1 :
    Filter.Tendsto (fun n : ℕ => (1 + 5 * (n : ℝ)) / (2 + 3 * (n : ℝ))) Filter.atTop
      (nhds (5 / 3)) := by
  have hn : Filter.Tendsto (fun n : ℕ => (n : ℝ)) Filter.atTop Filter.atTop :=
    tendsto_natCast_atTop_atTop
  have hden : Filter.Tendsto (fun n : ℕ => 9 * (n : ℝ) + 6) Filter.atTop Filter.atTop :=
    Filter.tendsto_atTop_add_const_right _ 6 (Filter.Tendsto.const_mul_atTop (by norm_num) hn)
  have hecart : Filter.Tendsto (fun n : ℕ => (7 : ℝ) / (9 * (n : ℝ) + 6)) Filter.atTop
      (nhds 0) := Filter.Tendsto.div_atTop tendsto_const_nhds hden
  have hforme : ∀ n : ℕ, (1 + 5 * (n : ℝ)) / (2 + 3 * (n : ℝ)) = 5 / 3 - 7 / (9 * (n : ℝ) + 6) := by
    intro n
    have hpos : (0 : ℝ) < 2 + 3 * (n : ℝ) := by positivity
    field_simp
    ring
  have hconst : Filter.Tendsto (fun _ : ℕ => (5 : ℝ) / 3) Filter.atTop (nhds (5 / 3)) :=
    tendsto_const_nhds
  have hlim := hconst.sub hecart
  rw [sub_zero] at hlim
  exact Filter.Tendsto.congr (fun n => (hforme n).symm) hlim

/-- La suite de l'affirmation 2 : `w₀ = 0` et `w_{n+1} = 3w_n − 2n + 3`. -/
noncomputable def w : ℕ → ℝ
  | 0 => 0
  | n + 1 => 3 * w n - 2 * n + 3

/-- La relation de récurrence, sous la forme où la preuve l'utilise. -/
theorem w_succ (n : ℕ) : w (n + 1) = 3 * w n - 2 * n + 3 := rfl

/-- Affirmation 2, **vraie** : pour tout entier naturel `n`, `w_n ≥ n`.

La récurrence est immédiate et instructive : de `w_n ≥ n` on tire
`w_{n+1} ≥ 3n − 2n + 3 = n + 3`, qui dépasse `n + 1` de deux unités. La marge grandit,
ce qui est le signe qu'une minoration bien plus forte serait vraie — mais celle-ci
suffit à répondre. -/
theorem ex3_affirmation_2 (n : ℕ) : (n : ℝ) ≤ w n := by
  induction n with
  | zero => simp [w]
  | succ n ih =>
    rw [w_succ]
    push_cast
    linarith

/-- Affirmation 4, **vraie** : pour tout réel `x > 0`, `ln x − x + 1 ≤ 0`.

C'est l'inégalité de concavité du logarithme, `ln x ≤ x − 1`, avec égalité en `1`
seulement : la courbe du logarithme est sous sa tangente en `1`. -/
theorem ex3_affirmation_4 {x : ℝ} (hx : 0 < x) : Real.log x - x + 1 ≤ 0 := by
  have h := Real.log_le_sub_one_of_pos hx
  linarith

/-! ## Exercice 4 — le freinage du chariot -/

/-- Partie B, question 1b : `g(t) = te^(−0,6t)` est solution de
`(E) : y′ + 0,6y = e^(−0,6t)`.

La dérivée d'un produit donne `g′(t) = e^(−0,6t) − 0,6te^(−0,6t)`, c'est-à-dire
`e^(−0,6t) − 0,6g(t)` : l'équation est vérifiée telle quelle. -/
theorem ex4_g_solution (t : ℝ) :
    HasDerivAt (fun s => s * Real.exp (-0.6 * s))
      (Real.exp (-0.6 * t) - 0.6 * (t * Real.exp (-0.6 * t))) t := by
  have hlin : HasDerivAt (fun s : ℝ => -0.6 * s) (-0.6) t := by
    simpa using (hasDerivAt_id' (x := t)).const_mul (-0.6 : ℝ)
  have hexp := hlin.exp
  refine (hasDerivAt_id' (x := t)).fun_mul hexp |>.congr_deriv ?_
  ring

/-- Partie B, question 2a : `v′(t) = (−6,2 − 0,6t)e^(−0,6t)`, où
`v(t) = (12 + t)e^(−0,6t)`.

C'est encore la dérivée d'un produit : `e^(−0,6t) − 0,6(12 + t)e^(−0,6t)`, et
`1 − 7,2 = −6,2`. -/
theorem ex4_derivee (t : ℝ) :
    HasDerivAt (fun s => (12 + s) * Real.exp (-0.6 * s))
      ((-6.2 - 0.6 * t) * Real.exp (-0.6 * t)) t := by
  have hlin : HasDerivAt (fun s : ℝ => -0.6 * s) (-0.6) t := by
    simpa using (hasDerivAt_id' (x := t)).const_mul (-0.6 : ℝ)
  have hexp := hlin.exp
  have hpoly : HasDerivAt (fun s : ℝ => 12 + s) 1 t := by
    simpa using (hasDerivAt_id' (x := t)).const_add (12 : ℝ)
  refine (hpoly.fun_mul hexp).congr_deriv ?_
  ring

/-- Partie B, question 1d : `v(t) = (12 + t)e^(−0,6t)` est bien la solution cherchée —
elle vérifie l'équation et la condition initiale `v(0) = 12`.

La vérification de l'équation est algébrique : `−6,2 − 0,6t + 0,6(12 + t) = 1`. La
condition initiale est ce qui détermine la constante, et donc ce qui rend la solution
unique. -/
theorem ex4_v_solution (t : ℝ) :
    (-6.2 - 0.6 * t) * Real.exp (-0.6 * t) + 0.6 * ((12 + t) * Real.exp (-0.6 * t)) =
        Real.exp (-0.6 * t) ∧
      (12 + (0 : ℝ)) * Real.exp (-0.6 * 0) = 12 := by
  refine ⟨by ring, by norm_num⟩

/-- Partie B, question 2c : la vitesse est strictement décroissante sur `[0 ; +∞[`.

La dérivée est le produit de `−6,2 − 0,6t`, négatif dès que `t ≥ 0`, par une
exponentielle, toujours positive. Le chariot ralentit sans jamais s'arrêter : c'est
pourquoi un dispositif mécanique est nécessaire. -/
theorem ex4_decroissance {t : ℝ} (ht : 0 ≤ t) : (-6.2 - 0.6 * t) * Real.exp (-0.6 * t) < 0 := by
  have hexp : 0 < Real.exp (-0.6 * t) := Real.exp_pos _
  nlinarith

/-- Partie B, question 2b : la vitesse tend vers `0` en `+∞`.

L'exponentielle l'emporte sur le terme linéaire, ce que le sujet fait admettre en
récrivant `te^(−0,6t)` sous la forme `(1/0,6)(0,6t)/e^(0,6t)`. La croissance comparée
est ici invoquée sous sa forme mathlib : `x e^(−x)` tend vers `0`. -/
theorem ex4_limite_de_v :
    Filter.Tendsto (fun t : ℝ => (12 + t) * Real.exp (-0.6 * t)) Filter.atTop (nhds 0) := by
  simp only [neg_mul]
  have hlin : Filter.Tendsto (fun t : ℝ => 0.6 * t) Filter.atTop Filter.atTop :=
    Filter.Tendsto.const_mul_atTop (by norm_num) Filter.tendsto_id
  have hexp : Filter.Tendsto (fun t : ℝ => Real.exp (-(0.6 * t))) Filter.atTop (nhds 0) := by
    simpa only [Function.comp_def] using Real.tendsto_exp_neg_atTop_nhds_zero.comp hlin
  have hprod : Filter.Tendsto (fun t : ℝ => (0.6 * t) ^ 1 * Real.exp (-(0.6 * t)))
      Filter.atTop (nhds 0) := by
    simpa only [Function.comp_def] using
      (Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero 1).comp hlin
  have hcombine := (hexp.const_mul (12 : ℝ)).add (hprod.const_mul ((1 : ℝ) / 0.6))
  rw [show (12 : ℝ) * 0 + 1 / 0.6 * 0 = 0 by norm_num] at hcombine
  refine Filter.Tendsto.congr (fun t => ?_) hcombine
  have h : (0.6 : ℝ) ≠ 0 := by norm_num
  field_simp

/-- Partie C, question 1 : la distance parcourue entre les instants `0` et `t` vaut
`e^(−0,6t)(−5t/3 − 205/9) + 205/9`.

Le sujet demande une intégration par parties ; ce qui se vérifie ici est le résultat,
en dérivant la primitive proposée : sa dérivée est bien `(12 + t)e^(−0,6t)`, et elle
s'annule en `0`. Le théorème fondamental de l'analyse fait le reste.

La limite de cette expression en `+∞` est `205/9 ≈ 22,8` : c'est la longueur minimale
de la zone de freinage, celle que la partie A faisait lire sur l'asymptote. -/
theorem ex4_distance (t : ℝ) :
    (∫ x in (0 : ℝ)..t, (12 + x) * Real.exp (-0.6 * x)) =
      Real.exp (-0.6 * t) * (-5 / 3 * t - 205 / 9) + 205 / 9 := by
  have hderiv : ∀ x ∈ Set.uIcc (0 : ℝ) t,
      HasDerivAt (fun s => Real.exp (-0.6 * s) * (-5 / 3 * s - 205 / 9) + 205 / 9)
        ((12 + x) * Real.exp (-0.6 * x)) x := by
    intro x _
    have hlin : HasDerivAt (fun s : ℝ => -0.6 * s) (-0.6) x := by
      simpa using (hasDerivAt_id' (x := x)).const_mul (-0.6 : ℝ)
    have hexp := hlin.exp
    have hpoly : HasDerivAt (fun s : ℝ => -5 / 3 * s - 205 / 9) (-5 / 3) x := by
      simpa using ((hasDerivAt_id' (x := x)).const_mul (-5 / 3 : ℝ)).sub_const (205 / 9 : ℝ)
    refine ((hexp.fun_mul hpoly).add_const (205 / 9 : ℝ)).congr_deriv ?_
    ring
  have hint : IntervalIntegrable (fun x : ℝ => (12 + x) * Real.exp (-0.6 * x))
      MeasureTheory.volume 0 t := by
    apply Continuous.intervalIntegrable
    fun_prop
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt hderiv hint]
  norm_num

end Bac.Metropole2025.Jour2
