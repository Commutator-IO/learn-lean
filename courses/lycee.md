# Programme du lycée — théorèmes et propriétés (filière S)

Suite du [programme du collège](college.md), pour le lycée général, **filière S** :
seconde (tronc commun), première S, terminale S, plus l'enseignement de spécialité
mathématiques de terminale S.

La filière S a disparu avec la réforme du lycée : dernière session du bac S en 2020.
Le contenu ci-dessous reste presque intégralement au programme actuel, redistribué ainsi :

| Ancien | Aujourd'hui |
|---|---|
| Seconde | Seconde (tronc commun, inchangé pour l'essentiel) |
| Première S | Spécialité mathématiques de première |
| Terminale S | Spécialité mathématiques de terminale |
| Spécialité S (arithmétique, matrices) | Mathématiques expertes (arithmétique, complexes, matrices) |
| — | Mathématiques complémentaires (option allégée, sans complexes ni intégration poussée) |

Colonnes *Niveau* : **2de**, **1S**, **TS**, **Spé** (spécialité de terminale S), et
**1NSI** / **TNSI** pour la spécialité *numérique et sciences informatiques*, au chapitre 11.
Colonne *Démontré* : mêmes symboles que dans le [README](../README.md) — ☐ à faire, ◐ en
cours (`sorry`), ☑ démontré, ✗ non formalisable en l'état. Les fiches détaillées sont
dans [`courses/lycee/`](02-lycee/README.md).

La colonne *Admis* signale les énoncés que le programme du lycée **admet** sans
démonstration (théorème des valeurs intermédiaires, propriétés de l'intégrale, théorème
de Moivre–Laplace…). C'est la frontière la plus intéressante du fichier : Lean ne connaît
pas cette convention, et ce qui est admis au lycée doit y être prouvé — ou emprunté à
Mathlib, ce qui revient à déplacer la question plutôt qu'à la résoudre.

---

## 1. Nombres, calcul algébrique

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Inclusions `ℕ ⊂ ℤ ⊂ 𝔻 ⊂ ℚ ⊂ ℝ`, strictes | 2de | | ☑ |
| `√2` est irrationnel | 2de | | ☑ |
| Un rationnel a un développement décimal périodique, et réciproquement | 2de | oui | ◐ |
| Valeur absolue : `\|x − a\| ≤ r ⟺ x ∈ [a − r, a + r]` | 2de | | ☑ |
| Inégalité triangulaire : `\|x + y\| ≤ \|x\| + \|y\|` | 2de | | ☑ |
| Identités remarquables `(a ± b)²`, `a² − b²` | 2de | | ☑ |
| Un produit est nul ⟺ l'un des facteurs est nul ; règle des signes d'un quotient | 2de | | ☑ |
| Signe de `ax + b` selon le signe de `a` | 2de | | ☑ |
| Puissances et racines : `√(ab) = √a √b`, `(aⁿ)ᵐ = aⁿᵐ` | 2de | | ☑ |
| Comparaison de `x`, `x²`, `√x` selon que `x ∈ [0,1]` ou `x ≥ 1` | 2de | | ☑ |
| Somme des termes d'une suite arithmétique : `1 + 2 + ⋯ + n = n(n+1)/2` | 1S | | ☑ |
| Somme géométrique : `1 + q + ⋯ + qⁿ = (1 − qⁿ⁺¹)/(1 − q)` pour `q ≠ 1` | 1S | | ☑ |
| Coefficients binomiaux ; relation de Pascal `C(n,k) + C(n,k+1) = C(n+1,k+1)` | 1S | | ☑ |
| Formule du binôme de Newton | 1S / TS | | ☑ |
| Raisonnement par récurrence : principe et mise en œuvre | TS | | ☑ |
| Inégalité de Bernoulli : `(1 + a)ⁿ ≥ 1 + na` pour `a ≥ −1` | TS | | ☑ |

---

## 2. Fonctions, second degré

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Ensemble de définition, image, antécédent ; sens de variation | 2de | | ☑ |
| Fonctions de référence : affine, carré, inverse, racine, cube — variations et courbes | 2de | | ☑ |
| Une fonction croissante conserve l'ordre ; composition avec une fonction décroissante l'inverse | 2de | | ☑ |
| Forme canonique d'un trinôme `ax² + bx + c` | 1S | | ☑ |
| Discriminant : nombre de racines réelles selon le signe de `Δ` | 1S | | ☑ |
| Factorisation `a(x − x₁)(x − x₂)` et signe du trinôme (« du signe de `a` sauf entre les racines ») | 1S | | ☑ |
| Somme et produit des racines : `x₁ + x₂ = −b/a`, `x₁x₂ = c/a` | 1S | | ☑ |
| Sommet de la parabole, axe de symétrie | 1S | | ☑ |
| Fonction homographique : ensemble de définition, variations, asymptotes | 1S | | ☑ |
| Parité : symétrie de la courbe par rapport à l'axe des ordonnées ou à l'origine | 2de / 1S | | ☑ |

---

## 3. Suites

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Suites arithmétiques : `uₙ = u₀ + nr` ; suites géométriques : `uₙ = u₀qⁿ` | 1S | | ☑ |
| Sens de variation d'une suite arithmétique (signe de `r`), géométrique (signe de `q − 1`, `u₀`) | 1S | | ☑ |
| Limite d'une suite : définition avec `ε` (ou avec `A` pour `+∞`) | TS | | ☑ |
| Unicité de la limite | TS | oui | ☑ |
| Opérations sur les limites (somme, produit, quotient), formes indéterminées | TS | oui | ☑ |
| Limite de `qⁿ` selon `\|q\| < 1`, `q = 1`, `q > 1` | TS | | ☑ |
| Théorèmes de comparaison ; théorème des gendarmes | TS | | ☑ |
| Toute suite croissante majorée converge (convergence monotone) | TS | oui | ☑ |
| Une suite croissante non majorée tend vers `+∞` | TS | | ☑ |
| Toute suite convergente est bornée | TS | | ☑ |
| Suites adjacentes ; dichotomie | TS | | ◐ |
| Suites `uₙ₊₁ = f(uₙ)` : si `f` continue et `uₙ → ℓ` alors `f(ℓ) = ℓ` | TS | | ☑ |

---

## 4. Limites, continuité, dérivation

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Limite d'une fonction en un point, en `±∞` ; asymptotes horizontale, verticale, oblique | TS | | ☑ |
| Opérations sur les limites ; limite d'une composée | TS | oui | ☑ |
| Croissances comparées : `eˣ/xⁿ → +∞`, `ln x / x → 0`, `x ln x → 0` | TS | | ☑ |
| Continuité en un point, sur un intervalle ; toute fonction dérivable est continue | TS | oui | ☑ |
| Théorème des valeurs intermédiaires | TS | oui | ☑ |
| Corollaire : `f` continue strictement monotone sur `[a,b]` ⟹ `f(x) = k` a une solution unique | TS | | ☑ |
| Nombre dérivé comme limite du taux d'accroissement ; équation de la tangente | 1S | | ☑ |
| Dérivées usuelles : `xⁿ`, `1/x`, `√x`, `sin`, `cos`, `exp`, `ln` | 1S / TS | | ☑ |
| Opérations : `(u + v)'`, `(uv)'`, `(1/v)'`, `(u/v)'` | 1S | | ☑ |
| Dérivée d'une composée `(v ∘ u)' = u' × (v' ∘ u)` ; cas `u(ax + b)` | 1S / TS | | ☑ |
| Signe de `f'` et sens de variation de `f` | 1S | oui | ☑ |
| Un extremum local en un point intérieur où `f` est dérivable annule `f'` ; la réciproque est fausse | 1S | | ☑ |
| Dérivée seconde, convexité, point d'inflexion | TS | | ☑ |

