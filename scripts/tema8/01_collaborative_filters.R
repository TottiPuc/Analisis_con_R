#Sistemas de recomendacion

install.packages("recommenderlab")
library(recommenderlab)

#dataset propio de R de peliculas catalogadas entre 1 y 5 por mas de 900 usuarios
# con esto crearemos un sistema de recomendacion

data("MovieLense")
# nos quedaremos con las peliculas bien valoradas por los usuarios

rating_movies <- MovieLense[rowCounts(MovieLense)>50, # en filas personas que hayan hecho mas de 50 valoraciones 
                            colCounts(MovieLense)>100, # y en columnas que tengamos  mas de 100 vizualizaciones de la pelicula
                            ]
# en la vatiable Dim de este nuevo dataset tenemos en las filas usuarios en este caso 560 y en las columnas las peliculas que seria 332

t.id <- sample(x=c(T,F), nrow(rating_movies),
               replace = T, prob = c(0.8,0.2)) # 80 porciento T y 20 pocirneot F
rating_movies@data # esto nos ofrece la matriz de valoraciones 
rating_movies@data[1,1] # esto es el primer usuarios con valoracion 5 a la primera pelicula
rating_movies@data[1,] # esto nos muestra todas las peliculas valoradas por el usuario 1
rating_movies@data[,1] # nos muestra todas las valoraciones hechas a la primera pelicula en este caso toystori


head(rownames(rating_movies)) # muestra los nombres de los usuariosa en este caso los identificadores 1, 2 ,3 no aparece el 4 por que seguramente fue un 
# usuario que no valoro con mas de 50 veces las peliculas y no lo cargamaos en el primer filtro
head(colnames(rating_movies)) # muestra los primeros nombres de las peliculas 

data_train <- rating_movies[t.id,]
data_test <- rating_movies[!t.id,]



#FILTRADO COLABORATIVO BASADO EN ITEMS (IBCF) filtro que muestra simulitudes entre items

ibcf <- Recommender(data_train,
                    method = "IBCF", # valoraciones similares por otros usuarios 
                    parameter = list(k=30))# son los k items mas similares para los items dados, # pasamos los 30 vecinos mas parecidos

ibcf.mod <- getModel(ibcf)
ibcf.mod # esto nos da una matris spased donde las filas y las columnas tiene la misma informacion osea las peliculas
# y dara un indice de similitud alto entre mas se parezcan

# ahora haremos la recomendacion de 10 peliculas 

n_rec <- 10
ibcf_pred <- predict(object = ibcf,
                     newdata = data_test,
                     n = n_rec)

ibcf_pred # ha escogido 103 usuario que le ha hecho 10 recomendaciones
# para verlas hacemos los siguientes

ibcf.rec.matrix <- sapply(ibcf_pred@items, 
                          function(x){
                            colnames(rating_movies)[x]
                            }
                          )
View(ibcf.rec.matrix[,1:3]) # con esto podemos ver que cada columna representa el usuario y las 10 peliculas que se le recomienda 



#AHORA LOS FOLTROS COLABORATIVOS BASADOS EN USUARIOS (UBCF) en este caso calcula las similitudes entres los usuarios y no entre los items


ubcf <- Recommender(data = data_train, method= "UBCF") 
ubcf.mod <- getModel(ubcf)
ubcf.mod

# ahora determinamos el top 10 de recomendaciones para el conunto de test

ubcf.pred <- predict(object = ubcf,
                     newdata = data_test,
                     n =n_rec)
ubcf.pred # que nos da un top 10 de recomendaciones para un total de 103 usuarios

ubcf.rec.matrix <- sapply(ubcf.pred@items, function(x){
  colnames(rating_movies)[x]
}
)

View(ubcf.rec.matrix[,1:3])


# Representacion de la matriz de recomendaciones

recommender_model <- recommenderRegistry$get_entries(dataType ="realRatingMatrix")
names(recommender_model)
# las ratingMatriz o matriz de valoraciones se pueden visualizar por medio de un mapa de calores 
# ya que estan catalogadas en un rango de 1 a 5

image(MovieLense, main = "mapa de calor de la matriz de valoraciones de peliculas")

min_n_movies <- quantile(rowCounts(MovieLense),0.99) # nos quedamos con el quantil del 99% de las peliculas mas vistas
min_n_users <- quantile(colCounts(MovieLense),0.99) # nos quedamos con el quantil del 99% de los mejores criticos lo que mas valoran
min_n_movies # esto es cuantas peliculas por fila tienen mas de 440 valoraciones
min_n_users # cuantos usarios han valorado mas ade 371 peliculas

image(MovieLense[rowCounts(MovieLense)>min_n_movies,
                 colCounts(MovieLense)>min_n_users 
                 ]
      )

min_r_movies <- quantile(rowCounts(rating_movies), 0.98)
min_r_users <- quantile(colCounts(rating_movies),0.98)
image(rating_movies[rowCounts(rating_movies)>min_r_movies,
                    colCounts(rating_movies)>min_r_users
                    ],
      main = "mapa de calor del top de peliculas y usuarios "
      )


# RECOMENDACIONES BASADAS EN DATOS BINARIOS
#BINARIZAR LOS DATOS DE VALORACIONES ENTRE 0 Y 1

rating_movies_viewed <- binarize(rating_movies, minRating =1)
image(rating_movies_viewed)

t.id <- sample(x=c(T,F), 
               size = nrow(rating_movies_viewed),
               replace = T,
               prob = c(0.8,0.2))

b_data_train <- rating_movies_viewed[t.id,]
b_data_test <- rating_movies_viewed[!t.id,]

#d(i,j) = (i y j)/(i o j)<<<< indice de Jaccard que funciona como distancia en variables binarias

b_model <- Recommender(data = b_data_train,
                       method= "IBCF",
                       parameter = list(method = "Jaccard"))

b_detail <- getModel(b_model)
b_detail

# paraver la recomendacion del top 10

b_pred <- predict(object = b_model,
                  newdata=b_data_test,
                  n = n_rec)

b_rec_matriz <- sapply(b_pred@items, function(x){
  colnames(rating_movies)[x]
})

View(b_rec_matriz[,1:3])
