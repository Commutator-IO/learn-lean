/-
Lycée — spécialité NSI, section « Algorithmes sur les tableaux ».
Ce fichier écrit les algorithmes du programme — recherche séquentielle, recherche
dichotomique, tris par insertion, par sélection et par fusion — puis démontre pour
chacun les deux choses qu'on lui demande : qu'il rende le bon résultat, et combien il
coûte. Les coûts sont comptés par une fonction écrite à côté de l'algorithme, qui
compte les comparaisons ; c'est ce qui permet d'en parler sans arrondir.
Énoncés et démonstrations en français : voir Informatique.tex.
-/
import Mathlib

namespace Lycee.Nsi

variable {α : Type*}

/-! ## Recherche séquentielle -/

/-- La recherche séquentielle : on parcourt le tableau du début à la fin et l'on rend
l'indice de la première case qui contient la valeur cherchée, ou rien. -/
def rechercheSequentielle [DecidableEq α] (x : α) : List α → Option ℕ
  | [] => none
  | a :: r => if a = x then some 0 else (rechercheSequentielle x r).map (· + 1)

/-- La recherche séquentielle est correcte : quand elle rend un indice, la case
correspondante contient bien la valeur cherchée ; quand elle ne rend rien, la valeur
n'est pas dans le tableau. Les deux moitiés sont nécessaires — un programme qui
répond toujours « absent » satisfait la première seule. -/
theorem recherche_sequentielle_correcte [DecidableEq α] (x : α) (t : List α) :
    (∀ i, rechercheSequentielle x t = some i → t[i]? = some x) ∧
      (rechercheSequentielle x t = none → x ∉ t) := by
  induction t with
  | nil => simp [rechercheSequentielle]
  | cons a r ih =>
      obtain ⟨ih1, ih2⟩ := ih
      by_cases h : a = x
      · subst h
        simp [rechercheSequentielle]
      · simp only [rechercheSequentielle, if_neg h]
        refine ⟨fun i hi => ?_, fun hn => ?_⟩
        · rcases hopt : rechercheSequentielle x r with _ | j
          · rw [hopt] at hi; simp at hi
          · rw [hopt] at hi
            simp at hi
            subst hi
            simpa using ih1 j hopt
        · rcases hopt : rechercheSequentielle x r with _ | j
          · simp only [List.mem_cons, not_or]
            exact ⟨fun hx => h hx.symm, ih2 hopt⟩
          · rw [hopt] at hn; simp at hn

/-- Le nombre de comparaisons que fait la recherche séquentielle : une par case
examinée, et l'on s'arrête dès qu'on a trouvé. -/
def coutRechercheSequentielle [DecidableEq α] (x : α) : List α → ℕ
  | [] => 0
  | a :: r => if a = x then 1 else 1 + coutRechercheSequentielle x r

/-- Le coût de la recherche séquentielle est d'au plus `n` comparaisons, et ce pire
cas est atteint : quand la valeur est absente, il faut examiner toutes les cases pour
pouvoir l'affirmer. -/
theorem cout_recherche_sequentielle [DecidableEq α] (x : α) (t : List α) :
    coutRechercheSequentielle x t ≤ t.length ∧
      (x ∉ t → coutRechercheSequentielle x t = t.length) := by
  induction t with
  | nil => simp [coutRechercheSequentielle]
  | cons a r ih =>
      obtain ⟨ih1, ih2⟩ := ih
      by_cases h : a = x
      · simp [coutRechercheSequentielle, h]
      · simp only [coutRechercheSequentielle, if_neg h, List.length_cons, List.mem_cons,
          not_or]
        exact ⟨by omega, fun hx => by rw [ih2 hx.2]; omega⟩

/-! ## Maximum d'un tableau -/

/-- Le maximum, calculé en un parcours : on garde le plus grand élément vu jusque-là.
Le premier élément sert d'initialisation, ce qui impose que le tableau soit non vide
— un tableau vide n'a pas de maximum, et la signature le dit. -/
def maxListe [LinearOrder α] : α → List α → α
  | m, [] => m
  | m, a :: r => maxListe (max m a) r

/-- Le maximum d'un tableau non vide est bien un élément du tableau, et il majore
tous les autres. Là encore les deux moitiés sont nécessaires : sans la première, une
fonction qui rend un nombre très grand conviendrait. -/
theorem maximum_d_un_tableau_non_vide [LinearOrder α] (a : α) (r : List α) :
    maxListe a r ∈ a :: r ∧ ∀ y ∈ a :: r, y ≤ maxListe a r := by
  induction r generalizing a with
  | nil => simp [maxListe]
  | cons b s ih =>
      obtain ⟨ihmem, ihmaj⟩ := ih (max a b)
      rw [maxListe]
      constructor
      · -- L'élément gardé est soit `a`, soit `b`, soit un élément de `s`.
        rcases List.mem_cons.1 ihmem with hm | hm
        · rcases max_cases a b with ⟨he, _⟩ | ⟨he, _⟩
          · exact List.mem_cons.2 (Or.inl (hm.trans he))
          · exact List.mem_cons.2 (Or.inr (List.mem_cons.2 (Or.inl (hm.trans he))))
        · exact List.mem_cons.2 (Or.inr (List.mem_cons.2 (Or.inr hm)))
      · intro y hy
        rcases List.mem_cons.1 hy with hy | hy
        · exact hy ▸ (le_max_left a b).trans (ihmaj _ (by simp))
        rcases List.mem_cons.1 hy with hy | hy
        · exact hy ▸ (le_max_right a b).trans (ihmaj _ (by simp))
        · exact ihmaj y (List.mem_cons.2 (Or.inr hy))

