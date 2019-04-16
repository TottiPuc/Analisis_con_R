# LOS SIGUIENTES SON CLUSTERS DE METODOS ALGOMERATIVOS

protein <- read.csv("../data/tema5/protein.csv")

# vamos a reescalar todas las variables para que esten entre 0 y 1 ecepto la de country que es categorica
data <- as.data.frame(scale(protein[,-1]))
#como elimine el pais ahora para normalizar ahora lo volvemos a poner
data$county = protein$Country
#para facilitar la lectura del dendograma en lugar de dejar los nombres de las filas como numeros le pondremos el nombre de cada pais
rownames(data) = data$county

# seempezara haciendo un closter aglomerativo para juntar los paises que se parecen en terminos del consumo de proteinas
#la funcion dist se encarga de medir distancias entre objetos
hc <- hclust(dist(data, method = "euclidean"), method = "ward.D2")
hc
# el siguiente sera su dendograma
plot(hc, hang = -0.01, cex = 0.7)


#cutre con esta funcion podremos ver el numero de datos que tiene cada culster
fit <- cutree(hc, k=4) # donde k es el numero de categorias que queremos categorizar el arbol en funcion de las similitudes 
 #ahora con un table podriamos mostrar cuantos elemntos tiene cada cluster
table(fit)

rect.hclust(hc, k=4, border = "red") # con esta funcion marcariamos en el dendograma cada categoria del cluster


#otro tipo de cluster sera en  lugar de ward.D2 sera el metodo simple(single)

hc2 <- hclust(dist(data,method = "euclidean"), method = "single")
plot(hc2, hang = -0.01, cex = 0.7)


#los cluster funcionan de lasiguiente manera se calcula las distancia entre paises de todas sus variables 

d <- dist(data, method = "euclidean")
d

# como se ve en el resultado de las distancia lo que tenemos es que austria y albania tienen una distacia de 6.47 en relacion a las proteinas
# este numero resulata de restar cada variable de cada pais elevarlas al cuadrado sumarlas y sacar la raiz cuadrada 

alba <- data["Albania", -10] # aqui extraemos todas las columnas del pais albania se coloca "Albania por que renombramos los indicadores con los nombre si no serai 1 en ves de albania
alba
aus <- data["Austria", -10]# igual que la de arriba se extrae toda la informacion de autria menos la ultima fila que es la de los nombre
aus

sqrt(sum((alba-aus)^2)) # se resta elemento a elemento se eleva al cuadrado sesuman todos y se saca la raiz
# y vemos que el resultado es casi similar al de la matriz d

# UNA DE LAS VARIABLES MAS UTILIES PARA VER CUALES SE HAN JUNTADO ES MARGE

hc2$merge
# donde cada numero representa el numero del pais por ejemplo el 18 y el 25 en el dataset original corresponde a yuguslavia y el 18 a romania el signo - significa el ultimo nodo y el positivo el cluster anterior