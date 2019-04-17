# haremos un analisis y una prediccion de una serie temporal para un dataset de yahoo finanzas

install.packages("forecast")
library(forecast)

inf <- read.csv("../data/tema6/infy-monthly.csv")
head(inf)
tail(inf)

# creamos la serie temporal que inicia desde marzo de 1999 con una frequencia mensual osea frecuencia =12
#la variablde Adj.close es la que vamos a predecir 
inf.ts <- ts(inf$Adj.Close, start = c(1999,3), frequency = 12)
inf.ts
plot(inf.ts)

# ahora llevaremos acabo el suavizado exponencial con un filtro convolucional

inf.hw <- HoltWinters(inf.ts) # esto crea una prediccion de la serie es el modelo para predecir
head(inf.hw)

plot(inf.hw, col = "blue", col.predicted = "red") # se grafica la original y la que se predijo

# podemos ver el error cuadratico medio que se ha cometido entre las originales y las predichas 
inf.hw$SSE

#los siguientes son los dos valores del filtro exponencial
inf.hw$alpha
inf.hw$beta
head(inf.hw$fitted) # que muestra los valores ajustados del modelo


# vamos a pedecir mas alla del ultimo valor del filtro con forecast <- prediccion

infy.fore <- forecast(inf.hw, h=24) # se pasa el modelo y se pide que prediga a 24 meses 
plot(infy.fore) # la linea azul es el predicho el gris oscuro es el intervalo de confianza del 80% y el gris claro el de 95%
infy.fore$lower # con esta tenemos los valores del intervalo de confianza