/-! ## Recherche dichotomique -/

/-- La recherche dichotomique dans un tableau trié. Le tableau est ici donné par la
fonction `t` qui à un indice associe sa valeur, et l'on cherche dans la tranche
d'indices `[lo, hi[` : c'est exactement ce qu'on écrit en machine, où les deux bornes
sont deux variables qui se rapprochent.

On compare la valeur du milieu à celle qu'on cherche, et l'on ne garde que la moitié
où elle peut encore se trouver. La terminaison tient à ce que `hi − lo` diminue
strictement à chaque appel : c'est le variant de la boucle. -/
def dichotomie [LinearOrder α] (t : ℕ → α) (x : α) (lo hi : ℕ) : Option ℕ :=
  if h : lo < hi then
    if t ((lo + hi) / 2) = x then some ((lo + hi) / 2)
    else if t ((lo + hi) / 2) < x then dichotomie t x ((lo + hi) / 2 + 1) hi
    else dichotomie t x lo ((lo + hi) / 2)
  else none
termination_by hi - lo
decreasing_by all_goals omega

/-- Quand la recherche dichotomique rend un indice, cette case contient bien la
valeur cherchée. Cette moitié-là ne demande pas que le tableau soit trié : on ne rend
un indice qu'après avoir comparé, et vu l'égalité. -/
theorem dichotomie_trouve [LinearOrder α] (t : ℕ → α) (x : α) :
    ∀ d lo hi m, hi - lo ≤ d → dichotomie t x lo hi = some m → t m = x := by
  intro d
  induction d with
  | zero =>
      intro lo hi m hd h
      rw [dichotomie, dif_neg (by omega)] at h
      simp at h
  | succ k ih =>
      intro lo hi m hd h
      rw [dichotomie] at h
      by_cases hlt : lo < hi
      · rw [dif_pos hlt] at h
        by_cases he : t ((lo + hi) / 2) = x
        · rw [if_pos he] at h
          simp only [Option.some.injEq] at h
          exact h ▸ he
        · rw [if_neg he] at h
          by_cases hinf : t ((lo + hi) / 2) < x
          · rw [if_pos hinf] at h
            exact ih _ _ _ (by omega) h
          · rw [if_neg hinf] at h
            exact ih _ _ _ (by omega) h
      · rw [dif_neg hlt] at h
        simp at h

/-- Quand la recherche dichotomique ne rend rien, la valeur est absente de la tranche
examinée. C'est ici que le tri sert, et c'est tout ce qu'il sert : si la valeur du
milieu est trop petite, celles qui la précèdent le sont aussi et l'on peut jeter
toute la moitié gauche sans la regarder. Sur un tableau non trié, l'algorithme
répondrait « absent » à tort. -/
theorem dichotomie_absent [LinearOrder α] (t : ℕ → α) (x : α) (n : ℕ)
    (htri : ∀ i j, i ≤ j → j < n → t i ≤ t j) :
    ∀ d lo hi, hi ≤ n → hi - lo ≤ d → dichotomie t x lo hi = none →
      ∀ i, lo ≤ i → i < hi → t i ≠ x := by
  intro d
  induction d with
  | zero =>
      intro lo hi _ hd _ i hi1 hi2
      omega
  | succ k ih =>
      intro lo hi hn hd h i hi1 hi2
      rw [dichotomie] at h
      have hlt : lo < hi := by omega
      rw [dif_pos hlt] at h
      have hm1 : lo ≤ (lo + hi) / 2 := by omega
      have hm2 : (lo + hi) / 2 < hi := by omega
      by_cases he : t ((lo + hi) / 2) = x
      · rw [if_pos he] at h; simp at h
      · rw [if_neg he] at h
        by_cases hinf : t ((lo + hi) / 2) < x
        · -- La valeur du milieu est trop petite : la moitié gauche l'est aussi.
          rw [if_pos hinf] at h
          by_cases hcas : (lo + hi) / 2 < i
          · exact ih _ _ hn (by omega) h i (by omega) hi2
          · have : t i ≤ t ((lo + hi) / 2) := htri i _ (by omega) (by omega)
            exact (lt_of_le_of_lt this hinf).ne
        · -- La valeur du milieu est trop grande : la moitié droite l'est aussi.
          rw [if_neg hinf] at h
          have hsup : x < t ((lo + hi) / 2) := lt_of_le_of_ne (not_lt.1 hinf) (Ne.symm he)
          by_cases hcas : i < (lo + hi) / 2
          · exact ih _ _ (by omega) (by omega) h i hi1 hcas
          · have : t ((lo + hi) / 2) ≤ t i := htri _ i (by omega) (by omega)
            exact (lt_of_lt_of_le hsup this).ne'

