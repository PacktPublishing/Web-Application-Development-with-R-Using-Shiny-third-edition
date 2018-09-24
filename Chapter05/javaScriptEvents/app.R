
ui <- fluidPage(
   
   titlePanel("JavaScript Events"),
   
   sidebarLayout(
      sidebarPanel(
         actionButton("redraw", "Redraw plot")
      ),
      
      mainPanel(
         plotOutput("testPlot"),
         includeHTML("events2.js")
      )
   )
)

server <- function(input, output) {
   
   output$testPlot <- renderPlot({
     
     input$redraw
     Sys.sleep(5)
     plot(1:10)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

