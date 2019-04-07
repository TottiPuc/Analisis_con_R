cp <- read.csv("../data/tema3/college-perf.csv")

#con order se ordena los niveles de factores de la variable en este caso Perf de acuerdo al 
# rango que le demos en este caso low estara por debajo de medium que a su ves estara por debajo de high

cp$Perf <- ordered(cp$Perf, levels = c("Low", "Medium", "High"))
cp$Pred <- ordered(cp$Pred , levels = c("Low", "Medium", "High"))

# ahora se generara una matriz de confusion con una tabla de doble entrada con los datos de entrada y los valores obtenidos con el modelo

table <- table(cp$Perf, cp$Pred, dnn = c("actual","Predecido"))
table # esto nos muestra la matriz de confusion de frecuencias absolutas

# para poder ver los resultados en porcentajes se usa
prop.table(table)
#para redondear los valores y dar el 100% de cada fila se hace lo siguiente
round(prop.table(table, 1)*100,2) # el coma 2 es el numero de decimales que queremos

barplot(table, legend = T,
        xlab = "Nota predecida por el modelo")

mosaicplot(table, main = "eficiencia del modelo")

# con la funcion summary aplicada directamente sobre la tabla aportara informacion util  como el nuemor de casos en la tablanumero de factores que se estan analizando

summary(table)
# con un p-value bajo  como respuesta de lo anterior se indica que la eficiencia del modelo es buena

