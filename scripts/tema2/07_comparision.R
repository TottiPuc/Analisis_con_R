data <- read.csv("../data/tema2/daily-bike-rentals.csv")

#se cambiara la estacion del años con sus numbres, el dia festivo se puede cambiar para categorico.
data$season <- factor(data$season, levels = c(1,2,3,4), labels = c("invierno", "primavera", "verano", "otoño"))

data$workingday <- factor(data$workingday, levels = c(0,1),
                          labels = c("Festivo", "De trabajo"))

data$weathersit <- factor(data$weathersit, levels = c(1,2,3),
                          labels = c("Despejado", "nublado", "lloviendo"))


# la fecha otiginalmente se carga como un factor pero se la puede poner en su formato original de fecha
data$dteday <- as.Date(data$dteday, format= "%Y-%m-%d")

attach(data)

# a continuación se hace un trabajo para facilitar la comparación de alquier de bicicletas por estacion del año
#para ver si es el mismo en verano invierno 
#como son 4 estaciones se dividira la grafica en 4 con par
par(mfrow=c(2,2))

# en lugar de trabajar con el dataframe original es mejor trabajar con 4 subdataframes cada uno de los cuales para una estacion en concreto
winter <- subset(data, season == "invierno")$cnt
spring <- subset(data, season == "primavera")$cnt
summer <- subset(data, season == "verano")$cnt
fall   <- subset(data, season == "otoño")$cnt

# ahora obtendremos sus respectivos histogramas de frecuencias relativas para cada estacion
hist(winter, prob = T , xlab = "alquiler diaroi en invierno", main = "")
lines(density(winter)) # funcion de densidad de probabilidad encima del histograma
abline(v = mean(winter), col = "red") # dibujar la media de los datos en el histograma en rojo v significa vertical y mean media
abline(v = median(winter), col = "blue") # dibujar la mediana de los datos en el histograma en azul v significa vertical y median mediana


hist(spring, prob = T, xlab = "alquiler diario en primavera", main = "")
lines(density(spring))
abline(v = mean(spring), col = "red")
abline(v = median(spring), col = "blue")

hist(summer, prob = T, xlab = " alquiler diarion en verano", main = "")
lines(density(summer))
abline(v = mean(summer), col = "red")
abline(v = median(summer), col = "blue")


hist(fall, prob = T, xlab = " alquiler diario en otoño", main = "")
lines(density(fall))
abline(v = mean(fall), col = "red")
abline(v = median(fall), col = "blue")


#GRAFICO DE LAS JUDIAS
install.packages("beanplot")
library(beanplot)

par(mfrow =c(1,1))
beanplot(cnt ~ season, col = c("blue", "red", "yellow")) # se esta representando el conteo cnt en funcion de las estaciones del año


#ANALISIS DE CAUSALIDAD para ver lo que el diagrama de judias muestra que en dias lluviosos se tiene poco alquiler
#para eso se utlizara la columna whatersit para corroborar con el conteno cnt
library(lattice)
bwplot( cnt ~ weathersit, data = data,
        layout = c(1,1), xlab = "pronostico del tiempo",
        ylab = "Frecuencias",
        panel = function(x,y,...){
          panel.bwplot(x,y,...)
          panel.stripplot(x,y,jitter.data = T,...)
        }, # esta funcion en particular puede o no puede ser incluida nos aportara informacion sobre como estan o el numero de datos en cada dia y con la funcion stripplot se dibujaran encima de nuestro anterior diagrama
        par.settings = list(box.rectangle = list(fill = c("red", "yellow", "green"))))
# con lo anterior se corrobora que efectivamente los dias lluviosos el alquiler se disminuye pero se ve con los punticos que los dias que lleuven son pocos entonces el negocio en esa zona puede ser muy productivo
