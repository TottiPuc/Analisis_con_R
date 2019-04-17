# ANALISIS DIARIO
wmt <- read.csv("../data/tema6/WMT.csv", stringsAsFactors = F)

#graficaremos la linea temporal de los precios de cierre del dataset 
 plot(wmt$Adj.Close, type = "l")

 d<- diff(wmt$Adj.Close) # esto hace una diferencia del un dia con respecto al anterior empezando desde el primero
head(d) 

# grafico de esas diferencias

plot(d, type = "l")

# ahora averiguaremos si los cambios siguen una cierta tendencia

hist(d, prob=T, ylim = c(0,0.8), breaks = 30, main = "walmart Stokcs", col = "green")
lines(density(d), lwd = 3) # con esto representamos la funcion de probabilidad encima del histograma para eso el hist debe estar con prob=T


# ANALISIS MENSUAL

wmt.m <- read.csv("../data/tema6/WMT-monthly.csv", stringsAsFactors = F)
# crearemos la serie temporal
wmt.m.ts <- ts(wmt.m$Adj.Close)
#creamos las diferencias de un dia al siguiente aplicada a la serie temporal
d<-diff(as.numeric(wmt.m.ts))
d

#hacemos el retorno general de las divisas

wmt.m.return <- d /lag(as.numeric(wmt.m.ts), k = -1)
hist(wmt.m.return, prob=T, col = "red")
