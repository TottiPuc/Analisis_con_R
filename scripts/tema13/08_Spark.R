#Apache spark
install.packages("SparkR")
#library(devtools)
#devtools::install_github("apache/spark@v2.2.1" , subdir = "R/pkg") # solo instalo el paquete de R
library(SparkR)

sparkR.session()

iris.df <- createDataFrame(iris)
showDF(iris.df, 5)

#extraer un subconjunto
sub.iris.df <- select(iris.df,
                      c("Sepal_Length", "Petal_Length"))
showDF(sub.iris.df,5)

library(magrittr)

agr.iris.df <- iris.df %>% groupBy("Species") %>% 
  avg("Sepal_Length") %>%
  withColumnRenamed("avg(Sepal_Length)", "AVg_Sepal_Length") %>%
  orderBy("Species")
#redondeamos a dos numeros
agr.iris.df$AVg_Sepal_Length <- format_number(agr.iris.df$AVg_Sepal_Length,2)
showDF(agr.iris.df)



# creamos una tabla temporal que al hacerla con spark es cmo si fuerra una tabla SQL
createOrReplaceTempView(iris.df,"IrisTable")
collect(sql("SELECT * FROM IrisTable LIMIT 10"))
