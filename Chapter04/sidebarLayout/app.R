
server = function(input, output) {
  
  output$table = renderTable({
    
    head(iris)
  })
  
}

ui = fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider", "Slider", min = 1, max = 100, value = 50),
      textInput("text", "Text")),
    mainPanel(tableOutput("table"))
  )
)
  
  shinyApp(ui, server)