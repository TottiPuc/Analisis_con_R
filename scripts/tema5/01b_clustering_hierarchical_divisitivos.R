install.packages("cluster")
library(cluster)

proteinas <- read.csv("../data/tema5/protein.csv")

data <- proteinas[,-1]

data <- as.data.frame(scale(data))

rownames(data) = proteinas$Country

#ahora utilizaremos la funcion diana para crear nuestro cluster divisitivo

dv <- diana(data, metric = "euclidean")
plot(dv)

