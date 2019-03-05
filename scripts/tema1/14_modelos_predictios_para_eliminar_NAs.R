library(mice)
housing.data <- read.csv("../data/tema1/housing-with-missing-value.csv", header = T, stringsAsFactors = F)

#escojo las columnas donde queiro imputar o inferir datos 

columns <- c("ptratio","rad")

#con mice creo un modelo predictivo que va a buscar una serie de itraciones basado en un numeor de valores para ajustar y  rellenar los valores NA
impute.date <- mice(housing.data[,names(housing.data) %in% columns], 
                    m = 5, # tomara 5 valores diferentes para poder inferir en cada iteracion
                    maxit =50, # numero de maximo de iteraciones que se quieres para inferir
                    method = "pmm",
                    seed = 2018) # se puede dejar por defecto o poner cualuier valor estandar


#metodos pmm - comparacion de medias predictivas 
#metodos logreg - regresion logistica
#modelo polyreg regresion logistica politomica
#polr modelo probabilidades proporcionales

summary(impute.date)

# ahora vamos a completar el data frame con los valores encontrados con el modelo predictivo
#se utiliza :: para especificar que la funcion complete pertences a micey no confundir con la de curl
complete.data <- mice::complete(impute.date)

#finalmente lo completo en el dataframe original 

housing.data$rad <- complete.data$rad
housing.data$ptratio <- complete.data$ptratio
#y ahora voy a comprobar cuantos NA tiene mi dataset completado

anyNA(housing.data)



#UNA ULTIMA FORMA DE IMPUTAR DATOS CON EL PAQUETE HMISC

library(Hmisc)
impute_arg <- aregImpute(~ptratio + rad, data = housing.data, n.impute = 5)
impute_arg

impute_arg$imputed$ptratio
