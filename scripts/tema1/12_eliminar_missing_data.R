housing.data <- read.csv("../data/tema1/housing-with-missing-value.csv", header = T, stringsAsFactors = FALSE)
#para hacer un resumen de los datos cargados se usa summary para ver con lo que nos estamos enfrentando
summary(housing.data)

# como se puede ver existen muchos NAs una solucion seria eliminar todas las filas que tengan NA

housing.data.1 <- na.omit(housing.data)
summary(housing.data.1) # como se puede ver ya no existen NAs pero altera el resto de las estadisticas 



# la otra solucion seria eliminar solo los NAs de una columna no de todas 

drop.na <- c("rad") # con esto informo a mi programa que los NA que estan en la columna con nombre rad no se toquen se dejen tal cual
housing.data.2 <- housing.data[complete.cases(housing.data[,!(names(housing.data))%in% drop.na]),] #el complete.case elimina 
summary(housing.data.2) # como se puede ver ya no existen NAs a exepecion de la columna rad que fue exluida y donde aun existen 


#tambien se puede eliminar toda una columna en caso que sean mas NAs que informacion

housing.data$rad <- NULL
summary(housing.data)


# en el caso de querer eliminar mas de una variable(columna)

drops<- c("rad","ptratio") # creo una variable con las columnas que quieor eliminar
housing.data.3 <- housing.data[,!(names(housing.data) %in% drops)] # de housing.data me quedo con las columnas donde los nombres de housing.date no estan dentro de drops
summary(housing.data.3)
