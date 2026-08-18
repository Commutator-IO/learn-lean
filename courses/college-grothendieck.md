# Le programme du collège, dit dans la langue de Grothendieck

Les mêmes énoncés que dans [college.md](college.md), reformulés dans le vocabulaire
qu'Alexandre Grothendieck a construit pour la géométrie algébrique : foncteur des points,
propriété universelle, limite et colimite, adjonction, torseur, faisceau, spectre,
changement de base, dévissage.

**Ce fichier ne démontre rien et ne remplace rien.** La liste de référence, avec ses
statuts et ses fiches, reste [college.md](college.md) ; ici il n'y a ni colonne
*Démontré* ni lien vers les fichiers Lean, pour qu'il n'y ait qu'une source de vérité.
Ce qu'on tient dans les mains est un dictionnaire : à gauche l'énoncé tel que le
programme le pose, à droite ce qu'il devient quand on accepte de le dire autrement.

**L'exercice est anachronique, et parfois c'est un déguisement.** Dire que la règle des
signes est la multiplicativité de `π₀(ℝ*)` n'apprend rien à qui sait déjà multiplier
deux nombres négatifs. Mais l'exercice n'est pas gratuit : dans une bonne moitié des
lignes, la traduction ne réhabille pas l'énoncé, elle en donne la raison. La division
euclidienne devient un système de représentants du quotient ; le théorème de Pythagore,
l'identité de polarisation d'une forme quadratique ; l'agrandissement de rapport `k`,
une graduation par le poids. Quand cela arrive, l'énoncé cesse d'être une règle à retenir
pour devenir la conséquence d'une structure — ce que Grothendieck appelait faire monter
la mer autour de la noix plutôt que de la casser au marteau.

Se prolonge par le [programme du lycée dans la même langue](lycee-grothendieck.md).

## Petit lexique

Le vocabulaire utilisé dans la colonne de droite, dans l'ordre où il devient utile.

| Terme | Ce qu'il veut dire ici |
|---|---|
| **Foncteur des points** | Un objet est connu par les applications qui arrivent dessus : un ensemble, un anneau, un espace se lisent par leurs points *à valeurs dans* autre chose. |
| **Propriété universelle** | Un objet caractérisé non par sa construction mais par le fait qu'il rend un problème unique : il existe une flèche, et une seule. |
| **Objet initial, objet final** | L'objet d'où part une flèche unique vers tous les autres (`ℕ`, `ℤ`), celui vers qui toutes les flèches arrivent (le point). |
| **Limite, colimite** | Ce qu'on obtient en imposant des conditions (produit, intersection, égalisateur) ou en recollant (somme, quotient). |
| **Égalisateur** | Le lieu où deux flèches coïncident. La médiatrice en est un. |
| **Adjonction** | Deux constructions inverses l'une de l'autre « au mieux » : l'enveloppe d'une partie, la projection orthogonale. |
| **Torseur** | Un objet sur lequel un groupe agit simplement transitivement : il ressemble au groupe, mais sans origine. Le plan est un torseur sous ses translations. |
| **Faisceau, recollement** | Une donnée locale qui se recolle en une donnée globale quand les morceaux s'accordent sur leurs intersections. |
| **Spectre, `Spec ℤ`** | L'espace dont les points sont les idéaux premiers d'un anneau. Pour `ℤ` : un point par nombre premier, plus un point générique. |
| **Changement de base** | Regarder un objet au-dessus d'un autre, et le transporter le long d'une flèche. Conditionner une probabilité en est un cas. |
| **Dévissage** | Décomposer un objet en morceaux plus simples reliés par des suites exactes, puis remonter. |
| **Groupe de Grothendieck (`K₀`)** | Le groupe engendré par des objets avec, pour seule relation, le découpage : le cardinal et l'aire en sont deux exemples. |

---

## 1. Nombres et calculs

`ℤ` est l'objet initial des anneaux : il n'y a rien à choisir en lui, et c'est pourquoi
tout le chapitre est une suite de conséquences. Son spectre `Spec ℤ` a un point fermé par
nombre premier et un point générique ; la divisibilité est la topologie de cet espace, les
fractions sont les fonctions qui y ont des pôles, et les critères de divisibilité sont des
égalités entre morphismes.

