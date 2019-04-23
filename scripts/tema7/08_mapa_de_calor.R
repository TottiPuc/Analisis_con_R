#heat map
install.packages(c("ggmap","maps"))
library(ggmap)
library(maps)
library(devtools)
install.packages("rlang")
tartu.data <- read.csv("../data/tema7/tartu_housing.csv", sep = ";") # este dataset viene separado por ; por esose especifica asi

head(tartu.data)
# primero unicaremos esta ciudad TARTU en un mapa  y pintaremos sus latitudes y longitudes

devtools::install_github("dkahle/ggmap", ref = "tidyup", force=TRUE)
library(ggmap)
register_google(key = "COLOCAR LA API")

tartu.map <- get_map(location = "tartu", maptype = "satellite", zoom = 12, api_key = "COLOCAR LA API")
ggmap(tartu.map, extent = "device")+
  geom_point(data = tartu.data, aes(x=lon, y=lat),
             colour = "red", alpha = 0.12, size =2)

#otro tipo de mapa

tartu.map2 <- get_map (location = "tartu", zoom = 13)
ggmap(tartu.map2, extent = "device")+
geom_density2d(data = tartu.data, aes(x=lon, y=lat),
               size =.3)+ #hasta aca va solo lineas añadiremos colores
  stat_density2d(data = tartu.data, aes(x=lon, y=lat, 
                                        fill=..level..,
                                        alpha=..level..),
                 size=0.01, bins=16, geom = "polygon")+
  scale_fill_gradient(low = "green", high = "red")+
  scale_alpha(range = c(0, 0.25), guide=F)
