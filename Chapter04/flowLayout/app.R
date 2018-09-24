
server = function(input, output) {
  
  output$table = renderTable({
    
    head(iris)
  })
  
}

ui = flowLayout(
  sliderInput("slider", "Slider", min = 1, max = 100, value = 50),
  textInput("text", "Text"),
  tableOutput("table")
)

shinyApp(ui, server)