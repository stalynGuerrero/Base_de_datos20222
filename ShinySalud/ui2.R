library(shinydashboard)
library(shiny)


ui <- dashboardPage(
  dashboardHeader(title = "Mi primer Shiny"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Gráficas", tabName = "grafica"),
      menuItem("Descriptivos", tabName = "descrip"),
      menuItem("Pruebas de hiótesis", tabName = "PHs")
    )
    
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "grafica",
              fluidRow(    
                column(width = 4,
                       selectInput(inputId = "var_cont",
                          label =  "Variables cuantitativas:",
                          choices = c("Mercurio en sangre" = "HgSangre",
                                      "Mercurio en cabello" = "HgCabello",
                                      "Mercurio en orina" = "HgOrina",
                                      "Plomo en sangre" = "PdSangre",
                                      "Edad"), 
                          selected = "HgSangre" ),
              
              selectInput(inputId = "var_cat",
                          label =  "Variables cualitativa:",
                          choices = c("Cancer" = "Cancer",
                                      "Embarazada",
                                      "Ocupado"), 
                          selected = "Cancer" )),
              column(4,           
              (plotOutput("plot_cont"))), 
              column(4,           
                    (plotOutput("plot_cuali")) )
              )
      ),
      
      
      tabItem(tabName = "descrip",
              h2("descrip")
      ),
      tabItem(tabName = "PHs",
              h2("PHs")
      )
    )
    
  )
)
