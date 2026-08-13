---
name: transcribe-lean-proof
description: Transcrire un fichier de preuves Lean de ce dépôt en français, dans le document LaTeX jumeau. Utiliser quand on demande de transcrire, traduire ou rédiger en français une preuve Lean, de mettre à jour un .tex de courses/, ou de rendre lisible une démonstration formelle.
---

# Transcrire une preuve Lean en français

Chaque fichier `courses/**/X.lean` a un jumeau `X.tex` : le même contenu mathématique,
rédigé pour un lecteur humain. Le squelette du `.tex` (préambule, sections, énoncés,
liens vers le dépôt) est produit par `python3 tools/generate-tex.py` ; ce qui suit décrit
la partie qui ne se scripte pas : la démonstration en français.

## Règle première

**Transcrire, pas réécrire.** La démonstration en français suit les étapes du script
Lean, dans leur ordre, avec leurs cas et leurs hypothèses. On ne substitue pas une preuve
plus élégante, on n'en abrège pas un cas, on n'en ajoute pas un lemme que le fichier ne
contient pas. Si la preuve Lean est laide, la transcription est laide.

Ce qui peut être ajouté, et rien d'autre : les justifications que le script laisse
implicites parce qu'une tactique les a automatisées, et qu'un lecteur humain attend.

## Procédure

1. Lire le fichier `.lean` en entier, y compris les docstrings : elles contiennent
   souvent déjà l'idée de la preuve.
2. Lancer `python3 tools/generate-tex.py` si le `.tex` n'existe pas encore. Le script ne
   réécrit jamais un `.tex` existant, donc les transcriptions déjà faites sont
   conservées.
3. Pour chaque `theorem` et `lemma`, insérer un environnement `proof` après l'énoncé.
   Les `def` n'en reçoivent pas — une définition ne se démontre pas.
4. Compiler : `tectonic courses/…/X.tex`. Corriger les débordements plutôt que les laisser.
5. Mettre à jour le statut de l'énoncé dans l'index du chapitre et dans `college.md` ou
   `lycee.md` si la transcription révèle un écart.

## Traduire les tactiques

Le vocabulaire ci-dessous fixe la correspondance. Ne pas nommer une tactique dans le
texte français : nommer ce qu'elle fait.

| Lean | Français |
|---|---|
| `omega` | « relève de l'arithmétique linéaire » — préciser l'égalité ou l'inégalité en jeu |
| `decide` | « vérifié par calcul », en disant ce qui est évalué |
| `simp`, `rfl`, `Iff.rfl` | « par définition », « les deux membres sont le même énoncé » |
| `exact ⟨w, _⟩` | « il suffit de prendre `w` », « on prend `w` », « avec `w` » |
| `obtain ⟨k, hk⟩ := h` | « on écrit `h` sous la forme … » |
| `cases`, `rcases`, `by_cases` | « distinguons deux cas », « selon que … » |
| `induction … using Nat.strongRecOn` | « par récurrence forte sur `n` » |
| `Classical.byContradiction` | « par l'absurde » |
| `calc` | une chaîne d'égalités affichée, avec la justification de chaque pas |
| `rw [h]`, `▸` | « en remplaçant … par … », le plus souvent silencieux |
| un lemme de la bibliothèque (`Nat.dvd_add`, `Real.sq_sqrt`, `mul_eq_zero`…) | **le traduire** : dire en français ce qu'il affirme, jamais recopier l'identifiant seul |

Un nom de lemme n'est pas une démonstration. `Nat.le_of_dvd` ne se transcrit pas par
« c'est `Nat.le_of_dvd` », mais par ce qu'il dit : « si `n = ak` avec `n > 0`, alors
`k ≥ 1`, donc `a ≤ n` ». Le nom peut suivre entre parenthèses quand il aide à retrouver le
lemme, jamais tenir lieu d'argument. Même chose pour les notations : `Nat`, `Int`, `Rat`,
`Real` s'écrivent ℕ, ℤ, ℚ, ℝ, et `a ∣ b`, `a % b`, `a / b` deviennent respectivement
« `a` divise `b` », `a \bmod b` et `\lfloor a/b \rfloor` sur les entiers.

Exhiber un objet ne se dit pas « le témoin est `w` », calque de la logique formelle : en
français on écrit « il suffit de prendre `w` », « on prend `w` », « `w` convient ». Même
principe pour le reste du vocabulaire : préférer la tournure qu'emploierait un manuel à
celle qu'emploierait un assistant de preuve.

Une tactique d'automatisation ne dispense pas d'expliquer : `omega` qui clôt
`n = 2 * (n / 2)` sous l'hypothèse `n % 2 = 0` se transcrit par la raison mathématique,
pas par « la tactique conclut ».

## Se mettre au niveau de la classe

Chaque énoncé porte un niveau dans `courses/college.md` ou `courses/lycee.md` (6e à 3e, 2de à terminale).
La rédaction se règle sur ce niveau : un critère de divisibilité de 6e ne se démontre pas
dans la langue d'un article de recherche.

**Au collège** : phrases courtes, pas de quantificateur symbolique, pas de vocabulaire de
logique. On écrit « un nombre pair s'écrit `2k` », « le reste de la division de `n` par
`10` », « on met les deux fractions au même dénominateur ». On évite « existentielle »,
« prédicat », « témoin », « hypothèse », au profit de « on peut écrire », « on sait que »,
« il suffit de prendre ». Un calcul se dit « en développant », « en simplifiant », pas
« par arithmétique linéaire ».

