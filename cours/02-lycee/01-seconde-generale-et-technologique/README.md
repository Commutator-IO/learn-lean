# Seconde générale et technologique

*Programme du lycée (filière S)* — énoncés tirés de [lycee.md](../../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Algorithmique et programmation — Variables et instructions élémentaires

Fichier : `AlgorithmiqueEtProgrammationVariablesEtInstructionsElementaires.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Variables informatiques de type entier, booléen, flottant, chaine de caractères | 2de | `variables_informatiques_de_type_entier_booleen_flottant_chaine` | ☐ |
| Affectation (notée ← en langage naturel) | 2de | `affectation_notee_en_langage_naturel` | ☐ |
| Séquence d’instructions | 2de | `sequence_dinstructions` | ☐ |
| Instruction conditionnelle | 2de | `instruction_conditionnelle` | ☐ |
| Boucle bornée (for), boucle non bornée (while) | 2de | `boucle_bornee_for_boucle_non_bornee_while` | ☐ |

## Algorithmique et programmation — Notion de fonction

Fichier : `AlgorithmiqueEtProgrammationNotionDeFonction.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Fonctions à un ou plusieurs arguments | 2de | `fonctions_a_un_ou_plusieurs_arguments` | ☐ |
| Fonction renvoyant un nombre aléatoire. Série statistique obtenue par la répétition de l’appel d’une telle fonction | 2de | `fonction_renvoyant_un_nombre_aleatoire_serie_statistique_obtenue` | ☐ |

## Nombres et calculs, algèbre — Arithmétique

Fichier : `NombresEtCalculsAlgebreArithmetique.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Notations ℕ et ℤ | 2de | `notations_n_et_z` | ☐ |
| Définition des notions de multiple, de diviseur, de nombre pair, de nombre impair : a est multiple de b s’il existe un entier k tel que a = kb | 2de | `definition_des_notions_de_multiple_de_diviseur_de` | ☐ |
| Pour une valeur numérique de a, la somme de deux multiples de a est multiple de a **(démonstration exigible)** | 2de | `pour_une_valeur_numerique_de_a_la_somme` | ☐ |
| Le carré d’un nombre impair est impair **(démonstration exigible)** | 2de | `le_carre_dun_nombre_impair_est_impair_demonstration` | ☐ |

## Nombres et calculs, algèbre — Nombres réels

Fichier : `NombresEtCalculsAlgebreNombresReels.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Ensemble ℝ des nombres réels, droite numérique | 2de | `ensemble_r_des_nombres_reels_droite_numerique` | ☐ |
| Intervalles de ℝ. Représentation graphique, notations du type [a, +∞[, ] –∞, a], [a, b], etc | 2de | `intervalles_de_r_representation_graphique_notations_du_type` | ☐ |
| Notation en valeur absolue \|a\| pour la distance de a à 0. Distance entre deux nombres réels | 2de | `notation_en_valeur_absolue_a_pour_la_distance` | ☐ |
| Inéquation du type \|𝑥 – a\| ⩽ r. Représentation graphique des solutions, intervalle [a – r, a + r] | 2de | `inequation_du_type_x_a_r_representation_graphique` | ☐ |
| Ensemble 𝔻 des nombres décimaux. Encadrement décimal d’un nombre réel à 10–𝑛 près | 2de | `ensemble_d_des_nombres_decimaux_encadrement_decimal_dun` | ☐ |
| Ensemble ℚ des nombres rationnels. Nombres irrationnels ; exemples fournis par la géométrie, par exemple √2 et π | 2de | `ensemble_q_des_nombres_rationnels_nombres_irrationnels_exemples` | ☐ |
| Le nombre rationnel n’est pas décimal. 3 **(démonstration exigible)** | 2de | `le_nombre_rationnel_nest_pas_decimal_3_demonstration` | ☐ |
| Le nombre réel √2 est irrationnel **(démonstration exigible)** | 2de | `le_nombre_reel_2_est_irrationnel_demonstration_exigible` | ☐ |

## Nombres et calculs, algèbre — Algèbre

Fichier : `NombresEtCalculsAlgebreAlgebre.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Règles de calcul sur les puissances entières relatives, sur les racines carrées. Relation √a2 = \|a\| | 2de | `regles_de_calcul_sur_les_puissances_entieres_relatives` | ☐ |
| Exemples simples de calcul sur des expressions algébriques, en particulier sur des expressions fractionnaires | 2de | `exemples_simples_de_calcul_sur_des_expressions_algebriques` | ☐ |
| Somme d’inégalités. Produit d’une inégalité par un réel positif, négatif, en liaison avec le sens de variation d’une fonction affine | 2de | `somme_dinegalites_produit_dune_inegalite_par_un_reel` | ☐ |
| Comparaison additive (par différence), comparaison multiplicative (par rapport, pour deux nombres strictement positifs) | 2de | `comparaison_additive_par_difference_comparaison_multiplicative_par_rapport` | ☐ |
| Ensemble des solutions des équations du type a𝑥 + b = 0, et des inéquations de la forme a𝑥 + b > 0 | 2de | `ensemble_des_solutions_des_equations_du_type_ax` | ☐ |
| Équation de la forme A(𝑥)B(𝑥) = 0 (équation produit nul). A(𝑥) | 2de | `equation_de_la_forme_a_x_b_x` | ☐ |
| En liaison avec la section « Fonctions », étude du signe des expressions de la forme A(𝑥)B(𝑥) et . B(𝑥) A(𝑥) | 2de | `en_liaison_avec_la_section_fonctions_etude_du` | ☐ |
| Équation = k (équation quotient) en lien avec l’ensemble de définition d’une expression. B(𝑥) | 2de | `equation_k_equation_quotient_en_lien_avec_lensemble` | ☐ |
| Quels que soient les réels positifs a et b, on a √ab = √a √b **(démonstration exigible)** | 2de | `quels_que_soient_les_reels_positifs_a_et` | ☐ |

## Géométrie — Vecteurs et problèmes de géométrie

Fichier : `GeometrieVecteursEtProblemesDeGeometrie.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Égalité de deux vecteurs. Notation ⃗𝑢. Vecteur nul | 2de | `egalite_de_deux_vecteurs_notation_u_vecteur_nul` | ☐ |
| Représentants d’un vecteur | 2de | `representants_dun_vecteur` | ☐ |
| Produit d’un vecteur par un nombre réel. Colinéarité de deux vecteurs | 2de | `produit_dun_vecteur_par_un_nombre_reel_colinearite` | ☐ |
| Représentation d’un vecteur comme combinaison de deux vecteurs non colinéaires | 2de | `representation_dun_vecteur_comme_combinaison_de_deux_vecteurs` | ☐ |
| Base orthonormée. Coordonnées d’un vecteur. Expression de la norme d’un vecteur | 2de | `base_orthonormee_coordonnees_dun_vecteur_expression_de_la` | ☐ |
| Expression des coordonnées de ⃗⃗⃗⃗⃗ AB en fonction de celles de A et de B | 2de | `expression_des_coordonnees_de_ab_en_fonction_de` | ☐ |
| Déterminant de deux vecteurs dans une base orthonormée, critère de colinéarité. Application à l’alignement, au parallélisme | 2de | `determinant_de_deux_vecteurs_dans_une_base_orthonormee` | ☐ |
| Caractérisation vectorielle du milieu d’un segment | 2de | `caracterisation_vectorielle_du_milieu_dun_segment` | ☐ |

## Géométrie — Droites du plan

Fichier : `GeometrieDroitesDuPlan.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Vecteur directeur d’une droite | 2de | `vecteur_directeur_dune_droite` | ☐ |
| Équation de droite : équation cartésienne, équation réduite | 2de | `equation_de_droite_equation_cartesienne_equation_reduite` | ☐ |
| Pente (ou coefficient directeur) d’une droite non parallèle à l’axe des ordonnées | 2de | `pente_ou_coefficient_directeur_dune_droite_non_parallele` | ☐ |

## Fonctions — Représentation algébrique et graphique des fonctions

Fichier : `FonctionsRepresentationAlgebriqueEtGraphiqueDesFonctions.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Fonction à valeurs réelles définie sur un intervalle ou une réunion finie d’intervalles de ℝ | 2de | `fonction_a_valeurs_reelles_definie_sur_un_intervalle` | ☐ |
| Recherche de domaine d’étude (ensemble de définition) | 2de | `recherche_de_domaine_detude_ensemble_de_definition` | ☐ |
| Courbe représentative : la courbe d’équation 𝑦 = ƒ (𝑥) est l’ensemble des points du plan dont les coordonnées (𝑥, 𝑦) vérifient 𝑦 = ƒ (𝑥) | 2de | `courbe_representative_la_courbe_dequation_y_x_est` | ☐ |
| Signe d’une fonction affine et des fonctions de référence | 2de | `signe_dune_fonction_affine_et_des_fonctions_de` | ☐ |
| Tableau de signes pour une fonction produit ou quotient | 2de | `tableau_de_signes_pour_une_fonction_produit_ou` | ☐ |

## Fonctions — Variations et extrémums d’une fonction

Fichier : `FonctionsVariationsEtExtremumsDuneFonction.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Croissance, décroissance, monotonie d’une fonction définie sur un intervalle. Tableau de variations | 2de | `croissance_decroissance_monotonie_dune_fonction_definie_sur_un` | ☐ |
| Maximum, minimum d’une fonction sur un intervalle | 2de | `maximum_minimum_dune_fonction_sur_un_intervalle` | ☐ |
| Pour une fonction affine donnée par ƒ (𝑥) = m𝑥 + p, interprétation de m comme taux d’accroissement et de p comme ordonnée à l’origine | 2de | `pour_une_fonction_affine_donnee_par_x_mx` | ☐ |
| Variations d’une fonction affine selon le signe du coefficient directeur | 2de | `variations_dune_fonction_affine_selon_le_signe_du` | ☐ |
| Variations des fonctions affines **(démonstration exigible)** | 2de | `variations_des_fonctions_affines_demonstration_exigible` | ☐ |
| Position relative des courbes d’équation 𝑦 = 𝑥, 𝑦 = 𝑥², pour 𝑥 ⩾ 0 **(démonstration exigible)** | 2de | `position_relative_des_courbes_dequation_y_x_y` | ☐ |
| Variations des fonctions carré, inverse **(démonstration exigible)** | 2de | `variations_des_fonctions_carre_inverse_demonstration_exigible` | ☐ |

## Statistiques et probabilités — Information chiffrée et statistique descriptive

Fichier : `StatistiquesEtProbabilitesInformationChiffreeEtStatistiqueDescriptive.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Proportions | 2de | `proportions` | ☐ |
| Ensembles de référence inclus les uns dans les autres : pourcentage de pourcentage | 2de | `ensembles_de_reference_inclus_les_uns_dans_les` | ☐ |
| Évolution V2 | 2de | `evolution_v2` | ☐ |
| Évolution : variation absolue (variation additive) V2 – V1, coefficient multiplicateur (variation multiplicative) , variation V1 V2 – V1 relative (taux d’évolution). V1 | 2de | `evolution_variation_absolue_variation_additive_v2_v1_coefficient` | ☐ |
| Évolutions successives, évolution réciproque : relation sur les coefficients multiplicateurs (produit, inverse) | 2de | `evolutions_successives_evolution_reciproque_relation_sur_les_coefficients` | ☐ |
| Statistiques à une variable | 2de | `statistiques_a_une_variable` | ☐ |
| Linéarité de la moyenne | 2de | `linearite_de_la_moyenne` | ☐ |
| Indicateurs de dispersion : écart type | 2de | `indicateurs_de_dispersion_ecart_type` | ☐ |
| Influence sur la moyenne, la médiane de l’ajout ou de la suppression d’une valeur dans la série | 2de | `influence_sur_la_moyenne_la_mediane_de_lajout` | ☐ |
| Regroupement par classes de même amplitude d’une série statistique continue | 2de | `regroupement_par_classes_de_meme_amplitude_dune_serie` | ☐ |
| Représentation graphique : histogramme, polygone des fréquences cumulées | 2de | `representation_graphique_histogramme_polygone_des_frequences_cumulees` | ☐ |
| Calcul de la moyenne à partir de la moyenne et des effectifs de chaque classe (moyenne pondérée) ; cas particulier où la répartition est uniforme dans chaque classe (donc égale au centre de la classe) | 2de | `calcul_de_la_moyenne_a_partir_de_la` | ☐ |
| Détermination de la classe médiane à partir des effectifs des classes ; estimation de la médiane dans le cas de répartition uniforme dans la classe médiane | 2de | `determination_de_la_classe_mediane_a_partir_des` | ☐ |

## Statistiques et probabilités — Croisement de deux variables qualitatives

Fichier : `StatistiquesEtProbabilitesCroisementDeDeuxVariablesQualitatives.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Tableau croisé d’effectifs | 2de | `tableau_croise_deffectifs` | ☐ |
| Fréquence conditionnelle, fréquence marginale | 2de | `frequence_conditionnelle_frequence_marginale` | ☐ |

## Statistiques et probabilités — Probabilités

Fichier : `StatistiquesEtProbabilitesProbabilites.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Version vulgarisée de la loi des grands nombres : « Lorsque n est grand, sauf exception, la fréquence observée est proche de la probabilité. » | 2de | `version_vulgarisee_de_la_loi_des_grands_nombres` | ☐ |
| Probabilité conditionnelle d’un évènement B sachant un évènement A de probabilité non nulle. Notation PA(B) | 2de | `probabilite_conditionnelle_dun_evenement_b_sachant_un_evenement` | ☐ |
| Arbres de probabilité, application au calcul de probabilités | 2de | `arbres_de_probabilite_application_au_calcul_de_probabilites` | ☐ |
