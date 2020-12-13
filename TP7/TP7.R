# Title     : TODO
# Objective : TODO
# Created by: AYOUB
# Created on: 12/12/2020

set.seed(0)
iris <- read.csv("iris.csv", header = T)
head(iris)
iris <- iris[,-1]
head(iris)
normalize <- function(x)#je normalise une collone x,
{
  max <- max(x)
  min <-min(x)
  x <-(x-min)/(max-min)
  return(x)
}

iris.norm <- as.data.frame(lapply(iris[, -5], normalize))
iris.norm <- cbind(iris.norm, iris$Species)
colnames(iris.norm) <- c("SpalLength", "SpalWidth", "PetalLength", "PetalWidth", "Species")
head(iris.norm)

iris.dist <- dist(iris.norm[, 1:4])

# appliquer la fonction hiérarchique
iris.hclust <- hclust(iris.dist)
# visualiser
plot(iris.hclust)

# obtenir 3 groupes de ségemntation
cutree(iris.hclust, 3)
plot(iris.hclust)
rect.hclust(iris.hclust, 5)
rect.hclust(iris.hclust, 5, border = c("blue", "green", "red", "pink", "black"))
rect.hclust(iris.hclust, 5, which = c(2,5))

# test de la commande
iris.hclust.5 <- rect.hclust(iris.hclust, 5)

# decouper par souris
plot(iris.hclust)
identify(iris.hclust)

plot(iris.hclust)
iris.hclust.id <- identify(iris.hclust)
iris.hclust.id

