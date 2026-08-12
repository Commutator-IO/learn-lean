# Énoncés conservés

*Programme du lycée (filière S)* — énoncés tirés de [lycee.md](../../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## 1. Nombres, calcul algébrique

Fichier : `1NombresCalculAlgebrique.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| `√2` est irrationnel | 2de | `est_irrationnel` | ☐ |
| Un rationnel a un développement décimal périodique, et réciproquement | 2de | `un_rationnel_a_un_developpement_decimal_periodique_et` | ☐ |
| Valeur absolue : `\|x − a\| ≤ r ⟺ x ∈ [a − r, a + r]` | 2de | `valeur_absolue` | ☐ |
| Inégalité triangulaire : `\|x + y\| ≤ \|x\| + \|y\|` | 2de | `inegalite_triangulaire` | ☐ |
| Un produit est nul ⟺ l'un des facteurs est nul ; règle des signes d'un quotient | 2de | `un_produit_est_nul_l_un_des_facteurs` | ☐ |
| Puissances et racines : `√(ab) = √a √b`, `(aⁿ)ᵐ = aⁿᵐ` | 2de | `puissances_et_racines` | ☐ |
| Somme des termes d'une suite arithmétique : `1 + 2 + ⋯ + n = n(n+1)/2` | 1S | `somme_des_termes_d_une_suite_arithmetique` | ☐ |
| Somme géométrique : `1 + q + ⋯ + qⁿ = (1 − qⁿ⁺¹)/(1 − q)` pour `q ≠ 1` | 1S | `somme_geometrique_pour` | ☐ |
| Coefficients binomiaux ; relation de Pascal `C(n,k) + C(n,k+1) = C(n+1,k+1)` | 1S | `coefficients_binomiaux_relation_de_pascal` | ☐ |
| Formule du binôme de Newton | 1S / TS | `formule_du_binome_de_newton` | ☐ |
| Inégalité de Bernoulli : `(1 + a)ⁿ ≥ 1 + na` pour `a ≥ −1` | TS | `inegalite_de_bernoulli_pour` | ☐ |

## 2. Fonctions, second degré

Fichier : `2FonctionsSecondDegre.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Ensemble de définition, image, antécédent ; sens de variation | 2de | `ensemble_de_definition_image_antecedent_sens_de_variation` | ☐ |
| Somme et produit des racines : `x₁ + x₂ = −b/a`, `x₁x₂ = c/a` | 1S | `somme_et_produit_des_racines` | ☐ |
| Sommet de la parabole, axe de symétrie | 1S | `sommet_de_la_parabole_axe_de_symetrie` | ☐ |
| Fonction homographique : ensemble de définition, variations, asymptotes | 1S | `fonction_homographique_ensemble_de_definition_variations_asymptotes` | ☐ |

## 3. Suites

Fichier : `3Suites.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Suites arithmétiques : `uₙ = u₀ + nr` ; suites géométriques : `uₙ = u₀qⁿ` | 1S | `suites_arithmetiques_suites_geometriques` | ☐ |
| Limite d'une suite : définition avec `ε` (ou avec `A` pour `+∞`) | TS | `limite_d_une_suite_definition_avec_ou_avec` | ☐ |
| Unicité de la limite | TS | `unicite_de_la_limite` | ☐ |
| Opérations sur les limites (somme, produit, quotient), formes indéterminées | TS | `operations_sur_les_limites_somme_produit_quotient_formes` | ☐ |
| Limite de `qⁿ` selon `\|q\| < 1`, `q = 1`, `q > 1` | TS | `limite_de_selon` | ☐ |
| Théorèmes de comparaison ; théorème des gendarmes | TS | `theoremes_de_comparaison_theoreme_des_gendarmes` | ☐ |
| Toute suite croissante majorée converge (convergence monotone) | TS | `toute_suite_croissante_majoree_converge_convergence_monotone` | ☐ |
| Toute suite convergente est bornée | TS | `toute_suite_convergente_est_bornee` | ☐ |
| Suites `uₙ₊₁ = f(uₙ)` : si `f` continue et `uₙ → ℓ` alors `f(ℓ) = ℓ` | TS | `suites_si_continue_et_alors` | ☐ |

## 4. Limites, continuité, dérivation

Fichier : `4LimitesContinuiteDerivation.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Limite d'une fonction en un point, en `±∞` ; asymptotes horizontale, verticale, oblique | TS | `limite_d_une_fonction_en_un_point_en` | ☐ |
| Opérations sur les limites ; limite d'une composée | TS | `operations_sur_les_limites_limite_d_une_composee` | ☐ |
| Continuité en un point, sur un intervalle ; toute fonction dérivable est continue | TS | `continuite_en_un_point_sur_un_intervalle_toute` | ☐ |
| Théorème des valeurs intermédiaires | TS | `theoreme_des_valeurs_intermediaires` | ☐ |
| Corollaire : `f` continue strictement monotone sur `[a,b]` ⟹ `f(x) = k` a une solution unique | TS | `corollaire_continue_strictement_monotone_sur_a_une_solution` | ☐ |
| Nombre dérivé comme limite du taux d'accroissement ; équation de la tangente | 1S | `nombre_derive_comme_limite_du_taux_d_accroissement` | ☐ |
| Dérivées usuelles : `xⁿ`, `1/x`, `√x`, `sin`, `cos`, `exp`, `ln` | 1S / TS | `derivees_usuelles` | ☐ |
| Dérivée d'une composée `(v ∘ u)' = u' × (v' ∘ u)` ; cas `u(ax + b)` | 1S / TS | `derivee_d_une_composee_cas` | ☐ |
| Un extremum local en un point intérieur où `f` est dérivable annule `f'` ; la réciproque est fausse | 1S | `un_extremum_local_en_un_point_interieur_ou` | ☐ |
| Dérivée seconde, convexité, point d'inflexion | TS | `derivee_seconde_convexite_point_d_inflexion` | ☐ |