---

## 5. Exponentielle, logarithme, trigonométrie

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Existence et unicité de `f` dérivable telle que `f' = f` et `f(0) = 1` | TS | oui | ☑ |
| `exp(a + b) = exp(a)exp(b)`, `exp(−a) = 1/exp(a)`, `exp(na) = exp(a)ⁿ` | TS | | ☑ |
| `exp(x) > 0` pour tout `x` ; `exp` strictement croissante | TS | | ☑ |
| Limites : `eˣ → +∞` en `+∞`, `eˣ → 0` en `−∞` | TS | | ☑ |
| `ln` réciproque de `exp` : `ln(exp x) = x`, `exp(ln x) = x` pour `x > 0` | TS | | ☑ |
| `ln(ab) = ln a + ln b`, `ln(a/b)`, `ln(aⁿ) = n ln a`, `ln √a = ½ ln a` | TS | | ☑ |
| `ln` dérivable de dérivée `1/x` ; `ln` strictement croissante | TS | | ☑ |
| Limites de `ln` en `0⁺` et en `+∞` | TS | | ☑ |
| Cercle trigonométrique, radians ; `cos² + sin² = 1` | 1S | | ☑ |
| Valeurs remarquables et angles associés (`−x`, `π − x`, `π/2 − x`…) | 1S | | ☑ |
| Formules d'addition et de duplication de `cos` et `sin` | 1S | | ☑ |
| Résolution de `cos x = a`, `sin x = a` ; périodicité | 1S | | ☑ |
| `sin` et `cos` dérivables, `sin' = cos`, `cos' = −sin` ; `lim (sin x)/x = 1` en 0 | TS | | ☑ |

