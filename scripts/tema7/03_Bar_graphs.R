# BAR CHAR es el que se decica a contar el numero de ocuerrencias de cada una de las variables de tipo factor que aparecen en los datos

install.packages("ggplot2")
library(ggplot2)
library(dplyr)

bike <- read.csv("../data/tema7/daily-bike-rentals.csv")
bike$season <- factor(bike$season,
                      levels = c(1,2,3,4),
                      labels = c("Invierno", "Primavera", "Verano","Otoño") )

bike$workingday <- factor(bike$workingday,
                          levels = c(0,1),
                          labels = c("dia libre", "dia de trabajo"))

bike$weathersit <- factor(bike$weathersit,
                          levels = c(1,2,3),
                          labels = c("buen tiempo", "Dia nublado", "mal tiempo"))

# ahora crearemos el grafico del numero totoal de alquiler de bicicleatas por estacion

bike.sum = bike %>% # esto agrupara los dias libres de cada estacion y sumara el numero de biciletas alquiladas para ese dia en esa estacion
  group_by(season,workingday) %>%
  summarize(rental = sum(cnt))
bike.sum

ggplot(bike.sum, aes(x= season, y= rental, 
                     fill = workingday, label = scales::comma(rental)))+ # aqui se ha indicado que utilice como rrelleno interior la informacion de la vriable workingday osea una tercera variable de modo que la parte 
  #correspondiente a cada estacion queda rellenada por cada parte correspondiente a dias libres y dias de trabajo
  geom_bar(show.legend = T, stat = "identity")+ # con stat = identity se indica que la Y pertenece al dataset si nopor lo general se usa BIN que es un conteo tomado por el propio dataset
labs(title = "alquiler de bicilcetas por estacion y dia")+
  scale_y_continuous(labels = scales::comma)+ # con esto inroducimos la informacion numerica de cada conteno para cada dia 
  geom_text(size =3, position = position_stack(vjust = 0.5))
