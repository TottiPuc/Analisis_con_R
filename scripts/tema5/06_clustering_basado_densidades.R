# es un cluster que se usa cuadno la informacion contiene ruido o outlyers

install.packages(c("fpc", "NbClust", "cluster", "factoextra"))
library(fpc)
library(factoextra)

data("multishapes", package = "factoextra") # este es un dataset del paquete factoextra
head(multishapes)
# nos qeudaremos con la columna x y y para saber si atinamos a la forma que es el cluster correspondiente 

dataPoints <- multishapes[,1:2]
plot(dataPoints)
#podemos ver que existen ruido o informacion innecesaria que son los puntos alejados de los circulos que pueden ser outlyers
# como se puede ver es un dataset que es poco util para clusterizar a primera por que la 
#bola grande engloba la pequeña cosa que dificulta su clusterizacion 

# vamos a ver que pasa con un kmeans y 5 clusters

km <- kmeans(dataPoints, 5)
# representamos el cluster
fviz_cluster(km, data = dataPoints)
# nos fijamos que mala division ha hecho los circulos ya que las bolas no los quieor separar

dsFit <- dbscan(dataPoints, eps = 0.15, MinPts = 5) # esto nos ayudara a elegir la mejor representacion de los cluster
# basado en las densidades, donde eps es el raadio entre muestas del dataset y MinPts es el numero de puntos minimos para el cluster  
dsFit

fviz_cluster(dsFit, dataPoints, geom = "point")
# lo importante es jugar con EPS y MINPTS para encontrar la mejor figura del dataset class 97 sec 7