library(caret)
install.packages("randomForest")
library(randomForest)


banknote <- read.csv("../data/tema3/banknote-authentication.csv")
banknote$class <- factor(banknote$class)

set.seed(2018)

training.ids <- createDataPartition(banknote$class, p = 0.7 , list = F)
mod <- randomForest(x = banknote[training.ids, 1:4],
                    y = banknote[training.ids, 5],
                    ntree = 500,
                    keep.forest = T)

pred <- predict(mod, banknote[-training.ids,], type = "class")
table(banknote[-training.ids, "class"], pred, dnn = c("actual", "predicho"))

probs <- predict(mod, banknote[-training.ids,], type = "prob")
pred2 <- prediction(probs[,2], banknote[-training.ids, "class"])

perfor3 <- performance(pred2, "tpr", "fpr")
plot(perfor3)