/-- Le nombre de comparaisons que fait la recherche dichotomique dans le pire des
cas : une par appel, et l'on continue dans la moitié la plus coûteuse. -/
def coutDichotomie (lo hi : ℕ) : ℕ :=
  if h : lo < hi then
    1 + max (coutDichotomie ((lo + hi) / 2 + 1) hi) (coutDichotomie lo ((lo + hi) / 2))
  else 0
termination_by hi - lo
decreasing_by all_goals omega

/-- La recherche dichotomique fait au plus `⌊log₂ n⌋ + 1` comparaisons sur une
tranche de `n` cases : chaque comparaison divise par deux le nombre de cases encore
possibles, et l'on ne peut diviser par deux qu'un nombre logarithmique de fois. C'est
tout l'intérêt du tri préalable : `20` comparaisons suffisent pour un million de
cases, contre un million pour la recherche séquentielle. -/
theorem cout_recherche_dichotomique :
    ∀ d lo hi, hi - lo ≤ d → coutDichotomie lo hi ≤ Nat.log 2 (hi - lo) + 1 := by
  intro d
  induction d with
  | zero =>
      intro lo hi hd
      rw [coutDichotomie, dif_neg (by omega)]
      omega
  | succ k ih =>
      intro lo hi hd
      rw [coutDichotomie]
      by_cases hlt : lo < hi
      · rw [dif_pos hlt]
        -- Les deux moitiés ont chacune au plus `(hi − lo)/2` cases.
        have hg : (lo + hi) / 2 - lo ≤ (hi - lo) / 2 := by omega
        have hdte : hi - ((lo + hi) / 2 + 1) ≤ (hi - lo) / 2 := by omega
        by_cases hun : hi - lo = 1
        · -- Une seule case : une comparaison, et les deux moitiés sont vides.
          have h1 : (lo + hi) / 2 = lo := by omega
          rw [h1, hun]
          rw [coutDichotomie, dif_neg (by omega), coutDichotomie, dif_neg (by omega)]
          simp
        · have hdeux : 2 ≤ hi - lo := by omega
          have hig := ih lo ((lo + hi) / 2) (by omega)
          have hid := ih ((lo + hi) / 2 + 1) hi (by omega)
          have hlog : Nat.log 2 (hi - lo) = Nat.log 2 ((hi - lo) / 2) + 1 := by
            have hpos : 0 < Nat.log 2 (hi - lo) := Nat.log_pos (by norm_num) hdeux
            have := Nat.log_div_base 2 (hi - lo)
            omega
          have hmg : Nat.log 2 ((lo + hi) / 2 - lo) ≤ Nat.log 2 ((hi - lo) / 2) :=
            Nat.log_mono_right hg
          have hmd : Nat.log 2 (hi - ((lo + hi) / 2 + 1)) ≤ Nat.log 2 ((hi - lo) / 2) :=
            Nat.log_mono_right hdte
          omega
      · rw [dif_neg hlt]
        omega

/-! ## Tri par insertion -/

/-- L'insertion d'un élément dans une liste déjà triée : on descend jusqu'à la
première place où il n'est pas trop grand, et on l'y pose. -/
def insere [LinearOrder α] (x : α) : List α → List α
  | [] => [x]
  | a :: r => if x ≤ a then x :: a :: r else a :: insere x r

/-- Le tri par insertion : on trie la fin du tableau, puis on insère le premier
élément à sa place. -/
def triInsertion [LinearOrder α] : List α → List α
  | [] => []
  | a :: r => insere a (triInsertion r)

/-- L'insertion ne perd ni n'invente d'élément : la liste obtenue est une permutation
de la liste de départ augmentée de l'élément inséré. -/
theorem insere_permutation [LinearOrder α] (x : α) (l : List α) :
    (insere x l).Perm (x :: l) := by
  induction l with
  | nil => simp [insere]
  | cons a r ih =>
      by_cases h : x ≤ a
      · simp [insere, h]
      · rw [insere, if_neg h]
        exact (ih.cons a).trans (List.Perm.swap x a r)

/-- Les éléments de la liste après insertion sont ceux d'avant, plus l'inséré. -/
theorem mem_insere [LinearOrder α] (x y : α) (l : List α) :
    y ∈ insere x l ↔ y = x ∨ y ∈ l :=
  ⟨fun h => by simpa using (insere_permutation x l).mem_iff.1 h,
   fun h => (insere_permutation x l).mem_iff.2 (by simpa using h)⟩

