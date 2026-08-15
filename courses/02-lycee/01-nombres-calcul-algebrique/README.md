# Nombres, calcul algébrique

*Programme du lycée (filière S)* — énoncés tirés de [lycee.md](../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Nombres, calcul algébrique

Fichier : `NombresCalculAlgebrique.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Inclusions `ℕ ⊂ ℤ ⊂ 𝔻 ⊂ ℚ ⊂ ℝ`, strictes | 2de | `inclusions_strictes` | ☑ |
| `√2` est irrationnel | 2de | `est_irrationnel` | ☑ |
| Un rationnel a un développement décimal périodique, et réciproquement | 2de | `un_rationnel_a_un_developpement_decimal_periodique_et` | ◐ |
| Valeur absolue : `\|x − a\| ≤ r ⟺ x ∈ [a − r, a + r]` | 2de | `valeur_absolue` | ☑ |
| Inégalité triangulaire : `\|x + y\| ≤ \|x\| + \|y\|` | 2de | `inegalite_triangulaire` | ☑ |
| Identités remarquables `(a ± b)²`, `a² − b²` | 2de | `identites_remarquables` | ☑ |
| Un produit est nul ⟺ l'un des facteurs est nul ; règle des signes d'un quotient | 2de | `un_produit_est_nul_l_un_des_facteurs` | ☑ |
| Signe de `ax + b` selon le signe de `a` | 2de | `signe_de_selon_le_signe_de` | ☑ |
| Puissances et racines : `√(ab) = √a √b`, `(aⁿ)ᵐ = aⁿᵐ` | 2de | `puissances_et_racines` | ☑ |
| Comparaison de `x`, `x²`, `√x` selon que `x ∈ [0,1]` ou `x ≥ 1` | 2de | `comparaison_de_selon_que_ou` | ☑ |
| Somme des termes d'une suite arithmétique : `1 + 2 + ⋯ + n = n(n+1)/2` | 1S | `somme_des_termes_d_une_suite_arithmetique` | ☑ |
| Somme géométrique : `1 + q + ⋯ + qⁿ = (1 − qⁿ⁺¹)/(1 − q)` pour `q ≠ 1` | 1S | `somme_geometrique_pour` | ☑ |
| Coefficients binomiaux ; relation de Pascal `C(n,k) + C(n,k+1) = C(n+1,k+1)` | 1S | `coefficients_binomiaux_relation_de_pascal` | ☑ |
| Formule du binôme de Newton | 1S / TS | `formule_du_binome_de_newton` | ☑ |
| Raisonnement par récurrence : principe et mise en œuvre | TS | `raisonnement_par_recurrence_principe_et_mise_en_uvre` | ☑ |
| Inégalité de Bernoulli : `(1 + a)ⁿ ≥ 1 + na` pour `a ≥ −1` | TS | `inegalite_de_bernoulli_pour` | ☑ |
