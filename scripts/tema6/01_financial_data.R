#haremos un analisis financiero en https://finance.yahoo.com/lookup elegimos la empresa appl, y descargamos los datos que queramos
install.packages("ggplot2")
library(ggplot2)


AMZN <- read.csv("../data/tema6/AMZN2.csv", stringsAsFactors = F)
APPL <- read.csv("../data/tema6/AAPL2.csv", stringsAsFactors = F)
FB <- read.csv("../data/tema6/FB2.csv", stringsAsFactors = F)
GOOG <- read.csv("../data/tema6/GOOG2.csv", stringsAsFactors = F)

head(AMZN) # como se puede ver tiene una fecha que es la final del 2007 queremos inicar desde el 2008 asi que quitaremos 
# las fechas inferiores a 2008

AMZN = AMZN[AMZN$Date>='2008-01-01',]
head(AMZN)

# se hace lo mismo para todas 

APPL = APPL[APPL$Date>='2008-01-01',]
head(AMZN)

GOOG = GOOG[GOOG$Date>='2008-01-01',]
head(GOOG)

# veremos la estructura de cada dataframe

str(APPL)

# como podemos ver la columna date al convertir el dataframe de stringAsFactor = F no la ha tomado como char, lo que se debe hacer
# es siempre las fechas transformarlas a su equivalente date

APPL$Date = as.Date(APPL$Date)
str(APPL) # y ahora si vemos que tenemos la variable date con formato date

# hacemos lo mismo para todas

AMZN$Date = as.Date(AMZN$Date)
FB$Date = as.Date(FB$Date)
GOOG$Date = as.Date(GOOG$Date)

#podemos graficar todas las tendencias de todas las variables en un solo ggplot separando con +
ggplot(APPL, aes(Date, Close)) + # vamos a plotear dos de las variables mas significativas o las que queramos con el parametro AES en este caso la fecha y el precio de cierre
  geom_line(aes(color="Apple"))+
  geom_line(data =AMZN, aes(color="Amazone"))+
  geom_line(data =FB, aes(color="Facebook"))+
  geom_line(data =GOOG, aes(color = "Google"))+
  labs(color="legend")+
  scale_color_manual("", breaks =c("Apple","Amazone", "Facebook", "Google"), 
                     values = c("gray","yellow", "blue","red"))+ # con esto pongo colores manuales a cada compañia
  ggtitle("Comparaciones de cierres de stooks entre las diferentes empresas")+
  theme(plot.title = element_text(lineheight = 0.7, face = "bold"))






