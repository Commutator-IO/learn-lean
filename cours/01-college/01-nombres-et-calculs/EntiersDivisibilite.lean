/-
Collège — section « Entiers, divisibilité ».
Les preuves n'utilisent que la bibliothèque standard ; Mathlib n'est importé que pour
ses notations (ℕ) et la cohérence avec les autres fichiers du chapitre.
Énoncés et démonstrations en français : voir EntiersDivisibilite.tex.
-/
import Mathlib

namespace College.NombresEtCalculs

/-- `n` est pair. -/
def Pair (n : ℕ) : Prop := ∃ k, n = 2 * k

/-- `n` est impair. -/
def Impair (n : ℕ) : Prop := ∃ k, n = 2 * k + 1

/-- `p` est premier. -/
def Premier (p : ℕ) : Prop := 2 ≤ p ∧ ∀ d, d ∣ p → d = 1 ∨ d = p

/-! ## Un entier est pair ou impair, jamais les deux -/

/-- Un entier est pair ou impair. -/
theorem pair_ou_impair (n : ℕ) : Pair n ∨ Impair n := by
  cases Nat.mod_two_eq_zero_or_one n with
  | inl h => exact Or.inl ⟨n / 2, by omega⟩
  | inr h => exact Or.inr ⟨n / 2, by omega⟩

/-- Aucun entier n'est à la fois pair et impair. -/
theorem pas_pair_et_impair (n : ℕ) : ¬(Pair n ∧ Impair n) := by
  intro ⟨⟨k, hk⟩, ⟨l, hl⟩⟩
  omega

/-- Réunion des deux énoncés précédents : tout entier relève d'un cas, et d'un seul. -/
theorem un_entier_est_pair_ou_impair_jamais_les_deux (n : ℕ) :
    (Pair n ∨ Impair n) ∧ ¬(Pair n ∧ Impair n) :=
  ⟨pair_ou_impair n, pas_pair_et_impair n⟩

/-! ## Somme de deux pairs = pair ; pair + impair = impair ; impair + impair = pair -/

/-- Somme de deux pairs = pair. -/
theorem somme_de_deux_pairs_est_paire {m n : ℕ} (hm : Pair m) (hn : Pair n) :
    Pair (m + n) := by
  obtain ⟨k, hk⟩ := hm
  obtain ⟨l, hl⟩ := hn
  exact ⟨k + l, by omega⟩

/-- Pair + impair = impair. -/
theorem somme_pair_impair_est_impaire {m n : ℕ} (hm : Pair m) (hn : Impair n) :
    Impair (m + n) := by
  obtain ⟨k, hk⟩ := hm
  obtain ⟨l, hl⟩ := hn
  exact ⟨k + l, by omega⟩

/-- Impair + impair = pair. -/
theorem somme_de_deux_impairs_est_paire {m n : ℕ} (hm : Impair m) (hn : Impair n) :
    Pair (m + n) := by
  obtain ⟨k, hk⟩ := hm
  obtain ⟨l, hl⟩ := hn
  exact ⟨k + l + 1, by omega⟩

/-! ## Notion de multiple et de diviseur ; un diviseur de `n` est inférieur ou égal à `n` -/

/-- Notion de multiple et de diviseur. -/
theorem multiple_ssi_divise {a n : ℕ} : (∃ k, n = a * k) ↔ a ∣ n := Iff.rfl

/-- Un diviseur de `n` est inférieur ou égal à `n`. -/
theorem diviseur_le_de_pos {a n : ℕ} (hn : 0 < n) (h : a ∣ n) : a ≤ n :=
  Nat.le_of_dvd hn h

/-- Contre-exemple pour `n = 0`. -/
theorem diviseur_de_zero_non_borne (a : ℕ) : a ∣ 0 :=
  ⟨0, by omega⟩

/-! ## Critère de divisibilité par 2, par 5, par 10 (chiffre des unités) -/

/-- Chiffre des unités. -/
def chiffreUnites (n : ℕ) : ℕ := n % 10

/-- Critère de divisibilité par 2 (chiffre des unités). -/
theorem critere_divisibilite_par_2 (n : ℕ) : 2 ∣ n ↔ 2 ∣ chiffreUnites n := by
  unfold chiffreUnites
  constructor <;> intro h <;> omega

/-- Critère de divisibilité par 2, chiffres énumérés. -/
theorem critere_divisibilite_par_2_chiffres (n : ℕ) :
    2 ∣ n ↔ chiffreUnites n = 0 ∨ chiffreUnites n = 2 ∨ chiffreUnites n = 4 ∨
            chiffreUnites n = 6 ∨ chiffreUnites n = 8 := by
  unfold chiffreUnites
  constructor <;> intro h <;> omega

