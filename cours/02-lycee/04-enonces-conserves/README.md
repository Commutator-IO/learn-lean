# Énoncés conservés

*Programme du lycée (filière S)* — énoncés tirés de [lycee.md](../../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## 1. Nombres, calcul algébrique

Fichier : `1NombresCalculAlgebrique.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Inclusions `ℕ ⊂ ℤ ⊂ 𝔻 ⊂ ℚ ⊂ ℝ`, strictes *(hors programme 2026)* | 2de | `inclusions_strictes_hors_programme_2026` | ☐ |
| `√2` est irrationnel *(hors programme 2026)* | 2de | `est_irrationnel_hors_programme_2026` | ☐ |
| Un rationnel a un développement décimal périodique, et réciproquement *(hors programme 2026)* | 2de | `un_rationnel_a_un_developpement_decimal_periodique_et` | ☐ |
| Valeur absolue : `\|x − a\| ≤ r ⟺ x ∈ [a − r, a + r]` | 2de | `valeur_absolue` | ☐ |
| Inégalité triangulaire : `\|x + y\| ≤ \|x\| + \|y\|` *(hors programme 2026)* | 2de | `inegalite_triangulaire_hors_programme_2026` | ☐ |
| Identités remarquables `(a ± b)²`, `a² − b²` *(hors programme 2026)* | 2de | `identites_remarquables_hors_programme_2026` | ☐ |
| Un produit est nul ⟺ l'un des facteurs est nul ; règle des signes d'un quotient | 2de | `un_produit_est_nul_l_un_des_facteurs` | ☐ |
| Signe de `ax + b` selon le signe de `a` | 2de | `signe_de_selon_le_signe_de` | ☐ |
| Puissances et racines : `√(ab) = √a √b`, `(aⁿ)ᵐ = aⁿᵐ` | 2de | `puissances_et_racines` | ☐ |
| Comparaison de `x`, `x²`, `√x` selon que `x ∈ [0,1]` ou `x ≥ 1` *(hors programme 2026)* | 2de | `comparaison_de_selon_que_ou_hors_programme_2026` | ☐ |
| Somme des termes d'une suite arithmétique : `1 + 2 + ⋯ + n = n(n+1)/2` | 1S | `somme_des_termes_d_une_suite_arithmetique` | ☐ |
| Somme géométrique : `1 + q + ⋯ + qⁿ = (1 − qⁿ⁺¹)/(1 − q)` pour `q ≠ 1` *(hors programme 2026)* | 1S | `somme_geometrique_pour_hors_programme_2026` | ☐ |
| Coefficients binomiaux ; relation de Pascal `C(n,k) + C(n,k+1) = C(n+1,k+1)` | 1S | `coefficients_binomiaux_relation_de_pascal` | ☐ |
| Formule du binôme de Newton *(hors programme 2026)* | 1S / TS | `formule_du_binome_de_newton_hors_programme_2026` | ☐ |
| Raisonnement par récurrence : principe et mise en œuvre *(hors programme 2026)* | TS | `raisonnement_par_recurrence_principe_et_mise_en_uvre` | ☐ |
| Inégalité de Bernoulli : `(1 + a)ⁿ ≥ 1 + na` pour `a ≥ −1` *(hors programme 2026)* | TS | `inegalite_de_bernoulli_pour_hors_programme_2026` | ☐ |

## 2. Fonctions, second degré

Fichier : `2FonctionsSecondDegre.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Ensemble de définition, image, antécédent ; sens de variation *(hors programme 2026)* | 2de | `ensemble_de_definition_image_antecedent_sens_de_variation` | ☐ |
| Fonctions de référence : affine, carré, inverse, racine, cube — variations et courbes | 2de | `fonctions_de_reference_affine_carre_inverse_racine_cube` | ☐ |
| Une fonction croissante conserve l'ordre ; composition avec une fonction décroissante l'inverse *(hors programme 2026)* | 2de | `une_fonction_croissante_conserve_l_ordre_composition_avec` | ☐ |
| Forme canonique d'un trinôme `ax² + bx + c` *(hors programme 2026)* | 1S | `forme_canonique_d_un_trinome_hors_programme_2026` | ☐ |
| Discriminant : nombre de racines réelles selon le signe de `Δ` *(hors programme 2026)* | 1S | `discriminant_nombre_de_racines_reelles_selon_le_signe` | ☐ |
| Factorisation `a(x − x₁)(x − x₂)` et signe du trinôme (« du signe de `a` sauf entre les racines ») *(hors programme 2026)* | 1S | `factorisation_et_signe_du_trinome_du_signe_de` | ☐ |
| Somme et produit des racines : `x₁ + x₂ = −b/a`, `x₁x₂ = c/a` | 1S | `somme_et_produit_des_racines` | ☐ |
| Sommet de la parabole, axe de symétrie *(hors programme 2026)* | 1S | `sommet_de_la_parabole_axe_de_symetrie_hors` | ☐ |
| Fonction homographique : ensemble de définition, variations, asymptotes *(hors programme 2026)* | 1S | `fonction_homographique_ensemble_de_definition_variations_asymptotes_hors` | ☐ |
| Parité : symétrie de la courbe par rapport à l'axe des ordonnées ou à l'origine *(hors programme 2026)* | 2de / 1S | `parite_symetrie_de_la_courbe_par_rapport_a` | ☐ |

## 3. Suites

Fichier : `3Suites.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Suites arithmétiques : `uₙ = u₀ + nr` ; suites géométriques : `uₙ = u₀qⁿ` | 1S | `suites_arithmetiques_suites_geometriques` | ☐ |
| Sens de variation d'une suite arithmétique (signe de `r`), géométrique (signe de `q − 1`, `u₀`) | 1S | `sens_de_variation_d_une_suite_arithmetique_signe` | ☐ |
| Limite d'une suite : définition avec `ε` (ou avec `A` pour `+∞`) | TS | `limite_d_une_suite_definition_avec_ou_avec` | ☐ |
| Unicité de la limite *(hors programme 2026)* | TS | `unicite_de_la_limite_hors_programme_2026` | ☐ |
| Opérations sur les limites (somme, produit, quotient), formes indéterminées | TS | `operations_sur_les_limites_somme_produit_quotient_formes` | ☐ |
| Limite de `qⁿ` selon `\|q\| < 1`, `q = 1`, `q > 1` *(hors programme 2026)* | TS | `limite_de_selon_hors_programme_2026` | ☐ |
| Théorèmes de comparaison ; théorème des gendarmes | TS | `theoremes_de_comparaison_theoreme_des_gendarmes` | ☐ |
| Toute suite croissante majorée converge (convergence monotone) | TS | `toute_suite_croissante_majoree_converge_convergence_monotone` | ☐ |
| Une suite croissante non majorée tend vers `+∞` | TS | `une_suite_croissante_non_majoree_tend_vers` | ☐ |
| Toute suite convergente est bornée | TS | `toute_suite_convergente_est_bornee` | ☐ |
| Suites adjacentes ; dichotomie *(hors programme 2026)* | TS | `suites_adjacentes_dichotomie_hors_programme_2026` | ☐ |
| Suites `uₙ₊₁ = f(uₙ)` : si `f` continue et `uₙ → ℓ` alors `f(ℓ) = ℓ` | TS | `suites_si_continue_et_alors` | ☐ |

## 4. Limites, continuité, dérivation

Fichier : `4LimitesContinuiteDerivation.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Limite d'une fonction en un point, en `±∞` ; asymptotes horizontale, verticale, oblique *(hors programme 2026)* | TS | `limite_d_une_fonction_en_un_point_en` | ☐ |
| Opérations sur les limites ; limite d'une composée | TS | `operations_sur_les_limites_limite_d_une_composee` | ☐ |
| Croissances comparées : `eˣ/xⁿ → +∞`, `ln x / x → 0`, `x ln x → 0` *(hors programme 2026)* | TS | `croissances_comparees_hors_programme_2026` | ☐ |
| Continuité en un point, sur un intervalle ; toute fonction dérivable est continue | TS | `continuite_en_un_point_sur_un_intervalle_toute` | ☐ |
| Théorème des valeurs intermédiaires | TS | `theoreme_des_valeurs_intermediaires` | ☐ |
| Corollaire : `f` continue strictement monotone sur `[a,b]` ⟹ `f(x) = k` a une solution unique *(hors programme 2026)* | TS | `corollaire_continue_strictement_monotone_sur_a_une_solution` | ☐ |
| Nombre dérivé comme limite du taux d'accroissement ; équation de la tangente | 1S | `nombre_derive_comme_limite_du_taux_d_accroissement` | ☐ |
| Dérivées usuelles : `xⁿ`, `1/x`, `√x`, `sin`, `cos`, `exp`, `ln` *(hors programme 2026)* | 1S / TS | `derivees_usuelles_hors_programme_2026` | ☐ |
| Opérations : `(u + v)'`, `(uv)'`, `(1/v)'`, `(u/v)'` *(hors programme 2026)* | 1S | `operations_hors_programme_2026` | ☐ |
| Dérivée d'une composée `(v ∘ u)' = u' × (v' ∘ u)` ; cas `u(ax + b)` | 1S / TS | `derivee_d_une_composee_cas` | ☐ |
| Signe de `f'` et sens de variation de `f` | 1S | `signe_de_et_sens_de_variation_de` | ☐ |
| Un extremum local en un point intérieur où `f` est dérivable annule `f'` ; la réciproque est fausse *(hors programme 2026)* | 1S | `un_extremum_local_en_un_point_interieur_ou` | ☐ |
| Dérivée seconde, convexité, point d'inflexion *(hors programme 2026)* | TS | `derivee_seconde_convexite_point_d_inflexion_hors_programme` | ☐ |

