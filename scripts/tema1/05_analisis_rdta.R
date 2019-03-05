clientes <- c("juan", "pedro", "carlos")
fechas <- as.Date(c("2017-11-1","2018-3-12","2017-5-7")) # con as.Data paso los string normales a formato fecha
pago <- c(23,345.3,456)
pediso<- data.frame(clientes,fechas,pago) #se convierte en data frame los datos anteriores

clientes_vip <- c("christian","totti")
save(pediso, file = "../data/tema1/pedidos.Rdata") #en el mismo archivo se pueden guardas mas de unavariables solo separandola con ,
saveRDS(pediso , file = "../data/tema1/pedidos.rds")

remove(pediso) # se utiliza para eliminar objetos o data frames y liberar ram

# para cargar achivos Rdata 

load("../data/tema1/pedidos.Rdata")

# para cargar archivos RDS a diferencia de Rdata se debe crear una variable nueva

orders <- readRDS("../data/tema1/pedidos.rds")

# se puede cargar datasets propios de R como el del analisis iris

data("iris")
data("cars")
View(iris)
View(cars)

# con esta funcion se guarda toda la secion de tabajo en un Rdata
save.image("../data/tema1/alldata.Rdata")