### Entiers, divisibilité

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Un entier est pair ou impair, jamais les deux | `ℤ` est réunion disjointe des fibres du morphisme d'anneaux `ℤ → 𝔽₂` : « ou » est la surjectivité, « jamais les deux » le fait qu'un morphisme est une application | 6e |
| Somme de deux pairs = pair ; pair + impair = impair ; impair + impair = pair | C'est la table d'addition de `𝔽₂`, transportée par fonctorialité : la réduction modulo `2` est un morphisme, donc elle commute à la somme | 6e |
| Critère de divisibilité par 2, par 5, par 10 (chiffre des unités) | `ℤ/10 ≅ 𝔽₂ × 𝔽₅` : `Spec ℤ/10` est la réunion disjointe de deux points, et le chiffre des unités est l'image dans `ℤ/10`, qu'on projette sur chaque facteur | 6e |
| Critère de divisibilité par 3 et par 9 (somme des chiffres) | L'écriture décimale est un antécédent par l'évaluation `ℤ[X] → ℤ`, `X ↦ 10`. Modulo `9`, `10 ≡ 1` : les deux évaluations `X ↦ 10` et `X ↦ 1` coïncident, et la seconde est la somme des chiffres | 6e |
| Critère de divisibilité par 4 (deux derniers chiffres) | Modulo `4`, `10² ≡ 0` : l'évaluation tue les coefficients de degré `≥ 2`, et il ne reste que le début du développement | 5e |
| Si `a ∣ b` et `a ∣ c` alors `a ∣ (b + c)` et `a ∣ (b − c)` | Diviser, c'est appartenir à un idéal : `a ∣ b ⟺ (b) ⊆ (a)`. Un idéal est un sous-module, donc stable par somme et différence | 5e |
| Division euclidienne : existence et unicité de `(q, r)` avec `a = bq + r`, `0 ≤ r < b` | `[0 ; b[` est un système de représentants de `ℤ/bℤ` : l'existence est la surjectivité de `ℤ → ℤ/bℤ`, l'unicité le fait que la section ainsi choisie ne rencontre chaque classe qu'une fois | 6e |
| Nombre premier ; tout entier > 1 admet un diviseur premier | Un nombre premier est un point fermé de `Spec ℤ` ; tout fermé propre non vide en contient un | 3e |
| PGCD, algorithme d'Euclide : `pgcd(a, b) = pgcd(b, a mod b)` | Le pgcd engendre `(a) + (b)`, borne supérieure des deux idéaux ; l'algorithme calcule cette somme, et il s'arrête parce que `ℤ` est nœthérien | 3e |
| Nombres premiers entre eux ⟺ `pgcd = 1` | `(a) + (b) = ℤ`, c'est-à-dire : les fermés `V(a)` et `V(b)` de `Spec ℤ` sont disjoints — aucun premier ne divise les deux | 3e |
| Décomposition en facteurs premiers : existence et unicité à l'ordre près | Le groupe des diviseurs de `Spec ℤ` est libre sur ses points fermés : `ℚ*/{±1} ≅ ⨁_p ℤ` | 3e |
| Toute fraction admet une écriture irréductible | Une fraction est un germe au point générique ; la liberté du groupe des diviseurs et la petitesse des unités (`±1`) fournissent dans chaque classe un représentant canonique | 3e |

