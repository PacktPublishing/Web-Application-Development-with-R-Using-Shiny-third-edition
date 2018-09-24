
library(leaflet)
library(DT)

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
      
      conditionalPanel(
        condition = "input.theTabs == 'trend'",
        checkboxInput("linear", label = "Add trend line?", 
                      value = FALSE)
      ),
      
      uiOutput("yearSelectorUI"),
      
      actionButton("showModal", "Launch loyalty test")
    ),
    
    mainPanel(
      tabsetPanel(id = "theTabs",
                  tabPanel("Summary", textOutput("summary"), 
                           value = "summary"),
                  tabPanel("Trend", plotOutput("trend"),
                           value = "trend"),
                  tabPanel("Map", leafletOutput("map"),
                           value = "map"),
                  tabPanel("Table", dataTableOutput("countryTable"), 
                           value = "table")
      )
    )
  )
)
