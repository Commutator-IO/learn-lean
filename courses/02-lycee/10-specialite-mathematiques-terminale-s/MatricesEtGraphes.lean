/-
Lycée — spécialité de terminale S, section « Matrices et graphes ».
Les matrices sont celles de Mathlib : `Matrix (Fin n) (Fin n) ℝ` est le type des tableaux
carrés de taille `n`, `!![a, b; c, d]` la notation d'une matrice `2 × 2`, et `A.mulVec X`
le produit d'une matrice par un vecteur colonne.
Énoncés et démonstrations en français : voir MatricesEtGraphes.tex.
-/
import Mathlib

namespace Lycee.Matrices

open Matrix

/-! ## Opérations sur les matrices -/

/-- Le produit matriciel est associatif et distributif sur l'addition. -/
theorem operations_matricielles {n : ℕ} (A B C : Matrix (Fin n) (Fin n) ℝ) :
    A * (B * C) = A * B * C ∧ A * (B + C) = A * B + A * C :=
  ⟨(Matrix.mul_assoc A B C).symm, Matrix.mul_add A B C⟩

/-- Mais il n'est pas commutatif : deux matrices `2 × 2` suffisent à le montrer. -/
example :
    (!![0, 1; 0, 0] : Matrix (Fin 2) (Fin 2) ℝ) * !![0, 0; 1, 0]
      ≠ !![0, 0; 1, 0] * (!![0, 1; 0, 0] : Matrix (Fin 2) (Fin 2) ℝ) := by
  intro h
  have h00 := congrFun (congrFun h 0) 0
  norm_num [Matrix.mul_apply, Fin.sum_univ_two] at h00

/-! ## Matrice inversible -/

/-- Le déterminant d'une matrice `2 × 2` est `ad − bc`, et lorsqu'il n'est pas nul, la
matrice est inversible d'inverse `(1/(ad − bc)) · !![d, −b; −c, a]`. -/
theorem inverse_matrice_2x2 {a b c d : ℝ} (h : a * d - b * c ≠ 0) :
    (!![a, b; c, d] : Matrix (Fin 2) (Fin 2) ℝ).det = a * d - b * c ∧
      (!![a, b; c, d] : Matrix (Fin 2) (Fin 2) ℝ) *
          ((a * d - b * c)⁻¹ • !![d, -b; -c, a]) = 1 ∧
      ((a * d - b * c)⁻¹ • !![d, -b; -c, a]) *
          (!![a, b; c, d] : Matrix (Fin 2) (Fin 2) ℝ) = 1 := by
  have h' : -(c * b) + a * d ≠ 0 := fun hc => h (by linarith)
  have h'' : a * d - c * b ≠ 0 := fun hc => h (by linarith)
  refine ⟨Matrix.det_fin_two_of a b c d, ?_, ?_⟩ <;>
  · ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.mul_apply, Fin.sum_univ_two] <;> field_simp <;> ring

/-! ## Écriture matricielle d'un système -/

/-- Écriture matricielle d'un système linéaire : si `A` est inversible, le système
`AX = B` a une solution et une seule, `X = A⁻¹B`. -/
theorem systeme_matriciel {n : ℕ} {A : Matrix (Fin n) (Fin n) ℝ} (hA : IsUnit A.det)
    (B : Fin n → ℝ) : ∃! X : Fin n → ℝ, A.mulVec X = B := by
  refine ⟨A⁻¹.mulVec B, ?_, ?_⟩
  · show A.mulVec (A⁻¹.mulVec B) = B
    rw [Matrix.mulVec_mulVec, Matrix.mul_nonsing_inv A hA, Matrix.one_mulVec]
  · intro Y hY
    rw [← hY, Matrix.mulVec_mulVec, Matrix.nonsing_inv_mul A hA, Matrix.one_mulVec]

/-! ## Puissances d'une matrice -/

/-- Puissances d'une matrice diagonale : elles s'obtiennent en élevant les coefficients
diagonaux à la puissance. -/
theorem puissances_d_une_diagonale {n : ℕ} (d : Fin n → ℝ) (k : ℕ) :
    (Matrix.diagonal d) ^ k = Matrix.diagonal (d ^ k) :=
  Matrix.diagonal_pow d k

