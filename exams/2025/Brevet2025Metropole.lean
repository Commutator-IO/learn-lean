/-
Brevet des collèges — série générale, Métropole–Antilles–Guyane, 26 juin 2025.

Chaque question du sujet qui porte une proposition mathématique devient ici un
théorème. Celles qui n'en portent pas — reconnaître une transformation sur une
figure, compléter un programme Scratch, écrire une formule de tableur — n'ont pas
d'énoncé, et l'index du dossier dit lesquelles et pourquoi.

Les énoncés sont ceux du sujet, pas leur généralisation. Quand la configuration
géométrique est donnée par une figure, ce qu'elle établit — l'angle droit, les
alignements — devient une hypothèse : la figure n'est pas formalisée, l'arithmétique
qui en découle l'est.
-/
import Mathlib

namespace Brevet.Metropole2025

/-! ## Exercice 1 — deux urnes -/

/-- L'urne `A` contient les boules `7, 10, 12, 15, 24, 30`. -/
def urneA : List ℕ := [7, 10, 12, 15, 24, 30]

/-- L'urne `B` contient les boules `2, 5, 6, 8, 17, 18, 21, 22, 25`. -/
def urneB : List ℕ := [2, 5, 6, 8, 17, 18, 21, 22, 25]

/-- Question 1 : quatre des six boules de l'urne `A` portent un nombre pair, donc
la probabilité d'en tirer une vaut `2/3`.

Les boules étant indiscernables au toucher, la probabilité est le quotient du
nombre de cas favorables par le nombre de cas possibles : c'est l'équiprobabilité,
et c'est la seule hypothèse de tout l'exercice. -/
theorem ex1_nombre_pair :
    (urneA.filter (fun n => n % 2 = 0)).length = 4 ∧ (4 : ℚ) / 6 = 2 / 3 :=
  ⟨by decide, by norm_num⟩

/-- Question 2 : trois des neuf boules de l'urne `B` portent un nombre premier —
`2`, `5` et `17` —, donc la probabilité vaut `1/3`.

Les six autres sont composées : `6`, `8`, `18` et `22` sont pairs et plus grands que
`2`, `21 = 3 × 7`, et `25 = 5²`. -/
theorem ex1_nombre_premier :
    (Nat.Prime 2 ∧ Nat.Prime 5 ∧ Nat.Prime 17) ∧
      (¬Nat.Prime 6 ∧ ¬Nat.Prime 8 ∧ ¬Nat.Prime 18 ∧ ¬Nat.Prime 21 ∧ ¬Nat.Prime 22 ∧
        ¬Nat.Prime 25) ∧
      (3 : ℚ) / 9 = 1 / 3 := by
  refine ⟨⟨by norm_num, by norm_num, by norm_num⟩, ⟨?_, ?_, ?_, ?_, ?_, ?_⟩, by norm_num⟩ <;>
    norm_num

/-- Question 3 : l'urne `A` contient trois multiples de `6` — `12`, `24`, `30` — et
l'urne `B` deux seulement — `6` et `18`. C'est donc `A`.

La question porte sur un effectif, non sur une probabilité : c'est `A` qui en contient
le plus, alors que la proportion y est aussi la plus grande, `1/2` contre `2/9`. -/
theorem ex1_multiples_de_six :
    (urneA.filter (fun n => n % 6 = 0)).length = 3 ∧
      (urneB.filter (fun n => n % 6 = 0)).length = 2 :=
  ⟨by decide, by decide⟩

/-- Question 4 : la probabilité d'obtenir un nombre supérieur ou égal à `20` est
`1/3` dans les deux urnes — `2` boules sur `6` d'un côté, `3` sur `9` de l'autre.

Les deux fractions ne sont pas les mêmes, mais elles ont la même valeur : c'est ce
que la question demande de démontrer, et rien n'oblige les urnes à avoir le même
nombre de boules pour cela. -/
theorem ex1_au_moins_vingt :
    (urneA.filter (fun n => 20 ≤ n)).length = 2 ∧
      (urneB.filter (fun n => 20 ≤ n)).length = 3 ∧ (2 : ℚ) / 6 = 3 / 9 :=
  ⟨by decide, by decide, by norm_num⟩

/-- Question 5 : en ajoutant une boule `50` dans chaque urne, l'égalité est rompue —
`3/7` d'un côté, `4/10` de l'autre, et `3/7 > 2/5`.

