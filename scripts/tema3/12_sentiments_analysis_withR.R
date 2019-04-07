install.packages(c("twitteR", "RColorBrewer", "plyr",
                   "ggplot2", "devtools", "httr"))
require(devtools)

install_url("https://cran.r-project.org/src/contrib/Archive/Rstem/Rstem_0.4-1.tar.gz")
install_url("https://cran.r-project.org/src/contrib/Archive/slam/slam_0.1-37.tar.gz")
install_url("https://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz")

library(slam)
library(sentiment)
library(twitteR)


api_key <- "zqTa9C4Q3HTUyRh9Es9StretZ"
api_secret <- "WMHmFEflKjoJ9HdFYmedveB82BJguXvTmhcWIkBv31gSSYY8Qo"
access_token <- "239854124-MlEwZl5nD11CZGj69MXEhrzms3nQMEpoaF1CbUmy"
acces_token_secret <- "yOIw6POSdp6yJRd8L6aCDgfhcZ4yTX45vNPEPfqzgxxol"

#crear la configuracion de acceso
setup_twitter_oauth(api_key, api_secret, access_token, acces_token_secret)

# descargar tweets que contengan la palabra machinelearning en total 1500 en ingles
tweets <- searchTwitter("machinelearning", n = 1500, lang = "en")

#limpiar los tweets descargados eliminando cosas inecesarias 
texts <- sapply(tweets, function(x) x$getText())
head(texts)

#ahora crearemos una funcion que limpie la informacion
clean.data <- function(text){
#eliminar re-tweets y @ del texto original ( si es re-tweet aparecera RT)y VIA que es cuadno se trasmite por web esto con la funcion gsub
  text = gsub("(RT|VIA)((?:\\b\\W*@\\w+)+)","", text)
  text = gsub("@\\w+", "", text)
  
  #borrar o liminar signos de puntuacion y digitos del zero al nueve
  text = gsub("[[:punct:]]", "", text)
  text = gsub("[[:digit:]]", "", text)
  
  # elimonar los links html tabulaciones y espacios regulares
  text <- gsub("http\\w+", "",text)
  text = gsub("[ \t]{2,}","", text)
  text = gsub("^\\s+|\\s+$", "",text)
  
}

#ahora aplicaremos la funcion antes creada al texto
texts <- clean.data(texts)
head(text)

# vamos a usar una funcion que gestiones los posibles NA esto se hace para posibles sentencias que no se puedan tratar como letras chinas caracteres especiales etc se catalogara como NA

handle.error <- function(x){
  #crear el valor omitido
  y=NA
  #intentar encontrar el erro con try_catch error
  try_error <- tryCatch(tolower(x), error=function(e) e)
  # si no hay error
  if(!inherits(try_error, "error"))
    y=tolower(x)
  #devolvemos el resultado
  return(y)
  
}

#probavmos la funcion

texts = sapply(texts, handle.error)
head(texts)

texts <- texts[!is.na(texts)]
names(texts) <- NULL
head(texts)



# analisis de sentimineto usando la funcion classyfy_emotion

class_emo <- classify_emotion(texts, algorithm = "bayes", prior = 1)
head(class_emo)

# nos quedaremos con la septima columna que es la clase que da el algoritmo

emotion <-class_emo[,7]
emotion[is.na(emotion)] <- "unknowns"
head(emotion)

#@otro tipo de analisis es el de la polaridad para ver si un tweet es catalogado como positivo o negativo o neutro

class_pol <- classify_polarity(texts, algorithm = "bayes")
head(class_pol)
polarity <- class_pol[,4]

#ahora crearemos un dataframe con todos los analisis hechos

sent_df <- data.frame(text = texts,
                      emotion = emotion, polarity = polarity, stringsAsFactors = F)
#por ultimo se reordena a factores de la emocion reconstruyendo los datos con within

sent_df <- within(sent_df, emotion <- factor(emotion, levels = names(sort(table(emotion), decreasing = T))) )


# ahora para representar los datos usamos las librerias RColorBrewer y ggplot2

library(RColorBrewer)
library(ggplot2)

ggplot(sent_df,aes(x= emotion))+
  geom_bar(aes(y = ..count.., fill=emotion))+
  scale_fill_brewer(palette = "Set2")+
  labs(x="categorias de emociones", y="numero de Tweets")+
  labs(tittle = "Analisis de sentimientos acerca de machine learning")

ggplot(sent_df, aes(x = polarity))+
  geom_bar(aes(y = ..count.., fill = polarity))+
  scale_fill_brewer(palette = "Set3")+
  labs(x="categorias de polaridad", Y="numero de tweets")+
  labs(tittle = "Analisis de sentimiento acerca de machine learning ")
