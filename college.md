# Programme du collège — théorèmes et propriétés

Le programme de mathématiques du collège français (cycle 3 pour la 6e, cycle 4 pour la
5e–3e), pris tel quel. La liste ne retient pas seulement ce qui se formalise bien : elle
recense ce que le programme demande, y compris les énoncés qui résistent à la
formalisation — constructions à la règle et au compas, lectures graphiques, définitions
de grandeurs, modélisation probabiliste, algorithmique.

Se prolonge par le [programme du lycée](lycee.md). Statuts et conventions : voir le
[README](README.md). Les fiches détaillées sont dans [`cours/college/`](cours/college/README.md).

Niveaux indicatifs : **6e** (cycle 3), **5e**, **4e**, **3e** (cycle 4).

---

## 1. Nombres et calculs

### Entiers, divisibilité

| Énoncé | Niveau | Démontré |
|---|---|---|
| Un entier est pair ou impair, jamais les deux | 6e | ☐ |
| Somme de deux pairs = pair ; pair + impair = impair ; impair + impair = pair | 6e | ☐ |
| Notion de multiple et de diviseur ; un diviseur de `n` est inférieur ou égal à `n` | 6e | ☐ |
| Critère de divisibilité par 2, par 5, par 10 (chiffre des unités) | 6e | ☐ |
| Critère de divisibilité par 3 et par 9 (somme des chiffres) | 6e | ☐ |
| Critère de divisibilité par 4 (deux derniers chiffres) | 5e | ☐ |
| Si `a ∣ b` et `a ∣ c` alors `a ∣ (b + c)` et `a ∣ (b − c)` | 5e | ☐ |
| Division euclidienne : existence et unicité de `(q, r)` avec `a = bq + r`, `0 ≤ r < b` | 6e | ☐ |
| Nombre premier ; tout entier > 1 admet un diviseur premier | 3e | ☐ |
| Crible d'Ératosthène : lister les nombres premiers inférieurs à 100 | 3e | ☐ |
| Décomposition en produit de facteurs premiers | 3e | ☐ |
| PGCD, algorithme d'Euclide : `pgcd(a, b) = pgcd(b, a mod b)` | 3e | ☐ |
| Nombres premiers entre eux ⟺ `pgcd = 1` | 3e | ☐ |
| Toute fraction admet une écriture irréductible | 3e | ☐ |

### Écritures des nombres

| Énoncé | Niveau | Démontré |
|---|---|---|
| Numération décimale de position ; valeur d'un chiffre selon son rang | 6e | ☐ |
| Ordre sur les décimaux ; comparaison, encadrement, intercalation | 6e | ☐ |
| Ordre sur les relatifs ; opposé, distance à zéro | 5e | ☐ |
| Égalité de fractions : `a/b = (ka)/(kb)` pour `k ≠ 0` | 5e | ☐ |
| Comparaison de fractions ; mise au même dénominateur | 5e | ☐ |
| Une fraction n'a pas toujours d'écriture décimale exacte (`1/3`) | 5e | ☐ |
| Arrondi, troncature, valeur approchée à `10⁻ⁿ` près, encadrement | 6e / 5e | ☐ |
| Ordre de grandeur d'un résultat ; contrôle de la vraisemblance d'un calcul | 5e | ☐ |
| Écriture scientifique : existence et unicité de `a × 10ⁿ` avec `1 ≤ \|a\| < 10` | 4e | ☐ |
| Racine carrée : `(√a)² = a` et `√(a²) = a` pour `a ≥ 0` | 3e | ☐ |
| `√(ab) = √a × √b` et `√(a/b) = √a / √b` (`a ≥ 0`, `b > 0`) | 3e | ☐ |
| Contre-exemple : `√(a + b) ≠ √a + √b` en général | 3e | ☐ |
| Rationnels et irrationnels : `√2` n'est pas rationnel (admis au collège) | 3e | ☐ |

### Calculs et calcul littéral

