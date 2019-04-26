library(RgoogleMaps)

wages <- read.csv("../data/tema12/nj-wages.csv")
head(wages)

# vamos a medir los cuantiles de como esta repartida la población
register_google(key = " aqui va la api")
wages$wgClass <- cut(wages$Avgwg, quantile(wages$Avgwg,
                                           probs = seq(0,1,0.2)),
                     labels = F, include.lowest = T)
head(wages)
pal <- palette(rainbow(5))

lat<- 40.155
lon <- -74.715

map <- GetMap(center = c(lat,lon), zoom = 8, 
              API_console_key =  "aqui va la api" )
PlotOnStaticMap(map, wages$Lat, wages$Long, lon, 
                pch=21, cex = sqrt(wages$wgClass),
                bg=pal[wages$wgClass]) # con esto tenemos un mapa de las regiones donde la gente tiene mayores salarios

legend("topleft", 
       legend = paste("<=", round(tapply(wages$Avgwg, wages$wgClass,max
                                         ),0
                                  )
                      ),
       pch = 21, pt.bg = pal, pt.cex = 1.0, bg="gray", title = "Ingresos promedio"
       )