Ajouter un même cas favorable à deux urnes de tailles différentes ne conserve pas
l'égalité des proportions : c'est l'urne la plus petite qui en profite le plus. -/
theorem ex1_avec_cinquante :
    ((50 :: urneA).filter (fun n => 20 ≤ n)).length = 3 ∧
      ((50 :: urneB).filter (fun n => 20 ≤ n)).length = 4 ∧ (3 : ℚ) / 7 ≠ 4 / 10 :=
  ⟨by decide, by decide, by norm_num⟩

/-! ## Exercice 2 — l'aquathlon -/

/-- Partie A, question 1 : `AD = AE − DE = 250 − 50 = 200 m`.

Les points `A`, `D`, `E` sont alignés dans cet ordre : la longueur cherchée est une
différence, ce que la figure donne et que l'énoncé écrit ne dit pas autrement. -/
theorem ex2_ad {AE DE : ℚ} (hAE : AE = 250) (hDE : DE = 50) : AE - DE = 200 := by
  rw [hAE, hDE]; norm_num

/-- Partie A, question 2 : `CD = 520 m`.

Le triangle `ADC` est rectangle en `A`, donc `CD² = AC² + AD² = 480² + 200²`, soit
`270 400`, dont la racine est `520`. Une longueur est positive : c'est ce qui rend la
solution unique. -/
theorem ex2_cd {AC AD CD : ℝ} (hAC : AC = 480) (hAD : AD = 200) (hpos : 0 ≤ CD)
    (h : CD ^ 2 = AC ^ 2 + AD ^ 2) : CD = 520 := by
  subst hAC hAD
  nlinarith [sq_nonneg (CD - 520), sq_nonneg (CD + 520)]

/-- Partie A, question 3a : les droites `(CD)` et `(BE)` sont parallèles.

Les rapports `AD/AE` et `AC/AB` valent tous deux `0,8` — avec `AB = AC + CB = 600` —
et les points sont alignés dans le même ordre : la réciproque du théorème de Thalès
conclut. Ce qui se vérifie ici est l'égalité des rapports ; la réciproque elle-même
est un énoncé du chapitre « Géométrie plane », et la configuration reste dans la
figure. -/
theorem ex2_paralleles : (200 : ℚ) / 250 = 480 / (480 + 120) := by norm_num

/-- Partie B, question 4 : le temps médian des neuf nageurs est `6 min`, soit
`360 s` — quatre élèves font mieux, quatre font moins bien.

Les temps sont convertis en secondes, seule façon de les comparer sans ambiguïté :
`5 min 49 s` et `5 min 50 s` ne se distinguent pas sur les minutes. -/
theorem ex2_mediane :
    (([330, 345, 349, 350, 360, 371, 372, 380, 400] : List ℕ).filter (fun t => t < 360)).length
        = 4 ∧
      (([330, 345, 349, 350, 360, 371, 372, 380, 400] : List ℕ).filter
        (fun t => 360 < t)).length = 4 :=
  ⟨by decide, by decide⟩

/-- Partie B, question 5 : le poisson rouge nage plus vite que le meilleur élève.

Le plus rapide couvre `200 m` en `5 min 30 s`, soit `330 s` : sa vitesse vaut
`200/330 ≈ 0,61 m/s`, quand `5 km/h` font `5 000/3 600 ≈ 1,39 m/s`. Comparer deux
vitesses demande d'abord de les exprimer dans la même unité, et c'est là toute la
question. -/
theorem ex2_poisson : (200 : ℚ) / 330 < 5000 / 3600 := by norm_num

/-! ## Exercice 3 — questionnaire à choix multiples -/

/-- Question 1 : si `3` melons coûtent `8,40 €`, `5` melons coûtent `14 €`.

Le prix est proportionnel à la quantité : le prix unitaire est `2,80 €`. -/
theorem qcm_melons : (8.40 : ℚ) / 3 * 5 = 14 := by norm_num

/-- Question 3 : un article à `350 €` augmenté de `20 %` coûte `420 €`.

Augmenter de `20 %` est multiplier par `1,2`, non ajouter `20`. -/
theorem qcm_augmentation : (350 : ℚ) * 1.2 = 420 := by norm_num

/-- Question 4 : l'aire du triangle `ABC` de côtés `6`, `4,5` et `7,5` vaut
`13,5 cm²`.

Le triangle est rectangle en `B` par la réciproque de Pythagore —
`6² + 4,5² = 56,25 = 7,5²` —, et son aire est le demi-produit des côtés de l'angle
droit. La réponse `27` est celle qu'on obtient en oubliant le demi ; la réponse
`18` celle qu'on obtient en prenant l'hypoténuse pour un côté de l'angle droit. -/
theorem qcm_aire :
    (6 : ℚ) ^ 2 + 4.5 ^ 2 = 7.5 ^ 2 ∧ (6 : ℚ) * 4.5 / 2 = 13.5 := by norm_num

