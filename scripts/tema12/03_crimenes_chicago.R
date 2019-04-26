#Crimenes de chicago

install.packages(c("ggmap","maps"))
library(ggmap)
library(maps)
register_google(key = "aqui va la api")
crimes <- read.csv("../data/tema12/chicago-crime.csv")
head(crimes)

# vamos a convertir a formto fecha la fecha

crimes$Date <- strptime(crimes$Date, format = "%m/%d/%y %H:%M")
head(crimes)

#creamos el mapa
chicago <- get_map(location = "chicago", zoom = 11, API_console_key =  "aqui va la api" )
ggmap(chicago) + #vamos a representar los primeros 100 crimenes del dataframe
  geom_point(data = crimes[1:100,], aes(x=Longitude, y = Latitude))

# vamos a graficar la frecuencia del crimen basado en las latitudes y longitudes con un mapa de calor

counts <- as.data.frame(table(round(crimes$Longitude,2),
                              round(crimes$Latitude,2)
                              )
                        )
head(counts)

counts$Lon <- as.numeric(as.character(counts$Var1))
counts$Lat <- as.numeric(as.character(counts$Var2))
counts$Var1 <- NULL
counts$Var2 <- NULL
head(counts)

ggmap(chicago)+
geom_tile(data = counts, aes(x=Lon, y=Lat, alpha = Freq),
          fill = "red")  