## 5. Exponentielle, logarithme, trigonométrie

Fichier : `5ExponentielleLogarithmeTrigonometrie.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Existence et unicité de `f` dérivable telle que `f' = f` et `f(0) = 1` *(hors programme 2026)* | TS | `existence_et_unicite_de_derivable_telle_que_et` | ☐ |
| `exp(a + b) = exp(a)exp(b)`, `exp(−a) = 1/exp(a)`, `exp(na) = exp(a)ⁿ` *(hors programme 2026)* | TS | `hors_programme_2026` | ☐ |
| `exp(x) > 0` pour tout `x` ; `exp` strictement croissante *(hors programme 2026)* | TS | `pour_tout_strictement_croissante_hors_programme_2026` | ☐ |
| Limites : `eˣ → +∞` en `+∞`, `eˣ → 0` en `−∞` *(hors programme 2026)* | TS | `limites_en_en_hors_programme_2026` | ☐ |
| `ln` réciproque de `exp` : `ln(exp x) = x`, `exp(ln x) = x` pour `x > 0` *(hors programme 2026)* | TS | `reciproque_de_pour_hors_programme_2026` | ☐ |
| `ln(ab) = ln a + ln b`, `ln(a/b)`, `ln(aⁿ) = n ln a`, `ln √a = ½ ln a` *(hors programme 2026)* | TS | `hors_programme_2026` | ☐ |
| `ln` dérivable de dérivée `1/x` ; `ln` strictement croissante | TS | `derivable_de_derivee_strictement_croissante` | ☐ |
| Limites de `ln` en `0⁺` et en `+∞` *(hors programme 2026)* | TS | `limites_de_en_et_en_hors_programme_2026` | ☐ |
| Cercle trigonométrique, radians ; `cos² + sin² = 1` | 1S | `cercle_trigonometrique_radians` | ☐ |
| Valeurs remarquables et angles associés (`−x`, `π − x`, `π/2 − x`…) | 1S | `valeurs_remarquables_et_angles_associes` | ☐ |
| Formules d'addition et de duplication de `cos` et `sin` *(hors programme 2026)* | 1S | `formules_d_addition_et_de_duplication_de_et` | ☐ |
| Résolution de `cos x = a`, `sin x = a` ; périodicité *(hors programme 2026)* | 1S | `resolution_de_periodicite_hors_programme_2026` | ☐ |
| `sin` et `cos` dérivables, `sin' = cos`, `cos' = −sin` ; `lim (sin x)/x = 1` en 0 *(hors programme 2026)* | TS | `et_derivables_en_0_hors_programme_2026` | ☐ |

