install.packages("tidyr")
library(tidyr)

crime.data <- read.csv("../data/tema1/USArrests.csv", stringsAsFactors = F)
View(crime.data)
#la siguiente funcion nos sirve para añadir nuevas columnas a nuestro dataframe original
#en el siguiente caso cbind añade una columna llamada state con los nombres de cada fila 
#en este caso los identificadores de numeros del dataframe original
crime.data <- cbind(state = rownames(crime.data), crime.data)


# se utilizara la funcion GATher para unir informacion de variables especificas en otro dataframe
# con esto se da una nueva tabla con clave valor para las columnas desde murder hasta urbanpop
crime.data.1 <- gather(crime.data,
                       key = "crime_type", value = "arrest_estimate",
                       Murder : UrbanPop)


# tambien se puede usar el formato clave valor para todas exepcto una en particular poniendo un menos adeltante 
# con lo que se creara mas filas reduciendo las columnas y agrupando todo con mas estilo
crime.data.2 <- gather(crime.data,
                       key = "crime_type", value = "arrest_estimate",
                       -state)


crime.data.3 <- gather(crime.data,
                       key = "crime_type", value = "arrest_stimate",
                       Murder,Assault)


#PARA VOLVER DEL NUEVO FORMATO CLAVE VALOR OBTENIDO POR GATHER AL FORMTO TRADICIONAL FILAS Y COLUMNAS SE UTILIZA LA FUNCINO SPREAD

crime.data.4 <- spread(crime.data.2, 
                       key = "crime_type", value = "arrest_estimate")




#una ultima funcion llamada unit puede unificar diversas las columans en una sola la informacion
#de la nuevacolumna sera separada por un _ en este caso

crime.data.5 <- unite(crime.data,
                   col = "murder_assault", # asecinato y asalto unificado en una sola
                   Murder, Assault,
                   sep = "_") 

# lo contrario de unite para separar datos de columnas se usa la funcion separate

crime.data.6 <- separate(crime.data.5,
                         col = "murder_assault",
                         into = c("Murder", "Assault"),
                         sep = "_")
