# Mapas de R
install.packages("maps")
library(maps)

map("world") # mapa con fronteras
map("world", interior =F) # mapa sin fronteras
map("world", fill=T, col = palette(rainbow(8))) # mapa relleno con 8 colores

#mapa de colombia
map("world","colombia")
map("italy")

map("world","colombia")

