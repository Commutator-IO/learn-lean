# Sujets

Les épreuves de mathématiques du brevet et du baccalauréat, matière première du projet :
chaque exercice d'examen est un petit énoncé à formaliser, souvent plus concret que les
théorèmes du [cours](../courses/README.md).

## Contenu

| Fichier | Rôle |
|---|---|
| [annales-brevet.md](annales-brevet.md) | Sujets du brevet, France métropolitaine, 2000 → 2026 — 107 sujets, avec liens PDF (sujets et corrigés) vers l'APMEP |
| [annales-bac.md](annales-bac.md) | Sujets du baccalauréat, France métropolitaine, 2000 → 2026 — 66 sujets : série S jusqu'en 2020, enseignement de spécialité ensuite |
| [download.sh](download.sh) | Récupère les PDF du brevet en local dans `exams/pdf/<année>/` |
| `pdf/` | Les PDF téléchargés — non versionnés (voir `.gitignore`) |

Les deux listes suivent les deux programmes : le brevet clôt le
[programme du collège](../courses/college.md), le baccalauréat celui du
[lycée](../courses/lycee.md).

## Télécharger les sujets

Le script ne couvre pour l'instant que le brevet. Toutes les sessions (107 sujets, série
générale, métropole) :

```bash
./exams/download.sh
```

Une seule année :

```bash
./exams/download.sh 2023
```

Le script saute les fichiers déjà présents, il peut donc être relancé sans risque. Les
sujets du baccalauréat se récupèrent pour l'instant à la main, depuis les liens de
[annales-bac.md](annales-bac.md).

## Convention de travail

Un exercice repris en Lean est rangé dans `LearnLean/Sujets/<année>_<session>.lean`,
avec un commentaire donnant l'énoncé original et le numéro de l'exercice.

Les sujets et corrigés sont la propriété de leurs auteurs et sont diffusés par
l'[APMEP](https://www.apmep.fr/) ; ce dépôt n'en héberge aucune copie, seulement des liens.
