names.first <- c("christian dayan", "sara", "grear69")
names.last <- c("Arcos", "españa", "Rubio")

#funcion paste para combinar dos vectores elemento a elemento siempre y cuadno sean del mismo tamanho
paste(names.first,names.last)


single.surnmae <- c("simpson", "carl")

paste(names.first, single.surnmae) # si no son del mismo tamaño el mas pequeño se añadira a todos y se repetira

# crear una funcion para unir cuantos caracteres querramos

username <- function(first, last){
  tolower(paste0(last, substr(first,2,3)))
  
}
username(names.first,names.last)

# multiplicar toda una variable por un escalar

auto <- read.csv("../data/tema10/auto-mpg.csv")

head(auto)
auto$dmpg <- auto$mpg *2
head(auto)

sum(auto$mpg)
min(auto$mpg)
max(auto$mpg)
range(auto$mpg)
prod(auto$mpg)

mean(auto$mpg)
median(auto$mpg)
var(auto$mpg)
sd(auto$mpg)
