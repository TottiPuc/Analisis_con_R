install.packages("treemap")
library(treemap)

#vamos a crear un arbol de valores solo para variables categoricas

branch <-c(rep("branch-1",4), rep("branch-2",2), rep("branch-3",3))
branch
subbranch <- paste("subbranch", c(1,2,3,4,1,2,1,2,3), sep = "-")
subbranch
values = c(15,4,22,13,11,8,6,1,25)
# ahora juntando rama con subrama y valor podemos crear un dataset 

data<- data.frame(branch,subbranch,values)
data
treemap(data, index = c("branch","subbranch"), 
        vSize = "values", type = "index")


# ahora un treemap para mezcla de variables categoricas y numercias 

posts <- read.csv("../data/tema7/post-data.csv")
head(posts) 
# ahora vamos a juntar la categoria del post con el mumero de comentarios y las views osea categoria con numericas y el tamaño de la caja seran las views

treemap(posts, index = c("category", "comments"),
        vSize = "views", type = "index")

