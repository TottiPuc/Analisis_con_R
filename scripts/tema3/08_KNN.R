install.packages("caret")
install.packages("class")
library(class)
library(caret)
# el algoritmo KNN requieres que las variables dependientes sean numericas y las aindependientes categoricas
vac <- read.csv("../data/tema3/vacation-trip-classification.csv")
# lo primero es normalizar los datos por que como se puede ver uno domina al otro
vac$Income.z <- scale(vac$Income)
vac$Family_size.z <- scale(vac$Family_size)


set.seed(2018)
t.ids <- createDataPartition(vac$Result, p=0.5 , list = F)
train <- vac[t.ids,]
temp <- vac[-t.ids,]
v.ids <- createDataPartition(temp$Result, p=0.5, list = F)
val <- temp[v.ids,]
test<- temp[-v.ids,]

# vamos a generar predicciones para el caso que decide solo un vecino mas cercano
# knn(los de entrenamiento, los que se va a predecir en la validacion, y la de eleccion o categoria, numero de vecino)
pred1 <-knn(train[,4:5],val[,4:5],train[,3], k =5)
errmat1 <- table(val$Result, pred1, dnn = c("actual","predichos"))
errmat1

# prediccion sobre el conjunto de test
pred2 <- knn(train[,4:5], test[,4:5], train[,3], k=1)
errmat2 <- table(test$Result, pred2, dnn = c("actual","predicha"))
errmat2


#para elegir el mejor numeor de vecinos para tomar una decision se hace lo siguiente
# crear una funcion 



knn.automate <- function(tr_predictors, val_predictors, tr_target, val_target,
                         start_k, end_k){
  for (k in start_k:end_k) {
    pred <- knn(tr_predictors, val_predictors, tr_target, k)
    tab <- table(val_target, pred, dnn = c("actual","predicho"))
    cat(paste("matriz de confusion para k = ",k,"\n"))
    cat("========================================\n")
    print(tab)
    cat("--------------------------------------------\n")
    
  }
  
}


#pruebo la funcion creada anteriormente qeu estaautomatizada

knn.automate(train[,4:5], val[,4:5], train[,3], val[,3],1,8)

# tambien se puede determinar el numero de vecinos haciendo una version generalizada en el paquete caret para primero escalar centrar y llevar el entrenamiento adecuado de las variables

trcntrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
caret_kann_fit <- train(Result ~Family_size + Income, data =train,
                        method = "knn", trControl = trcntrl,
                        preProcess = c("center","scale"),
                        tuneLength =10)

caret_kann_fit


pred5 <- knn(train[,4:5], val[,4:5], train[,3], k=5, prob = T)
pred5
