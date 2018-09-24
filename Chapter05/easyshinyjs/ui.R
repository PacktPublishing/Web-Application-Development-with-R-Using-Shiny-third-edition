
library(leaflet)
library(shinyjs)

fluidPage(
  tags$head(
    tags$style(HTML(".redText {
                      color: red;
                    }"
    ))
  ),
  
  useShinyjs(),
  
  titlePanel("Gapminder"),
  
  sidebarLayout(
    sidebarPanel(
      
      div(id = "yearPanel", 
          sliderInput("year",
                      "Years included",
                      min = 1952,
                      max = 2007,
                      value = c(1952, 2007),
                      sep = "",
                      step = 5
          )
      ),
      
      checkboxInput("linear", label = "Add trend line?", value = FALSE),
      checkboxInput("redText", "Red text?"),
      actionButton("reset", "Reset year")
      
    ),
    
    mainPanel(
      tabsetPanel(id = "theTabs",
                  tabPanel("Summary", value = "text", div(id = "theText", textOutput("summary"))),
                  tabPanel("Trend", value = "graph", plotOutput("trend"),
                           p(id = "controlList", style = "font-size: 24px")),
                  tabPanel("Map", value = "map", leafletOutput("map"), 
                           p("Map data is from the most recent year in the selected range"))
      )
    )
  )
)