### Écritures des nombres

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Égalité de fractions : `a/b = (ka)/(kb)` pour `k ≠ 0` | La localisation identifie `(a,b)` et `(ka,kb)` parce qu'elle rend `k` inversible : c'est la relation d'équivalence qui définit `ℚ` comme anneau des fractions | 5e |
| Une fraction n'a pas toujours d'écriture décimale exacte (`1/3`) | Les décimaux sont les fonctions régulières sur l'ouvert `D(10) = Spec ℤ ∖ {(2),(5)}`. `1/3` a un pôle en `(3)`, qui appartient à cet ouvert : elle n'y est pas régulière | 5e |
| Écriture scientifique : existence et unicité de `a × 10ⁿ` avec `1 ≤ \|a\| < 10` | `[1 ; 10[` est un domaine fondamental pour l'action libre du groupe discret `10^ℤ` sur `ℝ*₊` : l'existence dit que le domaine rencontre chaque orbite, l'unicité qu'il ne la rencontre qu'une fois | 4e |
| Racine carrée : `(√a)² = a` et `√(a²) = a` pour `a ≥ 0` | L'élévation au carré est un automorphisme du monoïde multiplicatif `ℝ₊` ; `√` en est l'inverse, donc les deux compositions sont l'identité | 3e |
| `√(ab) = √a × √b` et `√(a/b) = √a / √b` (`a ≥ 0`, `b > 0`) | Simple fonctorialité : l'inverse d'un morphisme de monoïdes est un morphisme de monoïdes | 3e |
| Contre-exemple : `√(a + b) ≠ √a + √b` en général | `√` est un morphisme pour la multiplication, pas pour l'addition : lui demander les deux serait en faire un morphisme d'anneaux, ce que la structure n'offre pas | 3e |
| Rationnels et irrationnels : `√2` n'est pas rationnel (admis au collège) | `ℚ[X]/(X² − 2)` est un corps : le `ℚ`-schéma `X² = 2` est un revêtement connexe de degré `2`, sans point rationnel, sur lequel `Gal(ℚ(√2)/ℚ) = ℤ/2` agit en échangeant les deux racines | 3e |

### Calculs et calcul littéral

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Règle des signes pour la multiplication et la division | Le signe est le morphisme de groupes `ℝ* → π₀(ℝ*) ≅ ℤ/2` vers le groupe des composantes connexes ; la règle est sa multiplicativité | 5e |
| Distributivité simple : `k(a + b) = ka + kb` | La multiplication par `k` est un endomorphisme du groupe additif : la distributivité *est* cette linéarité | 5e |
| Double distributivité : `(a + b)(c + d) = ac + ad + bc + bd` | La multiplication est bilinéaire, donc se factorise par le produit tensoriel `A ⊗ A → A` ; développer, c'est écrire l'image d'une somme de tenseurs élémentaires | 4e |
| Un produit est nul ⟺ l'un des facteurs est nul | `(0)` est un idéal premier : l'anneau est intègre, et `Spec A` a un point générique | 3e |
| Puissances : `aᵐ × aⁿ = aᵐ⁺ⁿ`, `aᵐ / aⁿ = aᵐ⁻ⁿ`, `(aᵐ)ⁿ = aᵐⁿ`, `(ab)ⁿ = aⁿbⁿ` | `n ↦ aⁿ` est un morphisme de groupes `ℤ → A*` ; et `x ↦ xⁿ` est un endomorphisme du groupe multiplicatif `𝔾ₘ`. Les quatre règles sont ces deux énoncés | 4e |
| `a⁻ⁿ = 1/aⁿ` pour `a ≠ 0` ; `a⁰ = 1` | Un morphisme de groupes envoie l'inverse sur l'inverse et le neutre sur le neutre : rien de plus n'est demandé | 4e |
| Conservation des inégalités : `a ≤ b ⟹ a + c ≤ b + c` ; multiplier par `c > 0` conserve, par `c < 0` inverse | Vu comme catégorie, `(ℝ, ≤)` a pour automorphismes les translations et les homothéties positives — des foncteurs covariants — et pour anti-automorphismes les homothéties négatives : renverser l'inégalité, c'est être contravariant | 4e |
| Équation du premier degré `ax + b = 0` : solution unique si `a ≠ 0` | `x ↦ ax + b` est un automorphisme de la droite affine dès que `a` est inversible ; résoudre, c'est prendre la fibre d'un isomorphisme, qui a exactement un point | 4e / 3e |
| Équation produit `(ax + b)(cx + d) = 0` | `V(fg) = V(f) ∪ V(g)` : le lieu des zéros d'un produit est la réunion des lieux des zéros | 3e |

