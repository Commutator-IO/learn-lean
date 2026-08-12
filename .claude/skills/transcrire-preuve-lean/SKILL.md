---
name: transcrire-preuve-lean
description: Transcrire un fichier de preuves Lean de ce dépôt en français, dans le document LaTeX jumeau. Utiliser quand on demande de transcrire, traduire ou rédiger en français une preuve Lean, de mettre à jour un .tex de cours/, ou de rendre lisible une démonstration formelle.
---

# Transcrire une preuve Lean en français

Chaque fichier `cours/**/X.lean` a un jumeau `X.tex` : le même contenu mathématique,
rédigé pour un lecteur humain. Le squelette du `.tex` (préambule, sections, énoncés,
liens vers le dépôt) est produit par `python3 outils/generer-tex.py` ; ce qui suit décrit
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
2. Lancer `python3 outils/generer-tex.py` si le `.tex` n'existe pas encore. Le script ne
   réécrit jamais un `.tex` existant, donc les transcriptions déjà faites sont
   conservées.
3. Pour chaque `theorem` et `lemma`, insérer un environnement `proof` après l'énoncé.
   Les `def` n'en reçoivent pas — une définition ne se démontre pas.
4. Compiler : `tectonic cours/…/X.tex`. Corriger les débordements plutôt que les laisser.
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
| un lemme de la bibliothèque | l'énoncer en français, et donner son nom entre parenthèses |

Exhiber un objet ne se dit pas « le témoin est `w` », calque de la logique formelle : en
français on écrit « il suffit de prendre `w` », « on prend `w` », « `w` convient ». Même
principe pour le reste du vocabulaire : préférer la tournure qu'emploierait un manuel à
celle qu'emploierait un assistant de preuve.

Une tactique d'automatisation ne dispense pas d'expliquer : `omega` qui clôt
`n = 2 * (n / 2)` sous l'hypothèse `n % 2 = 0` se transcrit par la raison mathématique,
pas par « la tactique conclut ».

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

## Ce qui n'est pas démontré

Quand le fichier Lean laisse un énoncé de côté — `sorry`, unicité admise, hypothèse
ajoutée que l'énoncé scolaire n'a pas — le dire explicitement dans le document, en
paragraphe séparé, et dire pourquoi. C'est l'objet même du dépôt : mesurer l'écart entre
l'énoncé de la classe et ce que la formalisation exige. Ne jamais présenter comme
démontré ce qui ne l'est pas, et ne jamais combler un trou par une preuve inventée.
