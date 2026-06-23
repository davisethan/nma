# data

Output of the network meta-analysis pipeline comparing three BCI decoding pipelines — **CSP+LDA**, **TS+SVM**, and **MDM** — across cross-subject evaluations on five MOABB datasets (BNCI2014-001, BNCI2014-004, Cho2017, Lee2019-MI, PhysionetMI). Each dataset is treated as an independent study; the outcome is mean decoding AUROC (mean difference scale).

---

## nma.json

Frequentist NMA fit with [`netmeta`](https://cran.r-project.org/package=netmeta) (DerSimonian–Laird heterogeneity, random-effects model, t-distribution CIs).

| Key | Description |
|---|---|
| `input` | Paired comparisons fed to netmeta: `study`, `treat1`, `treat2`, `md` (mean difference), `se`, `se_adj` (design-adjusted SE) |
| `estimates` | Per-treatment random-effects estimates vs. the reference treatment: `md`, `lower`, `upper` (95% CI), `z`, `pval`. The reference treatment has `null` values. |
| `league` | Full pairwise league table as nested objects keyed by treatment name: `md`, `lower`, `upper`. Diagonal entries are `null`. |
| `p_scores` | P-score per treatment — the frequentist analogue of SUCRA. Higher is better. |
| `heterogeneity` | `tau2`, `tau`, `i2`, `i2_lower`, `i2_upper` (95% CI), `q`, `q_df`, `q_pval` |
| `prediction` | Prediction interval matrix (`lower`, `upper`) for each pairwise comparison, reflecting between-study variance. |

---

## bnma.json

Bayesian NMA fit with [`gemtc`](https://cran.r-project.org/package=gemtc) via JAGS (normal likelihood, identity link, random-effects, 4 chains × 100k iterations, thinning 10).

| Key | Description |
|---|---|
| `sucra` | SUCRA (Surface Under the Cumulative RAnking curve) per treatment. Higher is better. |
| `convergence` | MCMC diagnostics: `rhat_max` (should be < 1.01), `ess_bulk_min`, `ess_tail_min` (should be > 400). |
| `league` | Bayesian pairwise league table keyed by treatment name: `md` (posterior median), `lower` (2.5th percentile), `upper` (97.5th percentile). |