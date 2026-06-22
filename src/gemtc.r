library(dotenv)
library(gemtc)
library(rjags)

load_dot_env()
data_path <- Sys.getenv("DATA_PATH")

df <- read.csv(file.path(data_path, "gemtc.csv"))

network <- mtc.network(data.ab = df)

model <- mtc.model(
    network,
    likelihood = "normal",
    link = "identity",
    linearModel = "random",
    n.chain = 4
)
results <- mtc.run(model, n.adapt = 5000, n.iter = 1e5, thin = 10)
rank <- rank.probability(results, preferredDirection = 1)

sucra <- apply(rank, 1, function(p) {
    n <- length(p)
    sum(cumsum(p)[-n]) / (n - 1)
})

sink(file.path(data_path, "gemtc.log"))
print(summary(network))
cat("\n")
print(gelman.diag(results)$mpsrf)
cat("\n")
print(sucra)
cat("\n")
print(relative.effect.table(results))
sink()

png(file.path(data_path, "gemtc_forest.png"), width = 500, height = 150)
gemtc::forest(
    relative.effect(results, t1 = "CSP_LDA"),
    xlim = c(-0.2, 0.2)
)
dev.off()

png(file.path(data_path, "gemtc_trace.png"), width = 800, height = 600)
plot(results)
dev.off()

png(file.path(data_path, "gemtc_gelman.png"), width = 800, height = 600)
gelman.plot(results)
dev.off()

png(file.path(data_path, "gemtc_rank.png"), width = 800, height = 600)
plot(rank, beside = TRUE)
dev.off()