---

## 2. Géométrie plane

Le plan n'est pas un groupe : il n'a pas d'origine. C'est un **torseur** sous son groupe de
translations, et choisir un repère, c'est le trivialiser. Tout le chapitre est la théorie
des invariants de son groupe d'automorphismes : les longueurs et les angles sont ce qui
survit aux isométries, les rapports ce qui survit aux applications affines.

### Droites, angles, parallèles

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Par deux points distincts passe une droite et une seule | L'enveloppe affine est l'adjoint à gauche de l'oubli, des parties vers les sous-espaces affines : elle produit *le* plus petit sous-espace contenant `{A, B}`, et l'unicité est celle qu'exige toute propriété universelle | 6e |
| Deux droites perpendiculaires à une même droite sont parallèles entre elles | L'orthogonalité est une connexion de Galois sur les sous-espaces de l'espace quadratique : deux directions ayant même orthogonal ont même bi-orthogonal, donc sont égales dans l'espace des directions | 6e |
| Si deux droites sont parallèles, toute perpendiculaire à l'une est perpendiculaire à l'autre | Même énoncé lu dans l'autre sens : l'orthogonalité ne dépend que de la direction, c'est-à-dire de l'image dans `ℙ¹` | 6e |
| Deux droites parallèles à une même droite sont parallèles entre elles | Le parallélisme est la relation d'équivalence associée au morphisme « direction » vers `ℙ¹` ; sa transitivité est celle de l'égalité des images | 6e |
| Le plus court chemin d'un point à une droite est le segment perpendiculaire | La projection orthogonale est adjointe à l'inclusion : le pied de la perpendiculaire est la meilleure approximation, et c'est la counité de cette adjonction | 6e |
| Angles opposés par le sommet : ils sont égaux | La symétrie centrale est un automorphisme du plan vectoriel qui agit trivialement sur les angles non orientés : les deux angles sont dans une même orbite | 6e |
| Angles adjacents, complémentaires, supplémentaires | L'angle prend ses valeurs dans le groupe `ℝ/2πℤ` : additionner des angles adjacents, c'est composer dans ce groupe | 6e |
| Deux parallèles coupées par une sécante : angles alternes-internes et correspondants égaux | La symétrie centrale au milieu du segment coupé échange les deux configurations ; l'égalité des angles est l'invariance sous ce sous-groupe | 5e |
| Réciproque : égalité de deux angles alternes-internes ⟹ parallélisme | L'invariance caractérise l'orbite : si la symétrie centrale envoie une droite sur l'autre, les deux ont même direction | 5e |
| Caractérisation de la médiatrice : `M` équidistant de `A` et `B` ⟺ `M` sur la médiatrice de `[AB]` | La médiatrice est l'égalisateur des deux fonctions `d(−, A)` et `d(−, B)` : « caractériser » un lieu, c'est le reconnaître comme limite | 6e |
| Caractérisation de la bissectrice : équidistance aux deux côtés de l'angle | Même limite, avec les deux fonctions distance aux côtés : l'égalisateur est stable sous le groupe qui échange les deux côtés | 6e |