/-- L'insertion dans une liste triée rend une liste triée : c'est l'unique chose à
vérifier, puisque le tri se contente de l'appliquer élément par élément. -/
theorem insere_trie [LinearOrder α] (x : α) (l : List α) (hl : l.Pairwise (· ≤ ·)) :
    (insere x l).Pairwise (· ≤ ·) := by
  induction l with
  | nil => simp [insere]
  | cons a r ih =>
      rw [List.pairwise_cons] at hl
      obtain ⟨hmaj, htri⟩ := hl
      by_cases h : x ≤ a
      · rw [insere, if_pos h, List.pairwise_cons]
        refine ⟨?_, by rw [List.pairwise_cons]; exact ⟨hmaj, htri⟩⟩
        intro b hb
        rcases List.mem_cons.1 hb with hb | hb
        · exact hb ▸ h
        · exact h.trans (hmaj b hb)
      · rw [insere, if_neg h, List.pairwise_cons]
        refine ⟨?_, ih htri⟩
        intro b hb
        rcases (mem_insere x b r).1 hb with hb | hb
        · exact hb ▸ (not_le.1 h).le
        · exact hmaj b hb

/-- Le tri par insertion est correct : son résultat est trié, et c'est une
permutation de l'entrée. Les deux moitiés sont nécessaires — la liste vide est triée,
et la liste de départ est une permutation d'elle-même. -/
theorem tri_par_insertion_correct [LinearOrder α] (t : List α) :
    (triInsertion t).Pairwise (· ≤ ·) ∧ (triInsertion t).Perm t := by
  induction t with
  | nil => simp [triInsertion]
  | cons a r ih =>
      obtain ⟨htri, hperm⟩ := ih
      rw [triInsertion]
      exact ⟨insere_trie a _ htri,
        (insere_permutation a (triInsertion r)).trans (hperm.cons a)⟩

/-! ## Tri par sélection -/

/-- L'extraction du minimum : on parcourt la liste en gardant le plus petit élément
vu, et l'on rend ce minimum accompagné de tous les autres éléments. -/
def extraitMin [LinearOrder α] : α → List α → α × List α
  | m, [] => (m, [])
  | m, a :: r =>
      if a < m then ((extraitMin a r).1, m :: (extraitMin a r).2)
      else ((extraitMin m r).1, a :: (extraitMin m r).2)

/-- L'extraction rend autant d'éléments qu'elle en a reçu, moins le minimum : c'est
ce qui fait que le tri par sélection termine. -/
theorem extrait_min_longueur [LinearOrder α] (m : α) (l : List α) :
    (extraitMin m l).2.length = l.length := by
  induction l generalizing m with
  | nil => simp [extraitMin]
  | cons a r ih =>
      by_cases h : a < m <;> simp [extraitMin, h, ih]

/-- Le tri par sélection : on extrait le minimum, on le pose en tête, et l'on
recommence sur le reste. La récursion ne porte pas sur un sous-terme mais sur une
liste de longueur strictement plus petite : il faut le dire à Lean. -/
def triSelection [LinearOrder α] : List α → List α
  | [] => []
  | a :: r => (extraitMin a r).1 :: triSelection (extraitMin a r).2
termination_by l => l.length
decreasing_by simp [extrait_min_longueur]

/-- L'extraction ne perd ni n'invente d'élément. -/
theorem extrait_min_permutation [LinearOrder α] (m : α) (l : List α) :
    ((extraitMin m l).1 :: (extraitMin m l).2).Perm (m :: l) := by
  induction l generalizing m with
  | nil => simp [extraitMin]
  | cons a r ih =>
      by_cases h : a < m
      · rw [extraitMin, if_pos h]
        exact (List.Perm.swap m _ _).trans ((ih a).cons m)
      · rw [extraitMin, if_neg h]
        exact ((List.Perm.swap a _ _).trans ((ih m).cons a)).trans (List.Perm.swap m a r)

/-- Le minimum extrait minore effectivement tous les éléments reçus. -/
theorem extrait_min_minore [LinearOrder α] (m : α) (l : List α) :
    ∀ y ∈ m :: l, (extraitMin m l).1 ≤ y := by
  induction l generalizing m with
  | nil => simp [extraitMin]
  | cons a r ih =>
      intro y hy
      by_cases h : a < m
      · rw [extraitMin, if_pos h]
        rcases List.mem_cons.1 hy with hym | hy
        · rw [hym]
          exact (ih a a (by simp)).trans (le_of_lt h)
        · exact ih a y hy
      · rw [extraitMin, if_neg h]
        rcases List.mem_cons.1 hy with hym | hy
        · rw [hym]
          exact ih m m (by simp)
        · rcases List.mem_cons.1 hy with hya | hy
          · rw [hya]
            exact (ih m m (by simp)).trans (not_lt.1 h)
          · exact ih m y (List.mem_cons.2 (Or.inr hy))

