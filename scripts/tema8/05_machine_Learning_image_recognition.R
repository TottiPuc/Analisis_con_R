#Machine Learning

#instalar el paquete mxnet desde un repositorio de github externo

repos <- getOption("repos")
repos # esto muestra los repositorios patrones donde R busca los paquetes 

repos["mxnet"] <- "https://apache-mxnet.s3-accelerate.dualstack.amazonaws.com/R/CRAN/" # con esto hemos creado un nuevo repositorio
repos                                               # con la etiqueta mxnet de donde r puede consultar paquetes pa instalar
options(repos = repos) # sobreescribirla variable para que ahora sea legal
install.packages("mxnet")
install.packages("jpeg")
install.packages("png")

library(devtools) # para acceder a un repositorio github donde se encuentra la red entrenada
devtools::install_github("rich-iannone/DiagrammeR")

source("http://bioconductor.org/biocLite.R")
biocLite()
biocLite("EBImage")# todo lo anterior son descargas de paquetes y librerias para trabajar con NN 


library(mxnet)
library(png)
library(jpeg)
library(EBImage)

#vamos a descargar la red neuronal entrenada esde un repositorio
if(!file.exists("../data/tema8/synset.txt")){
  download.file("http://data.dmlc.ml/mxnet/models/imagenet/inception-bn.tar.gz", #este es el fichero
                destfile = "../data/tema8/inception-bn.tar.gz") # este sera el destino en mi compu
  #ahora descomprimimos el tar.gz descargado anteriormente
  untar("../data/tema8/inception-bn.tar.gz",
        exdir = "../data/tema8/")  # con esto se descomprime el fichero
  file.remove("../data/tema8/inception-bn.tar.gz") # elimina el archivo tar.gz
  } else {
  cat("archivo ya existe")
  }

# cargamos el modelo ya entrenado
model <- mx.model.load("../data/tema8/Inception-BN", iteration = 126)
head(model)

# para leer archivos txt se usa readLines

synset <- readLines("../data/tema8/synset.txt") # este es el fichero de categorias de la red neuronal las imagenes etiquetadas
head(synset)


# vamos a cargar las imagenes de prueba a ver si las encuentra la red

elephant <- readImage("../data/tema8/elephant.jpg")
kangaroo <- readImage("../data/tema8/kangaroo.jpg")
leopard <- readImage("../data/tema8/leopard.jpg")
policy <- readImage("../data/tema8/policy.jpg")

# ahora haremos preprocesamiento de las imagenes ya que el modelo ue entrenado con imagenes de 224 x224
# las imagenes jpeg tiene 3 canales RGB pero las png tiene cuatro los RGB y la transparencia
preproc.imag <- function(image, isPng = F){
  n_chanels = 3
  if(isPng){
    n_chanels = 4
  }
  resized <- resize(image, 224, 224)
  arr <- as.array(resized) * 255 # ponemos la matriz como un array para poder trabajar con los diferentes colores RGB
                              # y lo estandariza entre 0 y 255
  dim(arr) <- c(224,224,n_chanels) # le decimos al array creado que su tamaño sera de 224x224 y que tendra 3 canales asi se tendra una fila R la siguiente G y la siguiente B y asi por todo el array
  m <- mean(arr)
  print(paste("el valor medio de la imagen es: ", m, sep = " "))
  norm <- arr - m # normalizamos la imagen
  dim(norm) = c(224,224, n_chanels,1) # el numero 1 es para calculos internos del modelo
  #norm <- norm[,,1:3,1] # en caso de tener 4 canales solo nos quedamos con los tres primeros 
  return(norm)
}



# ahora vamos a normalizar las imagens de prueba usando la funcion arriba creada

elephant.n <- preproc.imag(elephant, isPng = F)
kangaroo.n <- preproc.imag(kangaroo)
leopard.n <- preproc.imag(leopard)
# despues de tener la imagen vamos a predecir la imagen a ver como la clasifica

classify.imag <- function(image, isPNG=F){
   image.n <- preproc.imag(image , isPNG)
   prob <- predict(model, X= image.n)
   # de todas las categorias nos quedamos con el top 5 mas probables
   sorted.p <- order(prob[,1], decreasing = T) # ordene las probabilidades
   max.idx <- sorted.p[1:5]
   result <- data.frame(cat= synset[max.idx],
                     prob = 100*prob[sorted.p[1:5]])
   display(image)
   result # aqui se puede ver el porcentaje de probabilidad con el que acierta
}

classify.imag(leopard)
classify.imag(elephant)
classify.imag(kangaroo)
classify.imag(policy)
