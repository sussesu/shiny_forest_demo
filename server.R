library(shiny)
library(ggplot2)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  
  # Expression that generates a plot of the distribution. The expression
  # is wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically 
  #     re-executed when inputs change
  #  2) Its output type is a plot 
  #

  
  output$distPlot <- renderPlot({
    # generate a normal distribution and plot it
    cm_range <- seq(1,60,.1)
    d_density <- data.frame(cm = cm_range,
                            density = dnorm(cm_range, 
                                            mean = input$mu, 
                                            sd = input$sigma))
    
    ggplot(d_density, aes(cm_range, density)) +
      geom_line() +
      # ggtitle("1. Puiden kokojakauma") +
      xlab("Rungon läpimitta (cm)") + ylab("Density")

  })
  output$mapPlot <- renderPlot({
    
    # generate tree locations and plot with diameter
    d_density <- dnorm(1:60, mean = input$mu, sd = input$sigma)
    metsa <- data.frame(x = runif(input$obs, min=0, max=100),
                        y = runif(input$obs, min=0, max=100),
                        dbh = sample(1:60, size=input$obs, 
                                     prob = d_density, replace=TRUE))# rnorm(input$obs, mean = input$mu, sd = input$sigma))
    ggplot(metsa, aes(x, y, size=dbh)) + 
      geom_point(col="green", alpha=.6) +
      geom_point(col=1, shape=1) +
      scale_radius(range=c(.1, 8), limits=c(1,60)) +
      # ggtitle("2. Metsä lintuperspektiivistä") +
      guides(size=guide_legend(title="Läpimitta\n(cm)")) +
      coord_fixed() +
      ylim(0,100) + xlim(0,100) +
      theme(legend.position = "right",
            panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank(),
            axis.title = element_blank())
  })
})