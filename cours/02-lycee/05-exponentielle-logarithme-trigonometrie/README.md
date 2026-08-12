# Exponentielle, logarithme, trigonométrie

*Programme du lycée (filière S)* — énoncés tirés de [lycee.md](../../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Exponentielle, logarithme, trigonométrie

Fichier : `ExponentielleLogarithmeTrigonometrie.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Existence et unicité de `f` dérivable telle que `f' = f` et `f(0) = 1` | TS | `existence_et_unicite_de_derivable_telle_que_et` | ☐ |
| `exp(a + b) = exp(a)exp(b)`, `exp(−a) = 1/exp(a)`, `exp(na) = exp(a)ⁿ` | TS | `enonce` | ☐ |
| `exp(x) > 0` pour tout `x` ; `exp` strictement croissante | TS | `pour_tout_strictement_croissante` | ☐ |
| Limites : `eˣ → +∞` en `+∞`, `eˣ → 0` en `−∞` | TS | `limites_en_en` | ☐ |
| `ln` réciproque de `exp` : `ln(exp x) = x`, `exp(ln x) = x` pour `x > 0` | TS | `reciproque_de_pour` | ☐ |
| `ln(ab) = ln a + ln b`, `ln(a/b)`, `ln(aⁿ) = n ln a`, `ln √a = ½ ln a` | TS | `enonce` | ☐ |
| `ln` dérivable de dérivée `1/x` ; `ln` strictement croissante | TS | `derivable_de_derivee_strictement_croissante` | ☐ |
| Limites de `ln` en `0⁺` et en `+∞` | TS | `limites_de_en_et_en` | ☐ |
| Cercle trigonométrique, radians ; `cos² + sin² = 1` | 1S | `cercle_trigonometrique_radians` | ☐ |
| Valeurs remarquables et angles associés (`−x`, `π − x`, `π/2 − x`…) | 1S | `valeurs_remarquables_et_angles_associes` | ☐ |
| Formules d'addition et de duplication de `cos` et `sin` | 1S | `formules_d_addition_et_de_duplication_de_et` | ☐ |
| Résolution de `cos x = a`, `sin x = a` ; périodicité | 1S | `resolution_de_periodicite` | ☐ |
| `sin` et `cos` dérivables, `sin' = cos`, `cos' = −sin` ; `lim (sin x)/x = 1` en 0 | TS | `et_derivables_en_0` | ☐ |
