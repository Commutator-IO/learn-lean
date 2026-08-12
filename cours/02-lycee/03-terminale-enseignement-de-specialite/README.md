# Terminale — enseignement de spécialité

*Programme du lycée (filière S)* — énoncés tirés de [lycee.md](../../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Algèbre et géométrie — Combinatoire et dénombrement

Fichier : `AlgebreEtGeometrieCombinatoireEtDenombrement.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Principe additif : nombre d’éléments d’une réunion d’ensembles deux à deux disjoints | Tle | `principe_additif_nombre_delements_dune_reunion_densembles_deux` | ☐ |
| Principe multiplicatif : nombre d’éléments d’un produit cartésien. Nombre de k-uplets (ou k-listes) d’un ensemble à n éléments | Tle | `principe_multiplicatif_nombre_delements_dun_produit_cartesien_nombre` | ☐ |
| Nombre des parties d’un ensemble à n éléments. Lien avec les n-uplets de {0, 1}, les mots de longueur n sur un alphabet à deux éléments, les chemins dans un arbre, les issues dans une succession de n épreuves de Bernoulli | Tle | `nombre_des_parties_dun_ensemble_a_n_elements` | ☐ |
| Nombre des k-uplets d’éléments distincts d’un ensemble à n éléments. Définition de n! Nombre de permutations d’un ensemble fini à n éléments | Tle | `nombre_des_k_uplets_delements_distincts_dun_ensemble` | ☐ |
| Combinaisons de k éléments d’un ensemble à n éléments : parties à k éléments de l’ensemble. Représentation en termes de mots ou de chemins. n n(n – 1)…(n – k + 1) n! | Tle | `combinaisons_de_k_elements_dun_ensemble_a_n` | ☐ |
| Pour 0 ⩽ k ⩽ n, formules : formules : ( ) = = (n . k k! – k)! k! | Tle | `pour_0_k_n_formules_formules_n_k` | ☐ |
| Explicitation pour k = 0, 1, 2. Symétrie. Relation et triangle de Pascal | Tle | `explicitation_pour_k_0_1_2_symetrie_relation` | ☐ |
| Démonstration par dénombrement de la relation : ∑nk = 0 ( ) = 2n . k **(démonstration exigible)** | Tle | `demonstration_par_denombrement_de_la_relation_nk_0` | ☐ |
| Démonstrations de la relation de Pascal (par le calcul, par une méthode combinatoire) **(démonstration exigible)** | Tle | `demonstrations_de_la_relation_de_pascal_par_le` | ☐ |
| Approfondissement possible **(démonstration exigible)** | Tle | `approfondissement_possible_demonstration_exigible` | ☐ |
| Combinaisons avec répétitions **(démonstration exigible)** | Tle | `combinaisons_avec_repetitions_demonstration_exigible` | ☐ |

## Algèbre et géométrie — Manipulation des vecteurs, des droites et des plans de l’espace

Fichier : `AlgebreEtGeometrieManipulationDesVecteursDesDroitesEtDesPlansDeLespa.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Vecteurs de l’espace. Translations | Tle | `vecteurs_de_lespace_translations` | ☐ |
| Combinaisons linéaires de vecteurs de l’espace | Tle | `combinaisons_lineaires_de_vecteurs_de_lespace` | ☐ |
| Droites de l’espace. Vecteurs directeurs d’une droite. Vecteurs colinéaires | Tle | `droites_de_lespace_vecteurs_directeurs_dune_droite_vecteurs` | ☐ |
| Caractérisation d’une droite par un point et un vecteur directeur | Tle | `caracterisation_dune_droite_par_un_point_et_un` | ☐ |
| Plans de l’espace. Direction d’un plan de l’espace | Tle | `plans_de_lespace_direction_dun_plan_de_lespace` | ☐ |
| Caractérisation d’un plan de l’espace par un point et un couple de vecteurs non colinéaires | Tle | `caracterisation_dun_plan_de_lespace_par_un_point` | ☐ |
| Bases et repères de l’espace. Décomposition d’un vecteur sur une base | Tle | `bases_et_reperes_de_lespace_decomposition_dun_vecteur` | ☐ |

## Algèbre et géométrie — Orthogonalité et distances dans l’espace

Fichier : `AlgebreEtGeometrieOrthogonaliteEtDistancesDansLespace.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Produit scalaire de deux vecteurs de l’espace. Bilinéarité, symétrie | Tle | `produit_scalaire_de_deux_vecteurs_de_lespace_bilinearite` | ☐ |
| Orthogonalité de deux vecteurs. Caractérisation par le produit scalaire | Tle | `orthogonalite_de_deux_vecteurs_caracterisation_par_le_produit` | ☐ |
| Base orthonormée, repère orthonormé | Tle | `base_orthonormee_repere_orthonorme` | ☐ |
| Coordonnées d’un vecteur dans une base orthonormée. Expressions du produit scalaire et de la norme. Expression de la distance entre deux points | Tle | `coordonnees_dun_vecteur_dans_une_base_orthonormee_expressions` | ☐ |
| Développement de ‖𝑢 ⃗ + 𝑣‖2 , formules de polarisation | Tle | `developpement_de_u_v2_formules_de_polarisation` | ☐ |
| Orthogonalité de deux droites, d’un plan et d’une droite | Tle | `orthogonalite_de_deux_droites_dun_plan_et_dune` | ☐ |
| Vecteur normal à un plan. Étant donnés un point A et un vecteur non nul ⃗n, plan passant par A et normal à ⃗n | Tle | `vecteur_normal_a_un_plan_etant_donnes_un` | ☐ |
| Projeté orthogonal d’un point sur une droite, sur un plan | Tle | `projete_orthogonal_dun_point_sur_une_droite_sur` | ☐ |
| Plans perpendiculaires. Caractérisation par des vecteurs normaux | Tle | `plans_perpendiculaires_caracterisation_par_des_vecteurs_normaux` | ☐ |

## Algèbre et géométrie — Représentations paramétriques et équations cartésiennes

Fichier : `AlgebreEtGeometrieRepresentationsParametriquesEtEquationsCartesiennes.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Représentation paramétrique d’une droite | Tle | `representation_parametrique_dune_droite` | ☐ |
| Équation cartésienne d’un plan | Tle | `equation_cartesienne_dun_plan` | ☐ |

## Analyse — Suites

Fichier : `AnalyseSuites.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| La suite (𝑢𝑛) tend vers + ∞ si tout intervalle de la forme [A ; +∞[ contient toutes les valeurs un à partir d'un certain rang. Cas des suites croissantes non majorées. Suite tendant vers – ∞ | Tle | `la_suite_un_tend_vers_si_tout_intervalle` | ☐ |
| La suite (𝑢𝑛) converge vers le nombre réel 𝓁 si tout intervalle ouvert contenant 𝓁 contient toutes les valeurs 𝑢𝑛 à partir d'un certain rang | Tle | `la_suite_un_converge_vers_le_nombre_reel` | ☐ |
| Limites et comparaison. Théorèmes des gendarmes | Tle | `limites_et_comparaison_theoremes_des_gendarmes` | ☐ |
| Opérations sur les limites | Tle | `operations_sur_les_limites` | ☐ |
| Comportement d’une suite géométrique (q n) où q est un nombre réel | Tle | `comportement_dune_suite_geometrique_q_n_ou_q` | ☐ |
| Théorème admis : toute suite croissante majorée (ou décroissante minorée) converge | Tle | `theoreme_admis_toute_suite_croissante_majoree_ou_decroissante` | ☐ |
| Toute suite croissante non majorée tend vers + ∞ **(démonstration exigible)** | Tle | `toute_suite_croissante_non_majoree_tend_vers_demonstration` | ☐ |
| Limite de (q n), après démonstration par récurrence de l’inégalité de Bernoulli **(démonstration exigible)** | Tle | `limite_de_q_n_apres_demonstration_par_recurrence` | ☐ |
| Divergence vers + ∞ d’une suite minorée par une suite divergeant vers + ∞ **(démonstration exigible)** | Tle | `divergence_vers_dune_suite_minoree_par_une_suite` | ☐ |
| Limite en + ∞ et en – ∞ de la fonction exponentielle **(démonstration exigible)** | Tle | `limite_en_et_en_de_la_fonction_exponentielle` | ☐ |

## Analyse — Limites des fonctions

Fichier : `AnalyseLimitesDesFonctions.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Limite finie ou infinie d'une fonction en + ∞, en – ∞, en un point. Asymptote parallèle à un axe de coordonnées | Tle | `limite_finie_ou_infinie_d_une_fonction_en` | ☐ |
| Limites faisant intervenir les fonctions de référence étudiées en classe de première : puissances entières, racine carrée, fonction exponentielle | Tle | `limites_faisant_intervenir_les_fonctions_de_reference_etudiees` | ☐ |
| Limites et comparaison | Tle | `limites_et_comparaison` | ☐ |
| Opérations sur les limites | Tle | `operations_sur_les_limites` | ☐ |

## Analyse — Compléments sur la dérivation

Fichier : `AnalyseComplementsSurLaDerivation.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Composée de deux fonctions, notation v ○ u. Relation (v ○ u)’ = (v’ ○ u) × u’ pour la dérivée de la composée de deux fonctions dérivables | Tle | `composee_de_deux_fonctions_notation_v_u_relation` | ☐ |
| Dérivée seconde d’une fonction | Tle | `derivee_seconde_dune_fonction` | ☐ |
| Fonction convexe sur un intervalle : définition par la position relative de la courbe représentative et des sécantes. Pour une fonction deux fois dérivable, équivalence admise avec la position par rapport aux tangentes, la croissance de 𝑓 ’, la positivité de 𝑓 ’’ | Tle | `fonction_convexe_sur_un_intervalle_definition_par_la` | ☐ |
| Point d’inflexion | Tle | `point_dinflexion` | ☐ |

## Analyse — Continuité des fonctions d’une variable réelle

Fichier : `AnalyseContinuiteDesFonctionsDuneVariableReelle.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Fonction continue en un point (définition par les limites), sur un intervalle. Toute fonction dérivable est continue | Tle | `fonction_continue_en_un_point_definition_par_les` | ☐ |
| Image d’une suite convergente par une fonction continue | Tle | `image_dune_suite_convergente_par_une_fonction_continue` | ☐ |
| Théorème des valeurs intermédiaires. Cas des fonctions continues strictement monotones | Tle | `theoreme_des_valeurs_intermediaires_cas_des_fonctions_continues` | ☐ |

## Analyse — Fonction logarithme

Fichier : `AnalyseFonctionLogarithme.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Fonction logarithme népérien, notée ln, construite comme réciproque de la fonction exponentielle | Tle | `fonction_logarithme_neperien_notee_ln_construite_comme_reciproque` | ☐ |
| Propriétés algébriques du logarithme | Tle | `proprietes_algebriques_du_logarithme` | ☐ |
| Fonction dérivée du logarithme, variations | Tle | `fonction_derivee_du_logarithme_variations` | ☐ |
| Limites en 0 et en + ∞, courbe représentative. Lien entre les courbes représentatives des fonctions logarithme népérien et exponentielle | Tle | `limites_en_0_et_en_courbe_representative_lien` | ☐ |
| Croissance comparée du logarithme népérien et de 𝑥 ↦ 𝑥 𝑛 en 0 et en + ∞ | Tle | `croissance_comparee_du_logarithme_neperien_et_de_x` | ☐ |

## Analyse — Fonctions sinus et cosinus

Fichier : `AnalyseFonctionsSinusEtCosinus.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Fonctions trigonométriques sinus et cosinus. Parité, périodicité. Courbes représentatives | Tle | `fonctions_trigonometriques_sinus_et_cosinus_parite_periodicite_courbes` | ☐ |
| Dérivées, variations | Tle | `derivees_variations` | ☐ |

## Analyse — Primitives, équations différentielles

Fichier : `AnalysePrimitivesEquationsDifferentielles.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Équation différentielle 𝑦’ = 𝑓 . Notion de primitive d’une fonction continue sur un intervalle. Deux primitives d’une même fonction continue sur un intervalle diffèrent d’une constante. 1 **(démonstration exigible)** | Tle | `equation_differentielle_y_f_notion_de_primitive_dune` | ☐ |
| Primitives des fonctions de référence : 𝑥 ↦ 𝑥 𝑛 pour 𝑛 ∈ ℤ, 𝑥 ↦ , exponentielle, sinus, cosinus. √𝑥 | Tle | `primitives_des_fonctions_de_reference_x_x_n` | ☐ |
| Équation différentielle 𝑦’ = a𝑦, où a est un nombre réel ; allure des courbes. Équation différentielle 𝑦’ = a𝑦 + b | Tle | `equation_differentielle_y_ay_ou_a_est_un` | ☐ |
| Résolution de l’équation différentielle 𝑦’ = a𝑦 où a est un nombre réel **(démonstration exigible)** | Tle | `resolution_de_lequation_differentielle_y_ay_ou_a` | ☐ |

## Analyse — Calcul intégral

Fichier : `AnalyseCalculIntegral.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Définition de l’intégrale d'une fonction continue positive définie sur un segment [a,b], comme aire sous la courbe b représentative de ƒ. Notation ∫a ƒ(𝑥)d𝑥 . x | Tle | `definition_de_lintegrale_d_une_fonction_continue_positive` | ☐ |
| Théorème : si ƒ est une fonction continue positive sur [a,b], alors la fonction 𝐹a définie sur [a,b] par 𝐹a (𝑥) = ∫a ƒ(t )dt est la primitive de ƒ qui s’annule en a. b | Tle | `theoreme_si_est_une_fonction_continue_positive_sur` | ☐ |
| Sous les hypothèses du théorème, relation ∫a ƒ(𝑥)𝑑𝑥 = 𝐹(b) − 𝐹(a) où 𝐹 est une primitive quelconque de ƒ. Notation [𝐹(𝑥)]ba | Tle | `sous_les_hypotheses_du_theoreme_relation_a_x` | ☐ |
| Théorème : toute fonction continue sur un intervalle admet des primitives. b | Tle | `theoreme_toute_fonction_continue_sur_un_intervalle_admet` | ☐ |
| Définition par les primitives de∫a ƒ(𝑥)d𝑥 lorsque ƒ est une fonction continue de signe quelconque sur un intervalle contenant a et b | Tle | `definition_par_les_primitives_dea_x_dx_lorsque` | ☐ |
| Linéarité, positivité et intégration des inégalités. Relation de Chasles | Tle | `linearite_positivite_et_integration_des_inegalites_relation_de` | ☐ |
| Valeur moyenne d’une fonction | Tle | `valeur_moyenne_dune_fonction` | ☐ |
| Intégration par parties **(démonstration exigible)** | Tle | `integration_par_parties_demonstration_exigible` | ☐ |
| Pour une fonction positive croissante ƒ sur [a,b], la fonction 𝑥 ↦ ∫a ƒ(t )dt est une primitive de ƒ. Pour toute primitive F de ƒ, b relation ∫a ƒ(𝑥)d𝑥 = F(b) - F(a) **(démonstration exigible)** | Tle | `pour_une_fonction_positive_croissante_sur_a_b` | ☐ |

## Probabilités — Succession d’épreuves indépendantes, schéma de Bernoulli

Fichier : `ProbabilitesSuccessionDepreuvesIndependantesSchemaDeBernoulli.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Modèle de la succession d’épreuves indépendantes : la probabilité d’une issue (x1, …, xn) est égale au produit des probabilités des composantes xi. Représentation par un produit cartésien, par un arbre | Tle | `modele_de_la_succession_depreuves_independantes_la_probabilite` | ☐ |
| Épreuve de Bernoulli, loi de Bernoulli | Tle | `epreuve_de_bernoulli_loi_de_bernoulli` | ☐ |
| Schéma de Bernoulli : répétition de n épreuves de Bernoulli indépendantes | Tle | `schema_de_bernoulli_repetition_de_n_epreuves_de` | ☐ |
| Loi binomiale ℬ(n,p) : loi du nombre de succès. Expression à l’aide des coefficients binomiaux | Tle | `loi_binomiale_b_n_p_loi_du_nombre` | ☐ |

## Probabilités — Sommes de variables aléatoires

Fichier : `ProbabilitesSommesDeVariablesAleatoires.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Somme de deux variables aléatoires. Linéarité de l'espérance : E(X + Y) = E(X) + E(Y) et E(aX) = aE(X) | Tle | `somme_de_deux_variables_aleatoires_linearite_de_l` | ☐ |
| Dans le cadre de la succession d’épreuves indépendantes, exemples de variables indépendantes X, Y et relation d’additivité V(X + Y) = V(X) + V(Y). Relation V(aX) = a²V(X) | Tle | `dans_le_cadre_de_la_succession_depreuves_independantes` | ☐ |
| Application à l’espérance, la variance et l’écart type de la loi binomiale | Tle | `application_a_lesperance_la_variance_et_lecart_type` | ☐ |
| Échantillon de taille n d’une loi de probabilité : liste (X1, … , Xn) de variables indépendantes identiques suivant cette loi. Sn Espérance, variance, écart type de la somme Sn = X1 + … + Xn et de la moyenne Mn = . n | Tle | `echantillon_de_taille_n_dune_loi_de_probabilite` | ☐ |
| Espérance et variance de la loi binomiale **(démonstration exigible)** | Tle | `esperance_et_variance_de_la_loi_binomiale_demonstration` | ☐ |

## Probabilités — Concentration, loi des grands nombres

Fichier : `ProbabilitesConcentrationLoiDesGrandsNombres.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Inégalité de Bienaymé-Tchebychev. Pour une variable aléatoire X d’espérance  et de variance V, et quel que soit le réel V(X) strictement positif  : P (│X – │ ⩾  ) ⩽ . 𝛿2 | Tle | `inegalite_de_bienayme_tchebychev_pour_une_variable_aleatoire` | ☐ |
| Inégalité de concentration. Si Mn est la variable aléatoire moyenne d’un échantillon de taille n d’une variable aléatoire 𝑉 d’espérance  et de variance V, alors pour tout  > 0, P (│Mn – │ ⩾  ) ⩽ n𝛿 2 | Tle | `inegalite_de_concentration_si_mn_est_la_variable` | ☐ |
| Loi des grands nombres | Tle | `loi_des_grands_nombres` | ☐ |
| Capacité attendue | Tle | `capacite_attendue` | ☐ |
| Appliquer l’inégalité de Bienaymé-Tchebychev pour définir une taille d’échantillon, en fonction de la précision et du risque choisi | Tle | `appliquer_linegalite_de_bienayme_tchebychev_pour_definir_une` | ☐ |
