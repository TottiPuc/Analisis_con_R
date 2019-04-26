# se usa para grandes volumenes de datos en especial usa las bases de datos sql y sus comandos
#SELECT -> para elejir variables o columnas en dplyr -> select()
#WHERE -> se usa para filtrar subconjuntos de filas (dame todos los usarias where de españ) en dplyr -> filter()
#GROUP BY -> sirve para agrupar por un determinado criterio por ejemplo ( agrupa por los usuarios ade colombia y dime cuantos hay) en dplur -> group_by()
#ORDER_BY -> sirve para ordenar los datos por ejemplo alfabeticamente o del mas pe queño al mas grande en dplyr -> arrange()
#JOIN -> sirve para combinar tablas por ejemplo una tabla de usuarios y una de pagos se las puede unir en unsa sola en dplyr -> join()
#COLUMN ALIAS -> se usa para crear nuevas variables en plyr -> mutate()
install.packages("dplyr")
library(dplyr)


auto <- read.csv("../data/tema10/auto-mpg.csv", stringsAsFactors = F)
auto$cylinders <- factor(auto$cylinders,
                         levels = c(3,4,5,6,8),
                         labels = c("3C", "4C", "5C", "6C", "8C"))


# para seleccionr un conjunto de columnas dadas 
subset.autos <- select(auto, mpg, horsepower, acceleration )
head(subset.autos) # solo obtengo esas columnas 

# ahora vamos a usar filter para encontrar un conjunto concreto de datos por ejemplo los autos 
# de los años 80 en adelante

auto.80 <- filter(auto, model_year>80)
head(auto.80)

# ahora para crear una nueva variable en el dataset por ejemplo el mpg normalizado usamos mutate()

auto.norm <- mutate(auto, mpg.nor =round((mpg-mean(mpg))/sd(mpg),2) )
head(auto.norm)


# usamos summarise y group_by para hacer un usar una funcion en cada conjunto

summarise(group_by(auto, cylinders), mean(mpg))
 
summarise(group_by(auto, model_year), mean(mpg))


#uso del PIPE %>% lo mismo que | en bash y se lee como acontinuacion haz tal cosa

auto %>%  # dame el dataset
  filter(model_year<78) %>%  # acontinuacion filtrame por años menores al 78
  group_by(cylinders) %>%   # acontinuacion agrupalos por cilindros
  summarise(mean(mpg)) # finalmente haz un resumen aplicando la media a la variable mpg
