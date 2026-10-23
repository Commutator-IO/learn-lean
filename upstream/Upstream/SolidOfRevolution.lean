import Mathlib

/-!
# Rétroportage de la branche mathlib4 `feat/solid-of-revolution`

Volume des solides de révolution et du cône dans `ℝ × ℝ × ℝ`, par la méthode des disques.
Proposés à mathlib4 depuis le fork mycaule/mathlib4 (PR 44769, fermée en amont le 2026-10-22),
ils sont gardés ici contre la version épinglée de Mathlib, en dimension 3 seulement, et à
retirer dès que Mathlib les a.
-/

open MeasureTheory Set
open scoped ENNReal Real

namespace Upstream

/-- L'aire du disque, au sens de la mesure du plan. -/
theorem volume_disque (r : ℝ) :
    volume {q : ℝ × ℝ | q.1 ^ 2 + q.2 ^ 2 ≤ r ^ 2} = ENNReal.ofReal (π * r ^ 2) := by
  have hset : {q : ℝ × ℝ | q.1 ^ 2 + q.2 ^ 2 ≤ r ^ 2} =
      Complex.measurableEquivRealProd.symm ⁻¹' Metric.closedBall (0 : ℂ) |r| := by
    ext q
    have hq : Complex.measurableEquivRealProd.symm q = ⟨q.1, q.2⟩ := rfl
    change q.1 ^ 2 + q.2 ^ 2 ≤ r ^ 2 ↔ _
    rw [mem_preimage, hq, Metric.mem_closedBall, dist_zero_right, Complex.norm_def,
      Complex.normSq_mk, Real.sqrt_le_left (abs_nonneg r), sq_abs]
    exact ⟨fun h => by nlinarith [h], fun h => by nlinarith [h]⟩
  rw [hset, Complex.volume_preserving_equiv_real_prod.symm.measure_preimage_equiv,
    Complex.volume_closedBall]
  rw [← ENNReal.ofReal_pow (abs_nonneg r), sq_abs, ← ENNReal.ofReal_coe_nnreal,
    ← ENNReal.ofReal_mul (sq_nonneg r), mul_comm]
  simp

/-- Le volume d'un solide de révolution est l'intégrale des aires de ses tranches. -/
theorem volume_solidOfRevolution {f : ℝ → ℝ} {a b : ℝ} (hf : Continuous f) :
    volume {p : ℝ × ℝ × ℝ | p.1 ∈ Icc a b ∧ p.2.1 ^ 2 + p.2.2 ^ 2 ≤ f p.1 ^ 2} =
      ∫⁻ x in Icc a b, ENNReal.ofReal (π * f x ^ 2) := by
  have hmeas : MeasurableSet {p : ℝ × ℝ × ℝ | p.1 ∈ Icc a b ∧ p.2.1 ^ 2 + p.2.2 ^ 2 ≤ f p.1 ^ 2} :=
    (measurableSet_Icc.preimage measurable_fst).inter
      (measurableSet_le (f := fun p : ℝ × ℝ × ℝ => p.2.1 ^ 2 + p.2.2 ^ 2)
        (g := fun p : ℝ × ℝ × ℝ => f p.1 ^ 2) (by fun_prop)
        (by have := hf.measurable; fun_prop))
  rw [Measure.volume_eq_prod, Measure.prod_apply hmeas, ← lintegral_indicator measurableSet_Icc]
  refine lintegral_congr fun x => ?_
  by_cases hx : x ∈ Icc a b
  · have : Prod.mk x ⁻¹' {p : ℝ × ℝ × ℝ | p.1 ∈ Icc a b ∧ p.2.1 ^ 2 + p.2.2 ^ 2 ≤ f p.1 ^ 2} =
        {q : ℝ × ℝ | q.1 ^ 2 + q.2 ^ 2 ≤ f x ^ 2} := by
      have h₁ := hx.1
      have h₂ := hx.2
      ext q; simp [h₁, h₂]
    rw [this, volume_disque, indicator_of_mem hx]
  · have : Prod.mk x ⁻¹' {p : ℝ × ℝ × ℝ | p.1 ∈ Icc a b ∧ p.2.1 ^ 2 + p.2.2 ^ 2 ≤ f p.1 ^ 2} =
        ∅ := by
      ext q
      simp only [mem_preimage, mem_empty_iff_false, iff_false]
      exact fun h => hx h.1
    rw [this, indicator_of_notMem hx, measure_empty]

