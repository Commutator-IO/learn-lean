---
name: contribute-to-mathlib
description: Proposer à Mathlib (leanprover-community/mathlib4) un résultat démontré ou admis dans ce dépôt — vérifier que le manque est réel, rédiger le lemme au format Mathlib, le compiler sans `lake build`, ouvrir la PR depuis le fork mycaule/mathlib4, puis traiter les retours des relecteurs et la CI. Utiliser quand on demande une contribution à Mathlib, une PR mathlib4, de « remonter » un énoncé du dépôt, de corriger une PR Mathlib, de répondre à une revue ou de réparer sa CI.
---

# Contribuer à Mathlib depuis ce dépôt

Le dépôt formalise le secondaire ; il bute parfois sur un manque de Mathlib. Ces manques
font de bonnes PR, à condition de les présenter comme Mathlib les attend. Cette skill
rassemble ce qu'ont appris les sept PR du 11 octobre 2026 (suivi : issue #7) et leurs
revues. Les PR, leurs titres, descriptions, commits et réponses sont **en anglais**.

## 1. Vérifier que le manque est réel

Une PR qui double un lemme existant ou une PR ouverte est fermée. Avant d'écrire :

- **Mathlib master**, pas la version épinglée du dépôt : Loogle connaît master.

      curl -s -G 'https://loogle.lean-lang.org/json' --data-urlencode 'q=<nom ou motif>'

  Chercher par nom (`q=Real.digits`), par constantes (`q=Squarefree, ZMod, HPow.hPow`)
  et par chaîne (`q="revolution"`). Une requête qui ne renvoie rien n'est une preuve
  qu'après un contrôle positif sur un nom voisin qu'on sait exister.
- **Les PR ouvertes et fermées** : `gh search prs --repo leanprover-community/mathlib4 "<mots>"`.
  Fermée sans fusion veut souvent dire « refaite ailleurs » : lire pourquoi.
- La **recherche de code GitHub** n'est pas fiable sur mathlib4 (index incomplet, quota
  vite épuisé) : préférer Loogle, `git show origin/master:<fichier>` et `curl` sur
  `raw.githubusercontent.com`.
- **Informatique** (tris, graphes, complexité, terminaison) : le lieu est CSLib
  (`leanprover/cslib`), pas Mathlib. Y regarder aussi, beaucoup y est déjà
  (tri fusion avec `TimeM`, dichotomie, Dijkstra en PR…).

Noter dans la PR ce qui existe déjà autour (« Mathlib has X but not Y ») : le relecteur
voit tout de suite que la recherche a été faite.

## 2. Écrire au format Mathlib

### Énoncé

- **Le plus général qui reste naturel** : un ensemble d'indices filtrant plutôt que `ℕ`,
  un groupe ordonné plutôt que `ℝ`, sans hypothèse inutile. Une revue a fait retirer
  `x ∈ [0, 1)` (seul `0 ≤ x` servait) ; le linter `unusedArguments` fait échouer la CI sur
  une instance inutile (`[IsProbabilityMeasure P]` non utilisée).
- **Réutiliser les notions existantes** plutôt qu'un `∃ N p, ∀ n ≥ N, …` maison :
  `Function.Periodic`, `HasLaw`, `IdentDistrib`, `TendstoInDistribution`…
- **La forme normale du domaine** : en géométrie euclidienne, une distance à un
  sous-espace s'écrit `dist p (orthogonalProjection s p)`, pas `Metric.infDist`.
- **Le bon espace de noms** : `EuclideanGeometry` est réservé aux énoncés qui mêlent
  produit scalaire et espace affine (`NormedAddTorsor`) ; un énoncé purement vectoriel va
  dans `Analysis/InnerProductSpace`.
- **Fichier multiplicatif** (`Topology/Algebra/Order/Group.lean`…) : écrire la version
  multiplicative avec `@[to_additive /-- doc additive -/]`.
