# Conversiones entre DF, Mapas y objetos
library(sp)
library(sp)
install.packages("maptools")
library(maptools)

#maps -> spatial poligons -> spatial poligons data frame

nj.data <- read.csv("../data/tema12/nj-county-data.csv")
rownames(nj.data) <- nj.data$name
nj.data$name <- NULL
head(nj.data) # este es un DF normal donde se tiene estados pero no se tiene 
#latitudes ni longitudes para poderlo representar

nj.map <- map("county", "new jersey", fill = T, plot = F)
str(nj.map) # con esto tengo cordenadas de lat y long para nj

#nj,map tiene el nombre del estado con sus condados separados por comas 
# los separamos y pedimos solo el segundo campo que es el condado
nj.county<- sapply(strsplit(nj.map$names, ","), function(x) x[2])

#ahora lo mapeamos a spetial poligonos

nj.sp <- map2SpatialPolygons(nj.map, IDs = nj.county,
                             proj4string = CRS("+proj=longlat +ellps=WGS84"))
class(nj.sp)

nj.spdf <- SpatialPolygonsDataFrame(nj.sp, nj.data)
class(nj.spdf)

plot(nj.spdf)
spplot(nj.spdf, "per_capita_income", main= "renta per capita")
spplot(nj.spdf, "population", main= "poblacion")
spplot(nj.spdf, "median_family_income", main= "ingresos promedio de familia")
spplot(nj.spdf, c("per_capita_income","median_family_income") , main= "ingresos")
