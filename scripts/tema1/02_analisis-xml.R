install.packages("XML") #instalar este paquete para usar xml
library(XML)
url <- "../data/tema1/cd_catalog.xml"
xmldoc <- xmlParse(url)
rootnode <- xmlRoot(xmldoc)
rootnode[2]
cds_data <- xmlSApply(rootnode, function(x) xmlSApply(x, xmlValue))
cds.catalog <- data.frame(t(cds_data), row.names = NULL)
head(cds.catalog,2)
cds.catalog[1:5,]


html_url <- "../data/tema1/WorldPopulation-wiki.htm"
datos_html <- readHTMLTable(html_url)
mos_popular <-datos_html[[6]]
head(mos_popular,2)

custom_table <- readHTMLTable(html_url, which = 6)
