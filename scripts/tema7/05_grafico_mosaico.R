#MOSAIC PLOT
install.packages("stats")
library(stats)
#en este grafico lo que nos intresa son las variables categoricas y no las numericas por ejemplo las variables gear y carb de este dataset
mtcars<- read.csv("../data/tema7/mtcars.csv")
head(mtcars)

mosaicplot(~ gear + carb, data = mtcars, color = 2:5, las =1) 
