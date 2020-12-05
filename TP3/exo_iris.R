# Title     : TODO
# Objective : TODO
# Created by: AYOUB
# Created on: 30/11/2020


# EXO 1
set.seed(0)

data <- read.csv("iris.csv", header = TRUE)
head(data)
summary(data)
str(data)

typeof(data$Species)
table(data$Species)

# Réordoner
n <- length(data$Species)
v <- seq(1, n)
v<-round(runif(n, min=0,max=1), digits=2)
v

dataR <- data[order(v),]
head(dataR)

normalizer <- function (v) {
  return((v - min(v)) / (max(v) - min(v)))
}

dataN <- as.data.frame(lapply(dataR[,(2:5)], normalizer))
head(dataN)

# Apprentisage KNN
# Ensemble d'apprentissage
dataTrain <- dataN[c(1:100), ]
labelTrain <- dataR[c(1:100), 6]

# ensemble de Test
dataTest <- dataN[seq(101:150), ]
labelTest <- dataR[seq(from = 101, to = 150), 6]

library(class)

model <- knn(train = dataTrain, test = dataTest, cl = labelTrain, k = 3)
model

table(model)
table(labelTest)
conf <- table(model, labelTest)
conf

# Taux erreur
erreur <- 0
for (i in 1:3) {
  erreur <- erreur + sum(conf[i, -i])
}
 erreur <- erreur/length(labelTest)

vecteurK <- seq(1:10)
vecteurErreur <- rep(0,10)
for (i in vecteurK) {
  model <- knn( train = dataTrain, test = dataTest, cl=labelTrain, k=i)
  conf <- table(model, labelTest)
  erreur <- 0
  for( j in 1:3){
    erreur <- erreur + sum(conf[j, -j] )
  }
  vecteurErreur[i] <- erreur / length(labelTest)
}

vecteurErreur
plot(vecteurK,vecteurErreur)
lines(vecteurK,vecteurErreur)


