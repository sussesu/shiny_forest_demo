library(shiny)

# Define UI for application that plots random distributions 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Luo oma metsäsi!"),
  helpText("Määritä puiden koko ja määrä."),
  
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    sliderInput("mu", 
                "Keskiarvo:", 
                min = 1,
                max = 50, 
                value = 30),
    # helpText("Määrittää puiden kokojakauman keskiarvon."),
    sliderInput("sigma", 
                "Keskihajonta:", 
                min = 1,
                max = 15, 
                value = 5),
    # helpText("Määrittää kokojakauman keskihajonnan."),
    
    sliderInput("obs", 
                "Puiden määrä (kpl/ha):", 
                min = 1,
                max = 1000, 
                value = 500),
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    h3("1. Puiden kokojakauma"),
    plotOutput("distPlot", width="50%", height="200px"),
    h3("2. Metsä ylhäältä katsottuna"),
    plotOutput("mapPlot")
  )
))