install.packages("e1071") # libreria que contiene el svm
install.packages("caret")
library(caret)
library(e1071)


banknote <- read.csv("../data/tema3/banknote-authentication.csv")
banknote$class = factor(banknote$class)

set.seed(2018)

t.ids <- createDataPartition(banknote$class, p = 0.7, list = F)
#svm(variable que va a ser predicha ~ , en funcion de cuales variables)
mod <- svm(class ~., data = banknote[t.ids,])

table(banknote[t.ids,"class"], fitted(mod), dnn = c("actual", "predicha"))

pred <- predict(mod, banknote[-t.ids,])
table(banknote[-t.ids, "class"], pred, dnn = c("actual","predicho"))

plot(mod, data=banknote[t.ids,], skew ~ variance) # solo se graficara dos variables para visualizar el entrenamiento
plot(mod, data=banknote[-t.ids,], skew ~ variance) # solo se graficara dos variables para visualizar el test
