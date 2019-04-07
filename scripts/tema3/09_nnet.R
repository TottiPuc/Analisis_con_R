install.packages("nnet")
install.packages("caret")
library(nnet)
library(caret)

bm <- read.csv("../data/tema3/banknote-authentication.csv")
bm$class <- factor(bm$class)


t.ids <- createDataPartition(bm$class, p=0.7, list = F)

#creamos el modelo con nnet
# la variable target en este caso class en funcion ~ de todas las entradas . 
mod <- nnet(class ~ ., data = bm[t.ids,],
            size =3 , maxit = 10000, decay = 0.001, rang = 0.05,
            na.action = na.omit, # los NA en redes hacen que la red no clasifique bien por eso se puede omitirlos con esta funcion
            skip = T)
# la variable rang se usa para especificar el peso aleatorio inicial de la red se usa la regla de oro que se hace el maximo del dataset por el rango sea lo mas acercano a uno

apply(bm,2,max) # se puede ver que la mas alta es 17.9 que multiplicado por rang se acerca casi a uno
#rang*max(|variables|) ~1

pred <- predict(mod, newdata = bm[-t.ids,], type = "class")

#ahora miramos si funciona bien con una matriz de confucion

table(bm[-t.ids,]$class, pred , dnn = c("actual", "predicho"))

library(ROCR)
#para hacer no una clasificacion si no una regresion que calcule probabilidades se usa raw
pred2 <- predict(mod, newdata = bm [-t.ids,], type = "raw") 
#ahora analizaremos las predicciones el performance
perf <- performance(prediction(pred2,bm[-t.ids, "class"]), "tpr", "fpr")
plot(perf)
