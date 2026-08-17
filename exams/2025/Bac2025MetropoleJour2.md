# Baccalauréat 2025, jour 2 — décomposition en questions

*Spécialité mathématiques, voie générale, Métropole, 18 juin 2025* —
[sujet](https://www.apmep.fr/IMG/pdf/Metropole__spe_J2_18_06_2025_DV_2.pdf) ·
[corrigé](https://www.apmep.fr/IMG/pdf/Corrige_spe_Metropole_18_06_2025_DV.pdf) ·
énoncés Lean dans [`Bac2025MetropoleJour2.lean`](Bac2025MetropoleJour2.lean).

Statuts : ☑ démontré · ◐ énoncé écrit, preuve en cours · ☐ proposition pas encore écrite ·
✗ pas une proposition.

## Exercice 1 — chutes au roller, temps d'attente (5 points, page 1)

Deux séances d'initiation, puis deux temps d'attente indépendants à sommer.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1. Représenter la situation par un arbre pondéré | arbre pondéré | Probabilités et statistiques | — | ✗ |
| A.2. Calculer `P(Ā ∩ B̄)` et interpréter | probabilités composées | Probabilités et statistiques | `ex1_aucune_chute` | ☑ |
| A.3. Montrer que `P(B) = 0,34` | probabilités totales | Probabilités et statistiques | `ex1_chute_deuxieme` | ☑ |
| A.4. Probabilité de n'avoir pas chuté à la première séance | probabilité conditionnelle | Probabilités et statistiques | `ex1_conditionnelle` | ☑ |
| A.5a. Montrer que X suit une loi binomiale | modélisation, tirage avec remise | Probabilités et statistiques | — | ✗ |
| A.5b. Probabilité d'au moins `20` personnes | fonction de répartition binomiale | Probabilités et statistiques | — | ☐ |
| A.5c. Calculer `E(X)` et interpréter | espérance binomiale | Probabilités et statistiques | `ex1_esperance` | ☑ |
| B.1. Espérance de `T = T₁ + T₂` | additivité de l'espérance | Probabilités et statistiques | `ex1_esperance_totale` | ☑ |
| B.2. Montrer que `V(T) = 356` | variance d'une somme, indépendance | Probabilités et statistiques | `ex1_variance_totale` | ☑ |
| B.3. Montrer que `P(60 < T < 140) > 0,77` | inégalité de Bienaymé-Tchebychev | Probabilités et statistiques | `ex1_bienayme_tchebychev` | ☑ |

La partie B est l'occasion de voir où sert l'indépendance : dans l'espérance, nulle part —
`E(T₁ + T₂) = E(T₁) + E(T₂)` est toujours vrai ; dans la variance, partout — `356 = 10² + 16²`
n'a de sens que parce que les variables sont indépendantes. Ce sont les variances qui
s'ajoutent, non les écarts-types, et c'est la confusion que la question 2 cherche à écarter.

La question B.3 encadre à `0,7775`, quand la probabilité réelle est sans doute bien plus
grande : Bienaymé-Tchebychev est grossière et ne suppose rien de la loi, ce qui est
exactement pourquoi on l'utilise ici — aucune loi n'est donnée.

## Exercice 2 — droites, plan et projeté orthogonal (5 points, page 2)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1. Les droites `d` et `d′` sont sécantes en `S(−1/2 ; 1 ; 4)` | représentation paramétrique, système | Géométrie et mesure | `ex2_secantes` | ☑ |
| A.2a. `n(1 ; 2 ; 4)` est normal au plan `(ABC)` | produit scalaire, vecteur normal | Géométrie et mesure | `ex2_vecteur_normal` | ☑ |
| A.2b. Équation cartésienne du plan `(ABC)` | équation cartésienne d'un plan | Géométrie et mesure | `ex2_equation_du_plan` | ☑ |
| A.3. Les points `A`, `B`, `C`, `S` ne sont pas coplanaires | appartenance à un plan | Géométrie et mesure | `ex2_non_coplanaires` | ☑ |
| A.4a. `H(−1 ; 0 ; 2)` est le projeté orthogonal de `S` | projeté orthogonal, colinéarité | Géométrie et mesure | `ex2_projete_orthogonal` | ☑ |
| A.4b. Aucun point `M` du plan ne vérifie `SM < √21/2` | distance minimale, inégalité de Cauchy-Schwarz | Géométrie et mesure | `ex2_distance_minimale` | ☑ |
| B.1. Coordonnées de `M` en fonction de `k` | représentation d'un segment | Géométrie et mesure | `ex2_coordonnees_de_M` | ☑ |
| B.2. Existe-t-il `M` tel que `MAB` soit rectangle en `M` ? | produit scalaire nul, équation du second degré | Géométrie et mesure | `ex2_triangle_rectangle` | ☑ |

L'exercice se formalise entièrement, et c'est le plus intéressant du sujet à ce titre. Deux
questions méritent un mot.

La question A.4b devrait invoquer le fait que le projeté orthogonal réalise le minimum de la
distance. La formalisation fait mieux : pour tout point `M(x ; y ; z)` du plan, l'inégalité de
Cauchy-Schwarz appliquée à `(x + 1/2) + 2(y − 1) + 4(z − 4) = −21/2` donne directement
`SM² ≥ 21/4`. Le minimum n'est pas invoqué, il est démontré — et sur les carrés, la racine
n'apparaissant jamais.

La question B.2 est une question d'existence, non de valeur : le produit scalaire `MA · MB`
vaut `11,25k² − 6k − 2`, et sa racine dans `[0 ; 1]` est `(12 + 2√126)/45 ≈ 0,766`, un
irrationnel. L'énoncé Lean exhibe cette racine et vérifie qu'elle est dans le segment — c'est
la forme la plus fidèle de « existe-t-il un point ? ».

## Exercice 3 — vrai ou faux : suites, convexité, logarithme (4 points, page 3)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| 1. Affirmation 1 : `uₙ = (1 + 5n)/(2 + 3n)` converge vers `5/3` | limite d'un quotient, coefficients dominants | Fonctions, suites et analyse | `ex3_affirmation_1` | ☑ |
| 2. Affirmation 2 : `wₙ ≥ n` pour tout `n` | récurrence | Fonctions, suites et analyse | `ex3_affirmation_2` | ☑ |
| 3. Affirmation 3 : `f` est convexe d'après le graphique | lecture graphique, convexité | Fonctions, suites et analyse | — | ✗ |
| 4. Affirmation 4 : `ln x − x + 1 ≤ 0` pour tout `x > 0` | inégalité de convexité du logarithme | Fonctions, suites et analyse | `ex3_affirmation_4` | ☑ |

L'affirmation 1 est vraie et se démontre sans invoquer la règle des coefficients dominants :
l'écriture `uₙ = 5/3 − 7/(9n + 6)` exhibe l'écart à la limite, et il ne reste qu'à voir qu'un
quotient de constante par une quantité qui tend vers `+∞` tend vers `0`.

L'affirmation 3 est la seule sans énoncé, et elle est fausse : la courbe change de courbure,
ce qui se voit et ne se calcule pas — la fonction n'est donnée que par son graphique.

L'affirmation 4 est vraie et tient en une ligne, parce que mathlib porte l'inégalité
`ln x ≤ x − 1` : la courbe du logarithme est sous sa tangente en `1`. C'est un des rares
endroits d'un sujet de baccalauréat où l'énoncé demandé *est* un lemme de bibliothèque.

## Exercice 4 — le freinage du chariot (6 points, page 4)

Une distance `d`, une vitesse `v` solution de `y′ + 0,6y = e^(−0,6t)`, et `v(0) = 12`.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1. Temps pour parcourir `15 m` | lecture graphique | Fonctions, suites et analyse | — | ✗ |
| A.2. Longueur minimale de la zone de freinage | lecture graphique, asymptote | Fonctions, suites et analyse | — | ✗ |
| A.3. Valeur de `d′(4,7)` et interprétation | lecture graphique, nombre dérivé | Fonctions, suites et analyse | — | ✗ |
| B.1a. Solutions de `y′ + 0,6y = 0` | équation différentielle homogène | Fonctions, suites et analyse | — | ☐ |
| B.1b. `g(t) = te^(−0,6t)` est solution de `(E)` | dérivée d'un produit | Fonctions, suites et analyse | `ex4_g_solution` | ☑ |
| B.1c. En déduire les solutions de `(E)` | solution générale, solution particulière | Fonctions, suites et analyse | — | ☐ |
| B.1d. En déduire `v(t) = (12 + t)e^(−0,6t)` | condition initiale | Fonctions, suites et analyse | `ex4_v_solution` | ☑ |
| B.2a. Montrer que `v′(t) = (−6,2 − 0,6t)e^(−0,6t)` | dérivée d'un produit | Fonctions, suites et analyse | `ex4_derivee` | ☑ |
| B.2b. Limite de `v` en `+∞` | croissance comparée | Fonctions, suites et analyse | `ex4_limite_de_v` | ☑ |
| B.2c. Sens de variation et tableau de variation | signe de la dérivée | Fonctions, suites et analyse | `ex4_decroissance` | ☑ |
| B.2d. `v(t) = 1` admet une solution unique `α` | théorème des valeurs intermédiaires | Fonctions, suites et analyse | — | ☐ |
| B.3. Temps de déclenchement du dispositif d'arrêt | seuil, valeur approchée | Fonctions, suites et analyse | — | ☐ |
| C.1. Distance parcourue entre `0` et `t` | intégration par parties, primitive | Fonctions, suites et analyse | `ex4_distance` | ☑ |
| C.2. Distance avant déclenchement, au centième | valeur approchée | Fonctions, suites et analyse | — | ☐ |

La partie A est entièrement graphique, et le sujet l'annonce : « aucune justification n'est
attendue ». Elle demande une durée, une longueur et une pente — trois lectures. Ce n'est pas
un défaut : la partie C établira que la longueur cherchée est `205/9 ≈ 22,8 m`, et la question
A.2 est là pour qu'on voie l'asymptote avant de la calculer.

La question C.1 demande une intégration par parties ; ce qui est démontré ici est le résultat,
en dérivant la primitive proposée et en constatant qu'elle s'annule en `0`. Le théorème
fondamental de l'analyse fait le reste, et c'est mathlib qui le porte —
`intervalIntegral.integral_eq_sub_of_hasDerivAt`. La méthode demandée par le sujet et la
preuve écrite ici ne sont pas les mêmes, et l'énoncé, lui, est identique.

Les cinq questions non encore écrites forment une chaîne : la forme générale des solutions de
l'équation homogène (B.1a), les solutions de l'équation complète (B.1c), l'existence et
l'unicité de `α` par le théorème des valeurs intermédiaires (B.2d), la durée qui s'en déduit
(B.3), et la distance parcourue à cet instant (C.2). Les deux premières manquent au chapitre
d'analyse du dépôt ; les trois dernières demandent un encadrement numérique de `α ≈ 4,7`, du
même ordre que ceux qui manquent au brevet.

## Ce que la décomposition donne à voir

Trente-six questions : **vingt-quatre** démontrées, **six** qui sont des propositions non
encore écrites, **six** qui n'en sont pas.

Le sujet est très inégal de ce point de vue. L'exercice de géométrie se formalise
entièrement — huit questions sur huit —, parce que le repère orthonormé ramène tout aux
coordonnées. L'exercice d'analyse en formalise six sur quatorze, et les huit autres se
partagent entre lectures graphiques assumées par le sujet et théorèmes de cours qui manquent
encore : équations différentielles linéaires et valeurs approchées d'une solution.

C'est le même partage qu'au jour 1, et il se répète d'un sujet à l'autre : la géométrie
analytique et le dénombrement passent en Lean sans perte, l'analyse y demande un cours qui
reste à écrire, et le graphique n'y passera jamais.
