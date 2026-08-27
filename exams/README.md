# Sujets

Les épreuves de mathématiques du brevet et du baccalauréat, matière première du projet :
chaque exercice d'examen est un petit énoncé à formaliser, souvent plus concret que les
théorèmes du [cours](../courses/README.md).

## Contenu

| Fichier | Rôle |
|---|---|
| [annales-brevet.md](annales-brevet.md) | Sujets du brevet, France métropolitaine, 2000 → 2026 — 107 sujets, avec liens PDF (sujets et corrigés) vers l'APMEP |
| [annales-bac.md](annales-bac.md) | Sujets du baccalauréat, France métropolitaine, 2000 → 2026 — 66 sujets : série S jusqu'en 2020, enseignement de spécialité ensuite |
| [2025/](2025/README.md) | Les trois sessions de 2025 décomposées question par question, appariées à leurs énoncés Lean et à leurs démonstrations en français |
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

Une année reprise donne en outre un document LaTeX, `Sujets<année>Decomposes.tex`, où
chaque question démontrée porte sa réponse rédigée en français, suivie de sa
démonstration. Le document les appelle des **réponses**, non des théorèmes : un sujet pose
des questions, et un théorème est ce que le fichier Lean en fait. C'est
`tools/generate-tex.py` qui choisit le mot, sur le seul fait que le dossier est sous
`exams/`. Le squelette vient de
`python3 tools/generate-tex.py exams/<année>` ; les démonstrations sont écrites à la main,
et suivent pas à pas le script Lean (voir la skill `transcribe-lean-proof`). Ce qui n'est
pas démontré — un `sorry`, une hypothèse admise — y est signalé comme tel, en toutes
lettres.

Les figures vivent dans `exams/<année>/figures/<session>/<théorème>.{tex,svg}` : une
version TikZ pour le document, une version SVG pour le site, dessinées sur les mêmes
coordonnées. Le sous-dossier par session est nécessaire ici, à la différence des chapitres
du cours : trois sujets partagent le dossier d'une année, et les noms de déclarations s'y
répètent — `ex3_affirmation_4` désigne un énoncé différent dans chaque jour du
baccalauréat.

Les sujets et corrigés sont la propriété de leurs auteurs et sont diffusés par
l'[APMEP](https://www.apmep.fr/) ; ce dépôt n'en héberge aucune copie, seulement des liens.
