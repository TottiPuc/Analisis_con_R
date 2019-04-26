# la idea de esta funcion es dividir -> aplicar -> combinar
#plyr, 
#XYply donde X,Y = a -> array, d-> data.frame, l-> lista

install.packages("plyr")
library(plyr)


auto <- read.csv("../data/tema10/auto-mpg.csv", stringsAsFactors = F)
auto$cylinders <- factor(auto$cylinders,
                         levels = c(3,4,5,6,8),
                         labels = c("3C", "4C", "5C", "6C", "8C"))

# entonces vamos a calcular el promedio de la variable mpg para cada tipod e cilindro

ddply(auto, "cylinders", function(df){mean(df$mpg)})
ddply(auto, ~cylinders , function(df){mean(df$mpg)})

ddply(auto, c("cylinders", "model_year"),
      function(df){
        c(mean = mean(df$mpg),
          min = min(df$mpg),
          max = max(df$mpg))
      })

# en la siguiente vamos a usar la funcion summarize para hacer un resumen de cuantos cilindros hay por categoria de cilindrosy cual es su promedio

ddply(auto, .(cylinders), summarize,
      freq = length(cylinders), meanmpg = mean(mpg))

# para hacer graficos sonde entra un dataframe y no devuelve nada
par(mfrow=c(3,2))
d_ply(auto, "cylinders", summarize,
      hist(mpg, xlab = "millas por galon",
           main = "Histograma de frecuencias", breaks = 5))

# se pueden combinar dos dataframes que esten en una lista o dos parametros que esten en una lista
# por ejemplo tenemos la lista autos que tiene dos elemntos que son el mismo dataframe auto

autos <- list(auto, auto)
head(autos)

auto.big <- ldply(autos , I) # lo que hace es al final del primer datafame poner el segundo
head(auto.big)

