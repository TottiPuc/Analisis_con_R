data<- read.csv("../data/tema2/boston-housing-classification.csv")
training.ids <- createDataPartition(data$MEDV_CAT, p=0.7, list = F)
data.trainig <- data[training.ids,]
data.validations <- data[-training.ids,]

# y en el caso que se quiera hacer para treniamento validacion y test se hae lo mismo que con las numericas

training.ids.2 <- createDataPartition(data$MEDV_CAT, p=0.7 , list = F)
data.trainig.2<- data[training.ids.2,] # toma el 70%
temp<- data[-training.ids.2,] # variable temporal para crear los otros dos conjuntos validacion y test
training.ids.3 <- createDataPartition(temp$MEDV_CAT, p=0.5 , list = F)
data.validation.2 <- temp[training.ids.3,]
data.test.2 <- temp[-training.ids.3,]



# pero para no hacer todo manual podemos crear nuestras propias funciones e incorporarlas a nuestras librerias

data.div2<- function(dataframe, target.index, porcen){
  library(caret)
  training.ids <- createDataPartition(dataframe[,target.index], p=porcen , list = F)
  list(train = dataframe[training.ids,],val = dataframe[-training.ids,])
}




data.div3 <- function(dataframe , target.index, perctr, percvl){
  library(caret)
  training.ids <- createDataPartition(dataframe[,target.index], p=perctr , list = F)
  train.data <- dataframe[training.ids,]
  temp <- dataframe[-training.ids,]
  validation.ids <- createDataPartition(temp[,target.index], p = percvl, list = F)
  list(train = train.data, val = temp[validation.ids,], test = temp[-validation.ids,])
}

example1 <- data.div2(data, 14, 0.8)
example2 <- data.div3(data, 14, 0.7, 0.5)


# tambien se puede hacer una extraccion aleatoria de n elmentos con la funcions sample
nrow(data) # para saber el numero de filas de un dataframe
ncol(data) # para saber el numero de columnas de un dataframe

datos <- sample(data$CRIM , 40 , replace = F) # esto hace una extraccion de 40 muestras aleatorias de la variables 
#CRIM sin muestras repetidas ya que el parametro replace = F no hace que se repitan
