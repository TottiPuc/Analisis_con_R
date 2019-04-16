#k-fold cross validation

bh <- read.csv("../data/tema4/BostonHousing.csv")



#creamos una funcion para hacer automatica la validacion cruzada el cual tomara como entrada el df y el numero de partes a cruzar

kfold.crossval.reg <- function(df,nfolds){
  fold <- sample(1:nfolds, nrow(df), replace = T)
  cat(fold)
  
  mean.sqr.errs <- sapply(1:nfolds, kfold.cval.reg.iter, df, fold)
  
  list("MSE "=mean.sqr.errs,
  "Overall_mean_sqr_error " = mean(mean.sqr.errs),
  "std_mean_sqr_Error " = sd(mean.sqr.errs))
}

kfold.cval.reg.iter <- function(k,df,fold){
  cat("---------------------------------\n")
  tr.ids<- !fold %in% c(k) # el conjunto de valores que no estan en fold y no estan n k
  cat(tr.ids)
  test.ids <- fold %in% c(k) # el conjunto de fold que estan en k
  mod<- lm(MEDV ~ ., data = df[tr.ids,])
  pred <- predict(mod, df[test.ids,])
  sqr.error <- (pred - df[test.ids,"MEDV"])^2
  mean(sqr.error)
}

res <- kfold.crossval.reg(bh,5)




#ahora una nueva cross validation function dejando de lado un conjunto 

LOOCV.reg <- function(df){
  mean.sqr.errors <- sapply(1:nrow(df), loovc.reg.iter, df )
  list("MSE" = mean.sqr.errors, 
       "overall_mean_sqr_errors" = mean(mean.sqr.errors),
       "std_mean_sqr_errors" = sd(mean.sqr.errors))
  
  
}

loovc.reg.iter <- function(k,df){
  mod <- lm(MEDV ~., data = df[-k,]) # se hace la validacion sin el conjunto de datos k-esimo
  pred <- predict(mod,df[k,]) #predecimos justo con la k-edima eliminaada en el modelo
  sqr.error <- (pred - df[k,"MEDV"])^2
  sqr.error
}

res <- LOOCV.reg(bh)
res