/-- Critère de divisibilité par 5 (chiffre des unités). -/
theorem critere_divisibilite_par_5 (n : ℕ) :
    5 ∣ n ↔ chiffreUnites n = 0 ∨ chiffreUnites n = 5 := by
  unfold chiffreUnites
  constructor <;> intro h <;> omega

/-- Critère de divisibilité par 10 (chiffre des unités). -/
theorem critere_divisibilite_par_10 (n : ℕ) : 10 ∣ n ↔ chiffreUnites n = 0 := by
  unfold chiffreUnites
  constructor <;> intro h <;> omega

/-! ## Critère de divisibilité par 3 et par 9 (somme des chiffres) -/

/-- Somme des chiffres. -/
def sommeChiffres (n : ℕ) : ℕ :=
  if h : n = 0 then 0
  else n % 10 + sommeChiffres (n / 10)
decreasing_by exact Nat.div_lt_self (Nat.pos_of_ne_zero h) (by omega)

/-- `n` et la somme de ses chiffres ont le même reste modulo 9. -/
theorem mod_neuf_somme_chiffres (n : ℕ) : n % 9 = sommeChiffres n % 9 := by
  induction n using Nat.strongRecOn with
  | _ n hi =>
    rw [sommeChiffres]
    split
    · omega
    · rename_i h
      have hlt : n / 10 < n := Nat.div_lt_self (Nat.pos_of_ne_zero h) (by omega)
      have := hi (n / 10) hlt
      omega

/-- `n` et la somme de ses chiffres ont le même reste modulo 3. -/
theorem mod_trois_somme_chiffres (n : ℕ) : n % 3 = sommeChiffres n % 3 := by
  induction n using Nat.strongRecOn with
  | _ n hi =>
    rw [sommeChiffres]
    split
    · omega
    · rename_i h
      have hlt : n / 10 < n := Nat.div_lt_self (Nat.pos_of_ne_zero h) (by omega)
      have := hi (n / 10) hlt
      omega

/-- Critère de divisibilité par 3 (somme des chiffres). -/
theorem critere_divisibilite_par_3 (n : ℕ) : 3 ∣ n ↔ 3 ∣ sommeChiffres n := by
  have h := mod_trois_somme_chiffres n
  constructor <;> intro hd <;> omega

/-- Critère de divisibilité par 9 (somme des chiffres). -/
theorem critere_divisibilite_par_9 (n : ℕ) : 9 ∣ n ↔ 9 ∣ sommeChiffres n := by
  have h := mod_neuf_somme_chiffres n
  constructor <;> intro hd <;> omega

/-! ## Critère de divisibilité par 4 (deux derniers chiffres) -/

/-- Nombre formé par les deux derniers chiffres. -/
def deuxDerniersChiffres (n : ℕ) : ℕ := n % 100

/-- Critère de divisibilité par 4 (deux derniers chiffres). -/
theorem critere_divisibilite_par_4 (n : ℕ) : 4 ∣ n ↔ 4 ∣ deuxDerniersChiffres n := by
  unfold deuxDerniersChiffres
  constructor <;> intro h <;> omega

/-! ## Si `a ∣ b` et `a ∣ c` alors `a ∣ (b + c)` et `a ∣ (b − c)` -/

/-- Si `a ∣ b` et `a ∣ c` alors `a ∣ (b + c)`. -/
theorem divise_somme {a b c : ℕ} (hb : a ∣ b) (hc : a ∣ c) : a ∣ (b + c) :=
  Nat.dvd_add hb hc

/-- Si `a ∣ b` et `a ∣ c` alors `a ∣ (b − c)`. -/
theorem divise_difference {a b c : ℕ} (hb : a ∣ b) (hc : a ∣ c) : a ∣ (b - c) :=
  Nat.dvd_sub hb hc

/-! ## Division euclidienne : existence et unicité de `(q, r)` avec `a = bq + r`, `0 ≤ r < b` -/

/-- Division euclidienne : existence de `(q, r)` avec `a = bq + r`, `0 ≤ r < b`. -/
theorem division_euclidienne_existence (a : ℕ) {b : ℕ} (hb : 0 < b) :
    ∃ q r, a = b * q + r ∧ r < b :=
  ⟨a / b, a % b, (Nat.div_add_mod a b).symm, Nat.mod_lt a hb⟩

