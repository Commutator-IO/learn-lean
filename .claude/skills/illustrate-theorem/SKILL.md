---
name: illustrate-theorem
description: Dessiner la figure d'un théorème de ce dépôt — une version vectorielle TikZ pour le livre PDF, une version SVG (et son JS facultatif) pour le site. Utiliser quand on demande d'illustrer, de dessiner, de faire une figure, un schéma ou une animation pour un énoncé, ou d'ajouter des illustrations à un chapitre.
---

# Illustrer un théorème

Une figure a deux vies dans ce dépôt : imprimée dans le livre, où elle doit être vectorielle
et composée dans les polices du document, et affichée sur le site, où elle peut se laisser
manipuler. Ce sont deux fichiers, écrits l'un après l'autre, et qui montrent la même chose.

## Règle première

**Une figure illustre, elle ne démontre pas.** Elle rend un énoncé lisible : elle ne
remplace aucune étape de la preuve et n'ajoute aucune hypothèse. Un lecteur qui la couvre
de la main doit pouvoir suivre la démonstration sans elle.

Deuxième règle : **on n'illustre pas tout**. Une figure se justifie quand l'énoncé parle
d'objets qu'on voit — une configuration géométrique, une courbe et son aire, un arbre
pondéré, une suite qui s'approche de sa limite. Un calcul algébrique, une divisibilité,
une identité remarquable n'ont pas de figure : en dessiner une est du bruit.

## Où vivent les fichiers

    courses/<programme>/<chapitre>/figures/<nom_du_theoreme>.tex   TikZ, pour le livre
    courses/<programme>/<chapitre>/figures/<nom_du_theoreme>.svg   SVG, pour le site
    courses/<programme>/<chapitre>/figures/<nom_du_theoreme>.js    interaction, facultatif

Le nom du fichier est celui de la déclaration Lean, à l'identique : c'est par là que le
site et le livre retrouvent la figure. Un `example` anonyme ne peut donc pas être illustré ;
lui donner un nom d'abord, s'il mérite une figure.

## La construction, écrite une fois

Les deux fichiers dessinent la même chose, et rien ne les force à rester d'accord. On s'en
protège en écrivant les coordonnées **une fois**, en tête du `.tex`, dans un commentaire, et
en les recopiant telles quelles dans le `.svg` :

    % Construction : A = (0, 0), B = (4, 0), C = (0, 3).
    % Le carré de l'hypoténuse est porté par [BC], les deux autres par [AB] et [AC].

Si une coordonnée change, elle change dans les deux fichiers. Une figure dont les deux
versions divergent est un défaut au même titre qu'une preuve fausse.

## La version du livre : TikZ

TikZ, et pas une image importée : les étiquettes sont alors composées dans les polices du
livre, et la figure reste nette à toute échelle.

```latex
% Construction : A = (0, 0), B = (4, 0), C = (0, 3).
\begin{tikzpicture}[scale=0.9, >=stealth]
  \coordinate (A) at (0, 0);
  \coordinate (B) at (4, 0);
  \coordinate (C) at (0, 3);
  \draw (A) -- (B) -- (C) -- cycle;
  \draw (A) rectangle +(0.3, 0.3);          % l'angle droit
  \node[below] at ($(A)!0.5!(B)$) {$c$};
  \node[left]  at ($(A)!0.5!(C)$) {$b$};
  \node[above right] at ($(B)!0.5!(C)$) {$a$};
\end{tikzpicture}
```

Conventions :

- pas de couleur, ou une seule, celle du dépôt (`brand`), et jamais comme unique porteuse
  d'information : ce qui est distingué par la couleur l'est aussi par le trait ;
- les longueurs en unités TikZ, la figure tient dans `10cm` de large ;
- les étiquettes en mode mathématique, avec les mêmes lettres que l'énoncé français ;
- `\usetikzlibrary` va dans le préambule, jamais dans le fichier de figure.

Le fichier ne contient que le `tikzpicture` : ni préambule, ni `\begin{figure}`. C'est le
document qui l'insère :

```latex
\begin{figure}[h]
\centering
\input{figures/pythagore}
\caption{...}
\end{figure}
```

`tools/generate-book.py` réécrit ce chemin quand il assemble le livre — ne pas l'écrire en
absolu.

## La version du site : SVG

