fluidPage(
  
  titlePanel("Widget values and data types"), 
  
  sidebarLayout(

    sidebarPanel(
      
      checkboxGroupInput(inputId = "checkGroup",
                         label = "1. checkboxGroupInput",
                         choices = list("Ice cream" = "IC", "Trifle" = "Trifle",
                                        "Pistachios" = "Pist")),
      
      checkboxInput(inputId = "boxInput",
                    label = "2. checkboxInput"),
      
      dateInput(inputId = "theDate",
                label = "3. dateInput"),
      
      dateRangeInput(inputId = "dateRange",
                     label = "4. dateRangeInput"),
      
      numericInput(inputId = "pickNumber",
                   label = "5. numericInput",
                   min = 1, max = 10, value = 1),
      
      radioButtons(inputId = "pickRadio",
                   label = "6. radioButtons",
                   choices = list("Taxi" = "Taxi", "Take a walk" = "Walk")),
      
      selectInput(inputId = "comboBox",
                  label = "7. selectInput",
                  choices = list("News" = "News", "Situation comedy" = "Sitcom", "Film" = "Film")),
      
      sliderInput(inputId = "slider",
                  label = "8. sliderInput",
                  min = 1, max = 10, value = 7, step = 1),
      
      textInput(inputId = "comment",
                label = "9. textInput",
                value = "")
      
    ),
    
    mainPanel( 
      h3("Output and data type"),
      tableOutput("textDisplay")
    )
  )
)