## 5. Exponentielle, logarithme, trigonométrie

Fichier : `5ExponentielleLogarithmeTrigonometrie.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Existence et unicité de `f` dérivable telle que `f' = f` et `f(0) = 1` | TS | `existence_et_unicite_de_derivable_telle_que_et` | ☐ |
| `exp(a + b) = exp(a)exp(b)`, `exp(−a) = 1/exp(a)`, `exp(na) = exp(a)ⁿ` | TS | `enonce` | ☐ |
| Limites : `eˣ → +∞` en `+∞`, `eˣ → 0` en `−∞` | TS | `limites_en_en` | ☐ |
| `ln` réciproque de `exp` : `ln(exp x) = x`, `exp(ln x) = x` pour `x > 0` | TS | `reciproque_de_pour` | ☐ |
| `ln(ab) = ln a + ln b`, `ln(a/b)`, `ln(aⁿ) = n ln a`, `ln √a = ½ ln a` | TS | `enonce` | ☐ |
| `ln` dérivable de dérivée `1/x` ; `ln` strictement croissante | TS | `derivable_de_derivee_strictement_croissante` | ☐ |
| Limites de `ln` en `0⁺` et en `+∞` | TS | `limites_de_en_et_en` | ☐ |
| Cercle trigonométrique, radians ; `cos² + sin² = 1` | 1S | `cercle_trigonometrique_radians` | ☐ |
| Formules d'addition et de duplication de `cos` et `sin` | 1S | `formules_d_addition_et_de_duplication_de_et` | ☐ |
| Résolution de `cos x = a`, `sin x = a` ; périodicité | 1S | `resolution_de_periodicite` | ☐ |
| `sin` et `cos` dérivables, `sin' = cos`, `cos' = −sin` ; `lim (sin x)/x = 1` en 0 | TS | `et_derivables_en_0` | ☐ |

## 6. Intégration

