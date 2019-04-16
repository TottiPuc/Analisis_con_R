# primero cargamos las librerias necesarias para trabajar con imagenes
install.packages(c("OpenImageR", "ClusterR"))
library(OpenImageR)
library(ClusterR)

# cargar la imagen con
img <- readImage("../data/tema5/bird.jpg")

#vamos a rescalar la imagen para hacerla un poco mas pequeña que se pueda trabajar
img.resize<- resizeImage(img, 350, 350, method = "bilinear")
imageShow(img.resize) # mostramos la imagen

# como es una imagen de pixeles ahora se vectorizara la imagen a RGB y chequear su dimension

img.vector <- apply(img.resize, 3, as.vector) # entonces la imagen rescalada se obtienen
# 3 filas y columnas  como vectores, asi en lugar de tener todo como array vamos atener ahora una matriz grande
#con vectores de 3 en 3 donde la primera sera color rojo la segunda verde y la tercera azul RGB 
dim(img.vector) # con esto vemos el tamaño de la matriz  con 122500 filas y 3 columnas 
# siendo qeu cada columna ahora acontiene una cantidad de rojo verde o azul en el mismo

# ahora utilizamos minibatch kmean para llevar el cluster de la imagen vectorial y predecir el centroide de cada 
#trozo en los que dividamos la imagen, despues se hara la prediccion y se vera a que segmento de la imagen corersponde

kmmb <- MiniBatchKmeans(img.vector, clusters = 5, # escojemos 5 por que son los 5 colores mas vistosos
                        batch_size = 20, num_init = 5,
                        max_iters = 100, init_fraction = 0.2,
                        initializer = "kmeans++",
                        early_stop_iter = 10, verbose=F)

kmmb

prmb <- predict_MBatchKMeans(img.vector, kmmb$centroids) # esta es la prediccion de cada pixel

get.cent.mb <- kmmb$centroids
get.cent.mb # son los centroides de cada cluster

new.img <- get.cent.mb[prmb,]
dim(new.img) <- c(nrow(img.resize), ncol(img.resize), 3)
imageShow(new.img)
