# learn-lean

Apprentissage de Lean en formalisant les mathématiques de l'enseignement secondaire
français, du collège à la terminale.

Le corpus est pris tel quel, sans filtrer ce qui se formalise bien : il recense ce que
les programmes demandent, y compris les énoncés qui résistent — constructions à la règle
et au compas, lectures graphiques, définitions de grandeurs, modélisation probabiliste,
algorithmique. **C'est là que se lisent les limites de Lean**, et c'est une des choses que
ce dépôt cherche à mesurer, autant que les preuves elles-mêmes.

## Les deux programmes

| Fichier | Contenu | Items |
|---|---|---|
| [college.md](college.md) | Objectifs d'apprentissage, 6e (cycle 3) et 5e-3e (cycle 4), puis 133 énoncés conservés | 442 |
| [lycee.md](lycee.md) | Contenus, seconde et spécialité de première et terminale, puis 137 énoncés conservés | 341 |

Les deux listes sont **extraites des programmes officiels**, dans leur formulation
d'origine, par `python3 outils/extraire-programme.py` : cycle 3 au BO du 17 avril 2025,
cycle 4 au BO du 5 mars 2026, lycée au BO du 2 avril 2026. Les programmes entrent en
application par paliers — 5e en 2026, 4e en 2027, 3e en 2028, terminale en 2027.

Au lycée, 31 items portent la mention **démonstration exigible** : le programme demande
explicitement qu'ils soient démontrés. Ce sont les premiers à formaliser.

Chaque liste se termine par un chapitre **Énoncés conservés** : les propositions rédigées
avant la reprise des programmes, gardées parce qu'un objectif officiel n'est pas toujours
une proposition démontrable. Celles qu'aucun item de 2026 ne reprend portent la mention
*hors programme 2026* — 92 sur 133 au collège, 89 sur 137 au lycée. Ce sont ces énoncés
que porte le travail Lean déjà fait.

## Statuts

| Symbole | Sens |
|---|---|
| ☐ | pas encore formalisé |
| ◐ | énoncé écrit en Lean, preuve en cours (`sorry`) |
| ☑ | démontré, sans `sorry` |
| ✗ | tentative faite, énoncé jugé non formalisable en l'état — raison notée en commentaire du fichier `.lean` |
| — | l'item décrit un geste (construire, tracer, calculer…) et non une proposition : il n'y a rien à démontrer |

`✗` n'est pas un échec, c'est un résultat. Un énoncé peut y aboutir parce qu'il porte sur
un dessin, sur une procédure, sur une convention d'unités, ou parce que le formaliser
honnêtement demande un appareillage sans rapport avec le niveau de l'énoncé.

## Organisation

```
college.md      liste du programme du collège, un tableau par thème
lycee.md        idem pour le lycée, filière S
cours/          un dossier par chapitre : uniquement les définitions, propriétés et
                théorèmes des listes — les objectifs qui décrivent un geste ou une
                compétence n'y entrent pas, il n'y a rien à y démontrer
  01-college/     7 chapitres
  02-lycee/      10 chapitres
                les fichiers .lean s'y ajoutent au fur et à mesure
sujets/         annales du brevet (2000-2026) et script de téléchargement
outils/         extraire-programme.py (les deux listes, depuis le BO),
                generer-cours.py (index), generer-lakefile.py (bibliothèques),
                generer-tex.py (documents LaTeX)
lakefile.toml   généré : une bibliothèque Lean par chapitre
```

## Écrire les preuves

Un fichier `.lean` par section d'un chapitre, dans le dossier du chapitre — le nom
attendu est donné par l'index (`Triangles.lean`, `Integration.lean`) :

```lean
-- cours/01-college/01-nombres-et-calculs/EntiersDivisibilite.lean

/-- Si `a` divise `b` et `c`, il divise leur somme. Collège, 5e. -/
theorem divisibilite_somme {a b c : Nat} (hb : a ∣ b) (hc : a ∣ c) : a ∣ (b + c) :=
  Nat.dvd_add hb hc
```

Langue : tout le dépôt est rédigé **en français**, y compris les commentaires des
fichiers `.lean` et les noms de théorèmes. Seuls les messages de commit et les workflows
GitHub Actions sont en anglais.

Après chaque ajout ou suppression de fichier `.lean` :

```bash
python3 outils/generer-lakefile.py && lake build
```

## Lire les preuves hors de Lean

Chaque fichier `.lean` a un jumeau `.tex`, engendré à partir de lui :

```bash
python3 outils/generer-tex.py
```

Le script produit le squelette : introduction tirée du commentaire de tête, sections des
en-têtes `/-! ## … -/`, énoncés tirés des docstrings, et pour chacun un lien vers ses
lignes dans le dépôt — le code Lean n'est pas recopié. Les démonstrations en français
sont ensuite transcrites à la main, selon la skill
[`transcrire-preuve-lean`](.claude/skills/transcrire-preuve-lean/SKILL.md), qui fixe la
correspondance entre tactiques et rédaction française. Le script ne réécrit jamais un
`.tex` existant : les transcriptions sont conservées.

Le document se compile avec `tectonic` ou `pdflatex` ; les PDF ne sont pas versionnés.

Les dossiers de chapitre portent des noms lisibles et ordonnés (`06-integration`), qui ne
sont pas des identifiants Lean valides. Le lakefile les déclare donc en `srcDir` d'une
bibliothèque par chapitre : le nom du dossier n'apparaît jamais dans un `import`, les
modules sont simplement `Integration`, `Triangles`… Un chapitre encore vide donne une
bibliothèque vide, ce que Lake accepte sans broncher.

Pour travailler sur Mathlib, ajouter le bloc `[[require]]` correspondant dans
`lakefile.toml` (le script le conserve d'une régénération à l'autre) et aligner
`lean-toolchain` sur la version attendue par Mathlib.

Le [cours](cours/README.md) est le plan de travail : l'index d'un chapitre liste ses
énoncés, le fichier `.lean` où les écrire (`Integration.lean`) et un nom de théorème
suggéré (`integration_par_parties`). Les fichiers `.lean` sont écrits à la main, un par
section de chapitre ; rien n'est généré à l'intérieur des dossiers de chapitre. Les
[sujets](sujets/README.md) de brevet servent de banc d'essai grandeur nature : un exercice
de brevet est un énoncé concret, souvent plus retors qu'un théorème du cours.

## Tenir les index à jour

Après avoir modifié `college.md` ou `lycee.md` :

```bash
python3 outils/generer-cours.py
```

Le script ne crée que les index `README.md` manquants — jamais de `.lean` — et ne réécrit
aucun fichier existant. Pour reconstruire un index après modification d'une liste,
supprimer cet index et relancer.

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

Les lignes qui finiront en `✗` sont le vrai résultat de l'exercice. Quelques catégories
auxquelles on s'attend :

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
