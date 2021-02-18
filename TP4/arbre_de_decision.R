# Title     : TODO
# Objective : TODO
# Created by: AYOUB
# Created on: 03/12/2020

set.seed(0)

# Library rpart

library(rpart)

data.tennis <- read.csv("tennis.csv")
summary(data.tennis)
dt <- data.tennis
# construire arbre de désicion

tree.tennis <- rpart(Jouer ~ Ciel + Temperature + Humidite + Vent, data.tennis)

# Consulter aide
?rpart

# Creer un controle
tennis.cnt <- rpart.control(minsplit = 1)

# refaire l'arbe avec un controle
tree.tennis <- rpart(Jouer ~ Ciel + Temperature + Humidite + Vent, data.tennis, control = tennis.cnt)
tree.tennis

# Afficher l'arbre
plot(tree.tennis)
text(tree.tennis)

# Interpreter les resultats obtenus par les commande suivantes
plot(tree.tennis, uniform = T)
text(tree.tennis, use.n = T, all = T)

plot(tree.tennis, branch = 0)
plot(tree.tennis, branch = .7)
text(tree.tennis, use.n = T)

plot(tree.tennis, branch = .4, uniform = T, compress = T)
text(tree.tennis, all = T, use.n = T)

plot(tree.tennis, branch = .2, uniform = T, compress = T, margin = .1)
text(tree.tennis, all = T, use.n = T, fancy = T)

# prediction

#
data.test <-read.csv("tennis_test.csv")
predict(tree.tennis, data.test, "class")

predict <- predict(tree.tennis, data.tennis, "class")
table(predict, data.tennis$Jouer)

#last question
cnt.tennis <- rpart.control(minsplit = 5)
tree.tennis <-rpart(Jouer ~ Ciel +Temperature +Humidite + Vent, data.tennis, control = cnt.tennis)
plot(tree.tennis)
text(tree.tennis)
prediction <- predict(tree.tennis, data.tennis, "class")
table(prediction, data.tennis$Jouer)
#en essayant il se trompe


##############################################################
######################### exercice 2 #########################
##############################################################

data(car.test.frame)
data.cars <- car.test.frame
summary(data.cars)

# premiers lignes
head(data.cars)
summary(data.cars)
dim(data.cars)
str(data.cars)

# affichage de nissane Maxima V6
data.cars["Nissan Maxima V6"]
dc <- data.cars
# les classes
levels(data.cars$Type)
summary(data.cars$Type)

effectif <- summary(data.cars$Type)
plot(effectif)
plot(table(data.cars$Type))
barplot(effectif)

#afficher les caractéristiques d'une voiture
data.cars["Nissan Maxima V6",]
levels(data.cars$Type)
table(data.cars$Type)

plot(table(data.cars$Type))
barplot(table(data.cars$Type))

# dépendance deux à deux
plot(dc$Type, dc$Country)
plot(dc$Type, dc$Disp.)
plot(dc$Type, dc$HP)
plot(dc$Type, dc$Mileage)
plot(dc$Type, dc$Price)
plot(dc$Type, dc$Reliability)
plot(dc$Type, dc$Weight)
# ....

plot(dc$Weight, dc$Disp.)

# Arbre de decesion
arbre.cars <- rpart(Type ~ Price + Country + Reliability + Mileage + Weight + Disp. + HP, data.cars, control = rpart.control(minsplit = 1))
plot(arbre.cars)
text(arbre.cars)

# Grand arbre complexe pas bien lisible cp represente la complixité
tree.cars.pruned <- prune(arbre.cars, cp = 0.3)
tree.cars.pruned

# 0.3 on a un noeud Root

plot(tree.cars.pruned)
text(tree.cars.pruned)

# Table des validation coisées
arbre.cars$cptable
#l'arbre est lié a une table "cptable" , chaque ligne est un arbre élagé, le plus développé est le 8 eme,
# il y en a le nbr de noeuds, le cp(parametre de controle), cette table permet de determiner le meilleur cp =>la meilleur valeur dans notre cas c'est 0.04 regarde la console(puisque xerreur diminue puis augmente)

#rel erreur : l'erreur sur l'ensemble d'apprentissage(data.cars), elle est normalisé grace à la validation croisée pour reitérer plusieurs fois sur chaque partie de données
#xerror : l'erreur sur l'ensemble de test
# 75 % donnes d'apprentisssage et 25 % pour les testes
#rpart(formule, data) => validation croiséé c'est une methode de validation de mon modèle lorsqque j'ai un pas bcp de donnée(voir le cours)
err.app <- arbre.cars$cptable[,3] * (45/60) # je multiplie par 45/60 pout avoir le reel
err.app
err.test <- arbre.cars$cptable[,4] * (45/60) + arbre.cars$cptable[,5]
err.test

# Optimale de cp est 0.04 parce que on l'esrreur diminue et il auugment qu'on depasse le cp  = 0.04

nbNodes <- tree.cars$cptable[,2]+1