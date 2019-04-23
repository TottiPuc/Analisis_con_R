#correlation Matix solo funciona para variables numericas 
# que se utilizan para investigar la independencia entre multiples variables a la vez
# el resultado de la tabla contiene los coeficientes de correlacion entre cada una de las variables
#que conforman el dataframe

install.packages(c("ggplot2", "corrplot", "reshape2"))
library(ggplot2)
library(corrplot)
library(reshape2)

mtcars <- read.csv("../data/tema7/mtcars.csv")
# como solo es para variables numericas eliminaremos las string en este caso el nombre de loscoches
mtcars$X = NULL # con esto elimino la columna de nombres
# utilizaremos el metodo de correlacion de Pearson
mtcars.corr <- cor(mtcars, method = "pearson")
round(mtcars.corr, digits = 2)
corrplot(mtcars.corr)

corrplot(mtcars.corr, method = "shade", shade.col = NA, tl.col = "black",
         tl.srt = 45)
#jugar con colres

col <- colorRampPalette(c("#BB4444","#EE9988","#FFFFFF",
                          "#77AADD","#4477AA"))
corrplot(mtcars.corr,method = "shade", 
         #shade.col=NA, 
         tl.col = "black",
         tl.srt = 45, col = col(200), addCoef.col = "black",addcolorlable = "no",
         order = "AOE",
         #type = "upper", #dibuja solo una digonla o lower
         diag =  F, # elimina la diagonla principal 
         addshade = "all" # da la tendencia en lineas 
         )


# usando ggplot

mtcars.melted <- melt(mtcars.corr) # esto es para fundir la matriz de correlacion en 3 columnas para poder usar ggplot
head(mtcars.melted)         

ggplot(data = mtcars.melted, aes(x=Var1, y=Var2, fill=value))+ # siempre la primera no pinta si no el fondo
geom_tile()


#CON LAS SIGUIENTES TRES FUNCIONES SE PUEDE ENCONTRAR UNA MATRIZ DE CORRELACION EN UN MAPA DE CALOR

get_lower_tirangle <- function(cormat){ # funcion que devuelve la parte superiror de la matriz de correlacion
  cormat[upper.tri(cormat)] <- NA
  return(cormat)
}

get_uper_tirangle <- function(cormat){ # funcion que devuelve la parte inferiror de la matriz de correlacion
  cormat[lower.tri(cormat)] <- NA
  return(cormat)
}


reorder_cormat <- function(cormat){
  dd<- as.dist((1-cormat)/2)
               hc <- hclust(dd)
               cormat<-cormat[hc$order , hc$order]
  
}

cormat <- reorder_cormat(mtcars.corr) # reordenara dependiendo del cluster
cormat.ut <- get_uper_tirangle(cormat)
cormat.ut.melted <- melt(cormat.ut, na.rm = T) #na.rm elimina posibles NA en eldataset

ggplot(cormat.ut.melted, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low="blue", high = "red", mid = "white", midpoint = 0,
                       limit = c(-1,1), space = "Lab", name = "Pearson\nCorrelation")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust=1))+
  coord_fixed() # con esta ultima linea se centra el grafico para que no qeude alargado de ningun lado
 