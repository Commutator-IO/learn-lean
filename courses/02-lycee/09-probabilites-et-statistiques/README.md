# Probabilités et statistiques

*Programme du lycée (filière S)* — énoncés tirés de [lycee.md](../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Probabilités et statistiques

Fichier : `ProbabilitesEtStatistiques.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Moyenne, médiane, quartiles, écart interquartile, écart-type | 2de / 1S | `moyenne_mediane_quartiles_ecart_interquartile_ecart_type` | ◐ |
| Linéarité de la moyenne ; `écart-type(aX + b) = \|a\| × écart-type(X)` | 1S | `linearite_de_la_moyenne` | ☑ |
| `P(A ∪ B) = P(A) + P(B) − P(A ∩ B)` ; `P(Ā) = 1 − P(A)` | 2de | `enonce` | ☑ |
| Variable aléatoire : loi, espérance, variance, écart-type | 1S | `variable_aleatoire_loi_esperance_variance_ecart_type` | ☑ |
| `E(aX + b) = aE(X) + b` ; `V(aX + b) = a²V(X)` ; `V(X) = E(X²) − E(X)²` | 1S | `enonce` | ☑ |
| Épreuve et schéma de Bernoulli ; loi binomiale `P(X = k) = C(n,k)pᵏ(1−p)ⁿ⁻ᵏ` | 1S | `epreuve_et_schema_de_bernoulli_loi_binomiale` | ☑ |
| Espérance et variance d'une binomiale : `np` et `np(1−p)` | 1S | `esperance_et_variance_d_une_binomiale_et` | ◐ |
| Probabilité conditionnelle `P_A(B) = P(A ∩ B)/P(A)` ; formule des probabilités composées | TS | `probabilite_conditionnelle_formule_des_probabilites_composees` | ☑ |
| Formule des probabilités totales ; arbre pondéré | TS | `formule_des_probabilites_totales_arbre_pondere` | ☑ |
| Indépendance de deux événements ; indépendance et événements contraires | TS | `independance_de_deux_evenements_independance_et_evenements_contraires` | ☑ |
| Loi uniforme sur `[a,b]` : densité, espérance `(a+b)/2` | TS | `loi_uniforme_sur_densite_esperance` | ☑ |
| Loi exponentielle : densité `λe^{−λt}`, `P(X > t) = e^{−λt}`, absence de mémoire, espérance `1/λ` | TS | `loi_exponentielle_densite_absence_de_memoire_esperance` | ◐ |
| Loi normale centrée réduite ; théorème de Moivre–Laplace | TS | `loi_normale_centree_reduite_theoreme_de_moivrelaplace` | ◐ |
| Loi normale `N(μ, σ²)` ; intervalles `1σ`, `2σ`, `3σ` (68 %, 95 %, 99,7 %) | TS | `loi_normale_intervalles_68_95_99_7` | ◐ |
| Intervalle de fluctuation asymptotique au seuil 95 % : `[p ± 1,96√(p(1−p)/n)]` | TS | `intervalle_de_fluctuation_asymptotique_au_seuil_95` | ☐ |
| Intervalle de confiance `[f ± 1/√n]` ; prise de décision | TS | `intervalle_de_confiance_prise_de_decision` | ☐ |
