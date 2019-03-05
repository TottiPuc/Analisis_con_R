install.packages("Hmisc")
library(Hmisc)
housing.data<-read.csv("../data/tema1/housing-with-missing-value.csv")
housing.data.copy1 <- housing.data

# en la columna llamada ptratio de housing.data.copy1 vamos a llenar los NA con la media de la misma columna usando impute
housing.data.copy1$ptratio <- impute(housing.data.copy1$ptratio, mean)


# en la columna llamada rad de housing.data.copy1 vamos a llenar los NA con la media de la misma columna usando impute
housing.data.copy1$rad <- impute(housing.data.copy1$rad, mean)
summary(housing.data.copy1)


# en la columna llamada  ptratio y rad de housing.data.copy2 vamos a llenar los NA con la mediana de las mismas columnas usando impute
housing.data.copy2 <- housing.data                                 
housing.data.copy2$ptratio <- impute(housing.data.copy2$ptratio,median)
housing.data.copy2$rad <- impute(housing.data.copy2$rad,median )
summary(housing.data.copy2)



# ANTES DE ELIMINAR O RELLENAR INFORMACION FALTANTE ES BUENO MIRAR GRAFICAMENTE COMO CADA UNA DE LAS VARIABLES SE COMPORTA, A TRAVÉS DE EL PAQUETE MICE

install.packages("mice")
library(mice)
#esta funcion muestra los patrones qeu siguen la informacion que falta 
md.pattern(housing.data)



install.packages("VIM")
library(VIM)

#con la siguiente funcion podemos ver la cantidad de informacion faltante
aggr(housing.data, col=c('green','red'), number =T, sortVar =T, label = names(housing.data), cex.axis =0.75, gap = 1, ylab = c("histograma de NA","Patron"))
# con number se da los porcentajes,
# con sortVar se las ordena de mayor a menor
# con label se pone los nombres del data.frame original en las variables
#con cex.axis se cambia el tamaño de la fuente
# con gap se reduce el espacio entre graficos
# con ylabel se puede dar nombres personalizados a los ejes y de las graficas