# Énoncés conservés

*Programme du collège* — énoncés tirés de [college.md](../../../college.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## 1. Nombres et calculs — Entiers, divisibilité

Fichier : `1NombresEtCalculsEntiersDivisibilite.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Un entier est pair ou impair, jamais les deux *(hors programme 2026)* | 6e | `un_entier_est_pair_ou_impair_jamais_les` | ☐ |
| Somme de deux pairs = pair ; pair + impair = impair ; impair + impair = pair *(hors programme 2026)* | 6e | `somme_de_deux_pairs_pair_pair_impair_impair` | ☐ |
| Notion de multiple et de diviseur ; un diviseur de `n` est inférieur ou égal à `n` *(hors programme 2026)* | 6e | `notion_de_multiple_et_de_diviseur_un_diviseur` | ☐ |
| Critère de divisibilité par 2, par 5, par 10 (chiffre des unités) *(hors programme 2026)* | 6e | `critere_de_divisibilite_par_2_par_5_par` | ☐ |
| Critère de divisibilité par 3 et par 9 (somme des chiffres) *(hors programme 2026)* | 6e | `critere_de_divisibilite_par_3_et_par_9` | ☐ |
| Critère de divisibilité par 4 (deux derniers chiffres) *(hors programme 2026)* | 5e | `critere_de_divisibilite_par_4_deux_derniers_chiffres` | ☐ |
| Si `a ∣ b` et `a ∣ c` alors `a ∣ (b + c)` et `a ∣ (b − c)` *(hors programme 2026)* | 5e | `si_et_alors_et_hors_programme_2026` | ☐ |
| Division euclidienne : existence et unicité de `(q, r)` avec `a = bq + r`, `0 ≤ r < b` | 6e | `division_euclidienne_existence_et_unicite_de_avec` | ☐ |
| Nombre premier ; tout entier > 1 admet un diviseur premier *(hors programme 2026)* | 3e | `nombre_premier_tout_entier_1_admet_un_diviseur` | ☐ |
| Crible d'Ératosthène : lister les nombres premiers inférieurs à 100 *(hors programme 2026)* | 3e | `crible_d_eratosthene_lister_les_nombres_premiers_inferieurs` | ☐ |
| Décomposition en produit de facteurs premiers *(hors programme 2026)* | 3e | `decomposition_en_produit_de_facteurs_premiers_hors_programme` | ☐ |
| PGCD, algorithme d'Euclide : `pgcd(a, b) = pgcd(b, a mod b)` *(hors programme 2026)* | 3e | `pgcd_algorithme_d_euclide_hors_programme_2026` | ☐ |
| Nombres premiers entre eux ⟺ `pgcd = 1` | 3e | `nombres_premiers_entre_eux` | ☐ |
| Toute fraction admet une écriture irréductible | 3e | `toute_fraction_admet_une_ecriture_irreductible` | ☐ |

## 1. Nombres et calculs — Écritures des nombres

Fichier : `1NombresEtCalculsEcrituresDesNombres.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Numération décimale de position ; valeur d'un chiffre selon son rang *(hors programme 2026)* | 6e | `numeration_decimale_de_position_valeur_d_un_chiffre` | ☐ |
| Ordre sur les décimaux ; comparaison, encadrement, intercalation *(hors programme 2026)* | 6e | `ordre_sur_les_decimaux_comparaison_encadrement_intercalation_hors` | ☐ |
| Ordre sur les relatifs ; opposé, distance à zéro *(hors programme 2026)* | 5e | `ordre_sur_les_relatifs_oppose_distance_a_zero` | ☐ |
| Égalité de fractions : `a/b = (ka)/(kb)` pour `k ≠ 0` *(hors programme 2026)* | 5e | `egalite_de_fractions_pour_hors_programme_2026` | ☐ |
| Comparaison de fractions ; mise au même dénominateur *(hors programme 2026)* | 5e | `comparaison_de_fractions_mise_au_meme_denominateur_hors` | ☐ |
| Une fraction n'a pas toujours d'écriture décimale exacte (`1/3`) *(hors programme 2026)* | 5e | `une_fraction_n_a_pas_toujours_d_ecriture` | ☐ |
| Arrondi, troncature, valeur approchée à `10⁻ⁿ` près, encadrement *(hors programme 2026)* | 6e / 5e | `arrondi_troncature_valeur_approchee_a_pres_encadrement_hors` | ☐ |
| Ordre de grandeur d'un résultat ; contrôle de la vraisemblance d'un calcul *(hors programme 2026)* | 5e | `ordre_de_grandeur_d_un_resultat_controle_de` | ☐ |
| Écriture scientifique : existence et unicité de `a × 10ⁿ` avec `1 ≤ \|a\| < 10` *(hors programme 2026)* | 4e | `ecriture_scientifique_existence_et_unicite_de_avec_hors` | ☐ |
| Racine carrée : `(√a)² = a` et `√(a²) = a` pour `a ≥ 0` | 3e | `racine_carree_et_pour` | ☐ |
| `√(ab) = √a × √b` et `√(a/b) = √a / √b` (`a ≥ 0`, `b > 0`) *(hors programme 2026)* | 3e | `et_hors_programme_2026` | ☐ |
| Contre-exemple : `√(a + b) ≠ √a + √b` en général | 3e | `contre_exemple_en_general` | ☐ |
| Rationnels et irrationnels : `√2` n'est pas rationnel (admis au collège) *(hors programme 2026)* | 3e | `rationnels_et_irrationnels_n_est_pas_rationnel_admis` | ☐ |

## 1. Nombres et calculs — Calculs et calcul littéral

Fichier : `1NombresEtCalculsCalculsEtCalculLitteral.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Priorités opératoires ; rôle des parenthèses | 5e | `priorites_operatoires_role_des_parentheses` | ☐ |
| Addition et soustraction des relatifs ; `a − b = a + (−b)` | 5e | `addition_et_soustraction_des_relatifs` | ☐ |
| Règle des signes pour la multiplication et la division | 5e | `regle_des_signes_pour_la_multiplication_et_la` | ☐ |
| Somme, produit, quotient de fractions ; diviser = multiplier par l'inverse *(hors programme 2026)* | 5e / 4e | `somme_produit_quotient_de_fractions_diviser_multiplier_par` | ☐ |
| Distributivité simple : `k(a + b) = ka + kb` | 5e | `distributivite_simple` | ☐ |
| Double distributivité : `(a + b)(c + d) = ac + ad + bc + bd` | 4e | `double_distributivite` | ☐ |
| Factorisation d'une expression à facteur commun *(hors programme 2026)* | 4e | `factorisation_d_une_expression_a_facteur_commun_hors` | ☐ |
| Un produit est nul ⟺ l'un des facteurs est nul | 3e | `un_produit_est_nul_l_un_des_facteurs` | ☐ |
| Puissances : `aᵐ × aⁿ = aᵐ⁺ⁿ`, `aᵐ / aⁿ = aᵐ⁻ⁿ`, `(aᵐ)ⁿ = aᵐⁿ`, `(ab)ⁿ = aⁿbⁿ` *(hors programme 2026)* | 4e | `puissances_hors_programme_2026` | ☐ |
| `a⁻ⁿ = 1/aⁿ` pour `a ≠ 0` ; `a⁰ = 1` *(hors programme 2026)* | 4e | `pour_hors_programme_2026` | ☐ |
| Conservation des inégalités : `a ≤ b ⟹ a + c ≤ b + c` ; multiplier par `c > 0` conserve, par `c < 0` inverse *(hors programme 2026)* | 4e | `conservation_des_inegalites_multiplier_par_conserve_par_inverse` | ☐ |
| Équation du premier degré `ax + b = 0` : solution unique si `a ≠ 0` | 4e / 3e | `equation_du_premier_degre_solution_unique_si` | ☐ |
| Équation produit `(ax + b)(cx + d) = 0` | 3e | `equation_produit` | ☐ |
| Tester si un nombre est solution ; démontrer qu'une égalité est vraie pour tout `x` | 4e | `tester_si_un_nombre_est_solution_demontrer_qu` | ☐ |
| Programme de calcul : deux programmes donnent le même résultat pour toute entrée *(hors programme 2026)* | 5e → 3e | `programme_de_calcul_deux_programmes_donnent_le_meme` | ☐ |

## 2. Géométrie plane — Droites, angles, parallèles

Fichier : `2GeometriePlaneDroitesAnglesParalleles.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Par deux points distincts passe une droite et une seule *(hors programme 2026)* | 6e | `par_deux_points_distincts_passe_une_droite_et` | ☐ |
| Deux droites perpendiculaires à une même droite sont parallèles entre elles *(hors programme 2026)* | 6e | `deux_droites_perpendiculaires_a_une_meme_droite_sont` | ☐ |
| Si deux droites sont parallèles, toute perpendiculaire à l'une est perpendiculaire à l'autre *(hors programme 2026)* | 6e | `si_deux_droites_sont_paralleles_toute_perpendiculaire_a` | ☐ |
| Deux droites parallèles à une même droite sont parallèles entre elles | 6e | `deux_droites_paralleles_a_une_meme_droite_sont` | ☐ |
| Le plus court chemin d'un point à une droite est le segment perpendiculaire *(hors programme 2026)* | 6e | `le_plus_court_chemin_d_un_point_a` | ☐ |
| Angles opposés par le sommet : ils sont égaux | 6e | `angles_opposes_par_le_sommet_ils_sont_egaux` | ☐ |
| Angles adjacents, complémentaires, supplémentaires | 6e | `angles_adjacents_complementaires_supplementaires` | ☐ |
| Deux parallèles coupées par une sécante : angles alternes-internes et correspondants égaux | 5e | `deux_paralleles_coupees_par_une_secante_angles_alternes` | ☐ |
| Réciproque : égalité de deux angles alternes-internes ⟹ parallélisme | 5e | `reciproque_egalite_de_deux_angles_alternes_internes_parallelisme` | ☐ |
| Caractérisation de la médiatrice : `M` équidistant de `A` et `B` ⟺ `M` sur la médiatrice de `[AB]` *(hors programme 2026)* | 6e | `caracterisation_de_la_mediatrice_equidistant_de_et_sur` | ☐ |
| Caractérisation de la bissectrice : équidistance aux deux côtés de l'angle *(hors programme 2026)* | 6e | `caracterisation_de_la_bissectrice_equidistance_aux_deux_cotes` | ☐ |
| Constructions à la règle et au compas : médiatrice, bissectrice, perpendiculaire, report de longueur *(hors programme 2026)* | 6e | `constructions_a_la_regle_et_au_compas_mediatrice` | ☐ |

## 2. Géométrie plane — Triangles

Fichier : `2GeometriePlaneTriangles.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Somme des angles d'un triangle = 180° | 5e | `somme_des_angles_d_un_triangle_180` | ☐ |
| Angles d'un triangle équilatéral = 60° ; angles à la base d'un isocèle égaux, et réciproque *(hors programme 2026)* | 5e | `angles_d_un_triangle_equilateral_60_angles_a` | ☐ |
| Inégalité triangulaire : `AC ≤ AB + BC`, égalité ⟺ `B ∈ [AC]` *(hors programme 2026)* | 5e | `inegalite_triangulaire_egalite_hors_programme_2026` | ☐ |
| Un triangle est constructible ⟺ l'inégalité triangulaire est vérifiée *(hors programme 2026)* | 5e | `un_triangle_est_constructible_l_inegalite_triangulaire_est` | ☐ |
| Cas d'égalité et cas de similitude des triangles *(hors programme 2026)* | 4e / 3e | `cas_d_egalite_et_cas_de_similitude_des` | ☐ |
| Théorème de Pythagore : rectangle en `A` ⟹ `BC² = AB² + AC²` | 4e | `theoreme_de_pythagore_rectangle_en` | ☐ |
| Réciproque de Pythagore : `BC² = AB² + AC²` ⟹ rectangle en `A` | 4e | `reciproque_de_pythagore_rectangle_en` | ☐ |
| Contraposée : `BC² ≠ AB² + AC²` ⟹ non rectangle en `A` *(hors programme 2026)* | 4e | `contraposee_non_rectangle_en_hors_programme_2026` | ☐ |
| Théorème des milieux : la droite des milieux est parallèle au troisième côté et de longueur moitié *(hors programme 2026)* | 4e | `theoreme_des_milieux_la_droite_des_milieux_est` | ☐ |
| Réciproque : la parallèle menée par le milieu d'un côté coupe le deuxième côté en son milieu *(hors programme 2026)* | 4e | `reciproque_la_parallele_menee_par_le_milieu_d` | ☐ |
| Théorème de Thalès (triangle et « papillon ») : `AM/AB = AN/AC = MN/BC` | 3e | `theoreme_de_thales_triangle_et_papillon` | ☐ |
| Réciproque de Thalès : égalité des rapports et bon ordre des points ⟹ parallélisme *(hors programme 2026)* | 3e | `reciproque_de_thales_egalite_des_rapports_et_bon` | ☐ |
| Trigonométrie du triangle rectangle : définitions de `cos`, `sin`, `tan` d'un angle aigu *(hors programme 2026)* | 4e / 3e | `trigonometrie_du_triangle_rectangle_definitions_de_d_un` | ☐ |
| `cos²x + sin²x = 1` et `tan x = sin x / cos x` *(hors programme 2026)* | 3e | `et_hors_programme_2026` | ☐ |
| Concours des médiatrices ⟹ cercle circonscrit | 5e | `concours_des_mediatrices_cercle_circonscrit` | ☐ |
| Concours des médianes (centre de gravité), des hauteurs (orthocentre), des bissectrices (cercle inscrit) *(hors programme 2026)* | 5e / 4e | `concours_des_medianes_centre_de_gravite_des_hauteurs` | ☐ |

## 2. Géométrie plane — Cercle et quadrilatères

Fichier : `2GeometriePlaneCercleEtQuadrilateres.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Un triangle inscrit dans un cercle dont un côté est un diamètre est rectangle | 4e | `un_triangle_inscrit_dans_un_cercle_dont_un` | ☐ |
| Réciproque : l'hypoténuse est un diamètre du cercle circonscrit | 4e | `reciproque_l_hypotenuse_est_un_diametre_du_cercle` | ☐ |
| Dans un triangle rectangle, la médiane issue de l'angle droit vaut la moitié de l'hypoténuse *(hors programme 2026)* | 4e | `dans_un_triangle_rectangle_la_mediane_issue_de` | ☐ |
| La tangente à un cercle est perpendiculaire au rayon au point de contact *(hors programme 2026)* | 3e | `la_tangente_a_un_cercle_est_perpendiculaire_au` | ☐ |
| Parallélogramme ⟺ diagonales se coupant en leur milieu ⟺ côtés opposés parallèles ⟺ côtés opposés de même longueur *(hors programme 2026)* | 5e | `parallelogramme_diagonales_se_coupant_en_leur_milieu_cotes` | ☐ |
| Dans un parallélogramme, angles opposés égaux et angles consécutifs supplémentaires | 5e | `dans_un_parallelogramme_angles_opposes_egaux_et_angles` | ☐ |
| Caractérisations du rectangle, du losange, du carré | 5e | `caracterisations_du_rectangle_du_losange_du_carre` | ☐ |
| Axes de symétrie et centre de symétrie des quadrilatères usuels et du cercle *(hors programme 2026)* | 6e / 5e | `axes_de_symetrie_et_centre_de_symetrie_des` | ☐ |

## 2. Géométrie plane — Repérage et espace

Fichier : `2GeometriePlaneReperageEtEspace.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Repérage dans le plan : couple de coordonnées, abscisse et ordonnée *(hors programme 2026)* | 5e | `reperage_dans_le_plan_couple_de_coordonnees_abscisse` | ☐ |
| Coordonnées du milieu d'un segment | 3e | `coordonnees_du_milieu_d_un_segment` | ☐ |
| Distance entre deux points repérés (via Pythagore) | 3e | `distance_entre_deux_points_reperes_via_pythagore` | ☐ |
| Solides usuels : pavé, prisme, cylindre, pyramide, cône, boule ; faces, arêtes, sommets *(hors programme 2026)* | 6e → 4e | `solides_usuels_pave_prisme_cylindre_pyramide_cone_boule` | ☐ |
| Patrons d'un solide ; représentation en perspective cavalière | 6e / 5e | `patrons_d_un_solide_representation_en_perspective_cavaliere` | ☐ |
| Sections planes d'un pavé, d'un cylindre | 3e | `sections_planes_d_un_pave_d_un_cylindre` | ☐ |
| Repérage sur la sphère terrestre : latitude, longitude *(hors programme 2026)* | 5e | `reperage_sur_la_sphere_terrestre_latitude_longitude_hors` | ☐ |

## 3. Transformations du plan

Fichier : `3TransformationsDuPlan.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Symétrie axiale, symétrie centrale, translation, rotation : conservation des longueurs, des angles, des aires, de l'alignement *(hors programme 2026)* | 6e → 4e | `symetrie_axiale_symetrie_centrale_translation_rotation_conservation_des` | ☐ |
| La symétrie centrale transforme une droite en une droite parallèle *(hors programme 2026)* | 5e | `la_symetrie_centrale_transforme_une_droite_en_une` | ☐ |
| Composition de deux symétries centrales = translation *(hors programme 2026)* | 5e | `composition_de_deux_symetries_centrales_translation_hors_programme` | ☐ |
| Homothétie de rapport `k` : longueurs multipliées par `\|k\|`, angles conservés, droite envoyée sur une parallèle *(hors programme 2026)* | 3e | `homothetie_de_rapport_longueurs_multipliees_par_angles_conserves` | ☐ |
| Figures semblables : angles égaux et longueurs proportionnelles *(hors programme 2026)* | 3e | `figures_semblables_angles_egaux_et_longueurs_proportionnelles_hors` | ☐ |
| Frises, pavages, rosaces : reconnaître les transformations qui laissent la figure invariante *(hors programme 2026)* | 5e / 4e | `frises_pavages_rosaces_reconnaitre_les_transformations_qui_laissent` | ☐ |

## 4. Grandeurs et mesures

Fichier : `4GrandeursEtMesures.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Distinguer une grandeur de sa mesure ; unités et conversions *(hors programme 2026)* | 6e | `distinguer_une_grandeur_de_sa_mesure_unites_et` | ☐ |
| Mesure d'angles en degrés ; durées en système sexagésimal *(hors programme 2026)* | 6e | `mesure_d_angles_en_degres_durees_en_systeme` | ☐ |
| Périmètre du cercle `2πr` ; aire du disque `πr²` | 6e | `perimetre_du_cercle_aire_du_disque` | ☐ |
| Aires : rectangle, triangle (`base × hauteur / 2`), parallélogramme, trapèze *(hors programme 2026)* | 6e / 5e | `aires_rectangle_triangle_parallelogramme_trapeze_hors_programme_2026` | ☐ |
| Deux figures de même aire peuvent avoir des périmètres différents, et réciproquement *(hors programme 2026)* | 6e | `deux_figures_de_meme_aire_peuvent_avoir_des` | ☐ |
| Volumes : pavé, prisme, cylindre (`aire de base × hauteur`), pyramide et cône (`× 1/3`), boule (`4/3 πr³`) *(hors programme 2026)* | 5e → 3e | `volumes_pave_prisme_cylindre_pyramide_et_cone_boule` | ☐ |
| Agrandissement-réduction de rapport `k` : longueurs `× k`, aires `× k²`, volumes `× k³` *(hors programme 2026)* | 3e | `agrandissement_reduction_de_rapport_longueurs_aires_volumes_hors` | ☐ |
| Grandeurs quotients : vitesse `v = d / t`, débit, masse volumique, prix au kilo *(hors programme 2026)* | 4e | `grandeurs_quotients_vitesse_debit_masse_volumique_prix_au` | ☐ |
| Vitesse moyenne : ce n'est pas la moyenne des vitesses | 4e | `vitesse_moyenne_ce_n_est_pas_la_moyenne` | ☐ |
| Échelle d'un plan ou d'une carte *(hors programme 2026)* | 5e / 4e | `echelle_d_un_plan_ou_d_une_carte` | ☐ |

## 5. Proportionnalité et fonctions

Fichier : `5ProportionnaliteEtFonctions.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Reconnaître une situation de proportionnalité ; coefficient de proportionnalité | 6e | `reconnaitre_une_situation_de_proportionnalite_coefficient_de_proportionnalite` | ☐ |
| Un tableau est proportionnel ⟺ les produits en croix sont égaux *(hors programme 2026)* | 6e / 4e | `un_tableau_est_proportionnel_les_produits_en_croix` | ☐ |
| Égalité des produits en croix : `a/b = c/d ⟺ ad = bc` (`b, d ≠ 0`) *(hors programme 2026)* | 4e | `egalite_des_produits_en_croix_hors_programme_2026` | ☐ |
| Quatrième proportionnelle : existence et unicité | 6e / 5e | `quatrieme_proportionnelle_existence_et_unicite` | ☐ |
| Pourcentage d'une quantité ; appliquer et retrouver un taux d'évolution *(hors programme 2026)* | 5e / 4e | `pourcentage_d_une_quantite_appliquer_et_retrouver_un` | ☐ |
| Composition de deux évolutions : appliquer `p` puis `q` revient à multiplier par `(1+p)(1+q)` *(hors programme 2026)* | 4e | `composition_de_deux_evolutions_appliquer_puis_revient_a` | ☐ |
| Une évolution de `+p` puis `−p` ne ramène pas à la valeur initiale *(hors programme 2026)* | 4e | `une_evolution_de_puis_ne_ramene_pas_a` | ☐ |
| Notion de fonction : image, antécédent, notation `f(x)`, tableau de valeurs *(hors programme 2026)* | 3e | `notion_de_fonction_image_antecedent_notation_tableau_de` | ☐ |
| Une image est unique, un antécédent ne l'est pas nécessairement *(hors programme 2026)* | 3e | `une_image_est_unique_un_antecedent_ne_l` | ☐ |
| Lecture graphique d'une image, d'un antécédent *(hors programme 2026)* | 3e | `lecture_graphique_d_une_image_d_un_antecedent` | ☐ |
| Fonction linéaire `x ↦ ax` : traduit exactement la proportionnalité ; graphe = droite par l'origine *(hors programme 2026)* | 3e | `fonction_lineaire_traduit_exactement_la_proportionnalite_graphe_droite` | ☐ |
| Fonction affine `x ↦ ax + b` : graphe = droite ; `a` coefficient directeur, `b` ordonnée à l'origine *(hors programme 2026)* | 3e | `fonction_affine_graphe_droite_coefficient_directeur_ordonnee_a` | ☐ |
| `a = (f(x₂) − f(x₁)) / (x₂ − x₁)` pour une fonction affine | 3e | `pour_une_fonction_affine` | ☐ |
| Sens de variation d'une fonction affine selon le signe de `a` *(hors programme 2026)* | 3e | `sens_de_variation_d_une_fonction_affine_selon` | ☐ |

## 6. Statistiques et probabilités

Fichier : `6StatistiquesEtProbabilites.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Effectifs, fréquences ; la somme des fréquences vaut 1 | 6e / 5e | `effectifs_frequences_la_somme_des_frequences_vaut_1` | ☐ |
| Représentations : diagrammes en bâtons, circulaires, histogrammes ; choisir une représentation adaptée *(hors programme 2026)* | 6e → 4e | `representations_diagrammes_en_batons_circulaires_histogrammes_choisir_une` | ☐ |
| Moyenne : linéarité (`moyenne(x + c) = moyenne(x) + c`), moyenne pondérée | 4e | `moyenne_linearite_moyenne_ponderee` | ☐ |
| La moyenne est comprise entre le minimum et le maximum de la série *(hors programme 2026)* | 4e | `la_moyenne_est_comprise_entre_le_minimum_et` | ☐ |
| La moyenne de plusieurs moyennes n'est pas la moyenne de la série globale *(hors programme 2026)* | 4e | `la_moyenne_de_plusieurs_moyennes_n_est_pas` | ☐ |
| Médiane : au moins la moitié des valeurs lui sont inférieures ou égales *(hors programme 2026)* | 4e | `mediane_au_moins_la_moitie_des_valeurs_lui` | ☐ |
| Étendue = max − min ; la moyenne est sensible aux valeurs extrêmes, la médiane non *(hors programme 2026)* | 6e / 4e | `etendue_max_min_la_moyenne_est_sensible_aux` | ☐ |
| Probabilité : `0 ≤ P(A) ≤ 1`, somme des probabilités des issues = 1 *(hors programme 2026)* | 3e | `probabilite_somme_des_probabilites_des_issues_1_hors` | ☐ |
| Événement contraire : `P(Ā) = 1 − P(A)` | 3e | `evenement_contraire` | ☐ |
| Équiprobabilité : `P(A) = card(A) / card(Ω)` *(hors programme 2026)* | 3e | `equiprobabilite_hors_programme_2026` | ☐ |
| Expérience à deux épreuves : arbre pondéré, produit des probabilités le long d'une branche *(hors programme 2026)* | 3e | `experience_a_deux_epreuves_arbre_pondere_produit_des` | ☐ |
| Fréquence observée et probabilité : fluctuation d'échantillonnage, stabilisation quand `n` grandit *(hors programme 2026)* | 3e | `frequence_observee_et_probabilite_fluctuation_d_echantillonnage_stabilisation` | ☐ |
| Simuler une expérience aléatoire et comparer à la valeur théorique | 3e | `simuler_une_experience_aleatoire_et_comparer_a_la` | ☐ |

## 7. Algorithmique et programmation

Fichier : `7AlgorithmiqueEtProgrammation.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Notion de variable, d'affectation ; état d'un programme après exécution *(hors programme 2026)* | 5e | `notion_de_variable_d_affectation_etat_d_un` | ☐ |
| Boucle bornée : un programme répétant `n` fois une instruction produit tel résultat *(hors programme 2026)* | 5e | `boucle_bornee_un_programme_repetant_fois_une_instruction` | ☐ |
| Boucle non bornée, instruction conditionnelle ; terminaison d'un programme simple *(hors programme 2026)* | 4e | `boucle_non_bornee_instruction_conditionnelle_terminaison_d_un` | ☐ |
| Correction d'un programme de calcul : ce qu'il calcule vaut telle expression de l'entrée *(hors programme 2026)* | 4e / 3e | `correction_d_un_programme_de_calcul_ce_qu` | ☐ |
| Deux programmes différents calculent la même chose *(hors programme 2026)* | 4e / 3e | `deux_programmes_differents_calculent_la_meme_chose_hors` | ☐ |
