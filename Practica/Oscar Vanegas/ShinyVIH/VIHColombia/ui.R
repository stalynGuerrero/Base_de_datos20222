## ui.R ##
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "VIH Colombia 2020"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Mapas", tabName = "maps", icon = icon("map")),
      menuItem("Histogramas", tabName = "hist", icon = icon("th")),
      menuItem("Semanas", tabName = "weeks", icon = icon("calendar"))
      
    )
  ),
  
  
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(plotOutput("plot1", height = 250)),
      
      box(
        title = "Controls",
        sliderInput("slider", "Number of observations:", 1, 100, 50)
      )
    )
  )
)