# Title     : TODO
# Objective : TODO
# Created by: AYOUB
# Created on: 12/12/2020

set.seed(0)

###########################################
################## EXO 1 ##################
###########################################

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

iris.3means <- kmeans(iris.norm[, 1:4], 3)
iris.3means$cluster
iris.3means$centers
iris.3means$withinss # homogénité
iris.3means$tot.withinss # totale
iris.3means$betweenss # entre les classes
iris.3means$size

plot(iris.norm$PetalLength, iris.norm$PetalWidth)

# Séparer les données
sub.setosa <- subset(iris.norm, iris.norm$Species == "Iris-setosa")
sub.versicolor <- subset(iris.norm, iris.norm$Species == "Iris-versicolor")
sub.verginica <- subset(iris.norm, iris.norm$Species == "Iris-virginica")

# Séparer les données
sub.cluster.one <- subset(iris.norm, iris.3means$cluster == 1)
sub.cluster.two <- subset(iris.norm, iris.3means$cluster == 2)
sub.cluster.three <- subset(iris.norm, iris.3means$cluster == 3)

# afficher les elements rééls
plot(iris.norm$PetalLength, iris.norm$PetalWidth)
points(sub.setosa$PetalLength, sub.setosa$PetalWidth, col = 1, pch = 19)
points(sub.versicolor$PetalLength, sub.versicolor$PetalWidth, col = 2, pch = 19)
points(sub.verginica$PetalLength, sub.verginica$PetalWidth, col = 3, pch = 19)

# les points avec K means
plot(iris.norm$PetalLength, iris.norm$PetalWidth)
points(sub.cluster.one$PetalLength, sub.cluster.one$PetalWidth, col = 8, pch = 10)
points(sub.cluster.two$PetalLength, sub.cluster.two$PetalWidth, col = 9, pch = 10)
points(sub.cluster.three$PetalLength, sub.cluster.three$PetalWidth, col = 10, pch = 10)

# la confusion
table(iris.norm$Species, iris.3means$cluster)

# Trouver le Meilleur K
avg_interclasse <- integer(9)
avg_intraclasse <- integer(9)

for (i in 2:10) {
  iris.kmeans <- kmeans(iris.norm[, 1:4], centers = i, nstart = 30)
  avg_interclasse[i-1] <- iris.kmeans$tot.withinss
  avg_intraclasse[i-1] <- iris.kmeans$betweenss
}

plot(2:10, avg_intraclasse, xlab = "K", ylab = "moyenne intraclasse", type = "b", pch = 19, col = "red")
plot(2:10, avg_interclasse, xlab = "K", ylab = "moyenne interclasse", type = "b", pch = 19, col = "green")