| Énoncé | Niveau | Démontré |
|---|---|---|
| Priorités opératoires ; rôle des parenthèses | 5e | ☐ |
| Addition et soustraction des relatifs ; `a − b = a + (−b)` | 5e | ☐ |
| Règle des signes pour la multiplication et la division | 5e | ☐ |
| Somme, produit, quotient de fractions ; diviser = multiplier par l'inverse | 5e / 4e | ☐ |
| Distributivité simple : `k(a + b) = ka + kb` | 5e | ☐ |
| Double distributivité : `(a + b)(c + d) = ac + ad + bc + bd` | 4e | ☐ |
| Factorisation d'une expression à facteur commun | 4e | ☐ |
| Un produit est nul ⟺ l'un des facteurs est nul | 3e | ☐ |
| Puissances : `aᵐ × aⁿ = aᵐ⁺ⁿ`, `aᵐ / aⁿ = aᵐ⁻ⁿ`, `(aᵐ)ⁿ = aᵐⁿ`, `(ab)ⁿ = aⁿbⁿ` | 4e | ☐ |
| `a⁻ⁿ = 1/aⁿ` pour `a ≠ 0` ; `a⁰ = 1` | 4e | ☐ |
| Conservation des inégalités : `a ≤ b ⟹ a + c ≤ b + c` ; multiplier par `c > 0` conserve, par `c < 0` inverse | 4e | ☐ |
| Équation du premier degré `ax + b = 0` : solution unique si `a ≠ 0` | 4e / 3e | ☐ |
| Équation produit `(ax + b)(cx + d) = 0` | 3e | ☐ |
| Tester si un nombre est solution ; démontrer qu'une égalité est vraie pour tout `x` | 4e | ☐ |
| Programme de calcul : deux programmes donnent le même résultat pour toute entrée | 5e → 3e | ☐ |

---

## 2. Géométrie plane

### Droites, angles, parallèles

| Énoncé | Niveau | Démontré |
|---|---|---|
| Par deux points distincts passe une droite et une seule | 6e | ☐ |
| Deux droites perpendiculaires à une même droite sont parallèles entre elles | 6e | ☐ |
| Si deux droites sont parallèles, toute perpendiculaire à l'une est perpendiculaire à l'autre | 6e | ☐ |
| Deux droites parallèles à une même droite sont parallèles entre elles | 6e | ☐ |
| Le plus court chemin d'un point à une droite est le segment perpendiculaire | 6e | ☐ |
| Angles opposés par le sommet : ils sont égaux | 6e | ☐ |
| Angles adjacents, complémentaires, supplémentaires | 6e | ☐ |
| Deux parallèles coupées par une sécante : angles alternes-internes et correspondants égaux | 5e | ☐ |
| Réciproque : égalité de deux angles alternes-internes ⟹ parallélisme | 5e | ☐ |
| Caractérisation de la médiatrice : `M` équidistant de `A` et `B` ⟺ `M` sur la médiatrice de `[AB]` | 6e | ☐ |
| Caractérisation de la bissectrice : équidistance aux deux côtés de l'angle | 6e | ☐ |
| Constructions à la règle et au compas : médiatrice, bissectrice, perpendiculaire, report de longueur | 6e | ☐ |

### Triangles

| Énoncé | Niveau | Démontré |
|---|---|---|
| Somme des angles d'un triangle = 180° | 5e | ☐ |
| Angles d'un triangle équilatéral = 60° ; angles à la base d'un isocèle égaux, et réciproque | 5e | ☐ |
| Inégalité triangulaire : `AC ≤ AB + BC`, égalité ⟺ `B ∈ [AC]` | 5e | ☐ |
| Un triangle est constructible ⟺ l'inégalité triangulaire est vérifiée | 5e | ☐ |
| Cas d'égalité et cas de similitude des triangles | 4e / 3e | ☐ |
| Théorème de Pythagore : rectangle en `A` ⟹ `BC² = AB² + AC²` | 4e | ☐ |
| Réciproque de Pythagore : `BC² = AB² + AC²` ⟹ rectangle en `A` | 4e | ☐ |
| Contraposée : `BC² ≠ AB² + AC²` ⟹ non rectangle en `A` | 4e | ☐ |
| Théorème des milieux : la droite des milieux est parallèle au troisième côté et de longueur moitié | 4e | ☐ |
| Réciproque : la parallèle menée par le milieu d'un côté coupe le deuxième côté en son milieu | 4e | ☐ |
| Théorème de Thalès (triangle et « papillon ») : `AM/AB = AN/AC = MN/BC` | 3e | ☐ |
| Réciproque de Thalès : égalité des rapports et bon ordre des points ⟹ parallélisme | 3e | ☐ |
| Trigonométrie du triangle rectangle : définitions de `cos`, `sin`, `tan` d'un angle aigu | 4e / 3e | ☐ |
| `cos²x + sin²x = 1` et `tan x = sin x / cos x` | 3e | ☐ |
| Concours des médiatrices ⟹ cercle circonscrit | 5e | ☐ |
| Concours des médianes (centre de gravité), des hauteurs (orthocentre), des bissectrices (cercle inscrit) | 5e / 4e | ☐ |

