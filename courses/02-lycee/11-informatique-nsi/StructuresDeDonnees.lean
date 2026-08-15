/-
Lycée — spécialité NSI, section « Structures de données ».
Une structure de données n'est pas un rangement : c'est un contrat. La pile promet que
le dernier entré sort le premier, la file que c'est le premier, l'arbre binaire de
recherche que le parcours infixe rend les clés triées. Ce fichier écrit ces structures
et démontre leurs contrats — y compris celui, moins évident, de la file simulée par
deux piles.
Énoncés et démonstrations en français : voir Informatique.tex.
-/
import Mathlib

namespace Lycee.Nsi

variable {α : Type*}

/-! ## Piles -/

/-- Empiler : le nouvel élément est posé au sommet. -/
def empiler (x : α) (p : List α) : List α := x :: p

/-- Dépiler : on rend le sommet et la pile privée de ce sommet, ou rien si la pile est
vide. -/
def depiler : List α → Option (α × List α)
  | [] => none
  | x :: p => some (x, p)

/-- Le contrat de la pile : dernier entré, premier sorti. Dépiler juste après avoir
empilé rend l'élément qu'on vient de poser et l'état d'avant ; et si l'on empile deux
éléments, c'est le second qui ressort d'abord. -/
theorem pile_dernier_entre_premier_sorti (x y : α) (p : List α) :
    depiler (empiler x p) = some (x, p) ∧
      depiler (empiler y (empiler x p)) = some (y, empiler x p) :=
  ⟨rfl, rfl⟩

/-! ## Files -/

/-- Enfiler : le nouvel élément est mis à la fin. -/
def enfiler (x : α) (f : List α) : List α := f ++ [x]

/-- Défiler : on rend la tête, c'est-à-dire l'élément qui attend depuis le plus
longtemps. -/
def defiler : List α → Option (α × List α)
  | [] => none
  | x :: f => some (x, f)

/-- Le contrat de la file : premier entré, premier sorti. Enfiler dans une file vide
puis défiler rend l'élément ; enfiler dans une file non vide ne change pas qui sort en
premier — le nouveau venu prend la queue. -/
theorem file_premier_entre_premier_sorti (x y : α) (f : List α) :
    defiler (enfiler x []) = some (x, []) ∧
      defiler (enfiler x (y :: f)) = some (y, enfiler x f) := by
  constructor
  · rfl
  · simp [enfiler, defiler]

/-! ## File par deux piles -/

/-- Une file simulée par deux piles : on empile les arrivées sur la pile d'entrée, et
l'on sert depuis la pile de sortie ; quand celle-ci se vide, on y bascule l'entrée
retournée. C'est la construction classique, et elle n'a rien d'évident : la file
apparaît alors que ni l'une ni l'autre des deux piles ne se comporte comme une file. -/
structure FileDeuxPiles (α : Type*) where
  entree : List α
  sortie : List α

/-- Enfiler dans la structure : on empile sur la pile d'entrée. -/
def FileDeuxPiles.enfiler (x : α) (f : FileDeuxPiles α) : FileDeuxPiles α :=
  ⟨x :: f.entree, f.sortie⟩

/-- Défiler dans la structure : on sert la pile de sortie ; si elle est vide, on y
bascule d'abord la pile d'entrée retournée. -/
def FileDeuxPiles.defiler (f : FileDeuxPiles α) : Option (α × FileDeuxPiles α) :=
  match f.sortie with
  | x :: s => some (x, ⟨f.entree, s⟩)
  | [] =>
      match f.entree.reverse with
      | [] => none
      | x :: s => some (x, ⟨[], s⟩)

/-- Le contenu de la structure, vu comme une file ordinaire : ce qui attend dans la
pile de sortie, puis ce qui attend dans la pile d'entrée, retourné. C'est la fonction
d'abstraction — c'est elle qui donne un sens à « se comporter comme une file ». -/
def FileDeuxPiles.contenu (f : FileDeuxPiles α) : List α := f.sortie ++ f.entree.reverse

