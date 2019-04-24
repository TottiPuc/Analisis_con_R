#analisis de datos para datasets que no estan balanceados 
install.packages(c("pROC","DMwR","caTools"))
library(caret)
library(pROC)
library(DMwR)
library(caTools)

ccdata <- read.csv("../data/tema8/creditcard.csv")
head(ccdata)
str(ccdata)
ccdata$Class <- factor(ifelse(ccdata$Class==0,"0","1"))
table(ccdata$Class) # podemos ver como esta de desbalanceado el dataser donde hay muchisimas tarjeta fraudulentas y pocas originales

# elejimos losdatos de entrenamiento y testing si aun continuan desbalanceado se hara un tratamiento

t.id <- createDataPartition(ccdata$Class, p=0.7, list = F, times = 1)
training <- ccdata [t.id,]
test <- ccdata[-t.id,]
# y los analisamos
table(training$Class)
table(test$Class)
# claramente el dataset esta desbalanceado

# se balanceara con datos simulados 
training <- SMOTE(Class ~ ., training, perc.under = 100, perc.over = 200)
table(training$Class)
# ahora esta con mas originales que fraudulentas 
# y creamo el modelo

training$Class <- as.numeric(training$Class)
trControl <- trainControl(method = "cv", number = 10) # cv = cross-validation de 10 partes
model <- train(Class ~., data = training, method = "treebag",
               trControl = trControl)
model

# separamos las variables predictoras 
predictors <- names(training)[names(training)!="Class"]
predictors
pred <- predict(model$finalModel, test[,predictors]) # tomo todas las variablesemos la class para hacer la prediccion
pred # que calculara la probabilidad de que esas tarjetas de credito sean fraudulentas

#calculo de la curva ROC
auc <- roc(test$Class,pred)
auc   # se ve que el valor esta por encima del 97% lo que significa que es un excelente modelo
plot(auc, ylim= c(0,1), print.thres=T,
     main = paste("AUC con SMOTE ", round(auc$auc[[1]],2)))
abline(h=1, col = "green", lwd=2)
abline(h=0, col = "red", lwd=2)
