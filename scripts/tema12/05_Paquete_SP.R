#conversion entre data frame y datos espaciales
library(sp)

nj <- read.csv("../data/tema12/nj-wages.csv")
class(nj) # muestra un data frame normal no reconoce las latitudes ni longitude
head(nj)
#para convertirlo a un data frame espacial solo hacemos
coordinates(nj) <- c("Long", "Lat")
class(nj) # ahora ya es espacial solo indicando la longitud y latitud del dataframe

plot(nj)

spatial_lines <- function(spdf, name = "dummy"){
 temp <- SpatialLines(list(
                            Lines(
                              list(Line(coordinates(nj))),"Linenj")
                            )
                      )
 return(temp)
}
sp<- spatial_lines(nj)
plot(sp)
