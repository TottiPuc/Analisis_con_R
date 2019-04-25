library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("Aplicacion simple con Shiny"),
  sidebarPanel(
    p("Vamos a cear plots con el data frame de auto"),
    selectInput("x", "Seleciona el eje de las X",
                choices = c("weight","cylinders","acceleration"))),
  mainPanel(
    tabsetPanel(
      tabPanel("plot",
         h3(textOutput ("output_text")),
         plotOutput("output_plot")
      ),
      tabPanel("Image",
                img(src="machine_learning.JPG",height =200, widht = 200)     
               ),
      tabPanel("Summary",
               verbatimTextOutput("summary")),
      tabPanel("Table",
               tableOutput("table")),
      tabPanel("Data table",dataTableOutput("datatable"))
               
    )
    
    
   
    )
  
)
)