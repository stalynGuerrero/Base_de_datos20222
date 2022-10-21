#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

      library(readxl)
      # generate bins based on input$bins from ui.R
      x <- na.omit(VIH['EDAD'])
      x <- gsub(",", "", x)   # remove comma
      x <- as.numeric(x) 

      histogram(x)
      # draw the histogram with the specified number of bins
        

    })

})
