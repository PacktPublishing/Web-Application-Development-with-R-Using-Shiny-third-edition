
library(tidyverse)

load("geocodedData.Rdata")

function(input, output) { 
  
  output$plotDisplay <- renderPlot({
    
    gapminder %>%
      filter(country == input$country) %>%
      ggplot(aes(x = year, y = lifeExp)) +
      geom_line()
    
  })
  
  output$outputLink <- renderText({
    
    link = "https://en.wikipedia.org/wiki/"
    
    paste0('<form action="', link, input$country, '">
             <input type="submit" value="Go to Wikipedia">
             </form>')
  })
}