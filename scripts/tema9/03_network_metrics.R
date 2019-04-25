#Metricas
library(igraph)
load("../data/tema9/bipartite-graph.Rdata")
load("../data/tema9/meetup-hiking-d-graph.Rdata")
load("../data/tema9/meetup-hiking-graph.Rdata")

degree(g)# esto nos muestra los grados o numero de conecciones y aristas de nuestro grafo
plot.igraph(g)
# podemos pedir informacion de cada nodo
degree(bg, "g3")
degree(dg,15,mode = "in")
degree(dg,15,mode = "out")

options(digits = 3)
degree.distribution(dg)

# como de medio esta en el camino de un par de nodos 
betweenness(g)
betweenness(bg, "g3") # betweeness de un nodod en particular

# preguntar el betweeness de las aristas 

edge.betweenness(bg)

# saber cuales son los vecinos de cada nodo

neighbors(g,1)

#añadir nodos
new.g <- g + vertex(27,28)
plot.igraph(new.g)

#añadir aristas
new.g <- new.g + edge(27,28)
plot.igraph(new.g)

#eliminar nodos tambien es util cuadno estan aislados
new.g <- new.g +vertex(29,30,31)
plot.igraph(new.g)
new.g <- delete.vertices(new.g, V(new.g)[degree(new.g)==0])
plot.igraph(new.g)

new.g <- delete.vertices(new.g, 1)
plot.igraph(new.g)


