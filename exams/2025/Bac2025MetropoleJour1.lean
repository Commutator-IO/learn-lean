/-
Baccalauréat, épreuve de spécialité — voie générale, Métropole, 17 juin 2025 (jour 1).

Chaque question du sujet qui porte une proposition mathématique devient ici un
théorème. Celles qui n'en portent pas — compléter un arbre pondéré, lire un nombre
dérivé sur un graphique, compléter un algorithme, interpréter un résultat — n'ont pas
d'énoncé, et l'index du dossier dit lesquelles et pourquoi.

Les probabilités sont traitées comme le sujet les traite : sur les nombres. La
construction de l'espace probabilisé n'apporterait rien à des calculs qui portent sur
des probabilités données, et le chapitre « Probabilités et statistiques » du cours
fait ce travail-là pour ses propres énoncés.
-/
import Mathlib

namespace Bac.Metropole2025.Jour1

/-! ## Exercice 1 — groupes sanguins, loi binomiale, Bienaymé-Tchebychev -/

/-- Question 2 : `p(B ∩ R) = p(B) × p_B(R) = 0,10 × 0,84 = 0,084`.

C'est la lecture d'un chemin de l'arbre : les probabilités s'y multiplient. -/
theorem ex1_groupe_b_rhesus_positif : (0.10 : ℚ) * 0.84 = 0.084 := by norm_num

/-- Question 3 : `p_O(R) = 0,83`.

Le groupe `O` est le complémentaire des trois autres, donc `p(O) = 1 − 0,45 − 0,10 −
0,03 = 0,42`. La formule des probabilités totales décompose `p(R)` sur les quatre
groupes : `p(O ∩ R) = 0,839 7 − 0,45 × 0,85 − 0,10 × 0,84 − 0,03 × 0,82 = 0,348 6`, et
il ne reste qu'à diviser par `p(O)`. -/
theorem ex1_rhesus_sachant_o :
    (1 : ℚ) - 0.45 - 0.10 - 0.03 = 0.42 ∧
      ((0.8397 : ℚ) - 0.45 * 0.85 - 0.10 * 0.84 - 0.03 * 0.82) / 0.42 = 0.83 := by
  norm_num

/-- Question 4 : la probabilité d'être donneur universel vaut `0,071 4`.

Un donneur universel est du groupe `O` et de rhésus négatif : `p(O ∩ R̄) = p(O) ×
(1 − p_O(R)) = 0,42 × 0,17`. -/
theorem ex1_donneur_universel : (0.42 : ℚ) * (1 - 0.83) = 0.0714 := by norm_num

/-- Question 5c : `E(X) = 7,14` et `V(X) = 6,63` à `10⁻²` près.

Pour une loi binomiale de paramètres `n` et `p`, l'espérance vaut `np` et la variance
`np(1 − p)` : ce sont les deux formules du cours, et le sujet ne demande que de les
appliquer. La variance exacte est `6,629 604`, dont l'arrondi au centième est `6,63`. -/
theorem ex1_esperance_variance :
    (100 : ℚ) * 0.0714 = 7.14 ∧ |(100 : ℚ) * 0.0714 * (1 - 0.0714) - 6.63| < 0.005 := by
  refine ⟨by norm_num, ?_⟩
  rw [abs_lt]
  norm_num

/-- Question 6b : `E(M_N) = 7,14`, quel que soit le nombre `N` de villes.

L'espérance est linéaire : celle d'une moyenne de variables de même espérance est
cette espérance. Grouper les villes ne change donc rien à ce qu'on attend en
moyenne. -/
theorem ex1_esperance_moyenne {N : ℚ} (hN : N ≠ 0) : N * 7.14 / N = 7.14 := by
  field_simp

/-- Question 6c : `V(M_N) = 6,63/N`.

