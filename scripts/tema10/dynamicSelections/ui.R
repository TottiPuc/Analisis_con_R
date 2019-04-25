library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Elecciones dinamicas de data frame"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("dataset", "seleccion del dataset",
                   c("mtcars","rock")),
       uiOutput("var")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("Plot")
    )
  )
))
