
library(shinythemes)

fluidPage(theme = shinytheme("journal"),
          themeSelector(),
          titlePanel("Gapminder"),
          
          sidebarLayout(
            sidebarPanel(
              sliderInput("year",
                          "Years included",
                          min = 1952,
                          max = 2007,
                          value = c(1952, 2007),
                          sep = ""
              ),
              
              icon("linux", class = "fa-spin fa-3x"),
              
              checkboxInput("linear", label = "Add trend line?", value = FALSE)
            ),
            
            mainPanel(
              tabsetPanel(
                tabPanel("Summary", textOutput("summary"),
                         icon = icon("user", lib = "glyphicon")),
                tabPanel("Trend", plotOutput("trend"), icon = icon("calendar"))
              )
            )
          )
)
