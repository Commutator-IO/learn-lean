# Le programme du lycée, dit dans la langue de Grothendieck

Les mêmes énoncés que dans [lycee.md](lycee.md), reformulés dans le vocabulaire
qu'Alexandre Grothendieck a construit pour la géométrie algébrique. Suite du
[programme du collège dans la même langue](college-grothendieck.md), dont le
[petit lexique](college-grothendieck.md#petit-lexique) vaut aussi ici.

**Ce fichier ne démontre rien et ne remplace rien.** La liste de référence, avec ses
statuts, sa colonne *Admis* et ses liens vers les chapitres, reste
[lycee.md](lycee.md). Ici, deux colonnes seulement : l'énoncé du programme, et ce qu'il
devient quand on le dit autrement.

**Le lycée s'y prête mieux que le collège.** Au collège, la traduction était souvent un
habillage ; ici, elle tombe juste presque partout, pour une raison simple : les objets du
lycée *sont* ceux dont Grothendieck a fait la théorie. La dérivée est le calcul dans
l'anneau des nombres duaux ; l'exponentielle est l'isomorphisme entre le groupe formel
additif et le groupe formel multiplicatif ; le discriminant est l'obstruction à
trivialiser un torseur sous `μ₂` ; le théorème fondamental de l'analyse est la formule de
Stokes en dimension un ; le petit théorème de Fermat est l'énoncé que les points
rationnels sont les points fixes du Frobenius — d'où part tout le programme des conjectures
de Weil. Ce qu'un élève de terminale manipule est, à peu de choses près, le catalogue des
exemples de base de la géométrie algébrique moderne.

Vocabulaire supplémentaire par rapport au collège : nombres duaux et épaississement
infinitésimal, différentielles de Kähler, cohomologie de de Rham, six opérations et image
directe, descente galoisienne, Frobenius, algèbre initiale d'un foncteur.

---

## 1. Nombres, calcul algébrique

La chaîne `ℕ ⊂ ℤ ⊂ 𝔻 ⊂ ℚ ⊂ ℝ` est une chaîne de constructions universelles :
complétion pour les groupes, localisations successives, puis complétion topologique. Les
quatre premières sont algébriques et gratuites ; la dernière ne l'est pas, et c'est elle
que le lycée admet partout sans jamais l'énoncer.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Inclusions `ℕ ⊂ ℤ ⊂ 𝔻 ⊂ ℚ ⊂ ℝ`, strictes | Groupe de Grothendieck du monoïde `ℕ`, puis localisations `ℤ[1/10]` et `Frac ℤ`, puis complétion pour la place archimédienne : quatre propriétés universelles et un passage à la limite | 2de |
| `√2` est irrationnel | Le `ℚ`-schéma `X² = 2` n'a pas de point rationnel : c'est un revêtement connexe de degré `2` de `Spec ℚ` | 2de |
| Un rationnel a un développement décimal périodique, et réciproquement | Le développement est l'orbite d'un point sous l'itération d'un endomorphisme d'un ensemble fini, donc prépériodique ; la période est l'ordre de `10` dans `(ℤ/qℤ)*` une fois retirés les facteurs `2` et `5` | 2de |
| Valeur absolue : `\|x − a\| ≤ r ⟺ x ∈ [a − r, a + r]` | La valeur absolue est la place archimédienne de `ℚ` ; les boules qu'elle définit sont une base de voisinages, et l'équivalence est la description de cette base | 2de |
| Inégalité triangulaire : `\|x + y\| ≤ \|x\| + \|y\|` | C'est l'axiome qui fait de `\|·\|` une norme, donc de `ℝ` un espace métrique — la condition sans laquelle il n'y a pas de topologie à compléter | 2de |
| Identités remarquables `(a ± b)²`, `a² − b²` | Polarisation de la forme quadratique `x ↦ x²` d'un côté, factorisation de la norme de `ℤ[X]/(X² − b²)` de l'autre : deux cas de la même bilinéarité | 2de |
| Un produit est nul ⟺ l'un des facteurs est nul ; règle des signes d'un quotient | `ℝ` est intègre : `(0)` est premier, et `V(fg) = V(f) ∪ V(g)` | 2de |
| Signe de `ax + b` selon le signe de `a` | La droite affine privée du zéro de `ax + b` a deux composantes connexes ; le signe est la fonction localement constante qui les sépare | 2de |
| Puissances et racines : `√(ab) = √a √b`, `(aⁿ)ᵐ = aⁿᵐ` | Fonctorialité des morphismes de monoïdes `x ↦ xⁿ` et de leurs inverses sur `ℝ₊` | 2de |
| Comparaison de `x`, `x²`, `√x` selon que `x ∈ [0,1]` ou `x ≥ 1` | Sur le groupe `ℝ*₊`, l'exposant agit par un morphisme d'ordre : `x ↦ xᵗ` croît en `t` si `x > 1`, décroît si `x < 1`. Le point `1` est le point fixe de toute cette action | 2de |
| Somme des termes d'une suite arithmétique : `1 + 2 + ⋯ + n = n(n+1)/2` | Le cardinal est le morphisme `K₀(ensembles finis) ≅ ℤ` ; compter deux fois le même ensemble de paires donne l'identité | 1S |
| Somme géométrique : `1 + q + ⋯ + qⁿ = (1 − qⁿ⁺¹)/(1 − q)` pour `q ≠ 1` | C'est le complexe de Koszul en une variable : `0 → A → A → A/(1−q) → 0`, dont la somme partielle est la section explicite | 1S |
| Coefficients binomiaux ; relation de Pascal `C(n,k) + C(n,k+1) = C(n+1,k+1)` | `C(n,k)` est le rang de `∧ᵏ` d'un module libre de rang `n` ; Pascal est la décomposition `∧ᵏ(M ⊕ A) ≅ ∧ᵏM ⊕ ∧^{k−1}M` obtenue en ajoutant un générateur | 1S |
| Formule du binôme de Newton | Développement du produit tensoriel de `n` copies de `a ⊕ b` selon les sous-ensembles d'indices : les coefficients comptent les fibres | 1S / TS |
| Raisonnement par récurrence : principe et mise en œuvre | `ℕ` est l'objet initial de la catégorie des ensembles pointés munis d'un endomorphisme : définir par récurrence, c'est utiliser l'existence de la flèche ; démontrer par récurrence, c'est utiliser son unicité | TS |
| Inégalité de Bernoulli : `(1 + a)ⁿ ≥ 1 + na` pour `a ≥ −1` | Convexité de `x ↦ (1+x)ⁿ` : la courbe est au-dessus de sa tangente en `0` | TS |

---

## 2. Fonctions, second degré

Le second degré est le premier endroit du cursus où apparaît une **obstruction** : le
discriminant ne mesure pas une difficulté de calcul, il mesure si un torseur est trivial.
Deux racines forment un torseur sous le groupe `μ₂` qui les échange ; `Δ` est un carré
exactement quand ce torseur a un point rationnel.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Ensemble de définition, image, antécédent ; sens de variation | Source, image, fibre : le vocabulaire scolaire est celui des flèches, avec d'autres mots | 2de |
| Fonctions de référence : affine, carré, inverse, racine, cube — variations et courbes | Cinq morphismes de base : deux automorphismes de la droite affine, l'automorphisme `z ↦ 1/z` de `ℙ¹`, et les revêtements `x ↦ x²`, `x ↦ x³` | 2de |
| Une fonction croissante conserve l'ordre ; composition avec une fonction décroissante l'inverse | Vus comme foncteurs entre ensembles ordonnés : croissante = covariant, décroissante = contravariant, et la composition suit la règle des signes des variances | 2de |
| Forme canonique d'un trinôme `ax² + bx + c` | Diagonalisation de la forme quadratique par complétion du carré — possible parce que `2` est inversible | 1S |
| Discriminant : nombre de racines réelles selon le signe de `Δ` | `Δ` est la classe dans `ℝ*/(ℝ*)²` du torseur sous `μ₂` formé par les deux racines : il est trivial (deux racines) ou non (aucune racine réelle, les racines étant échangées par Galois) | 1S |
| Factorisation `a(x − x₁)(x − x₂)` et signe du trinôme (« du signe de `a` sauf entre les racines ») | Le diviseur du polynôme est la somme de ses deux points fermés ; le signe est la fonction localement constante sur le complémentaire, qui change en traversant un zéro simple | 1S |
| Somme et produit des racines : `x₁ + x₂ = −b/a`, `x₁x₂ = c/a` | Les fonctions symétriques élémentaires engendrent les invariants de `S₂` : les coefficients sont les coordonnées du quotient `𝔸²/S₂` | 1S |
| Sommet de la parabole, axe de symétrie | Le point fixe de l'involution `x ↦ −b/a − x`, unique automorphisme non trivial de la figure | 1S |
| Fonction homographique : ensemble de définition, variations, asymptotes | Un élément de `PGL₂` agissant sur `ℙ¹` : c'est un automorphisme partout défini de la droite projective, et les asymptotes sont les images du point à l'infini | 1S |
| Parité : symétrie de la courbe par rapport à l'axe des ordonnées ou à l'origine | Décomposition en espaces propres de l'action de `ℤ/2` sur les fonctions : `f = f₊ + f₋`, valeurs propres `+1` et `−1` | 2de / 1S |

---

## 3. Suites

Une suite convergente est une suite qui se prolonge au compactifié. Tout le chapitre est
la théorie de ce prolongement : l'unicité de la limite est la séparation, la convergence
monotone est l'existence de colimites bornées dans `ℝ`, et le passage à la limite dans
`uₙ₊₁ = f(uₙ)` est la commutation d'un foncteur continu aux limites.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Suites arithmétiques : `uₙ = u₀ + nr` ; suites géométriques : `uₙ = u₀qⁿ` | Orbites d'un point sous l'action de `ℕ` par translation dans `𝔾ₐ` ou par homothétie dans `𝔾ₘ` : deux fois le même énoncé, dans deux groupes | 1S |
| Sens de variation d'une suite arithmétique (signe de `r`), géométrique (signe de `q − 1`, `u₀`) | Le sens de l'orbite est donné par la position du générateur par rapport au neutre du groupe | 1S |
| Limite d'une suite : définition avec `ε` (ou avec `A` pour `+∞`) | Une suite converge si et seulement si elle se prolonge continûment au compactifié `ℕ ∪ {∞}` ; sa limite est la valeur du prolongement au point ajouté | TS |
| Unicité de la limite | Séparation de `ℝ` : deux prolongements continus qui coïncident sur une partie dense sont égaux | TS |
| Opérations sur les limites (somme, produit, quotient), formes indéterminées | Somme et produit sont continus, donc commutent au prolongement ; les formes indéterminées sont les points où l'opération n'admet pas de prolongement continu, `(0, ∞)` par exemple | TS |
| Limite de `qⁿ` selon `\|q\| < 1`, `q = 1`, `q > 1` | Dynamique de l'action de `ℕ` sur `𝔾ₘ` : `1` est le point fixe, attractif d'un côté, répulsif de l'autre | TS |
| Théorèmes de comparaison ; théorème des gendarmes | Deux morphismes qui se rejoignent à la limite coincent tout ce qui passe entre eux : c'est l'exactitude de l'ordre au passage à la colimite | TS |
| Toute suite croissante majorée converge (convergence monotone) | Le treillis `ℝ` est complet pour les parties majorées : la limite est la colimite du diagramme filtrant, et elle est atteinte parce que `ℝ` est complet | TS |
| Une suite croissante non majorée tend vers `+∞` | Même colimite, calculée dans le compactifié `ℝ̄`, où le supremum existe toujours | TS |
| Toute suite convergente est bornée | L'image d'un compact par une application continue est compacte : le prolongement au compactifié a une image bornée | TS |
| Suites adjacentes ; dichotomie | Un système projectif de segments emboîtés dont les longueurs tendent vers `0` : la limite projective est un point, et c'est la complétude qui l'affirme non vide | TS |
| Suites `uₙ₊₁ = f(uₙ)` : si `f` continue et `uₙ → ℓ` alors `f(ℓ) = ℓ` | Une application continue commute au passage à la limite : `f(lim uₙ) = lim f(uₙ)`. Le point limite est donc fixe | TS |

---

## 4. Limites, continuité, dérivation

Deux idées portent le chapitre, et aucune n'est de l'analyse. La première est la
connexité : le théorème des valeurs intermédiaires dit que l'image d'un connexe est
connexe, et le lien entre signe de `f'` et variations est le passage du local au global.
La seconde est l'infinitésimal : dériver, c'est évaluer sur l'anneau des nombres duaux
`ℝ[ε]/(ε²)`, et la tangente est l'espace tangent au sens exact que Grothendieck lui a
donné.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Limite d'une fonction en un point, en `±∞` ; asymptotes horizontale, verticale, oblique | Étude du prolongement au bord d'une compactification ; une asymptote est le comportement du morphisme au voisinage d'un point ajouté | TS |
| Opérations sur les limites ; limite d'une composée | Continuité des opérations et fonctorialité de la composition | TS |
| Croissances comparées : `eˣ/xⁿ → +∞`, `ln x / x → 0`, `x ln x → 0` | Comparaison d'ordres de croissance, c'est-à-dire de germes à l'infini : un énoncé dans la fibre du faisceau des fonctions au point ajouté, non en un point de `ℝ` | TS |
| Continuité en un point, sur un intervalle ; toute fonction dérivable est continue | Être dérivable, c'est admettre un développement à l'ordre `1` ; l'ordre `0` s'en déduit par troncature | TS |
| Théorème des valeurs intermédiaires | L'image d'un connexe par une application continue est connexe. C'est un énoncé de topologie, et la complétude de `ℝ` y entre par la connexité de l'intervalle | TS |
| Corollaire : `f` continue strictement monotone sur `[a,b]` ⟹ `f(x) = k` a une solution unique | Une bijection continue d'un compact vers un séparé est un homéomorphisme : la fibre au-dessus de `k` a exactement un point | TS |
| Nombre dérivé comme limite du taux d'accroissement ; équation de la tangente | `f(x + ε) = f(x) + f'(x)ε` avec `ε² = 0` : la dérivée est la valeur du morphisme sur les points à valeurs dans `ℝ[ε]`, et la tangente est l'espace tangent, c'est-à-dire le premier épaississement infinitésimal | 1S |
| Dérivées usuelles : `xⁿ`, `1/x`, `√x`, `sin`, `cos`, `exp`, `ln` | Calcul de la différentielle des morphismes de base ; pour `𝔾ₘ`, c'est la forme invariante `dx/x` | 1S / TS |
| Opérations : `(u + v)'`, `(uv)'`, `(1/v)'`, `(u/v)'` | `d` est une dérivation : `d(uv) = u dv + v du` est la relation de Leibniz qui définit le module des différentielles `Ω¹` | 1S |
| Dérivée d'une composée `(v ∘ u)' = u' × (v' ∘ u)` ; cas `u(ax + b)` | Fonctorialité de `Ω¹` : la différentielle d'une composée est le changement de base le long du premier morphisme | 1S / TS |
| Signe de `f'` et sens de variation de `f` | Passage du local au global : le signe de la différentielle est ponctuel, la monotonie est globale, et la connexité de l'intervalle fait le pont. C'est le prototype d'un principe de recollement | 1S |
| Un extremum local en un point intérieur où `f` est dérivable annule `f'` ; la réciproque est fausse | La différentielle s'annule en un point critique ; qu'un point critique ne soit pas un extremum est le début de la théorie de Morse, et `x³` en est le premier exemple | 1S |
| Dérivée seconde, convexité, point d'inflexion | Ordre `2` : on travaille sur `ℝ[ε]/(ε³)`, le deuxième voisinage infinitésimal. La convexité est la positivité de la forme quadratique de ce développement | TS |

---

## 5. Exponentielle, logarithme, trigonométrie

Le chapitre entier tient dans un isomorphisme de groupes `exp : 𝔾ₐ → 𝔾ₘ` et dans un
revêtement `ℝ → 𝕊¹`. Les « propriétés algébriques » sont la multiplicativité du premier ;
les formules de trigonométrie sont celle du second ; les périodes sont son noyau, et ce
noyau est le groupe fondamental du cercle.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Existence et unicité de `f` dérivable telle que `f' = f` et `f(0) = 1` | L'exponentielle est l'unique morphisme du groupe additif vers le groupe multiplicatif dont la différentielle en `0` est l'identité : en caractéristique nulle, c'est l'isomorphisme entre groupe formel additif et groupe formel multiplicatif | TS |
| `exp(a + b) = exp(a)exp(b)`, `exp(−a) = 1/exp(a)`, `exp(na) = exp(a)ⁿ` | Ce sont les trois façons de dire qu'il s'agit d'un morphisme de groupes | TS |
| `exp(x) > 0` pour tout `x` ; `exp` strictement croissante | L'image est contenue dans la composante neutre de `𝔾ₘ(ℝ)`, qui est `ℝ*₊` ; l'injectivité est la nullité du noyau sur `ℝ` | TS |
| Limites : `eˣ → +∞` en `+∞`, `eˣ → 0` en `−∞` | Le morphisme est un isomorphisme sur `ℝ*₊` : il transporte les deux bouts de `ℝ` sur les deux bouts de `ℝ*₊` | TS |
| `ln` réciproque de `exp` : `ln(exp x) = x`, `exp(ln x) = x` pour `x > 0` | Isomorphisme réciproque de l'isomorphisme précédent | TS |
| `ln(ab) = ln a + ln b`, `ln(a/b)`, `ln(aⁿ) = n ln a`, `ln √a = ½ ln a` | Un isomorphisme réciproque est un morphisme : les produits deviennent des sommes parce que l'on va de `𝔾ₘ` vers `𝔾ₐ` | TS |
| `ln` dérivable de dérivée `1/x` ; `ln` strictement croissante | `dlog = dx/x` est la forme différentielle invariante de `𝔾ₘ` ; le logarithme est son intégrale, ce qui explique du même coup sa dérivée et sa transformation des produits en sommes | TS |
| Limites de `ln` en `0⁺` et en `+∞` | Le logarithme envoie les deux bouts de `ℝ*₊` sur les deux bouts de `ℝ` | TS |
| Cercle trigonométrique, radians ; `cos² + sin² = 1` | Le cercle est le noyau de la norme sur `ℂ*` ; le radian est la normalisation du champ de vecteurs invariant, c'est-à-dire le choix d'une base de son algèbre de Lie | 1S |
| Valeurs remarquables et angles associés (`−x`, `π − x`, `π/2 − x`…) | Action des sous-groupes finis du groupe des isométries du cercle : les tables d'angles associés sont les orbites | 1S |
| Formules d'addition et de duplication de `cos` et `sin` | `t ↦ (cos t, sin t)` est un morphisme de groupes `ℝ → 𝕊¹` : les formules d'addition sont sa multiplicativité, la duplication son composé avec le doublement | 1S |
| Résolution de `cos x = a`, `sin x = a` ; périodicité | Les solutions forment une fibre du revêtement universel `ℝ → 𝕊¹`, donc un torseur sous son groupe d'automorphismes `2πℤ = π₁(𝕊¹)` | 1S |
| `sin` et `cos` dérivables, `sin' = cos`, `cos' = −sin` ; `lim (sin x)/x = 1` en 0 | La dérivation est l'action du champ invariant : elle fait tourner de `π/2`. La limite en `0` dit que le radian normalise ce champ à `1` | TS |

---

## 6. Intégration

L'intégration est une **image directe** : le morphisme induit par la projection d'un
segment sur le point. Vue ainsi, chaque propriété du programme est une propriété
fonctorielle — linéarité, recollement, positivité — et le théorème fondamental est la
formule de Stokes en dimension un, le bord de `[a,b]` étant `{b} − {a}`.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Intégrale d'une fonction continue positive = aire sous la courbe | L'intégrale est l'image directe le long de `[a,b] → point` : une opération sur les faisceaux, dont l'aire est l'interprétation, non la définition | TS |
| Toute fonction continue sur un intervalle admet des primitives | Lemme de Poincaré : la cohomologie de de Rham d'un intervalle est nulle en degré `1`, donc toute forme est exacte | TS |
| `x ↦ ∫ₐˣ f(t)dt` est la primitive de `f` qui s'annule en `a` | La primitive canonique est la section de `d` normalisée par une condition au bord : c'est le choix d'un relèvement, et `a` en est la donnée | TS |
| Deux primitives d'une même fonction diffèrent d'une constante | Le noyau de `d` est le `H⁰` de de Rham, qui vaut `ℝ` sur un connexe : c'est encore la connexité | TS |
| Théorème fondamental : `∫ₐᵇ f = F(b) − F(a)` | Formule de Stokes en dimension `1` : `∫_{[a,b]} dF = ∫_{∂[a,b]} F`, et `∂[a,b] = {b} − {a}` | TS |
| Linéarité de l'intégrale | L'image directe est un morphisme de modules | TS |
| Relation de Chasles | Additivité par recollement : l'intégrale sur `[a,c]` se calcule morceau par morceau dès que les morceaux s'accordent en leur point commun — l'image directe commute au découpage de la base | TS |
| Positivité et croissance : `f ≥ 0 ⟹ ∫ f ≥ 0` ; `f ≤ g ⟹ ∫ f ≤ ∫ g` | L'image directe respecte l'ordre : c'est un morphisme de modules ordonnés, la croissance étant la positivité appliquée à `g − f` | TS |
| Inégalité de la moyenne ; valeur moyenne `(1/(b−a))∫ₐᵇ f` | La valeur moyenne est le barycentre de `f` pour la mesure normalisée : elle appartient à l'enveloppe convexe de l'image | TS |
| Intégration par parties | Leibniz plus Stokes : intégrer `d(uv) = u dv + v du` sur `[a,b]` donne la formule, et le terme de bord est l'évaluation sur `∂[a,b]` | TS |
| Aire entre deux courbes ; volume d'un solide de révolution (approche) | Image directe le long d'une projection à fibres non ponctuelles : c'est Fubini, l'intégration se faisant fibre par fibre | TS |

---

## 7. Nombres complexes

`ℂ = ℝ[X]/(X² + 1)` représente le foncteur qui, à une `ℝ`-algèbre, associe l'ensemble de
ses racines carrées de `−1` : c'est la définition la plus courte du chapitre, et elle
contient tout le reste. La conjugaison est le groupe de Galois, la partie réelle est la
descente, le module est la norme, et l'argument est le revêtement du cercle.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Forme algébrique `a + ib` ; unicité de l'écriture, `i² = −1` | `ℂ` est la `ℝ`-algèbre universelle munie d'une racine carrée de `−1` : `Hom_{ℝ-alg}(ℂ, A) = {a ∈ A : a² = −1}`. L'unicité de l'écriture est la liberté du module `ℝ ⊕ ℝi` | TS |
| Conjugué : `conj(z + z') = conj z + conj z'`, `conj(zz') = conj z conj z'`, `z conj z = \|z\|²` | La conjugaison est le générateur de `Gal(ℂ/ℝ) ≅ ℤ/2` : c'est un automorphisme d'anneau, et `z conj z` est la norme de l'extension | TS |
| `z` réel ⟺ `z = conj z` ; `z` imaginaire pur ⟺ `z = −conj z` | Descente galoisienne : `ℝ = ℂ^{Gal}`, les invariants sous le groupe. Les imaginaires purs sont l'autre espace propre, de valeur propre `−1` | TS |
| Module : `\|zz'\| = \|z\|\|z'\|`, `\|z + z'\| ≤ \|z\| + \|z'\|` | La norme est un morphisme de groupes `ℂ* → ℝ*₊`, d'où la multiplicativité ; l'inégalité est la convexité, qui n'a rien d'algébrique | TS |
| Argument, forme trigonométrique ; `arg(zz') = arg z + arg z'` | La décomposition polaire est l'isomorphisme `ℂ* ≅ ℝ*₊ × 𝕊¹` ; l'argument est la projection sur le second facteur, donc un morphisme de groupes | TS |
| Forme exponentielle `re^{iθ}` ; formules d'Euler et de Moivre | `exp : ℂ → ℂ*` est un morphisme de groupes surjectif de noyau `2iπℤ` ; Moivre est sa multiplicativité, Euler la décomposition en parties invariante et anti-invariante sous Galois | TS |
| Équation du second degré à coefficients réels avec `Δ < 0` : deux racines conjuguées | Les racines forment un torseur sous `Gal(ℂ/ℝ)` : le groupe les échange, et c'est pourquoi elles sont conjuguées. Sur `ℂ`, le torseur devient trivial — c'est la clôture algébrique | TS |
| Interprétation géométrique : affixe, `\|z_B − z_A\|` = distance, `arg((z_C − z_A)/(z_B − z_A))` = angle | L'affixe est une trivialisation du plan comme droite affine complexe ; la différence vit dans le groupe des translations, et le quotient de deux différences est l'invariant du groupe des similitudes | TS |
| Alignement et orthogonalité en termes d'affixes ; caractérisation d'un cercle | Le rapport de deux différences est réel ou imaginaire pur : dans les deux cas, on teste l'appartenance à un sous-espace propre de Galois. Le cercle est la fibre d'une norme | TS |
| Écriture complexe d'une translation, d'une rotation, d'une homothétie | Les similitudes directes sont exactement les automorphismes du plan comme droite affine complexe : le groupe `ℂ ⋊ ℂ*`, avec `z ↦ az + b` | TS |

---

## 8. Géométrie : vecteurs, produit scalaire, espace

La relation de Chasles est l'axiome du torseur ; le produit scalaire est un morphisme de
`V` vers son dual ; le déterminant est l'action sur la puissance extérieure maximale.
Paramétrer, c'est donner un morphisme depuis l'espace affine standard ; équationner, c'est
donner un noyau — image d'un côté, fibre de l'autre.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Vecteurs : relation de Chasles, colinéarité ; `AB` et `CD` colinéaires ⟺ `(AB) ∥ (CD)` | Chasles est l'axiome du torseur : `AB` est la différence de deux points, à valeurs dans le groupe des translations, et la colinéarité est l'égalité des images dans `ℙ¹` | 2de |
| Critère de colinéarité par le déterminant `xy' − x'y = 0` | Le produit extérieur `u ∧ v` s'annule : les deux vecteurs n'engendrent pas la puissance extérieure maximale, donc sont liés | 2de |
| Décomposition unique d'un vecteur dans une base du plan | Une base est une trivialisation, c'est-à-dire un isomorphisme avec le module libre standard ; l'unicité des coordonnées est celle de l'isomorphisme réciproque | 2de / 1S |
| Coordonnées du milieu, distance entre deux points | Formules lues dans une trivialisation ; leur indépendance vis-à-vis du repère choisi est un énoncé de descente | 2de |
| Équation de droite `y = mx + p` et `ax + by + c = 0` ; parallélisme et coefficients directeurs | Une droite est le noyau d'une forme affine ; deux droites sont parallèles quand les formes linéaires associées sont proportionnelles, c'est-à-dire égales dans le dual projectif | 2de |
| Système linéaire 2×2 : existence et unicité de la solution si le déterminant est non nul | Le morphisme est un isomorphisme si et seulement si son action sur `∧²` est inversible ; la solution est alors l'unique point de la fibre | 2de / 1S |
| Produit scalaire : définitions équivalentes (projeté, coordonnées, normes, `\|u\|\|v\|cos θ`) | Quatre descriptions d'une même forme bilinéaire symétrique, c'est-à-dire d'un même morphisme `V → V*` : par le projeté (adjonction), en coordonnées (base), par polarisation (norme), par l'angle (invariant du groupe orthogonal) | 1S |
| Bilinéarité et symétrie du produit scalaire | La forme se factorise par le produit tensoriel symétrique `Sym²V → ℝ` | 1S |
| `u ⊥ v ⟺ u · v = 0` | L'orthogonalité est la connexion de Galois induite par le morphisme `V → V*` ; le produit scalaire est son test | 1S |
| Théorème d'Al-Kashi | Polarisation dans le cas général : `q(u − v) = q(u) + q(v) − 2⟨u,v⟩`. Pythagore en est le cas où le terme croisé disparaît | 1S |
| Théorème de la médiane ; formule des trois normes | Identité du parallélogramme : la forme quadratique est déterminée par ses valeurs sur les sommes et différences, ce qui est encore la polarisation | 1S |
| Équation cartésienne d'un cercle ; caractérisation `MA · MB = 0` | Le cercle est la fibre d'une forme quadratique ; celui de diamètre `[AB]` est le lieu d'annulation d'une forme bilinéaire, donc une quadrique de rang `2` | 1S |
| Loi des sinus ; aire `½ ab sin C` | Le sinus est la partie alternée du produit `u ⊗ v`, le cosinus la partie symétrique : l'aire est la forme volume `∧²`, et la loi des sinus est l'invariance de cette forme sur les trois choix de couples | 1S |
| Géométrie dans l'espace : positions relatives de droites et plans | Intersections de sous-espaces affines : la formule de Grassmann est l'exactitude de `0 → U ∩ V → U ⊕ V → U + V → 0`, et les cas « parallèles, sécants, non coplanaires » sont les valeurs possibles des dimensions | TS |
| Théorème du toit ; parallélisme de deux plans par deux sécantes | Deux plans dont les directions se recollent le long d'une droite commune : la direction de l'intersection est déterminée par les données locales, ce qui est un recollement | TS |
| Vecteurs de l'espace, coplanarité, repère et base | Rang d'une famille dans un module libre de rang `3` ; coplanaire = de rang `≤ 2` | TS |
| Représentation paramétrique d'une droite, d'un plan | Un morphisme depuis `𝔸¹` ou `𝔸²` : la description par l'image | TS |
| Produit scalaire dans l'espace ; vecteur normal et équation cartésienne `ax + by + cz + d = 0` | La description duale : un plan est le noyau d'une forme affine, et le vecteur normal est cette forme lue par le produit scalaire. Paramétrer et équationner sont les deux faces d'une même dualité | TS |
| Distance d'un point à un plan ; intersection droite-plan, plan-plan | La projection orthogonale est adjointe à l'inclusion ; la distance est la norme de l'unité d'adjonction, et les intersections sont des limites (produits fibrés) de sous-espaces | TS |

---

## 9. Probabilités et statistiques

Deux structures se partagent le chapitre. La première est hilbertienne : l'espérance est
une projection orthogonale sur les constantes, et la variance le carré de la distance à
cette projection — König–Huygens est Pythagore. La seconde est fonctorielle :
conditionner est un changement de base, l'indépendance est un produit tensoriel, et une
loi binomiale est une image directe.

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Moyenne, médiane, quartiles, écart interquartile, écart-type | Invariants d'une mesure empirique : les uns sont linéaires (moyenne), les autres ordinaux (médiane, quartiles) — deux familles de foncteurs distinctes, qui ne se déduisent pas l'une de l'autre | 2de / 1S |
| Linéarité de la moyenne ; `écart-type(aX + b) = \|a\| × écart-type(X)` | La moyenne est affine, l'écart-type est de poids `1` pour l'action de `𝔾ₘ` et invariant par translation : c'est la même graduation que pour les longueurs | 1S |
| `P(A ∪ B) = P(A) + P(B) − P(A ∩ B)` ; `P(Ā) = 1 − P(A)` | Inclusion-exclusion : la mesure est additive sur le groupe de Grothendieck des parties, où `[A ∪ B] + [A ∩ B] = [A] + [B]` | 2de |
| Variable aléatoire : loi, espérance, variance, écart-type | Une variable aléatoire est un morphisme ; sa loi est l'image directe de la mesure par ce morphisme | 1S |
| `E(aX + b) = aE(X) + b` ; `V(aX + b) = a²V(X)` ; `V(X) = E(X²) − E(X)²` | L'espérance est la projection orthogonale sur les constantes dans `L²` ; `V(X) = ‖X − E(X)‖²`, et König–Huygens est le théorème de Pythagore pour cette projection | 1S |
| Épreuve et schéma de Bernoulli ; loi binomiale `P(X = k) = C(n,k)pᵏ(1−p)ⁿ⁻ᵏ` | La loi binomiale est l'image directe de la mesure produit par la somme : le coefficient binomial compte les points de la fibre | 1S |
| Espérance et variance d'une binomiale : `np` et `np(1−p)` | L'espérance est additive sans hypothèse ; la variance l'est parce que la mesure est un produit, c'est-à-dire parce que les facteurs sont orthogonaux dans `L²` | 1S |
| Probabilité conditionnelle `P_A(B) = P(A ∩ B)/P(A)` ; formule des probabilités composées | Conditionner est un changement de base : on restreint la mesure au-dessus de `A` et l'on renormalise. Les probabilités composées sont la fonctorialité de cette restriction | TS |
| Formule des probabilités totales ; arbre pondéré | Recollement le long d'un recouvrement fini disjoint : la mesure globale est la somme de ses restrictions, et l'arbre est le diagramme de ce recollement | TS |
| Indépendance de deux événements ; indépendance et événements contraires | La loi jointe est le produit tensoriel des marginales ; l'indépendance est un énoncé de produit, et elle passe donc aux complémentaires par fonctorialité | TS |
| Loi uniforme sur `[a,b]` : densité, espérance `(a+b)/2` | L'unique mesure invariante par le groupe des translations préservant `[a,b]`, normalisée : la mesure de Haar, encore | TS |
| Loi exponentielle : densité `λe^{−λt}`, `P(X > t) = e^{−λt}`, absence de mémoire, espérance `1/λ` | L'absence de mémoire est l'invariance de la famille des conditionnements sous le semi-groupe des translations : c'est la caractérisation de `exp` comme morphisme, transportée aux mesures | TS |
| Loi normale centrée réduite ; théorème de Moivre–Laplace | La gaussienne est le point fixe attractif de la convolution renormalisée : un théorème de dynamique sur l'espace des lois, et la seule loi stable de variance finie | TS |
| Loi normale `N(μ, σ²)` ; intervalles `1σ`, `2σ`, `3σ` (68 %, 95 %, 99,7 %) | La famille est une orbite sous le groupe affine `𝔾ₐ ⋊ 𝔾ₘ` agissant sur les lois ; les intervalles sont les invariants de cette orbite, donc les mêmes pour tous les paramètres | TS |
| Intervalle de fluctuation asymptotique au seuil 95 % : `[p ± 1,96√(p(1−p)/n)]` | Pour un paramètre donné, la région où l'observation tombe avec probabilité `0,95` : une fibre du morphisme paramètre → loi | TS |
| Intervalle de confiance `[f ± 1/√n]` ; prise de décision | La lecture adjointe de la précédente : on inverse la relation entre paramètre et observation. Les deux intervalles sont les deux sens d'une même correspondance | TS |

---

## 10. Arithmétique, matrices et graphes

L'arithmétique de spécialité est la reprise, avec les bons mots, du chapitre 1 du collège :
congruences, Bézout, Gauss. Un énoncé la dépasse pourtant de très loin — le petit théorème
de Fermat, qui dit que les points rationnels sont les points fixes du Frobenius. C'est de
cette phrase qu'est parti le programme des conjectures de Weil.

### Arithmétique

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Divisibilité dans `ℤ` ; division euclidienne, existence et unicité | Ordre du treillis des idéaux, et système de représentants du quotient `ℤ/bℤ` | Spé |
| Congruences modulo `n` : compatibilité avec somme et produit | Travailler modulo `n`, c'est travailler dans l'anneau quotient ; la compatibilité est le fait que la projection est un morphisme d'anneaux | Spé |
| Critères de divisibilité revisités par les congruences | Les critères du collège, énoncés comme des égalités entre deux morphismes `ℤ[X] → ℤ/n` : c'est la même démonstration, enfin dite | Spé |
| PGCD, algorithme d'Euclide ; `pgcd(a,b) = pgcd(b, a mod b)` | Calcul de la somme d'idéaux `(a) + (b)` ; l'arrêt vient de la nœthérianité | Spé |
| Théorème de Bézout : `pgcd(a,b) = 1 ⟺ ∃(u,v), au + bv = 1` | `(a) + (b) = ℤ` ; de façon équivalente, les fermés `V(a)` et `V(b)` sont disjoints dans `Spec ℤ`, et le théorème chinois décompose `ℤ/ab ≅ ℤ/a × ℤ/b` | Spé |
| Théorème de Gauss : `a ∣ bc` et `pgcd(a,b) = 1` ⟹ `a ∣ c` | Localisation : `b` est inversible modulo `a`, on le simplifie. C'est l'énoncé que les composantes premières sont indépendantes | Spé |
| Équation diophantienne `ax + by = c` : condition d'existence, forme des solutions | L'ensemble des solutions est une fibre du morphisme `ℤ² → ℤ` : elle est vide, ou c'est un torseur sous le noyau. « Solution particulière plus solutions homogènes » est la définition d'un torseur | Spé |
| Infinité des nombres premiers | `Spec ℤ` a une infinité de points fermés : ce n'est pas un schéma fini, et c'est ce que la démonstration d'Euclide établit | Spé |
| Décomposition en facteurs premiers : existence et unicité | Le groupe des diviseurs est libre sur les points fermés : `ℤ` est factoriel parce que principal, et principal parce qu'euclidien | Spé |
| Petit théorème de Fermat : `p` premier, `p ∤ a` ⟹ `a^{p−1} ≡ 1 [p]` | Le Frobenius `x ↦ xᵖ` est un endomorphisme d'anneau de `𝔽̄ₚ`, et `𝔽ₚ` en est exactement le lieu des points fixes : les points rationnels sont les points fixes du Frobenius. Tout le comptage de points sur les corps finis part de là | Spé |
| Application au chiffrement (RSA, code affine) | Le chiffrement est un automorphisme du groupe `(ℤ/nℤ)*` ; l'inverser demande de connaître l'ordre du groupe, donc la décomposition de `n` — la sécurité est le coût du calcul des points fermés sous `n` | Spé |

### Matrices et graphes

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Opérations sur les matrices ; le produit n'est pas commutatif | Une matrice est un endomorphisme lu dans une base ; `End(V)` n'est pas commutatif dès que `dim V > 1`, la composition ne l'étant pas | Spé |
| Matrice inversible ; inverse d'une matrice `2×2` et condition `ad − bc ≠ 0` | Le déterminant est l'action sur `∧²V`, et le morphisme `det : GL → 𝔾ₘ` ; être inversible, c'est avoir une image inversible | Spé |
| Écriture matricielle d'un système linéaire ; résolution par l'inverse | Un système est une fibre ; quand le morphisme est un isomorphisme, la fibre est un point, et l'inverse le calcule | Spé |
| Puissances `Aⁿ` ; calcul par diagonalisation dans les cas simples | Dévissage : on décompose le module en sous-espaces propres, on calcule sur chacun, on recolle. C'est l'exemple le plus simple d'une décomposition spectrale | Spé |
| Suites `Uₙ₊₁ = AUₙ + B` ; forme explicite et état stable | Dynamique affine : l'état stable est le point fixe, et le trouver revient à trivialiser le torseur. La forme explicite est alors linéaire | Spé |
| Graphe probabiliste, matrice de transition ; convergence vers l'état stable (cas `2×2`) | L'état stable est le vecteur propre de valeur propre `1` ; la convergence dit que le reste du spectre est dans le disque ouvert — c'est Perron–Frobenius | Spé |

---

## 11. Informatique

Le chapitre a une clé unique, et elle est catégorique : **`ℕ`, les listes et les arbres
sont les algèbres initiales de trois foncteurs**. `ℕ` est l'algèbre initiale de
`X ↦ 1 + X`, les listes sur `A` celle de `X ↦ 1 + A × X`, les arbres binaires celle de
`X ↦ 1 + X × X`. Toute définition récursive est l'unique morphisme issu de l'objet
initial ; toute preuve par récurrence est l'unicité de ce morphisme. C'est un seul
théorème, énoncé douze fois dans le programme.

### Représentation des données

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Algèbre de Boole : lois de De Morgan, distributivité, `¬¬a = a` | Une algèbre de Boole est un anneau où `x² = x` ; par dualité de Stone, c'est l'algèbre des ouverts-fermés de son spectre, et De Morgan est le passage au complémentaire | 1NSI |
| Écriture binaire d'un entier naturel : existence et unicité | Une base de numération est une trivialisation : `ℕ ≅ ⨁ᵢ {0,1}·2ⁱ`, l'existence étant la surjectivité et l'unicité l'injectivité | 1NSI |
| Valeur d'une écriture binaire : `∑ bᵢ 2ⁱ` ; passage binaire ↔ décimal | Évaluation en `2` du polynôme des chiffres : le changement de base est le passage d'une évaluation à une autre | 1NSI |
| Nombre de bits d'un entier `n > 0` : `⌊log₂ n⌋ + 1` | La longueur de l'écriture est une valuation à l'infini, inverse discret du logarithme | 1NSI |
| Complément à deux sur `n` bits : les entiers de `−2ⁿ⁻¹` à `2ⁿ⁻¹ − 1`, et l'addition modulo `2ⁿ` | Les entiers machine sont les points de `ℤ/2ⁿℤ` ; le débordement n'est pas une erreur mais le passage au quotient, et le signe est le choix d'un système de représentants centré | 1NSI |
| Écriture hexadécimale ; un chiffre hexadécimal vaut quatre bits | `16 = 2⁴` : le changement de base est un regroupement de facteurs, c'est-à-dire un isomorphisme entre deux trivialisations | 1NSI |
| Nombres à virgule flottante : `1/10` n'a pas d'écriture binaire finie, d'où `0,1 + 0,2 ≠ 0,3` | Les flottants sont des fonctions régulières sur `D(2)` ; `1/10` a un pôle en `(5)`, qui est dans cet ouvert. C'est le `1/3` du collège, lu en base deux | 1NSI |
| Chaînes de caractères : la concaténation est associative, sa longueur est la somme des longueurs | Les chaînes forment le monoïde libre sur l'alphabet ; la longueur est l'unique morphisme vers `(ℕ, +)` envoyant chaque lettre sur `1` — propriété universelle du monoïde libre | 1NSI |

### Algorithmes sur les tableaux

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Recherche séquentielle : le résultat est un indice de la valeur cherchée, ou l'absence de la valeur | La spécification est une fibre : le résultat est un point de la fibre, ou un certificat qu'elle est vide | 1NSI |
| Coût de la recherche séquentielle : `n` comparaisons au pire, et ce pire est atteint | La borne est atteinte, donc c'est un maximum et non un majorant : l'énoncé porte sur la fonction de coût, pas sur une estimation | 1NSI |
| Maximum d'un tableau non vide : le résultat appartient au tableau et majore tous ses éléments | Le maximum est la colimite du diagramme fini des éléments dans l'ensemble ordonné ; qu'il appartienne au tableau dit que la colimite est atteinte | 1NSI |
| Recherche dichotomique dans un tableau trié : correction | L'invariant est un sous-objet stable : à chaque étape, la fibre cherchée est contenue dans l'intervalle courant, et la boucle est un endomorphisme de cette situation | 1NSI |
| Coût de la recherche dichotomique : `⌊log₂ n⌋ + 1` comparaisons au pire | Le nombre d'étapes est la hauteur d'un arbre de décision binaire couvrant `n` feuilles : un dénombrement de fibres | 1NSI |
| Tri par insertion : le résultat est trié et c'est une permutation de l'entrée | Le tri est une section de l'oubli de l'ordre : à un multiensemble il associe l'unique suite croissante qui le représente. Correction = cette section existe et est unique | 1NSI |
| Tri par sélection : même énoncé de correction | Deux algorithmes, une seule section : la même flèche calculée deux fois | 1NSI |
| Coût quadratique des tris par insertion et par sélection ; `n(n−1)/2` comparaisons au pire | Le nombre de paires : encore un cardinal, c'est-à-dire un calcul dans `K₀` des ensembles finis | 1NSI |
| Tri fusion : correction, et coût en `n log n` | Diviser pour régner : la récurrence de coût est celle de la hauteur d'un arbre de fusion, et la correction est la fonctorialité du recollement de deux suites triées | TNSI |
| Un tri par comparaisons demande au moins `log₂(n!)` comparaisons | Un arbre de décision à `k` feuilles a une hauteur au moins `log₂ k` ; comme il faut séparer les `n!` ordres, la borne est un comptage de fibres | TNSI |

### Récursivité et diviser pour régner

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Factorielle récursive : la fonction calcule bien `n!` et termine | Unique morphisme issu de l'algèbre initiale `X ↦ 1 + X` : l'existence donne la définition, l'unicité la correction, et la terminaison est la nœthérianité de `ℕ` | TNSI |
| Suite de Fibonacci : les versions récursive et itérative calculent la même valeur | Deux morphismes issus du même objet initial sont égaux : l'unicité fait la démonstration, sans comparer les exécutions | TNSI |
| Coût exponentiel de Fibonacci récursif naïf, linéaire de la version itérative | Le coût n'est pas un invariant de la fonction mais de la présentation : deux flèches égales, deux calculs différents | TNSI |
| Exponentiation rapide : `aⁿ` en `⌊log₂ n⌋ + 1` élévations au carré au plus | Le morphisme `n ↦ aⁿ` évalué le long de l'écriture binaire de `n` : le coût est la longueur de la trivialisation, non la valeur | TNSI |
| Tours de Hanoï : `2ⁿ − 1` déplacements, et aucune solution n'en demande moins | Le graphe des configurations est auto-similaire ; l'optimalité est une minoration sur les chemins de ce graphe, donc un énoncé de structure et non d'algorithme | TNSI |
| Diviser pour régner : le coût `T(n) = 2T(n/2) + n` vaut `n log₂ n` | Somme sur les niveaux d'un arbre de récursion : chaque niveau coûte `n`, il y a `log₂ n` niveaux — un dévissage du coût selon une filtration | TNSI |

### Structures de données

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Pile : dépiler après avoir empilé rend l'état initial (dernier entré, premier sorti) | `dépiler ∘ empiler = id` : la pile est une structure algébrique dont les axiomes sont des égalités de flèches, non une implémentation | TNSI |
| File : le premier entré est le premier sorti | Même spécification équationnelle, avec l'autre ordre : la file est le monoïde libre lu par l'autre bout | TNSI |
| File par deux piles : le comportement est celui d'une file | Deux implémentations sont équivalentes quand elles satisfont les mêmes équations : c'est un isomorphisme d'algèbres, non une ressemblance de code | TNSI |
| Liste chaînée : longueur d'une concaténation, parcours complet | Algèbre initiale de `X ↦ 1 + A × X` ; la longueur est le morphisme vers `ℕ`, et le parcours l'unique morphisme défini par récursion | TNSI |
| Arbre binaire de hauteur `h` : au plus `2ʰ − 1` nœuds, donc hauteur `≥ log₂(n+1)` | Comptage par niveaux : la filtration par la profondeur donne une somme géométrique, et la minoration de la hauteur en est la réciproque | TNSI |
| Arbre binaire strict : le nombre de feuilles vaut le nombre de nœuds internes plus un | Caractéristique d'Euler d'un arbre : `sommets − arêtes = 1`, relation invariante par recollement | TNSI |
| Arbre binaire de recherche : le parcours infixe donne les clés triées | L'arbre est une présentation de l'ordre ; le parcours infixe est l'isomorphisme entre cette présentation et la suite croissante | TNSI |
| Recherche dans un arbre binaire de recherche : coût majoré par la hauteur | Le chemin de la racine à la clé est une chaîne dans l'ordre de l'arbre ; son coût est sa longueur | TNSI |
| Graphe : un parcours en profondeur ne visite que des sommets accessibles | L'ensemble visité est stable par l'itération : c'est un sous-objet invariant, donc contenu dans la composante accessible | TNSI |
| Graphe : un parcours en profondeur atteint tous les sommets accessibles | Réciproquement, le sous-objet invariant est le plus petit contenant la source : c'est la composante connexe accessible, la clôture par la relation d'arête | TNSI |
| Un arbre enraciné à `n` nœuds a `n − 1` arêtes | Caractéristique d'Euler valant `1` : un arbre est un graphe connexe sans cycle, donc de premier nombre de Betti nul | TNSI |
| Algorithme de Dijkstra : correction pour des poids positifs | La distance est une valuation ; l'algorithme calcule le plus petit point fixe d'un opérateur croissant, et la positivité des poids en assure la monotonie | TNSI |

### Correction et terminaison des programmes

| Énoncé du programme | Dans la langue de Grothendieck | Niveau |
|---|---|---|
| Invariant de boucle : une propriété vraie avant et conservée par le corps est vraie à la sortie | Un invariant est un sous-objet stable par l'endomorphisme du corps de boucle : la boucle opère à l'intérieur, et la conclusion est la commutation d'un carré | 1NSI |
| Variant de boucle : un entier naturel strictement décroissant force l'arrêt | Nœthérianité : pas de chaîne strictement décroissante infinie dans `ℕ` — la condition de chaîne descendante, sous son nom d'algorithmique | 1NSI |
| Somme des `n` premiers entiers par accumulation : le programme calcule `n(n+1)/2` | Le programme et la formule sont deux morphismes issus de l'objet initial `ℕ` : ils sont égaux par unicité | 1NSI |
| Division euclidienne par soustractions successives : le programme rend quotient et reste | L'invariant `a = bq + r` est le sous-objet stable ; la terminaison donne `0 ≤ r < b`, c'est-à-dire le représentant canonique | 1NSI |
| Deux programmes de structures différentes calculent la même fonction | Égalité de deux flèches. La structure du texte appartient à la présentation, la fonction à l'objet | 1NSI |
| Indécidabilité du problème de l'arrêt | Théorème du point fixe de Lawvere : dans une catégorie cartésienne fermée, aucun objet ne paramètre toutes ses applications vers lui-même sans produire un point fixe. Cantor, Gödel, Tarski et Turing sont ce seul énoncé, lu dans quatre catégories | TNSI |

---

## 12. Ce que la traduction rend visible

**Les mêmes énoncés reviennent.** Une fois traduites, des lignes éloignées de six ans se
superposent. L'équation `ax + b = 0` de quatrième, le système linéaire de seconde,
l'équation diophantienne de spécialité et l'équation différentielle de terminale sont un
seul énoncé : *la fibre d'un morphisme est vide ou c'est un torseur sous son noyau* —
solution particulière plus solutions homogènes. Le collège, le lycée et la spécialité le
disent trois fois sans jamais le dire une.

De même, la boucle bornée de cinquième, la récurrence de terminale et l'algèbre initiale
de la spécialité informatique sont la propriété universelle de `ℕ`, énoncée trois fois.
Et `1/3` qui n'est pas décimal en cinquième, `0,1 + 0,2 ≠ 0,3` en première NSI : le même
pôle, dans deux ouverts différents de `Spec ℤ`.

**Ce que le lycée admet est ce qui demande une construction.** La liste des lignes
*Admis* dans [lycee.md](lycee.md) — valeurs intermédiaires, convergence monotone,
existence de primitives, intégrale, loi normale — devient, dans cette langue, une seule
observation : ce sont exactement les énoncés où il faut *construire* un objet, et non le
manipuler. Connexité et complétude de `ℝ`, existence de colimites, annulation d'un `H¹`,
théorie de la mesure. Le reste du programme se manipule ; ces quatre-là se construisent, et
c'est pourquoi ils sont admis d'un côté et coûteux à formaliser de l'autre.

**Ce que la traduction ne donne pas.** Aucune démonstration. Aucun raccourci : dire que
l'exponentielle est un isomorphisme de groupes formels ne dispense pas de construire
`exp`, et le vocabulaire ne remplace jamais le travail qu'il nomme. Grothendieck insistait
sur ce point plus que sur tout autre — la généralité n'est utile que si elle rend l'énoncé
inévitable, et elle se paie au prix fort, en constructions préalables. Ce fichier est donc
à lire comme ce qu'il est : la carte du terrain, dessinée après coup, et non le chemin qui
y mène.