### Triangles

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Somme des angles d'un triangle = 180° | Le défaut angulaire mesure la courbure ; il est nul parce que le plan est un torseur sous un groupe abélien, donc à connexion plate. C'est Gauss–Bonnet en courbure nulle | 5e |
| Angles d'un triangle équilatéral = 60° ; angles à la base d'un isocèle égaux, et réciproque | Le groupe d'automorphismes de la figure agit sur ses angles : `S₃` pour l'équilatéral, `ℤ/2` pour l'isocèle. L'égalité des angles est l'existence de cette symétrie, la réciproque sa reconstruction | 5e |
| Inégalité triangulaire : `AC ≤ AB + BC`, égalité ⟺ `B ∈ [AC]` | La norme est une fonction convexe sur le groupe des translations ; le cas d'égalité est le bord de la convexité, c'est-à-dire la colinéarité positive | 5e |
| Théorème de Pythagore : rectangle en `A` ⟹ `BC² = AB² + AC²` | Identité de polarisation : `q(u + v) = q(u) + q(v) + 2⟨u, v⟩`, et l'orthogonalité annule le terme croisé | 4e |
| Réciproque de Pythagore : `BC² = AB² + AC²` ⟹ rectangle en `A` | La forme bilinéaire est déterminée par la forme quadratique, la caractéristique n'étant pas `2` : annuler le terme croisé, c'est être orthogonal | 4e |
| Contraposée : `BC² ≠ AB² + AC²` ⟹ non rectangle en `A` | La contraposée d'une implication est la même flèche lue à l'envers ; rien de neuf n'est démontré | 4e |
| Théorème des milieux : la droite des milieux est parallèle au troisième côté et de longueur moitié | La multiplication par `1/2` dans le groupe des translations est un automorphisme (le groupe est uniquement divisible) : il envoie le côté sur la droite des milieux | 4e |
| Réciproque : la parallèle menée par le milieu d'un côté coupe le deuxième côté en son milieu | L'automorphisme précédent est inversible : sa réciproque est l'énoncé réciproque | 4e |
| Théorème de Thalès (triangle et « papillon ») : `AM/AB = AN/AC = MN/BC` | La projection sur une droite parallèlement à une autre est un morphisme d'espaces affines ; le rapport de trois points alignés est le seul invariant du groupe affine, et un morphisme le conserve | 3e |
| Réciproque de Thalès : égalité des rapports et bon ordre des points ⟹ parallélisme | L'égalité des rapports dit que les deux points sont dans la même orbite sous l'homothétie de centre `A` : leur image par la direction est donc la même | 3e |
| `cos²x + sin²x = 1` et `tan x = sin x / cos x` | Le cercle unité est le noyau du morphisme « norme » `ℂ* → ℝ*₊` ; l'identité est son équation, et la tangente la coordonnée affine sur `ℙ¹` | 3e |
| Concours des médiatrices ⟹ cercle circonscrit | Le lieu des points équidistants de `A`, `B` et `C` est l'égalisateur simultané des trois fonctions distance ; il est non vide parce que la troisième condition est conséquence des deux autres — une relation de cocycle | 5e |
| Concours des médianes (centre de gravité), des hauteurs (orthocentre), des bissectrices (cercle inscrit) | Trois points canoniques : chacun est l'unique point fixe d'une construction équivariante sous le groupe des similitudes, donc naturel au sens des foncteurs | 5e / 4e |

### Cercle et quadrilatères

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Un triangle inscrit dans un cercle dont un côté est un diamètre est rectangle | Théorème de l'angle inscrit : l'angle au centre est le double de l'angle inscrit, c'est-à-dire le revêtement `z ↦ z²` du cercle. Un diamètre correspond à `π` en haut, donc à `π/2` en bas | 4e |
| Réciproque : l'hypoténuse est un diamètre du cercle circonscrit | Le revêtement est surjectif : tout angle droit inscrit relève un angle plat au centre | 4e |
| Dans un triangle rectangle, la médiane issue de l'angle droit vaut la moitié de l'hypoténuse | Le centre du cercle circonscrit est le milieu de l'hypoténuse ; la médiane est un rayon | 4e |
| La tangente à un cercle est perpendiculaire au rayon au point de contact | L'espace tangent au cercle en un point est l'orthogonal du rayon : c'est la différentielle de l'équation `q(x) = r²`, dont le noyau est `(x)^⊥` | 3e |
| Parallélogramme ⟺ diagonales se coupant en leur milieu ⟺ côtés opposés parallèles ⟺ côtés opposés de même longueur | Le parallélogramme est la figure de la commutativité du groupe des translations : `D = B + C − A`. Les trois caractérisations sont trois lectures de cette égalité dans le torseur | 5e |
| Dans un parallélogramme, angles opposés égaux et angles consécutifs supplémentaires | La symétrie centrale au point d'intersection des diagonales est un automorphisme de la figure : les angles opposés sont dans une même orbite | 5e |

