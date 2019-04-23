#Scatter plots solo se respesentan los puntos

install.packages("ggplot2")
library(ggplot2)

auto <- read.csv("../data/tema7/auto-mpg.csv", stringsAsFactors = F)
auto$cylinders <- factor(auto$cylinders, 
                         labels = c("3c", "4c", "5c", "6c", "8c"))


plot <- ggplot(auto, aes(weight, mpg)) # punto de partida del grafico donde weight y mpg son dos de las variables del dataset
#al grafico anterior podemos añadirle capas
plot + geom_point() # donde se le dice que la geometria son puntos  
plot + geom_point(alpha =1/2, size = 5,
                  aes(color = factor(cylinders))) + # con esto se dice que daca coche es difernte para cada coche de la variable cylinder del dataser
geom_smooth(method = "lm", se = T, col= "green") + # añadimos una linea de regresion lineal encma  donde "se" es el intervalo de confianza encima de la recta
facet_grid(cylinders~.)+ #repreenamos cada cilindro en un grafico diferente con su propia linea de regresion
theme_bw(base_family = "Arial", base_size = 10)+
  labs(x="Peso") + labs(y = "Millas por galon")+
  labs(title = "Cosnumo vs peso")



#LA VERSION SINPLIFICADA DE GGPLOT ES QPLOT

qplot(x=weight, y = mpg, data = auto,
      geom = c("point","smooth"), method ="lm",
      formula = y~x, color = cylinders,
      main = "regresion de MPG sobre el Peso")
