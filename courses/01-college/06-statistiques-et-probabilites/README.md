# Statistiques et probabilités

*Programme du collège* — énoncés tirés de [college.md](../../../college.md) · retour à l'[index](../README.md).

Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · ✗ non formalisable en l'état.

Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la
colonne *Théorème* donne le nom suggéré, à ajuster librement.

## Statistiques et probabilités

Fichier : `StatistiquesEtProbabilites.lean`

| Énoncé | Niveau | Théorème | Statut |
|---|---|---|---|
| Moyenne : linéarité (`moyenne(x + c) = moyenne(x) + c`), moyenne pondérée | 4e | `moyenne_linearite_moyenne_ponderee` | ☑ |
| La moyenne est comprise entre le minimum et le maximum de la série | 4e | `la_moyenne_est_comprise_entre_le_minimum_et` | ☑ |
| La moyenne de plusieurs moyennes n'est pas la moyenne de la série globale | 4e | `la_moyenne_de_plusieurs_moyennes_n_est_pas` | ☑ |
| Médiane : au moins la moitié des valeurs lui sont inférieures ou égales | 4e | `mediane_au_moins_la_moitie_des_valeurs_lui` | ☑ |
| Probabilité : `0 ≤ P(A) ≤ 1`, somme des probabilités des issues = 1 | 3e | `probabilite_somme_des_probabilites_des_issues_1` | ☑ |
| Événement contraire : `P(Ā) = 1 − P(A)` | 3e | `evenement_contraire` | ☑ |
| Équiprobabilité : `P(A) = card(A) / card(Ω)` | 3e | `equiprobabilite` | ☑ |
| Expérience à deux épreuves : arbre pondéré, produit des probabilités le long d'une branche | 3e | `experience_a_deux_epreuves_arbre_pondere_produit_des` | ☑ |
| Fréquence observée et probabilité : fluctuation d'échantillonnage, stabilisation quand `n` grandit | 3e | `frequence_observee_et_probabilite_fluctuation_d_echantillonnage_stabilisation` | ☑ |
