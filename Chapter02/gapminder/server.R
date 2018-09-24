
library(tidyverse)
library(gapminder)
library(leaflet)
library(ggmap)

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
  
  # produce data
  
  theData = reactive({
    
    mapData %>%
      filter(year >= input$year[1], year <= input$year[2])
  })
  
  # Summary 
  
  output$summary = renderText({
    
    paste0(input$year[2] - input$year[1], " years are selected. There are ", 
           length(unique(theData()$country)), " countries in the dataset measured at ",
           length(unique(theData()$year)), " occasions.")
  })
  
  # trend
  
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
  
  # map
  
  output$map = renderLeaflet({
    
    mapData %>%
      filter(year == input$year[2]) %>%
      leaflet() %>%
      addTiles() %>%
      setView(lng = 0, lat = 0, zoom = 2) %>%
      addCircles(lng = ~ lon, lat = ~ lat, weight = 1,
                 radius = ~ lifeExp * 5000, 
                 popup = ~ paste(country, lifeExp))
  })
  
}