/-- Puissances par diagonalisation : si `A = PDP⁻¹`, alors `Aⁿ = PDⁿP⁻¹`, ce qui ramène le
calcul des puissances de `A` à celui des puissances de `D`. -/
theorem puissances_par_diagonalisation {n : ℕ} (P D : Matrix (Fin n) (Fin n) ℝ)
    (hP : IsUnit P.det) (k : ℕ) : (P * D * P⁻¹) ^ k = P * D ^ k * P⁻¹ := by
  induction k with
  | zero => simp [Matrix.mul_nonsing_inv P hP]
  | succ m ih =>
    have hPP : P⁻¹ * P = 1 := Matrix.nonsing_inv_mul P hP
    rw [pow_succ, ih, pow_succ]
    calc P * D ^ m * P⁻¹ * (P * D * P⁻¹)
        = P * D ^ m * (P⁻¹ * P) * D * P⁻¹ := by simp only [Matrix.mul_assoc]
      _ = P * D ^ m * D * P⁻¹ := by rw [hPP, Matrix.mul_one]
      _ = P * (D ^ m * D) * P⁻¹ := by simp only [Matrix.mul_assoc]

/-! ## Suites de matrices colonnes -/

/-- Suite `Uₙ₊₁ = AUₙ + B` : si `U*` est un état stable, c'est-à-dire `U* = AU* + B`,
alors l'écart à l'état stable se propage par `Uₙ − U* = Aⁿ(U₀ − U*)`. -/
theorem suite_matricielle {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (B : Fin n → ℝ)
    (U : ℕ → (Fin n → ℝ)) (hU : ∀ k, U (k + 1) = A.mulVec (U k) + B)
    (Ustar : Fin n → ℝ) (hstar : Ustar = A.mulVec Ustar + B) (k : ℕ) :
    U k - Ustar = (A ^ k).mulVec (U 0 - Ustar) := by
  induction k with
  | zero => simp
  | succ m ih =>
    have h1 : U (m + 1) - Ustar = A.mulVec (U m - Ustar) := by
      rw [Matrix.mulVec_sub, hU m]
      nth_rewrite 1 [hstar]
      abel
    rw [h1, ih, Matrix.mulVec_mulVec, ← pow_succ']

/-! ## Graphe probabiliste -/

/-- Graphe probabiliste à deux états, de matrice de transition `!![1−a, a; b, 1−b]` avec
`a` et `b` strictement positifs. L'état `(b/(a+b), a/(a+b))` est stable ; l'écart à cet
état est multiplié par `1 − a − b` à chaque étape ; et comme `|1 − a − b| < 1`, cet écart
tend vers zéro : la suite des états converge vers l'état stable, quel que soit l'état
initial. -/
theorem graphe_probabiliste {a b : ℝ} (ha : 0 < a) (hb : 0 < b) (hab : a + b < 2)
    {u₀ u₁ : ℝ} (hu : u₀ + u₁ = 1) :
    b / (a + b) * (1 - a) + a / (a + b) * b = b / (a + b) ∧
      u₀ * (1 - a) + u₁ * b - b / (a + b) = (1 - a - b) * (u₀ - b / (a + b)) ∧
      |1 - a - b| < 1 ∧
      Filter.Tendsto (fun k : ℕ => (1 - a - b) ^ k * (u₀ - b / (a + b))) Filter.atTop
        (nhds 0) := by
  have hs : a + b ≠ 0 := by positivity
  have habs : |1 - a - b| < 1 := by
    rw [abs_lt]
    constructor <;> linarith
  refine ⟨by field_simp; ring, ?_, habs, ?_⟩
  · field_simp
    linear_combination (b * (a + b)) * hu
  · simpa using
      (tendsto_pow_atTop_nhds_zero_of_abs_lt_one habs).mul_const (u₀ - b / (a + b))

end Lycee.Matrices
