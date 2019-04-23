#LINE CHARTS  se usan para representar dos variables continuas a traves del eje x y y osea como cambios continuos en la variable continua x aparentan tener una relacion con tra variable continua que se representa en el eje y
install.packages("ggplot2")
library(ggplot2)

mtcars <- read.csv("../data/tema7/mtcars.csv", stringsAsFactors = F)
head(mtcars)

plot <- ggplot(mtcars, aes(wt,mpg))
plot + geom_line()
plot + geom_line(linetype = "dashed", color = "green")
plot + geom_line(color = "red")
plot + geom_line(aes(color = as.factor(carb))) # representar cada linea dependiendo del tipo de carburador de la variable carb
