install.packages("rpart")
install.packages("rpart.plot")
install.packages("caret")
library(rpart)
library(rpart.plot)
library(caret)

ed <-read.csv("../data/tema4/education.csv")
ed$region <- factor(ed$region)

t.id <- createDataPartition(ed$expense, p=0.7, list = F)

#creamos el modelo con una categorica y 3 numericas

fit <-rpart(expense ~ region+urban+income+under18, data = ed[t.id,])
#representamos el arbol

prp(fit,type = 2, nn =T, fallen.leaves = T,
    faclen = 4, varlen = 8, shadow.col = "gray")

#bagging metodo de ensamblaje de las predicciones de dferentes arboles combinados

install.packages("ipred")
library(ipred)
bh <- read.csv("../data/tema4/BostonHousing.csv")
t.id <- createDataPartition(bh$MEDV, p = 0.7, list = F)
baggin.fit <- bagging(MEDV ~ ., data = bh[t.id,])

# ahora con el modelo creado vamos a calcular las predicciones sobre el modelo de entrqanmiento para ver si existe overgfiting

prediction.t <- predict(baggin.fit,bh[t.id,])
sqrt(mean((prediction.t-bh[t.id,]$MEDV)^2)) # mostrando ser mejor que el arbol anterior

#ahora podemos hacer la prediccion sobre el conjunto de validacion o test

prediction.v <- predict(baggin.fit,bh[-t.id,])
sqrt(mean((prediction.v-bh[-t.id,]$MEDV)^2))



# otro metodo utilizado para reducier el ensamblamiento cuadno los nuevos modelos es utilizan para aprender de los errores de mala clasificacion de modelos previos 
# para eso se usa boosting

install.packages("gbm")
library(gbm)

gbmfit <- gbm(MEDV ~., data = bh[t.id,], distribution = "gaussian")