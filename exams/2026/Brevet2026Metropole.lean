/-
Brevet des collèges — série générale, Métropole, 30 juin 2026.

Chaque question du sujet qui porte une proposition mathématique devient ici un
théorème. Celles qui n'en portent pas — une lecture graphique, une interprétation
à rédiger — n'ont pas d'énoncé, et l'index du dossier dit lesquelles et pourquoi :
c'est une des choses que ce dépôt cherche à mesurer.

Les énoncés sont ceux du sujet, pas leur généralisation. Quand la configuration
géométrique est donnée par une figure, ce qu'elle établit — l'égalité des rapports
de Thalès, le parallélisme — devient une hypothèse : la figure n'est pas
formalisée, l'arithmétique qui en découle l'est.
-/
import Mathlib

namespace Brevet.Metropole2026

/-! ## Première partie — automatismes -/

/-- Question 1 : `0,75` s'écrit `3/4`. Passer d'une écriture décimale à une
fraction, c'est simplifier `75/100` par `25`. -/
theorem qcm_ecriture_fractionnaire : (0.75 : ℚ) = 3 / 4 := by norm_num

/-- Question 2 : `−4,7 + 3,5 = −1,2`. La somme de deux relatifs de signes
contraires a le signe du plus grand en valeur absolue. -/
theorem qcm_somme_de_relatifs : (-4.7 : ℚ) + 3.5 = -1.2 := by norm_num

/-- Question 3 : dans un tableau de proportionnalité où `6` a pour image `18`,
l'image de `12` est `36`. L'égalité des produits en croix suffit à la déterminer. -/
theorem qcm_proportionnalite {a : ℚ} (h : 6 * a = 18 * 12) : a = 36 := by linarith

/-- Question 4 : dans un sac de `10` boules rouges, `4` bleues et `6` vertes,
toutes équiprobables, la probabilité de tirer une bleue est `4/20`, soit `1/5`. -/
theorem qcm_probabilite : (4 : ℚ) / (10 + 4 + 6) = 1 / 5 := by norm_num

/-- Question 5 : la solution de `10x + 16 = −64` est `−8`. -/
theorem qcm_equation {x : ℚ} (h : 10 * x + 16 = -64) : x = -8 := by linarith

/-- Question 6 : la notation scientifique de `0,004 58` est `4,58 × 10⁻³`. Elle
est unique : le facteur est compris entre `1` et `10`. -/
theorem qcm_notation_scientifique : (0.00458 : ℚ) = 4.58 * (10 : ℚ) ^ (-3 : ℤ) := by
  norm_num

/-- Question 8 : le périmètre d'un rectangle de `10 mm` sur `5 mm` vaut `30 mm`.
La réponse est une longueur, non une aire : c'est ce que les deux réponses en
`mm²` proposées cherchent à faire confondre. -/
theorem qcm_perimetre {L l : ℚ} (hL : L = 10) (hl : l = 5) : 2 * (L + l) = 30 := by
  rw [hL, hl]; norm_num

/-- Question 9 : dans un triangle rectangle en `E` où l'hypoténuse `DF` mesure
`10 cm` et le côté adjacent `DE` mesure `6 cm`, le cosinus de l'angle en `D` vaut
`3/5`.

Le cosinus d'un angle aigu est le quotient du côté adjacent par l'hypoténuse : la
question est de reconnaître lequel des trois côtés est l'hypoténuse, et le triangle
`6, 8, 10` est là pour qu'on puisse se tromper. -/
theorem qcm_cosinus {DE DF : ℚ} (hDE : DE = 6) (hDF : DF = 10) : DE / DF = 3 / 5 := by
  rw [hDE, hDF]; norm_num

/-! ## Exercice 1 — statistiques -/

/-- Le nombre total de médailles étant la somme des trois colonnes, celle qui
manque s'obtient par soustraction : les Pays-Bas ont `27` médailles d'or. -/
theorem ex1_medailles_pays_bas {or : ℕ} (h : or + 17 + 12 = 56) : or = 27 := by omega

/-- De même pour l'Australie, qui en a `18`. -/
theorem ex1_medailles_australie {or : ℕ} (h : or + 17 + 28 = 63) : or = 18 := by omega

/-- Plus de `20 %` des médailles de la Grande-Bretagne sont en bronze : la
proportion vaut `31/124`, c'est-à-dire exactement un quart. -/
theorem ex1_proportion_bronze : (1 : ℚ) / 5 < 31 / 124 ∧ (31 : ℚ) / 124 = 1 / 4 := by
  norm_num

/-- La médiane des neuf totaux est `82` : quatre pays en ont moins, quatre en ont
plus. C'est la définition même de la médiane pour un effectif impair, et elle ne
demande pas de trier la série pour être vérifiée. -/
theorem ex1_mediane :
    ([220, 124, 105, 56, 89, 71, 82, 75, 63].filter (· < 82)).length = 4 ∧
      ([220, 124, 105, 56, 89, 71, 82, 75, 63].filter (82 < ·)).length = 4 := by
  decide

/-- Le Brésil passe de `20` à `26` médailles d'argent : une augmentation de
`30 %`. Le taux se lit sur l'écart rapporté à la valeur de départ, non à celle
d'arrivée. -/
theorem ex1_augmentation : ((26 : ℚ) - 20) / 20 = 30 / 100 := by norm_num

