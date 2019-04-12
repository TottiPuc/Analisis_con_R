install.packages("caret")
install.packages("MASS")
library(caret)
library(MASS)

auto <- read.csv("../data/tema4/auto-mpg.csv")

auto$cylinders <- factor(auto$cylinders, levels = c(3,4,5,6,8), labels = c("3c", "4c", "5c", "6c", "8c"))

set.seed(2018)
t.id <- createDataPartition(auto$mpg, p=0.7, list = F )
names(auto)
#como hay variables que no me aportan en mi prediccion entonces se pueden eliminar en esta caso del dataset auto las columnas 1 ,8 y 9

# creamo el modelo de la regresion lineal

mod <- lm(mpg ~ ., data = auto[t.id,-c(1,8,9)])
mod
summary(mod)

# con esto se tiene la regresion lineas de la forma y = ax +b donde cada paramtero de la regresion seria representado de la siguiente dorma

# mpg = 38.6073120 + 7.2126522*4c + 5.6103498 *5c + 3.3071717 *6c + 6.2113432*8c + ...
#        ... + 0.0068775 * displacement -0.0722087 *  horsepower -0.0051560 * weight + 0.0248515 * acceleration
# entonces cada nuevo valor que llege a la ecuacion anterior predecira el nuevo valor requerido

# se puede dibujar la distribucion que toman los errores o residuos
boxplot(mod$residuals)

#calculo de el error que es similar al dado en el summary
sqrt(mean((mod$fitted.values - auto[t.id,]$mpg)^2))

# finalmente para ver que tan bueno es el modelo procedemos a hacer la predeiccion de los datos faltantes osea los de test

pred <- predict(mod, auto[-t.id, -c(1,8,9)])
sqrt(mean((pred - auto[-t.id,]$mpg)^2))


#finalmente graficaremos los resultados de la regresion
par(mfrow=c(2,2))
plot(mod)

df <- data.frame(actual = auto[-t.id,]$mpg , predicho = pred)




#con el fin de reducir posibles operaciones numericas siempre se toma como referencia de analisis la categoria con mas apariciones 
# en el caso anterior se tomo como referencia la estandar que es la primera de las categorias en ese caso los coches de 3cilindros
#pero esto se puede alterar de la siguiente forma ene ste caso tomando la referencia como 4cilindros

auto <- within(auto, cylinders <- relevel(cylinders, ref = "4c"))
mod <- lm(mpg ~., data = auto[t.id, -c(1,8,9)])
mod
#como se puede ver cambia a diferencia del modelo anterior

pred <- predict(mod, auto[-t.id, -c(1,8,9)])
sqrt(mean((pred - auto[-t.id,]$mpg)^2))
plot(mod)
df2 <- data.frame(actual= auto[-t.id,]$mpg, predicho = pred)

# vamos a ver que variables son importantes o no en el modelo y con cuales nos quedamos
# la funcion stepAIC va agregando variables imoprtantes con el comando farward si el modelo esta vacio
# o va eliminando con el comando backward si el modelo ya esta construido como en nuestro caso ya esta construido vamos a ir eliminando informacion no util
step.model <- stepAIC(mod, direction = "backward")
summary(step.model)
# asi podremos ver como era nuestro modleo original y como quedaria si eliminamos algunas variables
step.model$anova





