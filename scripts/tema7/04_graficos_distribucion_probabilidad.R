# DISTRIBUTION PLOTS
install.packages("ggplot2")
library(ggplot2)

geiser <- read.csv("../data/tema7/geiser.csv")
head(geiser)

plot <- ggplot(geiser, aes(x=waiting)) # cuando no se especifica la variable Y hace el conteo general de la variable en este caso X
plot + geom_histogram() # por defecto hace 30 divisiones para controlar esto se hace
plot + geom_histogram(binwidth = 5, fill = "white", colour = "black")
# para representar las pdfs se necesita que la Y no sean frecuencias absolutas si no relativas
ggplot(geiser, aes(x=waiting, y=..density..)) +# con esto se garantia que lo que sea que se represente en x sume 1o lo que es igual representar sus pdf
geom_histogram(fill="cornsilk", color ="grey60", size=.2)+
  geom_density() + xlim(35,105)


# para la otra variable del dataset que era eruption
ggplot(geiser, aes(x=eruptions, y=..density..)) +# con esto se garantia que lo que sea que se represente en x sume 1o lo que es igual representar sus pdf
  geom_histogram(fill="cornsilk", color ="grey60", size=.2)+
  geom_density() + xlim(0,7) 
