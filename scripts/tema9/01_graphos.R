#Representacion de grafos
install.packages("Matrix")
library(Matrix)
load("../data/tema9/meetup-hiking.Rdata")
unique(users$user_id)
unique(users$group_id)

group_membership = sparseMatrix(users$group_id, users$user_id, x=T) # el x=T es para asignar un 1 si hay considencia entre usuario y grupo

# ahora crearemos una matrix de adyacencias donde los usuarios esten en filas y columnas
# y en la conjuncion indique cuantos grupos coinciden 
#creamos la matrix de adyacencia que es la traspuesta por su original

adjacency <- t(group_membership) %*% group_membership # %*% es para multiplicacion matricial
# pintar una red de usuarios con matriz de aristar
head(summary(adjacency))

users_edgelist <- as.data.frame(summary(adjacency))
summary(users_edgelist)

users_edgelist.upper <- users_edgelist[users_edgelist$i < users_edgelist$j, ] # esto para eliminar la recirpocidad a=B , B=A
save(users_edgelist.upper, file = "../data/tema9/meetup-hiking-edgelist.Rdata")