---

## 6. Intégration

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Intégrale d'une fonction continue positive = aire sous la courbe | TS | oui | ☑ |
| Toute fonction continue sur un intervalle admet des primitives | TS | oui | ☑ |
| `x ↦ ∫ₐˣ f(t)dt` est la primitive de `f` qui s'annule en `a` | TS | | ☑ |
| Deux primitives d'une même fonction diffèrent d'une constante | TS | | ☑ |
| Théorème fondamental : `∫ₐᵇ f = F(b) − F(a)` | TS | | ☑ |
| Linéarité de l'intégrale | TS | | ☑ |
| Relation de Chasles | TS | | ☑ |
| Positivité et croissance : `f ≥ 0 ⟹ ∫ f ≥ 0` ; `f ≤ g ⟹ ∫ f ≤ ∫ g` | TS | | ☑ |
| Inégalité de la moyenne ; valeur moyenne `(1/(b−a))∫ₐᵇ f` | TS | | ☑ |
| Intégration par parties | TS | | ☑ |
| Aire entre deux courbes ; volume d'un solide de révolution (approche) | TS | oui | ◐ |

---

## 7. Nombres complexes

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Forme algébrique `a + ib` ; unicité de l'écriture, `i² = −1` | TS | | ☑ |
| Conjugué : `conj(z + z') = conj z + conj z'`, `conj(zz') = conj z conj z'`, `z conj z = \|z\|²` | TS | | ☑ |
| `z` réel ⟺ `z = conj z` ; `z` imaginaire pur ⟺ `z = −conj z` | TS | | ☑ |
| Module : `\|zz'\| = \|z\|\|z'\|`, `\|z + z'\| ≤ \|z\| + \|z'\|` | TS | | ☑ |
| Argument, forme trigonométrique ; `arg(zz') = arg z + arg z'` | TS | | ☑ |
| Forme exponentielle `re^{iθ}` ; formules d'Euler et de Moivre | TS | | ☑ |
| Équation du second degré à coefficients réels avec `Δ < 0` : deux racines conjuguées | TS | | ☑ |
| Interprétation géométrique : affixe, `\|z_B − z_A\|` = distance, `arg((z_C − z_A)/(z_B − z_A))` = angle | TS | | ☑ |
| Alignement et orthogonalité en termes d'affixes ; caractérisation d'un cercle | TS | | ☑ |
| Écriture complexe d'une translation, d'une rotation, d'une homothétie | TS | | ☑ |

---

