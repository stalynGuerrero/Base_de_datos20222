#    http://shiny.rstudio.com/
library(shiny)

# Definir UI
shinyUI(fluidPage(

    # Titulo de la aplicación
    titlePanel("VIH en Colombia 2020"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            selectInput(inputId = "bygroup",
                        label = "Departamento",
                        choices= c("Departamento" = "Depto",
                                   "Municipio" = "Mpio",
                                   "Estrato",
                                   "Sexo"),
                        )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
