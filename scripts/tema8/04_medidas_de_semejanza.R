install.packages("lsa")
library(lsa)

mtcars <- read.csv("../data/tema7/mtcars.csv")
head(mtcars)
mtcars$X <- NULL

# Distancia Euclidea

coche1 <- mtcars[1,]
coche2 <- mtcars[2,]


# si dos coches son iguales la distancia es cero si no sera uno
# la distancia euclidiana esta dada por 

sqrt(sum((coche1- coche2)*(coche1- coche2)))
# o que es lo mismo que usar
dist(coche1, coche2, method = "euclidean")

# otro ejemplo  con dos distribuciones normales aletoria

x1 <- rnorm(100)
x2 <- rnorm(100)
# como son dos filas tengo que hacer un rbind
dist(rbind(x1,x2),method="euclidean")



#USANDO COSENO

v1 <- c(1,0,1,1,0,1,1,0,0,1)
v2 <- c(0,1,1,1,0,0,1,0,1,0)
cosine(v1,v2)


# Correlacion de Pearson que mide cuando dos elementos estan correlacionados entre si

pear <- cor(mtcars, method = "pearson")
pear