/-- La file par deux piles se comporte bien comme une file : ses deux opérations
correspondent, à travers la fonction d'abstraction, à celles de la file ordinaire.
C'est ce qu'il faut démontrer pour avoir le droit de remplacer l'une par l'autre. -/
theorem file_par_deux_piles (x : α) (f : FileDeuxPiles α) :
    (f.enfiler x).contenu = enfiler x f.contenu ∧
      (f.defiler).map (fun r => (r.1, r.2.contenu)) = defiler f.contenu := by
  obtain ⟨e, s⟩ := f
  constructor
  · simp [FileDeuxPiles.enfiler, FileDeuxPiles.contenu, enfiler]
  · rcases s with _ | ⟨y, s⟩
    · -- La pile de sortie est vide : tout le contenu est l'entrée retournée.
      rcases hr : e.reverse with _ | ⟨z, t⟩
      · simp [FileDeuxPiles.defiler, FileDeuxPiles.contenu, hr, defiler]
      · simp [FileDeuxPiles.defiler, FileDeuxPiles.contenu, hr, defiler]
    · simp [FileDeuxPiles.defiler, FileDeuxPiles.contenu, defiler]

/-! ## Listes chaînées -/

/-- La longueur d'une liste chaînée, comptée maillon par maillon. -/
def longueur : List α → ℕ
  | [] => 0
  | _ :: r => 1 + longueur r

/-- La concaténation de deux listes chaînées : on recopie la première devant la
seconde. -/
def concatener : List α → List α → List α
  | [], l => l
  | a :: r, l => a :: concatener r l

/-- Le parcours d'une liste chaînée : on visite les maillons du premier au dernier. -/
def parcours : List α → List α
  | [] => []
  | a :: r => a :: parcours r

/-- Les deux propriétés qu'on attend d'une liste chaînée : la longueur d'une
concaténation est la somme des longueurs, et le parcours voit exactement les éléments
de la liste — il n'en oublie aucun et n'en invente aucun. -/
theorem liste_chainee (l1 l2 : List α) :
    longueur (concatener l1 l2) = longueur l1 + longueur l2 ∧
      ∀ y : α, y ∈ parcours l1 ↔ y ∈ l1 := by
  constructor
  · induction l1 with
    | nil => simp [concatener, longueur]
    | cons a r ih => simp [concatener, longueur, ih]; omega
  · intro y
    induction l1 with
    | nil => simp [parcours]
    | cons a r ih => simp [parcours, ih]

/-! ## Arbres binaires -/

/-- Un arbre binaire : soit vide, soit un nœud portant une valeur et deux
sous-arbres. -/
inductive Arbre (α : Type*) where
  | vide : Arbre α
  | noeud : Arbre α → α → Arbre α → Arbre α

/-- Le nombre de nœuds. -/
def Arbre.taille : Arbre α → ℕ
  | vide => 0
  | noeud g _ d => g.taille + 1 + d.taille

/-- La hauteur, comptée en nombre de niveaux : l'arbre vide a la hauteur `0`, un arbre
réduit à un nœud la hauteur `1`. C'est la convention des tableaux du programme ; avec
celle qui compte les arêtes, tous les énoncés se décalent de un. -/
def Arbre.hauteur : Arbre α → ℕ
  | vide => 0
  | noeud g _ d => 1 + max g.hauteur d.hauteur

/-- Un arbre de hauteur `h` a au plus `2ʰ − 1` nœuds : chaque niveau ne peut au mieux
que doubler le nombre de nœuds du précédent. L'inégalité est écrite `n + 1 ≤ 2ʰ` pour
éviter la soustraction tronquée des entiers naturels. -/
theorem arbre_binaire_taille_majoree (a : Arbre α) : a.taille + 1 ≤ 2 ^ a.hauteur := by
  induction a with
  | vide => simp [Arbre.taille, Arbre.hauteur]
  | noeud g x d ihg ihd =>
      rw [Arbre.taille, Arbre.hauteur, pow_add, pow_one]
      have h1 : (2 : ℕ) ^ g.hauteur ≤ 2 ^ max g.hauteur d.hauteur :=
        Nat.pow_le_pow_right (by norm_num) (le_max_left _ _)
      have h2 : (2 : ℕ) ^ d.hauteur ≤ 2 ^ max g.hauteur d.hauteur :=
        Nat.pow_le_pow_right (by norm_num) (le_max_right _ _)
      omega

/-- Conséquence directe : la hauteur d'un arbre à `n` nœuds vaut au moins
`log₂(n + 1)`. C'est la raison pour laquelle on cherche à équilibrer les arbres — on
ne peut pas descendre en dessous de cette hauteur, mais on peut s'en approcher. -/
theorem arbre_binaire_hauteur_minoree (a : Arbre α) :
    Nat.log 2 (a.taille + 1) ≤ a.hauteur := by
  calc Nat.log 2 (a.taille + 1) ≤ Nat.log 2 (2 ^ a.hauteur) :=
        Nat.log_mono_right (arbre_binaire_taille_majoree a)
    _ = a.hauteur := Nat.log_pow (by norm_num) _

