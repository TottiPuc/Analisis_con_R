data <- read.csv("../data/tema1/missing-data.csv", na.strings = "")

#esta forma solo sirve para variables numericas
data$Income.mean <- ifelse(is.na(data$Income)
                           ,mean(data$Income, na.rm = T),
                           data$Income)  # esta linea realiza un if preguntando en la primera parte
                            #si existe na en la columna Income, si existen los remplaza por la media 
                            # de la problacion de esa columna, si no existen colca el mismo dato original
                            # y todo esto creando una 4 columna en el data frame original con data$Income.mean

# esta nueva funcion sirve para variables categoricas y numericas

#x es un vector de datos que puede contener NA
random.input <- function(x){
  #missing contiene un vector de T/F dependiendo del NA de x solo True or False
  missing <- is.na(x)
  #n.missing devuelve el numero de T (osea cuantos NA) que encontro en el vector missing
  n.nissibg <- sum(missing)
  #x.obs <- devuelve los valores conocidos que tienen datos diferentes de NA en x
  x.obs <- x[!missing]
  #por defecto devolvera lo mismo que habia entrado por parametro x en la funcion
  inputed <- x
  # en los valores que faltaban o que eran NA del vector inputed
  #que es el mismo de entrada, los remplazamos por una muestra aleatoria 
  #de los que si conocemos(MAS)
  inputed[missing] <- sample(x.obs,n.nissibg, replace =TRUE)
  return(inputed)
}


random.impute.data.frame <- function(dataframe,cols){
  names <-names(dataframe) # recupero los nombre que me llegan del dataframe que entra como parametro
for (col in cols) {
  name <- paste(names[col],"imputed", sep = ".") # esto hace que la cabecera de cada columna tenga una replica con un nombre .imputed adicionado
  dataframe[name] = random.input(dataframe[,col])
}
  dataframe  # esto devolvera el propio objeto dataframe
}

data <- read.csv("../data/tema1/missing-data.csv", na.strings = "")
data$Income[data$Income ==0] <- NA   # los valores de las variables numericas INCOME que son ceros se les asigna un valor de NA
data <- random.impute.data.frame(data,c(1,2))  # esto es que ingrees a la funcion y que de el dataframe
#data solo tome las columnas 1 y 2 y se reescribira en la variable data
