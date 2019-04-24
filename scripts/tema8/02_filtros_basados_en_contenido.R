# filtros basados en contenido con datasets cargados directo desde la url
movie_url <- "http://files.grouplens.org/datasets/movielens/ml-100k/u.item"
users_url <- "http://files.grouplens.org/datasets/movielens/ml-100k/u.data"


movie_title_df <- read.table(movie_url,
                             header = F,
                             sep= "|",
                             quote = "\"")
users_df <- read.table(users_url,header = F,
                       sep = "\t",
                       quote = "\"")

names(movie_title_df) <- c("MovieID","Title","ReleaseDate",
                           "videoReleaseDate","IMDb_URL",
                           "unknown","Action","Adventure",
                           "Animation", "children","Comedy",
                           "Crime","Documentary","Drama","Fantasy",
                           "FilmNoir","Horror","Musical","Mystery",
                           "Romance","SciFi","Thriller","War","Western") # con esto damos un nombre a cada columna del dataset

head(movie_title_df)
# eliminamos columnas que no importan en un lcuste

movie_title_df$ReleaseDate <-NULL
movie_title_df$videoReleaseDate <- NULL
movie_title_df$IMDb_URL <- NULL
#eliminamos peliculas duplicadas
movie_title_df <- unique(movie_title_df)

head(users_df)
names(users_df) <- c("UserID","MovieID", "rating", "timestamp" )
#eliminar columnas innecesarias
users_df$timestamp <- NULL

str(movie_title_df)

# segmentacion de pelicula basada en el genero como distancia para usar kmeans

clusterMovies <- function(df, kclust =10){
  df <- df[,c(-1,-2)] #elimino mas variables poco necesarias como el identificaro y el titulo
  mclust <- kmeans(df,centers = kclust, nstart = 20)
return(mclust)
}


# ahora hacer unafuncion que detecte las peliculas que el usuario ha visto y ha valorado

getUserInfo <- function(df,id){
  myUser <- subset(df, UserID == id, select =c(MovieID,rating))
  cluster <-0
  activeUser <- data.frame(myUser[order(myUser$MovieID),],cluster)
  return(activeUser)
  }

setUserMovieCluster <- function(m_title_df, mclust, activeUser){
  df_aux <- data.frame(cbind(m_title_df$MovieID,
                             clustNum = mclust$cluster))
  names(df_aux) <- c("MovieID","Cluster")
  activeUser$cluster <- df_aux[match(activeUser$MovieID, df_aux$MovieID),2]
  return(activeUser)
}


getAverageClusterRating <- function(mclust, activeUser,minRating = 3){
  like <- aggregate(activeUser$rating, by = list(cluster=activeUser$cluster),mean)
  if(max(like$x)<minRating){
    like <- as.vector(0)
  }else {
    like <- as.vector(t(max(subset(like, x>=minRating, select = cluster))))
  }
  return(like)
}


getRecommendedMovies <- function(like, mclust, m_title_df){
  df_aux <- data.frame(cbind(m_title_df$MovieID,
                             clusterNum = mclust$cluster)
                       )
  names(df_aux) = c("MovieID", "Cluster")
  if(like ==0){
    recommend <- m_title_df[sample.int(n =nrow(m_title_df),
                                           size = 100),1]
  } else{
    recommend <- as.vector(t(subset(df_aux, Cluster == like,
                                    select = MovieID)))
  }
 
}


getRecommendations <- function(movie_df, user_df, userID){
  mclust <- clusterMovies(movie_df)
  activeUser <- getUserInfo(user_df, userID)
  activeUser
  activeUser <- setUserMovieCluster(movie_df, mclust, activeUser)
  like <- getAverageClusterRating(mclust, activeUser)
  recomendation <- getRecommendedMovies(like,mclust,movie_df)
  # eliminamos las peliculas que el usuario ya ha visto
  recomendation <- recomendation[-activeUser$MovieID]
  #añadimos el titulo de la pelicula
  movieTitle <- movie_df[match(recomendation, movie_df$MovieID),2]
  recomendation <- data.frame(recomendation,movieTitle)
  return(recomendation)
}

suggestMovies <- function(movie_df, user_df, user_id, num_movies){
  suggestions <- getRecommendations(movie_df,user_df,user_id)
  #suggestions
  suggestions <- suggestions[1:num_movies,]
  writeLines("Tal vez te gustaria ver tambien las siguientes peliculas")
  write.table(suggestions[2],row.names = F, col.names = F)
}


suggestMovies(movie_title_df,users_df, 196,10) # es el usuario 196 con sus 10 top list

users_df[users_df$UserID ==196,]$MovieID # con esto me quedo con todas las peliculas que ha visto el usuario 196
movie_title_df[match(movie_title_df$MovieID,users_df[users_df$UserID ==196,]$MovieID),2] # de todas las peliculas cuales a visto el usuario 
