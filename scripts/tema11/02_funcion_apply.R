# applay es para aplicar una funcion a toda una lista o matriz

m<- matrix(seq(1,16),4,4) # creo una matrix de 4 x 4 con numeros del 1 al 16
m

#aplicamos el minimo de cada fila usando la funcion applay

apply(m, 1, min) # donde uno son filas y 2 son columnas 
apply(m ,2, min)

apply( m, 1, prod) # multiplica por filas
apply( m, 2, sum) # por columnas

# para aplicar a cada elemento de la matriz su cuadrado
apply(m, c(1,2), function(x){x^2})

# aplicar quantiles que necesitan de un parametro mas 
apply(m, 1, quantile, probs = c(0.4, 0.6, 0.8)) # por filas

colSums(m) # suma por columnas lo mismo que con apply
rowSums(m) # suma por filas

colMeans(m)
rowMeans(m)


# si tenemos matrices de mas de dos dimensiones 
array3D <- array(seq(1,32), dim = c(4,4,2)) # seran dos matrices cada una con 16 elementos
array3D

apply(array3D, 3, sum) # suma todos los elementos de cada matriz
apply(array3D, 3, mean)
# sumar elemento a elemento de la primera matiz con el primero de la segunda 
apply(array3D, c(1,2), sum) # c(1,2) ya no seria filas y columnas si no matriz 1 y matriz 2