/-- Un sous-arbre compte pour une arête s'il n'est pas vide. -/
def Arbre.compteNonVide : Arbre α → ℕ
  | vide => 0
  | noeud _ _ _ => 1

/-- Le nombre d'arêtes : une par sous-arbre non vide accroché à un nœud. -/
def Arbre.aretes : Arbre α → ℕ
  | vide => 0
  | noeud g _ d => g.aretes + d.aretes + g.compteNonVide + d.compteNonVide

/-- Un arbre non vide à `n` nœuds a `n − 1` arêtes : chaque nœud sauf la racine est
relié à son père par exactement une arête, et il n'y en a pas d'autre. C'est la
version enracinée de l'énoncé « un arbre est un graphe connexe sans cycle, et il a
`n − 1` arêtes » ; la caractérisation par la connexité et l'absence de cycle demande
une théorie des graphes que ce fichier ne construit pas. -/
theorem arbre_aretes (a : Arbre α) (h : a ≠ Arbre.vide) : a.aretes + 1 = a.taille := by
  induction a with
  | vide => exact absurd rfl h
  | noeud g x d ihg ihd =>
      rcases g with _ | ⟨gg, gx, gd⟩ <;> rcases d with _ | ⟨dg, dx, dd⟩
      · simp [Arbre.aretes, Arbre.taille, Arbre.compteNonVide]
      · have hd := ihd (by simp)
        simp only [Arbre.aretes, Arbre.taille, Arbre.compteNonVide] at hd ⊢
        omega
      · have hg := ihg (by simp)
        simp only [Arbre.aretes, Arbre.taille, Arbre.compteNonVide] at hg ⊢
        omega
      · have hg := ihg (by simp)
        have hd := ihd (by simp)
        simp only [Arbre.aretes, Arbre.taille, Arbre.compteNonVide] at hg hd ⊢
        omega

/-! ## Arbres binaires stricts -/

/-- Un arbre binaire strict : chaque nœud interne a exactement deux enfants. On le
décrit par un type à part, ce qui rend la contrainte impossible à violer plutôt que
seulement vérifiée. -/
inductive ArbreStrict where
  | feuille : ArbreStrict
  | noeud : ArbreStrict → ArbreStrict → ArbreStrict

/-- Le nombre de feuilles. -/
def ArbreStrict.feuilles : ArbreStrict → ℕ
  | feuille => 1
  | noeud g d => g.feuilles + d.feuilles

/-- Le nombre de nœuds internes. -/
def ArbreStrict.internes : ArbreStrict → ℕ
  | feuille => 0
  | noeud g d => 1 + g.internes + d.internes

/-- Dans un arbre binaire strict, il y a exactement une feuille de plus que de nœuds
internes. On peut le lire ainsi : chaque nœud interne créé remplace une feuille par
deux, donc ajoute une feuille et un interne ; le compte part de une feuille et zéro
interne. -/
theorem arbre_strict_feuilles (a : ArbreStrict) : a.feuilles = a.internes + 1 := by
  induction a with
  | feuille => simp [ArbreStrict.feuilles, ArbreStrict.internes]
  | noeud g d ihg ihd =>
      rw [ArbreStrict.feuilles, ArbreStrict.internes, ihg, ihd]
      omega

/-! ## Arbres binaires de recherche -/

/-- Le parcours infixe : le sous-arbre gauche, la racine, le sous-arbre droit. -/
def Arbre.infixe : Arbre α → List α
  | vide => []
  | noeud g x d => g.infixe ++ x :: d.infixe

/-- La propriété d'arbre binaire de recherche : à chaque nœud, tout ce qui est à
gauche est plus petit que la racine, tout ce qui est à droite est plus grand, et les
deux sous-arbres sont eux-mêmes des arbres binaires de recherche. -/
def Arbre.estABR [LinearOrder α] : Arbre α → Prop
  | vide => True
  | noeud g x d =>
      (∀ y ∈ g.infixe, y ≤ x) ∧ (∀ y ∈ d.infixe, x ≤ y) ∧ g.estABR ∧ d.estABR

/-- Le parcours infixe d'un arbre binaire de recherche rend les clés triées. C'est ce
qui justifie la structure : on obtient le tri sans trier, par le seul fait d'avoir
rangé les clés selon la règle. -/
theorem abr_parcours_infixe_trie [LinearOrder α] (a : Arbre α) (h : a.estABR) :
    a.infixe.Pairwise (· ≤ ·) := by
  induction a with
  | vide => simp [Arbre.infixe]
  | noeud g x d ihg ihd =>
      obtain ⟨hg, hd, hgabr, hdabr⟩ := h
      rw [Arbre.infixe, List.pairwise_append]
      refine ⟨ihg hgabr, ?_, ?_⟩
      · rw [List.pairwise_cons]
        exact ⟨hd, ihd hdabr⟩
      · intro u hu v hv
        rcases List.mem_cons.1 hv with hv | hv
        · exact hv ▸ hg u hu
        · exact (hg u hu).trans (hd v hv)

