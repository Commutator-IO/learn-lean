# Arithmétique, matrices et graphes

*Programme du lycée (filière S)* — énoncés tirés de [lycee.md](../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Arithmétique

Fichier : `Arithmetique.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Divisibilité dans `ℤ` ; division euclidienne, existence et unicité | Spé | `divisibilite_dans_division_euclidienne_existence_et_unicite` | ☑ |
| Congruences modulo `n` : compatibilité avec somme et produit | Spé | `congruences_modulo_compatibilite_avec_somme_et_produit` | ☑ |
| Critères de divisibilité revisités par les congruences | Spé | `criteres_de_divisibilite_revisites_par_les_congruences` | ☑ |
| PGCD, algorithme d'Euclide ; `pgcd(a,b) = pgcd(b, a mod b)` | Spé | `pgcd_algorithme_d_euclide` | ☑ |
| Théorème de Bézout : `pgcd(a,b) = 1 ⟺ ∃(u,v), au + bv = 1` | Spé | `theoreme_de_bezout` | ☑ |
| Théorème de Gauss : `a ∣ bc` et `pgcd(a,b) = 1` ⟹ `a ∣ c` | Spé | `theoreme_de_gauss_et` | ☑ |
| Équation diophantienne `ax + by = c` : condition d'existence, forme des solutions | Spé | `equation_diophantienne_condition_d_existence_forme_des_solutions` | ☑ |
| Infinité des nombres premiers | Spé | `infinite_des_nombres_premiers` | ☑ |
| Décomposition en facteurs premiers : existence et unicité | Spé | `decomposition_en_facteurs_premiers_existence_et_unicite` | ☑ |
| Petit théorème de Fermat : `p` premier, `p ∤ a` ⟹ `a^{p−1} ≡ 1 [p]` | Spé | `petit_theoreme_de_fermat_premier` | ☑ |
| Application au chiffrement (RSA, code affine) | Spé | `application_au_chiffrement_rsa_code_affine` | ◐ |

## Matrices et graphes

Fichier : `MatricesEtGraphes.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Opérations sur les matrices ; le produit n'est pas commutatif | Spé | `operations_sur_les_matrices_le_produit_n_est` | ☑ |
| Matrice inversible ; inverse d'une matrice `2×2` et condition `ad − bc ≠ 0` | Spé | `matrice_inversible_inverse_d_une_matrice_et_condition` | ☑ |
| Écriture matricielle d'un système linéaire ; résolution par l'inverse | Spé | `ecriture_matricielle_d_un_systeme_lineaire_resolution_par` | ☑ |
| Puissances `Aⁿ` ; calcul par diagonalisation dans les cas simples | Spé | `puissances_calcul_par_diagonalisation_dans_les_cas_simples` | ☑ |
| Suites `Uₙ₊₁ = AUₙ + B` ; forme explicite et état stable | Spé | `suites_forme_explicite_et_etat_stable` | ☑ |
| Graphe probabiliste, matrice de transition ; convergence vers l'état stable (cas `2×2`) | Spé | `graphe_probabiliste_matrice_de_transition_convergence_vers_l` | ☑ |