/-- Le tri par sélection est correct : même énoncé que pour le tri par insertion, et
c'est le point de l'exercice — deux programmes de structures très différentes
satisfont la même spécification. -/
theorem tri_par_selection_correct [LinearOrder α] (t : List α) :
    (triSelection t).Pairwise (· ≤ ·) ∧ (triSelection t).Perm t := by
  induction t using triSelection.induct with
  | case1 => simp [triSelection]
  | case2 a r ih =>
      obtain ⟨htri, hperm⟩ := ih
      rw [triSelection, List.pairwise_cons]
      have hp := extrait_min_permutation a r
      refine ⟨⟨?_, htri⟩, ?_⟩
      · intro b hb
        have hb' : b ∈ (extraitMin a r).2 := hperm.mem_iff.1 hb
        exact extrait_min_minore a r b (hp.mem_iff.1 (List.mem_cons.2 (Or.inr hb')))
      · exact (hperm.cons _).trans hp

/-! ## Coût des tris quadratiques -/

/-- Le nombre de comparaisons que fait une insertion. -/
def coutInsere [LinearOrder α] (x : α) : List α → ℕ
  | [] => 0
  | a :: r => if x ≤ a then 1 else 1 + coutInsere x r

/-- Le nombre de comparaisons que fait le tri par insertion. -/
def coutTriInsertion [LinearOrder α] : List α → ℕ
  | [] => 0
  | a :: r => coutTriInsertion r + coutInsere a (triInsertion r)

/-- Une insertion coûte au plus la longueur de la liste où l'on insère. -/
theorem cout_insere_majore [LinearOrder α] (x : α) (l : List α) :
    coutInsere x l ≤ l.length := by
  induction l with
  | nil => simp [coutInsere]
  | cons a r ih =>
      by_cases h : x ≤ a
      · simp [coutInsere, h]
      · simp only [coutInsere, if_neg h, List.length_cons]
        omega

/-- Le tri par insertion fait au plus `n(n−1)/2` comparaisons. L'inégalité est écrite
sous la forme `2c + n ≤ n²` pour éviter à la fois la division et la soustraction
tronquée des entiers naturels. -/
theorem cout_quadratique_tri_par_insertion [LinearOrder α] (t : List α) :
    2 * coutTriInsertion t + t.length ≤ t.length * t.length := by
  induction t with
  | nil => simp [coutTriInsertion]
  | cons a r ih =>
      rw [coutTriInsertion, List.length_cons]
      have hlen : (triInsertion r).length = r.length :=
        (tri_par_insertion_correct r).2.length_eq
      have hmaj : coutInsere a (triInsertion r) ≤ r.length := by
        rw [← hlen]; exact cout_insere_majore a (triInsertion r)
      have : (r.length + 1) * (r.length + 1) = r.length * r.length + 2 * r.length + 1 := by
        ring
      omega

/-- Une liste strictement décroissante : `n, n−1, …, 1`. C'est le pire cas du tri par
insertion, puisque chaque élément inséré est plus grand que tous ceux déjà triés et
doit donc les traverser tous. -/
def listeDecroissante : ℕ → List ℕ
  | 0 => []
  | n + 1 => (n + 1) :: listeDecroissante n

/-- Une insertion parcourt toute la liste quand l'élément inséré est plus grand que
tous les autres. -/
theorem cout_insere_atteint (x : ℕ) (l : List ℕ) (h : ∀ y ∈ l, y < x) :
    coutInsere x l = l.length := by
  induction l with
  | nil => simp [coutInsere]
  | cons a r ih =>
      have ha : ¬ x ≤ a := by have := h a (by simp); omega
      rw [coutInsere, if_neg ha, List.length_cons, ih (fun y hy => h y (by simp [hy]))]
      omega

/-- Les éléments de `listeDecroissante n` sont les entiers de `1` à `n`. -/
theorem mem_liste_decroissante (n y : ℕ) (h : y ∈ listeDecroissante n) : 1 ≤ y ∧ y ≤ n := by
  induction n with
  | zero => simp [listeDecroissante] at h
  | succ k ih =>
      rcases List.mem_cons.1 h with h | h
      · omega
      · have := ih h; omega

/-- La longueur de `listeDecroissante n` est `n`. -/
theorem longueur_liste_decroissante (n : ℕ) : (listeDecroissante n).length = n := by
  induction n with
  | zero => simp [listeDecroissante]
  | succ k ih => simp [listeDecroissante, ih]

/-- Le pire cas quadratique est atteint : sur une liste strictement décroissante, le
tri par insertion fait exactement `n(n−1)/2` comparaisons. La majoration précédente
n'est donc pas améliorable. -/
theorem cout_quadratique_atteint (n : ℕ) :
    2 * coutTriInsertion (listeDecroissante n) + n = n * n := by
  induction n with
  | zero => simp [listeDecroissante, coutTriInsertion]
  | succ k ih =>
      rw [listeDecroissante, coutTriInsertion]
      have hlen : (triInsertion (listeDecroissante k)).length = k := by
        rw [(tri_par_insertion_correct (listeDecroissante k)).2.length_eq]
        exact longueur_liste_decroissante k
      have hmaj : ∀ y ∈ triInsertion (listeDecroissante k), y < k + 1 := by
        intro y hy
        have := mem_liste_decroissante k y
          ((tri_par_insertion_correct (listeDecroissante k)).2.mem_iff.1 hy)
        omega
      rw [cout_insere_atteint _ _ hmaj, hlen]
      have : (k + 1) * (k + 1) = k * k + 2 * k + 1 := by ring
      omega

/-! ## Tri fusion -/

/-- La fusion de deux listes triées : on compare les deux têtes et l'on prend la plus
petite. La récursion porte sur la somme des deux longueurs, qui diminue à chaque
appel. -/
def fusion [LinearOrder α] : List α → List α → List α
  | [], l => l
  | l, [] => l
  | a :: r, b :: s => if a ≤ b then a :: fusion r (b :: s) else b :: fusion (a :: r) s
termination_by l1 l2 => l1.length + l2.length

/-- La fusion ne perd ni n'invente d'élément. -/
theorem fusion_permutation [LinearOrder α] (l1 l2 : List α) :
    (fusion l1 l2).Perm (l1 ++ l2) := by
  induction l1, l2 using fusion.induct with
  | case1 l => simp [fusion]
  | case2 l => simp [fusion]
  | case3 a r b s h ih =>
      rw [fusion, if_pos h]
      exact (ih.cons a)
  | case4 a r b s h ih =>
      rw [fusion, if_neg h]
      refine List.Perm.trans (ih.cons b) ?_
      exact (List.perm_middle).symm

/-- La fusion de deux listes triées est triée. -/
theorem fusion_triee [LinearOrder α] (l1 l2 : List α)
    (h1 : l1.Pairwise (· ≤ ·)) (h2 : l2.Pairwise (· ≤ ·)) :
    (fusion l1 l2).Pairwise (· ≤ ·) := by
  induction l1, l2 using fusion.induct with
  | case1 l => simpa [fusion] using h2
  | case2 l => simpa [fusion] using h1
  | case3 a r b s h ih =>
      rw [List.pairwise_cons] at h1
      rw [fusion, if_pos h, List.pairwise_cons]
      refine ⟨?_, ih h1.2 h2⟩
      intro y hy
      have := (fusion_permutation r (b :: s)).mem_iff.1 hy
      rcases List.mem_append.1 this with hy | hy
      · exact h1.1 y hy
      · rcases List.mem_cons.1 hy with hy | hy
        · exact hy ▸ h
        · exact h.trans ((List.pairwise_cons.1 h2).1 y hy)
  | case4 a r b s h ih =>
      rw [List.pairwise_cons] at h2
      rw [fusion, if_neg h, List.pairwise_cons]
      refine ⟨?_, ih h1 h2.2⟩
      intro y hy
      have := (fusion_permutation (a :: r) s).mem_iff.1 hy
      rcases List.mem_append.1 this with hy | hy
      · rcases List.mem_cons.1 hy with hy | hy
        · exact hy ▸ (not_le.1 h).le
        · exact ((not_le.1 h).le).trans ((List.pairwise_cons.1 h1).1 y hy)
      · exact h2.1 y hy

/-- Le tri fusion : on coupe la liste en deux moitiés, on trie chacune, on fusionne.
La récursion porte sur la longueur ; couper au milieu ne suffit pas à la faire
diminuer si la liste a moins de deux éléments, d'où les deux cas de base. -/
def triFusion [LinearOrder α] : List α → List α
  | [] => []
  | [a] => [a]
  | a :: b :: r =>
      fusion (triFusion ((a :: b :: r).take ((r.length + 2) / 2)))
        (triFusion ((a :: b :: r).drop ((r.length + 2) / 2)))
termination_by l => l.length
decreasing_by
  · simp only [List.length_take, List.length_cons]; omega
  · simp only [List.length_drop, List.length_cons]; omega

/-- Le tri fusion est correct : son résultat est trié, et c'est une permutation de
l'entrée. La démonstration se ramène aux deux propriétés de la fusion, et à ce que
recoller les deux moitiés redonne la liste de départ. -/
theorem tri_fusion_correct [LinearOrder α] (t : List α) :
    (triFusion t).Pairwise (· ≤ ·) ∧ (triFusion t).Perm t := by
  induction t using triFusion.induct with
  | case1 => simp [triFusion]
  | case2 a => simp [triFusion]
  | case3 a b r ihg ihd =>
      obtain ⟨htg, hpg⟩ := ihg
      obtain ⟨htd, hpd⟩ := ihd
      rw [triFusion]
      refine ⟨fusion_triee _ _ htg htd, ?_⟩
      refine (fusion_permutation _ _).trans ?_
      refine ((hpg.append hpd).trans ?_)
      rw [List.take_append_drop]

/-- Trier ne change pas le nombre d'éléments. -/
theorem longueur_tri_fusion [LinearOrder α] (l : List α) :
    (triFusion l).length = l.length :=
  (tri_fusion_correct l).2.length_eq

/-- Le nombre de comparaisons que fait la fusion : une par tour, et l'on s'arrête dès
qu'une des deux listes est épuisée — la fin de l'autre est recopiée sans comparaison. -/
def coutFusion [LinearOrder α] : List α → List α → ℕ
  | [], _ => 0
  | _, [] => 0
  | a :: r, b :: s => 1 + if a ≤ b then coutFusion r (b :: s) else coutFusion (a :: r) s
termination_by l1 l2 => l1.length + l2.length

/-- La fusion est linéaire : elle fait au plus autant de comparaisons que la somme des
longueurs. C'est ce qui rend le tri fusion intéressant — le recollement ne coûte pas
plus cher qu'un parcours. -/
theorem cout_fusion_lineaire [LinearOrder α] (l1 l2 : List α) :
    coutFusion l1 l2 ≤ l1.length + l2.length := by
  induction l1, l2 using coutFusion.induct with
  | case1 l => simp [coutFusion]
  | case2 l => simp [coutFusion]
  | case3 a r b s ihg ihd =>
      -- Un tour consomme une tête ou l'autre : les deux cas se majorent de même.
      rw [coutFusion]
      simp only [List.length_cons] at ihg ihd ⊢
      split <;> omega

/-- Le nombre de comparaisons que fait le tri fusion : celles des deux moitiés, plus
celles du recollement. -/
def coutTriFusion [LinearOrder α] : List α → ℕ
  | [] => 0
  | [_] => 0
  | a :: b :: r =>
      coutTriFusion ((a :: b :: r).take ((r.length + 2) / 2)) +
        coutTriFusion ((a :: b :: r).drop ((r.length + 2) / 2)) +
        coutFusion (triFusion ((a :: b :: r).take ((r.length + 2) / 2)))
          (triFusion ((a :: b :: r).drop ((r.length + 2) / 2)))
termination_by l => l.length
decreasing_by
  · simp only [List.length_take, List.length_cons]; omega
  · simp only [List.length_drop, List.length_cons]; omega

/-- Le tri fusion coûte `n log₂ n` comparaisons : au plus `n ⌈log₂ n⌉`.

C'est la résolution de `T(n) = 2T(n/2) + n` faite sur le programme lui-même, et non
sur la seule récurrence : il y a `⌈log₂ n⌉` étages de découpe, et les recollements
d'un même étage portent ensemble sur les `n` éléments, d'où `n` par étage.

Le logarithme est ici arrondi par excès, ce qui est nécessaire : pour `n = 3`, on
découpe en `1` et `2`, et il faut bien deux étages. -/
theorem cout_tri_fusion [LinearOrder α] (t : List α) :
    coutTriFusion t ≤ t.length * Nat.clog 2 t.length := by
  induction t using coutTriFusion.induct with
  | case1 => simp [coutTriFusion]
  | case2 a => simp [coutTriFusion]
  | case3 a b r ihg ihd =>
      rw [coutTriFusion]
      -- Les deux moitiés ont `⌊n/2⌋` et `⌈n/2⌉` éléments.
      have hlen : (a :: b :: r).length = r.length + 2 := by simp
      have htake : ((a :: b :: r).take ((r.length + 2) / 2)).length
          = (r.length + 2) / 2 := by
        rw [List.length_take, hlen]; omega
      have hdrop : ((a :: b :: r).drop ((r.length + 2) / 2)).length
          = r.length + 2 - (r.length + 2) / 2 := by
        rw [List.length_drop, hlen]
      rw [htake] at ihg
      rw [hdrop] at ihd
      -- Le recollement coûte au plus `n` comparaisons.
      have hfus : coutFusion (triFusion ((a :: b :: r).take ((r.length + 2) / 2)))
          (triFusion ((a :: b :: r).drop ((r.length + 2) / 2))) ≤ r.length + 2 := by
        refine (cout_fusion_lineaire _ _).trans ?_
        rw [longueur_tri_fusion, longueur_tri_fusion, htake, hdrop]
        omega
      -- Un étage de découpe de moins pour chaque moitié.
      have hclog : Nat.clog 2 (r.length + 2)
          = Nat.clog 2 ((r.length + 2 + 1) / 2) + 1 :=
        Nat.clog_of_two_le (by norm_num) (by omega)
      have hhaut : r.length + 2 - (r.length + 2) / 2 = (r.length + 2 + 1) / 2 := by omega
      have hcd : Nat.clog 2 (r.length + 2 - (r.length + 2) / 2)
          = Nat.clog 2 (r.length + 2) - 1 := by rw [hhaut, hclog]; omega
      have hcg : Nat.clog 2 ((r.length + 2) / 2) ≤ Nat.clog 2 (r.length + 2) - 1 := by
        have hle : (r.length + 2) / 2 ≤ (r.length + 2 + 1) / 2 := by omega
        have := Nat.clog_mono_right 2 hle
        omega
      -- On remplace les deux logarithmes par le même, puis on recolle.
      obtain ⟨c, hc⟩ : ∃ c, Nat.clog 2 (r.length + 2) = c + 1 := ⟨_, hclog⟩
      have hg : coutTriFusion ((a :: b :: r).take ((r.length + 2) / 2))
          ≤ (r.length + 2) / 2 * c :=
        ihg.trans (Nat.mul_le_mul_left _ (by omega))
      have hd : coutTriFusion ((a :: b :: r).drop ((r.length + 2) / 2))
          ≤ (r.length + 2 - (r.length + 2) / 2) * c :=
        ihd.trans (Nat.mul_le_mul_left _ (by omega))
      have hsomme : (r.length + 2) / 2 * c + (r.length + 2 - (r.length + 2) / 2) * c
          + (r.length + 2) = (r.length + 2) * (c + 1) := by
        have hpart : (r.length + 2) / 2 + (r.length + 2 - (r.length + 2) / 2)
            = r.length + 2 := by omega
        calc (r.length + 2) / 2 * c + (r.length + 2 - (r.length + 2) / 2) * c
              + (r.length + 2)
            = ((r.length + 2) / 2 + (r.length + 2 - (r.length + 2) / 2)) * c
              + (r.length + 2) := by ring
          _ = (r.length + 2) * c + (r.length + 2) := by rw [hpart]
          _ = (r.length + 2) * (c + 1) := by ring
      rw [hlen, hc]
      omega

/-! ## Borne inférieure des tris par comparaisons -/

/-- L'arbre des comparaisons d'un algorithme de tri : chaque nœud est une comparaison
et ses deux enfants sont les deux réponses possibles ; chaque feuille est une sortie
de l'algorithme, donc une permutation qu'il peut produire. -/
inductive ArbreComparaisons where
  | feuille : ArbreComparaisons
  | noeud : ArbreComparaisons → ArbreComparaisons → ArbreComparaisons

/-- La hauteur de l'arbre, c'est-à-dire le nombre de comparaisons du pire cas. -/
def ArbreComparaisons.hauteur : ArbreComparaisons → ℕ
  | .feuille => 0
  | .noeud g d => 1 + max g.hauteur d.hauteur

/-- Le nombre de feuilles, c'est-à-dire le nombre de résultats distincts possibles. -/
def ArbreComparaisons.feuilles : ArbreComparaisons → ℕ
  | .feuille => 1
  | .noeud g d => g.feuilles + d.feuilles

/-- Un arbre de hauteur `h` a au plus `2ʰ` feuilles : chaque comparaison ne fait au
mieux que doubler le nombre de cas qu'on sait distinguer. -/
theorem feuilles_majorees (a : ArbreComparaisons) : a.feuilles ≤ 2 ^ a.hauteur := by
  induction a with
  | feuille => simp [ArbreComparaisons.feuilles, ArbreComparaisons.hauteur]
  | noeud g d ihg ihd =>
      rw [ArbreComparaisons.feuilles, ArbreComparaisons.hauteur, pow_add, pow_one]
      have h1 : (2 : ℕ) ^ g.hauteur ≤ 2 ^ max g.hauteur d.hauteur :=
        Nat.pow_le_pow_right (by norm_num) (le_max_left _ _)
      have h2 : (2 : ℕ) ^ d.hauteur ≤ 2 ^ max g.hauteur d.hauteur :=
        Nat.pow_le_pow_right (by norm_num) (le_max_right _ _)
      omega

/-- Un tri par comparaisons demande au moins `log₂(n!)` comparaisons.

L'hypothèse `hsorties` est ce qu'on demande à l'algorithme : pour trier
correctement `n` éléments, il doit pouvoir produire chacune des `n!` permutations,
donc son arbre a au moins `n!` feuilles. Comme un arbre de hauteur `h` n'a jamais
plus de `2ʰ` feuilles, il vient `n! ≤ 2ʰ`, puis la minoration par le logarithme.

Ce que cet énoncé ne formalise pas : que tout algorithme de tri par comparaisons
s'écrive bien sous la forme d'un tel arbre. C'est une modélisation, et elle est ici
portée par l'hypothèse plutôt que passée sous silence. -/
theorem borne_inferieure_tri_par_comparaisons (n : ℕ) (a : ArbreComparaisons)
    (hsorties : Nat.factorial n ≤ a.feuilles) :
    Nat.log 2 (Nat.factorial n) ≤ a.hauteur := by
  have h : Nat.factorial n ≤ 2 ^ a.hauteur := hsorties.trans (feuilles_majorees a)
  calc Nat.log 2 (Nat.factorial n) ≤ Nat.log 2 (2 ^ a.hauteur) := Nat.log_mono_right h
    _ = a.hauteur := Nat.log_pow (by norm_num) _

end Lycee.Nsi
