# Informatique

*Programme du lycée — spécialité NSI* — énoncés tirés de [lycee.md](../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Représentation des données

Fichier : `RepresentationDesDonnees.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Algèbre de Boole : lois de De Morgan, distributivité, `¬¬a = a` | 1NSI | `algebre_de_boole_lois_de_de_morgan_distributivite` | ☐ |
| Écriture binaire d'un entier naturel : existence et unicité | 1NSI | `ecriture_binaire_d_un_entier_naturel_existence_et` | ☐ |
| Valeur d'une écriture binaire : `∑ bᵢ 2ⁱ` ; passage binaire ↔ décimal | 1NSI | `valeur_d_une_ecriture_binaire_passage_binaire_decimal` | ☐ |
| Nombre de bits d'un entier `n > 0` : `⌊log₂ n⌋ + 1` | 1NSI | `nombre_de_bits_d_un_entier` | ☐ |
| Complément à deux sur `n` bits : les entiers de `−2ⁿ⁻¹` à `2ⁿ⁻¹ − 1`, et l'addition modulo `2ⁿ` | 1NSI | `complement_a_deux_sur_bits_les_entiers_de` | ☐ |
| Écriture hexadécimale ; un chiffre hexadécimal vaut quatre bits | 1NSI | `ecriture_hexadecimale_un_chiffre_hexadecimal_vaut_quatre_bits` | ☐ |
| Nombres à virgule flottante : `1/10` n'a pas d'écriture binaire finie, d'où `0,1 + 0,2 ≠ 0,3` | 1NSI | `nombres_a_virgule_flottante_n_a_pas_d` | ☐ |
| Chaînes de caractères : la concaténation est associative, sa longueur est la somme des longueurs | 1NSI | `chaines_de_caracteres_la_concatenation_est_associative_sa` | ☐ |

## Algorithmes sur les tableaux

Fichier : `AlgorithmesSurLesTableaux.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Recherche séquentielle : le résultat est un indice de la valeur cherchée, ou l'absence de la valeur | 1NSI | `recherche_sequentielle_le_resultat_est_un_indice_de` | ☐ |
| Coût de la recherche séquentielle : `n` comparaisons au pire, et ce pire est atteint | 1NSI | `cout_de_la_recherche_sequentielle_comparaisons_au_pire` | ☐ |
| Maximum d'un tableau non vide : le résultat appartient au tableau et majore tous ses éléments | 1NSI | `maximum_d_un_tableau_non_vide_le_resultat` | ☐ |
| Recherche dichotomique dans un tableau trié : correction | 1NSI | `recherche_dichotomique_dans_un_tableau_trie_correction` | ☐ |
| Coût de la recherche dichotomique : `⌊log₂ n⌋ + 1` comparaisons au pire | 1NSI | `cout_de_la_recherche_dichotomique_comparaisons_au_pire` | ☐ |
| Tri par insertion : le résultat est trié et c'est une permutation de l'entrée | 1NSI | `tri_par_insertion_le_resultat_est_trie_et` | ☐ |
| Tri par sélection : même énoncé de correction | 1NSI | `tri_par_selection_meme_enonce_de_correction` | ☐ |
| Coût quadratique des tris par insertion et par sélection ; `n(n−1)/2` comparaisons au pire | 1NSI | `cout_quadratique_des_tris_par_insertion_et_par` | ☐ |
| Tri fusion : correction, et coût en `n log n` | TNSI | `tri_fusion_correction_et_cout_en` | ☐ |
| Un tri par comparaisons demande au moins `log₂(n!)` comparaisons | TNSI | `un_tri_par_comparaisons_demande_au_moins_comparaisons` | ☐ |

## Récursivité et diviser pour régner

Fichier : `RecursiviteEtDiviserPourRegner.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Factorielle récursive : la fonction calcule bien `n!` et termine | TNSI | `factorielle_recursive_la_fonction_calcule_bien_et_termine` | ☐ |
| Suite de Fibonacci : les versions récursive et itérative calculent la même valeur | TNSI | `suite_de_fibonacci_les_versions_recursive_et_iterative` | ☐ |
| Coût exponentiel de Fibonacci récursif naïf, linéaire de la version itérative | TNSI | `cout_exponentiel_de_fibonacci_recursif_naif_lineaire_de` | ☐ |
| Exponentiation rapide : `aⁿ` en `⌊log₂ n⌋ + 1` élévations au carré au plus | TNSI | `exponentiation_rapide_en_elevations_au_carre_au_plus` | ☐ |
| Tours de Hanoï : `2ⁿ − 1` déplacements, et aucune solution n'en demande moins | TNSI | `tours_de_hanoi_deplacements_et_aucune_solution_n` | ☐ |
| Diviser pour régner : le coût `T(n) = 2T(n/2) + n` vaut `n log₂ n` | TNSI | `diviser_pour_regner_le_cout_vaut` | ☐ |

## Structures de données

Fichier : `StructuresDeDonnees.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Pile : dépiler après avoir empilé rend l'état initial (dernier entré, premier sorti) | TNSI | `pile_depiler_apres_avoir_empile_rend_l_etat` | ☐ |
| File : le premier entré est le premier sorti | TNSI | `file_le_premier_entre_est_le_premier_sorti` | ☐ |
| File par deux piles : le comportement est celui d'une file | TNSI | `file_par_deux_piles_le_comportement_est_celui` | ☐ |
| Liste chaînée : longueur d'une concaténation, parcours complet | TNSI | `liste_chainee_longueur_d_une_concatenation_parcours_complet` | ☐ |
| Arbre binaire de hauteur `h` : au plus `2ʰ⁺¹ − 1` nœuds, donc hauteur `≥ log₂(n+1)` | TNSI | `arbre_binaire_de_hauteur_au_plus_nuds_donc` | ☐ |
| Arbre binaire strict : le nombre de feuilles vaut le nombre de nœuds internes plus un | TNSI | `arbre_binaire_strict_le_nombre_de_feuilles_vaut` | ☐ |
| Arbre binaire de recherche : le parcours infixe donne les clés triées | TNSI | `arbre_binaire_de_recherche_le_parcours_infixe_donne` | ☐ |
| Recherche dans un arbre binaire de recherche : coût majoré par la hauteur | TNSI | `recherche_dans_un_arbre_binaire_de_recherche_cout` | ☐ |
| Graphe : un parcours en profondeur atteint exactement les sommets accessibles depuis l'origine | TNSI | `graphe_un_parcours_en_profondeur_atteint_exactement_les` | ☐ |
| Un arbre est un graphe connexe sans cycle ; il a `n − 1` arêtes | TNSI | `un_arbre_est_un_graphe_connexe_sans_cycle` | ☐ |
| Algorithme de Dijkstra : correction pour des poids positifs | TNSI | `algorithme_de_dijkstra_correction_pour_des_poids_positifs` | ☐ |

## Correction et terminaison des programmes

Fichier : `CorrectionEtTerminaisonDesProgrammes.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Invariant de boucle : une propriété vraie avant et conservée par le corps est vraie à la sortie | 1NSI | `invariant_de_boucle_une_propriete_vraie_avant_et` | ☐ |
| Variant de boucle : un entier naturel strictement décroissant force l'arrêt | 1NSI | `variant_de_boucle_un_entier_naturel_strictement_decroissant` | ☐ |
| Somme des `n` premiers entiers par accumulation : le programme calcule `n(n+1)/2` | 1NSI | `somme_des_premiers_entiers_par_accumulation_le_programme` | ☐ |
| Division euclidienne par soustractions successives : le programme rend quotient et reste | 1NSI | `division_euclidienne_par_soustractions_successives_le_programme_rend` | ☐ |
| Deux programmes de structures différentes calculent la même fonction | 1NSI | `deux_programmes_de_structures_differentes_calculent_la_meme` | ☐ |
| Indécidabilité du problème de l'arrêt | TNSI | `indecidabilite_du_probleme_de_l_arret` | ☐ |
