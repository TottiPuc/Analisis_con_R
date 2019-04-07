install.packages(c("rpart", "rpart.plot", "caret"))
 library(rpart)
library(caret)
library(rpart.plot)

banknote <- read.csv("../data/tema3/banknote-authentication.csv")
#vamos a partir el banco de datos original

set.seed(2018)
training.ids <- createDataPartition(banknote$class, p = 0.7 , list = F)

# vamos a generar el arbol

# class ~ . es igual a decir class ~ variance + skew + curtosis + entropy o la variable class depende de variance  de skne de curtosis y de entropia 
mod <- rpart(class ~ ., data = banknote[training.ids,],
             method = "class",
             control = rpart.control(minsplit = 20, cp = 0.01))
mod

# pintaremos el modelo del arbol
prp(mod, type = 2, extra = 104, nn = T,
    fallen.leaves = T, faclen = 4, varlen = 8,
    shadow.col = "gray")

# la siguiente tabla sirve para ver por donde se podria hacer el corte del arbol 
#para eso se coge el error minimo se le suma la desciavion estandar y dever superar el xerror
mod$cptable
# con lo anterior entonces se corta el modelo o arbol de la siguiente forma

mod.pruned <- prune(mod, mod$cptable[8, "CP"])

prp(mod.pruned, type = 2, extra =104, nn =T,
    fallen.leaves = T, faclen = 4, varlen = 8,
    shadow.col = "gray")

# ahora se testara 

pred.pruned <- predict(mod.pruned, banknote[-training.ids,], type = "class")

table(banknote[-training.ids,]$class, pred.pruned, dnn = c("acutal", "predicho"))


pred.pruned2 <- predict(mod.pruned, banknote[-training.ids,], type = "prob")

library(ROCR)
pred <- prediction(pred.pruned2[,2], banknote[-training.ids, "class"])

perfo <- performance(pred, "tpr", "fpr")
plot(perfo)
