/-
Lycée — spécialité NSI, section « Récursivité et diviser pour régner ».
Une fonction récursive s'appelle elle-même : rien ne garantit a priori qu'elle
s'arrête, ni qu'elle calcule ce qu'on croit. Ce fichier démontre les deux pour la
factorielle, Fibonacci et l'exponentiation rapide, puis compare les coûts — la
différence entre le Fibonacci récursif naïf et sa version itérative est
exponentielle, et couper un problème en deux moitiés donne le coût `n log₂ n`.
Énoncés et démonstrations en français : voir Informatique.tex.
-/
import Mathlib

namespace Lycee.Nsi

/-! ## Factorielle récursive -/

/-- La factorielle, écrite récursivement. La récursion porte sur le constructeur de
l'entier : chaque appel se fait sur `n`, prédécesseur de `n + 1`. C'est ce qui fait
que la fonction termine, et Lean l'accepte sans qu'on ait à le justifier. -/
def factorielle : ℕ → ℕ
  | 0 => 1
  | n + 1 => (n + 1) * factorielle n

/-- La fonction récursive calcule bien la factorielle : son résultat est le produit
des entiers de `1` à `n`. Elle ne rend jamais `0`, ce qui autorise à diviser par
elle. -/
theorem factorielle_recursive (n : ℕ) :
    factorielle n = ∏ i ∈ Finset.range n, (i + 1) ∧ 0 < factorielle n := by
  induction n with
  | zero => simp [factorielle]
  | succ k hk =>
      obtain ⟨hprod, hpos⟩ := hk
      refine ⟨?_, by simp [factorielle]; positivity⟩
      rw [factorielle, hprod, Finset.prod_range_succ]
      ring

/-! ## Suite de Fibonacci -/

/-- Fibonacci, écrit récursivement comme la définition mathématique le dit : chaque
terme est la somme des deux précédents. Deux appels par terme. -/
def fibRecursif : ℕ → ℕ
  | 0 => 0
  | 1 => 1
  | n + 2 => fibRecursif n + fibRecursif (n + 1)

/-- Fibonacci, écrit itérativement : on garde deux termes consécutifs et l'on avance
d'un cran à chaque tour. Un seul parcours. -/
def fibIteratif : ℕ → ℕ × ℕ
  | 0 => (0, 1)
  | n + 1 => ((fibIteratif n).2, (fibIteratif n).1 + (fibIteratif n).2)

/-- Les deux versions calculent la même valeur.

La récurrence porte sur l'invariant de la boucle, plus fort que l'énoncé : le couple
gardé en mémoire est exactement `(F(n), F(n+1))`. C'est un cas typique où l'on ne
peut pas démontrer l'énoncé tel quel, et où il faut d'abord dire ce que le programme
conserve. -/
theorem fibonacci_recursif_et_iteratif (n : ℕ) :
    fibIteratif n = (fibRecursif n, fibRecursif (n + 1)) := by
  induction n with
  | zero => simp [fibIteratif, fibRecursif]
  | succ k hk =>
      rw [fibIteratif, hk]
      simp [fibRecursif]

/-! ## Coût des deux versions -/

/-- Le nombre d'appels que fait le Fibonacci récursif naïf : un pour lui-même, plus
ceux de ses deux appels. -/
def appelsFibRecursif : ℕ → ℕ
  | 0 => 1
  | 1 => 1
  | n + 2 => 1 + appelsFibRecursif n + appelsFibRecursif (n + 1)

/-- Le nombre de tours de la version itérative : un par cran. -/
def toursFibIteratif : ℕ → ℕ
  | 0 => 0
  | n + 1 => toursFibIteratif n + 1

/-- Le nombre d'appels croît avec `n` : chaque appel supplémentaire ne peut
qu'ajouter du travail. C'est l'étape qu'il faut avoir démontrée avant de minorer le
coût. -/
theorem appels_fib_croissant (n : ℕ) : appelsFibRecursif n ≤ appelsFibRecursif (n + 1) := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
      match n with
      | 0 => simp [appelsFibRecursif]
      | 1 => simp [appelsFibRecursif]
      | k + 2 =>
          have h1 := ih k (by omega)
          have h2 := ih (k + 1) (by omega)
          simp only [appelsFibRecursif]
          omega

/-- Le coût du Fibonacci récursif naïf est exponentiel, celui de la version
itérative est linéaire.

La minoration `2^(n/2) ≤ appels(n)` suffit à conclure : le nombre d'appels double au
moins tous les deux crans, alors que la boucle n'en fait que `n`. Pour `n = 40`, cela
sépare le million de la quarantaine. -/
theorem cout_fibonacci (n : ℕ) :
    2 ^ (n / 2) ≤ appelsFibRecursif n ∧ toursFibIteratif n = n := by
  refine ⟨?_, ?_⟩
  · induction n using Nat.strong_induction_on with
    | _ n ih =>
        match n with
        | 0 => simp [appelsFibRecursif]
        | 1 => simp [appelsFibRecursif]
        | k + 2 =>
            have hk := ih k (by omega)
            have hmono := appels_fib_croissant k
            have hdiv : (k + 2) / 2 = k / 2 + 1 := by omega
            rw [hdiv, pow_succ]
            simp only [appelsFibRecursif]
            omega
  · induction n with
    | zero => simp [toursFibIteratif]
    | succ k hk => simp [toursFibIteratif, hk]

/-! ## Exponentiation rapide -/

