install.packages("devtools")
library(devtools)

protein <- read.csv("../data/tema5/protein.csv")

rownames(protein) = protein$Country # cambio el nombre de las filas
protein$Country = NULL # elimino la variable Country
#por ultimo hacemos la version escalada o normalizada del dataset

protein.scale <- as.data.frame(scale(protein))

#ahora para trabajar con kmeans vamos a utilizar una libreria que esta en github para eso se hace lo siguiente

devtools::install_github("kassambara/factoextra") # donde kassambara es el usuario del repositorio github, esta es unal ibreria que ayuda 
library(factoextra)
# a representar los cluster representados por kmean en el caso de tener muchas variables 

# con la libreria intalada creamos el kmeans
# donde k es el numero de grupos en los que se quiere agrupaar los paises

km <- kmeans(protein.scale, 4)
km # esto devuelve el grupo al que el pais pertenece 
#para calcular la media de cada variable dentro del culster se tiene 

aggregate(protein.scale, by = list(cluster = km$cluster), mean)
# para este ejemplo seria imposible representar nuestras nueve variables parar eso se usa la librerria
#factoextra que hará ese trabajo

fviz_cluster(km , data = protein.scale)