Fichier : `6Integration.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Intégrale d'une fonction continue positive = aire sous la courbe | TS | `integrale_d_une_fonction_continue_positive_aire_sous` | ☐ |
| `x ↦ ∫ₐˣ f(t)dt` est la primitive de `f` qui s'annule en `a` | TS | `est_la_primitive_de_qui_s_annule_en` | ☐ |
| Théorème fondamental : `∫ₐᵇ f = F(b) − F(a)` | TS | `theoreme_fondamental` | ☐ |
| Positivité et croissance : `f ≥ 0 ⟹ ∫ f ≥ 0` ; `f ≤ g ⟹ ∫ f ≤ ∫ g` | TS | `positivite_et_croissance` | ☐ |
| Inégalité de la moyenne ; valeur moyenne `(1/(b−a))∫ₐᵇ f` | TS | `inegalite_de_la_moyenne_valeur_moyenne` | ☐ |

## 7. Nombres complexes

Fichier : `7NombresComplexes.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Forme algébrique `a + ib` ; unicité de l'écriture, `i² = −1` | TS | `forme_algebrique_unicite_de_l_ecriture` | ☐ |
| Conjugué : `conj(z + z') = conj z + conj z'`, `conj(zz') = conj z conj z'`, `z conj z = \|z\|²` | TS | `conjugue` | ☐ |
| `z` réel ⟺ `z = conj z` ; `z` imaginaire pur ⟺ `z = −conj z` | TS | `reel_imaginaire_pur` | ☐ |
| Module : `\|zz'\| = \|z\|\|z'\|`, `\|z + z'\| ≤ \|z\| + \|z'\|` | TS | `module` | ☐ |
| Argument, forme trigonométrique ; `arg(zz') = arg z + arg z'` | TS | `argument_forme_trigonometrique` | ☐ |
| Forme exponentielle `re^{iθ}` ; formules d'Euler et de Moivre | TS | `forme_exponentielle_formules_d_euler_et_de_moivre` | ☐ |
| Interprétation géométrique : affixe, `\|z_B − z_A\|` = distance, `arg((z_C − z_A)/(z_B − z_A))` = angle | TS | `interpretation_geometrique_affixe_distance_angle` | ☐ |
| Alignement et orthogonalité en termes d'affixes ; caractérisation d'un cercle | TS | `alignement_et_orthogonalite_en_termes_d_affixes_caracterisation` | ☐ |

## 8. Géométrie : vecteurs, produit scalaire, espace

Fichier : `8GeometrieVecteursProduitScalaireEspace.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Vecteurs : relation de Chasles, colinéarité ; `AB` et `CD` colinéaires ⟺ `(AB) ∥ (CD)` | 2de | `vecteurs_relation_de_chasles_colinearite_et_colineaires` | ☐ |
| Critère de colinéarité par le déterminant `xy' − x'y = 0` | 2de | `critere_de_colinearite_par_le_determinant` | ☐ |
| Équation de droite `y = mx + p` et `ax + by + c = 0` ; parallélisme et coefficients directeurs | 2de | `equation_de_droite_et_parallelisme_et_coefficients_directeurs` | ☐ |
| Système linéaire 2×2 : existence et unicité de la solution si le déterminant est non nul | 2de / 1S | `systeme_lineaire_22_existence_et_unicite_de_la` | ☐ |
| Produit scalaire : définitions équivalentes (projeté, coordonnées, normes, `\|u\|\|v\|cos θ`) | 1S | `produit_scalaire_definitions_equivalentes_projete_coordonnees_normes` | ☐ |
| Bilinéarité et symétrie du produit scalaire | 1S | `bilinearite_et_symetrie_du_produit_scalaire` | ☐ |
| `u ⊥ v ⟺ u · v = 0` | 1S | `enonce` | ☐ |
| Théorème d'Al-Kashi | 1S | `theoreme_d_al_kashi` | ☐ |
| Théorème de la médiane ; formule des trois normes | 1S | `theoreme_de_la_mediane_formule_des_trois_normes` | ☐ |
| Équation cartésienne d'un cercle ; caractérisation `MA · MB = 0` | 1S | `equation_cartesienne_d_un_cercle_caracterisation` | ☐ |
| Théorème du toit ; parallélisme de deux plans par deux sécantes | TS | `theoreme_du_toit_parallelisme_de_deux_plans_par` | ☐ |
| Produit scalaire dans l'espace ; vecteur normal et équation cartésienne `ax + by + cz + d = 0` | TS | `produit_scalaire_dans_l_espace_vecteur_normal_et` | ☐ |

## 9. Probabilités et statistiques

Fichier : `9ProbabilitesEtStatistiques.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Linéarité de la moyenne ; `écart-type(aX + b) = \|a\| × écart-type(X)` | 1S | `linearite_de_la_moyenne` | ☐ |
| `P(A ∪ B) = P(A) + P(B) − P(A ∩ B)` ; `P(Ā) = 1 − P(A)` | 2de | `enonce` | ☐ |
| `E(aX + b) = aE(X) + b` ; `V(aX + b) = a²V(X)` ; `V(X) = E(X²) − E(X)²` | 1S | `enonce` | ☐ |
| Épreuve et schéma de Bernoulli ; loi binomiale `P(X = k) = C(n,k)pᵏ(1−p)ⁿ⁻ᵏ` | 1S | `epreuve_et_schema_de_bernoulli_loi_binomiale` | ☐ |
| Probabilité conditionnelle `P_A(B) = P(A ∩ B)/P(A)` ; formule des probabilités composées | TS | `probabilite_conditionnelle_formule_des_probabilites_composees` | ☐ |
| Formule des probabilités totales ; arbre pondéré | TS | `formule_des_probabilites_totales_arbre_pondere` | ☐ |
| Loi exponentielle : densité `λe^{−λt}`, `P(X > t) = e^{−λt}`, absence de mémoire, espérance `1/λ` | TS | `loi_exponentielle_densite_absence_de_memoire_esperance` | ☐ |
| Loi normale centrée réduite ; théorème de Moivre–Laplace | TS | `loi_normale_centree_reduite_theoreme_de_moivrelaplace` | ☐ |

