family.salary = c(40000, 60000, 50000, 80000, 60000,70000, 60000)
family.size = c(4, 3, 2, 2, 3, 4, 3)
family.car = c("Lujo", "Compacto", "Utilitario", "Lujo", "Compacto","Compacto", "Compacto")

family <- data.frame(family.salary, family.size, family.car)

#la funcion unique me elimina filas duplicadas de mi data frame

family.without.duplications <- unique(family)

# mostrar solo las filas que contienen duplicados solo ver donde estan sin eliminarlas
# para eso se utiliza la funcion duplicate que devolvera vector de T/F de las duplicaciones

duplicated(family)
family[duplicated(family),]
