housing <- read.csv("../data/tema1/BostonHousing.csv")
# se utilizara la funcion scale que es diferente a rescale y solo funciona para variables numericas
housing.z <- scale(housing) # esta funcion es la normalizacion estandar donde los valores mas cercanos a 0 seran los ideales los mas alejados seran los problematicos 
# esto es a cada valor de housing le resto la medio y lo dividio por la desviacion estandar

#esto seria lo mismo que hacer 
housing.z <- scale(housing, center = TRUE, scale = TRUE) # que es restar la media y dvir por la varianza

# los otros escenarios serian 

housing.none <- scale(housing, center = F, scale = F) # lo cual me daria el mismo data ser por que ni resto ni divido por nada 

housing.mean <- scale(housing, center = TRUE, scale = F) # simplemente se desplazaria la media de los datos originales pero las diferencias serian iguales al data set original

housing.scale <- scale(housing, center = F, scale = TRUE) # aqui solo se deivide por la desviacion tipica sin restar la media 


scale.many <- function(dataframe,cols){
  names <-names(dataframe) # se extraen todos los nombres de las columnas 
  for (col in cols) {
    name <- paste(names[col], "z",sep = ".") # para cada nombre de columna se crea otro con .z en el mismo dataframe
    dataframe[name] <- scale(dataframe[,col]) # en esa nueva variable creada anteriormente se escala cada columna del dataframe
  }
  cat(paste("se han normalizado", length(cols), "variables")) # se imprime por pantalla
  dataframe # se retorna el data frame
  
}


# se prueba la funcion
housing<-scale.many(housing, c(1,3,5:8))
