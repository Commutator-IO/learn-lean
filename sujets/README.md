# Sujets

Les épreuves de mathématiques du brevet, matière première du projet : chaque exercice
de brevet est un petit énoncé à formaliser, souvent plus concret que les théorèmes du
[cours](../cours/README.md).

## Contenu

| Fichier | Rôle |
|---|---|
| [annales-brevet.md](annales-brevet.md) | Liste des sujets de France métropolitaine de 2000 à 2026, avec liens PDF (sujets et corrigés) vers l'APMEP |
| [telecharger.sh](telecharger.sh) | Récupère les PDF en local dans `sujets/pdf/<année>/` |
| `pdf/` | Les PDF téléchargés — non versionnés (voir `.gitignore`) |

## Télécharger les sujets

Toutes les sessions (107 sujets, série générale, métropole) :

```bash
./sujets/telecharger.sh
```

Une seule année :

```bash
./sujets/telecharger.sh 2023
```

Le script saute les fichiers déjà présents, il peut donc être relancé sans risque.

## Convention de travail

Un exercice repris en Lean est rangé dans `LearnLean/Sujets/<année>_<session>.lean`,
avec un commentaire donnant l'énoncé original et le numéro de l'exercice.

Les sujets et corrigés sont la propriété de leurs auteurs et sont diffusés par
l'[APMEP](https://www.apmep.fr/) ; ce dépôt n'en héberge aucune copie, seulement des liens.
