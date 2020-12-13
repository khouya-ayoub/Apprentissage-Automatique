# Title     : TODO
# Objective : TODO
# Created by: AYOUB
# Created on: 12/12/2020

set.seed(0)
library(neuralnet)
# Generer 50 nombre aléatoire
train.input <- as.data.frame(runif(50, min = 0, max = 100))
train.output <- sqrt(train.input)

data.train <- cbind(train.input, train.output)
colnames(data.train) <- c("Input", "Output")

# entrainer un model
# threshold : critère d'arret
net.sqrt <- neuralnet(Output ~ Input, data = data.train, hidden = 10, threshold = 0.01)
net.sqrt$result.matrix
plot(net.sqrt)
ls(net.sqrt)

# le taux d'erreur
# error 8.484463e-04

# Tester sur un ensemble de test
data.test <- as.data.frame((1:10)^2)
prediction <- compute(net.sqrt, data.test)

ls(prediction)
print(prediction$net.result)

# creer un tablea pour visulaiser
res.reel <- cbind(data.test, sqrt(data.test), as.data.frame(prediction$net.result))
colnames(res.reel) <- c("Entre", "Attendu", "S-Reseau")

#####################################################
################### EXO 2 ###########################
#####################################################

iris.data <- read.csv("iris.csv", header = TRUE)
head(iris.data)
summary(iris.data)
str(iris.data)

v <- round(runif(length(iris.data$Id), min = 0, max = 1), digits = 2)
iris.data <- iris.data[order(v), ]

normalize <- function (x) {
  maxX <- max(x)
  minX <- min(x)
  x <- (x - minX)/(maxX - minX)
  return(x)
}

iris.norm <- as.data.frame(lapply(iris.data[,2:5], normalize))
head(iris.norm)

iris.data.norm <- cbind(iris.norm, iris.data$Species)
colnames(iris.data.norm) <- c("SpalLengthCm", "SepalWidthCm", "PetalLenghtCm", "PetalWidthCm", "Species")

iris.app <- iris.data.norm[1:105, ]
iris.test <- iris.data.norm[106:150, ]

# Ajouter des colones
iris.app$setosa <- iris.app$Species == "Iris-setosa"
iris.app$virginica <- iris.app$Species == "Iris-virginica"
iris.app$versicolor <- iris.app$Species == "Iris-versicolor"

# Enlever la colone Species
iris.app$Species <- NULL

#entrainer le rs neurones
net.iris.app <- neuralnet(setosa + virginica + versicolor ~ SpalLengthCm + SepalWidthCm + PetalLenghtCm + PetalWidthCm, data = iris.app, hidden = 3)

# Affichage
plot(net.iris.app)

# prediction
prediction <- compute(net.iris.app, iris.test[, -5])
print(prediction$net.result)

# donnes un nom
colnames(prediction$net.result) <- c("Iris-setosa" ,"Iris-virginica" , "Iris-versicolor")

# c'est quoi le label which.max
labels.pridicted <- rep(45)
for (i in 1:45)
  labels.pridicted[i] <- names(which.max(prediction$net.result[i, ]))

labels.reel <- cbind(iris.test[, 5], labels.pridicted)
table(iris.test[, 5], labels.pridicted)



