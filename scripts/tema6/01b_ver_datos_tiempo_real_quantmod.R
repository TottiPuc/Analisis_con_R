install.packages("quantmod")
library(quantmod)

##CARGAR DATOS EN TIEMPO REAL

# se usa la funcion getSymbols y se pone el nombre de la empresa como aparece en los stooks de las APPis

getSymbols("AAPL") # nos da un objeto tupo de xts que es espeial para trabajar con divisas 
barChart(AAPL) # este es del mismo paquete quantmod

chartSeries(AAPL, TA = NULL) # con esto solo tenemos la informacion temporal ninguna otra informacion en el grafico
head(AAPL)

#seguimos trabajando con la columna de cierre que es la 4
chartSeries(AAPL[,4], TA = "addMACD()") # con esto incorporamos informacion de la convergencia y divergencia del cambio de la media


#AHORA PARA NETFLIX 


getSymbols("NFLX") # nos da un objeto tupo de xts que es espeial para trabajar con divisas 
barChart(NFLX) # este es del mismo paquete quantmod

chartSeries(NFLX, TA = NULL) # con esto solo tenemos la informacion temporal ninguna otra informacion en el grafico
head(NFLX)

#seguimos trabajando con la columna de cierre que es la 4
chartSeries(NFLX[,4], TA = "addMACD()") # con esto incorporamos informacion de la convergencia y divergencia del cambio de la media

