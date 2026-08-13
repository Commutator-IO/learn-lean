# Nombres complexes

*Programme du lycée (filière S)* — énoncés tirés de [lycee.md](../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Nombres complexes

Fichier : `NombresComplexes.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Forme algébrique `a + ib` ; unicité de l'écriture, `i² = −1` | TS | `forme_algebrique_unicite_de_l_ecriture` | ☑ |
| Conjugué : `conj(z + z') = conj z + conj z'`, `conj(zz') = conj z conj z'`, `z conj z = \|z\|²` | TS | `conjugue` | ☑ |
| `z` réel ⟺ `z = conj z` ; `z` imaginaire pur ⟺ `z = −conj z` | TS | `reel_imaginaire_pur` | ☑ |
| Module : `\|zz'\| = \|z\|\|z'\|`, `\|z + z'\| ≤ \|z\| + \|z'\|` | TS | `module` | ☑ |
| Argument, forme trigonométrique ; `arg(zz') = arg z + arg z'` | TS | `argument_forme_trigonometrique` | ☑ |
| Forme exponentielle `re^{iθ}` ; formules d'Euler et de Moivre | TS | `forme_exponentielle_formules_d_euler_et_de_moivre` | ☑ |
| Équation du second degré à coefficients réels avec `Δ < 0` : deux racines conjuguées | TS | `equation_du_second_degre_a_coefficients_reels_avec` | ☑ |
| Interprétation géométrique : affixe, `\|z_B − z_A\|` = distance, `arg((z_C − z_A)/(z_B − z_A))` = angle | TS | `interpretation_geometrique_affixe_distance_angle` | ☑ |
| Alignement et orthogonalité en termes d'affixes ; caractérisation d'un cercle | TS | `alignement_et_orthogonalite_en_termes_d_affixes_caracterisation` | ☑ |
| Écriture complexe d'une translation, d'une rotation, d'une homothétie | TS | `ecriture_complexe_d_une_translation_d_une_rotation` | ☑ |
