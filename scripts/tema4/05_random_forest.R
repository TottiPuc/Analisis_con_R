install.packages("randomForest")
install.packages("caret")

library(randomForest)
library(caret)

bh <- read.csv("../data/tema4/BostonHousing.csv")

set.seed(2018)
t.id <- createDataPartition(bh$MEDV, p=0.7, list = F)

#ahora creamos el randomfores que son muchos arboles de regresion tantos como le indiquemos

mod <- randomForest(x = bh[t.id, 1:13], y = bh[t.id, 14],
                    ntree = 1000,
                    xtest = bh[-t.id, 1:13], ytest = bh[-t.id,14],
                    importance = T, keep.forest = T)
mod

# vamos a ver las variables importantes del modelo

mod$importance
# con  lo anterior podemos ver que cuanot mayor es el valor de la IncNodePurity mas importante es la variable predictora
#se puede ver que el porentaje de variabilidad supera el 86%
#ahora compararemos los valores de las predicciones con los de entrenamiento atraves de un grafico

plot(bh[t.id,]$MEDV, predict(mod,newdata = bh[t.id,]),
     xlab =  "Actual", ylab = "predichos")
abline(0,1)

#tambien podemos hacer el mismo grafico de predicciones para el conjunto de test
plot(bh[-t.id,]$MEDV, predict(mod, newdata = bh[-t.id,]),
     xlab = "Actual", ylab = "predicho")
abline(0,1)
