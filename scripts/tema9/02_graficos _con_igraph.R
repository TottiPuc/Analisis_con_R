#Representacion de grafos con matrices de aristas o de adyacencias
install.packages("igraph")
library(igraph)
load("../data/tema9/meetup-hiking-edgelist.Rdata")

# como son muchas observaciones para crear el grapho se reducira la red social para poder representarla

users_edgelist.filtered <- users_edgelist.upper[users_edgelist.upper$x>15, ] # nos quedamos con grupos que superen los 15 usuarios
head(users_edgelist.filtered)
#como los identificadores de los usuarios tienen numeros muy grandes
#es mejor renombrarlos para tener un mejor grapho
uid <- unique(c(users_edgelist.filtered$i, users_edgelist.filtered$j))

#buscamos las coincidencias para poder renombrar
# reescalar los identificadores de usuario
i <- match(users_edgelist.filtered$i, uid)
j <- match(users_edgelist.filtered$j, uid)

new.graph <- data.frame(i,j,x=users_edgelist.filtered$x)
head(new.graph)

# representar grafos con igraph
g <- graph.data.frame(new.graph,directed = F)
g
save(g, file = "../data/tema9/meetup-hiking-graph.Rdata") #guardar el grafo
plot.igraph(g,vertex.size =20)

plot.igraph(g, layout= layout.circle, vertex.size =20)
plot.igraph(g, edge.cuved = T , vertex.color = "pink", edge.color = "blue")
#podemos alterar el tamaño de los vertices de los grafos

V(g)$size = degree(g)*4
plot.igraph(g, edge.cuved = T , vertex.color = "pink", edge.color = "blue")

color <- ifelse(degree(g)>=5, "red", "blue")
size <- degree(g)*4
plot.igraph(g, vertex.label = NA,
            layout=layout.fruchterman.reingold,
            vertex.color=color,
            vertex.size=size)
E(g)$x
plot.igraph(g, edge.curved = T, edge.color ="black",
            edge.width = (E(g)-min(E(g))+1)/5)

# Grafo dirigido

dg <- graph.data.frame(new.graph, directed = T)
save(dg, file = "../data/tema9/meetup-hiking-d-graph.Rdata")
plot.igraph(dg, edge.curved=T, edge.color="black",
            vertex.label.cex=0.5)

#grafos con pesos en las aristas
# se debe hacer un cambio a la tercera variable se debe llamar weight

new.graph.w <- new.graph
names(new.graph.w) <- c("i","j","weight")
wg <- graph.data.frame(new.graph.w, directed = F)
wg

plot.igraph(wg)
E(wg)$weight
plot.igraph(wg, edge.label = E(wg)$weight)


# ahora vamos a hacer el proceso inverso obterner la matrix sparsed apartir del grafo
get.adjacency(g, type = "upper") # se muestra la marixy sus conecciones
get.adjacency(g, type = "lower", attr = "x") # se muestra la matrix y sus conecciones representadas por los pesos

# obtener la lista de aristas a partir de un grafo
get.data.frame(g)
get.data.frame(g, "vertices")
get.data.frame(g, "both")


#grafo bipartido
g1<- rbinom(10,1,0.5)
g2<- rbinom(10,1,0.5)
g3<- rbinom(10,1,0.5)
g4<- rbinom(10,1,0.5)
g5<- rbinom(10,1,0.5)

membership <- data.frame(g1,g2,g3,g4,g5)
names(membership)
rownames(membership) <- c("U1","U2","U3","U4","U5","U6","U7","U8","U9","U10")
rownames(membership)

bg <- graph.incidence(membership)
bg
V(bg)$type
V(bg)$name

layout <- layout.bipartite(bg)
plot(bg, layout = layout, vertex.size=20)

#proyeccion de un grafo bipartido
p <- bipartite.projection(bg)
p
plot(p$proj1, vertex.size =15)
plot(p$proj2, vertex.size =20)