## 8. Géométrie : vecteurs, produit scalaire, espace

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Vecteurs : relation de Chasles, colinéarité ; `AB` et `CD` colinéaires ⟺ `(AB) ∥ (CD)` | 2de | | ☑ |
| Critère de colinéarité par le déterminant `xy' − x'y = 0` | 2de | | ☑ |
| Décomposition unique d'un vecteur dans une base du plan | 2de / 1S | | ☑ |
| Coordonnées du milieu, distance entre deux points | 2de | | ☑ |
| Équation de droite `y = mx + p` et `ax + by + c = 0` ; parallélisme et coefficients directeurs | 2de | | ☑ |
| Système linéaire 2×2 : existence et unicité de la solution si le déterminant est non nul | 2de / 1S | | ☑ |
| Produit scalaire : définitions équivalentes (projeté, coordonnées, normes, `\|u\|\|v\|cos θ`) | 1S | | ☑ |
| Bilinéarité et symétrie du produit scalaire | 1S | | ☑ |
| `u ⊥ v ⟺ u · v = 0` | 1S | | ☑ |
| Théorème d'Al-Kashi | 1S | | ☑ |
| Théorème de la médiane ; formule des trois normes | 1S | | ☑ |
| Équation cartésienne d'un cercle ; caractérisation `MA · MB = 0` | 1S | | ☑ |
| Loi des sinus ; aire `½ ab sin C` | 1S | | ☑ |
| Géométrie dans l'espace : positions relatives de droites et plans | TS | | ◐ |
| Théorème du toit ; parallélisme de deux plans par deux sécantes | TS | oui | ◐ |
| Vecteurs de l'espace, coplanarité, repère et base | TS | | ☑ |
| Représentation paramétrique d'une droite, d'un plan | TS | | ☑ |
| Produit scalaire dans l'espace ; vecteur normal et équation cartésienne `ax + by + cz + d = 0` | TS | | ☑ |
| Distance d'un point à un plan ; intersection droite-plan, plan-plan | TS | | ◐ |

---

## 9. Probabilités et statistiques

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Moyenne, médiane, quartiles, écart interquartile, écart-type | 2de / 1S | | ◐ |
| Linéarité de la moyenne ; `écart-type(aX + b) = \|a\| × écart-type(X)` | 1S | | ☑ |
| `P(A ∪ B) = P(A) + P(B) − P(A ∩ B)` ; `P(Ā) = 1 − P(A)` | 2de | | ☑ |
| Variable aléatoire : loi, espérance, variance, écart-type | 1S | | ☑ |
| `E(aX + b) = aE(X) + b` ; `V(aX + b) = a²V(X)` ; `V(X) = E(X²) − E(X)²` | 1S | | ☑ |
| Épreuve et schéma de Bernoulli ; loi binomiale `P(X = k) = C(n,k)pᵏ(1−p)ⁿ⁻ᵏ` | 1S | | ☑ |
| Espérance et variance d'une binomiale : `np` et `np(1−p)` | 1S | oui | ◐ |
| Probabilité conditionnelle `P_A(B) = P(A ∩ B)/P(A)` ; formule des probabilités composées | TS | | ☑ |
| Formule des probabilités totales ; arbre pondéré | TS | | ☑ |
| Indépendance de deux événements ; indépendance et événements contraires | TS | | ☑ |
| Loi uniforme sur `[a,b]` : densité, espérance `(a+b)/2` | TS | | ☑ |
| Loi exponentielle : densité `λe^{−λt}`, `P(X > t) = e^{−λt}`, absence de mémoire, espérance `1/λ` | TS | | ◐ |
| Loi normale centrée réduite ; théorème de Moivre–Laplace | TS | oui | ◐ |
| Loi normale `N(μ, σ²)` ; intervalles `1σ`, `2σ`, `3σ` (68 %, 95 %, 99,7 %) | TS | oui | ◐ |
| Intervalle de fluctuation asymptotique au seuil 95 % : `[p ± 1,96√(p(1−p)/n)]` | TS | | ◐ |
| Intervalle de confiance `[f ± 1/√n]` ; prise de décision | TS | oui | ◐ |

---

## 10. Arithmétique, matrices et graphes

### Arithmétique

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Divisibilité dans `ℤ` ; division euclidienne, existence et unicité | Spé | | ☑ |
| Congruences modulo `n` : compatibilité avec somme et produit | Spé | | ☑ |
| Critères de divisibilité revisités par les congruences | Spé | | ☑ |
| PGCD, algorithme d'Euclide ; `pgcd(a,b) = pgcd(b, a mod b)` | Spé | | ☑ |
| Théorème de Bézout : `pgcd(a,b) = 1 ⟺ ∃(u,v), au + bv = 1` | Spé | | ☑ |
| Théorème de Gauss : `a ∣ bc` et `pgcd(a,b) = 1` ⟹ `a ∣ c` | Spé | | ☑ |
| Équation diophantienne `ax + by = c` : condition d'existence, forme des solutions | Spé | | ☑ |
| Infinité des nombres premiers | Spé | | ☑ |
| Décomposition en facteurs premiers : existence et unicité | Spé | oui | ☑ |
| Petit théorème de Fermat : `p` premier, `p ∤ a` ⟹ `a^{p−1} ≡ 1 [p]` | Spé | | ☑ |
| Application au chiffrement (RSA, code affine) | Spé | | ◐ |

