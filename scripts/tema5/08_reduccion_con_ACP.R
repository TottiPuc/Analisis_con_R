# ACP es uno de los mejores metodos lineales a la hora de tratar con probelmas de reduccion de dimensionalidad
#cuadno existe mucha correlacion entre variables
install.packages("corrplot")

library(corrplot) # usado para encontrar la matriz de correlacion que es muy util para
# ver que variables tienen relacion entre ellas y cuales no y por tanto ACP puede reducir
# lo importante es reducir lo que mas se pueda las variables preditoras
# ahora dejarmeos de lado la variable a predecir en este caso MEDV
bh <- read.csv("../data/tema5/BostonHousing.csv")

corr <- cor(bh[,-14]) # con esto analizamos las variables predictoras y su correlacion
corr
corrplot(corr, method = "circle")
# esta matriz se entiende de la siguiente forma 
# correlaciones positivas o muy ligadas entre variables se pintan de azul o son mas cercanas a 1 
#por eso cada variable esta muy correlacionada consigo misma y tiene la diagonal principal
# las correlaciones negativas se pintan de rojo cuanto mas rojo quiere dicir que las variables no estasn para nada correlacionadas

bh.acp <- prcomp(bh[,-14], scale = T) # con scale = T usa la matriz de correlaciones con scale =F usa la matriz de covarianzas
summary(bh.acp) # con esto puedo ver el valor Cumulative Proportion que nos da el porcentaje con el que se 
# explican mejor el dataset en este cas con 7 variables PC7 ya explicamos el 89% de la variabilidad del dataframe en los datos

plot(bh.acp) # que es la represnetacion de las varianzas para cada una de las componentes principales 
plot(bh.acp, type = "lines")

biplot(bh.acp, col = c("gray","red"))

head(bh.acp$x, 5) # de los 5 primeros datos sus coimponents principales
# la atriz de rotacion de cada componente principal, que muestra que combinacion lineal hay que llevar acabo de los componentes principales 

bh.acp$rotation
bh.acp$sdev # que muestra que importancia o cuanto se explica de cada variable en el dataset