/-- Question 5 : la forme développée et réduite de `(2x + 3)(x − 4)` est
`2x² − 5x − 12`, pour toute valeur de `x`.

C'est une identité, non une équation : elle vaut pour tout `x`, et c'est ce que
« développer » signifie. -/
theorem qcm_developpement (x : ℚ) : (2 * x + 3) * (x - 4) = 2 * x ^ 2 - 5 * x - 12 := by
  ring

/-- Question 6 : le volume d'une pyramide à base rectangulaire `7 cm × 4 cm` et de
hauteur `12 cm` vaut `112 cm³`.

Le tiers est ce qui distingue la pyramide du prisme de même base et même hauteur :
la réponse `336` est ce prisme. -/
theorem qcm_volume : (7 : ℚ) * 4 * 12 / 3 = 112 := by norm_num

/-! ## Exercice 4 — programmes de calcul -/

/-- Partie A, question 1 : le programme de Zoé renvoie `20` quand on part de `10`. -/
theorem ex4_zoe_dix : 2 * ((10 : ℚ) - 4) + 8 = 20 := by norm_num

/-- Partie A, question 2 : il renvoie `−14` quand on part de `−7`.

Le signe du produit est celui qu'il faut surveiller : `−7 − 4 = −11`, et non `−3`. -/
theorem ex4_zoe_moins_sept : 2 * ((-7 : ℚ) - 4) + 8 = -14 := by norm_num

/-- Partie A, question 3 : Zoé a raison — son programme renvoie toujours le double
du nombre choisi.

Deux exemples ne prouvent rien ; le calcul littéral, lui, conclut pour tous les
nombres à la fois. C'est le passage du numérique au littéral que la question évalue,
et il est ici l'argument entier. -/
theorem ex4_zoe_magique (x : ℚ) : 2 * (x - 4) + 8 = 2 * x := by ring

/-- Partie B, question 4 : le programme de Fred renvoie `20x + 50`.

Les trois instructions se composent : `x ↦ 4x ↦ 4x + 10 ↦ 5(4x + 10)`. L'ordre
compte, et c'est le `+ 10` avant le `× 5` qui donne le `+ 50`. -/
theorem ex4_fred (x : ℚ) : (4 * x + 10) * 5 = 20 * x + 50 := by ring

/-- Partie B, question 5 : pour obtenir `75`, il faut choisir `1,25`.

L'équation `20x + 50 = 75` a une solution unique, et elle n'est pas entière : le
programme n'est pas magique, mais il est inversible. -/
theorem ex4_fred_soixante_quinze {x : ℚ} (h : 20 * x + 50 = 75) : x = 1.25 := by
  linarith

/-! ## Exercice 5 — acheter ou louer -/

/-- Partie A, question 1 : avec l'option Achat, la dépense au bout d'un an vaut
`23 300 €` — le prix de la voiture, plus douze mois d'assurance. -/
theorem ex5_premiere_annee : (22400 : ℚ) + 75 * 12 = 23300 := by norm_num

/-- Partie A, question 2 : au bout de `36` mois, l'option Location fait économiser
`9 800 €`.

L'écart se creuse d'abord vite — le prix d'achat est payé tout de suite — puis se
resserre, l'assurance étant six fois moins chère que la location. -/
theorem ex5_trente_six_mois : ((22400 : ℚ) + 75 * 36) - 425 * 36 = 9800 := by norm_num

/-- Partie B, question 5 : l'option Achat devient la plus avantageuse à partir du
soixante-cinquième mois.

L'inéquation `22 400 + 75x < 425x` se réduit à `22 400 < 350x`, c'est-à-dire
`x > 64` : les deux dépenses sont égales au bout de `64` mois, à `27 200 €`, et
l'Achat ne devient strictement meilleur qu'ensuite.

Le sujet demande une lecture graphique, et la réponse attendue est « à partir de
`64` mois ». Ce qui est démontré ici est l'inéquation exacte, ce que le graphique ne
peut que suggérer — la donnée étant algébrique, contrairement aux lectures de courbe
d'autres sujets. -/
theorem ex5_seuil (x : ℚ) : 22400 + 75 * x < 425 * x ↔ 64 < x := by
  constructor <;> intro h <;> linarith

end Brevet.Metropole2025