**Au lycée** : quantificateurs, notations ensemblistes, récurrence, fonctions et suites
sont disponibles à partir du moment où le programme du niveau visé les a introduits — la
récurrence en terminale, le produit scalaire en première, et ainsi de suite.

**Quand la preuve formelle dépasse le niveau**, ce qui arrive souvent — une récurrence
forte pour un énoncé de 6e, des congruences pour un critère de divisibilité, la théorie de
la mesure derrière une loi de probabilité de terminale — le dire en une phrase, sans
s'excuser et sans faire semblant : « la démonstration ci-dessous emploie une récurrence,
outil de terminale, alors que l'énoncé est de 6e ». Cet écart est précisément ce que le
dépôt cherche à mesurer.

Ne jamais simplifier au point de fausser : mieux vaut un mot hors niveau, signalé comme
tel, qu'une phrase fausse mais accessible.

## Les énoncés portent leur formule

Un théorème se transcrit par ce qu'il affirme, formule comprise. « Une homothétie de
rapport `k` multiplie les distances » ne dit pas de combien ; l'énoncé est :

    \[ \mathrm{dist}\bigl(h(x), h(y)\bigr) = |k| \times \mathrm{dist}(x, y) . \]

La phrase française nomme le résultat, la formule le donne. Quand l'énoncé Lean porte des
hypothèses (`k ≠ 0`, `0 < b`, `a ≥ 0`), elles figurent dans la transcription : un énoncé
amputé de ses hypothèses est faux, pas simplifié.

## Les définitions portent leur formule

Une définition ne se transcrit pas par son intitulé. « Somme des chiffres » ne définit
rien ; ce qui définit, c'est la formule, reprise du corps du `def` Lean et posée en
display :

    \[ S(0) = 0, \qquad S(n) = (n \bmod 10) + S(\lfloor n/10 \rfloor)
       \ \text{ pour } n \ne 0 . \]

Une phrase en français dit ce que la formule veut dire, la formule dit ce qu'elle est.
Pour une définition récursive, donner les deux cas et la raison de la terminaison ; pour
un prédicat, l'équivalence complète. Seules les définitions sans contenu algébrique (un
type, une structure) s'en passent.

## Garder les calculs

Quand la preuve Lean calcule — un `calc`, un `ring`, un `field_simp`, une suite de
réécritures — **le calcul figure dans la transcription**, posé en formule, et non résumé
par une phrase. « On réduit au même dénominateur puis on identifie les numérateurs » ne
remplace pas :

    \[
    \frac{a}{b} + \frac{c}{d} = \frac{ad}{bd} + \frac{cb}{bd} = \frac{ad + cb}{bd} .
    \]

Une phrase peut précéder le calcul pour dire ce qu'on fait, ou le suivre pour dire ce
qu'on en tire ; elle ne s'y substitue pas. Un lecteur doit pouvoir refaire le calcul sans
ouvrir le fichier Lean.

Deux exceptions : les vérifications purement numériques qu'un élève ferait de tête
(« $2^2 - 5 \times 2 + 6 = 0$ » se donne tel quel, sans détail), et les calculs qu'une
tactique produit sans qu'on puisse les lire (`decide`, `norm_num` sur de grosses
expressions) — là, dire ce qui est vérifié et par quel moyen.

## Conventions du document

- Tout en français : énoncés, démonstrations, titres. Seuls les identifiants Lean restent
  tels quels, en `\texttt{}`.
- Notations : `∣` devient `\mid`, `%` devient `\bmod`, la division entière `a / b` devient
  `\lfloor a/b \rfloor`. Sur `Nat`, rappeler au besoin que la soustraction est tronquée.
- Les variables gardent les noms du fichier Lean : un lecteur doit pouvoir suivre les deux
  textes côte à côte.
- Chaque énoncé porte déjà son nom Lean et le lien vers ses lignes dans le dépôt,
  engendrés par le script : ne pas les recopier dans la démonstration.
- Guillemets français `\og{}` `\fg{}`, tiret cadratin `\textemdash{}`.

## Les conventions de Lean ne sont pas des mathématiques

Lean exige que toute fonction soit totale, alors Mathlib complète celles qui ne le sont
pas : `x / 0 = 0`, `a - b = 0` quand `b > a` sur ℕ, `Real.sqrt` d'un négatif vaut `0`.
Ces valeurs de remplissage rendent des théorèmes vrais dans des cas où l'énoncé
mathématique n'a aucun sens.

**Ne jamais les présenter comme une vérité mathématique.** « Sur ℚ, la division par zéro
vaut zéro » est faux : la division par zéro n'est pas définie. Ce qui est vrai, c'est que
*Lean* la définit ainsi pour rendre la fonction totale.

La transcription doit donc, chaque fois qu'une valeur de remplissage intervient : énoncer
les hypothèses que réclame l'énoncé mathématique (`c ≠ 0`, `b ≤ a`, `0 ≤ a`), puis dire
que le théorème formel s'en passe grâce à une convention de la bibliothèque, et que
l'égalité y est alors vraie pour de mauvaises raisons.

## Ce qui n'est pas démontré

Quand le fichier Lean laisse un énoncé de côté — `sorry`, unicité admise, hypothèse
ajoutée que l'énoncé scolaire n'a pas — le dire explicitement dans le document, en
paragraphe séparé, et dire pourquoi. C'est l'objet même du dépôt : mesurer l'écart entre
l'énoncé de la classe et ce que la formalisation exige. Ne jamais présenter comme
démontré ce qui ne l'est pas, et ne jamais combler un trou par une preuve inventée.