/-- La méthode des disques : `V = π ∫ₐᵇ f²`. -/
theorem volume_solidOfRevolution_eq {f : ℝ → ℝ} {a b : ℝ} (hab : a ≤ b) (hf : Continuous f) :
    volume {p : ℝ × ℝ × ℝ | p.1 ∈ Icc a b ∧ p.2.1 ^ 2 + p.2.2 ^ 2 ≤ f p.1 ^ 2} =
      ENNReal.ofReal (π * ∫ x in a..b, f x ^ 2) := by
  rw [volume_solidOfRevolution hf, ← ofReal_integral_eq_lintegral_ofReal]
  · rw [integral_Icc_eq_integral_Ioc, ← intervalIntegral.integral_of_le hab,
      intervalIntegral.integral_const_mul]
  · exact (by fun_prop : Continuous fun x => π * f x ^ 2).integrableOn_Icc
  · exact Filter.Eventually.of_forall fun x => by positivity

/-- Le cône de rayon `R` et de hauteur `H`, d'axe la dernière coordonnée. -/
theorem volume_cone {R H : ℝ} (hH : 0 < H) :
    volume {p : ℝ × ℝ × ℝ | 0 ≤ p.2.2 ∧ p.2.2 ≤ H ∧
        p.1 ^ 2 + p.2.1 ^ 2 ≤ (R * (1 - p.2.2 / H)) ^ 2} =
      ENNReal.ofReal (π * R ^ 2 * H / 3) := by
  let e : ℝ × ℝ × ℝ ≃ᵐ ℝ × ℝ × ℝ :=
    MeasurableEquiv.prodAssoc.symm.trans MeasurableEquiv.prodComm
  have he : MeasurePreserving e volume volume :=
    (measurePreserving_prodAssoc volume volume volume).symm.trans
      (Measure.measurePreserving_swap (μ := volume) (ν := volume))
  have hset : {p : ℝ × ℝ × ℝ | 0 ≤ p.2.2 ∧ p.2.2 ≤ H ∧
        p.1 ^ 2 + p.2.1 ^ 2 ≤ (R * (1 - p.2.2 / H)) ^ 2} =
      e ⁻¹' {p : ℝ × ℝ × ℝ | p.1 ∈ Icc 0 H ∧
        p.2.1 ^ 2 + p.2.2 ^ 2 ≤ (fun x => R * (1 - x / H)) p.1 ^ 2} := by
    ext p
    exact and_assoc.symm
  rw [hset, he.measure_preimage_equiv,
    volume_solidOfRevolution_eq (f := fun x => R * (1 - x / H)) hH.le (by fun_prop)]
  congr 1
  have hint : ∫ x in (0 : ℝ)..H, (R * (1 - x / H)) ^ 2 = R ^ 2 * H / 3 := by
    rw [intervalIntegral.integral_eq_sub_of_hasDerivAt
      (f := fun x => -(R ^ 2 * H / 3) * (1 - x / H) ^ 3)]
    · field_simp
      ring
    · intro x _
      have h₁ : HasDerivAt (fun x : ℝ => 1 - x / H) (-(1 / H)) x := by
        simpa using ((hasDerivAt_id x).div_const H).const_sub 1
      refine ((h₁.pow 3).const_mul (-(R ^ 2 * H / 3))).congr_deriv ?_
      have hH' : H ≠ 0 := hH.ne'
      field_simp
      linear_combination (3 * R ^ 2 * (x - H) ^ 2 * (H * H⁻¹ + 1)) * mul_inv_cancel₀ hH'
    · exact (by fun_prop : Continuous fun x : ℝ => (R * (1 - x / H)) ^ 2).intervalIntegrable _ _
  rw [hint]
  ring

end Upstream
