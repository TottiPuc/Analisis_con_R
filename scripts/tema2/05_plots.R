auto <- read.csv("../data/tema2/auto-mpg.csv")
#para sobre escribir una columna y convertila de numerica a categorica (factor)
auto$cylinders <- factor(auto$cylinders, levels = c(3,4,5,6,8),
                         labels = c("3cil", "4cil", "5cil", "6cil", "8cil"))

# con attach se hace que el dataset se convierta en parte del codigo y ya no sera necesario estar 
#refiriendose a una variable del dataset con $ como en la linea de arriba

attach(auto)

# por ejemplo

head(cylinders)

#primer grafico histograma de frecuencias para variables numericas

hist(acceleration, 
     col = "blue",  #o puedo utilizar la funcion rainbow(numero de bins) para colorear el histograma
     xlab = "aceleracion",
     ylab =  "frecuencias",
     main ="histograma de las aceleraciones",
     breaks = 16)

# para trabajar no con frecuencias absolutas si no con frequencias relativas y poder trabajar con fdps donde la suma dara uno
hist(mpg, prob =T)
density(mpg) # densidad de probabilidad por consola 
# con la variables lines sobrepongo graficso igual a hold en matlab
lines(density(mpg))

# segundo graficos Boxplots
boxplot(mpg, 
        xlab = "millas por galon")
# para representarlo para un grupo de datos de la misma variable por ejemplo por año donde mode_year representa la columna de los años
boxplot(mpg ~ model_year, xlab="millas por galon (por año)" )
# en este ejemplo se vera si el numero de milla que corre un carro depende de la cilindrada del carro variable que anteriormente convertimos a categorica
# para eso se utiliza ~ que es en funcion de 
boxplot(mpg ~ cylinders, xlab = "consumo por numero de cilindros")
#boxplot del dataframe original este no puede representar las variables que son strings
boxplot(auto)

#  tercer grafico scatterplot solo para variables numericas donde la primera se coloca en el eje de las x y la segunda en el eje de las y
# se utiliza de nuevo ~ para decir que una esta en funcion de la otra, en este ejemplo mpg sera la variable dependiente osea el eje y 
plot(mpg ~ horsepower)

#para tener una mejor visualizacion de la tendencia se usaria un modelo de regresion lineal sobre el scatterplot con la funcion lm
linearmodel<- lm (mpg ~ horsepower) # y despues hacer un modelo de la represntacion lineal con una linea de regresion con la funcion abline
abline(linearmodel)


# agregar colores para una variable por ejemplo la cilindrada para saber que coche pertenece a una categoria de cilindro
plot(mpg ~ horsepower, type = "n")
with(subset(auto, cylinders == "8cil"),
     points(horsepower,mpg, col = "red")) # la funcion subset es para dividir el conjunto de entrada 
with(subset(auto, cylinders == "6cil"),
     points(horsepower,mpg, col = "blue"))
with(subset(auto, cylinders == "5cil"),
     points(horsepower,mpg, col = "yellow"))
with(subset(auto, cylinders == "4cil"),
     points(horsepower, mpg, col = "green"))


# lo mas util es hacer una matriz de scatterplots donde se cruzan 2 a 2 diferentes variables consideradas corelacionadas
# se pone la tilde al inicio para decir que se las quiere todas con todas 
pairs(~mpg+displacement+horsepower+weight)

# Combinacion de plots con par donde par significa la configuracion de parametros de los graficos
old.par <- par() # almacenaremos la configuracion de los parametros viejos 
old.par
# modificaremos los parametros por ejemplo mfrow para 1 fila y 2 columnas
par(mfrow = c(1,2))
with(auto, {
  plot(mpg ~ weight, main = "peso vs consumo")
  plot(mpg ~ acceleration, main = " aceleracion vs consumo")
})

# despues de pintar o haber modificado los parametros se los tiene que restaurar a sus valores originales
par(old.par)


