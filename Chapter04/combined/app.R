
server = function(input, output) {
  
  output$table = renderTable({
    
    head(iris)
  })
  
  output$graph1 = renderPlot({
    
    plot(runif(10), runif(10))
  })
  
  output$graph2 = renderPlot({
    
    plot(runif(10), runif(10))
  })
  
}

ui = fluidPage(
  fluidRow(
    column(width = 4, 
           sliderInput("slider", "Slider", min = 1, max = 100, value = 50)),
    column(width = 8, 
           tableOutput("table")
    )
  ),
  splitLayout(
    plotOutput("graph1"), plotOutput("graph2")
  ),
  verticalLayout(
    textInput("text", "Text"),
    p("More details here"),
    a(href = "https://shiny.rstudio.com/tutorial/", "Shiny documentation")
  )
)

shinyApp(ui, server)