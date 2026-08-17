# Baccalauréat 2025, jour 1 — décomposition en questions

*Spécialité mathématiques, voie générale, Métropole, 17 juin 2025* —
[sujet](https://www.apmep.fr/IMG/pdf/Metro_J1_17_06_2025_DV.pdf) ·
[corrigé](https://www.apmep.fr/IMG/pdf/Corrige__Me_tropole_spe_J1_17_06_2025_VTFK.pdf) ·
énoncés Lean dans [`Bac2025MetropoleJour1.lean`](Bac2025MetropoleJour1.lean).

Statuts : ☑ démontré · ◐ énoncé écrit, preuve en cours · ☐ proposition pas encore écrite ·
✗ pas une proposition.

La distinction entre ☐ et ✗ est celle qui compte. ☐ signale une question qui *pourrait*
devenir un théorème et qui ne l'est pas encore ; ✗ signale une question qui ne le
deviendra pas — compléter un arbre, lire une pente sur un graphique, écrire un programme,
justifier une modélisation.

## Exercice 1 — groupes sanguins, loi binomiale, Bienaymé-Tchebychev (5 points, page 1)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| 1. Compléter l'arbre pondéré | arbre pondéré | Probabilités et statistiques | — | ✗ |
| 2. Montrer que `p(B ∩ R) = 0,084` | probabilités composées | Probabilités et statistiques | `ex1_groupe_b_rhesus_positif` | ☑ |
| 3. Montrer que `p_O(R) = 0,83` | probabilités totales, conditionnement | Probabilités et statistiques | `ex1_rhesus_sachant_o` | ☑ |
| 4. Probabilité d'être donneur universel | évènement contraire, intersection | Probabilités et statistiques | `ex1_donneur_universel` | ☑ |
| 5a. Justifier que X suit une loi binomiale | modélisation, tirage avec remise | Probabilités et statistiques | — | ✗ |
| 5b. `P(X ≤ 7)` à `10⁻³` près | fonction de répartition binomiale | Probabilités et statistiques | — | ☐ |
| 5c. `E(X) = 7,14` et `V(X) ≈ 6,63` | espérance et variance binomiales | Probabilités et statistiques | `ex1_esperance_variance` | ☑ |
| 6a. Ce que représente la variable M_N | interprétation | Probabilités et statistiques | — | ✗ |
| 6b. Calculer `E(M_N)` | linéarité de l'espérance | Probabilités et statistiques | `ex1_esperance_moyenne` | ☑ |
| 6c. Montrer que `V(M_N) = 6,63/N` | variance d'une moyenne, indépendance | Probabilités et statistiques | `ex1_variance_moyenne` | ☑ |
| 6d. Plus petit `N` par Bienaymé-Tchebychev | inégalité de Bienaymé-Tchebychev | Probabilités et statistiques | `ex1_bienayme_tchebychev` | ☑ |

La question 5b est la seule du sujet dont l'énoncé s'écrirait sans peine et dont la preuve
coûterait cher : `P(X ≤ 7)` est une somme de huit termes binomiaux à cent facteurs, un
rationnel exact dont il faut certifier l'arrondi. Le calcul est faisable, il n'est pas fait —
d'où le ☐, qui n'a pas le même sens que le ✗ de la question 5a, où c'est la modélisation
elle-même qui est demandée.

La question 6d montre pourquoi Bienaymé-Tchebychev est enseignée : `N ≥ 6 766` est une
exigence énorme pour une garantie modeste, et c'est le prix d'une inégalité qui ne suppose
rien de la loi.

## Exercice 2 — une fonction avec un logarithme (6 points, page 2)

`f(x) = x[2(ln x)² − 3 ln x + 2]` sur `]0 ; +∞[`, deux tangentes tracées, une aire à calculer.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1. Lire `f′(1)` sur le graphique | lecture graphique, tangente | Fonctions, suites et analyse | — | ✗ |
| A.2. Nombre de solutions de `f′(x) = 0` sur `]0 ; 3]` | lecture graphique, extremums | Fonctions, suites et analyse | — | ✗ |
| A.3. Signe de `f″(0,2)` | lecture graphique, convexité | Fonctions, suites et analyse | — | ✗ |
| B.1. Résoudre `2X² − 3X + 2 = 0` et conclure | discriminant, forme canonique | Fonctions, suites et analyse | `ex2_pas_de_racine`, `ex2_ne_sannule_pas` | ☑ |
| B.2. Limite de `f` en `+∞` | minoration, limite | Fonctions, suites et analyse | `ex2_limite_en_plus_infini` | ☑ |
| B.3a. Montrer que `f″(x) = (4 ln x + 1)/x` | dérivée d'un produit, dérivée de ln | Fonctions, suites et analyse | `ex2_derivee_seconde` | ☑ |
| B.3b. Convexité et abscisse du point d'inflexion | signe de la dérivée seconde | Fonctions, suites et analyse | `ex2_signe_derivee_seconde` | ☑ |
| B.3c. La courbe est au-dessus de la tangente T_B sur `]1 ; +∞[` | position relative courbe-tangente | Fonctions, suites et analyse | — | ☐ |
| C.1. Équation réduite de la tangente T_B | équation de la tangente | Fonctions, suites et analyse | `ex2_tangente` | ☑ |
| C.2. Intégration par parties de `x ln x` | intégration par parties | Fonctions, suites et analyse | — | ☐ |
| C.3. Aire du domaine hachuré | intégrale et aire, différence de deux courbes | Fonctions, suites et analyse | `ex2_aire` | ☑ |

La partie A est entièrement graphique, et c'est assumé : le sujet écrit « on répondra en
justifiant à l'aide du graphique ». Trois questions, trois lectures — le nombre dérivé se lit
sur la tangente qui passe par `C(3 ; 0)`, le nombre de solutions de `f′(x) = 0` se compte sur
les extremums, le signe de `f″` se voit sur la courbure. La partie B donne ensuite `f′`, ce
qui permettrait de retrouver ces réponses par le calcul ; mais les questions telles qu'elles
sont posées demandent de lire, et c'est cela qui n'a pas d'énoncé.

La question B.1 est un bon exemple de ce que la formalisation change. Le sujet calcule un
discriminant négatif et conclut qu'il n'y a pas de racine ; la preuve la plus courte est la
forme canonique `2(X − 3/4)² + 7/8`, qui donne mieux qu'une non-annulation — une minoration
par `7/8`. Cette minoration sert ensuite à la limite de la question B.2, où elle remplace la
croissance comparée : `f(x) ≥ 7x/8` suffit.

La question B.3b est comptée comme démontrée, avec une réserve : ce qui est établi est le
signe de la dérivée seconde, `f″(x) ≥ 0 ⟺ x ≥ e^(−1/4)`. Le passage du signe de `f″` à la
convexité est le critère du cours, qui n'est pas repris ici.

## Exercice 3 — vrai ou faux dans l'espace (4 points, page 4)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| 1a. Affirmation 1 : représentation paramétrique de `(AB)` | vecteur directeur, colinéarité | Géométrie et mesure | `ex3_affirmation_1` | ☑ |
| 1b. Affirmation 2 : `n(5 ; −2 ; 1)` normal au plan `(OAB)` | vecteur normal, produit scalaire | Géométrie et mesure | `ex3_affirmation_2` | ☑ |
| 2. Affirmation 3 : les droites `d` et `d′` ne sont pas coplanaires | intersection de deux droites, système | Géométrie et mesure | `ex3_affirmation_3` | ☑ |
| 3. Affirmation 4 : distance de `C` au plan `P` | distance d'un point à un plan | Géométrie et mesure | `ex3_affirmation_4` | ☑ |

L'exercice se formalise entièrement — le repère orthonormé ramène tout aux coordonnées, et le
produit scalaire y est une somme de produits. Deux affirmations sont vraies, deux fausses, et
les preuves des fausses sont les plus courtes : pour l'affirmation 2, un produit scalaire non
nul suffit ; pour l'affirmation 3, le point d'intersection `(−9 ; 12 ; −14)` se calcule et
montre que les droites sont sécantes, donc coplanaires.

## Exercice 4 — la posidonie (5 points, page 5)

Un modèle discret — `u₀ = 1`, `u_{n+1} = −0,02u_n² + 1,3u_n` — puis un modèle continu, régi
par l'équation logistique `y′ = 0,02y(15 − y)`.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1. Superficie au premier juillet 2025 | suite récurrente | Fonctions, suites et analyse | `ex4_u1` | ☑ |
| A.2a. Montrer que `1 ≤ uₙ ≤ u_{n+1} ≤ 20` | récurrence, monotonie de la fonction | Fonctions, suites et analyse | `ex4_encadrement` | ☑ |
| A.2b. En déduire que la suite converge | suite croissante majorée | Fonctions, suites et analyse | — | ☐ |
| A.2c. Justifier que la limite vaut `15` | point fixe de la récurrence | Fonctions, suites et analyse | `ex4_limite` | ☑ |
| A.3a. Justifier sans calcul que `14 ha` seront dépassés | limite, croissance | Fonctions, suites et analyse | — | ☐ |
| A.3b. Compléter l'algorithme Python | boucle non bornée, seuil | Algorithmique et informatique | — | ✗ |
| B.1. Montrer que `g = 1/f` est solution de `(E₂)` | dérivée de l'inverse, changement de fonction | Fonctions, suites et analyse | `ex4_changement_de_fonction` | ☑ |
| B.2. Donner les solutions de `(E₂)` | équation différentielle linéaire | Fonctions, suites et analyse | — | ☐ |
| B.3. En déduire `f(t) = 15/(14e^(−0,3t) + 1)` | condition initiale, inversion | Fonctions, suites et analyse | `ex4_expression` | ☑ |
| B.4. Limite de `f` en `+∞` | limite d'un quotient | Fonctions, suites et analyse | `ex4_limite_continue` | ☑ |
| B.5. Résoudre `f(t) > 14` et interpréter | inéquation exponentielle, logarithme | Fonctions, suites et analyse | `ex4_seuil` | ☑ |

La question A.2a est celle qui apprend le plus. Le triple encadrement `1 ≤ uₙ ≤ u_{n+1} ≤ 20`
se démontre d'un seul bloc, et la croissance ne vient pas d'un argument de point fixe mais de
la monotonie de `h(x) = −0,02x² + 1,3x` sur `[0 ; 20]`, que le sujet fait admettre. Le
majorant `20` y est essentiel : `h` décroît au-delà de `32,5`, et sans lui la récurrence
tombe.

La question B.2 demande la forme générale des solutions de `y′ = ay + b` : c'est un théorème
du cours, que le chapitre « Limites, continuité, dérivation » ne contient pas encore — même
raison qu'au jour 1 du sujet 2026, et c'est le manque le plus visible du dépôt en analyse.

Le changement de fonction de la question B.1 est le cœur de l'exercice : `1/f` linéarise
l'équation logistique. C'est le seul endroit où l'hypothèse « `f` ne s'annule pas » sert, et
la formalisation le rend visible — elle est en hypothèse du théorème, et nulle part ailleurs.

## Ce que la décomposition donne à voir

Trente-sept questions : **vingt-quatre** démontrées, **six** qui sont des propositions non
encore écrites, **sept** qui n'en sont pas.

Les sept se répartissent en trois familles : trois lectures graphiques et un arbre à
compléter — la figure est la donnée ; deux modélisations à justifier — que `X` suive une loi
binomiale, ce que représente une moyenne empirique ; un algorithme à compléter.

Les six propositions non écrites disent où le dépôt manque, non où l'épreuve résiste : la
forme générale des solutions d'une équation différentielle linéaire, la convergence d'une
suite croissante majorée, une intégration par parties, un calcul binomial certifié. Ce sont
des théorèmes de cours à écrire, pas des obstacles de nature.
