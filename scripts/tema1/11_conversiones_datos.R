students <- read.csv("../data/tema1/data-conversion.csv")
# se creara una variable categorica apartir de una numerica esto es del dataframe anterior 
# de la columna incoming los valores que esten por debajo de 10000 seran ingresos bajos los 
# que esten entre 10000 y 30000 como ingresos medios y los de encima de 30000 como ingresos altos

bp <- c(-Inf,10000,31000, Inf) # esto es un breakpoitn donde el valor mas bajo sera representado por 
#-Inf y el mas alto por Inf, con esto estaria creada la tabla entre -Infe 10000 entre 10000 y 31000
# y entre 31000 y Inf
names <- c("low","average", "high") # nombrar los rangos
# ahora creare mi nueva columna


# con la funcion cut realizamos los cortes y las asignaciones de la columna Income original utiliza los rangos
# creados en la variable bp para inserir el trozo al que la variable se catagorizar 
students$Income.categorica <- cut(students$Income, breaks = bp, labels = names)


# en caso de no pasarle los label el los nombra por defecto 
students$Income.categorica_sin_name <- cut(students$Income, breaks = bp)

# y si no se especifica los cortes se deja a R que lo haga de forma automatica, haciendolos 
# con un ancho entre bins casi que igual 

students$Income.categorica_sin_name_sin_rango <- cut(students$Income, breaks = 4,
                                                     labels = c("level 1", "level 2", "level 3", "level 4"))





# por otro lador se tiene la conversion de categoricas a numericas que se puede hacer con la libreria dummies

install.packages("dummies")
library(dummies)

students.dummy <- dummy.data.frame(students, sep="." ) # si se pone el parametro all = FALSE no se incluiran las variables numericas originales solo las simbolicas 

#para ver los nuevos nombres de las categoricas a numericas 
names(students.dummy)


# se puede hacer la conversion solo de una variables con
dummy(students$State)


# o tambien especificandolos como parametros 
dummy.data.frame(students, names = c("State","Gender"), sep =".")
# por ejemplo si omito State solo me convertira el genero y el estado se mantendra como categorico
dummy.data.frame(students, names = c("Gender"), sep =".")
