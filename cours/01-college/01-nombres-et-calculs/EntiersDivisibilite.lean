/-
Collège — parité, divisibilité, division euclidienne, nombres premiers et PGCD.
Reprend les quatorze énoncés de la section « Entiers, divisibilité » du chapitre.

Lean core seulement : pas d'import de Mathlib. `Pair`, `Impair`, `Premier` et la somme
des chiffres sont donc définis ici plutôt que repris d'une bibliothèque.
-/

namespace College.NombresEtCalculs

/-- `n` est pair : il vaut deux fois un entier naturel. -/
def Pair (n : Nat) : Prop := ∃ k, n = 2 * k

/-- `n` est impair : il vaut deux fois un entier naturel, plus un. -/
def Impair (n : Nat) : Prop := ∃ k, n = 2 * k + 1

/-- `p` est premier : au moins égal à 2, et sans diviseur autre que 1 et lui-même. -/
def Premier (p : Nat) : Prop := 2 ≤ p ∧ ∀ d, d ∣ p → d = 1 ∨ d = p

/-! ## Un entier est pair ou impair, jamais les deux -/

/-- Tout entier naturel est pair ou impair. -/
theorem pair_ou_impair (n : Nat) : Pair n ∨ Impair n := by
  cases Nat.mod_two_eq_zero_or_one n with
  | inl h => exact Or.inl ⟨n / 2, by omega⟩
  | inr h => exact Or.inr ⟨n / 2, by omega⟩

/-- Aucun entier n'est à la fois pair et impair. -/
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

/-- impair + impair = pair. C'est le cas qui surprend les élèves. -/
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

/-! ## Critère de divisibilité par 2, par 5, par 10 (chiffre des unités) -/

/-- Le chiffre des unités de `n` en écriture décimale. -/
def chiffreUnites (n : Nat) : Nat := n % 10

/-- Divisible par 2 si et seulement si le chiffre des unités l'est. La preuve tient à
`2 ∣ 10` : réduire modulo 10 d'abord ne change rien au reste modulo 2. -/
theorem critere_divisibilite_par_2 (n : Nat) : 2 ∣ n ↔ 2 ∣ chiffreUnites n := by
  unfold chiffreUnites
  constructor <;> intro h <;> omega

/-- Version « en toutes lettres » du critère : le chiffre des unités est 0, 2, 4, 6 ou 8. -/
theorem critere_divisibilite_par_2_chiffres (n : Nat) :
    2 ∣ n ↔ chiffreUnites n = 0 ∨ chiffreUnites n = 2 ∨ chiffreUnites n = 4 ∨
            chiffreUnites n = 6 ∨ chiffreUnites n = 8 := by
  unfold chiffreUnites
  constructor <;> intro h <;> omega

/-- Divisible par 5 si et seulement si le chiffre des unités est 0 ou 5. -/
theorem critere_divisibilite_par_5 (n : Nat) :
    5 ∣ n ↔ chiffreUnites n = 0 ∨ chiffreUnites n = 5 := by
  unfold chiffreUnites
  constructor <;> intro h <;> omega

/-- Divisible par 10 si et seulement si le chiffre des unités est 0. -/
theorem critere_divisibilite_par_10 (n : Nat) : 10 ∣ n ↔ chiffreUnites n = 0 := by
  unfold chiffreUnites
  constructor <;> intro h <;> omega

/-! ## Critère de divisibilité par 3 et par 9 (somme des chiffres) -/

/-- Somme des chiffres de l'écriture décimale de `n`. La récursion se fait sur `n / 10`,
strictement décroissant tant que `n ≠ 0`. -/
def sommeChiffres (n : Nat) : Nat :=
  if h : n = 0 then 0
  else n % 10 + sommeChiffres (n / 10)
decreasing_by exact Nat.div_lt_self (Nat.pos_of_ne_zero h) (by omega)

/-- `n` et la somme de ses chiffres ont le même reste modulo 9. C'est le cœur des deux
critères : `10 ≡ 1 [9]`, donc chaque chiffre compte pour lui-même. -/
theorem mod_neuf_somme_chiffres (n : Nat) : n % 9 = sommeChiffres n % 9 := by
  induction n using Nat.strongRecOn with
  | _ n hi =>
    rw [sommeChiffres]
    split
    · omega
    · rename_i h
      have hlt : n / 10 < n := Nat.div_lt_self (Nat.pos_of_ne_zero h) (by omega)
      have := hi (n / 10) hlt
      omega

