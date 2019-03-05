auto <- read.csv("../data/tema1/auto-mpg.csv", header = TRUE, sep = ",", 
                 na.strings="",stringsAsFactors = FALSE)
names((auto))
head(auto,4)

auto_noheader <- read.csv("../data/tema1/auto-mpg-noheader.csv", header = F)
auto_custom_header <- read.csv("../data/tema1/auto-mpg-noheader.csv", header = F, 
                               col.names = c("nuemro","millas","cilindrada","desplaza","caballos",
                                             "peso","aceleracion","año","modelo"
                                             )
                               )
head(auto_custom_header,2)