## 6. Intégration

Fichier : `6Integration.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Intégrale d'une fonction continue positive = aire sous la courbe | TS | `integrale_d_une_fonction_continue_positive_aire_sous` | ☐ |
| Toute fonction continue sur un intervalle admet des primitives | TS | `toute_fonction_continue_sur_un_intervalle_admet_des` | ☐ |
| `x ↦ ∫ₐˣ f(t)dt` est la primitive de `f` qui s'annule en `a` *(hors programme 2026)* | TS | `est_la_primitive_de_qui_s_annule_en` | ☐ |
| Deux primitives d'une même fonction diffèrent d'une constante | TS | `deux_primitives_d_une_meme_fonction_different_d` | ☐ |
| Théorème fondamental : `∫ₐᵇ f = F(b) − F(a)` *(hors programme 2026)* | TS | `theoreme_fondamental_hors_programme_2026` | ☐ |
| Linéarité de l'intégrale *(hors programme 2026)* | TS | `linearite_de_l_integrale_hors_programme_2026` | ☐ |
| Relation de Chasles | TS | `relation_de_chasles` | ☐ |
| Positivité et croissance : `f ≥ 0 ⟹ ∫ f ≥ 0` ; `f ≤ g ⟹ ∫ f ≤ ∫ g` | TS | `positivite_et_croissance` | ☐ |
| Inégalité de la moyenne ; valeur moyenne `(1/(b−a))∫ₐᵇ f` | TS | `inegalite_de_la_moyenne_valeur_moyenne` | ☐ |
| Intégration par parties | TS | `integration_par_parties` | ☐ |
| Aire entre deux courbes ; volume d'un solide de révolution (approche) *(hors programme 2026)* | TS | `aire_entre_deux_courbes_volume_d_un_solide` | ☐ |

## 7. Nombres complexes

Fichier : `7NombresComplexes.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Forme algébrique `a + ib` ; unicité de l'écriture, `i² = −1` *(hors programme 2026)* | TS | `forme_algebrique_unicite_de_l_ecriture_hors_programme` | ☐ |
| Conjugué : `conj(z + z') = conj z + conj z'`, `conj(zz') = conj z conj z'`, `z conj z = \|z\|²` *(hors programme 2026)* | TS | `conjugue_hors_programme_2026` | ☐ |
| `z` réel ⟺ `z = conj z` ; `z` imaginaire pur ⟺ `z = −conj z` *(hors programme 2026)* | TS | `reel_imaginaire_pur_hors_programme_2026` | ☐ |
| Module : `\|zz'\| = \|z\|\|z'\|`, `\|z + z'\| ≤ \|z\| + \|z'\|` *(hors programme 2026)* | TS | `module_hors_programme_2026` | ☐ |
| Argument, forme trigonométrique ; `arg(zz') = arg z + arg z'` *(hors programme 2026)* | TS | `argument_forme_trigonometrique_hors_programme_2026` | ☐ |
| Forme exponentielle `re^{iθ}` ; formules d'Euler et de Moivre *(hors programme 2026)* | TS | `forme_exponentielle_formules_d_euler_et_de_moivre` | ☐ |
| Équation du second degré à coefficients réels avec `Δ < 0` : deux racines conjuguées *(hors programme 2026)* | TS | `equation_du_second_degre_a_coefficients_reels_avec` | ☐ |
| Interprétation géométrique : affixe, `\|z_B − z_A\|` = distance, `arg((z_C − z_A)/(z_B − z_A))` = angle *(hors programme 2026)* | TS | `interpretation_geometrique_affixe_distance_angle_hors_programme_2026` | ☐ |
| Alignement et orthogonalité en termes d'affixes ; caractérisation d'un cercle *(hors programme 2026)* | TS | `alignement_et_orthogonalite_en_termes_d_affixes_caracterisation` | ☐ |
| Écriture complexe d'une translation, d'une rotation, d'une homothétie *(hors programme 2026)* | TS | `ecriture_complexe_d_une_translation_d_une_rotation` | ☐ |

