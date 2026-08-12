/-
Collège — section « Algorithmique et programmation ».
Un programme est ici une suite d'instructions agissant sur la valeur d'une variable.
Énoncés et démonstrations en français : voir AlgorithmiqueEtProgrammation.tex.
-/
import Mathlib

namespace College.Algorithmique

/-! ## Définitions -/

/- Toutes les définitions du fichier sont posées ici, avant les démonstrations. -/

/-- Une instruction transforme la valeur de la variable. -/
abbrev Instruction := ℤ → ℤ

/-- Exécuter une suite d'instructions, de la première à la dernière. -/
def executer (p : List Instruction) (x : ℤ) : ℤ := p.foldl (fun v f => f v) x

/-- Répéter `n` fois une instruction. -/
def repeter (f : Instruction) (n : ℕ) : Instruction := f^[n]

/-- Boucle non bornée : retrancher `b` à `x` tant que c'est possible. -/
def soustraireTantQue (b x : ℕ) : ℕ :=
  if _h : 0 < b ∧ b ≤ x then soustraireTantQue b (x - b) else x
decreasing_by omega

/-- Le programme « ajouter 3, doubler, retrancher 6 ». -/
def programmeA : List Instruction := [(· + 3), (· * 2), (· - 6)]

/-- Le programme « doubler ». -/
def programmeB : List Instruction := [(· * 2)]

/-! ## Une suite d'affectations compose ses instructions dans l'ordre d'écriture -/

/-- Exécuter une suite d'affectations revient à composer les instructions dans l'ordre
d'écriture : la valeur finale se lit de proche en proche. -/
theorem etat_apres_affectations (x : ℤ) :
    executer [(· + 3), (· * 2)] x = (x + 3) * 2 := by
  simp [executer]

/-- Ajouter une instruction à la fin d'un programme, c'est l'appliquer au résultat. -/
theorem executer_concat (p : List Instruction) (f : Instruction) (x : ℤ) :
    executer (p ++ [f]) x = f (executer p x) := by
  simp [executer]

/-! ## Boucle bornée : répéter `n` fois une instruction -/

/-- Répéter `n` fois l'ajout de `a` ajoute `n × a`. -/
theorem repeter_ajout (a : ℤ) (n : ℕ) (x : ℤ) :
    repeter (· + a) n x = x + n * a := by
  induction n with
  | zero => simp [repeter]
  | succ n hn =>
    rw [repeter, Function.iterate_succ_apply']
    rw [repeter] at hn
    push_cast
    rw [hn]
    ring

/-- Répéter `n` fois le doublement multiplie par `2ⁿ`. -/
theorem repeter_doublement (n : ℕ) (x : ℤ) :
    repeter (· * 2) n x = x * 2 ^ n := by
  induction n with
  | zero => simp [repeter]
  | succ n hn =>
    rw [repeter, Function.iterate_succ_apply']
    rw [repeter] at hn
    rw [hn]
    ring

/-! ## Terminaison d'une boucle non bornée -/

/-- La boucle « retrancher `b` tant que c'est possible » s'arrête, et ce qu'elle laisse
est le reste de la division de `x` par `b`. La terminaison tient à ce que `x` décroît
strictement à chaque tour, une quantité entière positive ne pouvant décroître
indéfiniment. -/
theorem soustraireTantQue_eq_mod {b : ℕ} (hb : 0 < b) (x : ℕ) :
    soustraireTantQue b x = x % b := by
  induction x using Nat.strong_induction_on with
  | _ x hi =>
    rw [soustraireTantQue]
    split
    · rename_i h
      rw [hi (x - b) (by omega)]
      exact (Nat.mod_eq_sub_mod h.2).symm
    · rename_i h
      have hlt : x < b := by omega
      exact (Nat.mod_eq_of_lt hlt).symm

/-- C'est l'hypothèse `0 < b` qui garantit la décroissance : pour `b = 0`, la condition
d'entrée est fausse et la boucle rend `x` sans rien faire. -/
theorem soustraireTantQue_zero (x : ℕ) : soustraireTantQue 0 x = x := by
  rw [soustraireTantQue]
  simp

/-! ## Correction d'un programme de calcul -/

/-- Le programme « ajouter 3, doubler, retrancher 6 » calcule le double de l'entrée. -/
theorem correction_programmeA (x : ℤ) : executer programmeA x = 2 * x := by
  simp [executer, programmeA]
  ring

/-! ## Deux programmes de longueurs différentes calculent la même chose -/

/-- Les deux programmes donnent le même résultat pour toute entrée, bien qu'ils ne
suivent pas les mêmes étapes. -/
theorem programmes_equivalents (x : ℤ) : executer programmeA x = executer programmeB x := by
  rw [correction_programmeA]
  simp [executer, programmeB]
  ring

/-- Et pourtant les deux suites d'instructions diffèrent : l'équivalence porte sur ce que
les programmes calculent, pas sur la façon dont ils le calculent. -/
theorem programmes_de_longueurs_differentes : programmeA.length ≠ programmeB.length := by
  simp [programmeA, programmeB]

end College.Algorithmique
