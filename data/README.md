# Network Meta-Analysis Results

Comparison of three BCI pipelines (CSP+LDA, MDM, TS+SVM) across five datasets (BNCI2014-001,
BNCI2014-004, Cho2017, Lee2019-MI, PhysionetMotorImagery). Primary analysis uses a frequentist
NMA (netmeta); Bayesian NMA (gemtc) serves as a sensitivity analysis.

---

## Primary Analysis: Frequentist NMA (netmeta)

Effect sizes are unstandardized mean differences in AUROC (paired, correlated arms). Random
effects model with DerSimonian-Laird tau² estimator and t-distribution CIs (df = 8).

### Treatment Estimates vs. CSP+LDA

| Treatment | MD | 95% CI | p-value |
|---|---|---|---|
| MDM | -0.0507 | [-0.0949, -0.0066] | 0.029 |
| TS+SVM | 0.0098 | [-0.0310, 0.0506] | 0.594 |

MDM performs significantly worse than CSP+LDA (p = 0.029). TS+SVM outperforms CSP+LDA by
0.01 AUROC on average but the difference is not significant (p = 0.594).

### Network League Table

Cells show MD (95% CI) for row vs. column. Positive values favour the row treatment.

|  | CSP+LDA | MDM | TS+SVM |
|---|---|---|---|
| **CSP+LDA** | — | 0.05 (0.01; 0.09) | -0.01 (-0.04; 0.03) |
| **MDM** | -0.05 (-0.09; -0.01) | — | -0.06 (-0.10; -0.02) |
| **TS+SVM** | 0.01 (-0.03; 0.05) | 0.06 (0.02; 0.10) | — |

MDM is significantly worse than both CSP+LDA and TS+SVM. The CSP+LDA vs. TS+SVM difference
is not significant in either direction.

### Heterogeneity

| Statistic | Value |
|---|---|
| tau² | 0.0014 |
| tau | 0.0380 |
| I² | 93.4% [89.5%, 95.8%] |
| Q (df = 8) | 120.53 (p < 0.0001) |

Heterogeneity is very high (I² = 93.4%), indicating that pipeline performance varies
substantially across datasets. This is consistent with the noisy, non-stationary nature of EEG
and differences in recording hardware, subject populations, and task protocols across datasets.
Results should be interpreted in light of this variability.

### P-Scores

| Pipeline | P-score |
|---|---|
| TS+SVM | 0.849 |
| CSP+LDA | 0.641 |
| MDM | 0.010 |

TS+SVM ranks first with high certainty (P = 0.85). CSP+LDA is mid-ranked. MDM is almost
certainly the worst pipeline across datasets (P = 0.01).

---

## Sensitivity Analysis: Bayesian NMA (gemtc)

Arm-based random effects model (normal likelihood, identity link, 4 chains). Arms are treated
as independent within studies — within-study correlation from the paired design is not modelled,
making credible intervals conservative. Gelman-Rubin statistic: 1.001 (good convergence).

### League Table

Cells show MD (95% CrI) for row vs. column. Positive values favour the row treatment.

|  | CSP+LDA | MDM | TS+SVM |
|---|---|---|---|
| **CSP+LDA** | — | -0.069 (-0.129, 0.003) | 0.011 (-0.055, 0.076) |
| **MDM** | 0.069 (-0.003, 0.129) | — | 0.079 (0.009, 0.138) |
| **TS+SVM** | -0.011 (-0.076, 0.055) | -0.079 (-0.138, -0.009) | — |

### SUCRA

| Pipeline | SUCRA |
|---|---|
| TS+SVM | 0.811 |
| CSP+LDA | 0.667 |
| MDM | 0.022 |

---

## Consistency of Results

Treatment rankings are consistent across both models. SUCRA values closely match P-scores,
confirming that TS+SVM > CSP+LDA >> MDM regardless of modelling framework. The Bayesian CrIs
are wider than the frequentist CIs, expected given the unmodelled within-study correlation.
The one notable difference is the MDM vs. CSP+LDA comparison: the Bayesian 95% CrI
(-0.129, 0.003) marginally includes zero while the frequentist CI (-0.0949, -0.0066) excludes
it, reflecting the more conservative uncertainty in the Bayesian model.