## 10. Spécialité mathématiques (terminale S) — Arithmétique

Fichier : `10SpecialiteMathematiquesTerminaleSArithmetique.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Divisibilité dans `ℤ` ; division euclidienne, existence et unicité | Spé | `divisibilite_dans_division_euclidienne_existence_et_unicite` | ☐ |
| Congruences modulo `n` : compatibilité avec somme et produit | Spé | `congruences_modulo_compatibilite_avec_somme_et_produit` | ☐ |
| Critères de divisibilité revisités par les congruences | Spé | `criteres_de_divisibilite_revisites_par_les_congruences` | ☐ |
| PGCD, algorithme d'Euclide ; `pgcd(a,b) = pgcd(b, a mod b)` | Spé | `pgcd_algorithme_d_euclide` | ☐ |
| Théorème de Bézout : `pgcd(a,b) = 1 ⟺ ∃(u,v), au + bv = 1` | Spé | `theoreme_de_bezout` | ☐ |
| Théorème de Gauss : `a ∣ bc` et `pgcd(a,b) = 1` ⟹ `a ∣ c` | Spé | `theoreme_de_gauss_et` | ☐ |
| Équation diophantienne `ax + by = c` : condition d'existence, forme des solutions | Spé | `equation_diophantienne_condition_d_existence_forme_des_solutions` | ☐ |
| Infinité des nombres premiers | Spé | `infinite_des_nombres_premiers` | ☐ |
| Décomposition en facteurs premiers : existence et unicité | Spé | `decomposition_en_facteurs_premiers_existence_et_unicite` | ☐ |
| Petit théorème de Fermat : `p` premier, `p ∤ a` ⟹ `a^{p−1} ≡ 1 [p]` | Spé | `petit_theoreme_de_fermat_premier` | ☐ |

## 10. Spécialité mathématiques (terminale S) — Matrices et graphes

Fichier : `10SpecialiteMathematiquesTerminaleSMatricesEtGraphes.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Opérations sur les matrices ; le produit n'est pas commutatif | Spé | `operations_sur_les_matrices_le_produit_n_est` | ☐ |
| Suites `Uₙ₊₁ = AUₙ + B` ; forme explicite et état stable | Spé | `suites_forme_explicite_et_etat_stable` | ☐ |
| Graphe probabiliste, matrice de transition ; convergence vers l'état stable (cas `2×2`) | Spé | `graphe_probabiliste_matrice_de_transition_convergence_vers_l` | ☐ |
