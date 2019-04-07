install.packages("caret")
library(caret)

bh <- read.csv("../data/tema3/boston-housing-logistic.csv")
bh$CLASS <- factor(bh$CLASS, levels = c(0,1)) # en la regresion logistica se necesita que la s
#variables independientes sean numericas y el target o variable dependeinte sea categorica 


set.seed(2018)
#creamos los datos de entrenamiento
t.ids <- createDataPartition(bh$CLASS, p=0.7, list = F)

#creamos el modelo

mod <- glm(CLASS ~ ., data = bh[t.ids,], family = binomial)
summary(mod)

#ahora calculamos las probabilidades de exito del validacion

bh[-t.ids, "PROB_SUCCESS"] <- predict(mod, newdata = bh[-t.ids,], type = "response")
# con lo anterior se tiene la nueva columna con las probabilidades en funcion de las variables de clasificacion las independientes
# ahora se debe decidir por donde se corta la curva logistica que generalmente es en 50%

bh[-t.ids, "PRED_50"] <- ifelse(bh[-t.ids, "PROB_SUCCESS"]>=0.5,1,0) # esto es un if que dice que si los datos de entrenamiento
#dela nueva columna de prediccion PROB_SUCCESS son mayores que 0.5 catalogelo como 1 caso contrario 0

#finalmente creamod una matriz de confucion para ver si la tecnica es un exito

table(bh[-t.ids,"CLASS"], bh[-t.ids, "PRED_50"], dnn = c("actual", "predicha"))
