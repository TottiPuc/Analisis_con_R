install.packages("caret") # este es un paquete pa trabajar con particiones para NN
library(caret)

data<- read.csv("../data/tema2/BostonHousing.csv")
# identificadores de entrenamiento 
training.ids <- createDataPartition(data$MEDV, p=0.8, list = F) # con esto solo se cre un vector de numeros del uno hasta donde de el 80 % de la variable MEDV puede ser con cualquier variable

# esto seria solo si quiero entrenar y validar
data.training <- data[training.ids,] # con esto solo tomo el 80% de los valores del dataset osesa el 80% de las filas de todas las columnas
data.validation <- data[-training.ids,] # con esto tomo el restante de los valores osea el 20% osea el 20% restante de las filas de todas las columnas


# ahora si quiero entrenar validar y testar pues tengo que hacer uan tercera particion

training.ids.2 <- createDataPartition(data$MEDV, p= 0.7 , list = F) 

data.training.2 <- data[training.ids.2,] # obtengo el 70 % de entrenamiento
temp <- data [-training.ids.2,] #hago una variable temporal solo pa volver a dividirla
validations.ids.2 <- createDataPartition(temp$MEDV, p = 0.5 , list = F) # creo otros indicadores pa scar el resto de valores
data.validation.2 <- temp[validations.ids.2,] # obtengo el 50% del 30% restatne del dataframe para validar
data.testing.2<- temp[-validations.ids.2,] # y el resto para testar

