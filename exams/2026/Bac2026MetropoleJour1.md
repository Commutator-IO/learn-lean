# Baccalauréat 2026, jour 1 — décomposition en questions

*Spécialité mathématiques, voie générale, Métropole, 16 juin 2026* —
[sujet](https://www.apmep.fr/IMG/pdf/BAC_General_Specialite_Sujet_J1_metropole_FK-v2.pdf) ·
[corrigé](https://www.apmep.fr/IMG/pdf/BAC_General_Specialite_Corrige_J1_metropole_FK-v3.pdf) ·
énoncés Lean dans [`Bac2026MetropoleJour1.lean`](Bac2026MetropoleJour1.lean).

Statuts : ☑ démontré · ◐ énoncé écrit, preuve en cours · ☐ proposition non encore écrite ·
✗ pas une proposition.

La distinction entre ☐ et ✗ est celle qui compte. ☐ signale une question qui *pourrait*
devenir un théorème et qui ne l'est pas encore ; ✗ signale une question qui ne le
deviendra pas — lire une pente sur un graphique, compléter un arbre, écrire un programme.

## Exercice 1 — probabilités, espérance, Bienaymé-Tchebychev (5 points)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1a. Probabilité de l'évènement contraire | évènement contraire | Probabilités et statistiques | `ex1_evenement_contraire` | ☑ |
| A.1b. Compléter l'arbre pondéré | arbre pondéré | Probabilités et statistiques | — | ✗ |
| A.2. Probabilité de l'intersection | probabilités composées | Probabilités et statistiques | `ex1_intersection` | ☑ |
| A.3. Probabilité conditionnelle sachant la cabine | probabilité conditionnelle | Probabilités et statistiques | `ex1_conditionnelle` | ☑ |
| A.4. Probabilité conditionnelle sachant l'absence de véhicule | probabilités totales, arrondi | Probabilités et statistiques | `ex1_conditionnelle_contraire` | ☑ |
| B.1. Espérance et variance de X | espérance, variance, König–Huygens | Probabilités et statistiques | `ex1_esperance_variance` | ☑ |
| B.2a. Justifier que Z = 0,6(X + Y) | modélisation | Probabilités et statistiques | — | ✗ |
| B.2b. Espérance et variance de Z | linéarité, indépendance | Probabilités et statistiques | `ex1_reduction` | ☑ |
| B.3a. Espérance et variance de la moyenne | moyenne empirique | Probabilités et statistiques | `ex1_moyenne_empirique` | ☑ |
| B.3b. Plus petit n par Bienaymé-Tchebychev | inégalité de Bienaymé-Tchebychev | Probabilités et statistiques | `ex1_bienayme_tchebychev` | ☑ |

La question B.2a demande de *justifier* une modélisation : une remise de `40 %` porte sur
la somme des deux montants. C'est une phrase, pas un calcul.

## Exercice 2 — vrai ou faux : espace et dénombrement (4 points)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| 1a. Affirmation 1 : plan médiateur de [AB] | vecteur normal, milieu | Géométrie et mesure | `ex2_affirmation_1` | ☑ |
| 1b. Affirmation 2 : droites sécantes | représentation paramétrique, système | Géométrie et mesure | `ex2_affirmation_2` | ☑ |
| 1c. Affirmation 3 : mesure d'un angle | produit scalaire, cosinus | Géométrie et mesure | `ex2_affirmation_3` | ☑ |
| 2. Affirmation 4 : comparer deux digicodes | arrangements, combinaisons | Probabilités et statistiques | `ex2_affirmation_4` | ☑ |

L'exercice se formalise entièrement, et c'est le seul du sujet dans ce cas. Deux
affirmations sont vraies, deux fausses — et la démonstration d'une affirmation fausse est
la construction du contre-exemple, ici l'absence de solution d'un système.

## Exercice 3 — équation différentielle et suite (6 points)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1. Solutions de l'équation différentielle | équation différentielle linéaire | Fonctions, suites et analyse | — | ☐ |
| A.2. Vérifier que T(t) = 26 − 8e^(−0,035t) | solution particulière, condition initiale | Fonctions, suites et analyse | `ex3_solution` | ☑ |
| A.3. Temps pour atteindre 20 °C | résolution d'une équation exponentielle | Fonctions, suites et analyse | — | ☐ |
| A.4. La température peut-elle dépasser 28 °C ? | majoration, limite | Fonctions, suites et analyse | `ex3_majoration` | ☑ |
| B.1. Calculer u₁ | suite récurrente | Fonctions, suites et analyse | `ex3_u1` | ☑ |
| B.2. Montrer par récurrence que uₙ > 10 | récurrence, point fixe | Fonctions, suites et analyse | `ex3_minoration` | ☑ |
| B.3. Convergence de la suite | suite décroissante minorée | Fonctions, suites et analyse | — | ☐ |
| B.4. La limite vaut 10 | point fixe de la récurrence | Fonctions, suites et analyse | `ex3_limite` | ☑ |
| B.5a. Compléter le programme Python | boucle non bornée | Algorithmique et informatique | — | ✗ |
| B.5b. Temps de remise en marche | seuil d'une suite | Fonctions, suites et analyse | — | ☐ |

La question A.1 demande la forme générale des solutions de `y' = ay + b` : c'est un
théorème du cours, que le chapitre « Limites, continuité, dérivation » ne contient pas
encore.

## Exercice 4 — une fonction avec un logarithme (5 points)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1. Justifier que a = 1 | valeur en un point, ln 1 = 0 | Fonctions, suites et analyse | `ex4_valeur_de_a` | ☑ |
| A.2a. Lire f′(0) sur le graphique | lecture graphique, tangente | Fonctions, suites et analyse | — | ✗ |
| A.2b. Lire le signe de f″(1) | lecture graphique, convexité | Fonctions, suites et analyse | — | ✗ |
| A.3a. Calculer f′(x) | dérivée d'un quotient, dérivée de ln | Fonctions, suites et analyse | `ex4_derivee` | ☑ |
| A.3b. En déduire b = 4 | identification par la dérivée | Fonctions, suites et analyse | `ex4_valeur_de_b` | ☑ |
| B.1. Asymptote horizontale y = 1 | limite en +∞ | Fonctions, suites et analyse | — | ☐ |
| B.2. Résoudre 1 − ln(x+1) > 0 | inéquation logarithmique | Fonctions, suites et analyse | `ex4_inequation` | ☑ |
| B.3. Tableau de variation et extremum | variations, extremum | Fonctions, suites et analyse | — | ☐ |
| B.4. Unicité de la solution de f(x) = 1,5 | théorème des valeurs intermédiaires | Fonctions, suites et analyse | — | ☐ |
| B.5a. Calculer l'intégrale de ln(x+1)/(x+1) | primitive de u′u | Fonctions, suites et analyse | `ex4_integrale` | ☑ |
| B.5b. Aire du domaine | intégrale et aire | Fonctions, suites et analyse | — | ☐ |

Les questions A.2a et A.2b sont les seules du sujet à demander une lecture graphique, et
elles sont *nécessaires* : sans elles, `b` reste indéterminé. La courbe est une donnée de
l'énoncé au même titre qu'un nombre, et c'est ce qui les rend impossibles à formaliser.

## Ce que la décomposition donne à voir

Trente-cinq questions : **vingt-deux** démontrées, **huit** qui sont des propositions non
encore écrites, **cinq** qui n'en sont pas.

Ces cinq dernières sont plus variées qu'au brevet : deux lectures graphiques, un programme
Python à compléter, un arbre à remplir, une modélisation à justifier. L'épreuve du
baccalauréat évalue davantage de choses qu'un théorème ne peut en dire.
