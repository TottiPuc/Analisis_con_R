#REDES
install.packages("igraph")
library(igraph)

g.dir <- graph(edges = c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6, 5,6), n=6) # grafo dirigido
g.n.dir <- graph(edges = c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6, 5,6), n=6, directed = F) # grafo no dirigido

par(mfrow=c(1,2))
plot(g.dir)
plot(g.n.dir)

g_isolated <- graph(c("juan", "maria",
                      "maria", "ana",
                      "ana", "juan",
                      "jose", "maria",
                      "pedro","jose",
                      "joel", "pedro"),
                    isolates = c("carmen", "antonio", "mario", "vicente"))

par(mfrow=c(1,1))
plot(g_isolated, edge.arrow.size=1, 
     vertex.color="gold", vertex.size=15,
     vertex.frame.color="gray",
     vertex.label.color = "black",
     vertex.label.cex = 0.8,
     vertex.label.dist =2,
     edge.curved=0.2)
