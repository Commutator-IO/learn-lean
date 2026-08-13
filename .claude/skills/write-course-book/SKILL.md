---
name: write-course-book
description: Rédiger les textes de liaison du livre « cours complet » de ce dépôt — introductions de partie, de chapitre, phrases de passage entre sections. Utiliser quand on demande d'écrire, compléter ou relire le livre, les transitions, les introductions de book/textes/, ou de rendre le PDF du cours lisible d'un bout à l'autre.
---

# Rédiger le livre du cours

Les chapitres de `courses/` sont des suites d'énoncés : ils n'ont ni entrée en matière, ni
fil, ni rappel de ce qui sert plus loin. Le livre — `book/cours-complet.tex`, assemblé par
`python3 tools/generate-book.py` — ajoute ce fil, et rien d'autre.

Cette skill décrit ce qu'on écrit et, surtout, ce à quoi on ne touche pas.

## La règle qui prime sur toutes les autres

**Les énoncés et les démonstrations ne sont pas réécrits.** Ils viennent des fichiers
`.tex` des chapitres, qui transcrivent le script Lean étape par étape (voir la skill
[`transcribe-lean-proof`](../transcribe-lean-proof/SKILL.md)). Les rendre plus élégants
romprait le lien entre le livre et la preuve vérifiée par la machine, qui est tout l'objet
du dépôt. Une démonstration laborieuse dans le livre l'est aussi dans le fichier : c'est
une information, pas un défaut de rédaction.

Le texte qu'on écrit ici vit dans `book/textes/`, jamais dans `courses/`. Si une phrase de
liaison ne peut pas s'écrire sans corriger un énoncé, c'est l'énoncé qu'il faut corriger,
dans son fichier, avec sa preuve — et cela relève de l'autre skill.

## Ce qu'on écrit

Trois sortes de textes, du plus général au plus précis.

**L'ouverture du livre** (`book/textes/livre.tex`) — une page. Ce que contient l'ouvrage,
d'où viennent les démonstrations, ce que signifie qu'un énoncé soit vérifié par un
assistant de preuve, et ce que le lecteur doit savoir pour lire : rien, sinon le programme
de sa classe.

**L'ouverture d'une partie** (`book/textes/01-college.tex`, `02-lycee.tex`) — une demi-page
à une page. Ce que le cycle apporte, dans quel ordre, et ce qui y change de nature : au
collège on passe du calcul à la démonstration, au lycée de la démonstration à l'analyse.

**L'ouverture d'un chapitre** (`book/textes/01-college__02-geometrie-plane.tex`) — deux à
cinq paragraphes. C'est le texte le plus utile du livre, et le plus contraint :

- ce que le chapitre établit, en une phrase, sans formule ;
- ce dont il a besoin et qui vient d'ailleurs, avec le renvoi (« la relation de Chasles,
  démontrée au chapitre 1 ») ;
- ce qu'il faut regarder de près : la définition dont tout dépend, l'hypothèse qu'on
  oublie, le cas particulier qui trompe ;
- s'il y a lieu, **ce que le chapitre ne démontre pas et pourquoi** — c'est déjà écrit dans
  les documents de chapitre, il s'agit de l'annoncer, pas de le répéter en détail.

## Ce qu'on n'écrit pas

- **Aucun énoncé mathématique nouveau.** Le livre ne contient pas une propriété de plus que
  les fichiers Lean. Une transition qui aurait besoin d'un résultat non démontré doit se
  contenter de l'annoncer comme admis, en le disant.
- **Aucun exercice, aucun exemple numérique inventé.** Les exemples du livre sont ceux des
  fichiers, qui sont eux-mêmes des théorèmes.
- **Aucune promesse.** « Nous verrons plus loin que… » n'est acceptable que si le résultat
  est effectivement plus loin, et démontré.
- **Aucun jugement sur la difficulté** (« il est facile de voir que »). Ce qui est facile
  pour l'auteur ne l'est pas pour l'élève, et la formalisation a précisément montré
  combien de « c'est évident » cachaient un travail.

## Le niveau de langue

Le livre va de la sixième à la terminale : le registre suit. Une introduction de chapitre
de collège emploie les mots de la classe — « on met au même dénominateur », « le reste de
la division ». Une introduction de terminale peut dire « on admet la complétude de ℝ ».

Quand une démonstration du chapitre dépasse le niveau de son énoncé — une récurrence forte
pour une propriété de sixième, la théorie de la mesure derrière une aire — l'introduction
du chapitre le dit en une phrase, sans s'excuser. C'est l'écart que ce dépôt mesure.

## Les renvois

Le livre est un document unique : on peut donc renvoyer par le numéro de chapitre, et non
par le nom de fichier. Écrire « au chapitre 4 » plutôt que « dans
`LimitesContinuiteDerivation.lean` ». Les renvois vers le dépôt sont déjà présents sous
chaque énoncé, engendrés — il ne faut pas les doubler dans la prose.

## Conventions typographiques

Les mêmes que dans les documents de chapitre, puisque le livre les reprend tels quels :
guillemets `\og{}` `\fg{}`, tiret cadratin `\textemdash{}`, mathématiques en `\(…\)` ou en
display, et pas de `$…$` doublés. Le fichier est en UTF-8 et se compile avec
`tectonic book/cours-complet.tex`.

## Procédure

1. Lire le chapitre — son index dans `courses/**/README.md`, puis son `.tex` en entier. On
   n'introduit pas un chapitre qu'on n'a pas lu.
2. Écrire le texte dans `book/textes/<id>.tex`, où `<id>` est celui qu'affiche
   `python3 tools/generate-book.py --liste`.
3. Réassembler et compiler :

   ```bash
   python3 tools/generate-book.py && tectonic book/cours-complet.tex
   ```

4. Vérifier le PDF : la transition doit se lire d'affilée avec ce qui suit, sans redite. Un
   paragraphe qui répète l'énoncé qui vient trois lignes plus bas est à couper.
