# Sujets

Les épreuves de mathématiques du brevet et du baccalauréat, matière première du projet :
chaque exercice d'examen est un petit énoncé à formaliser, souvent plus concret que les
théorèmes du [cours](../courses/README.md).

## Contenu

| Fichier | Rôle |
|---|---|
| [annales-brevet.md](annales-brevet.md) | Sujets du brevet, France métropolitaine, 2000 → 2026 — 107 sujets, avec liens PDF (sujets et corrigés) vers l'APMEP |
| [annales-bac.md](annales-bac.md) | Sujets du baccalauréat, France métropolitaine, 2000 → 2026 — 66 sujets : série S jusqu'en 2020, enseignement de spécialité ensuite |
| [2025/](2025/README.md) | Les trois sessions de 2025 décomposées question par question, appariées à leurs énoncés Lean |
| [2026/](2026/README.md) | Les trois sessions de 2026 décomposées de la même façon |
| [download.sh](download.sh) | Récupère les PDF en local dans `exams/pdf/<année>/` |
| `pdf/` | Les PDF téléchargés — non versionnés (voir `.gitignore`) |

Les deux listes suivent les deux programmes : le brevet clôt le
[programme du collège](../courses/college.md), le baccalauréat celui du
[lycée](../courses/lycee.md).

## Télécharger les sujets

Le script couvre toutes les sessions du brevet (107 sujets, série générale, métropole), et
les sujets du baccalauréat des sessions décomposées ici :

```bash
./exams/download.sh
```

Une seule année :

```bash
./exams/download.sh 2023
```

Le script saute les fichiers déjà présents, il peut donc être relancé sans risque. Les
autres sujets du baccalauréat se récupèrent à la main, depuis les liens de
[annales-bac.md](annales-bac.md).

## Convention de travail

Une session reprise en Lean donne deux fichiers dans `exams/<année>/` : un index
`.md`, qui découpe le sujet en problèmes puis en questions, et un `.lean` de même nom, qui
porte les énoncés dérivés de ces questions. L'index est la source : c'est lui qui dit, pour
chaque question, la notion en jeu, le thème du dépôt, le théorème correspondant — ou
l'absence de théorème, quand la question n'est pas une proposition mathématique.

Les sujets et corrigés sont la propriété de leurs auteurs et sont diffusés par
l'[APMEP](https://www.apmep.fr/) ; ce dépôt n'en héberge aucune copie, seulement des liens.