Un fichier SVG autonome, lisible dans un éditeur de texte, sans référence extérieure. Il
est repris tel quel par `site/scripts/manifest.mjs`, qui l'attache à la déclaration du même
nom, et inséré dans la page par le composant `Figure` — donc jamais chargé comme une image,
ce qui lui permet de suivre la couleur du texte.

- `viewBox` obligatoire, pas de `width`/`height` fixes : la figure s'adapte au volet. C'est
  la feuille de style qui lui donne sa largeur ; un SVG sans dimension se replie à zéro dans
  un conteneur flexible, et l'on croit alors la figure absente ;
- `stroke="currentColor"` pour les traits, `fill="none"` par défaut : la figure suit la
  couleur du texte, donc le thème ;
- les étiquettes en `<text>`, `font-style="italic"`, jamais d'image bitmap ni de police
  chargée ;
- un `<title>` en première ligne : c'est ce que lit un lecteur d'écran.

```svg
<svg viewBox="0 0 200 160" xmlns="http://www.w3.org/2000/svg" stroke="currentColor" fill="none">
  <title>Triangle rectangle en A, de côtés b et c et d'hypoténuse a</title>
  <polygon points="20,140 180,140 20,20" />
  <path d="M20,128 h12 v12" />
  <text x="100" y="155" fill="currentColor" stroke="none" font-style="italic">c</text>
</svg>
```

## L'interaction, seulement si elle apprend quelque chose

Le fichier `.js` est facultatif et doit rester rare. Il n'a de sens que si **déplacer**
montre ce qu'une figure fixe ne montre pas : un point qui parcourt un cercle et voit
l'angle inscrit rester constant, une subdivision qu'on affine et qui fait apparaître
l'intégrale. Une animation décorative n'a pas sa place.

Le module exporte une seule fonction, qui reçoit l'élément `<svg>` déjà inséré :

```js
/** Le point M se déplace sur le cercle ; l'angle inscrit ne bouge pas. */
export function initialiser(svg) {
  // …
}
```

Contraintes : pas de dépendance, pas de `fetch`, pas de minuterie qui tourne en fond quand
la figure est hors de l'écran, et un état initial identique à ce que montre le SVG seul —
le PDF et le site doivent partir de la même image.

## Procédure

1. Choisir l'énoncé et vérifier qu'il se voit. Dans le doute, ne pas illustrer.
2. Écrire la construction en commentaire, puis le `.tex`, puis le `.svg` à partir des mêmes
   coordonnées.
3. Insérer la `figure` dans le `.tex` du chapitre, juste après l'énoncé qu'elle illustre —
   jamais au milieu d'une démonstration.
4. Déclarer `\usepackage{tikz}` dans le document du chapitre s'il ne l'a pas encore —
   `tools/generate-tex.py` le met désormais dans les documents qu'il crée, mais pas dans
   ceux qui existaient avant.
5. Compiler le chapitre : `tectonic courses/<…>/<Chapitre>.tex`, et **regarder la page** :
   `pdftoppm -f <page> -l <page> -r 75 -png <fichier>.pdf <sortie>` rend une image qu'on
   peut ouvrir. Une figure qui déborde ou qui chevauche son titre ne se voit pas autrement.
6. Reconstruire le site : `npm run manifest --prefix site`, et regarder la figure dans les
   deux volets.
7. Reconstruire le livre : `python3 tools/generate-book.py` puis `tectonic book/cours-complet.tex`,
   et vérifier que la figure y est arrivée — le livre passe par une réécriture de chemin,
   c'est un endroit de plus où elle peut se perdre.

## Ce qu'il ne faut pas faire

- Illustrer un énoncé admis (`sorry`) comme s'il était démontré : la figure ne comble pas
  le manque, et le lecteur qui la voit croira le contraire.
- Dessiner un cas particulier en laissant croire au cas général — si le triangle du dessin
  est isocèle alors que l'énoncé ne le suppose pas, le dessin ment.
- Faire porter à la couleur la seule différence entre deux objets.
- Recopier une figure d'un manuel : elles sont protégées, et celles de ce dépôt se
  construisent à partir de l'énoncé Lean, pas d'une source extérieure.
- Mettre la légende dans le fichier de figure : elle appartient au document, qui seul sait
  ce que la figure vient illustrer à cet endroit.
- Croire une figure absente parce que le navigateur ne l'affiche pas : vérifier d'abord
  qu'elle est bien dans les données du site (`site/public/chapters/*.json`, champ
  `figure`), puis qu'elle a une largeur.
