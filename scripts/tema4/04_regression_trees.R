install.packages("rpart")
install.packages("rpart.plot")
install.packages("caret")
library(rpart)
library(rpart.plot)
library(caret)

# del siguiente dataframe vamos a predecir la variable MEDV
bh <- read.csv("../data/tema4/BostonHousing.csv")

t.id <- createDataPartition(bh$MEDV, p = 0.7, list = F)

# ahora usaremos rpart para llevar acano el arbol de regresion
bfit <- rpart(MEDV ~ ., data = bh[t.id,])
bfit

par(mfrow=c(1,1))
# su representacion grafica es 
prp(bfit, type = 2 , nn=T,
    fallen.leaves = T, faclen = 4,
    varlen = 8, shadow.col = "gray")

# la siguiete tabla nos muestra los resultados comprensibles de los errores del arbol
bfit$cptable
plotcp(bfit)

# con los graficos anteriores podemos ver cual seria el mejor corte del arbol para que 
# realice una regresion adecuada con cfit$cptable podemos calcular cual es el mejor error 
#para ver con cuantas divisiones nos quedamos en este caso se usa el menor xerro y se le resta su xstd
#ese resultado lo comparamos ccon los valores xerror y el que este por encima de ese valor sera el corte ejemplo 0.2775518 + 0.04478981 = 0.3223416 que sera el cp
#en este caso nos quedariamos con el 4 arbol lo mismo se puede hace con plotcp

#ahora podemos hacer el corte o recorte de ramas apartir del modelo original de la siguiete forma
bfitpruned <- prune(bfit, cp = 0.02683282)

prp(bfitpruned, type = 2 , nn=T,
    fallen.leaves = T, faclen = 4,
    varlen = 8, shadow.col = "gray")

# la siguiete tabla nos muestra los resultados comprensibles de los errores del arbol
bfitpruned$cptable
plotcp(bfitpruned)

# ahora calcularemos las predicciones con el modelo recortado y el conjunto de entrenamiento para ver que tnanto se ajusto

preds <- predict(bfitpruned, bh[t.id, ])
sqrt(mean((preds - bh[t.id,]$MEDV)^2))


# y ahora si validaremos nuestro conjunto de test

preds <- predict(bfitpruned, bh[-t.id, ])
sqrt(mean((preds - bh[-t.id,]$MEDV)^2))

# como se puede ver el conjunto de test tiene un error mas alto




#podemos ver lo mismo con el arbol sin recorte para ver si el error de clasificacion aumenta o disminuye

preds <- predict(bfit, bh[t.id, ])
sqrt(mean((preds - bh[t.id,]$MEDV)^2))


# y ahora si validaremos nuestro conjunto de test

preds <- predict(bfit, bh[-t.id, ])
sqrt(mean((preds - bh[-t.id,]$MEDV)^2))