/-! ## Exercice 2 — Thalès, triangles semblables, aire -/

/-- Question 1 : le triangle `ABC` de côtés `6,4`, `4,8` et `8` est rectangle en
`A`, par la réciproque du théorème de Pythagore — `6,4² + 4,8² = 40,96 + 23,04 = 64`. -/
theorem ex2_rectangle {AB AC BC : ℚ} (hAB : AB = 6.4) (hAC : AC = 4.8) (hBC : BC = 8) :
    AB ^ 2 + AC ^ 2 = BC ^ 2 := by
  rw [hAB, hAC, hBC]; norm_num

/-- Question 2 : `DE = 6 cm` et `AE = 3,6 cm`.

Les droites `(BC)` et `(DE)` étant parallèles et les points alignés, le théorème
de Thalès donne l'égalité des trois rapports ; c'est elle qu'on prend en
hypothèse, la figure n'étant pas formalisée. Le rapport vaut `4,8/6,4 = 0,75`, et
il ne reste qu'à multiplier. -/
theorem ex2_thales {AB AC AD AE BC DE : ℚ}
    (hAB : AB = 6.4) (hAC : AC = 4.8) (hAD : AD = 4.8) (hBC : BC = 8)
    (hAE : AD / AB = AE / AC) (hDE : AD / AB = DE / BC) :
    DE = 6 ∧ AE = 3.6 := by
  subst hAB hAC hAD hBC
  norm_num at hAE hDE
  constructor <;> linarith

/-- Question 5 : l'aire du quadrilatère `BCDE` vaut `24 cm²`.

Il se découpe en deux triangles rectangles en `A` : `ABC`, de côtés de l'angle
droit `6,4` et `4,8`, et `ADE`, de côtés `4,8` et `3,6`. Leurs aires valent
`15,36` et `8,64`. -/
theorem ex2_aire {AB AC AD AE : ℚ}
    (hAB : AB = 6.4) (hAC : AC = 4.8) (hAD : AD = 4.8) (hAE : AE = 3.6) :
    AB * AC / 2 + AD * AE / 2 = 24 := by
  rw [hAB, hAC, hAD, hAE]; norm_num

/-! ## Exercice 3 — volume d'une boule -/

/-- Partie B, question 1 : le volume d'une boule de rayon `2,5 cm` vaut `65 cm³`
à l'unité près.

L'énoncé donne la formule `V = 4πR³/3` : le sujet ne demande pas de la démontrer,
et ce dépôt ne la démontre pas non plus — c'est un des énoncés admis du chapitre
« Grandeurs et mesures ». Ce qui se vérifie ici est le calcul, et l'arrondi :
`4π(2,5)³/3` vaut environ `65,45`, dont l'arrondi à l'unité est bien `65`. -/
theorem ex3_volume : |4 * Real.pi * (2.5 : ℝ) ^ 3 / 3 - 65| < 1 / 2 := by
  have h1 : (3.1415 : ℝ) < Real.pi := Real.pi_gt_d4
  have h2 : Real.pi < 3.1416 := Real.pi_lt_d4
  rw [abs_lt]
  constructor <;> nlinarith

/-- Partie B, question 2 : avec `1 000 cm³` de plastique et des boules de `65 cm³`,
on en fabrique `15` au maximum. Le nombre cherché est un quotient euclidien, non
un quotient décimal : `15,38` boules n'a pas de sens. -/
theorem ex3_nombre_de_boules : 15 * 65 ≤ 1000 ∧ 1000 < 16 * 65 := by norm_num

/-- Partie B, question 3 : à `0,9 g/cm³`, une boule de `65 cm³` pèse `58,5 g`.
La masse volumique est un coefficient de proportionnalité entre volume et masse. -/
theorem ex3_masse : (0.9 : ℚ) * 65 = 58.5 := by norm_num

/-! ## Exercice 4 — sachets de bonbons -/

/-- Question 1 : on ne peut pas constituer `16` sachets, car `16` ne divise pas
`140` — il en resterait des bonbons au caramel. -/
theorem ex4_seize_sachets : ¬ (16 ∣ 140) := by decide

/-- Question 2 : la décomposition en facteurs premiers de `140` est `2² × 5 × 7`. -/
theorem ex4_decomposition : 140 = 2 ^ 2 * 5 * 7 := by norm_num

/-- Question 3 : le nombre maximal de sachets est `28`, et chacun contient alors
`4` bonbons à la fraise et `5` au caramel.

Le nombre de sachets doit diviser `112` et `140` : c'est un diviseur commun, et le
plus grand possible est leur PGCD. Les décompositions `112 = 2⁴ × 7` et
`140 = 2² × 5 × 7` donnent `2² × 7 = 28`. -/
theorem ex4_nombre_maximal :
    Nat.gcd 112 140 = 28 ∧ 112 / 28 = 4 ∧ 140 / 28 = 5 := by decide

/-- Et `28` est bien maximal parmi les diviseurs communs : tout diviseur commun de
`112` et `140` divise `28`, donc ne le dépasse pas. -/
theorem ex4_maximalite {d : ℕ} (h1 : d ∣ 112) (h2 : d ∣ 140) : d ≤ 28 :=
  Nat.le_of_dvd (by norm_num) (Nat.dvd_gcd h1 h2)

end Brevet.Metropole2026
