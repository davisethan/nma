library(dotenv)
library(netmeta)

load_dot_env()
data_path <- Sys.getenv("DATA_PATH")

df <- read.csv(file.path(data_path, "netmeta.csv"))

network <- netmeta(
    TE = md,
    seTE = se,
    treat1 = treat1,
    treat2 = treat2,
    studlab = study,
    data = df,
    sm = "MD",
    common = FALSE,
    random = TRUE,
    correlated = TRUE,
    method.random.ci = "t-dist",
    reference.group = "CSP+LDA",
    sep.trts = " vs "
)
netleague <- netleague(network, bracket = "(", digits = 2)
netrank <- netrank(network, small.values = "bad")

sink(file.path(data_path, "netmeta.log"))
print(summary(network))
cat("\n")
print(netleague$random)
cat("\n")
print(netrank)
sink()

png(file.path(data_path, "netmeta_forest.png"), width = 400, height = 150)
forest(
    network,
    reference.group = "CSP+LDA",
    sortvar = se,
    xlim = c(-0.1, 0.1),
    smlab = paste("Pipelines vs. CSP+LDA"),
    drop.reference.group = TRUE,
    label.left = "Reference",
    label.right = "Treatment"
)
dev.off()
