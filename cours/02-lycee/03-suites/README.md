# Suites

*Programme du lycée (filière S)* — énoncés tirés de [lycee.md](../../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Suites

Fichier : `Suites.lean`

| Énoncé | Niveau | Admis | Théorème | Statut |
|---|---|---|---|---|
| Suites arithmétiques : `uₙ = u₀ + nr` ; suites géométriques : `uₙ = u₀qⁿ` | 1S |  | `suites_arithmetiques_suites_geometriques` | ☐ |
| Sens de variation d'une suite arithmétique (signe de `r`), géométrique (signe de `q − 1`, `u₀`) | 1S |  | `sens_de_variation_d_une_suite_arithmetique_signe` | ☐ |
| Limite d'une suite : définition avec `ε` (ou avec `A` pour `+∞`) | TS |  | `limite_d_une_suite_definition_avec_ou_avec` | ☐ |
| Unicité de la limite | TS | oui | `unicite_de_la_limite` | ☐ |
| Opérations sur les limites (somme, produit, quotient), formes indéterminées | TS | oui | `operations_sur_les_limites_somme_produit_quotient_formes` | ☐ |
| Limite de `qⁿ` selon `\|q\| < 1`, `q = 1`, `q > 1` | TS |  | `limite_de_selon` | ☐ |
| Théorèmes de comparaison ; théorème des gendarmes | TS |  | `theoremes_de_comparaison_theoreme_des_gendarmes` | ☐ |
| Toute suite croissante majorée converge (convergence monotone) | TS | oui | `toute_suite_croissante_majoree_converge_convergence_monotone` | ☐ |
| Une suite croissante non majorée tend vers `+∞` | TS |  | `une_suite_croissante_non_majoree_tend_vers` | ☐ |
| Toute suite convergente est bornée | TS |  | `toute_suite_convergente_est_bornee` | ☐ |
| Suites adjacentes ; dichotomie | TS |  | `suites_adjacentes_dichotomie` | ☐ |
| Suites `uₙ₊₁ = f(uₙ)` : si `f` continue et `uₙ → ℓ` alors `f(ℓ) = ℓ` | TS |  | `suites_si_continue_et_alors` | ☐ |
