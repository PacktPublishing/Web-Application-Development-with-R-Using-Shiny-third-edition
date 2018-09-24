
library(leaflet)

fluidPage(
  
  titlePanel("Gapminder"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "year",
                  label = "Years included",
                  min = 1952,
                  max = 2007,
                  value = c(1952, 2007),
                  sep = "",
                  step = 5
      ),
      
      checkboxInput("linear", label = "Add trend line?", value = FALSE)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Summary", textOutput("summary")),
        tabPanel("Trend", plotOutput("trend")),
        tabPanel("Map", leafletOutput("map"), 
                 p("Map data is from the most recent year in the selected range; 
                     radius of circles is scaled to life expectancy"))
      )
    )
  )
)
