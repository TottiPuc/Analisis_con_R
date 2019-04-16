install.packages("Cluster")
install.packages("factoextra")
library(cluster)
library(factoextra)
protein <- read.csv("../data/tema5/protein.csv")
rownames(protein) <- protein$Country
protein$Country = NULL
protein.scaled <- as.data.frame(scale(protein))

# el algoritmo pam se basa en buscar los kmedodides de todas las observaciones en un numero determinado de clusters en este caso 4
km <- pam(protein.scaled, 4)
km

fviz_cluster(km)


#OTRO TIPO DE PARTICION USADA PARA DATASET ENORMES ES CLARA QUE USA LAS MISMAS IDEAS DE PAM

clarafit <- clara(protein.scaled , 4 , samples = 5)
clarafit

fviz_cluster(clarafit)
