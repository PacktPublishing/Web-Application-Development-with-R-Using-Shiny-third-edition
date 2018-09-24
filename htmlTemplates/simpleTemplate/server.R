
library(tidyverse)
library(gapminder)

if(!file.exists("geocodedData.Rdata")){
  
  mapData = gapminder %>%
    mutate(country2 = as.character(country)) %>%
    group_by(country) %>%
    slice(1) %>%
    mutate_geocode(country2, source = "dsk") %>%
    select(-country2)
  
  mapData = left_join(gapminder, mapData) %>%
    group_by(country) %>%
    fill(lon) %>%
    fill(lat)
  
  save(mapData, file = "geocodedData.Rdata")
  
} else {
  
  load("geocodedData.Rdata")
}

function(input, output) {
  
  theData = reactive({
    
    mapData %>%
      filter(year >= input$year[1])
  })
  
  output$trend = renderPlot({ 
    
    thePlot = theData() %>%
      group_by(continent, year) %>%
      summarise(meanLife = mean(lifeExp)) %>%
      ggplot(aes(x = year, y = meanLife, group = continent, colour = continent)) +
      geom_line() + ggtitle("Graph to show life expectancy by continent over time")
    
    if(input$linear){ 
      thePlot = thePlot + geom_smooth(method = "lm") 
    } 
    
    print(thePlot)
  })
  
}