/-- La recherche dans un arbre binaire de recherche : on compare à la racine et l'on
descend d'un seul côté. -/
def Arbre.recherche [LinearOrder α] (x : α) : Arbre α → Bool
  | vide => false
  | noeud g y d => if x = y then true else if x < y then g.recherche x else d.recherche x

/-- Le nombre de comparaisons que fait cette recherche. -/
def Arbre.coutRecherche [LinearOrder α] (x : α) : Arbre α → ℕ
  | vide => 0
  | noeud g y d =>
      1 + (if x = y then 0 else if x < y then g.coutRecherche x else d.coutRecherche x)

/-- La recherche dans un arbre binaire de recherche coûte au plus la hauteur de
l'arbre : on ne descend que d'un niveau par comparaison, et l'on ne remonte jamais.
D'où l'intérêt d'un arbre équilibré, dont la hauteur est logarithmique. -/
theorem cout_recherche_abr [LinearOrder α] (x : α) (a : Arbre α) :
    a.coutRecherche x ≤ a.hauteur := by
  induction a with
  | vide => simp [Arbre.coutRecherche, Arbre.hauteur]
  | noeud g y d ihg ihd =>
      rw [Arbre.coutRecherche, Arbre.hauteur]
      have h1 : g.hauteur ≤ max g.hauteur d.hauteur := le_max_left _ _
      have h2 : d.hauteur ≤ max g.hauteur d.hauteur := le_max_right _ _
      split
      · omega
      · split <;> omega

/-! ## Parcours en profondeur d'un graphe -/

/-- Un graphe est donné par la liste des voisins de chaque sommet. Un sommet `v` est
accessible depuis `u` s'il existe une suite d'arêtes qui y mène — y compris la suite
vide, qui rend tout sommet accessible depuis lui-même. -/
def Accessible {V : Type*} (voisins : V → List V) (u v : V) : Prop :=
  Relation.ReflTransGen (fun a b => b ∈ voisins a) u v

/-- Le parcours en profondeur, avec une pile explicite et la liste des sommets déjà
vus. Le premier argument est un carburant : il borne le nombre de tours, ce qui évite
d'avoir à démontrer la terminaison avant d'avoir démontré quoi que ce soit d'autre.
Un vrai programme s'arrête parce que la liste des vus ne fait que croître. -/
def parcoursProfondeur {V : Type*} [DecidableEq V] (voisins : V → List V) :
    ℕ → List V → List V → List V
  | 0, _, vus => vus
  | _ + 1, [], vus => vus
  | n + 1, s :: pile, vus =>
      if s ∈ vus then parcoursProfondeur voisins n pile vus
      else parcoursProfondeur voisins n (voisins s ++ pile) (s :: vus)

/-- Le parcours en profondeur ne visite que des sommets accessibles : il n'invente
rien. La démonstration est une récurrence sur le carburant, avec pour invariant que
tout ce qui est dans la pile et tout ce qui est déjà vu est accessible. -/
theorem parcours_profondeur_correct {V : Type*} [DecidableEq V] (voisins : V → List V)
    (depart : V) :
    ∀ n pile vus, (∀ v ∈ pile, Accessible voisins depart v) →
      (∀ v ∈ vus, Accessible voisins depart v) →
      ∀ v ∈ parcoursProfondeur voisins n pile vus, Accessible voisins depart v := by
  intro n
  induction n with
  | zero => intro pile vus _ hvus v hv; exact hvus v hv
  | succ k ih =>
      intro pile vus hpile hvus v hv
      rcases pile with _ | ⟨s, pile⟩
      · rw [parcoursProfondeur] at hv
        exact hvus v hv
      · rw [parcoursProfondeur] at hv
        by_cases hs : s ∈ vus
        · rw [if_pos hs] at hv
          exact ih pile vus (fun w hw => hpile w (by simp [hw])) hvus v hv
        · rw [if_neg hs] at hv
          refine ih (voisins s ++ pile) (s :: vus) ?_ ?_ v hv
          · intro w hw
            rcases List.mem_append.1 hw with hw | hw
            · -- Un voisin de `s` est accessible : un pas de plus depuis `s`.
              exact (hpile s (by simp)).tail hw
            · exact hpile w (by simp [hw])
          · intro w hw
            rcases List.mem_cons.1 hw with hw | hw
            · exact hw ▸ hpile s (by simp)
            · exact hvus w hw