### Repérage et espace

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Coordonnées du milieu d'un segment | Un repère est une trivialisation du torseur affine ; le milieu est le barycentre, opération intrinsèque, et sa formule est sa lecture dans la trivialisation | 3e |
| Distance entre deux points repérés (via Pythagore) | La distance est la norme de la différence, lue dans une base orthonormée : que la formule ne dépende pas du repère choisi est un énoncé de descente | 3e |

---

## 3. Transformations du plan

Le chapitre est la suite exacte `1 → Translations → Isométries → O(2) → 1`. Chaque
transformation est un élément, chaque « conservation » un invariant, chaque composition
un produit dans le groupe.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Symétrie axiale, symétrie centrale, translation, rotation : conservation des longueurs, des angles, des aires, de l'alignement | Ce sont des automorphismes de la structure ; longueur, angle, aire et alignement sont les foncteurs invariants de cette structure, donc constants sur les orbites | 6e → 4e |
| La symétrie centrale transforme une droite en une droite parallèle | Sa partie linéaire est `−id`, qui agit trivialement sur `ℙ¹` : la direction est conservée, le point ne l'est pas | 5e |
| Composition de deux symétries centrales = translation | Le morphisme vers `O(2)` envoie chaque symétrie centrale sur `−id` ; leur produit est dans le noyau, c'est-à-dire une translation. C'est l'exactitude de la suite | 5e |
| Homothétie de rapport `k` : longueurs multipliées par `\|k\|`, angles conservés, droite envoyée sur une parallèle | L'action de `𝔾ₘ` sur le plan vectoriel : la longueur est de poids `1`, l'angle de poids `0`, la direction est fixe | 3e |
| Figures semblables : angles égaux et longueurs proportionnelles | Être semblable, c'est être isomorphe dans la catégorie des figures et des similitudes ; l'angle est un invariant de cette catégorie, la longueur n'en est un qu'à un facteur près | 3e |

---

## 4. Grandeurs et mesures

Une grandeur est un morphisme défini sur un groupe de Grothendieck : on engendre
librement par les figures, on impose le découpage comme seule relation, et l'aire est une
flèche partant de ce quotient. Ce que la dilatation fait à ces flèches est une graduation.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Périmètre du cercle `2πr` ; aire du disque `πr²` | `π` est une période : une intégrale de forme algébrique sur un cycle, qui ne se calcule pas dans `ℚ`. C'est le premier nombre du programme qui ne soit pas construit mais mesuré | 6e |
| Aires : rectangle, triangle (`base × hauteur / 2`), parallélogramme, trapèze | L'aire est un morphisme du groupe de Grothendieck des polygones — engendré par les figures, avec le découpage pour relation — vers `ℝ` ; chaque formule est le calcul de l'image d'un générateur | 6e / 5e |
| Deux figures de même aire peuvent avoir des périmètres différents, et réciproquement | Le périmètre n'est pas un morphisme du même groupe : il n'est pas additif par découpage. Deux invariants distincts ne se déterminent pas l'un l'autre | 6e |
| Volumes : pavé, prisme, cylindre (`aire de base × hauteur`), pyramide et cône (`× 1/3`), boule (`4/3 πr³`) | Même morphisme en dimension `3` — mais le facteur `1/3` ne s'obtient pas par découpage fini : c'est le troisième problème de Hilbert, et l'invariant de Dehn en est l'obstruction | 5e → 3e |
| Agrandissement-réduction de rapport `k` : longueurs `× k`, aires `× k²`, volumes `× k³` | Les grandeurs sont graduées par l'action de `𝔾ₘ` : une grandeur de dimension `d` est de poids `d`, et « dimension » est exactement ce poids | 3e |

---

## 5. Proportionnalité et fonctions

