s <- read.csv("../data/tema6/ts-example.csv") # ejemplo de ventas de caulquier cosa em 100 dias
head(s)

s.ts <- ts(s)
class(s.ts)
head(s.ts)
plot(s.ts) # en este caso no se tiene una fecha especifica ni columan que representar el date

# ahora digamos que queremos asignarles un año a cada muestra del dataset
s.ts.a <- ts(s,start = 2001) # significa una frequencia anual
s.ts.a
plot(s.ts.a) # ahora si inicia desde el 2001

# en el caso de querer una serie mensaul

s.ts.m <- ts(s,start = c(2001,1), frequency = 12) # start = enero de 2001 = c(2001,1)
s.ts.m # obteniendo cada dato para un determinado mes
plot(s.ts.m)

# en el caso de una serie temporal trimestral 
s.ts.t <- ts(s, start = 2001, frequency = 4)
s.ts.t
plot(s.ts.t)

#saber cuando inicia una serie temporal
start(s.ts.m)
#saber cuando acaba
end(s.ts.m)
# la frequencia con la que se recolectaron datos
frequency(s.ts.m)



start(s.ts.t)
end(s.ts.t)
frequency(s.ts.t)



# para el caso que se tenga no solo una serie temporal si no varias series temporales en un dataset

prices <- read.csv("../data/tema6/prices.csv")
head(prices) # de nuevo dos variables numericas que carecen de fechas 

prices.ts <- ts(prices, start = c(1980,1), frequency = 12)
prices.ts # ya son series temporales con inicio el primer mes de 1980 y una frequencia mensual

plot(prices.ts) # se puede ver como R grafica las dos series temporales tanto la de la harina como la del gas

# en el caso de querer las graficas en un solo plot
plot(prices.ts,plot.type = "single", col=1:2)
legend("topleft", colnames(prices.ts),col = 1:2, lty =1)



# por lo general las series temporales se dicen q son multipllcativas un nuevo elemento el la multiplicacion de el con un antiguo
# para poder descomponerla se una logaritmo ya que 
#log(a*b) = Log(a) + log(b) y tenemos una descomposicion aditiva

#DESCOMPOSICION DE UNA SERIE TEMPORAL

#STL
#SEASONAL DECOMPOSITION OF TIME SERIES BY LOESS
#vamos a usar el mismo dataaset de la harina y el gas
flour.l<-log(prices.ts[,1]) # aplicamos log a la serie de la harina para hacerla aditiva y descomponerla con stl
flour.stl <- stl(flour.l,s.window = "period")
flour.stl
plot(flour.stl)

gas.l <- log(prices.ts[,2])
gas.stl <- stl(gas.l, s.window = "period")
plot(gas.stl)


#DECOMPOSE
#CLASSICAL SEASONAL DECOMPOSITION BY MOVIN AVERAGE
flour.dec <- decompose(flour.l)
plot(flour.dec)


gas.dec <- decompose(gas.l)
plot(gas.dec)


# ahora podemos ajustar los datos iniciales haciendo que de la informacion original
# del propio dataset se le elimina la informacion que la serie temporal determina que es estacional
#es decir que se va repitiendo estacion tras estacion, para asi tener una vision mas clara y concreta de caul
# es la tendencia global del mercado

gas.seasson.adjusted <- prices.ts[,2] - gas.dec$seasonal # en este casi escojimos el gas y le restamos su variable seasson
plot(gas.seasson.adjusted)


# si hacemos un filtro
n <- 12 #creamos el filtro en este caso con 12 por que la frecuencia es anual
weights = filter(1/n, n)
gas.filter <- filter(prices.ts[,2], filter = weights, sides = 1)
lines(gas.filter, col = "red", lwd =3)
