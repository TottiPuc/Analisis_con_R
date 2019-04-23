#Plot Multivariante

install.packages(c("ggplot2","GGally"))
library(ggplot2)
library(GGally)

bike <- read.csv("../data/tema7/daily-bike-rentals.csv")
head(bike)

bike$season <- factor(bike$season,
                      levels = c(1,2,3,4),
                      labels = c("invierno","primavera","verano","otoño"))

bike$weathersit <- factor(bike$weathersit,
                          levels = c(1,2,3),
                          labels = c("despejado","nublado","lloviendo"))

bike$weekday <- factor(bike$weekday,
                       levels = 0:6,
                       labels = c("D","L","M","X","J","V","S"))

# el viento apesar  de ser numerica se puede categorizar cortando apartir de un numero se puede decir por ejemplo
# de 1.1 para abajo sera mucho viento de 1,1 hasta 2,2 poco viento y encima de 3.3 nada de viento

hist(bike$windspeed)
bike$windspeed.fac <- cut(bike$windspeed, breaks = 3,
                          labels = c("poco","medio","elevado"))
head(bike)


# vamos a hacer el analisi multivariante

ggplot(bike, aes(x=temp, y = cnt))+
geom_point(size =3, aes(color=windspeed.fac))+ #  aqui añadimos una dimension mas al grafico con la variable del viento
  theme(legend.position = "bottom")+
  geom_smooth(method = "lm", se=F, col="red")+ # añadimos la recta de regresion
  facet_grid(weekday ~ season) # # añadimos dos variables mas en forma de grid en este caso el dia de la semana en contra de la estacion del año




#GRAFICOS MULTIVARIABLES CON GGALLY

auto <- read.csv("../data/tema7/auto-mpg.csv", stringsAsFactors = F)
auto$cylinders <- factor(auto$cylinders,
                         labels = c("3C","4C","5C","6C","8C"))
#########
#exportar imagenes por codigo
#postcript
#postscript(file = "multivariant.ps")
pdf(file = "multivariant.ps")
# con lo anterior todo lo que se represente para abajo se guardara en dicha salida todos los formatos posibles 
#########

ggpairs(auto[,2:7], aes(color =cylinders, alpha =0.4),
        title = "analisis multivariables de coches ",
        upper=list(continuous = "density"),
        lower = list(combo = "denstrip"))+
  theme(plot.title = element_text(hjust = 0.5))

dev.off()# con esto se cierra el fichero del postscript almacenado
