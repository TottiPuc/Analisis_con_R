install.packages("data.table")
library(data.table)

auto <- read.csv("../data/tema10/auto-mpg.csv", stringsAsFactors = F)
auto$cylinders <- factor(auto$cylinders,
                         levels = c(3,4,5,6,8),
                         labels = c("3C", "4C", "5C", "6C", "8C"))
# primero creamos la version data.table del data.frame de autos

auto.dt <- data.table(auto)
class(auto.dt)

# en el dataframe usamos el $ para referirnos a una variable

auto.dt$mpg # que sirve en data.table pero lo mas eficiente es hacer
auto.dt[, .(mpg)] # ahora devuelve la variable en formato data.table

#para elegir varias columnas 

auto.dt[, .(mpg, horsepower, acceleration)]

# podemos quedarnos con un conjunto de coches  por ejemplo los de 3 4 y 5 cilindros

auto.dt[cylinders %in% c("3C", "4C", "5C")]

# podemos usar estructuras booleanas para concatenar peticiones

auto.dt[cylinders == "4C" & horsepower > 100] # coches de 4 cilindros y con potencia mayo a 100

#podemos iltrar tipo sql con las iniciales de una palabra

auto.dt[car_name %like% "mazda"]

#podemos hacer operaciones por ejemplo hacer el promedio de la variable mpg filtrando por cilindros

auto.dt[, mean(mpg), by = cylinders]
# y lo podemos añadir como una columna nueva

auto.dt[, meanmpg := mean(mpg), by = cylinders]
head(auto.dt)

# se pueden añadir multiples columnas

auto.dt[, c("z_mpg", "sd_mpg") :=list(
  round((mpg - mean(mpg))/sd(mpg),2), sd(mpg)),
  by = cylinders]

auto.dt[1:5, c(1:3,9:12), with = F] # con with = F se convierte a dataframe

# calculos de variables especifica

auto.dt[, lapply(.SD, mean), 
        .SDcols = c("mpg", "horsepower")]



#se puede convertir columnas en claves

setkey(auto.dt, cylinders)
tables()

# ahora podemos usar las claves para acceder a otras columnas por ejemplo la clave 4C

auto.dt["4C", c(1:3,9:10), with = F]

auto.dt[, list(mean= mean(mpg), min = min(mpg),
               max = max(mpg), sd=sd(mpg)),
        by = cylinders]


# para hacerel conteo de cada variable categorizada porejemplo los cilindro se usa .N

auto.dt[,.N, by = cylinders]
auto.dt["3C",.N]

#para eliminar columnas

auto.dt[, meanmpg:=NULL]
head(auto.dt)


# Join o uniones  para juntar dos dataframes
#primer dataframe de empleado
empl <- read.csv("../data/tema11/employees.csv", stringsAsFactors = F)
head(empl)
#segundo dataframe de departamentos
dept <- read.csv("../data/tema11/departments-1.csv", stringsAsFactors = F)
head(dept)

# para combinar los dataframes primero se convierten a datatables

empl.dt <- data.table(empl)
dpt.dt <- data.table(dept)

# creamos una clave para que identificar mejor en este caso del dataset de empleados hacemos como
#clave el id del departamento DeptId

setkey(empl.dt, "DeptId")

# ahora combinamos los datatables para obtener los departamentos y los empleados en unos solo
# con los DeptId como claves

combine <- empl.dt[dpt.dt]
head(combine)

# en el caso de existir un dataframe mas grande que el otro el join daria problemas entonces se hace lo siguiente

dept2 <- read.csv("../data/tema11/departments-2.csv", stringsAsFactors = F)
head(dept2)
#primero lo pasamos a data table
dept2.dt <- data.table(dept2)
# pero al combinar el de empleados con el dept2 creara filas con NA que son los departamentos donde no hya empleados

combine <- empl.dt[dept2.dt]
tail(combine)
combine[,.N] #pregunta cuantas filas hay

# para evitar esos NA se puede usar un parametro para evitarlos
combine <- empl.dt[dept2.dt, nomatch = 0]
tail(combine)
combine[,.N]


# con la funcion MARGE se pueden juntar dos tablas

merge(empl.dt, dept2.dt, by = "DeptId") # InnerJoin
merge(empl.dt, dept2.dt, by = "DeptId", all.x = T) # left join
merge(empl.dt, dept2.dt, by = "DeptId", all.y = T) # right join
merge(empl.dt, dept2.dt, by = "DeptId", all = T) # full join
 

#SIMBOLOS ESPECIALES QUE PERMITEN MEJORAR LAS FUNCIONALIDADES
#DT[i,j,by]
# .SD -> guardar referencia a todas las columnas (salvo las del by)
  # .SDcols -> la referencia guardada a las columnas (son las que se pueden inclui o exluir en la j)
# .EACHI -> para agrupar por claves 
# .N  ->  contar el numero del data table
# .I  ->  los indices indicados en el datatable
# .By  ->



# vamos a calcular el sueldo maximo de cada departamento

empl.dt[dept.dt, max(.SD), by = .EACHI] # daria error por que en max se hace referencia a todas las columnas 
# y existen columnas con nombres que no se puede calcular max para eso se especifica el numeor de columnas que se quiere

empl.dt[dept.dt, max(.SD),by = .EACHI, .SDcols = "Salary"] # con esto se soluciona por que solo se hace referencia a la columna de salario


# sueldo promedio por departamento
empl.dt[, .(AvgSalary = lapply(.SD, mean)),
        by = "DeptId", .SDcols = "Salary"]

# y junamos los departamentos para saber cual es el deprtamento

empl.dt[dept2.dt, list(DeptName, AvgSalat = lapply(.SD, mean)),
        by = .EACHI, .SDcols = "Salary"]