### Matrices et graphes

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Opérations sur les matrices ; le produit n'est pas commutatif | Spé | | ☑ |
| Matrice inversible ; inverse d'une matrice `2×2` et condition `ad − bc ≠ 0` | Spé | | ☑ |
| Écriture matricielle d'un système linéaire ; résolution par l'inverse | Spé | | ☑ |
| Puissances `Aⁿ` ; calcul par diagonalisation dans les cas simples | Spé | | ☑ |
| Suites `Uₙ₊₁ = AUₙ + B` ; forme explicite et état stable | Spé | | ☑ |
| Graphe probabiliste, matrice de transition ; convergence vers l'état stable (cas `2×2`) | Spé | oui | ☑ |

---

## 11. Informatique

La spécialité *numérique et sciences informatiques*, en première et en terminale. Elle ne
fait pas partie du programme de mathématiques, et figure ici pour une raison précise : le
collège traite l'[algorithmique et la programmation](college.md#7-algorithmique-et-programmation),
et rien ne prend la suite au lycée. Les énoncés ci-dessous rétablissent cette continuité —
la boucle bornée de cinquième et l'invariant de boucle de première NSI sont la même idée,
énoncée deux fois à six ans d'écart.

Un programme n'est pas un objet mathématique tant qu'on ne l'a pas défini comme tel. Ces
énoncés portent donc sur des fonctions Lean écrites pour l'occasion — une recherche
dichotomique, un tri, un parcours d'arbre — et non sur du code Python. C'est la différence
entre *démontrer qu'un algorithme est correct* et *tester qu'un programme fonctionne*, et
c'est exactement ce que ce dossier cherche à rendre visible.

Une partie de la spécialité reste dehors, faute d'énoncé à démontrer : architecture
matérielle, réseaux, systèmes d'exploitation, interfaces web, et le versant pratique des
bases de données. Ce qui s'en formalise — l'algèbre relationnelle, les protocoles de
routage — appartient à un autre projet que celui-ci.

### Représentation des données

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Algèbre de Boole : lois de De Morgan, distributivité, `¬¬a = a` | 1NSI | | ☐ |
| Écriture binaire d'un entier naturel : existence et unicité | 1NSI | oui | ☐ |
| Valeur d'une écriture binaire : `∑ bᵢ 2ⁱ` ; passage binaire ↔ décimal | 1NSI | | ☐ |
| Nombre de bits d'un entier `n > 0` : `⌊log₂ n⌋ + 1` | 1NSI | | ☐ |
| Complément à deux sur `n` bits : les entiers de `−2ⁿ⁻¹` à `2ⁿ⁻¹ − 1`, et l'addition modulo `2ⁿ` | 1NSI | | ☐ |
| Écriture hexadécimale ; un chiffre hexadécimal vaut quatre bits | 1NSI | | ☐ |
| Nombres à virgule flottante : `1/10` n'a pas d'écriture binaire finie, d'où `0,1 + 0,2 ≠ 0,3` | 1NSI | | ☐ |
| Chaînes de caractères : la concaténation est associative, sa longueur est la somme des longueurs | 1NSI | | ☐ |

### Algorithmes sur les tableaux

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Recherche séquentielle : le résultat est un indice de la valeur cherchée, ou l'absence de la valeur | 1NSI | | ☐ |
| Coût de la recherche séquentielle : `n` comparaisons au pire, et ce pire est atteint | 1NSI | | ☐ |
| Maximum d'un tableau non vide : le résultat appartient au tableau et majore tous ses éléments | 1NSI | | ☐ |
| Recherche dichotomique dans un tableau trié : correction | 1NSI | | ☐ |
| Coût de la recherche dichotomique : `⌊log₂ n⌋ + 1` comparaisons au pire | 1NSI | oui | ☐ |
| Tri par insertion : le résultat est trié et c'est une permutation de l'entrée | 1NSI | | ☐ |
| Tri par sélection : même énoncé de correction | 1NSI | | ☐ |
| Coût quadratique des tris par insertion et par sélection ; `n(n−1)/2` comparaisons au pire | 1NSI | | ☐ |
| Tri fusion : correction, et coût en `n log n` | TNSI | oui | ☐ |
| Un tri par comparaisons demande au moins `log₂(n!)` comparaisons | TNSI | oui | ☐ |

