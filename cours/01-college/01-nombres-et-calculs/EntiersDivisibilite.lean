/-
Collège, 6e — parité et divisibilité dans les entiers naturels.

Lean core seulement : pas d'import de Mathlib, donc `Pair` et `Impair` sont définis
ici plutôt que repris de `Even` / `Odd`.
-/

namespace College.NombresEtCalculs

/-- `n` est pair : il vaut deux fois un entier naturel. -/
def Pair (n : Nat) : Prop := ∃ k, n = 2 * k

/-- `n` est impair : il vaut deux fois un entier naturel, plus un. -/
def Impair (n : Nat) : Prop := ∃ k, n = 2 * k + 1

/-! ## Un entier est pair ou impair, jamais les deux -/

/-- Tout entier naturel est pair ou impair. Le témoin est `n / 2` dans les deux cas ;
c'est `n % 2`, qui ne peut valoir que `0` ou `1`, qui décide lequel s'applique. -/
theorem pair_ou_impair (n : Nat) : Pair n ∨ Impair n := by
  cases Nat.mod_two_eq_zero_or_one n with
  | inl h => exact Or.inl ⟨n / 2, by omega⟩
  | inr h => exact Or.inr ⟨n / 2, by omega⟩

/-- Aucun entier n'est à la fois pair et impair : `2 * k = 2 * l + 1` est impossible. -/
theorem pas_pair_et_impair (n : Nat) : ¬(Pair n ∧ Impair n) := by
  intro ⟨⟨k, hk⟩, ⟨l, hl⟩⟩
  omega

/-- Les deux énoncés réunis : l'un des deux cas se produit, et un seul. -/
theorem un_entier_est_pair_ou_impair_jamais_les_deux (n : Nat) :
    (Pair n ∨ Impair n) ∧ ¬(Pair n ∧ Impair n) :=
  ⟨pair_ou_impair n, pas_pair_et_impair n⟩

/-! ## Somme de deux pairs = pair ; pair + impair = impair ; impair + impair = pair -/

/-- pair + pair = pair. -/
theorem somme_de_deux_pairs_est_paire {m n : Nat} (hm : Pair m) (hn : Pair n) :
    Pair (m + n) := by
  obtain ⟨k, hk⟩ := hm
  obtain ⟨l, hl⟩ := hn
  exact ⟨k + l, by omega⟩

/-- pair + impair = impair. -/
theorem somme_pair_impair_est_impaire {m n : Nat} (hm : Pair m) (hn : Impair n) :
    Impair (m + n) := by
  obtain ⟨k, hk⟩ := hm
  obtain ⟨l, hl⟩ := hn
  exact ⟨k + l, by omega⟩

/-- impair + impair = pair. C'est le cas qui surprend les élèves, et celui où les deux
`+ 1` se recombinent en un facteur `2`. -/
theorem somme_de_deux_impairs_est_paire {m n : Nat} (hm : Impair m) (hn : Impair n) :
    Pair (m + n) := by
  obtain ⟨k, hk⟩ := hm
  obtain ⟨l, hl⟩ := hn
  exact ⟨k + l + 1, by omega⟩

/-! ## Notion de multiple et de diviseur ; un diviseur de `n` est inférieur ou égal à `n` -/

/-- « `n` est un multiple de `a` » et « `a` divise `n` » sont le même énoncé : sur `Nat`,
`Dvd` se déplie exactement en cette existentielle. -/
theorem multiple_ssi_divise {a n : Nat} : (∃ k, n = a * k) ↔ a ∣ n := Iff.rfl

/-- Un diviseur d'un entier `n` non nul est inférieur ou égal à `n`. L'énoncé scolaire
laisse l'hypothèse implicite, parce que le cas `n = 0` n'y est pas envisagé. -/
theorem diviseur_le_de_pos {a n : Nat} (hn : 0 < n) (h : a ∣ n) : a ≤ n :=
  Nat.le_of_dvd hn h

/-- L'hypothèse `0 < n` ne peut pas être retirée : `0` est multiple de tout entier, donc
ses diviseurs ne sont pas bornés. C'est tout l'écart entre l'énoncé de la classe et
l'énoncé formel — au collège, `n` est toujours un nombre d'objets à partager. -/
theorem diviseur_de_zero_non_borne (a : Nat) : a ∣ 0 :=
  ⟨0, by omega⟩

end College.NombresEtCalculs
