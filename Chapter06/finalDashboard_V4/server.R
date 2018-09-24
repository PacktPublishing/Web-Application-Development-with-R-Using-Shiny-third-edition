
library(tidyverse)
library(gapminder)
library(leaflet)
library(googleVis)

function(input, output, session) {
  
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
      geom_line()
    
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
  
  # icons
  
  output$infoYears = renderInfoBox({
    infoBox(
      "Years", input$year[2] - input$year[1], 
      icon = icon("calendar", lib = "font-awesome"),
      color = "blue", 
      fill = ifelse(input$year[2] < 2007, 
                    TRUE, FALSE)
    )
  })
  
  output$infoLifeExp = renderInfoBox({
    
    infoLifeExp = theData() %>%
      filter(year == 2007) %>%
      group_by(continent) %>%
      filter(continent == input$continent) %>%
      pull(lifeExp) %>%
      mean() %>%
      round(0)

    infoBox(
      "Life Exp. (2007)", infoLifeExp,
        icon = icon("user"),
      color = "purple", 
      fill = ifelse(infoLifeExp > 60, 
                    TRUE, FALSE)
    )
  })
  
  output$infoGdpPercap = renderInfoBox({
    
    infoGDP = theData() %>%
      filter(year == 2007) %>%
      group_by(continent) %>%
      filter(continent == input$continent) %>%
      pull(gdpPercap) %>%
      mean() %>%
      round(0)
    
    infoBox("GDP per capita", 
      infoGDP, 
      icon = icon("usd"),
      color = "green", 
      fill = ifelse(infoGDP > 5000, 
                    TRUE, FALSE)
    )
  })
  
  output$notifications = renderMenu({
    
    countries = length(unique(theData()$country))
    continents = length(unique(theData()$continent))
    
    notifData = data.frame("number" = c(countries, continents), 
                            "text" = c(" countries", " continents"), 
                            "icon"= c("flag", "globe"))
    
    notifs <- apply(notifData, 1, function(row) {
      notificationItem(text = paste0(row[["number"]], row[["text"]]), 
                       icon = icon(row[["icon"]]))
    })
    dropdownMenu(type = "notifications", .list = notifs)
  })
  
  output$gauge = renderGvis({
    
    # dependence on size of plots to detect a resize
    
    session$clientData$output_trend_width
    
    infoGDP = theData() %>%
      filter(year == 2007) %>%
      group_by(continent) %>%
      filter(continent == input$continent) %>%
      pull(gdpPercap) %>%
      mean() %>%
      round(0)
    
    df = data.frame(Label = "GDP", Value = infoGDP)
    
    gvisGauge(df,
              options = list(min = 0, max = 50000, 
                             greenFrom = 5000, greenTo = 50000, 
                             yellowFrom = 5000, yellowTo = 25000,
                             redFrom = 0, redTo = 5000))
    
  })
}