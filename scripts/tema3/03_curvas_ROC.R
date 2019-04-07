install.packages("ROCR")
library(ROCR)


data1 <- read.csv("../data/tema3/roc-example-1.csv")
data2 <- read.csv("../data/tema3/roc-example-2.csv")

#pedictor basado en enteros

#0 <- indicara el fallo
#1 <- indicara exito
pred1 <- prediction(data1$prob, data1$class) # objeto de prediccion
perf1 <- performance(pred1, "tpr", "fpr") # objeto medidor de la eficiencia del objeto anterior con lo que se ve un falso positivo y un verdadero positivo

plot(perf1)
lines(par()$usr[1:2],par()$usr[3:4])

#ahora miraremos un punto con el que lidearemos entre falsos y verdaderos positivos 

prob.cuts.1 <- data.frame(cut = perf1@alpha.values[[1]],
                          fpr = perf1@x.values [[1]],
                          tpr = perf1@y.values [[1]])

head(prob.cuts.1)
tail(prob.cuts.1) 
# por ejemplo para qeudarme con un  80 % de probalididad de acierto entonces lidiaria con un punto encimade 0.8

prob.cuts.1[prob.cuts.1$tpr>=0.8,] # con esto sabria que desde el dato 55 con un corte de 49% puedo decir que son verdaderos

#predictor basado en etiquetas 

pred2 <- prediction(data2$prob , data2$class, label.ordering = c("non-buyer", "buyer"))
perf2 <- performance(pred2, "tpr", "fpr")

plot(perf2)
lines(par()$usr[1:2], par()$usr[3:4]) # esto es para crear una linea desde el 00 hasta el final de la grafica 

#clase 60 
