# Géométrie plane

*Programme du collège* — énoncés tirés de [college.md](../../../college.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Droites, angles, parallèles

Fichier : `DroitesAnglesParalleles.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Par deux points distincts passe une droite et une seule | 6e | `par_deux_points_distincts_passe_une_droite_et` | ☑ |
| Deux droites perpendiculaires à une même droite sont parallèles entre elles | 6e | `deux_droites_perpendiculaires_a_une_meme_droite_sont` | ☑ |
| Si deux droites sont parallèles, toute perpendiculaire à l'une est perpendiculaire à l'autre | 6e | `si_deux_droites_sont_paralleles_toute_perpendiculaire_a` | ☑ |
| Deux droites parallèles à une même droite sont parallèles entre elles | 6e | `deux_droites_paralleles_a_une_meme_droite_sont` | ☑ |
| Le plus court chemin d'un point à une droite est le segment perpendiculaire | 6e | `le_plus_court_chemin_d_un_point_a` | ☑ |
| Angles opposés par le sommet : ils sont égaux | 6e | `angles_opposes_par_le_sommet_ils_sont_egaux` | ☑ |
| Angles adjacents, complémentaires, supplémentaires | 6e | `angles_adjacents_complementaires_supplementaires` | ☑ |
| Deux parallèles coupées par une sécante : angles alternes-internes et correspondants égaux | 5e | `deux_paralleles_coupees_par_une_secante_angles_alternes` | ☑ |
| Réciproque : égalité de deux angles alternes-internes ⟹ parallélisme | 5e | `reciproque_egalite_de_deux_angles_alternes_internes_parallelisme` | ☑ |
| Caractérisation de la médiatrice : `M` équidistant de `A` et `B` ⟺ `M` sur la médiatrice de `[AB]` | 6e | `caracterisation_de_la_mediatrice_equidistant_de_et_sur` | ☑ |
| Caractérisation de la bissectrice : équidistance aux deux côtés de l'angle | 6e | `caracterisation_de_la_bissectrice_equidistance_aux_deux_cotes` | ☐ |

## Triangles

Fichier : `Triangles.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Somme des angles d'un triangle = 180° | 5e | `somme_des_angles_d_un_triangle_180` | ☑ |
| Angles d'un triangle équilatéral = 60° ; angles à la base d'un isocèle égaux, et réciproque | 5e | `angles_d_un_triangle_equilateral_60_angles_a` | ☑ |
| Inégalité triangulaire : `AC ≤ AB + BC`, égalité ⟺ `B ∈ [AC]` | 5e | `inegalite_triangulaire_egalite` | ☑ |
| Théorème de Pythagore : rectangle en `A` ⟹ `BC² = AB² + AC²` | 4e | `theoreme_de_pythagore_rectangle_en` | ☑ |
| Réciproque de Pythagore : `BC² = AB² + AC²` ⟹ rectangle en `A` | 4e | `reciproque_de_pythagore_rectangle_en` | ☑ |
| Contraposée : `BC² ≠ AB² + AC²` ⟹ non rectangle en `A` | 4e | `contraposee_non_rectangle_en` | ☑ |
| Théorème des milieux : la droite des milieux est parallèle au troisième côté et de longueur moitié | 4e | `theoreme_des_milieux_la_droite_des_milieux_est` | ☑ |
| Réciproque : la parallèle menée par le milieu d'un côté coupe le deuxième côté en son milieu | 4e | `reciproque_la_parallele_menee_par_le_milieu_d` | ☑ |
| Théorème de Thalès (triangle et « papillon ») : `AM/AB = AN/AC = MN/BC` | 3e | `theoreme_de_thales_triangle_et_papillon` | ☑ |
| Réciproque de Thalès : égalité des rapports et bon ordre des points ⟹ parallélisme | 3e | `reciproque_de_thales_egalite_des_rapports_et_bon` | ☑ |
| `cos²x + sin²x = 1` et `tan x = sin x / cos x` | 3e | `et` | ☑ |
| Concours des médiatrices ⟹ cercle circonscrit | 5e | `concours_des_mediatrices_cercle_circonscrit` | ☑ |
| Concours des médianes (centre de gravité), des hauteurs (orthocentre), des bissectrices (cercle inscrit) | 5e / 4e | `concours_des_medianes_centre_de_gravite_des_hauteurs` | ☑ |

## Cercle et quadrilatères

Fichier : `CercleEtQuadrilateres.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Un triangle inscrit dans un cercle dont un côté est un diamètre est rectangle | 4e | `un_triangle_inscrit_dans_un_cercle_dont_un` | ☑ |
| Réciproque : l'hypoténuse est un diamètre du cercle circonscrit | 4e | `reciproque_l_hypotenuse_est_un_diametre_du_cercle` | ☑ |
| Dans un triangle rectangle, la médiane issue de l'angle droit vaut la moitié de l'hypoténuse | 4e | `dans_un_triangle_rectangle_la_mediane_issue_de` | ☑ |
| La tangente à un cercle est perpendiculaire au rayon au point de contact | 3e | `la_tangente_a_un_cercle_est_perpendiculaire_au` | ☑ |
| Parallélogramme ⟺ diagonales se coupant en leur milieu ⟺ côtés opposés parallèles ⟺ côtés opposés de même longueur | 5e | `parallelogramme_diagonales_se_coupant_en_leur_milieu_cotes` | ☐ |
| Dans un parallélogramme, angles opposés égaux et angles consécutifs supplémentaires | 5e | `dans_un_parallelogramme_angles_opposes_egaux_et_angles` | ☑ |

## Repérage et espace

Fichier : `ReperageEtEspace.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Coordonnées du milieu d'un segment | 3e | `coordonnees_du_milieu_d_un_segment` | ☑ |
| Distance entre deux points repérés (via Pythagore) | 3e | `distance_entre_deux_points_reperes_via_pythagore` | ☑ |
