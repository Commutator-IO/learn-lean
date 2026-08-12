# Énoncés conservés

*Programme du collège* — énoncés tirés de [college.md](../../../college.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## 1. Nombres et calculs — Entiers, divisibilité

Fichier : `1NombresEtCalculsEntiersDivisibilite.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Un entier est pair ou impair, jamais les deux | 6e | `un_entier_est_pair_ou_impair_jamais_les` | ☑ |
| Somme de deux pairs = pair ; pair + impair = impair ; impair + impair = pair | 6e | `somme_de_deux_pairs_pair_pair_impair_impair` | ☑ |
| Notion de multiple et de diviseur ; un diviseur de `n` est inférieur ou égal à `n` | 6e | `notion_de_multiple_et_de_diviseur_un_diviseur` | ☑ |
| Critère de divisibilité par 2, par 5, par 10 (chiffre des unités) | 6e | `critere_de_divisibilite_par_2_par_5_par` | ☑ |
| Critère de divisibilité par 3 et par 9 (somme des chiffres) | 6e | `critere_de_divisibilite_par_3_et_par_9` | ☑ |
| Critère de divisibilité par 4 (deux derniers chiffres) | 5e | `critere_de_divisibilite_par_4_deux_derniers_chiffres` | ☑ |
| Si `a ∣ b` et `a ∣ c` alors `a ∣ (b + c)` et `a ∣ (b − c)` | 5e | `si_et_alors_et` | ☑ |
| Division euclidienne : existence et unicité de `(q, r)` avec `a = bq + r`, `0 ≤ r < b` | 6e | `division_euclidienne_existence_et_unicite_de_avec` | ☑ |
| Nombre premier ; tout entier > 1 admet un diviseur premier | 3e | `nombre_premier_tout_entier_1_admet_un_diviseur` | ☑ |
| Crible d'Ératosthène : lister les nombres premiers inférieurs à 100 | 3e | `crible_d_eratosthene_lister_les_nombres_premiers_inferieurs` | ☑ |
| Décomposition en produit de facteurs premiers | 3e | `decomposition_en_produit_de_facteurs_premiers` | ◐ |
| PGCD, algorithme d'Euclide : `pgcd(a, b) = pgcd(b, a mod b)` | 3e | `pgcd_algorithme_d_euclide` | ☑ |
| Nombres premiers entre eux ⟺ `pgcd = 1` | 3e | `nombres_premiers_entre_eux` | ☑ |

## 1. Nombres et calculs — Écritures des nombres

Fichier : `1NombresEtCalculsEcrituresDesNombres.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Égalité de fractions : `a/b = (ka)/(kb)` pour `k ≠ 0` | 5e | `egalite_de_fractions_pour` | ☐ |
| Racine carrée : `(√a)² = a` et `√(a²) = a` pour `a ≥ 0` | 3e | `racine_carree_et_pour` | ☐ |
| `√(ab) = √a × √b` et `√(a/b) = √a / √b` (`a ≥ 0`, `b > 0`) | 3e | `et` | ☐ |
| Rationnels et irrationnels : `√2` n'est pas rationnel (admis au collège) | 3e | `rationnels_et_irrationnels_n_est_pas_rationnel_admis` | ☐ |

## 1. Nombres et calculs — Calculs et calcul littéral

Fichier : `1NombresEtCalculsCalculsEtCalculLitteral.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Addition et soustraction des relatifs ; `a − b = a + (−b)` | 5e | `addition_et_soustraction_des_relatifs` | ☐ |
| Règle des signes pour la multiplication et la division | 5e | `regle_des_signes_pour_la_multiplication_et_la` | ☐ |
| Somme, produit, quotient de fractions ; diviser = multiplier par l'inverse | 5e / 4e | `somme_produit_quotient_de_fractions_diviser_multiplier_par` | ☐ |
| Distributivité simple : `k(a + b) = ka + kb` | 5e | `distributivite_simple` | ☐ |
| Double distributivité : `(a + b)(c + d) = ac + ad + bc + bd` | 4e | `double_distributivite` | ☐ |
| Un produit est nul ⟺ l'un des facteurs est nul | 3e | `un_produit_est_nul_l_un_des_facteurs` | ☐ |
| Puissances : `aᵐ × aⁿ = aᵐ⁺ⁿ`, `aᵐ / aⁿ = aᵐ⁻ⁿ`, `(aᵐ)ⁿ = aᵐⁿ`, `(ab)ⁿ = aⁿbⁿ` | 4e | `puissances` | ☐ |
| `a⁻ⁿ = 1/aⁿ` pour `a ≠ 0` ; `a⁰ = 1` | 4e | `pour` | ☐ |
| Conservation des inégalités : `a ≤ b ⟹ a + c ≤ b + c` ; multiplier par `c > 0` conserve, par `c < 0` inverse | 4e | `conservation_des_inegalites_multiplier_par_conserve_par_inverse` | ☐ |
| Équation du premier degré `ax + b = 0` : solution unique si `a ≠ 0` | 4e / 3e | `equation_du_premier_degre_solution_unique_si` | ☐ |
| Équation produit `(ax + b)(cx + d) = 0` | 3e | `equation_produit` | ☐ |
| Tester si un nombre est solution ; démontrer qu'une égalité est vraie pour tout `x` | 4e | `tester_si_un_nombre_est_solution_demontrer_qu` | ☐ |

## 2. Géométrie plane — Droites, angles, parallèles

Fichier : `2GeometriePlaneDroitesAnglesParalleles.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Deux droites perpendiculaires à une même droite sont parallèles entre elles | 6e | `deux_droites_perpendiculaires_a_une_meme_droite_sont` | ☐ |
| Si deux droites sont parallèles, toute perpendiculaire à l'une est perpendiculaire à l'autre | 6e | `si_deux_droites_sont_paralleles_toute_perpendiculaire_a` | ☐ |
| Deux droites parallèles à une même droite sont parallèles entre elles | 6e | `deux_droites_paralleles_a_une_meme_droite_sont` | ☐ |
| Le plus court chemin d'un point à une droite est le segment perpendiculaire | 6e | `le_plus_court_chemin_d_un_point_a` | ☐ |
| Angles opposés par le sommet : ils sont égaux | 6e | `angles_opposes_par_le_sommet_ils_sont_egaux` | ☐ |
| Réciproque : égalité de deux angles alternes-internes ⟹ parallélisme | 5e | `reciproque_egalite_de_deux_angles_alternes_internes_parallelisme` | ☐ |
| Caractérisation de la médiatrice : `M` équidistant de `A` et `B` ⟺ `M` sur la médiatrice de `[AB]` | 6e | `caracterisation_de_la_mediatrice_equidistant_de_et_sur` | ☐ |
| Caractérisation de la bissectrice : équidistance aux deux côtés de l'angle | 6e | `caracterisation_de_la_bissectrice_equidistance_aux_deux_cotes` | ☐ |

## 2. Géométrie plane — Triangles

Fichier : `2GeometriePlaneTriangles.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Somme des angles d'un triangle = 180° | 5e | `somme_des_angles_d_un_triangle_180` | ☐ |
| Angles d'un triangle équilatéral = 60° ; angles à la base d'un isocèle égaux, et réciproque | 5e | `angles_d_un_triangle_equilateral_60_angles_a` | ☐ |
| Inégalité triangulaire : `AC ≤ AB + BC`, égalité ⟺ `B ∈ [AC]` | 5e | `inegalite_triangulaire_egalite` | ☐ |
| Un triangle est constructible ⟺ l'inégalité triangulaire est vérifiée | 5e | `un_triangle_est_constructible_l_inegalite_triangulaire_est` | ☐ |
| Cas d'égalité et cas de similitude des triangles | 4e / 3e | `cas_d_egalite_et_cas_de_similitude_des` | ☐ |
| Théorème de Pythagore : rectangle en `A` ⟹ `BC² = AB² + AC²` | 4e | `theoreme_de_pythagore_rectangle_en` | ☐ |
| Réciproque de Pythagore : `BC² = AB² + AC²` ⟹ rectangle en `A` | 4e | `reciproque_de_pythagore_rectangle_en` | ☐ |
| Contraposée : `BC² ≠ AB² + AC²` ⟹ non rectangle en `A` | 4e | `contraposee_non_rectangle_en` | ☐ |
| Théorème des milieux : la droite des milieux est parallèle au troisième côté et de longueur moitié | 4e | `theoreme_des_milieux_la_droite_des_milieux_est` | ☐ |
| Réciproque : la parallèle menée par le milieu d'un côté coupe le deuxième côté en son milieu | 4e | `reciproque_la_parallele_menee_par_le_milieu_d` | ☐ |
| Théorème de Thalès (triangle et « papillon ») : `AM/AB = AN/AC = MN/BC` | 3e | `theoreme_de_thales_triangle_et_papillon` | ☐ |
| Réciproque de Thalès : égalité des rapports et bon ordre des points ⟹ parallélisme | 3e | `reciproque_de_thales_egalite_des_rapports_et_bon` | ☐ |
| Trigonométrie du triangle rectangle : définitions de `cos`, `sin`, `tan` d'un angle aigu | 4e / 3e | `trigonometrie_du_triangle_rectangle_definitions_de_d_un` | ☐ |
| `cos²x + sin²x = 1` et `tan x = sin x / cos x` | 3e | `et` | ☐ |
| Concours des médiatrices ⟹ cercle circonscrit | 5e | `concours_des_mediatrices_cercle_circonscrit` | ☐ |

## 2. Géométrie plane — Cercle et quadrilatères

Fichier : `2GeometriePlaneCercleEtQuadrilateres.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Un triangle inscrit dans un cercle dont un côté est un diamètre est rectangle | 4e | `un_triangle_inscrit_dans_un_cercle_dont_un` | ☐ |
| Réciproque : l'hypoténuse est un diamètre du cercle circonscrit | 4e | `reciproque_l_hypotenuse_est_un_diametre_du_cercle` | ☐ |
| Dans un triangle rectangle, la médiane issue de l'angle droit vaut la moitié de l'hypoténuse | 4e | `dans_un_triangle_rectangle_la_mediane_issue_de` | ☐ |
| La tangente à un cercle est perpendiculaire au rayon au point de contact | 3e | `la_tangente_a_un_cercle_est_perpendiculaire_au` | ☐ |
| Parallélogramme ⟺ diagonales se coupant en leur milieu ⟺ côtés opposés parallèles ⟺ côtés opposés de même longueur | 5e | `parallelogramme_diagonales_se_coupant_en_leur_milieu_cotes` | ☐ |
| Caractérisations du rectangle, du losange, du carré | 5e | `caracterisations_du_rectangle_du_losange_du_carre` | ☐ |

## 2. Géométrie plane — Repérage et espace

Fichier : `2GeometriePlaneReperageEtEspace.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Solides usuels : pavé, prisme, cylindre, pyramide, cône, boule ; faces, arêtes, sommets | 6e → 4e | `solides_usuels_pave_prisme_cylindre_pyramide_cone_boule` | ☐ |

## 3. Transformations du plan

Fichier : `3TransformationsDuPlan.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Composition de deux symétries centrales = translation | 5e | `composition_de_deux_symetries_centrales_translation` | ☐ |

## 4. Grandeurs et mesures

Fichier : `4GrandeursEtMesures.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Deux figures de même aire peuvent avoir des périmètres différents, et réciproquement | 6e | `deux_figures_de_meme_aire_peuvent_avoir_des` | ☐ |
| Grandeurs quotients : vitesse `v = d / t`, débit, masse volumique, prix au kilo | 4e | `grandeurs_quotients_vitesse_debit_masse_volumique_prix_au` | ☐ |
| Vitesse moyenne : ce n'est pas la moyenne des vitesses | 4e | `vitesse_moyenne_ce_n_est_pas_la_moyenne` | ☐ |

## 5. Proportionnalité et fonctions

Fichier : `5ProportionnaliteEtFonctions.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Un tableau est proportionnel ⟺ les produits en croix sont égaux | 6e / 4e | `un_tableau_est_proportionnel_les_produits_en_croix` | ☐ |
| Égalité des produits en croix : `a/b = c/d ⟺ ad = bc` (`b, d ≠ 0`) | 4e | `egalite_des_produits_en_croix` | ☐ |
| Une image est unique, un antécédent ne l'est pas nécessairement | 3e | `une_image_est_unique_un_antecedent_ne_l` | ☐ |
| Fonction linéaire `x ↦ ax` : traduit exactement la proportionnalité ; graphe = droite par l'origine | 3e | `fonction_lineaire_traduit_exactement_la_proportionnalite_graphe_droite` | ☐ |
| Fonction affine `x ↦ ax + b` : graphe = droite ; `a` coefficient directeur, `b` ordonnée à l'origine | 3e | `fonction_affine_graphe_droite_coefficient_directeur_ordonnee_a` | ☐ |
| `a = (f(x₂) − f(x₁)) / (x₂ − x₁)` pour une fonction affine | 3e | `pour_une_fonction_affine` | ☐ |

## 6. Statistiques et probabilités

Fichier : `6StatistiquesEtProbabilites.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Effectifs, fréquences ; la somme des fréquences vaut 1 | 6e / 5e | `effectifs_frequences_la_somme_des_frequences_vaut_1` | ☐ |
| Moyenne : linéarité (`moyenne(x + c) = moyenne(x) + c`), moyenne pondérée | 4e | `moyenne_linearite_moyenne_ponderee` | ☐ |
| La moyenne est comprise entre le minimum et le maximum de la série | 4e | `la_moyenne_est_comprise_entre_le_minimum_et` | ☐ |
| La moyenne de plusieurs moyennes n'est pas la moyenne de la série globale | 4e | `la_moyenne_de_plusieurs_moyennes_n_est_pas` | ☐ |
| Médiane : au moins la moitié des valeurs lui sont inférieures ou égales | 4e | `mediane_au_moins_la_moitie_des_valeurs_lui` | ☐ |
| Étendue = max − min ; la moyenne est sensible aux valeurs extrêmes, la médiane non | 6e / 4e | `etendue_max_min_la_moyenne_est_sensible_aux` | ☐ |
| Probabilité : `0 ≤ P(A) ≤ 1`, somme des probabilités des issues = 1 | 3e | `probabilite_somme_des_probabilites_des_issues_1` | ☐ |
| Événement contraire : `P(Ā) = 1 − P(A)` | 3e | `evenement_contraire` | ☐ |
| Équiprobabilité : `P(A) = card(A) / card(Ω)` | 3e | `equiprobabilite` | ☐ |
| Expérience à deux épreuves : arbre pondéré, produit des probabilités le long d'une branche | 3e | `experience_a_deux_epreuves_arbre_pondere_produit_des` | ☐ |

## 7. Algorithmique et programmation

Fichier : `7AlgorithmiqueEtProgrammation.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Boucle bornée : un programme répétant `n` fois une instruction produit tel résultat | 5e | `boucle_bornee_un_programme_repetant_fois_une_instruction` | ☐ |
| Correction d'un programme de calcul : ce qu'il calcule vaut telle expression de l'entrée | 4e / 3e | `correction_d_un_programme_de_calcul_ce_qu` | ☐ |
