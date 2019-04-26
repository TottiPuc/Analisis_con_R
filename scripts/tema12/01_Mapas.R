#R Google Maps
install.packages("RgoogleMaps")
library(RgoogleMaps)

lat <- 1.203194
lon <- -77.292472

#### datos para conectar con la api de google maps ####
devtools::install_github("dkahle/ggmap", ref = "tidyup", force=TRUE)
library(ggmap)
register_google(key = " aqui va la api")
#######################################################

# mapa en forma de terreno y guardado en jpeg
hom.map <- GetMap(center = c(lat,lon), zoom = 17, 
                  API_console_key =  "aqui va la api",
                  destfile = "tema12/hom.jpeg",
                  format = "jpeg")

# mapa en vista de satelite y guardado en pdf
hom.map <- GetMap(center = c(lat,lon), zoom = 17, 
                  API_console_key =  "aqui va la api",
                  destfile = "tema12/hom.pdf",
                  format = "pdf",
                  maptype = "satellite")
PlotOnStaticMap(hom.map)