/-- `n` et la somme de ses chiffres ont le même reste modulo 3, pour la même raison. -/
theorem mod_trois_somme_chiffres (n : Nat) : n % 3 = sommeChiffres n % 3 := by
  induction n using Nat.strongRecOn with
  | _ n hi =>
    rw [sommeChiffres]
    split
    · omega
    · rename_i h
      have hlt : n / 10 < n := Nat.div_lt_self (Nat.pos_of_ne_zero h) (by omega)
      have := hi (n / 10) hlt
      omega

/-- Divisible par 3 si et seulement si la somme des chiffres l'est. -/
theorem critere_divisibilite_par_3 (n : Nat) : 3 ∣ n ↔ 3 ∣ sommeChiffres n := by
  have h := mod_trois_somme_chiffres n
  constructor <;> intro hd <;> omega

/-- Divisible par 9 si et seulement si la somme des chiffres l'est. -/
theorem critere_divisibilite_par_9 (n : Nat) : 9 ∣ n ↔ 9 ∣ sommeChiffres n := by
  have h := mod_neuf_somme_chiffres n
  constructor <;> intro hd <;> omega

/-! ## Critère de divisibilité par 4 (deux derniers chiffres) -/

/-- Le nombre formé par les deux derniers chiffres de `n`. -/
def deuxDerniersChiffres (n : Nat) : Nat := n % 100

/-- Divisible par 4 si et seulement si le nombre formé par les deux derniers chiffres
l'est : ici c'est `4 ∣ 100` qui fait tout le travail. -/
theorem critere_divisibilite_par_4 (n : Nat) : 4 ∣ n ↔ 4 ∣ deuxDerniersChiffres n := by
  unfold deuxDerniersChiffres
  constructor <;> intro h <;> omega

/-! ## Si `a ∣ b` et `a ∣ c` alors `a ∣ (b + c)` et `a ∣ (b − c)` -/

/-- Un diviseur commun divise la somme. -/
theorem divise_somme {a b c : Nat} (hb : a ∣ b) (hc : a ∣ c) : a ∣ (b + c) :=
  Nat.dvd_add hb hc

/-- Un diviseur commun divise la différence. Sur `Nat` la soustraction est tronquée,
mais l'énoncé reste vrai : si `b < c`, la différence vaut `0`, que tout entier divise. -/
theorem divise_difference {a b c : Nat} (hb : a ∣ b) (hc : a ∣ c) : a ∣ (b - c) :=
  Nat.dvd_sub hb hc

/-! ## Division euclidienne : existence et unicité de `(q, r)` avec `a = bq + r`, `0 ≤ r < b` -/

/-- Existence du quotient et du reste. Ce sont `a / b` et `a % b`. -/
theorem division_euclidienne_existence (a : Nat) {b : Nat} (hb : 0 < b) :
    ∃ q r, a = b * q + r ∧ r < b :=
  ⟨a / b, a % b, (Nat.div_add_mod a b).symm, Nat.mod_lt a hb⟩