Deux objets se partagent le chapitre : la droite projective `ℙ¹`, où vivent les rapports,
et le groupe additif `𝔾ₐ`, dont les endomorphismes sont exactement les fonctions
linéaires. Toute la difficulté que le programme signale — confondre `+p` et `×(1+p)` —
est celle de ne pas confondre `𝔾ₐ` et `𝔾ₘ`.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Un tableau est proportionnel ⟺ les produits en croix sont égaux | La matrice `2×2` est de rang `≤ 1` : ses deux colonnes définissent le même point de `ℙ¹`, et le déterminant est l'obstruction | 6e / 4e |
| Égalité des produits en croix : `a/b = c/d ⟺ ad = bc` (`b, d ≠ 0`) | `(a : b)` et `(c : d)` sont le même point de `ℙ¹` ; l'écriture fractionnaire est la carte affine, l'écriture en produits croisés la définition homogène | 4e |
| Composition de deux évolutions : appliquer `p` puis `q` revient à multiplier par `(1+p)(1+q)` | Une évolution est un point de `𝔾ₘ` ; les composer, c'est les multiplier dans ce groupe | 4e |
| Une évolution de `+p` puis `−p` ne ramène pas à la valeur initiale | L'inverse dans `𝔾ₘ` n'est pas l'opposé dans `𝔾ₐ` : `(1+p)(1−p) = 1 − p²`. Toute la question est de ne pas confondre les deux groupes | 4e |
| Une image est unique, un antécédent ne l'est pas nécessairement | Une application est une flèche : l'unicité de l'image est sa définition. La non-unicité des antécédents dit seulement qu'elle n'est pas un monomorphisme | 3e |
| Fonction linéaire `x ↦ ax` : traduit exactement la proportionnalité ; graphe = droite par l'origine | `End(𝔾ₐ) = ℝ` : les endomorphismes de la droite comme groupe sont exactement les homothéties. « Linéaire = proportionnel » est ce calcul d'endomorphismes | 3e |
| Fonction affine `x ↦ ax + b` : graphe = droite ; `a` coefficient directeur, `b` ordonnée à l'origine | Une application affine est un morphisme de torseurs ; « prendre la partie linéaire » est le morphisme `Aff → 𝔾ₘ`, dont `b` est le défaut de trivialisation | 3e |
| `a = (f(x₂) − f(x₁)) / (x₂ − x₁)` pour une fonction affine | La partie linéaire se lit sur n'importe quelle paire de points : la différence de deux points est un vecteur, et le morphisme y agit linéairement | 3e |
| Sens de variation d'une fonction affine selon le signe de `a` | Vu comme foncteur entre ensembles ordonnés, `x ↦ ax + b` est covariant si `a > 0`, contravariant si `a < 0` | 3e |

---

## 6. Statistiques et probabilités

Les lois de probabilité sur un ensemble fini forment un simplexe : l'objet universel des
combinaisons convexes. Une moyenne est un point de cet objet, une expérience à deux
épreuves une composition — et la composition en question a un nom, c'est celle de la
catégorie de Kleisli de la monade des lois.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Moyenne : linéarité (`moyenne(x + c) = moyenne(x) + c`), moyenne pondérée | La moyenne est l'unique application affine qui prolonge l'identité sur les points : c'est la propriété universelle du simplexe comme convexe libre | 4e |
| La moyenne est comprise entre le minimum et le maximum de la série | Un barycentre à coefficients positifs appartient à l'enveloppe convexe des points | 4e |
| La moyenne de plusieurs moyennes n'est pas la moyenne de la série globale | La moyenne est affine, non linéaire : elle ne commute au recollement que si l'on se souvient des poids, c'est-à-dire si l'on travaille dans la catégorie des mesures et non dans celle des nombres | 4e |
| Médiane : au moins la moitié des valeurs lui sont inférieures ou égales | La médiane est un seuil de la fonction de répartition, morphisme croissant vers `[0,1]` : elle est définie par une inégalité, non par une formule, d'où sa non-unicité | 4e |
| Probabilité : `0 ≤ P(A) ≤ 1`, somme des probabilités des issues = 1 | Une loi est un point du simplexe : positivité et normalisation en sont les deux équations | 3e |
| Événement contraire : `P(Ā) = 1 − P(A)` | Additivité sur la partition `Ω = A ⊔ Ā` : la mesure envoie une somme disjointe sur une somme | 3e |
| Équiprobabilité : `P(A) = card(A) / card(Ω)` | La loi uniforme est l'unique mesure invariante sous le groupe des automorphismes de `Ω` : la mesure de Haar d'un ensemble fini | 3e |
| Expérience à deux épreuves : arbre pondéré, produit des probabilités le long d'une branche | Une expérience à deux épreuves est la composée d'une loi et d'un noyau dans la catégorie de Kleisli de la monade des lois ; le produit le long d'une branche est la formule de cette composition | 3e |
| Fréquence observée et probabilité : fluctuation d'échantillonnage, stabilisation quand `n` grandit | La fréquence empirique est un point aléatoire du simplexe qui converge vers la loi : énoncé de limite, admis au collège | 3e |