### Récursivité et diviser pour régner

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Factorielle récursive : la fonction calcule bien `n!` et termine | TNSI | | ☐ |
| Suite de Fibonacci : les versions récursive et itérative calculent la même valeur | TNSI | | ☐ |
| Coût exponentiel de Fibonacci récursif naïf, linéaire de la version itérative | TNSI | | ☐ |
| Exponentiation rapide : `aⁿ` en `⌊log₂ n⌋ + 1` élévations au carré au plus | TNSI | | ☐ |
| Tours de Hanoï : `2ⁿ − 1` déplacements, et aucune solution n'en demande moins | TNSI | oui | ☐ |
| Diviser pour régner : le coût `T(n) = 2T(n/2) + n` vaut `n log₂ n` | TNSI | oui | ☐ |

### Structures de données

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Pile : dépiler après avoir empilé rend l'état initial (dernier entré, premier sorti) | TNSI | | ☐ |
| File : le premier entré est le premier sorti | TNSI | | ☐ |
| File par deux piles : le comportement est celui d'une file | TNSI | | ☐ |
| Liste chaînée : longueur d'une concaténation, parcours complet | TNSI | | ☐ |
| Arbre binaire de hauteur `h` : au plus `2ʰ⁺¹ − 1` nœuds, donc hauteur `≥ log₂(n+1)` | TNSI | | ☐ |
| Arbre binaire strict : le nombre de feuilles vaut le nombre de nœuds internes plus un | TNSI | | ☐ |
| Arbre binaire de recherche : le parcours infixe donne les clés triées | TNSI | | ☐ |
| Recherche dans un arbre binaire de recherche : coût majoré par la hauteur | TNSI | | ☐ |
| Graphe : un parcours en profondeur atteint exactement les sommets accessibles depuis l'origine | TNSI | | ☐ |
| Un arbre est un graphe connexe sans cycle ; il a `n − 1` arêtes | TNSI | oui | ☐ |
| Algorithme de Dijkstra : correction pour des poids positifs | TNSI | oui | ☐ |

### Correction et terminaison des programmes

| Énoncé | Niveau | Admis | Démontré |
|---|---|---|---|
| Invariant de boucle : une propriété vraie avant et conservée par le corps est vraie à la sortie | 1NSI | | ☐ |
| Variant de boucle : un entier naturel strictement décroissant force l'arrêt | 1NSI | | ☐ |
| Somme des `n` premiers entiers par accumulation : le programme calcule `n(n+1)/2` | 1NSI | | ☐ |
| Division euclidienne par soustractions successives : le programme rend quotient et reste | 1NSI | | ☐ |
| Deux programmes de structures différentes calculent la même fonction | 1NSI | | ☐ |
| Indécidabilité du problème de l'arrêt | TNSI | oui | ☐ |

---

## 12. Ce que le lycée admet

Regroupement des lignes marquées *Admis* — c'est là que le programme fait crédit, et
donc là que la formalisation coûte le plus cher :

- **Analyse.** Théorème des valeurs intermédiaires, convergence monotone, existence de
  primitives pour toute fonction continue, lien entre signe de `f'` et variations,
  opérations sur les limites. Tout repose sur la complétude de `ℝ`, jamais énoncée au lycée.
- **Intégration.** L'intégrale est définie comme une aire, notion admise sans construction.
  En Lean il faut choisir une théorie de l'intégration avant même d'écrire l'énoncé.
- **Probabilités continues.** Densité, loi normale, Moivre–Laplace : rien n'est démontrable
  au lycée faute de théorie de la mesure.
- **Existence de l'exponentielle.** Admise comme solution de `y' = y`, `y(0) = 1` ; sa
  construction (série, équation différentielle, réciproque de `ln`) est hors programme.

Symétriquement, une partie du programme est déjà dans Mathlib presque mot pour mot
(`Real.exp`, `Real.log`, `Complex.abs`, `Nat.gcd`, `Nat.Prime`, `intervalIntegral`,
`MeasureTheory`, `Matrix`). Pour ces énoncés, l'exercice n'est plus de démontrer mais de
retrouver la formulation exacte et de vérifier qu'elle dit bien la même chose que
l'énoncé français — ce qui est un exercice différent, et pas toujours plus facile.
