#EPOCH  que es el 1 de enero de 1970 que es el inicio de la informatica moderna el minuto 0 desde donde se empeizan a contar las fechas 

#para ver la fecha de HOY
Sys.Date()

#FORMATO
# años dos digitos
as.Date("1/1/80", format("%m/%d/%y"))

# años CUATRO digitos
as.Date("1/1/1980", format("%m/%d/%Y"))

# en caso de omitir el formato se debe pasar de la siguiente dorma
# yyyy-mm-dd o yyyy/mm/dd

as.Date("2018-01-06")
as.Date("88/05/19")

# pasar fecha a numerica
nac <- as.Date("1986/02/19")
as.numeric(nac) # me da el numero de dias que han pasado desde la fecha especificada al dia de hoy
as.numeric(as.Date(Sys.Date()))

# para dar nombre de los meses

as.Date("Jan 19, 2018", format="%b %d, %Y")
as.Date("January 19, 2018", format="%B %d, %Y")

# crear fechas desde dias de EPOCH
dt <- 2018
class(dt) <- "Date"
dt # al epoch le suma 2018 dias

dt <- -2018
class(dt) <- "Date"
dt # al epoch le resta 2018 dias 


# crear fechas desde dias de un punto dado

dt <- as.Date(2018, origin = as.Date("1986/02/19")) # a mi fecha de nacimiento le sumo 2018 dias

as.Date(-2018, origin = as.Date("1986/02/19")) # a mi fecha de nacimiento le resto 2018 dias



#COMPONENTES DE LAS FECHAS

#QUEDARSE SOLO CON EL AÑO

dt

format(dt,"%Y") # año en string de cuatro digitos
as.numeric(format(dt,"%Y")) # el año en formato numerico


# OBTENER EL MES COMO STRING
format(dt, "%b") # da el nombre del mes abreviado
format(dt, "%B") # formato del mes completo
# o tambien usamos months o weekdays o qaurters o julian para obtener informacion de la fecha


months(dt)
weekdays(dt)
quarters(dt)
julian(dt) # cuantos dias pasaron desde el EPOCH hasta la fecha 
julian(dt, origin = as.Date("1980/02/19")) # quantos dias pasaron desde el 19 de febrero de 1980 hasta mi fecha de nacimiento



#PODEMOS SUMAR O RESTAR DIAS A UNA FECHA ESPECIFICA

dt<- as.Date("1/1/2018", format = "%d/%m/%Y")
dt
dt + 100 # a la fecha anterior le sumamos 100 dias
dt - 100 # restamos dias

dt2 <- as.Date("2018/01/02")
dt2
dt2 -dt
dt-dt2
as.numeric(dt-dt2)

dt>dt2
dt2>dt

#podemos crear sequencias de fechas
seq(dt, dt+365, "month")

seq(dt, dt+50, "day")
#saltando dos meses
seq(dt, dt+365, "2 month")

#con esto genero una secuencia desde dt que vaya cada cuatro meses y que genere 6 muestras
seq(from =dt, by = "4 months", length.out = 6)
#y podemos extraer cualquier elmento de las lista por ejemplo el tercero
seq(from =dt, by = "4 months", length.out = 6)[3]


seq(from =dt, by = "3 weeks", length.out = 6)
