
function(input, output, session) {

  output$randomNumber = renderText({
    
    theNumber = sample(1:input$pickNumber, 1)
    
    session$sendCustomMessage(type = 'sendMessage',
                              message = theNumber)
    
    return(theNumber)
  })
  
  output$theMessage = renderText({
    
    return(input$JsMessage)
  })
  
}