Les variables étant indépendantes, leurs variances s'ajoutent ; la division par `N`
étant une multiplication par `1/N`, elle divise la variance par `N²`. C'est là que
l'hypothèse d'indépendance sert, et nulle part ailleurs — et c'est ce quotient par
`N` qui fait que la moyenne se resserre quand on multiplie les villes. -/
theorem ex1_variance_moyenne {N : ℚ} (hN : N ≠ 0) : N * 6.63 / N ^ 2 = 6.63 / N := by
  field_simp

/-- Question 6d : la plus petite valeur de `N` convenable est `6 766`.

L'inégalité de Bienaymé-Tchebychev majore `P(|M_N − 7,14| ≥ 0,14)` par
`V(M_N)/0,14² = 6,63/(0,019 6 N)`. Pour que l'évènement contraire — c'est-à-dire
`7 < M_N < 7,28` — ait une probabilité au moins `0,95`, il suffit que cette majoration
descende à `0,05`, soit `N ≥ 6 765,3…`.

L'inégalité obtenue sur les rationnels est stricte à `6 765` et vraie à `6 766` : le
seuil n'est pas entier, et c'est le passage à l'entier supérieur qui donne la
réponse. -/
theorem ex1_bienayme_tchebychev {N : ℕ} (hN : 0 < N) :
    (6.63 : ℚ) / (N * 0.14 ^ 2) ≤ 0.05 ↔ 6766 ≤ N := by
  have hpos : (0 : ℚ) < (N : ℚ) := by exact_mod_cast hN
  rw [div_le_iff₀ (by positivity)]
  constructor
  · intro h
    have h' : (6765 : ℚ) < (N : ℚ) := by nlinarith
    have : 6765 < N := by exact_mod_cast h'
    omega
  · intro h
    have : (6766 : ℚ) ≤ (N : ℚ) := by exact_mod_cast h
    nlinarith

/-! ## Exercice 2 — une fonction avec un logarithme -/

/-- La fonction de l'exercice : `f(x) = x[2(ln x)² − 3 ln x + 2]`, sur `]0 ; +∞[`. -/
noncomputable def f (x : ℝ) : ℝ := x * (2 * Real.log x ^ 2 - 3 * Real.log x + 2)

/-- Partie B, question 1 : l'équation `2X² − 3X + 2 = 0` n'a pas de solution réelle,
et la courbe de `f` ne coupe donc pas l'axe des abscisses.

Le discriminant vaut `9 − 16 = −7 < 0`. Ce qui se démontre le plus directement est
la mise sous forme canonique : `2X² − 3X + 2 = 2(X − 3/4)² + 7/8 ≥ 7/8 > 0`. Le
crochet ne s'annulant pas et `x` étant strictement positif, `f(x)` ne s'annule pas
non plus. -/
theorem ex2_pas_de_racine (X : ℝ) : 2 * X ^ 2 - 3 * X + 2 ≥ 7 / 8 := by
  nlinarith [sq_nonneg (X - 3 / 4)]

/-- Le corollaire : `f` ne s'annule sur `]0 ; +∞[`. -/
theorem ex2_ne_sannule_pas {x : ℝ} (hx : 0 < x) : f x ≠ 0 := by
  have h := ex2_pas_de_racine (Real.log x)
  have hpos : 0 < 2 * Real.log x ^ 2 - 3 * Real.log x + 2 := by linarith
  have hfx : f x = x * (2 * Real.log x ^ 2 - 3 * Real.log x + 2) := rfl
  rw [hfx]
  exact ne_of_gt (mul_pos hx hpos)

/-- Partie B, question 2 : `f` tend vers `+∞` en `+∞`.

