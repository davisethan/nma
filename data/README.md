# Network Meta-Analysis Results

Frequentist NMA comparing three BCI pipelines (CSP+LDA, MDM, TS+SVM) across five datasets
(BNCI2014-001, BNCI2014-004, Cho2017, Lee2019-MI, PhysionetMotorImagery). Effect sizes are
unstandardized mean differences in AUROC (paired, correlated arms). Random effects model with
DerSimonian-Laird tau² estimator and t-distribution CIs (df = 8).

## Treatment Estimates vs. CSP+LDA

| Treatment | MD | 95% CI | p-value |
|---|---|---|---|
| MDM | -0.0507 | [-0.0949, -0.0066] | 0.029 |
| TS+SVM | 0.0098 | [-0.0310, 0.0506] | 0.594 |

MDM performs significantly worse than CSP+LDA (p = 0.029). TS+SVM outperforms CSP+LDA by
0.01 AUROC on average but the difference is not significant (p = 0.594).

## Network League Table

Cells show MD (95% CI) for row vs. column. Positive values favour the row treatment.

|  | CSP+LDA | MDM | TS+SVM |
|---|---|---|---|
| **CSP+LDA** | — | 0.05 (0.01; 0.09) | -0.01 (-0.04; 0.03) |
| **MDM** | -0.05 (-0.09; -0.01) | — | -0.06 (-0.10; -0.02) |
| **TS+SVM** | 0.01 (-0.03; 0.05) | 0.06 (0.02; 0.10) | — |

MDM is significantly worse than both CSP+LDA and TS+SVM. The CSP+LDA vs. TS+SVM difference
is not significant in either direction.

## Heterogeneity

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

## P-Scores

| Pipeline | P-score |
|---|---|
| TS+SVM | 0.849 |
| CSP+LDA | 0.641 |
| MDM | 0.010 |

TS+SVM ranks first with high certainty (P = 0.85). CSP+LDA is mid-ranked. MDM is almost
certainly the worst pipeline across datasets (P = 0.01).