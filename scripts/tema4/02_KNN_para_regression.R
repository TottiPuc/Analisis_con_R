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

# ahora creamos las particiones
t.id <- createDataPartition(edu$expense, p=0.6, list = F)
tr <- edu[t.id, ]
tmp <- edu[-t.id, ]
# ahora los devalidacion
v.id <- createDataPartition(tmp$expense, p=0.5, list = F)
val <- tmp[v.id,]
test <- tmp[-v.id,]

#ahora creamos nuestro modelo y calculamos el rms

rmse <- function(actual, predicho){
  return(sqrt(mean((actual - predicho)^2)))
}


reg1 <- knn.reg(tr[,7:12],val[,7:12],tr$expense, k=1,
                algorithm = "brute")
rmse1 <- sqrt(mean((reg1$pred - val$expense)^2)) #aqui usamos la funcion de rmse directamente
rmse1

#ahora para k=2

reg2 <- knn.reg(tr[,7:12],val[,7:12],tr$expense, k=2,
               algorithm = "brute")
rmse2 <- rmse(val$expense,reg2$pred) # aqui usamos la funcion rmse que creamos
rmse2

# ahora con k=3 

reg3 <- knn.reg(tr[,7:12],val[,7:12],tr$expense, k=3,
                algorithm = "brute")
rmse3 <- rmse(val$expense,reg3$pred)
rmse3

# ahora para ver como se comporta el modelo entrenado en reg3 se hace lo siguiente
df1 = data.frame(actual = val$expense , pred = reg3$pred)
plot(df1)
abline(0,1)



# ahora con k=4 

reg4 <- knn.reg(tr[,7:12],val[,7:12],tr$expense, k=4,
                algorithm = "brute")
rmse4 <- rmse(val$expense,reg4$pred)
rmse4
# como nos podemos dar cuenta con k =4 ya se aumenta el rmse lo que quiere decir qeu en este caso
# con k=3 es el mejor modelo

errors = c(rmse1, rmse2, rmse3, rmse4)
plot(errors, type = 'o', xlab = "k", ylab = "RMSE")

#analizaremos el conjunto de tests
reg.test <- knn.reg(tr[,7:12],test[,7:12], tr$expense, k = 3,
                    algorithm = "brute")
rmse.test<- rmse(test$expense, reg.test$pred)
rmse.test


# ahora para ver como se comporta el modelo entrenado en reg.test se hace lo siguiente
df = data.frame(actual = test$expense , pred = reg.test$pred)
plot(df)
abline(0,1)


#para automatizar las k y no hacer una por una se crea una funcion que haga la regresion

rdacb.knn.reg <- function(tr_predictor, val_predictor,
                          tr_targer, val_target,k){
  library(FNN)
  res <- knn.reg(tr_predictor,val_predictor,tr_targer , k, algorithm = "brute")
  rmserror <- sqrt(mean((val_target-res$pred)^2))
  cat(paste("RMSE para k = ", toString(k), ": ", rmserror, "\n", sep = ""))
  rmserror
}


rdacb.knn.reg(tr[,7:12], val[,7:12], tr$expense, val$expense, 1)
rdacb.knn.reg(tr[,7:12], val[,7:12], tr$expense, val$expense, 2)
rdacb.knn.reg(tr[,7:12], val[,7:12], tr$expense, val$expense, 3)



rdacb.knn.reg.multi <- function(tr_predictor, val_predictor,
                                tr_target, val_target, start_k, end_k){
  rmserrors <- vector()
  for (k in start_k:end_k) {
    rms_error <- rdacb.knn.reg(tr_predictor, val_predictor, tr_target, val_target, k)
    rmserrors<- c(rmserrors, rms_error)
  }
  plot(rmserrors,type = "o", xlab = "k", ylab = "RMSE")
}


rdacb.knn.reg.multi(tr[,7:12], val[,7:12], tr$expense, val$expense,1,10)