Le sujet passe par la forme `x[2(ln x)² − 3 ln x + 2]` et le fait que le crochet tend
vers `+∞`. La minoration de la question précédente suffit et dit davantage : le
crochet reste au-dessus de `7/8`, donc `f(x) ≥ 7x/8`, et une fonction minorée par une
fonction qui tend vers `+∞` tend vers `+∞`. -/
theorem ex2_limite_en_plus_infini :
    Filter.Tendsto f Filter.atTop Filter.atTop := by
  have hmono : Filter.Tendsto (fun x : ℝ => 7 / 8 * x) Filter.atTop Filter.atTop :=
    Filter.Tendsto.const_mul_atTop (by norm_num) Filter.tendsto_id
  refine Filter.tendsto_atTop_mono' _ ?_ hmono
  filter_upwards [Filter.eventually_gt_atTop (0 : ℝ)] with x hx
  have h := ex2_pas_de_racine (Real.log x)
  have hmul : 7 / 8 * x ≤ (2 * Real.log x ^ 2 - 3 * Real.log x + 2) * x :=
    mul_le_mul_of_nonneg_right h hx.le
  have hf : f x = (2 * Real.log x ^ 2 - 3 * Real.log x + 2) * x := by rw [f]; ring
  rw [hf]
  exact hmul

/-- Partie B, question 3a : `f″(x) = (4 ln x + 1)/x` sur `]0 ; +∞[`.

Le sujet admet `f′(x) = 2(ln x)² + ln x − 1` ; la dérivée seconde s'en déduit en
dérivant terme à terme, `(ln x)²` donnant `2 ln x / x`. -/
theorem ex2_derivee_seconde {x : ℝ} (hx : 0 < x) :
    HasDerivAt (fun t => 2 * Real.log t ^ 2 + Real.log t - 1) ((4 * Real.log x + 1) / x) x := by
  have hlog : HasDerivAt Real.log x⁻¹ x := Real.hasDerivAt_log (ne_of_gt hx)
  have hcarre := hlog.fun_pow 2
  refine (((hcarre.const_mul (2 : ℝ)).add hlog).sub_const (1 : ℝ)).congr_deriv ?_
  push_cast
  field_simp
  ring

/-- Partie B, question 3b : la dérivée seconde est positive si et seulement si
`x ≥ e^(−1/4)`.

C'est le signe de `4 ln x + 1`, le dénominateur `x` étant positif. La fonction est
donc concave avant `e^(−1/4)`, convexe après, et ce point est son point d'inflexion :
l'abscisse exacte est `e^(−1/4)`, non une valeur décimale.

Ce qui est démontré est le signe ; la convexité s'en déduit par le critère du cours,
qui n'est pas repris ici. -/
theorem ex2_signe_derivee_seconde {x : ℝ} (hx : 0 < x) :
    0 ≤ (4 * Real.log x + 1) / x ↔ Real.exp (-(1 / 4)) ≤ x := by
  rw [le_div_iff₀ hx, zero_mul, ← Real.le_log_iff_exp_le hx]
  constructor <;> intro h <;> linarith

/-- Partie C, question 1 : la tangente à la courbe au point `B(e ; e)` a pour
équation réduite `y = 2x − e`.

En `x = e`, le logarithme vaut `1` : `f(e) = e(2 − 3 + 2) = e` et
`f′(e) = 2 + 1 − 1 = 2`. L'équation de la tangente est
`y = f′(e)(x − e) + f(e) = 2x − e`. -/
theorem ex2_tangente : f (Real.exp 1) = Real.exp 1 ∧
    2 * Real.log (Real.exp 1) ^ 2 + Real.log (Real.exp 1) - 1 = 2 := by
  simp [f, Real.log_exp]
  ring

/-- Partie C, question 3 : l'aire du domaine hachuré vaut `(3e² − 4e − 5)/4` unités
d'aire.

Le domaine est compris entre la courbe et sa tangente, entre `x = 1` et `x = e` :
son aire est `∫₁^e (f(x) − (2x − e)) dx`, et l'intégrande se simplifie en
`2x(ln x)² − 3x ln x + e`. Les deux intégrales sont celles de la question 2 et de
l'énoncé — `(e² + 1)/4` et `(e² − 1)/4` — et sont ici prises en hypothèse, comme le
sujet les admet. Reste `2(e²−1)/4 − 3(e²+1)/4 + e(e−1)`. -/
theorem ex2_aire {I J : ℝ} (hI : I = (Real.exp 1 ^ 2 + 1) / 4)
    (hJ : J = (Real.exp 1 ^ 2 - 1) / 4) :
    2 * J - 3 * I + Real.exp 1 * (Real.exp 1 - 1) =
      (3 * Real.exp 1 ^ 2 - 4 * Real.exp 1 - 5) / 4 := by
  subst hI hJ; ring

