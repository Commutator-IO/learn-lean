# Cours

Un dossier par chapitre des deux programmes. Chaque dossier contient un index
des énoncés à démontrer et accueille les fichiers `.lean` au fur et à mesure.

| Programme | Dossier | Source |
|---|---|---|
| Programme du collège | [`college/`](college/README.md) | [college.md](../college.md) |
| Programme du lycée (filière S) | [`lycee/`](lycee/README.md) | [lycee.md](../lycee.md) |

## Écrire les preuves

Un fichier `.lean` par section d'un chapitre, nommé dans l'index du chapitre
(`Triangles.lean`, `Integration.lean`…). Quand un énoncé est traité, mettre à jour
son statut dans l'index du chapitre, et dans `college.md` ou `lycee.md`.

## Régénérer les index

```bash
python3 outils/generer-cours.py
```

Le script ne crée que les `README.md` manquants, jamais de `.lean`, et ne réécrit
aucun fichier existant. Après modification de `college.md` ou `lycee.md`, supprimer
l'index concerné et relancer pour le reconstruire.
