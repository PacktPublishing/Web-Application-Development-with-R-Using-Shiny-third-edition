
fluidPage(
  
  title = "Gapminder",
  
  h2("Gapminder explorer",
     style = "font-family: 'Impact'; color: purple; font-size: 32px;"),
  
  fluidRow(
    column(6,
           wellPanel(
             sliderInput("year",
                         "Years included",
                         min = 1952,
                         max = 2007,
                         value = c(1952, 2007),
                         sep = "",
                         step = 5
             ))
    ),
    column(6,
           p("Map data is from the most recent year in the selected range",
             style = "text-align: center;"))
  ),
  
  hr(),
  
  fluidRow(
    
    column(6, plotOutput("trend")),
    column(6, leafletOutput("map"))
  ),
  
  fluidRow(
    column(6, 
           checkboxInput("linear", label = "Add trend line?", 
                         value = FALSE),
           textOutput("summary")
    )
  )
)