/-! ## Exercice 3 — vrai ou faux dans l'espace -/

/-- Affirmation 1, **vraie**. Le vecteur directeur proposé est `(−2 ; −1 ; 3)`, et
`AB = (4 ; 2 ; −6) = −2 × (−2 ; −1 ; 3)` : il est colinéaire à `AB`. Le point obtenu
pour `t = 0` est `B(3 ; 2 ; −1)`, qui appartient à la droite. La représentation
paramétrique est donc bien celle de `(AB)`. -/
theorem ex3_affirmation_1 :
    ((3 : ℚ) - -1, (2 : ℚ) - 0, (-1 : ℚ) - 5) = (-2 * -2, -2 * -1, -2 * 3) := by
  norm_num

/-- Affirmation 2, **fausse**. Le vecteur `n = (5 ; −2 ; 1)` est bien orthogonal à
`OA` — le produit scalaire vaut `−5 + 0 + 5 = 0` — mais pas à `OB`, où il vaut
`15 − 4 − 1 = 10`. Un vecteur normal à un plan doit être orthogonal à deux vecteurs
non colinéaires du plan : une seule orthogonalité ne suffit pas, et c'est le piège de
l'affirmation. -/
theorem ex3_affirmation_2 :
    (5 * (-1 : ℚ) + -2 * 0 + 1 * 5 = 0) ∧ (5 * (3 : ℚ) + -2 * 2 + 1 * -1 ≠ 0) := by
  norm_num

/-- Affirmation 3, **fausse** : les droites `d` et `d′` sont sécantes, donc
coplanaires.

Le système donné par les deux premières coordonnées a pour solution `s = 5/2` et
`k = −4`, et la troisième coordonnée est alors satisfaite aussi : les deux droites
passent par `(−9 ; 12 ; −14)`. Démontrer qu'une affirmation d'existence est fausse
c'est exhiber le point, et c'est plus court que de raisonner sur les vecteurs. -/
theorem ex3_affirmation_3 :
    ∃ k s : ℚ, 15 + k = 1 + 4 * s ∧ 8 - k = 2 + 4 * s ∧ -6 + 2 * k = 1 - 6 * s := by
  exact ⟨-4, 5 / 2, by norm_num, by norm_num, by norm_num⟩

/-- Affirmation 4, **vraie** : la distance de `C(2 ; −1 ; 2)` au plan
`x − y + z + 1 = 0` vaut `2√3`.

La formule donne `|2 + 1 + 2 + 1|/√(1 + 1 + 1) = 6/√3`, et `6/√3 = 2√3` — c'est la
même valeur écrite sans radical au dénominateur. -/
theorem ex3_affirmation_4 :
    |(2 : ℝ) - -1 + 2 + 1| / Real.sqrt (1 + 1 + 1) = 2 * Real.sqrt 3 := by
  have h3 : Real.sqrt 3 > 0 := Real.sqrt_pos.2 (by norm_num)
  have hsq : Real.sqrt 3 * Real.sqrt 3 = 3 := Real.mul_self_sqrt (by norm_num)
  rw [show (1 : ℝ) + 1 + 1 = 3 by norm_num, abs_of_nonneg (by norm_num : (0:ℝ) ≤ 2 - -1 + 2 + 1)]
  field_simp
  nlinarith [hsq]

/-! ## Exercice 4 — la posidonie -/

/-- La suite du modèle discret : `u₀ = 1` et `u_{n+1} = −0,02u_n² + 1,3u_n`. -/
noncomputable def u : ℕ → ℝ
  | 0 => 1
  | n + 1 => -0.02 * u n ^ 2 + 1.3 * u n

/-- La relation de récurrence, sous la forme où les preuves l'utilisent. -/
theorem u_succ (n : ℕ) : u (n + 1) = -0.02 * u n ^ 2 + 1.3 * u n := rfl

