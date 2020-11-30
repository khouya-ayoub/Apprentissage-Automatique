# Title     : TODO
# Objective : TODO
# Created by: AYOUB
# Created on: 30/11/2020


############################## Etape 1 generer ensemble d'apprentissage

# Fonction generate
f <- function (x, bruit) {
  return(0.1*x^3 - 0.5*x^2 - x + 10 + bruit)
}

generate <- function (n) {
  set.seed(0)
  bruit <- rnorm(n, 0.5, 1)
  X <- runif(n, -10, 10)
  Y <- f(X, bruit)
  return(cbind(X, Y))
}

S1 <- generate(100)
x <- S1[, 1]
y <- S1[, 2]
plot(S1, xlab = "X", ylab = "Y")

############################## Etape 2 model de prediction
# regression lineaire
m1 <- lm(S1[, 2] ~ S1[, 1])
m2 <- lm(S1[, 2] ~ poly(S1[, 1], 2))
print(m1)

M <- c(1, 2, 3, 6, 12)
x <- S1[, 1]
y <- S1[, 2]
z <- seq(from = -10, to = 10, length.out = 300)

couleur <- c("green", "blue", "red", "yellow", "violet")
c <- 1

for (i in M) {
  modelM <- lm(y ~ poly(x, i))
  print(modelM)
  predictZ <- predict(modelM, data.frame(x = z))
  lines(z, predictZ, col = couleur[c], lty = 1)
  c <- c + 1
}

# Le model qui col le mieux aux données d'apprentisage est le model 3 et 6
# le phénomène observé est le sur apprentisage avec le model 12

# Etpae 3 : Sélection du modèle
test <- generate(1000)
plot(test)
xTest <- test[, 1]
yTest <- test[, 2]

degrees <- seq(1, 20)

EQMA <- rep(0, length(degrees))
EQMT <- rep(0, length(degrees))

EQM <- function (x, y, N) {
  return(sqrt(sum( (y-x)^2)/N))
}

for (i in degrees) {
  model <- lm(y ~ poly(x, i))
  p <- predict(model, data.frame(x = x))
  EQMA[i] <- EQM(p, y, 15)

  pT <- predict(model, data.frame(x = xTest))
  EQMT[i] <- EQM(pT, yTest, 1000)
}

EQMA
EQMT
plot(degrees, EQMT, ylim = c(1, 500), col = "green", pch = 19)
points(degrees, EQMA, col = "red", pch = 22)
