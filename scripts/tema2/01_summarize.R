data <- read.csv("../data/tema2/auto-mpg.csv", header = T, stringsAsFactors = F)

# vamos a convertir la variable cilider que es numerica a categorica con factor
# donde levels es el numero de cilindros y label la nueva etiqueta 
data$cylinders <- factor(data$cylinders, levels = c(3,4,5,6,8),
                         labels = c("3cil","4cil","5cil","6cil","8cil"))
#con la funcion summary muestra estadistica si la variables es numerica 
# el numero de repeticiones si es variable categorica tipo factor
#o nos dara el numero de strings si es solo de strings

summary(data)

# la funcion str nos da la estructura general del data frame es muy importante
# que nos dira el tipo de objetos que tendra nuestra estructura

str (data)

#para variables concreta se usa la sintaxis del $

summary(data$cylinders)
summary(data$mpg)

str(data$cylinders)


install.packages(c("modeest","raster","moments"))
library(modeest) #moda
library(raster) # quantiles, coeficiente de variacion
library(moments) # asimetria, curtosis

### cuando el CRAN no esta actualizado pa instalar paquetes o dependencias 
### es necesario utilizar biocManager que actualizaras los mirrors
install.packages("BiocManager")
library("BiocManager")
BiocManager::install("genefilter")
##########################################

# esta sera la variable de ejemplo pa aplicar las medidas estadisticas
X <- data$mpg


###### medidas de centralizacion que indicara como de centrados estan los datos
mean(X)
median(X)
mfv(X) # moda retorna el valor que mas se repite
quantile(X)

### medidas de dispercion, nos hace ver cuanto nuestros datos se desplazan mucho o poco de la media por ejemplo

var(X) # varianza
sd(X) # desviacion estandar
cv(X) # coeficiente de variacion

### medidas de asimetria (momentos)

skewness(X)   #asimetria
kurtosis(X)   #curtosis


hist(X)