/-- Division euclidienne : unicité de `(q, r)`. -/
theorem division_euclidienne_unicite {a b q r q' r' : ℕ} (hb : 0 < b)
    (h : a = b * q + r) (hr : r < b) (h' : a = b * q' + r') (hr' : r' < b) :
    q = q' ∧ r = r' := by
  have e : a / b = q ∧ a % b = r :=
    (Nat.div_mod_unique hb).mpr ⟨by rw [h]; exact Nat.add_comm _ _, hr⟩
  have e' : a / b = q' ∧ a % b = r' :=
    (Nat.div_mod_unique hb).mpr ⟨by rw [h']; exact Nat.add_comm _ _, hr'⟩
  exact ⟨by rw [← e.1, e'.1], by rw [← e.2, e'.2]⟩

/-! ## Nombre premier ; tout entier > 1 admet un diviseur premier -/

/-- Nombre premier : ses seuls diviseurs sont 1 et lui-même. -/
theorem premier_diviseurs {p d : ℕ} (hp : Premier p) (h : d ∣ p) : d = 1 ∨ d = p :=
  hp.2 d h

/-- Tout entier > 1 admet un diviseur premier. -/
theorem existe_diviseur_premier : ∀ {n : ℕ}, 2 ≤ n → ∃ p, Premier p ∧ p ∣ n := by
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

/-- Crible d'Ératosthène, écrit comme un test. -/
def estPremier (n : ℕ) : Bool :=
  2 ≤ n && (List.range n).all fun d => d < 2 || n % d != 0

/-- Le test et la définition coïncident. -/
theorem estPremier_iff (n : ℕ) : estPremier n = true ↔ Premier n := by
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

/-- Crible d'Ératosthène : les nombres premiers inférieurs à 100. -/
theorem crible_eratosthene :
    (List.range 100).filter estPremier =
      [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73,
       79, 83, 89, 97] := by
  decide

/-! ## Décomposition en produit de facteurs premiers -/

/-- Produit des éléments d'une liste. -/
def produit : List ℕ → ℕ
  | [] => 1
  | p :: l => p * produit l

/-- Décomposition en produit de facteurs premiers. -/
theorem decomposition_en_facteurs_premiers :
    ∀ {n : ℕ}, 0 < n → ∃ l : List ℕ, (∀ p ∈ l, Premier p) ∧ produit l = n := by
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

/-- Lemme d'Euclide, sur lequel repose l'unicité. -/
theorem lemme_d_euclide {p a b : ℕ} (hp : Premier p) (h : p ∣ a * b) :
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
Statut ◐ : l'existence est démontrée, l'unicité ne l'est pas — elle demande de comparer
deux listes de facteurs à permutation près. Au collège, elle est admise.
-/

/-! ## PGCD, algorithme d'Euclide -/

/-- PGCD, algorithme d'Euclide : `pgcd(a, b) = pgcd(b, a mod b)`. -/
theorem pgcd_euclide (a b : ℕ) : Nat.gcd a b = Nat.gcd (b % a) a :=
  Nat.gcd_rec a b

/-- Le PGCD est un diviseur commun. -/
theorem pgcd_divise (a b : ℕ) : Nat.gcd a b ∣ a ∧ Nat.gcd a b ∣ b :=
  ⟨Nat.gcd_dvd_left a b, Nat.gcd_dvd_right a b⟩

/-- Tout diviseur commun divise le PGCD. -/
theorem pgcd_le_de_diviseur_commun {a b d : ℕ} (ha : d ∣ a) (hb : d ∣ b) :
    d ∣ Nat.gcd a b :=
  Nat.dvd_gcd ha hb

/-! ## Deux nombres sont premiers entre eux ⟺ `pgcd = 1` -/

/-- Nombres premiers entre eux ⟺ `pgcd = 1`. -/
theorem premiers_entre_eux_ssi_pgcd_un {a b : ℕ} :
    Nat.Coprime a b ↔ Nat.gcd a b = 1 := Iff.rfl

/-- Nombres premiers entre eux ⟺ seuls diviseurs communs égaux à 1. -/
theorem premiers_entre_eux_ssi_diviseurs_communs_triviaux {a b : ℕ} :
    Nat.Coprime a b ↔ ∀ d, d ∣ a → d ∣ b → d = 1 := by
  constructor
  · intro h d hda hdb
    have : d ∣ Nat.gcd a b := Nat.dvd_gcd hda hdb
    rw [h] at this
    exact Nat.eq_one_of_dvd_one this
  · intro h
    exact h (Nat.gcd a b) (Nat.gcd_dvd_left a b) (Nat.gcd_dvd_right a b)

/-! ## Toute fraction admet une écriture irréductible -/

/-- Toute fraction admet une écriture irréductible. -/
theorem fraction_irreductible {n d : ℕ} (hd : 0 < d) :
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
