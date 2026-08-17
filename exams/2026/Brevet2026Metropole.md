# Brevet 2026 — décomposition en questions

*Série générale, Métropole, 30 juin 2026* —
[sujet](https://www.apmep.fr/IMG/pdf/DNB_generale_Sujet_2026-06-30_Metropole_FK-v2.pdf) ·
[corrigé](https://www.apmep.fr/IMG/pdf/DNB_generale_Corrige_2026-06-30_Metropole_MD-v4.pdf) ·
énoncés Lean dans [`Brevet2026Metropole.lean`](Brevet2026Metropole.lean).

Le sujet est découpé question par question. Chaque ligne porte les notions en jeu, le thème
du dépôt auquel elle se rattache, et l'énoncé Lean qui en est dérivé quand il y en a un.

**Ce qui n'a pas d'énoncé n'est pas un oubli.** Une question de brevet n'est pas toujours
une proposition mathématique : lire une valeur sur un graphique, interpréter un résultat
dans le contexte, décrire une démarche sont des tâches, pas des théorèmes. Les recenser
est une partie du travail — c'est là que se voit ce qu'une épreuve demande et qu'un
assistant de preuve ne sait pas dire.

Statuts : ☑ démontré · ◐ énoncé écrit, preuve en cours · ✗ pas une proposition.

## Première partie — automatismes (6 points)

QCM, neuf questions, sans justification demandée.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| 1. Écriture fractionnaire de `0,75` | fractions, écritures décimales | Nombres et calcul | `qcm_ecriture_fractionnaire` | ☑ |
| 2. Somme `−4,7 + 3,5` | nombres relatifs | Nombres et calcul | `qcm_somme_de_relatifs` | ☑ |
| 3. Tableau de proportionnalité | proportionnalité, produits en croix | Fonctions, suites et analyse | `qcm_proportionnalite` | ☑ |
| 4. Probabilité d'une boule bleue | équiprobabilité, fréquence | Probabilités et statistiques | `qcm_probabilite` | ☑ |
| 5. Équation `10x + 16 = −64` | équation du premier degré | Nombres et calcul | `qcm_equation` | ☑ |
| 6. Notation scientifique de `0,004 58` | puissances de dix | Nombres et calcul | `qcm_notation_scientifique` | ☑ |
| 7. Diagramme circulaire, effectif d'un secteur | lecture graphique, proportionnalité | Probabilités et statistiques | — | ✗ |
| 8. Périmètre d'une figure | périmètre, distinction longueur/aire | Géométrie et mesure | `qcm_perimetre` | ☑ |
| 9. Cosinus d'un angle aigu | trigonométrie du triangle rectangle | Géométrie et mesure | `qcm_cosinus` | ☑ |

La question 7 demande de lire un angle sur un diagramme circulaire : la donnée est dans
l'image, et l'énoncé écrit ne la contient pas. Rien à formaliser tant que la figure n'est
pas elle-même un objet mathématique.

## Exercice 1 — statistiques (3 points)

Tableau des médailles de neuf pays aux Jeux paralympiques de Paris 2024.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| 1. Médailles d'or des Pays-Bas | lecture de tableau, soustraction | Probabilités et statistiques | `ex1_medailles_pays_bas` | ☑ |
| 2. Médailles d'or de l'Australie | idem, valeur manquante | Probabilités et statistiques | `ex1_medailles_australie` | ☑ |
| 3. « Plus de 20 % des médailles britanniques sont en bronze » | proportion, pourcentage | Probabilités et statistiques | `ex1_proportion_bronze` | ☑ |
| 4a. Médiane des totaux | médiane, effectif impair | Probabilités et statistiques | `ex1_mediane` | ☑ |
| 4b. Interpréter la médiane dans le contexte | interprétation | Probabilités et statistiques | — | ✗ |
| 5. Pourcentage d'augmentation | taux d'évolution | Fonctions, suites et analyse | `ex1_augmentation` | ☑ |

La question 4b demande d'interpréter : « la moitié des pays ont obtenu moins de 82
médailles ». C'est une phrase en français sur le sens d'un nombre, et elle n'a pas de
contenu qui se démontre.

## Exercice 2 — Thalès et triangles semblables (4 points)

Deux droites sécantes en `A`, deux parallèles, quatre longueurs données.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| 1. `ABC` est rectangle en `A` | réciproque de Pythagore | Géométrie et mesure | `ex2_rectangle` | ☑ |
| 2. `DE = 6` et `AE = 3,6` | théorème de Thalès | Géométrie et mesure | `ex2_thales` | ☑ |
| 3. Égalité de deux angles | angles alternes-internes | Géométrie et mesure | — | ✗ |
| 4. `ABC` et `ADE` sont semblables | triangles semblables | Géométrie et mesure | — | ✗ |
| 5. Aire du quadrilatère `BCDE` | aire d'un triangle rectangle, découpage | Géométrie et mesure | `ex2_aire` | ☑ |

Les questions 3 et 4 portent sur la configuration elle-même : les angles alternes-internes
et la similitude se lisent sur la figure, et les formaliser demanderait de modéliser le
plan, les droites et les angles orientés — ce que le chapitre de géométrie du dépôt fait
pour ses propres énoncés, mais qui dépasse ce qu'un exercice de brevet met en jeu. Ce qui
est formalisé ici est l'arithmétique qui en découle, la configuration étant prise en
hypothèse.

## Exercice 3 — volume d'une boule (3 points)

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1. Image de `3,6` lue sur la courbe | lecture graphique | Fonctions, suites et analyse | — | ✗ |
| A.2. Antécédent de `660` lu sur la courbe | lecture graphique | Fonctions, suites et analyse | — | ✗ |
| B.1. Volume d'une boule de rayon `2,5` | volume de la boule, arrondi | Géométrie et mesure | `ex3_volume` | ☑ |
| B.2. Nombre de boules dans `1 000 cm³` | division euclidienne | Nombres et calcul | `ex3_nombre_de_boules` | ☑ |
| B.3. Masse d'une boule | masse volumique, proportionnalité | Grandeurs et mesures | `ex3_masse` | ☑ |

La partie A est entièrement graphique : la courbe est la donnée, et les deux questions
demandent de la lire. C'est l'exemple le plus net de ce que le brevet évalue et qu'aucun
énoncé formel ne capture.

La formule `V = 4πR³/3` est donnée par le sujet, et le dépôt ne la démontre pas non plus :
elle figure parmi les énoncés admis du chapitre « Grandeurs et mesures ». Ce qui est
vérifié ici, c'est le calcul et son arrondi.

## Exercice 4 — sachets de bonbons (2 points)

`112` bonbons à la fraise, `140` au caramel, des sachets identiques.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| 1. Peut-on faire `16` sachets ? | divisibilité | Nombres et calcul | `ex4_seize_sachets` | ☑ |
| 2. Décomposition de `140` en facteurs premiers | facteurs premiers | Nombres et calcul | `ex4_decomposition` | ☑ |
| 3. Nombre maximal de sachets et composition | PGCD, diviseurs communs | Nombres et calcul | `ex4_nombre_maximal`, `ex4_maximalite` | ☑ |

C'est l'exercice qui se formalise le mieux, et de loin : il est arithmétique de bout en
bout. La maximalité du PGCD, que le sujet admet implicitement, est ici démontrée — tout
diviseur commun divise le PGCD, donc ne le dépasse pas.

## Ce que la décomposition donne à voir

Vingt-huit questions, dont **vingt-deux** portent une proposition qui se démontre et
**six** n'en portent pas. Les six se répartissent en trois familles :

- **la lecture graphique** (questions 7 du QCM, A.1 et A.2 de l'exercice 3) — la donnée est
  dans une image ;
- **l'interprétation** (question 4b de l'exercice 1) — il s'agit de dire en français ce
  qu'un nombre signifie ;
- **la configuration géométrique** (questions 3 et 4 de l'exercice 2) — l'énoncé porte sur
  une figure, et ce qu'on en déduit est déjà arithmétique.

Aucune n'est un défaut du sujet. Ce sont des compétences que l'épreuve évalue et qu'un
assistant de preuve ne sait pas exprimer, ce qui est précisément ce que ce dépôt cherche à
mesurer.
