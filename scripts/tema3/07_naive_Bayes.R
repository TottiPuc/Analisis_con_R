install.packages("naivebayes")
install.packages("caret")
install.packages("e1071")
library(e1701)
library(naivebayes)
library(caret)

ep <- read.csv("../data/tema3/electronics-purchase.csv")
# el algoritmo naive bayes requiere que todas las variables sean categoricas 

# primero se crea el modelo
set.seed(2018)
t.ids<- createDataPartition(ep$Purchase, p= 0.67, list = F)
mod <- naiveBayes(Purchase ~ ., data = ep[t.ids,])
mod

# ahora probamos el modelo creado

pred <- predict(mod, ep[-t.ids,])
tab <- table(ep[-t.ids,]$Purchase, pred, dnn = c("actual","predicha"))
confusionMatrix(tab)
