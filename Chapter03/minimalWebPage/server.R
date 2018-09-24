function(input, output) { 
  
  output$textDisplay = renderText({ 
                                     
    paste0("Title:'", input$comment,           
           "'. There are ", nchar(input$comment), 
           " characters in this."                
    )
  })
  
  output$plotDisplay = renderPlot({
    
    par(bg ="#ECF1EF")
    
    plot(poly(1:100, as.numeric(input$graph)), type = "l", ylab="y", xlab="x")
    
  })
  
}