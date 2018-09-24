fluidPage( # flexible layout function
  
  h4(HTML("Think of a number:</br>Does Shiny or JavaScript rule?")),
  
  sidebarLayout(
    sidebarPanel( # sidebar configuration
      sliderInput("pickNumber", "Pick a number",
                  min = 1, max = 10, value = 5),
      tags$div(id = "output") # tags$XX for holding dropdown
    ),
    
    mainPanel(
      textOutput("randomNumber"),
      hr(),
      textOutput("theMessage"),
      includeHTML("dropdownDepend.js") # include JS file
    )
  )
)