## 8. Géométrie : vecteurs, produit scalaire, espace

Fichier : `8GeometrieVecteursProduitScalaireEspace.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Vecteurs : relation de Chasles, colinéarité ; `AB` et `CD` colinéaires ⟺ `(AB) ∥ (CD)` *(hors programme 2026)* | 2de | `vecteurs_relation_de_chasles_colinearite_et_colineaires_hors` | ☐ |
| Critère de colinéarité par le déterminant `xy' − x'y = 0` | 2de | `critere_de_colinearite_par_le_determinant` | ☐ |
| Décomposition unique d'un vecteur dans une base du plan | 2de / 1S | `decomposition_unique_d_un_vecteur_dans_une_base` | ☐ |
| Coordonnées du milieu, distance entre deux points | 2de | `coordonnees_du_milieu_distance_entre_deux_points` | ☐ |
| Équation de droite `y = mx + p` et `ax + by + c = 0` ; parallélisme et coefficients directeurs *(hors programme 2026)* | 2de | `equation_de_droite_et_parallelisme_et_coefficients_directeurs` | ☐ |
| Système linéaire 2×2 : existence et unicité de la solution si le déterminant est non nul *(hors programme 2026)* | 2de / 1S | `systeme_lineaire_22_existence_et_unicite_de_la` | ☐ |
| Produit scalaire : définitions équivalentes (projeté, coordonnées, normes, `\|u\|\|v\|cos θ`) *(hors programme 2026)* | 1S | `produit_scalaire_definitions_equivalentes_projete_coordonnees_normes_hors` | ☐ |
| Bilinéarité et symétrie du produit scalaire | 1S | `bilinearite_et_symetrie_du_produit_scalaire` | ☐ |
| `u ⊥ v ⟺ u · v = 0` *(hors programme 2026)* | 1S | `hors_programme_2026` | ☐ |
| Théorème d'Al-Kashi *(hors programme 2026)* | 1S | `theoreme_d_al_kashi_hors_programme_2026` | ☐ |
| Théorème de la médiane ; formule des trois normes *(hors programme 2026)* | 1S | `theoreme_de_la_mediane_formule_des_trois_normes` | ☐ |
| Équation cartésienne d'un cercle ; caractérisation `MA · MB = 0` | 1S | `equation_cartesienne_d_un_cercle_caracterisation` | ☐ |
| Loi des sinus ; aire `½ ab sin C` *(hors programme 2026)* | 1S | `loi_des_sinus_aire_hors_programme_2026` | ☐ |
| Géométrie dans l'espace : positions relatives de droites et plans *(hors programme 2026)* | TS | `geometrie_dans_l_espace_positions_relatives_de_droites` | ☐ |
| Théorème du toit ; parallélisme de deux plans par deux sécantes *(hors programme 2026)* | TS | `theoreme_du_toit_parallelisme_de_deux_plans_par` | ☐ |
| Vecteurs de l'espace, coplanarité, repère et base *(hors programme 2026)* | TS | `vecteurs_de_l_espace_coplanarite_repere_et_base` | ☐ |
| Représentation paramétrique d'une droite, d'un plan | TS | `representation_parametrique_d_une_droite_d_un_plan` | ☐ |
| Produit scalaire dans l'espace ; vecteur normal et équation cartésienne `ax + by + cz + d = 0` *(hors programme 2026)* | TS | `produit_scalaire_dans_l_espace_vecteur_normal_et` | ☐ |
| Distance d'un point à un plan ; intersection droite-plan, plan-plan | TS | `distance_d_un_point_a_un_plan_intersection` | ☐ |

## 9. Probabilités et statistiques

Fichier : `9ProbabilitesEtStatistiques.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Moyenne, médiane, quartiles, écart interquartile, écart-type *(hors programme 2026)* | 2de / 1S | `moyenne_mediane_quartiles_ecart_interquartile_ecart_type_hors` | ☐ |
| Linéarité de la moyenne ; `écart-type(aX + b) = \|a\| × écart-type(X)` | 1S | `linearite_de_la_moyenne` | ☐ |
| `P(A ∪ B) = P(A) + P(B) − P(A ∩ B)` ; `P(Ā) = 1 − P(A)` *(hors programme 2026)* | 2de | `hors_programme_2026` | ☐ |
| Variable aléatoire : loi, espérance, variance, écart-type | 1S | `variable_aleatoire_loi_esperance_variance_ecart_type` | ☐ |
| `E(aX + b) = aE(X) + b` ; `V(aX + b) = a²V(X)` ; `V(X) = E(X²) − E(X)²` *(hors programme 2026)* | 1S | `hors_programme_2026` | ☐ |
| Épreuve et schéma de Bernoulli ; loi binomiale `P(X = k) = C(n,k)pᵏ(1−p)ⁿ⁻ᵏ` | 1S | `epreuve_et_schema_de_bernoulli_loi_binomiale` | ☐ |
| Espérance et variance d'une binomiale : `np` et `np(1−p)` | 1S | `esperance_et_variance_d_une_binomiale_et` | ☐ |
| Probabilité conditionnelle `P_A(B) = P(A ∩ B)/P(A)` ; formule des probabilités composées *(hors programme 2026)* | TS | `probabilite_conditionnelle_formule_des_probabilites_composees_hors_programme` | ☐ |
| Formule des probabilités totales ; arbre pondéré | TS | `formule_des_probabilites_totales_arbre_pondere` | ☐ |
| Indépendance de deux événements ; indépendance et événements contraires | TS | `independance_de_deux_evenements_independance_et_evenements_contraires` | ☐ |
| Loi uniforme sur `[a,b]` : densité, espérance `(a+b)/2` | TS | `loi_uniforme_sur_densite_esperance` | ☐ |
| Loi exponentielle : densité `λe^{−λt}`, `P(X > t) = e^{−λt}`, absence de mémoire, espérance `1/λ` *(hors programme 2026)* | TS | `loi_exponentielle_densite_absence_de_memoire_esperance_hors` | ☐ |
| Loi normale centrée réduite ; théorème de Moivre–Laplace *(hors programme 2026)* | TS | `loi_normale_centree_reduite_theoreme_de_moivrelaplace_hors` | ☐ |
| Loi normale `N(μ, σ²)` ; intervalles `1σ`, `2σ`, `3σ` (68 %, 95 %, 99,7 %) *(hors programme 2026)* | TS | `loi_normale_intervalles_68_95_99_7_hors` | ☐ |
| Intervalle de fluctuation asymptotique au seuil 95 % : `[p ± 1,96√(p(1−p)/n)]` *(hors programme 2026)* | TS | `intervalle_de_fluctuation_asymptotique_au_seuil_95_hors` | ☐ |
| Intervalle de confiance `[f ± 1/√n]` ; prise de décision *(hors programme 2026)* | TS | `intervalle_de_confiance_prise_de_decision_hors_programme` | ☐ |

