#trabajando con spark

library(SparkR)
sparkR.session()

# las clases de boston y ejemplos de clasificacion

df <- read.df("../data/tema13/boston-housing-logistic.csv",
              "csv", header = "true", inferSchema = "true",
              na.strings = "NA")
showDF(df,5)

train.data <- sample(df, FALSE, 0.8)
test.data <- except(df, train.data)
# freamo un modelo lineal para predecir la clasificacion de la casa en funcion de los otros predictores
model <- glm(CLASS ~ NOX + DIS + RAD + TAX + PTRATIO,
             data = train.data, family = "binomial")

prediction <- predict(model, newData = test.data)
head(prediction)




# sistemas de recomendacion con bases de datos en MySQL

db.url <- "jdbc:mysql://localhost:3306/RecomendationSystem"
df.rates <- read.jdbc(db.url, "RecomendationSystem.Ratin",
                      user = "christian", password = "")

install.packages("sparklyr")
library(sparklyr)
library(devtools)
spark_install(version = "2.1.1")
devtools::install_github("rstudio/sparklyr")
config <- spark_config()
config$`sparklyr.shell.driver-class-path` <- "../lib/mysql-connector-java-5-1-45/mysql-connector-java-5.1.45-bin.jar"
sc <- spark_connect(master = "local",
                    version = "2.2.1",
                    config = config)


