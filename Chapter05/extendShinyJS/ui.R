
library(leaflet)
library(shinyjs)

fluidPage(
  
  titlePanel("Gapminder"),
  
  useShinyjs(),
  extendShinyjs(script = "appendText.js"),
  
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
      
      actionButton("buttonClick", "Add inputs"),
      
      selectInput("color", "Text colour", 
                  c("Red" = "red", 
                    "Blue" = "blue", 
                    "Black" = "black")),
      
      selectInput("size", "Text size",
                  c("Extremely small" = "xx-small", 
                    "Very small" = "x-small",
                    "Small" = "small", 
                    "Medium" = "medium", 
                    "Large" = "large", 
                    "Extra large" = "x-large", 
                    "Super size" = "xx-large")
      )
      
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Summary", textOutput("summary")),
        tabPanel("Trend", plotOutput("trend"),
                 h3("User selection history"),
                 p(id = "selection", "")),
        tabPanel("Map", leafletOutput("map"), 
                 p("Map data is from the most recent year in the selected range"))
      )
    )
  )
)
