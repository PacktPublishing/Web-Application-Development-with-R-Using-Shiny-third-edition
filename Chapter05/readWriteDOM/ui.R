
library(leaflet)

fluidPage(
  
  titlePanel("Gapminder"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("year",
                  "Years included",
                  min = 1952,
                  max = 2007,
                  value = c(1952, 2007),
                  sep = "",
                  step = 5
      ),
      
      checkboxInput("linear", label = "Add trend line?", value = FALSE),
      
      tags$input(type = "button",              
                 id = "append",                    
                 value = "Add current input values",
                 onClick = "buttonClick()"),
      
      includeHTML("appendText.js")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Summary", textOutput("summary"), p(id = "selection", "Values")),
        tabPanel("Trend", plotOutput("trend")),
        tabPanel("Map", leafletOutput("map"), 
                 p("Map data is from the most recent year in the selected range"))
      )
    )
  )
)
