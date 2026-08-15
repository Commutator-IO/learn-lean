# Informatique

*Programme du lycée — spécialité NSI* — énoncés tirés de [lycee.md](../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Trois énoncés portent leur modélisation dans leurs hypothèses plutôt que dans une
théorie qu'il faudrait d'abord construire : l'indécidabilité de l'arrêt, l'optimalité
des tours de Hanoï et la correction de Dijkstra. Ce que l'hypothèse recouvre est écrit
en toutes lettres dans la documentation de chacun — c'est un choix, pas un oubli.

## Représentation des données

Fichier : `RepresentationDesDonnees.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Algèbre de Boole : lois de De Morgan, distributivité, `¬¬a = a` | 1NSI | `de_morgan`, `distributivite_et_double_negation` | ☑ |
| Écriture binaire d'un entier naturel : existence et unicité | 1NSI | `ecriture_binaire_existence`, `ecriture_binaire_unicite` | ☑ |
| Valeur d'une écriture binaire : `∑ bᵢ 2ⁱ` ; passage binaire ↔ décimal | 1NSI | `valeur_d_une_ecriture_binaire` | ☑ |
| Nombre de bits d'un entier `n > 0` : `⌊log₂ n⌋ + 1` | 1NSI | `nombre_de_bits` | ☑ |
| Complément à deux sur `n` bits : les entiers de `−2ⁿ⁻¹` à `2ⁿ⁻¹ − 1`, et l'addition modulo `2ⁿ` | 1NSI | `complement_a_deux` | ☑ |
| Écriture hexadécimale ; un chiffre hexadécimal vaut quatre bits | 1NSI | `hexadecimal_vaut_quatre_bits` | ☑ |
| Nombres à virgule flottante : `1/10` n'a pas d'écriture binaire finie, d'où `0,1 + 0,2 ≠ 0,3` | 1NSI | `un_dixieme_n_est_pas_binaire` | ☑ |
| Chaînes de caractères : la concaténation est associative, sa longueur est la somme des longueurs | 1NSI | `concatenation` | ☑ |

## Algorithmes sur les tableaux

Fichier : `AlgorithmesSurLesTableaux.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Recherche séquentielle : le résultat est un indice de la valeur cherchée, ou l'absence de la valeur | 1NSI | `recherche_sequentielle_correcte` | ☑ |
| Coût de la recherche séquentielle : `n` comparaisons au pire, et ce pire est atteint | 1NSI | `cout_recherche_sequentielle` | ☑ |
| Maximum d'un tableau non vide : le résultat appartient au tableau et majore tous ses éléments | 1NSI | `maximum_d_un_tableau_non_vide` | ☑ |
| Recherche dichotomique dans un tableau trié : correction | 1NSI | `dichotomie_trouve`, `dichotomie_absent` | ☑ |
| Coût de la recherche dichotomique : `⌊log₂ n⌋ + 1` comparaisons au pire | 1NSI | `cout_recherche_dichotomique` | ☑ |
| Tri par insertion : le résultat est trié et c'est une permutation de l'entrée | 1NSI | `tri_par_insertion_correct` | ☑ |
| Tri par sélection : même énoncé de correction | 1NSI | `tri_par_selection_correct` | ☑ |
| Coût quadratique des tris par insertion et par sélection ; `n(n−1)/2` comparaisons au pire | 1NSI | `cout_quadratique_tri_par_insertion`, `cout_quadratique_atteint` | ☑ |
| Tri fusion : correction, et coût en `n log n` | TNSI | `tri_fusion_correct`, `cout_tri_fusion` | ☑ |
| Un tri par comparaisons demande au moins `log₂(n!)` comparaisons | TNSI | `borne_inferieure_tri_par_comparaisons` | ☑ |

## Récursivité et diviser pour régner

Fichier : `RecursiviteEtDiviserPourRegner.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Factorielle récursive : la fonction calcule bien `n!` et termine | TNSI | `factorielle_recursive` | ☑ |
| Suite de Fibonacci : les versions récursive et itérative calculent la même valeur | TNSI | `fibonacci_recursif_et_iteratif` | ☑ |
| Coût exponentiel de Fibonacci récursif naïf, linéaire de la version itérative | TNSI | `cout_fibonacci` | ☑ |
| Exponentiation rapide : `aⁿ` en `⌊log₂ n⌋ + 1` élévations au carré au plus | TNSI | `exponentiation_rapide_correcte`, `exponentiation_rapide_cout` | ☑ |
| Tours de Hanoï : `2ⁿ − 1` déplacements, et aucune solution n'en demande moins | TNSI | `tours_de_hanoi`, `tours_de_hanoi_optimal` | ☑ |
| Diviser pour régner : le coût `T(n) = 2T(n/2) + n` vaut `n log₂ n` | TNSI | `diviser_pour_regner` | ☑ |

## Structures de données

Fichier : `StructuresDeDonnees.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Pile : dépiler après avoir empilé rend l'état initial (dernier entré, premier sorti) | TNSI | `pile_dernier_entre_premier_sorti` | ☑ |
| File : le premier entré est le premier sorti | TNSI | `file_premier_entre_premier_sorti` | ☑ |
| File par deux piles : le comportement est celui d'une file | TNSI | `file_par_deux_piles` | ☑ |
| Liste chaînée : longueur d'une concaténation, parcours complet | TNSI | `liste_chainee` | ☑ |
| Arbre binaire de hauteur `h` : au plus `2ʰ − 1` nœuds, donc hauteur `≥ log₂(n+1)` | TNSI | `arbre_binaire_taille_majoree`, `arbre_binaire_hauteur_minoree` | ☑ |
| Arbre binaire strict : le nombre de feuilles vaut le nombre de nœuds internes plus un | TNSI | `arbre_strict_feuilles` | ☑ |
| Arbre binaire de recherche : le parcours infixe donne les clés triées | TNSI | `abr_parcours_infixe_trie` | ☑ |
| Recherche dans un arbre binaire de recherche : coût majoré par la hauteur | TNSI | `cout_recherche_abr` | ☑ |
| Graphe : un parcours en profondeur ne visite que des sommets accessibles | TNSI | `parcours_profondeur_correct` | ☑ |
| Graphe : un parcours en profondeur atteint tous les sommets accessibles | TNSI | `parcours_profondeur_complet` | ◐ |
| Un arbre enraciné à `n` nœuds a `n − 1` arêtes | TNSI | `arbre_aretes` | ☑ |
| Algorithme de Dijkstra : correction pour des poids positifs | TNSI | `poids_chemin_croissant`, `dijkstra_poids_positifs` | ☑ |

La hauteur est ici comptée en niveaux : l'arbre vide a la hauteur `0`, un arbre réduit
à un nœud la hauteur `1`. Avec la convention qui compte les arêtes, la majoration
s'écrit `2ʰ⁺¹ − 1`.

L'énoncé sur les arbres est démontré pour les arbres enracinés, qui sont ceux que
manipulent les programmes. La caractérisation « graphe connexe sans cycle » demande une
théorie des graphes que ce chapitre ne construit pas.

## Correction et terminaison des programmes

Fichier : `CorrectionEtTerminaisonDesProgrammes.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Invariant de boucle : une propriété vraie avant et conservée par le corps est vraie à la sortie | 1NSI | `invariant_de_boucle` | ☑ |
| Variant de boucle : un entier naturel strictement décroissant force l'arrêt | 1NSI | `variant_de_boucle` | ☑ |
| Somme des `n` premiers entiers par accumulation : le programme calcule `n(n+1)/2` | 1NSI | `somme_des_premiers_entiers_par_accumulation` | ☑ |
| Division euclidienne par soustractions successives : le programme rend quotient et reste | 1NSI | `division_euclidienne_par_soustractions` | ☑ |
| Deux programmes de structures différentes calculent la même fonction | 1NSI | `deux_programmes_calculent_la_meme_fonction` | ☑ |
| Indécidabilité du problème de l'arrêt | TNSI | `indecidabilite_du_probleme_de_l_arret` | ☑ |