---

## 7. Algorithmique et programmation

Un programme est une flèche, l'exécution une composition, une boucle l'image d'un entier
par un morphisme de monoïdes. `ℕ` y intervient deux fois : comme monoïde libre à un
générateur — c'est la récursion — et comme ensemble bien ordonné — c'est la terminaison.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Une suite d'affectations compose ses instructions dans l'ordre d'écriture | Un programme est un morphisme dans la catégorie des états ; l'exécution est la composition, et l'ordre d'écriture est celui des flèches | 5e |
| Boucle bornée : répéter `n` fois l'ajout de `a` ajoute `n × a` ; répéter `n` fois le doublement multiplie par `2ⁿ` | Répéter `n` fois, c'est évaluer en `n` l'unique morphisme de monoïdes `ℕ → End(E)` qui envoie `1` sur le corps de boucle — propriété universelle du monoïde libre à un générateur | 5e |
| Terminaison d'une boucle non bornée : « retrancher `b` tant que c'est possible » s'arrête et laisse `x mod b` | La terminaison est la nœthérianité de `ℕ` : pas de chaîne strictement décroissante infinie. Le résultat est le représentant canonique de la classe modulo `b` | 4e |
| Correction d'un programme de calcul : ce qu'il calcule vaut telle expression de l'entrée | La correction est une égalité de deux flèches, non une observation sur des exemples | 4e / 3e |
| Deux programmes de longueurs différentes calculent la même chose | Deux flèches égales, non deux flèches isomorphes : la longueur du texte est une propriété de la présentation, pas de la fonction | 4e / 3e |

---

## Ce que la traduction apprend, et ce qu'elle coûte

**Là où elle éclaire.** Une dizaine de lignes changent de nature une fois traduites.
La division euclidienne cesse d'être un algorithme pour devenir un système de
représentants. Pythagore et sa réciproque deviennent une seule identité, celle de
polarisation, dont la réciproque est gratuite. Thalès devient la linéarité d'une
projection, et l'on comprend enfin *pourquoi* ce sont les rapports qui se conservent :
ce sont les seuls invariants du groupe affine. L'agrandissement de rapport `k` explique
la dimension : `k`, `k²`, `k³` sont trois poids d'une même action. Et l'arbre pondéré des
probabilités devient une composition, ce qui est exactement ce qu'un élève de troisième
peine à voir dans le produit le long d'une branche.

**Là où elle habille.** Les critères de divisibilité, la règle des signes, les identités
sur les puissances ne gagnent rien : ce sont des calculs, et les dire fonctoriels ne les
rend ni plus vrais ni plus faciles. La médiane, les fréquences, la lecture de tableaux
résistent : ce qu'elles évaluent n'est pas une structure mais un geste.

**Ce que Grothendieck aurait objecté.** Le vocabulaire n'était pas le but ; le but était
de trouver la généralité où l'énoncé devient une tautologie, et cette généralité se
paie en construction. Aucun collégien n'a besoin de `Spec ℤ` pour savoir que `4` divise
`100`. Mais la moitié de ces énoncés sont des théorèmes de structure qui s'ignorent, et
les nommer comme tels est le seul moyen de voir que la divisibilité au collège,
l'arithmétique de spécialité et la géométrie algébrique disent la même chose trois fois,
à quinze ans d'écart.
