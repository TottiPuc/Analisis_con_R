library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Elecciones condicionales"),
  
  # Sidebar with a slider input for number of bins 
  sidebarPanel(
    selectInput("plot_type", "plot type",
                c("Scatter Plot" = "scatter",
                  "Histogramas" = "histogram")),
    conditionalPanel(condition="input.plot_type != 'histogram'",
                     selectInput("x"," Selecciona la variable en el eje X",
                                 choices = c("Peso" = "weight",
                                             "cilindro" = "cylinders",
                                             "caballos de p" = "horsepower")))
    
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot") 
      
    )
  )
)
