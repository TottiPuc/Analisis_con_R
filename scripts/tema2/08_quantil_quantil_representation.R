# creamos una sequencia que va del 1 % al 99% con saltos de 1% que es el tercer valor
s <- seq(0.01, 0.99, 0.01)
# para investigar cuales son los diferentes percentiles de la sequencia se utiliza la funcion 
qn <- qnorm(s)
qn
# creamos un dataframe con los datos y sus percentelies como se puede ver el primer valor es el percentil numero 1 que deja el 1% de los datos por debajo y el percentil 99 es el que 
# deja por debajo de 99% los datos de la sequencia el percentil 50 queda justo en la media 0

df <- data.frame(s,qn)


# crearemos una sequencia aleatoria normal con rnomr

sample <- rnorm(200)
sample
quantile(sample, probs = s)

#Graficos qqnorm 
trees # banco de datos de arboles de R
qqnorm(trees$Height) # hace el grafico quantil quantil que aproximadamente parece una distribucion normal


#Graficos qqplot utilizada para qualquier distribucion
randu  # dataset de numero aleatorios en el intervalo 0, 1 los quales deberan estar distribuidos en una distribucion uniforme
# esto es todos tiene la misma distribucion
n <- length(randu$x)
y <- qunif(ppoints(n)) # se genera una distribucion de quantiles uniformes la variable ppoint genera n numeros de probabilidades diferentes
qqplot(y,randu$x)


# distribucion chi quadrada
chi3 <- qchisq(ppoints(30), df =3)
n30 <- qnorm(ppoints(30))
qqplot(n30,chi3) # comparando una normal con una chi quadrada lo que da una parabola sesgada a la derecha


# distribucion de cauchy
cauchy <- qcauchy(ppoints(30))
qqplot(n30,cauchy)



# para graficar las distribuciones se puede hacer lo siguiente
par(mfrow = c(1,2))
x<- seq(-3,3,0.01)
plot(x,dnorm(x)) # grafica la funcion densidad de probabilidad
plot(x, pnorm(x)) # grafica la funcion de probabilidades acumulativas

# lo mismo para las otra

plot(x, dchisq(x, df =3))
plot(x, pchisq(x, df =3))


plot(x, dcauchy(x))
plot(x, pcauchy(x))
