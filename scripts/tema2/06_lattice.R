auto <- read.csv("../data/tema2/auto-mpg.csv", stringsAsFactors = F)
auto$cylinders = factor(auto$cylinders, levels = c(3,4,5,6,8),
                        labels = c("3C", "4C", "5C", "6C", "8C"))
install.packages("lattice")
library(lattice)

#para dibujar boxplot con lattice (antes de la barra | se indican las variables dependiente e independiente 
#ya despues de la barra | se representa los facotres en los que se quiere dividir en este caso el numero de cilindros)
# en este ejemplo solo la variable mpg se divide en cilindros
bwplot(~auto$mpg | auto$cylinders,
       main = "MPG segun cilindros",
       xlab = "Millas por galon")

#para dibujar un escatterplo
# en estse ejemplo se muestra la dependiente y la independiente en funcion de los cilindros
xyplot(mpg~weight | cylinders, data = auto,
       main = "peso vs consumo vs cilindros",
       xlab = "peso (kg)", ylab = "consumo (mpg)")

