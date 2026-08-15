# learn-lean

Apprentissage de Lean en formalisant les mathématiques de l'enseignement secondaire
français, du collège à la terminale.

Le corpus est pris tel quel, sans filtrer ce qui se formalise bien : il recense ce que
les programmes demandent, y compris les énoncés qui résistent — constructions à la règle
et au compas, lectures graphiques, définitions de grandeurs, modélisation probabiliste,
algorithmique. **C'est là que se lisent les limites de Lean**, et c'est une des choses que
ce dépôt cherche à mesurer, autant que les preuves elles-mêmes.

## Les deux programmes

| Fichier | Contenu | Énoncés | Démontrés |
|---|---|---|---|
| [college.md](courses/college.md) | Cycle 3 (6e) et cycle 4 (5e, 4e, 3e) | 93 | 90 |
| [lycee.md](courses/lycee.md) | Seconde, première S, terminale S et spécialité | 137 | 123 |
| [lycee.md](courses/lycee.md#11-informatique-nsi) | Spécialité NSI, première et terminale | 42 | 41 |

Les dix-huit chapitres ont leurs fichiers `.lean`, leur transcription française et leur
PDF. Le dernier, la spécialité NSI, donne au thème *Algorithmique* la suite qui lui
manquait après le collège : tris, dichotomie, arbres, invariants de boucle, et
l'indécidabilité de l'arrêt.

Les énoncés restants sont ceux qui résistent. Ils sont **écrits en Lean sans être
démontrés** — leur preuve est un `sorry`, et le site comme le livre les marquent
*admis* — de sorte que le manque se compte au lieu de disparaître : aire du disque et
volume de la boule, volume d'un solide de révolution, théorème du toit, Moivre–Laplace,
intervalles de fluctuation, et la moitié difficile du parcours en profondeur. La raison
est écrite au cas par cas dans le document du chapitre.

Chaque ligne y porte un statut. Le fichier lycée ajoute une colonne *Admis* qui signale
les énoncés que le programme admet sans démonstration (théorème des valeurs
intermédiaires, existence de primitives, Moivre–Laplace…) : c'est la frontière la plus
intéressante, puisque Lean ne connaît pas cette convention. Elle se déplace dans les deux
sens : l'espérance d'une loi binomiale, admise au lycée, est ici démontrée — Mathlib ne la
contenait pas ; et le théorème du toit, admis lui aussi, ne l'est pas.

## Statuts

| Symbole | Sens |
|---|---|
| ☐ | pas encore formalisé |
| ◐ | énoncé écrit en Lean, preuve en cours (`sorry`) |
| ☑ | démontré, sans `sorry` |
| ✗ | tentative faite, énoncé jugé non formalisable en l'état — raison notée en commentaire du fichier `.lean` |

`✗` n'est pas un échec, c'est un résultat. Un énoncé peut y aboutir parce qu'il porte sur
un dessin, sur une procédure, sur une convention d'unités, ou parce que le formaliser
honnêtement demande un appareillage sans rapport avec le niveau de l'énoncé.

## Organisation

```
courses/        les deux programmes et un dossier par chapitre
  college.md      liste du programme du collège, un tableau par thème
  lycee.md        idem pour le lycée, filière S
  themes.json     l'ordre de lecture : cinq thèmes, chacun du collège à la
                  terminale — lu par le site comme par le livre
  appuis.json     généré : où trouver, dans Mathlib, la source de chaque
                  résultat emprunté par une démonstration
  01-college/     7 chapitres
  02-lycee/      11 chapitres, dont la spécialité NSI
                chaque chapitre contient ses .lean (les preuves), son .tex
                (les mêmes énoncés rédigés en français) et son dossier
                figures/, et produit un PDF
exams/          annales du brevet et du baccalauréat (2000-2026)
tools/          generate-courses.py (index), generate-lakefile.py (bibliothèques),
                generate-tex.py (un document LaTeX par chapitre),
                generate-book.py (le livre entier), liens-mathlib.py (les emprunts)
book/           le livre : préambule, textes de liaison, références
site/           le site publié sur lean.commutator.io
lakefile.toml   généré : une bibliothèque Lean par chapitre
```

## Écrire les preuves

Un fichier `.lean` par section d'un chapitre, dans le dossier du chapitre — le nom
attendu est donné par l'index (`Triangles.lean`, `Integration.lean`) :

```lean
-- courses/01-college/01-nombres-et-calculs/EntiersDivisibilite.lean

/-- Si `a` divise `b` et `c`, il divise leur somme. Collège, 5e. -/
theorem divise_somme {a b c : Nat} (hb : a ∣ b) (hc : a ∣ c) : a ∣ (b + c) :=
  Nat.dvd_add hb hc
```

Langue : tout le dépôt est rédigé **en français**, y compris les commentaires des
fichiers `.lean` et les noms de théorèmes. Seuls les messages de commit, les workflows
GitHub Actions et les issues sont en anglais.

Après chaque ajout ou suppression de fichier `.lean` :

```bash
python3 tools/generate-lakefile.py
```

Puis construire, en nommant la bibliothèque du chapitre touché — celle qu'affiche
`generate-lakefile.py`, par exemple `CollegeGrandeursEtMesures` :

```bash
lake build CollegeGrandeursEtMesures
```

**Attention à la mémoire.** `lake build` sans argument prend les dix-huit bibliothèques et
lance un processus par cœur ; or un processus Lean qui fait `import Mathlib` occupe environ
1,8 Go avant même de démontrer quoi que ce soit. Sur une machine à huit cœurs et huit
gigaoctets, il en réclame le double de ce qu'elle a, part en swap et tombe. Lake 5 n'a plus
d'option de parallélisme : on borne la mémoire en ne demandant **qu'un module à la fois**.

```bash
lake build StructuresDeDonnees
```

La CI ne passe plus `--wfail`. Les énoncés que le programme demande et que ce dépôt ne
démontre pas s'écrivent `sorry`, ce que Lean signale par un avertissement : garder
`--wfail` aurait obligé soit à cacher ces manques, soit à faire échouer chaque
construction. Le workflow en publie la liste à la place, de sorte qu'un `sorry` ajouté sans
qu'on le veuille se voie dans le journal.

Le serveur de langage, lui, ne coûte qu'un processus : c'est la façon la moins chère de
vérifier un fichier pendant qu'on l'écrit. Il ne signale en revanche pas les dépréciations
de Mathlib, que seule une construction fait apparaître.

## Lire les preuves hors de Lean

Chaque chapitre a un document `.tex` unique, engendré à partir de ses fichiers Lean :

```bash
python3 tools/generate-tex.py
```

Le script produit le squelette : introduction tirée du commentaire de tête, sections des
en-têtes `/-! ## … -/`, énoncés tirés des docstrings, et pour chacun un lien vers ses
lignes dans le dépôt — le code Lean n'est pas recopié. Les démonstrations en français
sont ensuite transcrites à la main, selon la skill
[`transcribe-lean-proof`](.claude/skills/transcribe-lean-proof/SKILL.md), qui fixe la
correspondance entre tactiques et rédaction française. Le script ne réécrit jamais un
`.tex` existant : les transcriptions sont conservées.

Le document se compile avec `tectonic` ou `pdflatex` ; les PDF ne sont pas versionnés.

Un chapitre qui reçoit un nouveau fichier `.lean` après coup voit sa section ajoutée à la
fin du document ; le reste, transcriptions comprises, n'est pas touché. Les renvois
`\source{…}{Fichier.lean#L42}` se remettent à jour tout seuls :

```bash
python3 tools/generate-tex.py --liens
```

Une preuve qui s'allonge décale toutes les lignes en dessous, et le site apparie alors des
énoncés avec la démonstration de leur voisin sans que rien n'échoue. Un travail de la CI
relance ce script et refuse toute différence.

## Les démonstrations empruntées

Une preuve qui tient en une ligne — `exact Nat.dvd_add hb hc` — est correcte et ne montre
rien : le raisonnement est dans une bibliothèque que le lecteur n'ouvrira pas s'il faut la
chercher. On lui en donne donc l'adresse.

```bash
python3 tools/liens-mathlib.py
```

Le script lit les sources de Mathlib, de Batteries et du noyau de Lean — une partie de
l'arithmétique des entiers y est démontrée, et non dans Mathlib — puis écrit dans
`courses/appuis.json` le fichier et la ligne de chaque résultat cité. Le site en fait une
bande « s'appuie sur », sous l'en-tête du volet de code, qui mène à **la démonstration
elle-même** et non à sa documentation. Quand la liste est vide, elle le dit aussi : c'est
l'information la plus utile des deux.

La résolution demande les sources de Mathlib, donc le script tourne en local et son
résultat est versionné ; la construction du site ne lit que le JSON.

Côté texte, la règle est dans la skill : une transcription ne dit pas « c'est un résultat
de la bibliothèque », elle **ouvre cette démonstration et la rend en français**. Le nom de
l'emprunt est mentionné une fois, pour qu'on puisse aller vérifier ; il ne porte jamais
l'argument à lui seul. Restent assumés les emprunts qu'on ne refera pas — la construction
de ℝ, la théorie de la mesure, la définition de `Real.exp` et de ses semblables : le texte
dit alors sur quoi il s'appuie, sans faire croire qu'il l'a démontré.

## Les figures

Trente-deux figures, chacune écrite deux fois : en TikZ pour le livre, où elle est composée
dans les polices du document, et en SVG pour le site, où elle suit la couleur du texte.

    courses/<programme>/<chapitre>/figures/<nom_du_theoreme>.tex
    courses/<programme>/<chapitre>/figures/<nom_du_theoreme>.svg

Le nom du fichier est celui de la déclaration Lean : c'est par là que le site et le livre
retrouvent la figure. Les coordonnées sont écrites **une fois**, en commentaire en tête du
`.tex`, et recopiées dans le `.svg` — deux versions qui divergent seraient un défaut au même
titre qu'une preuve fausse.

On n'illustre pas tout : un calcul algébrique, une divisibilité, une identité remarquable
n'ont pas de figure. Et jamais un énoncé admis — la figure ne comble pas le manque, et le
lecteur qui la voit croira le contraire. Voir la skill
[`illustrate-theorem`](.claude/skills/illustrate-theorem/SKILL.md).

Les dossiers de chapitre portent des noms lisibles et ordonnés (`06-integration`), qui ne
sont pas des identifiants Lean valides. Le lakefile les déclare donc en `srcDir` d'une
bibliothèque par chapitre : le nom du dossier n'apparaît jamais dans un `import`, les
modules sont simplement `Integration`, `Triangles`… Un chapitre encore vide donne une
bibliothèque vide, ce que Lake accepte sans broncher.

Pour travailler sur Mathlib, ajouter le bloc `[[require]]` correspondant dans
`lakefile.toml` (le script le conserve d'une régénération à l'autre) et aligner
`lean-toolchain` sur la version attendue par Mathlib.

Le [cours](courses/README.md) est le plan de travail : l'index d'un chapitre liste ses
énoncés, le fichier `.lean` où les écrire (`Integration.lean`) et un nom de théorème
suggéré (`integration_par_parties`). Les fichiers `.lean` sont écrits à la main, un par
section de chapitre ; rien n'est généré à l'intérieur des dossiers de chapitre. Les
[sujets](exams/README.md) de brevet et de baccalauréat servent de banc d'essai grandeur
nature : un exercice d'examen est un énoncé concret, souvent plus retors qu'un théorème
du cours.

## Installation

1. Lean et son gestionnaire de versions : suivre <https://lean-lang.org/install/>, qui
   installe `elan`, `lake` et l'extension d'éditeur. La version utilisée ici est fixée par
   `lean-toolchain`, `elan` s'en charge tout seul.
2. Récupérer les binaires de Mathlib plutôt que de la compiler — quelques minutes contre
   plusieurs heures :

   ```bash
   lake exe cache get
   ```

3. Installer les deux outils de la section précédente.

## Tenir les index à jour

Après avoir modifié `courses/college.md` ou `courses/lycee.md` :

```bash
python3 tools/generate-courses.py
```

Le script ne crée que les index `README.md` manquants — jamais de `.lean` — et ne réécrit
aucun fichier existant. Pour reconstruire un index après modification d'une liste,
supprimer cet index et relancer. Les index portent le décompte des énoncés démontrés, qui
est donc à reconstruire après chaque changement de statut.

## Outillage indispensable

Deux outils installés dans ce dépôt, sans lesquels le travail n'avance pas à un rythme
raisonnable :

- [oOo0oOo/lean-lsp-mcp](https://github.com/oOo0oOo/lean-lsp-mcp) — serveur MCP exposant
  le serveur de langage de Lean. Il rend **toutes** les erreurs d'un fichier en une fois,
  donne l'état du but à n'importe quelle ligne, teste des tactiques sans modifier le
  fichier et cherche un lemme par sa signature. Sans lui, chaque nom de lemme erroné coûte
  un `lake build` complet ; avec lui, la boucle se compte en secondes.
- [cameronfreer/lean4-skills](https://github.com/cameronfreer/lean4-skills) — skills et
  workflows Lean 4 pour agents de code, sur la recherche de preuve, que
  [`transcribe-lean-proof`](.claude/skills/transcribe-lean-proof/SKILL.md) ne couvre pas :
  cette dernière ne traite que la transcription en français.

## Pour aller plus loin

Ce dépôt s'arrête à la terminale. Deux ressources pour ce qui vient après :

- [leanprover.zulipchat.com](https://leanprover.zulipchat.com/) — le Zulip de la
  communauté Lean, où se tiennent le développement de Mathlib et l'entraide. Le canal
  *Is there code for X?* répond à la question qui coûte le plus cher ici : le résultat
  existe-t-il déjà dans la bibliothèque, et sous quel nom ?
- [google-deepmind/formal-conjectures](https://google-deepmind.github.io/formal-conjectures/)
  — un recueil de conjectures ouvertes énoncées en Lean, sans démonstration. C'est
  exactement l'exercice inverse du nôtre : ici les énoncés sont élémentaires et les
  preuves existent ; là les énoncés sont hors de portée et la seule chose qu'on puisse
  faire est de les écrire correctement. Les deux se rejoignent sur le point difficile
  — formaliser un énoncé sans le trahir.

## Outils logiques transversaux

Ce sont ces schémas, plus que les théorèmes eux-mêmes, que la formalisation met à nu.

- Implication `P ⟹ Q`, et distinction avec la réciproque `Q ⟹ P`.
- Équivalence `P ⟺ Q` : toutes les caractérisations (médiatrice, parallélogramme, proportionnalité).
- Contraposée `¬Q ⟹ ¬P` : l'usage standard de la réciproque de Pythagore.
- Réfutation par contre-exemple : `√(a + b) ≠ √a + √b`, `+p` puis `−p`.
- Disjonction de cas : parité, signe d'un relatif, signe du discriminant.
- Quantification : « pour tout `x` », « il existe un `x` » — le plus souvent implicite dans les énoncés scolaires.
- Récurrence : en germe au collège dans les formules de sommes, explicite en terminale.
- Ce qui est *admis* (unicité de la décomposition en facteurs premiers au collège,
  théorème des valeurs intermédiaires au lycée) : Lean ignore cette convention et déplace
  donc la frontière entre admis et démontré.

## Ce qu'on cherche à observer

Les lignes qui finiraient en `✗` seraient le vrai résultat de l'exercice. À ce jour il n'y
en a aucune : tout ce que les programmes demandent a pu s'écrire en Lean, quitte à en
admettre la démonstration. C'est déjà une réponse — la difficulté ne porte pas sur
l'énonçable, mais sur le démontrable, et les dix-sept `sorry` disent où elle se trouve.

Les catégories auxquelles on s'attendait, et qui se sont toutes laissé énoncer :

- **Les constructions.** « Construire la médiatrice à la règle et au compas » est une
  procédure, pas une proposition : la formaliser suppose de modéliser le compas.
- **Le dessin comme donnée.** Lire un antécédent sur un graphique, reconnaître la
  transformation d'une frise, dresser un tableau de variation : l'énoncé porte sur une
  figure, pas sur un objet formel.
- **Les grandeurs et les unités.** Distinguer une grandeur de sa mesure, convertir, parler
  de vitesse moyenne : Lean calcule sur des nombres purs, sauf appareillage supplémentaire.
- **Les définitions coûteuses.** Aire du disque, volume de la boule, intégrale comme aire,
  loi normale : formules données à l'école, théorèmes d'analyse ou de théorie de la mesure
  en Lean.
- **Les tâches déguisées en énoncés.** « Étudier la fonction `f` » n'est pas une
  proposition ; la formaliser demande de décider ce qui compte comme étude complète.
- **Le méta-niveau.** « Deux programmes de calcul donnent le même résultat » est facile ;
  « ce programme termine » suppose d'avoir formalisé le langage lui-même.

Symétriquement, une bonne part du programme du lycée existe déjà dans Mathlib presque mot
pour mot (`Real.exp`, `Real.log`, `Complex.abs`, `Nat.Prime`, `intervalIntegral`,
`Matrix`). Pour ces énoncés, l'exercice n'est plus de démontrer mais de retrouver la
formulation exacte et de vérifier qu'elle dit bien la même chose que l'énoncé français —
exercice différent, et pas toujours plus facile.

## Le site

Le dépôt publie [lean.commutator.io](https://lean.commutator.io/), quatre onglets :

| Onglet | Contenu |
|---|---|
| Apprendre Lean | le cours à deux volets — le fichier Lean à gauche, sa transcription française à droite, défilement lié et identifiants cliquables |
| Le livre | le même cours rédigé d'affilée, sans le code, et son PDF |
| Méthode | comment on passe d'un énoncé de programme à un théorème vérifié, la chaîne de construction, les trois skills |
| Sujets d'examens | les annales de brevet et de baccalauréat, avec aperçu du PDF — le chantier suivant |

```bash
cd site && npm install && npm run dev
```

Le site ne stocke rien : `npm run manifest` relit `courses/`, apparie chaque déclaration
Lean avec son bloc LaTeX par le renvoi `\source{…}{Fichier.lean#L42}`, et rend les
formules par KaTeX à la construction. Une formule fautive fait donc échouer la
construction plutôt que de s'afficher en rouge en production.

Le livre s'assemble à part, des mêmes documents de chapitre :

```bash
python3 tools/generate-book.py && tectonic book/cours-complet.tex
```

Il n'ajoute aucune mathématique : seulement le texte de liaison de `book/textes/`, écrit
selon la skill [`write-course-book`](.claude/skills/write-course-book/SKILL.md). Ses parties
sont les thèmes de `courses/themes.json`, et non les deux cycles : on lit une notion du
collège à la terminale sans changer de partie. Le
workflow [`site.yml`](.github/workflows/site.yml) construit les deux et les déploie sur
GitHub Pages.
