# Géométrie : vecteurs, produit scalaire, espace

*Programme du lycée (filière S)* — énoncés tirés de [lycee.md](../../lycee.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Géométrie : vecteurs, produit scalaire, espace

Fichier : `GeometrieVecteursProduitScalaireEspace.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Vecteurs : relation de Chasles, colinéarité ; `AB` et `CD` colinéaires ⟺ `(AB) ∥ (CD)` | 2de | `vecteurs_relation_de_chasles_colinearite_et_colineaires` | ☑ |
| Critère de colinéarité par le déterminant `xy' − x'y = 0` | 2de | `critere_de_colinearite_par_le_determinant` | ☑ |
| Décomposition unique d'un vecteur dans une base du plan | 2de / 1S | `decomposition_unique_d_un_vecteur_dans_une_base` | ☑ |
| Coordonnées du milieu, distance entre deux points | 2de | `coordonnees_du_milieu_distance_entre_deux_points` | ☑ |
| Équation de droite `y = mx + p` et `ax + by + c = 0` ; parallélisme et coefficients directeurs | 2de | `equation_de_droite_et_parallelisme_et_coefficients_directeurs` | ☑ |
| Système linéaire 2×2 : existence et unicité de la solution si le déterminant est non nul | 2de / 1S | `systeme_lineaire_22_existence_et_unicite_de_la` | ☑ |
| Produit scalaire : définitions équivalentes (projeté, coordonnées, normes, `\|u\|\|v\|cos θ`) | 1S | `produit_scalaire_definitions_equivalentes_projete_coordonnees_normes` | ☑ |
| Bilinéarité et symétrie du produit scalaire | 1S | `bilinearite_et_symetrie_du_produit_scalaire` | ☑ |
| `u ⊥ v ⟺ u · v = 0` | 1S | `enonce` | ☑ |
| Théorème d'Al-Kashi | 1S | `theoreme_d_al_kashi` | ☑ |
| Théorème de la médiane ; formule des trois normes | 1S | `theoreme_de_la_mediane_formule_des_trois_normes` | ☑ |
| Équation cartésienne d'un cercle ; caractérisation `MA · MB = 0` | 1S | `equation_cartesienne_d_un_cercle_caracterisation` | ☑ |
| Loi des sinus ; aire `½ ab sin C` | 1S | `loi_des_sinus_aire` | ☑ |
| Géométrie dans l'espace : positions relatives de droites et plans | TS | `geometrie_dans_l_espace_positions_relatives_de_droites` | ◐ |
| Théorème du toit ; parallélisme de deux plans par deux sécantes | TS | `theoreme_du_toit_parallelisme_de_deux_plans_par` | ☐ |
| Vecteurs de l'espace, coplanarité, repère et base | TS | `vecteurs_de_l_espace_coplanarite_repere_et_base` | ☑ |
| Représentation paramétrique d'une droite, d'un plan | TS | `representation_parametrique_d_une_droite_d_un_plan` | ☑ |
| Produit scalaire dans l'espace ; vecteur normal et équation cartésienne `ax + by + cz + d = 0` | TS | `produit_scalaire_dans_l_espace_vecteur_normal_et` | ☑ |
| Distance d'un point à un plan ; intersection droite-plan, plan-plan | TS | `distance_d_un_point_a_un_plan_intersection` | ◐ |
