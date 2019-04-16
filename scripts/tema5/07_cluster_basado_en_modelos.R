# estos clusters utilizan la tecnica de la maxima expectacion para intentar obtener le modelo mas faborable para poder inferir el numeor de cluster debe llevar acabo

install.packages(c("mclust", "fpc", "NbClust", "cluster", "factoextra"))
library(fpc)
library(factoextra)
library(mclust)
library(NbClust)
library(cluster)

data("multishapes", package = "factoextra") # este es un dataset del paquete factoextra
head(multishapes)
# nos qeudaremos con la columna x y y para saber si atinamos a la forma que es el cluster correspondiente 

dataPoints <- multishapes[,1:2]
plot(dataPoints)

mclust <- Mclust(dataPoints)
# la anterior funcion ha elaborado varios modelos asi que miraremos cual es el mas adecuado

plot(mclust) # para salir del cluster se pone 0

summary(mclust)