### Cercle et quadrilatères

| Énoncé | Niveau | Démontré |
|---|---|---|
| Un triangle inscrit dans un cercle dont un côté est un diamètre est rectangle | 4e | ☐ |
| Réciproque : l'hypoténuse est un diamètre du cercle circonscrit | 4e | ☐ |
| Dans un triangle rectangle, la médiane issue de l'angle droit vaut la moitié de l'hypoténuse | 4e | ☐ |
| La tangente à un cercle est perpendiculaire au rayon au point de contact | 3e | ☐ |
| Parallélogramme ⟺ diagonales se coupant en leur milieu ⟺ côtés opposés parallèles ⟺ côtés opposés de même longueur | 5e | ☐ |
| Dans un parallélogramme, angles opposés égaux et angles consécutifs supplémentaires | 5e | ☐ |
| Caractérisations du rectangle, du losange, du carré | 5e | ☐ |
| Axes de symétrie et centre de symétrie des quadrilatères usuels et du cercle | 6e / 5e | ☐ |

### Repérage et espace

| Énoncé | Niveau | Démontré |
|---|---|---|
| Repérage dans le plan : couple de coordonnées, abscisse et ordonnée | 5e | ☐ |
| Coordonnées du milieu d'un segment | 3e | ☐ |
| Distance entre deux points repérés (via Pythagore) | 3e | ☐ |
| Solides usuels : pavé, prisme, cylindre, pyramide, cône, boule ; faces, arêtes, sommets | 6e → 4e | ☐ |
| Patrons d'un solide ; représentation en perspective cavalière | 6e / 5e | ☐ |
| Sections planes d'un pavé, d'un cylindre | 3e | ☐ |
| Repérage sur la sphère terrestre : latitude, longitude | 5e | ☐ |

---

## 3. Transformations du plan

| Énoncé | Niveau | Démontré |
|---|---|---|
| Symétrie axiale, symétrie centrale, translation, rotation : conservation des longueurs, des angles, des aires, de l'alignement | 6e → 4e | ☐ |
| La symétrie centrale transforme une droite en une droite parallèle | 5e | ☐ |
| Composition de deux symétries centrales = translation | 5e | ☐ |
| Homothétie de rapport `k` : longueurs multipliées par `\|k\|`, angles conservés, droite envoyée sur une parallèle | 3e | ☐ |
| Figures semblables : angles égaux et longueurs proportionnelles | 3e | ☐ |
| Frises, pavages, rosaces : reconnaître les transformations qui laissent la figure invariante | 5e / 4e | ☐ |

---

## 4. Grandeurs et mesures

| Énoncé | Niveau | Démontré |
|---|---|---|
| Distinguer une grandeur de sa mesure ; unités et conversions | 6e | ☐ |
| Mesure d'angles en degrés ; durées en système sexagésimal | 6e | ☐ |
| Périmètre du cercle `2πr` ; aire du disque `πr²` | 6e | ☐ |
| Aires : rectangle, triangle (`base × hauteur / 2`), parallélogramme, trapèze | 6e / 5e | ☐ |
| Deux figures de même aire peuvent avoir des périmètres différents, et réciproquement | 6e | ☐ |
| Volumes : pavé, prisme, cylindre (`aire de base × hauteur`), pyramide et cône (`× 1/3`), boule (`4/3 πr³`) | 5e → 3e | ☐ |
| Agrandissement-réduction de rapport `k` : longueurs `× k`, aires `× k²`, volumes `× k³` | 3e | ☐ |
| Grandeurs quotients : vitesse `v = d / t`, débit, masse volumique, prix au kilo | 4e | ☐ |
| Vitesse moyenne : ce n'est pas la moyenne des vitesses | 4e | ☐ |
| Échelle d'un plan ou d'une carte | 5e / 4e | ☐ |

