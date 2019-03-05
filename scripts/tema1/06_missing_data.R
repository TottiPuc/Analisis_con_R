data<- read.csv("../data/tema1/missing-data.csv", na.strings = "") # se busca los datos faltantes y se los remplaza por NA
data_cleaned <- na.omit(data) #elimina todas las filas del dataframe que contengan almenos un NA

is.na(data[4,2]) # pregunta si en la fila 4 colmna 2 hay un NA si es cierto devuelve un TRUE caso contrario devuelve un FALSE

is.na(data$Income)# se puede preguntar por toda una columna con la sintaxis del $ 
is.na(data[,1]) # o usando la funcion tradicional que es la misma de arriba

#solo extrae las filas que no contienen NA
data.income.cleaned <- data[!is.na(data$Income),]

#filas acompletas para un data frame solo si en esa fila no esxiste ninguna NA (hace los mismo que na.omit linea 2)
complete.cases(data)
data_cleaned.2 <- data[complete.cases(data),] # escoge todas las filas que esten sin NA

# convertir los ceros de ingresos en NA
data$Income[data$Income == 0] <- NA


# medidas de centralizacion y dispercion
mean(data$Income) # si la columna income tiene NA por seguridad mean no me dara valor promedio
mean(data$Income, na.rm = TRUE) # a diferencia de la linea anterior en esta linea se ignora los NA y se da un promedio de todas las variables
# lo mismo de arriba pasa con la desviacion tipica
sd(data$Income)
sd(data$Income, na.rm = TRUE)
