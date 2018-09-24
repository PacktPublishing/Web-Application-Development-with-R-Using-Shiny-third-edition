
library(shinydashboard)
library(leaflet)

header <- dashboardHeader(title = "Gapminder",
                          dropdownMenuOutput("notifications"))

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", 
             icon = icon("dashboard")),
    
    menuItem("Map", icon = icon("globe"), tabName = "map",
             badgeLabel = "beta", badgeColor = "red"),
    
    sliderInput("year",
                "Years included",
                min = 1952,
                max = 2007,
                value = c(1952, 2007),
                sep = "",
                step = 5
    ),
    
    selectInput("continent", "Select continent", 
                choices = c("Africa", "Americas", "Asia", 
                            "Europe", "Oceania"))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "dashboard",
            fluidRow(
              infoBoxOutput(width = 3, "infoYears"),
              infoBoxOutput(width = 3, "infoLifeExp"),
              infoBoxOutput(width = 3, "infoGdpPercap"),
              infoBox(width = 3, "Shiny version", "1.1.0",
                      icon = icon("desktop"))),
            fluidRow(
              box(width = 10, plotOutput("trend"),
                  checkboxInput("linear", 
                                label = "Add trend line?", 
                                value = FALSE)),
              box(width = 2, htmlOutput("gauge"))
            )
    ),
    
    tabItem(tabName = "map",
            box(width = 12, leafletOutput("map"),
                p("Map data is from the most recent year in the selected range"))
    )
  )
)

dashboardPage(header, sidebar, body)
