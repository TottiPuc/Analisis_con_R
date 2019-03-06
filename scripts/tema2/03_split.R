#split / unsplit

data<-read.csv("../data/tema2/auto-mpg.csv", stringsAsFactors = F)

carslist <- split(data, data$cylinders) # dividira en el numero de cilindros que tiene cada coche
#para ingresar a cada valor de la lista creada por split

carslist[1] # con esto devuelve el objeto
carslist[[1]] # con esto devuelve el dataframe de cada objeto
