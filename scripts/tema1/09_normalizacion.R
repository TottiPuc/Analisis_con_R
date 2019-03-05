#esta normalizacion es mas bien un rescalado entre cero y uno
install.packages("scales")
library(scales)
students <- read.csv("../data/tema1/data-conversion.csv")
students$Icome.rescaled <- rescale(students$Income) # con estos e normaliza la columna Income del data
                                        #frame llamado students y la signa a una nueva columna llamada Icome.rescaled

# la funcion rescales es la misma normalizacion donde le valor mas pequeño tomara el valor de 0 y el mas grande el valor de 1
(students$Income - min(students$Income))/
  (max(students$Income) - min(students$Income))

rescale(students$Income, to = c(0,100)) # esto hace lo mismo que las 2 funciones anteriores solo que el resultado esta en porcentaje

# lo anterior es manualmente para normalizar columna por columna
# puedo crear una funcion que normalize de una sola vez todas las columnas que ingrese como parametro
# la funcion se llamara rescale.many

rescale.many <- function(dataframe,cols){
  names <- names(dataframe) # se toma los nombres de las columnas originales
  for (col in cols) { #para cada columna del vector  de columnas de entrada haga losiguiente
    name <- paste(names[col], "rescaled",sep = ".") #cree una nueva columna con el nombre original + .rescaled (paste es para concatenar)
    dataframe[name] <- rescale(dataframe[,col])
  }
  cat(paste("se han normalizado", length(cols), "variables")) # con car se muestra por consola
  dataframe # se retorna el propio dataframe
}

students <- rescale.many(students,c(1,4)) # provando la funcion 
