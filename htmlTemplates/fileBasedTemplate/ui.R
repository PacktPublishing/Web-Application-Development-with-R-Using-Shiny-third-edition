htmlTemplate(
  "template.html",
  slider = sliderInput(inputId = "year",
                       label = "Years included",
                       min = 1952,
                       max = 2007,
                       value = c(1952, 2007),
                       sep = "",
                       step = 5),
  checkbox = checkboxInput("linear", label = "Add trend line?", value = FALSE),
  thePlot = plotOutput("trend")
)