/-- Unicité : deux écritures `a = bq + r` avec `r < b` coïncident. -/
theorem division_euclidienne_unicite {a b q r q' r' : Nat} (hb : 0 < b)
    (h : a = b * q + r) (hr : r < b) (h' : a = b * q' + r') (hr' : r' < b) :
    q = q' ∧ r = r' := by
  have e : a / b = q ∧ a % b = r :=
    (Nat.div_mod_unique hb).mpr ⟨by rw [h]; exact Nat.add_comm _ _, hr⟩
  have e' : a / b = q' ∧ a % b = r' :=
    (Nat.div_mod_unique hb).mpr ⟨by rw [h']; exact Nat.add_comm _ _, hr'⟩
  exact ⟨by rw [← e.1, e'.1], by rw [← e.2, e'.2]⟩

/-! ## Nombre premier ; tout entier > 1 admet un diviseur premier -/

/-- Un nombre premier n'est divisible que par 1 et par lui-même — c'est sa définition,
rappelée ici sous la forme utilisée dans les preuves. -/
theorem premier_diviseurs {p d : Nat} (hp : Premier p) (h : d ∣ p) : d = 1 ∨ d = p :=
  hp.2 d h

/-- Tout entier supérieur ou égal à 2 admet un diviseur premier. -/
theorem existe_diviseur_premier : ∀ {n : Nat}, 2 ≤ n → ∃ p, Premier p ∧ p ∣ n := by
  intro n
  induction n using Nat.strongRecOn with
  | _ n hi =>
    intro hn
    by_cases hp : Premier n
    · exact ⟨n, hp, Nat.dvd_refl n⟩
    · have : ∃ d, d ∣ n ∧ d ≠ 1 ∧ d ≠ n := by
        refine Classical.byContradiction fun hc => hp ⟨hn, fun d hd => ?_⟩
        refine Classical.byContradiction fun hne => hc ⟨d, hd, ?_, ?_⟩
        · exact fun h1 => hne (Or.inl h1)
        · exact fun h2 => hne (Or.inr h2)
      obtain ⟨d, hd, hd1, hdn⟩ := this
      have hd0 : d ≠ 0 := by
        intro h0
        subst h0
        obtain ⟨k, hk⟩ := hd
        omega
      have hle : d ≤ n := Nat.le_of_dvd (by omega) hd
      have hlt : d < n := Nat.lt_of_le_of_ne hle hdn
      obtain ⟨p, hp', hpd⟩ := hi d hlt (by omega)
      exact ⟨p, hp', Nat.dvd_trans hpd hd⟩

/-! ## Crible d'Ératosthène : lister les nombres premiers inférieurs à 100 -/

/-- Version calculable de la primalité : aucun `d` strictement compris entre 1 et `n`
ne divise `n`. C'est exactement le crible, écrit comme un test. -/
def estPremier (n : Nat) : Bool :=
  2 ≤ n && (List.range n).all fun d => d < 2 || n % d != 0

/-- Le test calculable et la définition mathématique coïncident. -/
theorem estPremier_iff (n : Nat) : estPremier n = true ↔ Premier n := by
  unfold estPremier Premier
  simp only [Bool.and_eq_true, decide_eq_true_eq, List.all_eq_true, List.mem_range,
    Bool.or_eq_true, bne_iff_ne, ne_eq, decide_eq_true_eq]
  constructor
  · intro ⟨hn, hall⟩
    refine ⟨hn, fun d hd => ?_⟩
    have hle : d ≤ n := Nat.le_of_dvd (by omega) hd
    rcases Nat.lt_or_ge d n with hlt | hge
    · have := hall d hlt
      have hmod : n % d = 0 := Nat.mod_eq_zero_of_dvd hd
      have : d < 2 := by
        rcases this with h | h
        · exact h
        · exact absurd hmod h
      have : d = 0 ∨ d = 1 := by omega
      rcases this with rfl | rfl
      · exfalso
        obtain ⟨k, hk⟩ := hd
        simp at hk
        omega
      · exact Or.inl rfl
    · exact Or.inr (Nat.le_antisymm hle hge)
  · intro ⟨hn, hdiv⟩
    refine ⟨hn, fun d hd => ?_⟩
    by_cases h2 : d < 2
    · exact Or.inl h2
    · refine Or.inr fun hmod => ?_
      have : d ∣ n := Nat.dvd_of_mod_eq_zero hmod
      rcases hdiv d this with h1 | h1 <;> omega

/-- Les nombres premiers inférieurs à 100, obtenus en filtrant `0, …, 99` par le test. -/
theorem crible_eratosthene :
    (List.range 100).filter estPremier =
      [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73,
       79, 83, 89, 97] := by
  decide

/-! ## Décomposition en produit de facteurs premiers -/

/-- Produit des éléments d'une liste. -/
def produit : List Nat → Nat
  | [] => 1
  | p :: l => p * produit l

/-- Tout entier non nul est un produit de nombres premiers — la liste est vide pour `1`. -/
theorem decomposition_en_facteurs_premiers :
    ∀ {n : Nat}, 0 < n → ∃ l : List Nat, (∀ p ∈ l, Premier p) ∧ produit l = n := by
  intro n
  induction n using Nat.strongRecOn with
  | _ n hi =>
    intro hn
    by_cases h1 : n = 1
    · exact ⟨[], by simp, by simp [produit, h1]⟩
    · obtain ⟨p, hp, hpd⟩ := existe_diviseur_premier (n := n) (by omega)
      obtain ⟨m, hm⟩ := hpd
      have hp2 : 2 ≤ p := hp.1
      have hm0 : 0 < m := by
        rcases Nat.eq_zero_or_pos m with h | h
        · subst h
          rw [Nat.mul_zero] at hm
          omega
        · exact h
      have hmlt : m < n := by
        have h1 : 1 * m < p * m := (Nat.mul_lt_mul_right hm0).mpr (by omega)
        rw [Nat.one_mul] at h1
        exact hm ▸ h1
      obtain ⟨l, hl, hprod⟩ := hi m hmlt hm0
      exact ⟨p :: l, by
        intro q hq
        rcases List.mem_cons.mp hq with h | h
        · exact h ▸ hp
        · exact hl q h, by simp [produit, hprod, hm]⟩

/-- Lemme d'Euclide : un nombre premier qui divise un produit divise l'un des facteurs.
C'est lui qui porte l'unicité de la décomposition, admise au collège. -/
theorem lemme_d_euclide {p a b : Nat} (hp : Premier p) (h : p ∣ a * b) :
    p ∣ a ∨ p ∣ b := by
  by_cases ha : p ∣ a
  · exact Or.inl ha
  · refine Or.inr ?_
    have hcop : Nat.Coprime p a := by
      rcases hp.2 (Nat.gcd p a) (Nat.gcd_dvd_left p a) with h1 | h1
      · exact h1
      · exact absurd (h1 ▸ Nat.gcd_dvd_right p a) ha
    exact hcop.dvd_of_dvd_mul_left h

/-
Statut ◐ pour cet énoncé : l'existence de la décomposition est démontrée ci-dessus, et
le lemme d'Euclide en donne la clé, mais l'unicité elle-même ne l'est pas encore. Elle
demande de comparer deux listes de facteurs à permutation près (`List.Perm`), ce qui est
une récurrence d'une tout autre longueur que l'énoncé de 3e ne le laisse croire — au
collège, l'unicité est admise sans même être formulée.
-/

/-! ## PGCD, algorithme d'Euclide -/

/-- L'étape de l'algorithme d'Euclide : `pgcd(a, b) = pgcd(b mod a, a)`. C'est la
définition même de `Nat.gcd`, et donc ce qui garantit que l'algorithme termine. -/
theorem pgcd_euclide (a b : Nat) : Nat.gcd a b = Nat.gcd (b % a) a :=
  Nat.gcd_rec a b

/-- Le PGCD est un diviseur commun. -/
theorem pgcd_divise (a b : Nat) : Nat.gcd a b ∣ a ∧ Nat.gcd a b ∣ b :=
  ⟨Nat.gcd_dvd_left a b, Nat.gcd_dvd_right a b⟩

/-- Et c'est le plus grand : tout diviseur commun divise le PGCD. -/
theorem pgcd_le_de_diviseur_commun {a b d : Nat} (ha : d ∣ a) (hb : d ∣ b) :
    d ∣ Nat.gcd a b :=
  Nat.dvd_gcd ha hb

/-! ## Deux nombres sont premiers entre eux ⟺ `pgcd = 1` -/

/-- « Premiers entre eux » et « PGCD égal à 1 » sont le même énoncé : sur `Nat`,
`Coprime` est défini comme l'égalité du PGCD à 1. -/
theorem premiers_entre_eux_ssi_pgcd_un {a b : Nat} :
    Nat.Coprime a b ↔ Nat.gcd a b = 1 := Iff.rfl

/-- Formulation scolaire : deux entiers sont premiers entre eux exactement quand leurs
seuls diviseurs communs sont `1`. -/
theorem premiers_entre_eux_ssi_diviseurs_communs_triviaux {a b : Nat} :
    Nat.Coprime a b ↔ ∀ d, d ∣ a → d ∣ b → d = 1 := by
  constructor
  · intro h d hda hdb
    have : d ∣ Nat.gcd a b := Nat.dvd_gcd hda hdb
    rw [h] at this
    exact Nat.eq_one_of_dvd_one this
  · intro h
    exact h (Nat.gcd a b) (Nat.gcd_dvd_left a b) (Nat.gcd_dvd_right a b)

/-! ## Toute fraction admet une écriture irréductible -/

/-- Toute fraction `n / d` de dénominateur non nul est égale à une fraction irréductible :
on divise les deux termes par leur PGCD. L'égalité des fractions est écrite en produits
croisés, pour rester dans `Nat`. -/
theorem fraction_irreductible {n d : Nat} (hd : 0 < d) :
    ∃ n' d', 0 < d' ∧ Nat.Coprime n' d' ∧ n * d' = n' * d := by
  have hg : 0 < Nat.gcd n d := Nat.gcd_pos_of_pos_right n hd
  refine ⟨n / Nat.gcd n d, d / Nat.gcd n d, ?_, Nat.coprime_div_gcd_div_gcd hg, ?_⟩
  · exact Nat.div_pos (Nat.le_of_dvd hd (Nat.gcd_dvd_right n d)) hg
  · have hn : Nat.gcd n d * (n / Nat.gcd n d) = n :=
      Nat.mul_div_cancel' (Nat.gcd_dvd_left n d)
    have hd' : Nat.gcd n d * (d / Nat.gcd n d) = d :=
      Nat.mul_div_cancel' (Nat.gcd_dvd_right n d)
    calc n * (d / Nat.gcd n d)
        = (Nat.gcd n d * (n / Nat.gcd n d)) * (d / Nat.gcd n d) := by rw [hn]
      _ = (n / Nat.gcd n d) * (Nat.gcd n d * (d / Nat.gcd n d)) := by
            rw [Nat.mul_comm (Nat.gcd n d) (n / Nat.gcd n d), Nat.mul_assoc]
      _ = (n / Nat.gcd n d) * d := by rw [hd']

end College.NombresEtCalculs
