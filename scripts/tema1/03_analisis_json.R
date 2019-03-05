
install.packages("jsonlite")  # instalar paquete
library(jsonlite)    # inicializar paquete

data.1 <- fromJSON("../data/tema1/students.json")
data.2 <- fromJSON("../data/tema1/student-courses.json")

install.packages("curl")
library(curl)
url <- "http://www.floatrates.com/daily/usd.json"
currencies <- fromJSON(url)
currencie.data<-currencies$eur$rate

head(data.1,3)

data.1$Email
data.1[c(2,5,8),]
data.1[,c(2,5)]
