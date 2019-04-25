
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   selectInput("choice","Selecciona la variable que deseas en el eje X",
                choices = c("weight", "horspower")),
   downloadButton("report", "generar informe")
   
)


server <- function(input, output) {
  output$report <- downloadHandler(
    #nombre del fichero en pdf
    filename = "Report.pdf",
    # funcion generadora del contenido del fichero
    content = function(file) {
      #Markdown base sobre el que genera el reporte
      report <- file.path("Report.Rmd")
      #configuramos una lista de parametros que pasar al Rmd
      params <- list(n = input$choice)
      
      #generamos el Rmd con los parametros y lo evaluamos de forma general
      
      rmarkdown::render(report,
                        output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
                        )
    }
    
    
  ) 
   
}


shinyApp(ui = ui, server = server)