/-- Partie A, question 1 : au premier juillet 2025, la posidonie recouvre
`1,28 hectare`. -/
theorem ex4_u1 : u 1 = 1.28 := by
  rw [u_succ]
  norm_num [u]

/-- Partie A, question 2a : pour tout `n`, `1 ≤ u_n ≤ u_{n+1} ≤ 20`.

La récurrence porte sur les trois inégalités à la fois, et c'est nécessaire : la
croissance de `n` à `n+1` se déduit de celle de `n−1` à `n` en appliquant `h`, non
d'un raisonnement sur le point fixe — la fonction `h(x) = −0,02x² + 1,3x` est
croissante sur `[0 ; 20]`, ce que le sujet admet et que les inégalités polynomiales
retrouvent directement. Sans le majorant `20`, cette monotonie tomberait : `h`
décroît au-delà de `32,5`. -/
theorem ex4_encadrement (n : ℕ) : 1 ≤ u n ∧ u n ≤ u (n + 1) ∧ u (n + 1) ≤ 20 := by
  have hcroissante : ∀ a b : ℝ, 0 ≤ a → a ≤ b → b ≤ 20 →
      -0.02 * a ^ 2 + 1.3 * a ≤ -0.02 * b ^ 2 + 1.3 * b := by
    intro a b ha hab hb
    nlinarith [mul_nonneg (sub_nonneg.2 hab) (by linarith : (0 : ℝ) ≤ 1.3 - 0.02 * (a + b))]
  have hmajoree : ∀ b : ℝ, 1 ≤ b → b ≤ 20 → -0.02 * b ^ 2 + 1.3 * b ≤ 20 := by
    intro b h1 h2
    nlinarith [mul_nonneg (by linarith : (0 : ℝ) ≤ 25 - b) (by linarith : (0 : ℝ) ≤ 40 - b)]
  induction n with
  | zero =>
    refine ⟨by norm_num [u], ?_, ?_⟩
    · rw [u_succ]; norm_num [u]
    · rw [u_succ]; norm_num [u]
  | succ n ih =>
    obtain ⟨h1, h2, h3⟩ := ih
    have hun1 : (1 : ℝ) ≤ u (n + 1) := le_trans h1 h2
    refine ⟨hun1, ?_, ?_⟩
    · rw [u_succ (n + 1), u_succ n]
      exact hcroissante (u n) (u (n + 1)) (by linarith) h2 h3
    · rw [u_succ (n + 1)]
      exact hmajoree (u (n + 1)) hun1 h3

/-- Partie A, question 2c : la limite de la suite vaut `15 hectares`.

Si la suite converge vers `L`, la limite vérifie `L = −0,02L² + 1,3L`, c'est-à-dire
`0,02L² = 0,3L` : les points fixes sont `0` et `15`. La suite étant minorée par `1`,
sa limite l'est aussi, et `L = 15`. La zone étudiée fait `20 hectares` : le modèle
prévoit donc que la posidonie n'en recouvrira jamais toute la surface. -/
theorem ex4_limite {L : ℝ} (hL : 1 ≤ L) (h : L = -0.02 * L ^ 2 + 1.3 * L) : L = 15 := by
  have h0 : L * (L - 15) = 0 := by nlinarith
  rcases mul_eq_zero.1 h0 with h1 | h1
  · linarith
  · linarith

/-- Partie B, question 1 : `g = 1/f` est solution de `y′ = −0,3y + 0,02`.

C'est le changement de fonction qui rend l'équation linéaire : la dérivée de `1/f`
vaut `−f′/f²`, et en remplaçant `f′` par `0,02f(15 − f)` il reste
`−0,02(15 − f)/f = −0,3/f + 0,02`, soit `−0,3g + 0,02`. C'est le seul endroit où
l'hypothèse « `f` ne s'annule pas » sert. -/
theorem ex4_changement_de_fonction {F : ℝ → ℝ} {t : ℝ} (hne : F t ≠ 0)
    (hF : HasDerivAt F (0.02 * F t * (15 - F t)) t) :
    HasDerivAt (fun s => 1 / F s) (-0.3 * (1 / F t) + 0.02) t := by
  have h := (hasDerivAt_const t (1 : ℝ)).div hF hne
  have heq : (0 * F t - 1 * (0.02 * F t * (15 - F t))) / F t ^ 2 = -0.3 * (1 / F t) + 0.02 := by
    field_simp
    ring
  rw [heq] at h
  exact h

