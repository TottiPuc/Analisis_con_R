# esta es una funcion que se utiliza para crear modelos autorregresivos integrando la media movil par series temporales univariantes

inf <- read.csv("../data/tema6/INFY-monthly.csv")
#creamos la serie temporal apartir del valor ajustado del cierre

inf.ts <- ts(inf$Adj.Close, start = c(1999,3), frequency = 12)

# ahora con la serie ya creada hacemos el modelo autogregresivo para la prediccion

inf.ari <- auto.arima(inf.ts)
summary(inf.ari)

# vamos a predecir a 24 meses

inf.fore <- forecast(inf.ari, h =12)
plot(inf.fore, col = "red", fcol = "green")
