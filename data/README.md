# data

Output of the network meta-analysis pipeline comparing three BCI decoding pipelines — **CSP+LDA**, **TS+SVM**, and **MDM** — across cross-subject evaluations on five MOABB datasets (BNCI2014-001, BNCI2014-004, Cho2017, Lee2019-MI, PhysionetMI). Each dataset is treated as an independent study; the outcome is mean decoding AUROC (mean difference scale). All league tables are keyed as `league[metric][row][col]`, where the value represents row minus col. Diagonal entries are `null`.

---

## nma.json

Frequentist NMA fit with [`netmeta`](https://cran.r-project.org/package=netmeta) (DerSimonian–Laird heterogeneity, random-effects model, t-distribution CIs).

| Key | Description |
|---|---|
| `p_scores` | P-score per treatment — the frequentist analogue of SUCRA. Higher is better. |
| `league.md` | Pairwise random-effects mean differences. |
| `league.lower` / `league.upper` | 95% confidence intervals. |
| `league.z` | Z-statistics. Anti-symmetric: `z[i][j] = -z[j][i]`. |
| `league.pval` | Two-sided p-values. Symmetric: `pval[i][j] = pval[j][i]`. |
| `heterogeneity.tau2` / `tau` | Between-study variance and SD (DL point estimates). |
| `heterogeneity.i2` / `i2_lower` / `i2_upper` | I² and its 95% CI — proportion of variance due to heterogeneity. |
| `heterogeneity.q` / `q_df` / `q_pval` | Cochran's Q statistic, degrees of freedom, and p-value. |
| `prediction` | Prediction interval matrix (`lower`, `upper`). Translates tau into the AUROC MD scale — the expected range of true effects in a new dataset. |

---

## bnma.json

Bayesian NMA fit with [`gemtc`](https://cran.r-project.org/package=gemtc) via JAGS (normal likelihood, identity link, random-effects, 4 chains × 100k iterations, thinning 10). Used as a sensitivity analysis alongside `nma.json`.

| Key | Description |
|---|---|
| `sucra` | SUCRA (Surface Under the Cumulative RAnking curve) per treatment. Higher is better. Bayesian analogue of P-scores. |
| `league.md` | Posterior median of pairwise mean differences. |
| `league.lower` / `league.upper` | 95% credible intervals. Interpreted as: there is a 95% posterior probability the true effect lies in this range. |
| `heterogeneity.sd` | Posterior median of `sd.d` — the between-study SD of true treatment effects (Bayesian analogue of tau). |
| `heterogeneity.sd_lower` / `sd_upper` | 95% credible interval on `sd.d`. |
| `convergence.rhat_max` | Maximum R-hat across all parameters. Should be < 1.01. |
| `convergence.ess_bulk_min` | Minimum bulk ESS across all parameters. Should be > 400. |
| `convergence.ess_tail_min` | Minimum tail ESS across all parameters. Should be > 400. |