# Title     : TODO
# Objective : TODO
# Created by: AYOUB
# Created on: 13/12/2020

set.seed(0)

# Instalation de package
install.packages("dbscan")
library(dbscan)

# charger les données
data.multishapes <- read.table("multishapes.txt", header = TRUE)
plot(data.multishapes$x, data.multishapes$y)

# appliquer la fonction dbscan
data.dbscan <- dbscan(data.multishapes, eps = 0.15, minPts = 5)
data.dbscan

afficherCluster <- function (data, dbscan, xl, yl) {
  nb <- max(dbscan$cluster)
  plot(data$x, data$y, xlab = xl, ylab = yl)
  for (i in 0:nb) {
    clusters <- subset(data, dbscan$cluster == i)
    points(clusters$x, clusters$y, col = (i+1), pch = 19)
  }
}

afficherCluster(data.multishapes, data.dbscan, "ligne X", "Ligne Y")

# si on change epsilone plus petit on obtient plusieurs clusters
# sinon pour le minPts on si on diminue la valuer on obtient des plus de clusters

kNNdist(data.multishapes, k = 8)
kNNdistplot(data.multishapes, k = 8)