# Baccalauréat 2026, jour 2 — décomposition en exercices

*Spécialité mathématiques, voie générale, Métropole, 17 juin 2026* —
[sujet](https://www.apmep.fr/IMG/pdf/BAC_generale_specialite_J2_2026-06-17_Metropole_FK-v4.pdf) ·
[corrigé](https://www.apmep.fr/IMG/pdf/BAC_generale_specialite_J2_Corrige_2026-06-17_Metropole_FK-v2.pdf) ·
énoncés Lean dans [`Bac2026MetropoleJour2.lean`](Bac2026MetropoleJour2.lean).

Statuts : ☑ démontré · ◐ énoncé écrit, preuve en cours · ☐ proposition non encore écrite ·
✗ pas une proposition.

## Exercice 1 — géométrie dans l'espace (5 points)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| 1. A, B et C définissent un plan | vecteurs non colinéaires | Géométrie et mesure | — | ☐ |
| 2a. Le vecteur n est normal au plan | produit scalaire, vecteur normal | Géométrie et mesure | `ex1_vecteur_normal` | ☑ |
| 2b. Équation cartésienne du plan | équation cartésienne d'un plan | Géométrie et mesure | `ex1_equation_du_plan` | ☑ |
| 3. Représentation paramétrique de la droite Δ | représentation paramétrique | Géométrie et mesure | — | ☐ |
| 4. Projeté orthogonal de D sur le plan | projeté orthogonal, colinéarité | Géométrie et mesure | `ex1_projete_orthogonal` | ☑ |
| 5a. Le triangle ABC est isocèle en B | distance dans l'espace | Géométrie et mesure | `ex1_isocele` | ☑ |
| 5b. Aire du triangle ABC | produit vectoriel, aire | Géométrie et mesure | `ex1_aire` | ☑ |
| 6a. Volume du tétraèdre ABCD | volume d'un tétraèdre | Géométrie et mesure | `ex1_volume` | ☑ |
| 6b. Aire du triangle BCD | volume vu d'une autre base | Géométrie et mesure | `ex1_aire_bcd` | ☑ |
| 7a. Valeur de k rendant les points coplanaires | coplanarité | Géométrie et mesure | `ex1_coplanarite` | ☑ |
| 7b. A peut-il être le projeté de Dₖ ? | projeté orthogonal, discussion | Géométrie et mesure | — | ☐ |

C'est l'exercice qui se formalise le mieux du sujet : tout y est en coordonnées, et
l'orthogonalité s'y écrit avec un produit scalaire nul. La question 6b est la plus jolie —
le volume ne dépend pas de la face choisie comme base, ce qui détermine l'aire cherchée
sans la calculer directement.

## Exercice 2 — pollution d'un bassin (5 points)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1. Calculer V₁ et V₂ | suite récurrente | Fonctions, suites et analyse | `ex2_premiers_termes` | ☑ |
| A.2. Compléter le programme Python | boucle bornée | Algorithmique et informatique | — | ✗ |
| A.3. Récurrence : Vₙ ≤ Vₙ₊₁ ≤ 1200 | récurrence, encadrement, point fixe | Fonctions, suites et analyse | `ex2_croissance_majoree` | ☑ |
| A.4. Convergence et limite de la suite | suite croissante majorée | Fonctions, suites et analyse | — | ☐ |
| B.1a. Solutions de l'équation différentielle | équation différentielle linéaire | Fonctions, suites et analyse | — | ☐ |
| B.1b. Vérifier que v(t) = 1200(1 − e^(−0,005t)) | solution particulière | Fonctions, suites et analyse | `ex2_solution` | ☑ |
| B.1c. Limite de v en +∞ | limite d'une exponentielle | Fonctions, suites et analyse | — | ☐ |
| B.1d. Sens de variation de v | signe de la dérivée | Fonctions, suites et analyse | — | ☐ |
| B.2. Faut-il nettoyer le bassin ? | proportion, comparaison à un seuil | Fonctions, suites et analyse | `ex2_taux_maximal` | ☑ |
| B.3. Instant où le volume dépasse 50 litres | équation exponentielle, logarithme | Fonctions, suites et analyse | `ex2_seuil` | ☑ |

Les deux parties modélisent le même phénomène, l'une par une suite, l'autre par une
fonction — et donnent la même limite, `1 200` litres. Le rapprochement n'est demandé nulle
part dans le sujet, mais il saute aux yeux une fois les questions mises côte à côte.

## Exercice 3 — vrai ou faux : probabilités et dénombrement (4 points)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| 1. Affirmation 1 : probabilité conditionnelle | formule de Bayes | Probabilités et statistiques | `ex3_affirmation_1` | ☑ |
| 2a. Affirmation 2 : P(X ⩽ 340) ≈ 0,4 | loi binomiale, somme cumulée | Probabilités et statistiques | `ex3_affirmation_2` | ◐ |
| 2b. Affirmation 3 : intervalle de Bienaymé-Tchebychev | inégalité de Bienaymé-Tchebychev | Probabilités et statistiques | `ex3_affirmation_3` | ☑ |
| 3. Affirmation 4 : nombre d'équipes | combinaisons | Probabilités et statistiques | `ex3_affirmation_4` | ☑ |

L'affirmation 2 est écrite en Lean mais non démontrée : la vérifier demande d'évaluer une
somme de `341` coefficients binomiaux de rang `5 000`, calcul que le sujet fait faire à la
calculatrice et que ni `decide` ni `norm_num` ne mènent. C'est un cas intéressant — la
proposition est parfaitement claire, et c'est l'arithmétique qui bloque.

## Exercice 4 — la fonction du logo (6 points)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1a. Lire f′(1) sur le graphique | lecture graphique, tangente | Fonctions, suites et analyse | — | ✗ |
| A.1b. Lire la solution de f(x) = 0 | lecture graphique | Fonctions, suites et analyse | — | ✗ |
| A.2. Déterminer f′(1/2) | pente d'une tangente | Fonctions, suites et analyse | — | ☐ |
| A.3. Reconnaître les primitives parmi trois courbes | primitives, variations | Fonctions, suites et analyse | — | ✗ |
| B.1a. Écrire f avec une exponentielle au dénominateur | propriétés de l'exponentielle | Fonctions, suites et analyse | `ex4_forme_pour_la_limite` | ☑ |
| B.1b. Limite de f en +∞ | croissances comparées | Fonctions, suites et analyse | — | ☐ |
| B.2a. Calculer f′(x) | dérivée d'un produit | Fonctions, suites et analyse | `ex4_derivee` | ☑ |
| B.2b. Tableau de variations | variations | Fonctions, suites et analyse | — | ✗ |
| B.3. Existence et unicité de α | théorème des valeurs intermédiaires | Fonctions, suites et analyse | — | ☐ |
| C.1. Intégrale par parties | intégration par parties, primitive | Fonctions, suites et analyse | `ex4_integrale` | ☑ |
| C.2. Volume du porte-clé | aire, volume, unités | Grandeurs et mesures | — | ☐ |

L'intégration par parties que demande la question C.1 revient, une fois la primitive
`−x e^(−2x+3)` reconnue, à une simple dérivation : c'est souvent le cas, et la
formalisation le rend visible — on vérifie une primitive au lieu de la chercher.

## Ce que la décomposition donne à voir

Trente-six questions : **dix-neuf** démontrées, **une** écrite sans être démontrée,
**onze** propositions non encore écrites, **cinq** qui n'en sont pas.

Les deux sujets du baccalauréat ensemble comptent dix questions qui ne sont pas des
propositions — lectures graphiques, tableaux de variation, programmes à compléter, arbre à
remplir, modélisation à justifier. C'est une question sur sept, une proportion plus forte
qu'au brevet, où c'est une sur cinq… mais sur un sujet trois fois plus court.
