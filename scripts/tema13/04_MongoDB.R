#MongoDB

install.packages(c("RMongo", "mongolite"))
library(devtools) # para acceder a un repositorio github donde se encuentra la red entrenada
devtools::install_local(path = "../RMongo_0.0.25.tar.gz")
library(RMongo)
library(mongolite)
library(data.table)

crimes <- data.table::fread("../../../data/tema13/Crimes_2001_to_present_sample.csv")

crime_collection = mongo(collection = "full_crimes",
                         db = "chicago")

crime_collection$insert(crimes)

crime_collection$count() # devuelve todos los crimenes
crime_collection$iterate()$one() # devuelve todos los crimenes

crime_collection$count('{ "Primary Type" : "ASSAULT"}')

library(dplyr)
crimes <- crime_collection$find('{}', fields = '{"Primary Type" : 1 , "Year" :1}')
crimes %>% group_by(`Primary Type`) %>% 
  summarize(Count=n()) %>% arrange(desc(Count)) %>% head(10)

crimes %>% group_by(`Year`) %>% 
  summarize(Count=n()) %>% arrange(desc(Count)) %>% head(10)


library(ggplot2)
crime_collection$aggregate('[{"$group":{"_id":"$Location Description", "Count" :{"$sum":1}}}]') %>% na.omit() %>%
  arrange(desc(Count)) %>% head(10)%>%

ggplot(aes(x=reorder(`_id`, Count), y = Count))+
  geom_bar(stat = "identity", fill= "#C678EF")+
  geom_text(aes(label = Count), color = "red") + 
  coord_flip() + xlab("lugar del crimen") + ylab("numero de crimenes ")


