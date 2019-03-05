ozone.data <- read.csv("../data/tema1/ozone.csv", stringsAsFactors = F)

#vamos a identificar la variable pressure_height del dataframe ozone.data a ver como se esta comportando
# el ultimo $out es para mostrar el grafico
outliers_values <- boxplot(ozone.data$pressure_height)$out # se le puede asignar a una variable

# o se puede graficar directamente

boxplot(ozone.data$pressure_height,
        main = "medida de presion", #poner titulo de grafica
        boxwex = 0.5 # mirar el ancho de la caja de la grafica
        )

# puedo crear un diagrama mucho mas informativo convinando dos variables una enfuncion de la otra siempre y cuadno tengas relacion
# para eso se utiliza la ~ 

boxplot(pressure_height ~Month, 
        data = ozone.data,
        main = "presure hight per month")

# porejemplo con otra variable el ozono en funcion del mes
boxplot(ozone_reading ~Month, 
        data = ozone.data,
        main = "ozone reading per month")

# si al final de l funcion pongo un $out puedo ver cuales son los valores de esos outliers
# de mi grafico de bigotes
boxplot(ozone_reading ~Month, 
        data = ozone.data,
        main = "ozone reading per month")$out





# AHORA REMPLAZAR LOS OUTLIERS POR VALORES ESTADISTICOS COMO MEDIA O VARIANZA esto es una imputacion

impute_outliers <- function(x, removeNA = T){
quantiles <- quantile(x, c(0.05, 0.95), na.rm = removeNA)
x[x<quantiles[1]] <- mean(x, na.rm = removeNA)
x[x>quantiles[2]] <- median(x, na.rm = removeNA)
x # siempre se debe retornar el vector modificado si no solo dara un valor
}
  

#probar la funcion anterior

impute.data <- impute_outliers(ozone.data$pressure_height)
  
  
# se grafica la variables con y sin outliers

par(mfrow = c(1,2))
boxplot(ozone.data$pressure_height, main = "presion con outliers")
boxplot(impute.data, main = "presion sin outliers")


# AHORA SE HACE UN REMPLAZO DE LOS OUTLIERS Y NO UNA IMPUTACION

replace.outliers <- function(x, removeNA = T ){
  qrts <- quantile(x, probs = c(0.25, 0.75), na.rm = removeNA) # calcula los quartiles por debajo 1 y 3
  caps <- quantile(x, probs = c(0.05, 0.95), na.rm = removeNA) # calcula los caps o la cola por encima y por debajo del intervalode confinza 0.5
  iqr <- qrts[2]- qrts[1] # esto es el rango interquartil la diferencia entre el 1 y el 3
  h <- 1.5 * iqr # esta es la altura de los bigotes
  x[x<qrts[1]-h] <- caps [1]
  x[x> qrts[2]+h] <- caps [2]
  x
  
}
capped.pressure.hight <- replace.outliers(ozone.data$pressure_height)

par(mfrow = c(1,2))
boxplot(ozone.data$pressure_height, main = "presion con outliers")
boxplot(capped.pressure.hight, main = "presion sin outliers")