## 10. Spécialité mathématiques (terminale S) — Arithmétique

Fichier : `10SpecialiteMathematiquesTerminaleSArithmetique.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Divisibilité dans `ℤ` ; division euclidienne, existence et unicité *(hors programme 2026)* | Spé | `divisibilite_dans_division_euclidienne_existence_et_unicite_hors` | ☐ |
| Congruences modulo `n` : compatibilité avec somme et produit *(hors programme 2026)* | Spé | `congruences_modulo_compatibilite_avec_somme_et_produit_hors` | ☐ |
| Critères de divisibilité revisités par les congruences *(hors programme 2026)* | Spé | `criteres_de_divisibilite_revisites_par_les_congruences_hors` | ☐ |
| PGCD, algorithme d'Euclide ; `pgcd(a,b) = pgcd(b, a mod b)` *(hors programme 2026)* | Spé | `pgcd_algorithme_d_euclide_hors_programme_2026` | ☐ |
| Théorème de Bézout : `pgcd(a,b) = 1 ⟺ ∃(u,v), au + bv = 1` *(hors programme 2026)* | Spé | `theoreme_de_bezout_hors_programme_2026` | ☐ |
| Théorème de Gauss : `a ∣ bc` et `pgcd(a,b) = 1` ⟹ `a ∣ c` *(hors programme 2026)* | Spé | `theoreme_de_gauss_et_hors_programme_2026` | ☐ |
| Équation diophantienne `ax + by = c` : condition d'existence, forme des solutions *(hors programme 2026)* | Spé | `equation_diophantienne_condition_d_existence_forme_des_solutions` | ☐ |
| Infinité des nombres premiers *(hors programme 2026)* | Spé | `infinite_des_nombres_premiers_hors_programme_2026` | ☐ |
| Décomposition en facteurs premiers : existence et unicité *(hors programme 2026)* | Spé | `decomposition_en_facteurs_premiers_existence_et_unicite_hors` | ☐ |
| Petit théorème de Fermat : `p` premier, `p ∤ a` ⟹ `a^{p−1} ≡ 1 [p]` *(hors programme 2026)* | Spé | `petit_theoreme_de_fermat_premier_hors_programme_2026` | ☐ |
| Application au chiffrement (RSA, code affine) *(hors programme 2026)* | Spé | `application_au_chiffrement_rsa_code_affine_hors_programme` | ☐ |

## 10. Spécialité mathématiques (terminale S) — Matrices et graphes

Fichier : `10SpecialiteMathematiquesTerminaleSMatricesEtGraphes.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Opérations sur les matrices ; le produit n'est pas commutatif *(hors programme 2026)* | Spé | `operations_sur_les_matrices_le_produit_n_est` | ☐ |
| Matrice inversible ; inverse d'une matrice `2×2` et condition `ad − bc ≠ 0` *(hors programme 2026)* | Spé | `matrice_inversible_inverse_d_une_matrice_et_condition` | ☐ |
| Écriture matricielle d'un système linéaire ; résolution par l'inverse *(hors programme 2026)* | Spé | `ecriture_matricielle_d_un_systeme_lineaire_resolution_par` | ☐ |
| Puissances `Aⁿ` ; calcul par diagonalisation dans les cas simples | Spé | `puissances_calcul_par_diagonalisation_dans_les_cas_simples` | ☐ |
| Suites `Uₙ₊₁ = AUₙ + B` ; forme explicite et état stable *(hors programme 2026)* | Spé | `suites_forme_explicite_et_etat_stable_hors_programme` | ☐ |
| Graphe probabiliste, matrice de transition ; convergence vers l'état stable (cas `2×2`) *(hors programme 2026)* | Spé | `graphe_probabiliste_matrice_de_transition_convergence_vers_l` | ☐ |
