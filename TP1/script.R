# Title     : TODO
# Objective : TODO
# Created by: AYOUB
# Created on: 29/11/2020

# To get Help we use ?functionName or help(functionName)
# Exemple
#?cos
#help(cos)

# The Objects
v <- c(1, 2, 5, 9)
mode(v)
length(v)
mode(cos)

# Input/Output
scan()
a <- scan()
b <- scan()
c <- a + b
print(c)
c

# Controle structures
# if (condition) { expression } else { expression }
# for (variable in rang) { expression }
# while (condtition) { expression }

# functions
carre <- function (x) {
  return (x*x)
}

# Vectors all in R is a vector

v1 <- vector("numeric", 10)
v2 <- vector("logical", 8)
v3 <- c(1, 3, 4, 8)
v4 <- rep(1, 10)
v5 <- seq(1, 10)
v6 <- (1:10)
v7 <- seq(1, 10, 3)

# Vector with names
poids <- c(77, 58, 66, 82)
poids
names(poids)
names(poids) <- c("Marc", "Sophie", "Julie", "Blaise")
poids

poids[1]
poids["Sophie"]

poids[2:3]
poids[c(1, 4)]
poids[c(TRUE, FALSE, TRUE, FALSE)]

# EXO
v <- c(1:12, 8:5, rep(2,4), 8:15, 16:12)
v[7]

# Vectors and Operations
poids <- c(85, 78, 54, 98, 66, 78, 77, 72, 99, 102, 54, 66, 98, 75, 82, 83, 75)
poids
poids <- poids + 1
poids
sqrt(poids)
length(poids)
sort(poids)
sort(poids, decreasing = TRUE)
order(poids)
poids[order(poids)]

# Summary : Min 1st.Qu Median Mean 3rd.Qu Max.
summary(order(poids))
summary(poids)

# How to compare a lot of vectors
objets <- load("test.RData")
objets

length(objets["tailleG"])
length(objets["performanceG"])
length(objets["tailleF"])
length(objets["performanceF"])

length(tailleG)
length(tailleF)
length(performanceG)
length(performanceF)

# Afficher les noms
names(tailleF)

# ?union Two vectors
union(names(tailleF), names(performanceG))
# ?intersect
intersect(names(tailleF), names(performanceF))
# taille + performance
tailleG2 <- tailleG[intersect(names(tailleG), names(performanceG))]
tailleF2 <- tailleF[intersect(names(tailleF), names(performanceF))]
# order
tailleG3 <- tailleG2[order(tailleG2)]

# Factors
vent <- factor(c("fort", "faible", "moyen", "faible", "faible", "fort"))
vent

# Matrix
m1 <- matrix(1:6, nrow = 2, ncol = 3)
m1
m2 <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
m2
m3 <- matrix(c(40, 80, 45, 21, 55, 32), nrow = 2, ncol = 3)
m3
m3[1, 2]
m3[2, ]
m3[ , 3]


# Lists
x <- list(size = c(1, 5, 2), user = "Joe", new = TRUE)
x
x[1]
x[[1]]
x$size

athletes <- list(
  Didier = c(630, 625, 628, 599, 635, 633, 622),
  Jules = c(610, 590, 595, 582, 6001, 603),
  Pierre = c(644, 638, 639, 627, 642, 633, 639),
  Matthieu = c(622, 625, 633, 641, 610),
  Georges = c(561, 572, 555, 569, 653, 549, 558, 561)
)

lapply(athletes, min)
sapply(athletes, min)
sapply(athletes, length)
sapply(athletes, mean)


# Data Frames
resultats <- data.frame(  taille = c(185, 178, 165, 171, 172),
                          poids = c(82, 81, 55, 65, 68),
                          QI = c(110, 108, 125, 99, 124),
                          sexe = c("M", "M", "F", "F", "F"),
                          row.names = c("Paul", "Matthieu", "Camille", "Mireille", "Capucine")
                        )
resultats

resultats["Camille", "taille"]
resultats[1:3, "QI"]
resultats[1:3, 3:4]
resultats[1:3, ]
resultats["poids"]


# Day.csv
dataBikes <- read.csv("day.csv", header = TRUE)
dataBikes
head(dataBikes)
summary(dataBikes)

# Graphics
curve(sin(x), -3, 10)
x <- rnorm(18)
y <- rnorm(18)
plot(x, y, xlab = "", ylab = "",
     xlim = c(-2, 2), ylim = c(-2, 2),
     pch = 22, col = "red", bg = "yellow",
     tcl = 0.4, main = "Nuage de points")

grid(lwd = 1)