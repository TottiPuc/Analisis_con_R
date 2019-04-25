#Analisis de redes con twitter
library(twitteR)
library(igraph)
library(dplyr)

api_key <- "zqTa9C4Q3HTUyRh9Es9StretZ"
api_secret <- "WMHmFEflKjoJ9HdFYmedveB82BJguXvTmhcWIkBv31gSSYY8Qo"
access_token <- "239854124-MlEwZl5nD11CZGj69MXEhrzms3nQMEpoaF1CbUmy"
acces_token_secret <- "yOIw6POSdp6yJRd8L6aCDgfhcZ4yTX45vNPEPfqzgxxol"

setup_twitter_oauth(api_key, api_secret,access_token, acces_token_secret)

#ahora descargamos tweets

all_tweets <- searchTwitter("monetization", n=2000)# buscamos el hashtag que queremos en este caso monetization con 2000 tweets

# despues pasamos la lista de tweets a un dataframe

all_tweets <- twListToDF(all_tweets)

# ahora trabajamos com los 200 primeros tweets si los algoritmos funcionan se puede trabajar ocn el df completo

#sample_tweets <- all_tweets[1:200,]
sample_tweets <- all_tweets # si queresmo analisar toda la red

# dividimos en si son tweets o retweets

split_tweest <- split(sample_tweets, sample_tweets$isRetweet)

# primero trabajaremos con los retweets

retweets <- mutate(split_tweest[['TRUE']],
                   sender = substr(text, 5, regexpr(":",text)-1)) # lo que se hace es quedarse 
                    # con el usuario eliminando el RT y el espacio de inicio por eso empieza en 5
                    # y llegando hasta el primer : una posicion anterior

# ahora creamos las aristas de quien a retweeteado a quien 

edge_list <- as.data.frame(cbind(sender = tolower(retweets$sender),
                                 receiver = tolower(retweets$screenName)))

#ahora con la lista de aristas o nodos creado anteriormente vamos a contar cuantos retweets hay en esa lista de emisorr y receptro

edge_list <- count(edge_list, sender, receiver)

# ahora creamos la red

tweets_graph <- graph_from_data_frame(d=edge_list, directed = T)
save(tweets_graph, file = "../data/tema9/tweets-from-monetization.Rdata")


# ahora lo graficaremos los retweets

plot(tweets_graph, 
     #layout = layout.fruchterman.reingold,
     vertex.color= "blue",
     vertex.size = degree(tweets_graph, mode = "in"), # in para ver como son de importantes los tweets de ntrada se puede dividir por n par aminimizar la arista /n
     vertex.label=NA,
     edge.arrow.size=0.5,
     edge.arrow.width =0.5,
     edge.width = edge_attr(tweets_graph)$n,
     edge.color = hsv(h=.9, s=1, v=.7, alpha = 0.5),
     main= "Tweets sobre monetizacion")


# vamos a probar otros layout basados en fuerza de atraccion
install.packages("devtools")
install.packages("backports")
library(devtools)
devtools::