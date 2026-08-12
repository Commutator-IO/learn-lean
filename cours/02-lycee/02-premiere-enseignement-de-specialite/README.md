# Première — enseignement de spécialité

*Programme du lycée (filière S)* — énoncés tirés de [lycee.md](../../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Algèbre — Suites numériques, modèles discrets

Fichier : `AlgebreSuitesNumeriquesModelesDiscrets.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Exemples de modes de génération d’une suite : explicite 𝑢𝑛 = ƒ (𝑛), par une relation de récurrence 𝑢𝑛 + 1 = ƒ (𝑢𝑛), par un algorithme, par des motifs géométriques | 1re | `exemples_de_modes_de_generation_dune_suite_explicite` | ☐ |
| Notations : 𝑢(𝑛), 𝑢𝑛, (𝑢(𝑛)), (𝑢𝑛) | 1re | `notations_u_n_un_u_n_un` | ☐ |
| Suites arithmétiques : exemples, définition, calcul du terme général. Lien avec l’étude d’évolutions successives à accroissements constants. Lien avec les fonctions affines. Calcul de 1 + 2 + … + 𝑛 **(démonstration exigible)** | 1re | `suites_arithmetiques_exemples_definition_calcul_du_terme_general` | ☐ |
| Suites géométriques : exemples, définition, calcul du terme général. Lien avec l’étude d’évolutions successives à taux constant. Lien avec la fonction exponentielle. Calcul de 1 + 𝑞 + … + 𝑞𝑛 **(démonstration exigible)** | 1re | `suites_geometriques_exemples_definition_calcul_du_terme_general` | ☐ |
| Sens de variation d’une suite | 1re | `sens_de_variation_dune_suite` | ☐ |
| Sur des exemples, introduction intuitive de la notion de limite, finie ou infinie, ou l’absence de limite d’une suite | 1re | `sur_des_exemples_introduction_intuitive_de_la_notion` | ☐ |
| Calcul du terme général d’une suite arithmétique, d’une suite géométrique **(démonstration exigible)** | 1re | `calcul_du_terme_general_dune_suite_arithmetique_dune` | ☐ |

## Algèbre — Équations, fonctions polynômes du second degré

Fichier : `AlgebreEquationsFonctionsPolynomesDuSecondDegre.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Fonction polynôme du second degré donnée sous forme factorisée. Racines, signe, expression de la somme et du produit des racines | 1re | `fonction_polynome_du_second_degre_donnee_sous_forme` | ☐ |
| Forme canonique d’une fonction polynôme du second degré. Discriminant. Factorisation éventuelle. Résolution d’une équation du second degré. Signe | 1re | `forme_canonique_dune_fonction_polynome_du_second_degre` | ☐ |

## Analyse — Dérivation

Fichier : `AnalyseDerivation.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Point de vue local | 1re | `point_de_vue_local` | ☐ |
| Taux de variation. Sécantes à la courbe représentative d’une fonction en un point donné | 1re | `taux_de_variation_secantes_a_la_courbe_representative` | ☐ |
| Nombre dérivé d’une fonction en un point, comme limite du taux de variation. Notation ƒ ’(a) | 1re | `nombre_derive_dune_fonction_en_un_point_comme` | ☐ |
| Tangente à la courbe représentative d’une fonction en un point, comme « limite des sécantes ». Pente. Équation : la tangente à la courbe représentative de ƒ au point d’abscisse a est la droite d’équation 𝑦 = ƒ (a) + ƒ ‘(a)(𝑥 – a) | 1re | `tangente_a_la_courbe_representative_dune_fonction_en` | ☐ |
| Approximation linéaire : fonction affine tangente 𝑥 ↦ ƒ (a) + ƒ ‘(a)(𝑥 – a) et approximation de ƒ (a + h) par ƒ (a) + ƒ ‘(a)h | 1re | `approximation_lineaire_fonction_affine_tangente_x_a_a` | ☐ |
| Point de vue global | 1re | `point_de_vue_global` | ☐ |
| Fonction dérivable sur un intervalle. Fonction dérivée | 1re | `fonction_derivable_sur_un_intervalle_fonction_derivee` | ☐ |
| Fonction dérivée des fonctions carré, cube, inverse, racine carrée | 1re | `fonction_derivee_des_fonctions_carre_cube_inverse_racine` | ☐ |
| Opérations sur les fonctions dérivables : somme, produit, inverse, quotient | 1re | `operations_sur_les_fonctions_derivables_somme_produit_inverse` | ☐ |
| Pour 𝑛 dans ℤ, fonction dérivée de la fonction 𝑥 ↦ 𝑥 𝑛 | 1re | `pour_n_dans_z_fonction_derivee_de_la` | ☐ |
| Fonction valeur absolue : étude de la dérivabilité en 0 | 1re | `fonction_valeur_absolue_etude_de_la_derivabilite_en` | ☐ |
| Équation de la tangente en un point à une courbe représentative **(démonstration exigible)** | 1re | `equation_de_la_tangente_en_un_point_a` | ☐ |
| La fonction racine carrée n’est pas dérivable en 0 **(démonstration exigible)** | 1re | `la_fonction_racine_carree_nest_pas_derivable_en` | ☐ |
| Fonction dérivée de la fonction carrée, de la fonction inverse **(démonstration exigible)** | 1re | `fonction_derivee_de_la_fonction_carree_de_la` | ☐ |
| Fonction dérivée d’un produit **(démonstration exigible)** | 1re | `fonction_derivee_dun_produit_demonstration_exigible` | ☐ |

## Analyse — Variations et courbes représentatives des fonctions

Fichier : `AnalyseVariationsEtCourbesRepresentativesDesFonctions.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Représentation algébrique et graphique de fonctions paires, impaires. Traduction géométrique | 1re | `representation_algebrique_et_graphique_de_fonctions_paires_impaires` | ☐ |
| Lien entre le sens de variation d’une fonction dérivable sur un intervalle et signe de sa fonction dérivée ; caractérisation des fonctions constantes | 1re | `lien_entre_le_sens_de_variation_dune_fonction` | ☐ |
| Nombre dérivé en un extrémum, tangente à la courbe représentative | 1re | `nombre_derive_en_un_extremum_tangente_a_la` | ☐ |

## Analyse — Fonction exponentielle

Fichier : `AnalyseFonctionExponentielle.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Définition de la fonction exponentielle comme unique fonction dérivable sur ℝ vérifiant ƒ ‘ = ƒ et ƒ (0) = 1. L’existence et l’unicité sont admises. Notation exp(𝑥) | 1re | `definition_de_la_fonction_exponentielle_comme_unique_fonction` | ☐ |
| Pour tous réels 𝑥 et 𝑦, exp(𝑥 + 𝑦) = exp(𝑥) exp(𝑦) et exp(𝑥) exp(–𝑥) = 1. Nombre e. Notation e 𝑥 | 1re | `pour_tous_reels_x_et_y_exp_x` | ☐ |
| Signe, sens de variation et courbe représentative de la fonction exponentielle. Lien avec les suites géométriques | 1re | `signe_sens_de_variation_et_courbe_representative_de` | ☐ |

## Analyse — Trigonométrie

Fichier : `AnalyseTrigonometrie.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Cercle trigonométrique. Longueur d’arc. Radian | 1re | `cercle_trigonometrique_longueur_darc_radian` | ☐ |
| Enroulement de la droite sur le cercle trigonométrique. Image d’un nombre réel | 1re | `enroulement_de_la_droite_sur_le_cercle_trigonometrique` | ☐ |
| Cosinus et sinus d’un nombre réel. Lien avec le sinus et le cosinus dans un triangle rectangle. Valeurs remarquables | 1re | `cosinus_et_sinus_dun_nombre_reel_lien_avec` | ☐ |

## Géométrie — Calcul vectoriel et produit scalaire

Fichier : `GeometrieCalculVectorielEtProduitScalaire.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Produit scalaire à partir de la projection orthogonale et de la formule avec le cosinus. Caractérisation de l’orthogonalité | 1re | `produit_scalaire_a_partir_de_la_projection_orthogonale` | ☐ |
| Bilinéarité, symétrie. En base orthonormée, expression du produit scalaire et de la norme, critère d’orthogonalité. Expression des coordonnées dans une base orthonormée en termes de produits scalaires avec les vecteurs de la base | 1re | `bilinearite_symetrie_en_base_orthonormee_expression_du_produit` | ☐ |
| Développement de ‖𝑢 ⃗ + 𝑣‖2 et ‖𝑢 ⃗ − 𝑣 ‖2 . Formule d’Al-Kashi | 1re | `developpement_de_u_v2_et_u_v_2` | ☐ |
| Transformation de l’expression M ⃗⃗⃗⃗⃗⃗B. ⃗⃗⃗⃗⃗⃗⃗A ⋅ M | 1re | `transformation_de_lexpression_m_b_a_m` | ☐ |
| Formule d’Al-Kashi (démonstration avec le produit scalaire) **(démonstration exigible)** | 1re | `formule_dal_kashi_demonstration_avec_le_produit_scalaire` | ☐ |
| Ensemble des points M tels que M ⃗⃗⃗⃗⃗⃗B = 0 (démonstration avec le produit scalaire). ⃗⃗⃗⃗⃗⃗⃗A ⋅ M **(démonstration exigible)** | 1re | `ensemble_des_points_m_tels_que_m_b` | ☐ |

## Géométrie — Géométrie repérée

Fichier : `GeometrieGeometrieReperee.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Vecteur normal à une droite. Le vecteur de coordonnées (a, b) est normal à la droite d’équation a𝑥 + b𝑦 + c = 0 | 1re | `vecteur_normal_a_une_droite_le_vecteur_de` | ☐ |
| Projection orthogonale d’un point sur une droite | 1re | `projection_orthogonale_dun_point_sur_une_droite` | ☐ |
| Équation de cercle | 1re | `equation_de_cercle` | ☐ |

## Probabilités et statistiques — Probabilités conditionnelles et indépendance

Fichier : `ProbabilitesEtStatistiquesProbabilitesConditionnellesEtIndependance.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Indépendance de deux évènements | 1re | `independance_de_deux_evenements` | ☐ |
| Partition de l’univers (systèmes complets d’évènements). Formule des probabilités totales | 1re | `partition_de_lunivers_systemes_complets_devenements_formule_des` | ☐ |
| Succession de deux épreuves indépendantes. Représentation par un arbre ou un tableau | 1re | `succession_de_deux_epreuves_independantes_representation_par_un` | ☐ |
| Pour 𝑛 ⩽ 4, répétition de 𝑛 épreuves de Bernoulli indépendantes et identiques | 1re | `pour_n_4_repetition_de_n_epreuves_de` | ☐ |

## Probabilités et statistiques — Variables aléatoires réelles

Fichier : `ProbabilitesEtStatistiquesVariablesAleatoiresReelles.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Contenu | Classe | `contenu` | ☐ |
| Variable aléatoire réelle : modélisation du résultat numérique d’une expérience aléatoire ; formalisation comme fonction définie sur l’univers et à valeurs réelles | 1re | `variable_aleatoire_reelle_modelisation_du_resultat_numerique_dune` | ☐ |
| Loi d’une variable aléatoire | 1re | `loi_dune_variable_aleatoire` | ☐ |
| Espérance, variance, écart type d’une variable aléatoire | 1re | `esperance_variance_ecart_type_dune_variable_aleatoire` | ☐ |
| Linéarité de l’espérance | 1re | `linearite_de_lesperance` | ☐ |
| Formule de König-Huygens | 1re | `formule_de_konig_huygens` | ☐ |
