#Cargar ficheros ESRI

install.packages("sp")
install.packages("rgdal")

library(sp)
library(rgdal)

countries.sp <- readOGR("../data/tema12/natural_earth",
                        "ne_50m_admin_0_countries")

airports.sp <- readOGR("../data/tema12/natural_earth",
                       "ne_50m_airports")

class(countries.sp)
class(airports.sp)

#graficamos los paises
plot(countries.sp, 
     col = countries.sp@data$admin)

# ahora graficamos los aeropuertos con add=T para que los pinte encima del anterior mapa
plot(airports.sp, add=T)

#grafico de l economia de cada pais
spplot(countries.sp, c("economy"))
#grafico de la poblacion estimada de cada pais
spplot(countries.sp, c("pop_est"))
