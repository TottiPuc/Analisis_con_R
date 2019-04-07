usarrest <- read.csv("../data/tema1/USArrests.csv", stringsAsFactors = F)

#vamos a cambiar el indentificador padron numerico 1,2,3... por el mismo nombre de las ciudades

row.names(usarrest) <- usarrest$X
#como ahora ya tengo identificados los estados con la accion de arriba entonces la columna X la puedo eliminar

usarrest$X <- NULL

# calcular la varianza que existe en cada variable del dataframe
apply(usarrest, 2, var)
# con esto vemos que la variable que tiene mayor varianza es la de assault, que mas cambia de un estado a otro

# como el numero de asaltos es mucho mayor que el resto devariables siempre es bueno escalar o normalizar las variables antes de usar las tecnicas de ACP
# entonces se restara la media y se dividira la desviacion tipica para perder asi la variabilidad tan grande qeu tiene el datset 

acp <- prcomp(usarrest, center = T, scale. = T)
print(acp)

# pero una forma de ver mejor los datos es pintando directamente el acp

plot(acp, type = "l")
#con lo anterrior podemos ver que la varianza de las dos ultimas componenetes es muy baja por eso seria mejor despreciarlas 

# si queremos explicar que porcentaje de variabilidad nos quedamos se podria ver con un summer que nos presenta las respuestas acumulativas

summary(acp)
#podriamos decir que con PC1 y PC2 ya obtenemos mas del 80 % de variabilidad

biplot(acp, scale = 0)
#con el diagrama anterior se puede ver lo mismo de la matriz de rotacion se ve que las componentes murder assault y rape son mejor representadas o estan correlacionadas en la PC! y al Urbanpop esta mejor explicado en PC2 que es donde mas se mueve

# ahora para quedarme con las componente principales de cada variable y eliminar las que no sirven se hace lo siguiente

pc1 <- apply(acp$rotation[,1]*usarrest,1 , sum)
pc1
pc2 <- apply(acp$rotation[,2]*usarrest,1 , sum)
pc2

#ahora creo las dos componentes principales en el dataset original y elimiio el resto con eso tengo mas del 86% de informacion represntada so lo en dos componentes pricipales como se vio arriba

usarrest$pc1 <- pc1
usarrest$pc2 <- pc2
usarrest[,1:4] <- NULL
# con esto el dataset es mas liviano y explica lo mismo que el dataset original salvo algunos casos 

