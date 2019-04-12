install.packages("FNN")
install.packages("dummies")
install.packages("caret")
install.packages("scales")

library(FNN)
library(dummies)
library(scales)
library(caret)

edu <- read.csv("../data/tema4/education.csv")

#lo primero es generar variables dummies de la variable region

dms <- dummy(edu$region, sep ="_")
edu <- cbind(edu,dms)

#ahora vamos a estandarizar las variables predictoras

edu$urban.s <- rescale(edu$urban)
edu$income.s <- rescale(edu$income)
edu$under18.s <- rescale(edu$under18)

set.seed(2018)

t.id <- createDataPartition(edu$expense, p=0.7, list = F)
tr <- edu[t.id,] #conjumto de entrenamiento
vali <- edu[-t.id,]  # conjunto de validacion ya no necesitarioamos conjunto de test

reg <- knn.reg(tr[,7:12], test = NULL, y = tr$expense, k=3, algorithm = "brute")
# lo anterior proporciona los residuos de los errores por lo que para calcular el rmse 
# se deben elevar al cuadrado sacar la media y la raiz cuadrada

rmse.reg <- sqrt(mean(reg$residuals^2))
rmse.reg

# el resultado es mayor al encontrado en al scrip anterior ya que si no se tiene un conjunto de test
# la validacion no surgira resultado






