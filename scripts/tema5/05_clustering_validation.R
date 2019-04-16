# validaremos que tan bien estan construidos los cluster y como de bien esta represetnada su estructura
# segun la cantidad de datos presentes en el dataset, sirve para cualquier tipo de cluster

install.packages(c("fpc", "NbClust", "cluster", "factoextra"))

library(factoextra)
library(cluster)
library(fpc)
library(NbClust)

protein <- read.csv("../data/tema5/protein.csv")
rownames(protein) <- protein$Country
protein$Country = NULL
protein.scaled <- as.data.frame(scale(protein))


# vamos a encontrar el numero optimo de clusters o divisiones que necesitamos

nb <- NbClust(protein.scaled, distance = "euclidean",
              min.nc = 2, max.nc = 12, method = "ward.D2", index = "all")
# en este caso nos a arrojado que el mejor numero de clusters para este dataframe es 3

#para verlo mas claro podemos ver
fviz_nbclust(nb) + theme_minimal()

# sabiendo cual es el munero optimo de k podemos aplicar cualquier tecnica de cluster

km.res <- kmeans(protein.scaled, 3)
# ahora analizaremos su silueta

sil.km <- silhouette(km.res$cluster, dist(protein.scaled))
sil.sum <- summary(sil.km)
sil.sum

fviz_silhouette(sil.km) # representacion de silueta
# con lo anterior analizamos cuantos objetos de mi dataset tiene cada cluster en la columna size y su peso la cual mide la eficiencia de algoritmo
# dadno la medida de compactidad osea que tan compactos estan los cluster como de conectados y como de separados estan cada uno de ellos
# con esto cuanto mas cercano a -1 se encuentre cada valor peor clusterizado esta la muestra
# por su parte cuanto mas cercano a 1 estara mejor clusterisado y cuadno tiende a 0 es de terner
# en cuenta por que en ves de pertenecer al cluster que esta puede pertencer a otro


# ahora la representacion del cluster
fviz_cluster(km.res, data = protein.scaled)

# calculamos la matriz de distancias del cluster

dd <- dist(protein.scaled, method = "euclidean")
km_stats <- cluster.stats(dd, km.res$cluster)
km_stats

# para ver la suma total y el promedio de las distacncia de cada punto a su cluster mas cercano 

km_stats$within.cluster.ss # suma total
km_stats$clus.avg.silwidths # promedio
km_stats$dunn # es el cociente entre la distacnica mas pequeña de observaciones que no estan en el mismo cluster entre la distancia mas grande entre dos elmentos del mismo cluster
# este valor puede acercarse a 0 o irse a infinito  entre mas alto sea es mejor quiere decir que los cluster estan bien separados


#PARA CORROBORAR AHORA SE HACE LO MISMO PERO NO CON KMEAN SI NO CON K MEDODS O PAM

kmed <- pam(protein.scaled,3)
sil.kmed <- silhouette(kmed$clustering, dist(protein.scaled))
sil.kmedo <- summary(sil.kmed)
sil.kmedo
fviz_silhouette(sil.kmed) # representacion de silueta
fviz_cluster(kmed, data = protein.scaled)
kmed_stats <- cluster.stats(dd, kmed$clustering)
kmed_stats$within.cluster.ss # suma total
kmed_stats$clus.avg.silwidths # promedio
kmed_stats$dunn



#POR ULTIMO VAMOS A COMPARAR UN ALGORITMO CON OTRO

res.com <- cluster.stats(dd, km.res$cluster, kmed$clustering)
res.com$corrected.rand # indicie de correcion aleatoria es una medida de la similitud que existe entre ambas particiones ajustando el azar de modo que se encuentre 
# entre -1 y 1 donde -1 es los dos metodos no estan deacuerdo y 1 que es una coincidencia perfecta osea que tiene que ser cercano a 1 seria lo mejor
res.com$vi # variacion de la informacion es una medida de la distancia que existe entre los dos clusters esta tiene que tender a 0 que seria lo mejor quiere decir que la de arriba sera uno