/-- Partie B, question 3 : `f(t) = 15/(14e^(−0,3t) + 1)`.

Les solutions de `(E₂)` sont les `t ↦ Ce^(−0,3t) + 1/15`, et `g(0) = 1/f(0) = 1`
donne `C = 14/15`. Il ne reste qu'à inverser : `f = 1/g`, et le dénominateur ne
s'annule pas puisque l'exponentielle est positive. -/
theorem ex4_expression (t : ℝ) : 1 / (14 / 15 * Real.exp (-0.3 * t) + 1 / 15) =
    15 / (14 * Real.exp (-0.3 * t) + 1) := by
  have h : (0 : ℝ) < 14 * Real.exp (-0.3 * t) + 1 := by positivity
  rw [eq_div_iff (ne_of_gt h)]
  field_simp

/-- Partie B, question 4 : la superficie tend vers `15 hectares`.

L'exponentielle `e^(−0,3t)` tend vers `0`, donc le dénominateur vers `1`. Le modèle
continu et le modèle discret donnent la même limite, ce qui est le seul point commun
qu'on leur demande. -/
theorem ex4_limite_continue :
    Filter.Tendsto (fun t : ℝ => 15 / (14 * Real.exp (-0.3 * t) + 1)) Filter.atTop
      (nhds 15) := by
  have hexp : Filter.Tendsto (fun t : ℝ => Real.exp (-0.3 * t)) Filter.atTop (nhds 0) := by
    simpa [neg_mul] using
      Filter.Tendsto.const_mul_atTop (by norm_num : (0 : ℝ) < 0.3) Filter.tendsto_id
  have hden : Filter.Tendsto (fun t : ℝ => 14 * Real.exp (-0.3 * t) + 1) Filter.atTop
      (nhds 1) := by
    simpa using (hexp.const_mul 14).add_const 1
  have hinv := hden.inv₀ (by norm_num)
  simpa [div_eq_mul_inv] using hinv.const_mul (15 : ℝ)

/-- Partie B, question 5 : la superficie dépasse `14 hectares` après
`t > (10/3) ln 196`, soit environ `17,6` années — donc dans le courant de l'année
2042.

L'inéquation `15/(14e^(−0,3t) + 1) > 14` équivaut à `e^(−0,3t) < 1/196`, c'est-à-dire
`−0,3t < −ln 196`. Le seuil exact est `(ln 196)/0,3` : la valeur décimale ne se lit
qu'à la calculatrice, mais l'équivalence est exacte. -/
theorem ex4_seuil (t : ℝ) :
    15 / (14 * Real.exp (-0.3 * t) + 1) > 14 ↔ Real.log 196 / 0.3 < t := by
  have hpos : (0 : ℝ) < 14 * Real.exp (-0.3 * t) + 1 := by positivity
  have cle : Real.exp (-0.3 * t) < 1 / 196 ↔ -0.3 * t < -Real.log 196 := by
    rw [← Real.lt_log_iff_exp_lt (by norm_num : (0 : ℝ) < 1 / 196), one_div, Real.log_inv]
  rw [gt_iff_lt, lt_div_iff₀ hpos, div_lt_iff₀ (by norm_num : (0 : ℝ) < 0.3)]
  constructor
  · intro h
    have h1 : Real.exp (-0.3 * t) < 1 / 196 := by nlinarith
    have h2 := cle.1 h1
    linarith
  · intro h
    have h2 : -0.3 * t < -Real.log 196 := by linarith
    have h1 := cle.2 h2
    nlinarith

end Bac.Metropole2025.Jour1
