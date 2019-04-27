#MySQL y bases de datos relacionales
install.packages("RODBC")
install.packages("RJDBC")
install.packages("ROracle")
install.packages("RMySQL")

library(RODBC)
odbcDataSources()

con <- odbcConnect("MySQL",
                   uid = "christian",
                   pwd = "")

#hacer una consulta a MySQL de toda la tabla
custData <- sqlQuery(con, "select * from recomendationsystem.Rating limit 5;")
custData
#hacer una consulta a MySQL de toda la tabla peor una sola variable
custData <- sqlQuery(con, "select rating from recomendationsystem.Rating limit 5;")
custData

# añadir valores a la base de datos 

customers <- c("christian Arcos", "pol luna", "andres Patricio")
ordardate <- as.Date(c('2018-01-25','2017-12-31','2017-12-1'))
orderamount <- c(350, 44.65, 105.32)


#creamos el dataframes
orders <- data.frame(customers, orderamount)

# vamos a guardarlo a sql

sqlSave(con, orders, "recomendationsystem.Orders", append = F)
#para hacer una consulta
df <- sqlQuery(con, "select * from recomendationsystem.Orders")
df



#OTRA LIBRERIA
library(RMySQL)

#creamos la coneccion
con <- dbConnect(MySQL(),
                 dbname = "recomendationsystem",
                 host = "127.0.0.1",
                 port = 3306,
                 username = "christian",
                 password = "")

# leer una tabla competa
ac <- dbReadTable(con, "Acomodation")
ac

# consultas especificas que coincidan con las palabra chaler

df <- dbGetQuery(con, "select * from Acomodation where title like '%chalet%'")
df

# vamos a escribir una tabla

dbWriteTable(con, "Orders", orders, row.names = F)
dbReadTable(con, "Orders")

#hacer una consulta especifica 
#rs<- dbSendQuery(con, "select location, max(price) from Acomodation group by location order by max(price) desc ")
rs<- dbSendQuery(con, paste("SELECT a.location, max(a.price)",
                            "FROM Acomodation a",
                            "GROUP BY a.location",
                            "ORDER BY max(a.price) DESC"))

rs # devuelve un objeto para hacer la consulta de lo que tiene ese objeto

while(!dbHasCompleted(rs)){ # mientras no se haya terminado la consulta
  print(fetch(rs, n=2)) # el 2 es para ir pidiendo de 2 en 2 no la tabla completa
  }

# es importante siempre despues de una consulta limpiar el objeto para liberar memoria

dbClearResult(rs)
# y desconectar la coneccion
dbDisconnect(con)
# para mostra el numero de conecciones 
dbListConnections(dbDriver("MySQL"))
