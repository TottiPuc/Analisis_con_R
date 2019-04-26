# lapplay y sapply se usan para trabajr con listas vectores y dataframes

#lapply devuelve los valores como listas

auto <- read.csv("../data/tema10/auto-mpg.csv", stringsAsFactors = F)
head(auto)

# para el caso de un vector
x <- c(1,2,3)
x
lapply(x, sqrt) # devuelve la raiz de cada elemento del vector pero en una lista
lapply(x, mean)
#ahora creamos una lista de listas 

x <- list(a=1:10 , b=c(1,10,100,1000), c=seq(5,50,5))
x
lapply(x, mean) # me da una media de cada lista de la lista
lapply(x, sqrt) # da la raiz de cada ele,mento de cada lista

class(lapply(x, mean)) # nos devuelve que es una lista, se puede acceder a cada elemento como en las listas
class(sapply(x, mean)) # nos devuelve que es nuemrica, ahora cada resultado es una columna de un dataframe


lapply(auto[,2:8], min) # devuelve un elemento de cada variable su minimo en una lista
lapply(auto[,2:8], min)[7] # donde se puede acceder a cada elemento como las listas
lapply(auto[,2:8], min)$model_year # donde se puede acceder a cada elemento como las listas o como variable con el $


sapply(auto[,2:8], min) # ahora es un vector numerico 
sapply(auto[,2:8], min) # de la columna dos a la 8 nos da el minimo de cada columna
sapply(auto[,2], min) # si quiero solo de una columna falla por que R trabaja con vector para solucionar eso se trabaja la columna como dataframe
sapply(as.data.frame(auto[,2]), min) # ahora si dara el minimo de la columna



#TAPPLY  es una funcion que se aplica a cada subnivel de un dataframe a cada factor de una variable

auto$cylinders <- factor(auto$cylinders,
                         levels = c(3,4,5,6,8),
                         labels = c("3C", "4C", "5C", "6C", "8C"))
# con lo anterior ya no tengo la variable cylinder como numerica si no como factor
class(auto$cylinders)
# ahora aplico a una de las variables numericas una funcion dependiendo de la cilindrada o de cada factor de la variable cylinder

tapply(auto$mpg, auto$cylinders, mean) # se obtiene el promedio de cada cillindro
# se puede aplicar a todas las variables factores pasandolas como lista
tapply(auto$mpg, list(cyl1=auto$cylinders), mean)


by(auto, auto$cylinders, 
   function(row){ cor(row$mpg, row$acceleration)}) # muestra como estan relacionadas
#las variables mpg y aceleracion para cada tipo de cilindro
