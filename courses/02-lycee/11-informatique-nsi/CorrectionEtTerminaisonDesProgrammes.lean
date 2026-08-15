/-
Lycée — spécialité NSI, section « Correction et terminaison des programmes ».
Un programme n'est pas correct parce qu'il donne le bon résultat sur les exemples
essayés : il l'est parce qu'on sait dire ce qu'il conserve à chaque tour de boucle,
et pourquoi il s'arrête. Ce fichier démontre les deux outils de ce raisonnement —
l'invariant et le variant — puis s'en sert sur deux programmes du programme de
première, avant de montrer que ce raisonnement a une limite : aucun programme ne
peut décider si un autre s'arrête.
Énoncés et démonstrations en français : voir Informatique.tex.
-/
import Mathlib

namespace Lycee.Nsi

/-! ## Invariant de boucle -/

/-- Une boucle est modélisée par le corps qu'elle répète : `corps^[n] e` est l'état
obtenu après `n` tours à partir de l'état `e`.

Invariant de boucle : une propriété vraie avant la boucle et conservée par le corps
est vraie après un nombre quelconque de tours, donc en particulier à la sortie. -/
theorem invariant_de_boucle {α : Type*} (corps : α → α) (P : α → Prop)
    (hstable : ∀ x, P x → P (corps x)) (e : α) (he : P e) (n : ℕ) :
    P (corps^[n] e) := by
  induction n with
  | zero => simpa using he
  | succ k hk =>
      rw [Function.iterate_succ_apply']
      exact hstable _ hk

/-! ## Variant de boucle -/

/-- Variant de boucle : si l'on sait associer à l'état un entier naturel qui décroît
strictement à chaque tour tant que la condition est vraie, alors la condition finit
par devenir fausse — la boucle s'arrête.

C'est le seul endroit où l'on se sert de ce que ℕ n'a pas de suite infinie
strictement décroissante : un entier naturel qui diminue à chaque tour ne peut pas
diminuer indéfiniment. -/
theorem variant_de_boucle {α : Type*} (cond : α → Prop) (corps : α → α) (v : α → ℕ)
    (hdec : ∀ x, cond x → v (corps x) < v x) (e : α) :
    ∃ n, ¬ cond (corps^[n] e) := by
  -- Récurrence forte sur la valeur du variant : soit la condition est déjà fausse,
  -- soit on fait un tour, et le variant a strictement diminué.
  induction hv : v e using Nat.strong_induction_on generalizing e with
  | _ k hk =>
      by_cases hc : cond e
      · obtain ⟨n, hn⟩ := hk (v (corps e)) (hv ▸ hdec e hc) (corps e) rfl
        exact ⟨n + 1, by rwa [Function.iterate_succ_apply]⟩
      · exact ⟨0, by simpa using hc⟩

/-! ## Somme des premiers entiers par accumulation -/

/-- Le corps de la boucle qui somme les entiers un à un. L'état est le couple
`(i, s)` : `i` compte les tours, `s` accumule la somme. Un tour ajoute `i + 1` à
l'accumulateur et avance le compteur. -/
def corpsSomme (e : ℕ × ℕ) : ℕ × ℕ := (e.1 + 1, e.2 + e.1 + 1)

/-- Après `n` tours à partir de `(0, 0)`, le compteur vaut `n` et l'accumulateur vaut
`n(n+1)/2` : le programme calcule bien la somme des `n` premiers entiers.

L'invariant est l'égalité `2s = i(i+1)`, qui évite la division ; la forme
`n(n+1)/2` s'en déduit à la fin. -/
theorem somme_des_premiers_entiers_par_accumulation (n : ℕ) :
    corpsSomme^[n] (0, 0) = (n, n * (n + 1) / 2) := by
  -- On démontre d'abord l'invariant sans division.
  have inv : ∀ m : ℕ, (corpsSomme^[m] (0, 0)).1 = m ∧
      2 * (corpsSomme^[m] (0, 0)).2 = m * (m + 1) := by
    intro m
    induction m with
    | zero => simp
    | succ k hk =>
        obtain ⟨h1, h2⟩ := hk
        rw [Function.iterate_succ_apply']
        refine ⟨by simp [corpsSomme, h1], ?_⟩
        show 2 * ((corpsSomme^[k] (0, 0)).2 + (corpsSomme^[k] (0, 0)).1 + 1) = _
        rw [h1]
        calc 2 * ((corpsSomme^[k] (0, 0)).2 + k + 1)
            = 2 * (corpsSomme^[k] (0, 0)).2 + 2 * k + 2 := by ring
          _ = k * (k + 1) + 2 * k + 2 := by rw [h2]
          _ = (k + 1) * (k + 1 + 1) := by ring
    -- fin de la récurrence
  obtain ⟨h1, h2⟩ := inv n
  -- Le produit `n(n+1)` est traité comme un bloc : c'est un entier pair, dont
  -- l'accumulateur est la moitié.
  have : (corpsSomme^[n] (0, 0)).2 = n * (n + 1) / 2 := by
    set k := n * (n + 1) with hkdef
    omega
  exact Prod.ext h1 this

/-! ## Division euclidienne par soustractions successives -/

/-- La division par soustractions successives : tant que le dividende est au moins
égal au diviseur, on retranche le diviseur et l'on compte un quotient de plus.

La récursion termine parce que `a - b < a` dès que `0 < b ≤ a` : la valeur du
dividende est le variant de la boucle. -/
def divSoustractions (a b : ℕ) : ℕ × ℕ :=
  if _h : 0 < b ∧ b ≤ a then
    let (q, r) := divSoustractions (a - b) b
    (q + 1, r)
  else (0, a)
termination_by a
decreasing_by omega

/-- Le programme rend bien le quotient et le reste : le quotient multiplié par le
diviseur, plus le reste, redonne le dividende, et le reste est strictement plus petit
que le diviseur. -/
theorem division_euclidienne_par_soustractions (b : ℕ) (hb : 0 < b) (a : ℕ) :
    (divSoustractions a b).1 * b + (divSoustractions a b).2 = a ∧
      (divSoustractions a b).2 < b := by
  induction a using Nat.strong_induction_on with
  | _ a hrec =>
      rw [divSoustractions]
      by_cases h : 0 < b ∧ b ≤ a
      · obtain ⟨hq, hr⟩ := hrec (a - b) (by omega)
        simp only [h]
        constructor
        · show ((divSoustractions (a - b) b).1 + 1) * b + (divSoustractions (a - b) b).2 = a
          have : (divSoustractions (a - b) b).1 * b + (divSoustractions (a - b) b).2 = a - b := hq
          have hba : b ≤ a := h.2
          calc ((divSoustractions (a - b) b).1 + 1) * b + (divSoustractions (a - b) b).2
              = ((divSoustractions (a - b) b).1 * b + (divSoustractions (a - b) b).2) + b := by ring
            _ = (a - b) + b := by rw [this]
            _ = a := by omega
        · exact hr
      · simp only [h, dif_neg, not_false_eq_true]
        omega

/-! ## Deux programmes pour une même fonction -/

/-- La même somme, écrite récursivement : la structure du programme n'a rien à voir
avec la précédente — pas de boucle, pas d'accumulateur. -/
def sommeRecursive : ℕ → ℕ
  | 0 => 0
  | n + 1 => sommeRecursive n + (n + 1)

/-- Deux programmes de structures différentes calculent la même fonction : la boucle
avec accumulateur et la définition récursive rendent la même valeur pour toute
entrée. C'est le sens qu'on donne à « ces deux programmes sont corrects » : ils ne
se ressemblent pas, ils calculent la même chose. -/
theorem deux_programmes_calculent_la_meme_fonction (n : ℕ) :
    sommeRecursive n = (corpsSomme^[n] (0, 0)).2 := by
  induction n with
  | zero => simp [sommeRecursive]
  | succ k hk =>
      rw [Function.iterate_succ_apply', sommeRecursive, hk]
      have h1 : (corpsSomme^[k] (0, 0)).1 = k := by
        have := somme_des_premiers_entiers_par_accumulation k
        rw [this]
      show (corpsSomme^[k] (0, 0)).2 + (k + 1) = (corpsSomme^[k] (0, 0)).2 + (corpsSomme^[k] (0, 0)).1 + 1
      rw [h1]
      omega

/-! ## Indécidabilité du problème de l'arrêt -/

/-- Le problème de l'arrêt est indécidable.

On se donne un langage de programmation abstrait : `arrete p e` signifie que le
programme `p` s'arrête sur l'entrée `e`, et tout programme peut être donné en entrée
à un autre — c'est le cas dans un vrai langage, où un programme est un fichier
texte.

L'hypothèse `hdiagonal` est l'unique chose qu'on demande au langage : supposer qu'un
programme décide l'arrêt permet d'en écrire un autre, le programme diagonal, qui
s'arrête sur `p` exactement quand `p` ne s'arrête pas sur lui-même — il suffit
d'appeler le décideur et de boucler exprès quand il répond « oui ». La contradiction
est alors immédiate, en appliquant le programme diagonal à lui-même.

Ce que cet énoncé ne formalise pas : que ce programme diagonal soit effectivement
écrivable. C'est la partie qui demande un modèle de calcul — machines de Turing,
fonctions récursives — et qui dépasse le programme de terminale ; elle est ici
portée par l'hypothèse, énoncée en toutes lettres plutôt que passée sous silence. -/
theorem indecidabilite_du_probleme_de_l_arret {Programme : Type*}
    (arrete : Programme → Programme → Prop) (diagonal : Programme)
    (hdiagonal : ∀ p, arrete diagonal p ↔ ¬ arrete p p) : False := by
  -- Le programme diagonal, appliqué à lui-même : il s'arrête si et seulement s'il
  -- ne s'arrête pas.
  have h := hdiagonal diagonal
  tauto

end Lycee.Nsi
