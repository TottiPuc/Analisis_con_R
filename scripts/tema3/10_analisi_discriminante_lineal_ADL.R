install.packages("MASS")
install.packages("caret")
library(MASS)
library(caret)

bn <- read.csv("../data/tema3/banknote-authentication.csv")
bn$class <- factor(bn$class)

set.seed(2018)

t.id <- createDataPartition(bn$class, p=0.7, list = F)

#crearemos el modelo adl

mod <- lda(bn[t.id,1:4], bn[t.id,5]) #esta es la notacion de variables independientes por un lado 1: y dependientes por otro 5
mod <- lda(class ~ ., data = bn[t.id,]) # esta es la otra forma que se utiliza la formula variable dependiente class en funcion del resto y debe dar el mismo resultado del modelo de arrriba

# con esta nueva tecnica se puede añadir al dataset original la columna con las predicciones

bn[t.id, "Pred"] <- predict(mod, bn[t.id,1:4])$class

# creamos la matriz de confusion
# esto es para probar como se comporta con los datos de entrenamiento
table(bn[t.id, "class"], bn[t.id, "Pred"], dnn = c("actual","predicho"))

# ahota predecimos la validacion
bn[-t.id, "Pred"] <- predict(mod, bn[-t.id,1:4])$class
#su matriz de confusion
table(bn[-t.id, "class"], bn[-t.id, "Pred"], dnn= c("actual","predicha"))
