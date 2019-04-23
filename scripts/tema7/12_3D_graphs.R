# graficos en 3D
install.packages("plot3D")
library(plot3D)

mtcars <- read.csv("../data/tema7/mtcars.csv")
head(mtcars)
# vamos a renombrar el identificador con la columna X y posteriormente eliminar cicha columna

rownames(mtcars) = mtcars$X
mtcars$X = NULL
head(mtcars)

# vamos a pintar tres variables numericas no categoricas

scatter3D(x=mtcars$disp, 
          y=mtcars$wt,
          z=mtcars$mpg,
          clab = c("millas por galon"),
          pch=17, #pch son el tipo de punto consultar informacion
          cex = 0.6, # tamaño de puntos
          theta = 18,
          phi = 25, # son los angulos para mover el cubo
          main="coches de los 70",
          xlab="desplazamiento en (cu.in)",
          ylab = "peso por libra",
          zlab = "millas por galon",
          bty = "g" # son el tipo de cubo con f es completo la b viene por defecto y g 
          )

# agregaremos textos en 3d

text3D(x=mtcars$disp,
       y=mtcars$wt,
       z=mtcars$mpg,
       labels = rownames(mtcars),
       add = T, # esta ultima linea es importante po rque se le indica al programa que adicione
       #una nueva capa al grafico arriba creado en este caso texto en 3d
       colkey=F,
       cex =0.5)



# graficar histogramas  en 3d con un dataset de regalo de R

data("VADeaths")
head(VADeaths)          

hist3D(z = VADeaths, scale = F, expand = 0.01,
       bty = "g", phi =30, 
       col="#1188CC", border = "black",
       shade = 0.2, ltheta = 80,
       space = 0.3,
       ticktype = "detailed")


# nuevo grafico
scatter3D(x=mtcars$disp,
          y = mtcars$wt,
          z= mtcars$mpg,
          type = "h")
