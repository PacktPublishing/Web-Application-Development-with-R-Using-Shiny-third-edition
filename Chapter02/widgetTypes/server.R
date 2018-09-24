function(input, output) { 
  
  output$textDisplay = renderTable({ 
    
    getMat = matrix(
      c(paste(input$checkGroup, collapse=','), class(input$checkGroup),
        input$boxInput, class(input$boxInput),
        as.character(as.Date(input$theDate, origin = "1970-01-01")), class(input$theDate),
        paste(as.character(as.Date(input$dateRange[[1]], origin = "1970-01-01")),
              as.character(as.Date(input$dateRange[[2]], origin = "1970-01-01")), 
              collapse = ','),
        class(input$dateRange),
        input$pickNumber, class(input$pickNumber),
        input$pickRadio, class(input$pickRadio),
        input$comboBox, class(input$comboBox),
        input$slider, class(input$slider),
        input$comment, class(input$comment)
      ), ncol = 2, byrow = TRUE)
    
    colnames(getMat) = c("Value", "Class")
    
    getMat
    
  })
}