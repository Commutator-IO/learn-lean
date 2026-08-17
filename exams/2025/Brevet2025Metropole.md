# Brevet 2025 — décomposition en questions

*Série générale, Métropole–Antilles–Guyane, 26 juin 2025* —
[sujet](https://www.apmep.fr/IMG/pdf/Brevet_Me_tropole_26_06_2025_FK.pdf) ·
[corrigé](https://www.apmep.fr/IMG/pdf/Corrige_Brevet_Metropole_26_06_2025_DV.pdf) ·
énoncés Lean dans [`Brevet2025Metropole.lean`](Brevet2025Metropole.lean).

Le sujet est découpé question par question. Chaque ligne porte les notions en jeu, le thème
du dépôt auquel elle se rattache, et l'énoncé Lean qui en est dérivé quand il y en a un.

**Ce qui n'a pas d'énoncé n'est pas un oubli.** Une question de brevet n'est pas toujours
une proposition mathématique : reconnaître une transformation sur une figure, compléter un
programme, écrire une formule de tableur sont des tâches, pas des théorèmes. Les recenser
est une partie du travail — c'est là que se voit ce qu'une épreuve demande et qu'un
assistant de preuve ne sait pas dire.

Statuts : ☑ démontré · ◐ énoncé écrit, preuve en cours · ☐ proposition pas encore écrite ·
✗ pas une proposition.

## Exercice 1 — deux urnes (20 points, page 1)

Une urne `A` de six boules — `7 ; 10 ; 12 ; 15 ; 24 ; 30` — et une urne `B` de neuf boules —
`2 ; 5 ; 6 ; 8 ; 17 ; 18 ; 21 ; 22 ; 25`.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| 1. Probabilité d'obtenir un nombre pair dans `A` | équiprobabilité, parité | Probabilités et statistiques | `ex1_nombre_pair` | ☑ |
| 2. Probabilité d'obtenir un nombre premier dans `B` | nombres premiers | Nombres et calcul | `ex1_nombre_premier` | ☑ |
| 3. Quelle urne contient le plus de multiples de `6` | multiples, divisibilité | Nombres et calcul | `ex1_multiples_de_six` | ☑ |
| 4. Même probabilité d'obtenir au moins `20` dans les deux urnes | égalité de deux proportions | Probabilités et statistiques | `ex1_au_moins_vingt` | ☑ |
| 5. Effet de l'ajout d'une boule `50` dans chaque urne | comparaison de proportions | Probabilités et statistiques | `ex1_avec_cinquante` | ☑ |

L'exercice se formalise entièrement, et c'est le seul du sujet dans ce cas : les urnes sont
des listes finies, et chaque probabilité un dénombrement. Les cinq énoncés se démontrent par
calcul — `decide` compte les boules, `norm_num` compare les fractions.

La question 4 est la plus intéressante : `2/6` et `3/9` ne sont pas la même fraction, et
c'est justement leur égalité qu'il faut établir. La question 5 montre qu'elle était fragile
— ajouter une même boule aux deux urnes la détruit, parce que la plus petite urne en profite
le plus.

## Exercice 2 — l'aquathlon (23 points, page 1)

Un parcours `ACDEB`, un triangle rectangle, deux droites à comparer ; puis les temps de neuf
nageurs sur `200 m`.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1. Justifier que `AD = 200 m` | alignement, soustraction | Géométrie et mesure | `ex2_ad` | ☑ |
| A.2. Calculer la longueur `CD` | théorème de Pythagore | Géométrie et mesure | `ex2_cd` | ☑ |
| A.3a. Les droites `(CD)` et `(BE)` sont-elles parallèles ? | réciproque du théorème de Thalès | Géométrie et mesure | `ex2_paralleles` | ☑ |
| A.3b. L'angle `ACD` dépasse-t-il `20°` ? | trigonométrie du triangle rectangle | Géométrie et mesure | — | ☐ |
| A.3c. Le parcours est-il validé ? | conjonction des deux critères | Géométrie et mesure | — | ☐ |
| B.4. Temps médian des neuf nageurs | médiane, conversion en secondes | Probabilités et statistiques | `ex2_mediane` | ☑ |
| B.5. Le poisson rouge nage-t-il plus vite que le meilleur élève ? | vitesse, conversion d'unités | Grandeurs et mesures | `ex2_poisson` | ☑ |

Les deux questions sans énoncé le sont pour la même raison, et elle est instructive :
comparer un angle à `20°` demande un encadrement numérique de la tangente ou du cosinus, que
le dépôt ne possède pas encore. `tan 20° ≈ 0,364` est plus petit que `200/480 ≈ 0,417`, mais
certifier cette comparaison n'est pas du même ordre que vérifier un calcul — c'est un
encadrement de fonction transcendante. La question 3c n'attend qu'une conclusion, et elle
tombe avec la précédente.

Le reste de la configuration, en revanche, se traite bien : le calcul de `CD` par Pythagore
et l'égalité des rapports de Thalès sont de l'arithmétique, la figure fournissant l'angle
droit et les alignements en hypothèse.

## Exercice 3 — questionnaire à choix multiples (18 points, page 2)

Six questions, sans justification demandée.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| 1. Prix de cinq melons | proportionnalité, prix unitaire | Fonctions, suites et analyse | `qcm_melons` | ☑ |
| 2. Transformation menant de la figure 1 à la figure 2 | rotation, symétries, translation | Géométrie et mesure | — | ✗ |
| 3. Prix après une augmentation de `20 %` | taux d'évolution | Fonctions, suites et analyse | `qcm_augmentation` | ☑ |
| 4. Aire du triangle rectangle `ABC` | réciproque de Pythagore, aire | Géométrie et mesure | `qcm_aire` | ☑ |
| 5. Forme développée et réduite de `(2x + 3)(x − 4)` | double distributivité | Nombres et calcul | `qcm_developpement` | ☑ |
| 6. Volume d'une pyramide à base rectangulaire | volume de la pyramide | Grandeurs et mesures | `qcm_volume` | ☑ |

La question 2 est la seule du sujet à ne porter sur rien d'écrit : les deux figures *sont*
l'énoncé, et reconnaître laquelle des quatre transformations les relie demande de les
regarder. Rien à formaliser tant que la figure n'est pas elle-même un objet mathématique.

La question 5 est la seule dont l'énoncé Lean soit universellement quantifié : développer
n'est pas résoudre, et l'égalité vaut pour tout `x`. C'est une identité, et le dire ainsi est
plus fidèle au sens de la question qu'une vérification sur un nombre.

## Exercice 4 — programmes de calcul (20 points, page 4)

Le programme de Zoé — choisir un nombre, soustraire `4`, multiplier par `2`, ajouter `8` — et
celui de Fred, écrit en Scratch.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1. Résultat obtenu en partant de `10` | programme de calcul | Nombres et calcul | `ex4_zoe_dix` | ☑ |
| A.2. Résultat obtenu en partant de `−7` | nombres relatifs | Nombres et calcul | `ex4_zoe_moins_sept` | ☑ |
| A.3. Le résultat est-il toujours le double du nombre choisi ? | calcul littéral, preuve générale | Nombres et calcul | `ex4_zoe_magique` | ☑ |
| B.4. Le programme de Fred renvoie `20x + 50` | calcul littéral, composition | Nombres et calcul | `ex4_fred` | ☑ |
| B.5. Nombre de départ donnant `75` | équation du premier degré | Nombres et calcul | `ex4_fred_soixante_quinze` | ☑ |
| B.6. Compléter la sixième ligne du programme Scratch | instruction manquante | Algorithmique et informatique | — | ✗ |

C'est l'exercice où la différence entre vérifier et démontrer est la plus visible. Les
questions 1 et 2 sont deux calculs, la question 3 est un théorème : « quel que soit le nombre
choisi » se formalise par une quantification universelle, et la preuve tient en un `ring`.
Deux exemples ne prouvent rien, et le sujet le sait.

La question 6 demande d'écrire une instruction — `mettre résultat à résultat − 50`. L'égalité
qui la justifie, `20x + 50 − 50 = 20x`, est triviale ; ce qui est évalué, c'est de savoir
écrire l'instruction dans le langage du programme, et cela n'a pas d'énoncé.

## Exercice 5 — acheter ou louer (19 points, page 5)

Achat à `22 400 €` plus `75 €` d'assurance par mois, contre location à `425 €` par mois.

| Question | Notions | Thème | Théorème | Statut |
|---|---|---|---|---|
| A.1. Dépense à la fin de la première année | somme, mensualités | Nombres et calcul | `ex5_premiere_annee` | ☑ |
| A.2. Économie réalisée après `36` mois | comparaison de deux dépenses | Nombres et calcul | `ex5_trente_six_mois` | ☑ |
| A.3. Formule à saisir dans la cellule `B3` | formule de tableur, recopie | Algorithmique et informatique | — | ✗ |
| B.4. Expression de `f(x)` pour l'option Achat | modélisation par une fonction affine | Fonctions, suites et analyse | — | ✗ |
| B.5. À partir de combien de mois l'Achat est-il plus avantageux | lecture graphique, inéquation | Fonctions, suites et analyse | `ex5_seuil` | ☑ |

Deux questions sans énoncé, de deux natures différentes. La formule `=425*B1` est du tableur :
sa syntaxe fait partie de la compétence évaluée, et elle n'est pas une proposition. Passer de
la situation à `f(x) = 75x + 22 400`, en revanche, est une modélisation : rien à démontrer,
tout à traduire — et c'est le pas que le sujet évalue.

La question 5 mérite d'être regardée de près. Le sujet demande une lecture graphique, et la
réponse attendue est « à partir de `64` mois ». Mais la donnée est ici algébrique, les deux
fonctions étant données par des formules : l'inéquation `22 400 + 75x < 425x` se résout
exactement, et donne `x > 64`. C'est cette équivalence qui est démontrée, ce que le graphique
ne peut que suggérer — à la différence des lectures de courbe d'autres sujets, où la courbe
*est* la donnée.

## Ce que la décomposition donne à voir

Vingt-neuf questions : **vingt-trois** portent une proposition démontrée, **deux** une
proposition qui reste à écrire, **quatre** n'en portent pas.

Les quatre se répartissent en trois familles :

- **la figure** (question 2 du QCM) — les deux dessins sont l'énoncé ;
- **l'outil** (question 6 de l'exercice 4, question 3 de l'exercice 5) — écrire une
  instruction Scratch ou une formule de tableur relève d'un langage, non d'une démonstration ;
- **la modélisation** (question 4 de l'exercice 5) — traduire une situation en fonction est un
  pas qu'aucun théorème ne contient.

Les deux propositions non écrites sont d'une autre nature : elles demandent de comparer un
angle à `20°`, c'est-à-dire d'encadrer numériquement une fonction trigonométrique. Le sujet
le fait à la calculatrice ; ce dépôt ne le fait pas encore. C'est le seul endroit du brevet
2025 où l'obstacle est de notre côté, et non du côté de l'épreuve.
