# Title     : TODO
# Objective : TODO
# Created by: AYOUB
# Created on: 30/11/2020

# Exo de reconnaissance de caractères manuscrits
set.seed(0)
Dtrain <- read.csv("mnist_train.csv")

# dimension
dim <- dim(Dtrain)
# Dimension de problème d'apprentissage
# nous avans 59999 elements de 785 attribus
# 59999 * 785
Dtrain[, 1]
# La colonne est X5 ou la premier colonne

# Premier image
im <- matrix(Dtrain[1, -1], nrow = 28, ncol = 28)
im_numbers <- apply(im, 2, as.numeric)
image(1:28, 1:28, im_numbers, col = gray((0:255)/255))

# Cinque premier image
for (i in 1:5) {
  image(1:28, 1:28, apply(matrix(Dtrain[i, -1], nrow = 28, ncol = 28),
                                     2, as.numeric), col = gray((0:255)/255))
}


# un echantion de 10 000 image de train
echantion <- sample(seq_len(nrow(Dtrain)), 10000)
SubDtrain <- Dtrain[echantion, c(2:785)]
SubLabelTrain <- as.factor(Dtrain[echantion, 1])

# un echantion de 1 000 image de teste
Dtest <- read.csv("mnist_test.csv")
echTest <- sample(seq_len(nrow(Dtest)), 1000)
SubDtest <- Dtest[echTest, c(2:785)]
SubLabelTest <- as.factor(Dtest[echTest, 1])

library(class)

model <- knn(train = SubDtrain, test = SubDtest, cl = SubLabelTrain, k = 2)
table(model)
table(SubLabelTest)
conf <- table(model, SubLabelTest)
conf

# Taux erreur sur echantion de test
erreur <- 0
for (i in 1:10) {
  erreur <- erreur + sum(conf[i, -i])
}
erreur <- erreur / length(SubLabelTest)
erreur

# Indices des image mal class
for (i in 1:1000) {
  if (model[i] != SubLabelTest[i]) {
    paste("Mal classé i=", i, ", Model =", model[i], ", Test =", SubLabelTest[i]);
  }
}