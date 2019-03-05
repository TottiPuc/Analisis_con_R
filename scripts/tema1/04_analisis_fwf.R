students_data<- read.fwf("../data/tema1/student-fwf.txt",widths = c(4,15,20,15,4),
                         col.names = c("id","name","email","carrera","año"))

students_data_header <- read.fwf("../data/tema1/student-fwf-header.txt", widths = c(4,15,20,15,4),
                                 header = T, sep = "\t",skip = 2) #ponemos el separador de la header  y skip es para saltar el numero de lineas que no nos interesan en este caso las dos primeras lineas

students_data_noemail<- read.fwf("../data/tema1/student-fwf.txt",widths = c(4,15,-20,15,4),
                         col.names = c("id","name","carrera","año")) # para eliminar una columna solo se spone la columna con signo menos (-)