---

## 5. Proportionnalité et fonctions

| Énoncé | Niveau | Démontré |
|---|---|---|
| Reconnaître une situation de proportionnalité ; coefficient de proportionnalité | 6e | ☐ |
| Un tableau est proportionnel ⟺ les produits en croix sont égaux | 6e / 4e | ☐ |
| Égalité des produits en croix : `a/b = c/d ⟺ ad = bc` (`b, d ≠ 0`) | 4e | ☐ |
| Quatrième proportionnelle : existence et unicité | 6e / 5e | ☐ |
| Pourcentage d'une quantité ; appliquer et retrouver un taux d'évolution | 5e / 4e | ☐ |
| Composition de deux évolutions : appliquer `p` puis `q` revient à multiplier par `(1+p)(1+q)` | 4e | ☐ |
| Une évolution de `+p` puis `−p` ne ramène pas à la valeur initiale | 4e | ☐ |
| Notion de fonction : image, antécédent, notation `f(x)`, tableau de valeurs | 3e | ☐ |
| Une image est unique, un antécédent ne l'est pas nécessairement | 3e | ☐ |
| Lecture graphique d'une image, d'un antécédent | 3e | ☐ |
| Fonction linéaire `x ↦ ax` : traduit exactement la proportionnalité ; graphe = droite par l'origine | 3e | ☐ |
| Fonction affine `x ↦ ax + b` : graphe = droite ; `a` coefficient directeur, `b` ordonnée à l'origine | 3e | ☐ |
| `a = (f(x₂) − f(x₁)) / (x₂ − x₁)` pour une fonction affine | 3e | ☐ |
| Sens de variation d'une fonction affine selon le signe de `a` | 3e | ☐ |

---

## 6. Statistiques et probabilités

| Énoncé | Niveau | Démontré |
|---|---|---|
| Effectifs, fréquences ; la somme des fréquences vaut 1 | 6e / 5e | ☐ |
| Représentations : diagrammes en bâtons, circulaires, histogrammes ; choisir une représentation adaptée | 6e → 4e | ☐ |
| Moyenne : linéarité (`moyenne(x + c) = moyenne(x) + c`), moyenne pondérée | 4e | ☐ |
| La moyenne est comprise entre le minimum et le maximum de la série | 4e | ☐ |
| La moyenne de plusieurs moyennes n'est pas la moyenne de la série globale | 4e | ☐ |
| Médiane : au moins la moitié des valeurs lui sont inférieures ou égales | 4e | ☐ |
| Étendue = max − min ; la moyenne est sensible aux valeurs extrêmes, la médiane non | 6e / 4e | ☐ |
| Probabilité : `0 ≤ P(A) ≤ 1`, somme des probabilités des issues = 1 | 3e | ☐ |
| Événement contraire : `P(Ā) = 1 − P(A)` | 3e | ☐ |
| Équiprobabilité : `P(A) = card(A) / card(Ω)` | 3e | ☐ |
| Expérience à deux épreuves : arbre pondéré, produit des probabilités le long d'une branche | 3e | ☐ |
| Fréquence observée et probabilité : fluctuation d'échantillonnage, stabilisation quand `n` grandit | 3e | ☐ |
| Simuler une expérience aléatoire et comparer à la valeur théorique | 3e | ☐ |

---

## 7. Algorithmique et programmation

| Énoncé | Niveau | Démontré |
|---|---|---|
| Notion de variable, d'affectation ; état d'un programme après exécution | 5e | ☐ |
| Boucle bornée : un programme répétant `n` fois une instruction produit tel résultat | 5e | ☐ |
| Boucle non bornée, instruction conditionnelle ; terminaison d'un programme simple | 4e | ☐ |
| Correction d'un programme de calcul : ce qu'il calcule vaut telle expression de l'entrée | 4e / 3e | ☐ |
| Deux programmes différents calculent la même chose | 4e / 3e | ☐ |
