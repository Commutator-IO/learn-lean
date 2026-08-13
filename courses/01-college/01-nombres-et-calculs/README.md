# Nombres et calculs

*Programme du collège* — énoncés tirés de [college.md](../../../college.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Entiers, divisibilité

Fichier : `EntiersDivisibilite.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Un entier est pair ou impair, jamais les deux | 6e | `un_entier_est_pair_ou_impair_jamais_les` | ☑ |
| Somme de deux pairs = pair ; pair + impair = impair ; impair + impair = pair | 6e | `somme_de_deux_pairs_pair_pair_impair_impair` | ☑ |
| Critère de divisibilité par 2, par 5, par 10 (chiffre des unités) | 6e | `critere_de_divisibilite_par_2_par_5_par` | ☑ |
| Critère de divisibilité par 3 et par 9 (somme des chiffres) | 6e | `critere_de_divisibilite_par_3_et_par_9` | ☑ |
| Critère de divisibilité par 4 (deux derniers chiffres) | 5e | `critere_de_divisibilite_par_4_deux_derniers_chiffres` | ☑ |
| Si `a ∣ b` et `a ∣ c` alors `a ∣ (b + c)` et `a ∣ (b − c)` | 5e | `si_et_alors_et` | ☑ |
| Division euclidienne : existence et unicité de `(q, r)` avec `a = bq + r`, `0 ≤ r < b` | 6e | `division_euclidienne_existence_et_unicite_de_avec` | ☑ |
| Nombre premier ; tout entier > 1 admet un diviseur premier | 3e | `nombre_premier_tout_entier_1_admet_un_diviseur` | ☑ |
| PGCD, algorithme d'Euclide : `pgcd(a, b) = pgcd(b, a mod b)` | 3e | `pgcd_algorithme_d_euclide` | ☑ |
| Nombres premiers entre eux ⟺ `pgcd = 1` | 3e | `nombres_premiers_entre_eux` | ☑ |
| Décomposition en facteurs premiers : existence et unicité à l'ordre près | 3e | `decomposition_en_facteurs_premiers_existence_et_unicite_a` | ☑ |
| Toute fraction admet une écriture irréductible | 3e | `toute_fraction_admet_une_ecriture_irreductible` | ☑ |

## Écritures des nombres

Fichier : `EcrituresDesNombres.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Égalité de fractions : `a/b = (ka)/(kb)` pour `k ≠ 0` | 5e | `egalite_de_fractions_pour` | ☑ |
| Une fraction n'a pas toujours d'écriture décimale exacte (`1/3`) | 5e | `une_fraction_n_a_pas_toujours_d_ecriture` | ☑ |
| Écriture scientifique : existence et unicité de `a × 10ⁿ` avec `1 ≤ \|a\| < 10` | 4e | `ecriture_scientifique_existence_et_unicite_de_avec` | ☑ |
| Racine carrée : `(√a)² = a` et `√(a²) = a` pour `a ≥ 0` | 3e | `racine_carree_et_pour` | ☑ |
| `√(ab) = √a × √b` et `√(a/b) = √a / √b` (`a ≥ 0`, `b > 0`) | 3e | `et` | ☑ |
| Contre-exemple : `√(a + b) ≠ √a + √b` en général | 3e | `contre_exemple_en_general` | ☑ |
| Rationnels et irrationnels : `√2` n'est pas rationnel (admis au collège) | 3e | `rationnels_et_irrationnels_n_est_pas_rationnel_admis` | ☑ |

## Calculs et calcul littéral

Fichier : `CalculsEtCalculLitteral.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Règle des signes pour la multiplication et la division | 5e | `regle_des_signes_pour_la_multiplication_et_la` | ☑ |
| Distributivité simple : `k(a + b) = ka + kb` | 5e | `distributivite_simple` | ☑ |
| Double distributivité : `(a + b)(c + d) = ac + ad + bc + bd` | 4e | `double_distributivite` | ☑ |
| Un produit est nul ⟺ l'un des facteurs est nul | 3e | `un_produit_est_nul_l_un_des_facteurs` | ☑ |
| Puissances : `aᵐ × aⁿ = aᵐ⁺ⁿ`, `aᵐ / aⁿ = aᵐ⁻ⁿ`, `(aᵐ)ⁿ = aᵐⁿ`, `(ab)ⁿ = aⁿbⁿ` | 4e | `puissances` | ☑ |
| `a⁻ⁿ = 1/aⁿ` pour `a ≠ 0` ; `a⁰ = 1` | 4e | `pour` | ☑ |
| Conservation des inégalités : `a ≤ b ⟹ a + c ≤ b + c` ; multiplier par `c > 0` conserve, par `c < 0` inverse | 4e | `conservation_des_inegalites_multiplier_par_conserve_par_inverse` | ☑ |
| Équation du premier degré `ax + b = 0` : solution unique si `a ≠ 0` | 4e / 3e | `equation_du_premier_degre_solution_unique_si` | ☑ |
| Équation produit `(ax + b)(cx + d) = 0` | 3e | `equation_produit` | ☑ |