- Un lemme auxiliaire utile ailleurs va dans **le fichier le plus élémentaire** possible
  (une identité sur `ℕ` dans `Mathlib/Data/Nat/Init.lean`, pas dans l'analyse), et n'est
  **pas `private`** sans raison.

### Fichier

- **Imports** : chaque import ajouté se paie. Le bot pose `large-import` au-delà de
  quelques pour cent ; la parade est un **nouveau fichier** (`Geometric/Moments.lean`,
  `DeMoivreLaplace.lean`) plutôt qu'un import lourd dans un fichier de base. Ce qui ne
  sert qu'aux preuves s'importe sans `public`. Vérifier l'absence de cycle : le module
  importé ne doit pas déjà importer le fichier modifié.
- Nouveau fichier : en-tête de copyright (`Copyright (c) 2026 Michel Hua.` / `Authors:
  Michel Hua`), `module`, imports, docstring `/-! # Titre … ## Main statements -/`,
  `public section` ; l'inscrire dans `Mathlib.lean` **à sa place alphabétique**.
- Ne pas répéter un bloc `variable` identique à celui d'une section voisine : étendre ou
  renommer la section (`perpBisector` → `RealInnerProductSpace`), et `open scoped … in`
  devant la déclaration qui en a besoin.
- Lignes de **100 caractères** au plus (compter les caractères, pas les octets :
  `awk length` se trompe sur l'Unicode).

### Le guide de style

Relire le [guide de style](https://leanprover-community.github.io/contribute/style.html)
et les [conventions de nommage](https://leanprover-community.github.io/contribute/naming.html)
avant chaque PR. Ce que le guide demande et que la CI ne vérifie pas toujours :

- **Imports** : `module` seul sur sa ligne après l'en-tête, une ligne vide, les
  `public import`, une ligne vide, les `import` ; **ordre alphabétique dans chaque bloc**.
- **Mise en page** : déclarations et commandes collées à gauche, rien n'est indenté sous
  `section` ou `namespace` ; suite d'énoncé indentée de 4 espaces, preuve de 2 ; `by` en
  fin de ligne, jamais seul ; espaces autour de `:` et `:=`, placés avant le retour à la
  ligne ; une espace après `←` dans `rw` et `simp` ; un `·` non indenté par sous-but ;
  **pas de ligne vide à l'intérieur d'une déclaration** (un linter le vérifie).
- `fun x ↦ …`, jamais `λ` ni `$` (utiliser `<|`) ; types des arguments toujours écrits.
- **Hypothèses à gauche des deux-points** plutôt qu'un `∀`/`→` introduit en tête de preuve ;
  ni hypothèse ni conclusion en **conjonction** (deux lemmes plutôt qu'un `∧`) ; une
  hypothèse `x ≠ ⊥` plutôt que `⊥ < x`, une conclusion `⊥ < x` plutôt que `x ≠ ⊥`.
- **Noms de variables** : `m, n, k` entiers naturels, `s, t` ensembles, `x, y` éléments,
  `h, h₁` hypothèses, `G, R, K, 𝕜, E` pour les structures. Une variable locale d'écart type
  ne s'appelle donc pas `s`.
- **`simp` terminal non comprimé** : ne pas remplacer un `simp [lemme clé]` qui clôt le
  but par la sortie de `simp?`. Si le `simp` simple boucle, réécrire d'abord à la main
  (`rw [this]`), puis finir par un `simp` court.
- **Pas de `rfl` ni d'`erw` après `rw`/`simp`** : le guide y voit un manque d'API.
  Fermer par `ring`, `simp [Set.preimage]`… ou ajouter le lemme qui manque.
- `@[to_additive]` plutôt que deux énoncés écrits à la main ; renommer une déclaration
  publique laisse un `@[deprecated (since := "AAAA-MM-JJ")] alias`.
- Docstring de module avec titre, résumé, `## Main results` (puces `-` ou `*`, suite
  indentée de 2 espaces), notations, références ; docstring de déclaration sans
  indentation des lignes suivantes.

### Docstrings et commentaires : avec parcimonie

Leçon de la revue de #44756 ([discussion](https://github.com/leanprover-community/mathlib4/pull/44756#discussion_r4245199412)).
@vihdzp : une IA commente tout son code, et sur des théorèmes aussi simples les
commentaires ne sont que du bruit visuel. Puis, en réponse à l'objection « le guide de
style exige des commentaires »
([réponse](https://github.com/leanprover-community/mathlib4/pull/44756#discussion_r4246164823)) :
les **définitions** exigent un docstring, **pas les théorèmes**. Sans règle officielle,
l'usage des relecteurs réserve le docstring d'un théorème à deux cas :

1. **les théorèmes majeurs**, pour pouvoir citer leur nom dans la littérature
   (*de Moivre–Laplace*, *Cavalieri*, *suites adjacentes*) ;
2. **les théorèmes alambiqués**, difficiles à comprendre à partir de la seule signature
   (hypothèses enchevêtrées, objet mal nommé, convention cachée comme une division par
   zéro, interprétation géométrique non évidente comme `s.directionᗮ = ℝ ∙ n`).

Le piège à éviter : lire la section
[« Comments »](https://leanprover-community.github.io/contribute/style.html#comments) du
guide de style comme une obligation de commenter. Elle dit **quels délimiteurs** employer
(`/-! -/` pour les en-têtes de section, `/- -/` pour les notes techniques, `--` en ligne,
`/-- -/` pour les docstrings), pas qu'il faut un docstring partout. La
[documentation](https://leanprover-community.github.io/contribute/doc.html) exige un
docstring sur « every definition and major theorem » ; elle l'« encourage » sur un lemme,
mais la pratique des relecteurs est plus stricte. Ne pas débattre de la règle avec un
relecteur : appliquer.

En pratique :

- **docstring obligatoire** sur chaque **définition** (`def`, `structure`, `class`,
  `instance` nommée, tactique) et sur les théorèmes des deux cas ci-dessus ;
- **pas de docstring** sur un lemme dont la signature dit tout : `integral_sq_…`,
  `memLp_two_…`, une série `hasSum_…`, un lemme de cast, de réécriture ou une direction
  d'une équivalence. Le nom, choisi selon les conventions de nommage, fait le travail ;
- **pas de commentaire `--` dans une preuve courte** ; un seul, au besoin, pour signaler
  une astuce non évidente dans une preuve longue (remplacer `f` par une fonction mesurable
  avec `piecewise`, par exemple) ;
- le **docstring de module** reste obligatoire et liste les résultats principaux : c'est
  là, pas sur chaque lemme, que le lecteur trouve la carte du fichier.

Avant d'ouvrir une PR, relire chaque docstring et chaque commentaire en se demandant :
*le relecteur apprend-il quelque chose que le nom et la signature ne disaient pas ?*
Sinon, le retirer.

### Preuve

- Les tactiques que la revue préfère : `field` à la place d'une disjonction
  `rcases eq_or_ne x 0` suivie de `simp` / `field_simp` ; `lia` pour l'arithmétique
  entière ; `fun_prop` pour la mesurabilité.
- Pièges rencontrés :
  - dans `theorem Monotone.foo`, un nom nu comme `ge_of_tendsto` se résout en
    `Monotone.ge_of_tendsto` : écrire `_root_.le_of_tendsto` ;
  - `σ` est une notation (symétrie de `unitInterval`) : ne pas l'utiliser comme nom de
    variable sous `open scoped unitInterval` ;
  - `rw` avec un lemme de forme `f p.1` n'unifie pas `R * p.1 / H` : passer `(f := …)`
    explicitement ou utiliser `.trans` ;
  - `rw` ne réécrit pas sous une coercion `ProbabilityMeasure → Measure` : d'abord
    `simp only [ProbabilityMeasure.coe_mk] at h`.

## 3. Compiler sans `lake build`

La machine a 8 Go de RAM et peu de disque : **jamais** `lake build` sur Mathlib ni
`lake exe cache get`. Deux outils suffisent.

- **Un Mathlib déjà compilé** (août 2026) vit dans `~/Commutator/grothendieck-project/lean`.
  Y compiler un fichier d'essai, un seul processus, sans toucher au projet :

      cd ~/Commutator/grothendieck-project/lean && lake env lean <scratchpad>/Essai.lean

  Ce Mathlib a du retard sur master. Quand la preuve utilise un lemme apparu depuis, le
  **simuler** dans le fichier d'essai avec sa signature exacte de master
  (`theorem … := sorry`) et le dire dans le compte rendu.
- **Loogle** pour confirmer que chaque nom utilisé existe encore sur master, avec le
  même module.

Ce contrôle local ne voit pas les **renommages et dépréciations** de master
(`measurable_pi_lambda` → `Measurable.of_eval`, `Set.mem_setOf_eq` →
`Set.mem_ofPred_eq`) ni les linters d'environnement : la CI de la PR est le juge final.

## 4. Ouvrir la PR

- **Clone de travail** : clone superficiel et partiel d'upstream dans le scratchpad, avec
  le fork en second remote.

      git clone --depth 1 --filter=blob:none --sparse https://github.com/leanprover-community/mathlib4 m4
      git -C m4 remote add fork git@github.com:mycaule/mathlib4.git
      git -C m4 fetch --depth 200 origin master

  Une branche par PR, partie de `origin/master` : `git switch -c feat/<sujet> origin/master`.
- Le hook Lean du plugin bloque `git reset --hard`, `git checkout <rev> -- <chemin>` et
  `git sparse-checkout` ; ne pas le contourner. Pour un fichier hors de l'extraction
  partielle, l'écrire à côté et l'indexer :

      SHA=$(git hash-object -w ../Fichier.lean)
      git update-index --add --cacheinfo 100644,$SHA,Mathlib/Chemin/Fichier.lean

- **Commit** : titre `feat(Dossier/Fichier): …`, corps qui liste les déclarations, dernière
  ligne `Co-Authored-By: Claude …`. Pousser sur le fork : `git push fork feat/<sujet>`.
- **PR** en brouillon, de `mycaule:feat/<sujet>` vers `master` :

      gh pr create --draft --repo leanprover-community/mathlib4 --base master --head mycaule:feat/<sujet> --title "feat(…): …" --body-file -

  Corps : les déclarations avec leur énoncé, un paragraphe de preuve, ce que Mathlib avait
  déjà, les choix discutables (fichier, imports) avec l'offre de les changer, une ligne
  « AI disclosure » (rédigé avec Claude, compilé, relu), puis le pied de page
  Claude Code. Le bot ajoute `new-contributor` et `LLM-generated` : c'est attendu.
- Le passage de brouillon à « ready for review » revient à Michel, une fois la CI verte.

## 5. Après l'ouverture : CI et revue

- **CI rouge** : lire le journal (`gh pr checks <n>` puis
  `gh run view <id> --log-failed`) et corriger la cause réelle. Causes rencontrées :
  nom déprécié sur master, argument inutilisé, import manquant après réduction des
  imports (`Measurable ncard` vient de `MeasureTheory.MeasurableSpace.NCard`).
- **Avant tout commit** sur une branche existante, `git fetch fork <branche>` : Michel peut
  y avoir fusionné master depuis GitHub. Repartir de la pointe du fork
  (`git switch -c <tmp> fork/<branche>`), jamais de sa copie locale. **Jamais de
  `push --force`** : un commit de correction par série de retours, titre
  `address review: …`.
- **Suggestions des relecteurs** : les appliquer à la lettre quand elles sont précises ;
  quand une suggestion est fausse telle quelle (`0 ≤ x` restait nécessaire), appliquer
  l'esprit et l'expliquer.
- **Ne rien publier au nom de Michel** sans son accord : réponses aux relecteurs,
  résolution de fils, changement d'état. Rédiger la réponse et la lui proposer. Mettre à
  jour le titre et la description de la PR quand le code change, en revanche, fait
  partie de la correction.
- Ne pas multiplier les PR : la capacité de relecture est le goulot, et un nouveau
  contributeur gagne à faire fusionner les premières avant d'en ouvrir d'autres.

## 6. Retour au dépôt

Quand une PR est fusionnée, suivre la liste de l'issue #7 : monter `rev` de Mathlib dans
`lakefile.toml`, remplacer le `sorry` par l'appel au nouveau lemme, sortir l'énoncé de la
section « Énoncés admis », mettre à jour `college.md` / `lycee.md`, le `.tex` du chapitre
et `courses/appuis.json` (`python3 tools/liens-mathlib.py`), cocher la case.
