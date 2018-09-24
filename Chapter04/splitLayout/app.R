
server = function(input, output) {
  
  output$table = renderTable({
    
    head(iris)
  })
  
}

ui = splitLayout(
  cellWidths = c("20%", "20%", "60%"),
  sliderInput("slider", "Slider", min = 1, max = 100, value = 50),
  textInput("text", "Text"),
  tableOutput("table")
)

shinyApp(ui, server)