install.packages("nnet")
install.packages("caret")
install.packages("devtools")
library(nnet)
library(caret)
library(devtools)

#vamos a predecir el precio de las casas del dataset bostonhouses

bh <- read.csv("../data/tema4/BostonHousing.csv")

set.seed(2018)

t.id <- createDataPartition(bh$MEDV, p =0.7 , list = F)

#ahora encontraremos el rango de la variabilidad de la respuesta para poder escalar el dataset de 0 a 1
summary(bh$MEDV)
#como podemos ver el minimo es 5 y el maximo es 50se dividira el MEDV por 50 
#size = 6 quiere decir el numero de neurones ocultos, decay para gestionar el decaimento, maxit es el numero de epocas, y linoeut nos especifica si queremos una salida lineal y no logistica
fit <- nnet(MEDV/50 ~., data = bh[t.id, ], size = 6, decay = 0.1,
            maxit=1000, linout=T )




# ahora usaremos una libreria para graficar dad por un tercero alojada en github para eso es la libreria devtools para poder conectarnos a la url
#source_url(y la url donde nos vayamos a conectar)

# la libreria de la red se encuentra como 
install.packages("NeuralNetTools")
library(NeuralNetTools)

#max.sp es para dejar lo mas espaciado posible todos los nodos
plotnet(fit, max.sp=T)


#ahora calculamos los errores cuadrados sobre el modelo de entrenamiento

sqrt(mean((fit$fitted.values*50-bh[t.id, "MEDV"])^2))
#los fitted.values es para ver los valores ajustados al conjunto de entrenamiento
#ahora haremos la predicciones sobre el conjunto de teste o validacion

pred <- predict(fit,bh[-t.id,])
#en este caso usamos los valores fit para ver los valores ajustados con el conjunto de test
pred     
sqrt(mean((pred*50 - bh[-t.id,"MEDV"])^2))