/-- L'exponentiation rapide : au lieu de multiplier `n` fois par `a`, on élève au
carré la puissance de l'exposant moitié. La récursion se fait sur `n / 2`, qui est
strictement plus petit que `n` dès que `n` n'est pas nul : c'est le variant qui
justifie la terminaison, et Lean le réclame explicitement. -/
def puissanceRapide (a n : ℕ) : ℕ :=
  if n = 0 then 1
  else if n % 2 = 0 then puissanceRapide a (n / 2) * puissanceRapide a (n / 2)
  else a * (puissanceRapide a (n / 2) * puissanceRapide a (n / 2))
termination_by n
decreasing_by all_goals omega

/-- Le nombre d'élévations au carré que fait l'exponentiation rapide : une par
appel. -/
def coutPuissanceRapide (n : ℕ) : ℕ :=
  if n = 0 then 0 else 1 + coutPuissanceRapide (n / 2)
termination_by n
decreasing_by omega

/-- L'exponentiation rapide calcule bien `aⁿ`.

Tout repose sur l'écriture `n = 2⌊n/2⌋ + (n mod 2)`, donc
`aⁿ = (a^⌊n/2⌋)² × a^(n mod 2)` : c'est le carré qui fait tout le travail, et le
facteur `a` supplémentaire ne sert que pour un exposant impair. -/
theorem exponentiation_rapide_correcte (a n : ℕ) : puissanceRapide a n = a ^ n := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
      rw [puissanceRapide]
      by_cases h0 : n = 0
      · simp [h0]
      · rw [if_neg h0]
        have hr := ih (n / 2) (by omega)
        by_cases h2 : n % 2 = 0
        · rw [if_pos h2, hr, ← pow_add]
          congr 1
          omega
        · rw [if_neg h2, hr, ← pow_add, ← pow_succ']
          congr 1
          omega

/-- L'exponentiation rapide fait au plus `⌊log₂ n⌋ + 1` élévations au carré : chaque
appel divise l'exposant par deux, et l'on ne peut diviser par deux qu'un nombre
logarithmique de fois avant d'atteindre zéro. -/
theorem exponentiation_rapide_cout {n : ℕ} (hn : n ≠ 0) :
    coutPuissanceRapide n ≤ Nat.log 2 n + 1 := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
      rw [coutPuissanceRapide, if_neg hn]
      by_cases h1 : n = 1
      · simp [h1, coutPuissanceRapide]
      · -- `n ≥ 2` : l'exposant moitié est encore non nul, et son logarithme vaut un
        -- de moins que celui de `n`.
        have hn2 : 2 ≤ n := by omega
        have hdiv : n / 2 ≠ 0 := by omega
        have hrec := ih (n / 2) (by omega) hdiv
        have hlog : 0 < Nat.log 2 n := Nat.log_pos (by norm_num) hn2
        have hstep : Nat.log 2 (n / 2) = Nat.log 2 n - 1 := Nat.log_div_base 2 n
        omega

/-! ## Tours de Hanoï -/

/-- Le nombre de déplacements de la solution récursive : pour déplacer `n + 1`
disques, on déplace les `n` plus petits sur le piquet libre, on déplace le grand, on
remet les `n` petits dessus. -/
def hanoi : ℕ → ℕ
  | 0 => 0
  | n + 1 => 2 * hanoi n + 1

/-- La solution récursive demande `2ⁿ − 1` déplacements. L'égalité est écrite sous la
forme `hanoi n + 1 = 2ⁿ` pour éviter la soustraction tronquée des entiers naturels,
où `0 − 1` vaudrait `0`. -/
theorem tours_de_hanoi (n : ℕ) : hanoi n + 1 = 2 ^ n := by
  induction n with
  | zero => simp [hanoi]
  | succ k hk =>
      rw [hanoi, pow_succ]
      omega

/-- Aucune solution ne fait mieux.

L'hypothèse `hgrand` est la seule observation qu'on demande sur les déplacements :
pour déplacer `n + 1` disques, il faut bien à un moment déplacer le plus grand, et à
cet instant les `n` autres sont tous sur le piquet restant — il a donc fallu les y
amener, puis les ramener ensuite, d'où au moins `2f(n) + 1` déplacements. La
récurrence en tire la minoration pour tout `n`.

Ce que cet énoncé ne formalise pas : cette observation elle-même, qui demanderait de
modéliser les configurations et les déplacements licites. Elle est portée par
l'hypothèse, écrite en toutes lettres. -/
theorem tours_de_hanoi_optimal (f : ℕ → ℕ) (h0 : f 0 = 0)
    (hgrand : ∀ n, 2 * f n + 1 ≤ f (n + 1)) (n : ℕ) : hanoi n ≤ f n := by
  induction n with
  | zero => simp [hanoi, h0]
  | succ k hk =>
      have := hgrand k
      rw [hanoi]
      omega

/-! ## Diviser pour régner -/

/-- Le coût d'un algorithme qui coupe le problème en deux moitiés, les traite, puis
recolle en temps linéaire — c'est le schéma du tri fusion. La variable est ici le
nombre d'étages `k`, c'est-à-dire la taille `n = 2ᵏ`. -/
def coutDiviserPourRegner : ℕ → ℕ
  | 0 => 0
  | k + 1 => 2 * coutDiviserPourRegner k + 2 ^ (k + 1)

/-- Le coût vaut `n log₂ n` : pour `n = 2ᵏ`, il vaut `k · 2ᵏ`.

C'est l'énoncé `T(n) = 2T(n/2) + n` résolu. On le lit ainsi : il y a `k = log₂ n`
étages de découpe, et chaque étage coûte `n` au total, puisque les recollements d'un
même étage portent ensemble sur les `n` éléments. -/
theorem diviser_pour_regner (k : ℕ) : coutDiviserPourRegner k = k * 2 ^ k := by
  induction k with
  | zero => simp [coutDiviserPourRegner]
  | succ m hm =>
      rw [coutDiviserPourRegner, hm, pow_succ]
      ring

end Lycee.Nsi
