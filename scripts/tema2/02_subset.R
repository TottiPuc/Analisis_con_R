data <- read.csv("../data/tema2/auto-mpg.csv",  stringsAsFactors = F)

#index by position
data[1:5,8:9] # con esto se extrae un subconjutno

# tambien se puede extraer por nombres del header

data[1:5,c("model_year","car_name")]

# buscar el coche que mas cosume mpg y el que menos consume
# esto es deme de todas las filas el maximo o el minimo todas las columnas
data[data$mpg == max(data$mpg) | data$mpg == min(data$mpg),]


#filtros con condiciones
# por ejemplo buscarel coche que consuma poco

data[data$mpg>30 & data$cylinders == 6, c("car_name","mpg")]


#subset se usa para hacer ls mismas operaciones anteriores 

subset(data, mpg>30 & cylinders ==6, select=c("car_name","mpg"))


# excluir columnas solo se pone el signo menos delante de la columna a excluir
# esto solo funciona por index no por nombre de columnas
data[1:5,c(-1,-9)]
data[1:5,-c(1,9)] # es igual a lo anterior

#para hacerlo por nombres de columna se hace lo siguiente
data[1:5,!names(data) %in% c("No","car_name")]
data[1:5, -c("No","car_name")] # esto da error 


# o algo muy util pedir algo que este dentro de un rango
data[data$mpg %in% c(15,20), c("car_name","mpg")]
#loque me retornara los coches que consuman mpg entre 15 y 20 de las columnas car:name y mpg

# con estos e puede decir que filas o columasn se pide que se muestren 
#si no se pone el numero exactos de T y F R empezara a usar reutilizar despues del primer T
data[c(F,F,F,F,T), c(F,F,T)]
