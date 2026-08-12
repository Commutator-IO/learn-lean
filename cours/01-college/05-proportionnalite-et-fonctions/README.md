# Proportionnalité et fonctions

*Programme du collège* — énoncés tirés de [college.md](../../../college.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Proportionnalité et fonctions

Fichier : `ProportionnaliteEtFonctions.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Un tableau est proportionnel ⟺ les produits en croix sont égaux | 6e / 4e | `un_tableau_est_proportionnel_les_produits_en_croix` | ☑ |
| Égalité des produits en croix : `a/b = c/d ⟺ ad = bc` (`b, d ≠ 0`) | 4e | `egalite_des_produits_en_croix` | ☑ |
| Composition de deux évolutions : appliquer `p` puis `q` revient à multiplier par `(1+p)(1+q)` | 4e | `composition_de_deux_evolutions_appliquer_puis_revient_a` | ☑ |
| Une évolution de `+p` puis `−p` ne ramène pas à la valeur initiale | 4e | `une_evolution_de_puis_ne_ramene_pas_a` | ☑ |
| Une image est unique, un antécédent ne l'est pas nécessairement | 3e | `une_image_est_unique_un_antecedent_ne_l` | ☑ |
| Fonction linéaire `x ↦ ax` : traduit exactement la proportionnalité ; graphe = droite par l'origine | 3e | `fonction_lineaire_traduit_exactement_la_proportionnalite_graphe_droite` | ☑ |
| Fonction affine `x ↦ ax + b` : graphe = droite ; `a` coefficient directeur, `b` ordonnée à l'origine | 3e | `fonction_affine_graphe_droite_coefficient_directeur_ordonnee_a` | ☑ |
| `a = (f(x₂) − f(x₁)) / (x₂ − x₁)` pour une fonction affine | 3e | `pour_une_fonction_affine` | ☑ |
| Sens de variation d'une fonction affine selon le signe de `a` | 3e | `sens_de_variation_d_une_fonction_affine_selon` | ☑ |
