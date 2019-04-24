#Sistemas hibridos : UBCF + random selection
install.packages("recommenderlab")
library(recommenderlab)

data("MovieLense")
data_frame <- MovieLense[rowCounts(MovieLense)>50,]

train <- data_frame[1:100]
test <- data_frame[101:110]

hybrid_recom <- HybridRecommender(
  Recommender(train, method = "UBCF"),
  Recommender(train, method = "RANDOM"),
  weights = c(0.75, 0.25) # esto es para delegar pesos a los modelos usados en este caso UBCF tiene mas peso
  
) 

as(predict(hybrid_recom, test, 3), "list") # el as y el list son puesto para que el objeto seadevuelto
# por consola haciedno casting como lista