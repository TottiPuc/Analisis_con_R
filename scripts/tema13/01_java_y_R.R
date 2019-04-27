#JAVA
install.packages("rJava")
library(rJava)
.jinit()
.jcall("java/lang/System","S","getProperty","java.runtime.version")
getwd()
setwd("tema13")
setwd("java-files")
.jaddClassPath(getwd())
.jclassPath()


### CLASE STRING DE JAVA

s <- .jnew("java/lang/String", "Hola Soy Christian Arcos y Soy MCs")
print(s)
.jstrVal(s)
.jcall(s, "S", "toLowerCase")
.jcall(s,"S","toUpperCase")
.jcall(s,"S", "replaceAll", "Christian Arcos", "ingeniero")


### VECTORES EN  JAVA

v <- .jnew("java/util/Vector")
months <- month.abb
months # esto crea los meses del año en R
sapply(months, v$add)
v$size()
v$toString()


### CALENDARIO y Array

monthArray <- .jarray(month.abb)
yearArray <- .jarray(as.numeric(2011:2017))
colArray <- .jarray(list(monthArray, yearArray))
print(colArray)
.jevalArray(colArray)
.jevalArray(monthArray)
print(l <- .jevalArray(colArray))
l
lapply(l, .jevalArray)


### Class hello world
hw <- .jnew("HelloWorld")
hello <- .jcall(hw , "S", "getString")
hello

greet <- .jnew("Greeting")
print(greet)
jb <- .jcall(greet, "S", "getString", "Christian Arcos")
print(jb)
.jstrVal(jb)