/-- Réciproquement, tout sommet accessible finit par être visité, pourvu qu'on laisse
au parcours assez de carburant.

Énoncé admis. Sa démonstration demande un invariant nettement plus fin que celui de
la moitié précédente : il faut suivre, à chaque tour, l'ensemble des sommets qui sont
soit déjà vus, soit encore dans la pile, et montrer qu'aucun sommet accessible ne peut
sortir de cet ensemble — puis borner le carburant nécessaire. C'est la moitié
difficile du théorème, et elle n'est pas faite ici. -/
theorem parcours_profondeur_complet {V : Type*} [Fintype V] [DecidableEq V]
    (voisins : V → List V) (depart : V) :
    ∃ n, ∀ v, Accessible voisins depart v → v ∈ parcoursProfondeur voisins n [depart] [] := by
  sorry

/-! ## Plus courts chemins et algorithme de Dijkstra -/

/-- Le poids d'un chemin, parcouru depuis un sommet de départ : la somme des poids des
arêtes empruntées. Le chemin est donné par la liste des sommets qu'on visite après le
départ. -/
def poidsChemin {V : Type*} (poids : V → V → ℕ) : V → List V → ℕ
  | _, [] => 0
  | u, v :: r => poids u v + poidsChemin poids v r

/-- Avec des poids positifs, allonger un chemin ne le raccourcit jamais.

C'est exactement ce qui autorise l'algorithme de Dijkstra à fixer définitivement la
distance du sommet le plus proche sans regarder la suite du graphe : aucun détour ne
pourra faire mieux. Avec des poids négatifs, l'énoncé tombe, et l'algorithme aussi. -/
theorem poids_chemin_croissant {V : Type*} (poids : V → V → ℕ) (u : V) (c c' : List V) :
    poidsChemin poids u c ≤ poidsChemin poids u (c ++ c') := by
  induction c generalizing u with
  | nil => simp [poidsChemin]
  | cons v r ih =>
      rw [List.cons_append, poidsChemin, poidsChemin]
      exact Nat.add_le_add_left (ih v) _

/-- Correction de l'algorithme de Dijkstra pour des poids positifs.

L'algorithme fixe, pour chaque sommet, une distance `fixe v`. Les deux hypothèses sont
ce qu'il garantit à la fin : la distance de la source est nulle, et aucune arête ne
permet d'améliorer une distance fixée — c'est ce que signifie « l'algorithme a
relâché toutes les arêtes ». On en tire ce qui est demandé : la distance fixée est
bien la plus petite possible, quel que soit le chemin qu'on considère.

La démonstration remonte le chemin arête par arête depuis la source. Ce que cet
énoncé ne formalise pas : que l'algorithme, avec sa file de priorité, établisse bien
ces deux garanties — c'est la partie programmation, et elle est ici portée par les
hypothèses plutôt que passée sous silence. -/
theorem dijkstra_poids_positifs {V : Type*} (poids : V → V → ℕ) (source : V)
    (fixe : V → ℕ) (hsource : fixe source = 0)
    (hrelache : ∀ u v : V, fixe v ≤ fixe u + poids u v) (v : V) (c : List V)
    (hc : c.getLast? = some v) :
    fixe v ≤ poidsChemin poids source c := by
  -- On démontre l'inégalité depuis un départ quelconque, puis on prend la source.
  have cle : ∀ (c : List V) (u w : V), c.getLast? = some w →
      fixe w ≤ fixe u + poidsChemin poids u c := by
    intro c
    induction c with
    | nil => intro u w hw; simp at hw
    | cons z r ih =>
        intro u w hw
        rcases r with _ | ⟨z', r'⟩
        · -- Le chemin s'arrête sur `z` : une seule arête depuis `u`.
          simp only [List.getLast?_singleton, Option.some.injEq] at hw
          subst hw
          rw [poidsChemin, poidsChemin]
          have := hrelache u z
          omega
        · -- Le dernier sommet est celui de la suite du chemin.
          have hw' : (z' :: r').getLast? = some w := by
            rwa [List.getLast?_cons_cons] at hw
          have hrec := ih z w hw'
          have hu := hrelache u z
          rw [show poidsChemin poids u (z :: z' :: r')
                = poids u z + poidsChemin poids z (z' :: r') from rfl]
          omega
  have := cle c source v hc
  omega

end Lycee.Nsi
