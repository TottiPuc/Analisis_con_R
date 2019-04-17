# FILTRO DE SERIES TEMPORALES PARA LOCALIZAR TENDENCIAS

s <- read.csv("../data/tema6/ts-example.csv")
s$sales
plot(s$sales, type = "l") # como se ve son muy puntiagudos

# como el dataset no tiene fechas vamos a asumir que se tienen datos un cada dia o datos semanales
# de modo que el periodo de muestreo es de 7 muestras cada semana

n <- 7 # valor de muestras por semana
weights <- rep(1/n, n) # son pesos que en este caso se repiten 7 veces
weights # que sera el filtro de 7 septimos el valor todal debe sumar 1

s.fil.1 <- filter(s$sales, filter = weights, sides = 2)
lines(s.fil.1, col = "blue", lwd = 3)
# lo que hace lo anterior es hacer promedio 3 valores para atras y para adelante del valor actualp
# para suavizar la serie original


#PODEMOS HACER OTRO FILTRADO NO TOMANDO LOS 3 ANTERIORES Y POSTERIORES SI NO TOMANDO 6 PERO AHORA UNILATERAL SOLO DE UN LADO

s.fil.2 <- filter(s$sales,filter = weights, sides = 1)
lines(s.fil.2, col = "red", lwd =3)
