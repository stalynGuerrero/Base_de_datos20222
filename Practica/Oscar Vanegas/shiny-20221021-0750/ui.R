######################################################
## Dashboard de la vigilancia en salud publica del VIH/Sida en Colombia 2020 
## Shiny VIH-2020
## Oscar Vanegas, Diana Parra, Nelson Lopez, Mario Benedetti, Luis Acuna 
## Version 1
## Fecha: 22/10/2022
######################################################

## ui.R ##
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "VIH Colombia 2020"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Gráficos descriptivos", tabName = "hist", icon = icon("chart-simple")),
      menuItem("Medidas descriptivas", tabName = "descriptivos", icon = icon("table")),
      menuItem("Mapas", tabName = "maps", icon = icon("map")),
      menuItem("Inferencia", tabName = "pruebaHipotesis", icon = icon("table")),
      menuItem("Comportamiento semanal", tabName = "weeks", icon = icon("chart-simple"))
    )
  ),
  
  dashboardBody(
    tabItems(
    
      # Pestaña de estadísticos descriptivos
      tabItem(tabName = "hist",
              h1("Estadística descriptiva"),
              fluidRow(
                box(title="Distribución por edad de las personas notificadas en el departamento",
                    h3(textOutput("departamento_elegido")),
                    status = "primary",
                    solidHeader = TRUE,
                    plotlyOutput("histograma1", height = 500),
                    width= 8
                ),
                valueBoxOutput(
                  "conteocasos1",
                  width=2
                ),
                valueBoxOutput(
                  "conteocasos2",
                  width=2
                ),
                box(
                  title = "Departamento de ocurrencia",
                  status = "warning",
                  solidHeader = TRUE,
                  width = 4,
                  selectInput(inputId = "Depto",
                              label =  "Seleccione un departamento:",
                              choices = unique(BaseVIH$Departamento_ocurrencia), 
                              selected = "BOGOTA"
                  )
                ),
                box(title="Distribución por género de los casos en el departamento",
                    solidHeader = TRUE,
                    status= "primary",
                    plotlyOutput("piechart1", height = 240),
                    width= 4
                )
              )
      ),
      
      # Pestaña de medidas de tendencia y boxplot
      tabItem(tabName = "descriptivos",
              h1("Medidas de tendencia y dispersión"),
              fluidRow(
                box(
                  title= "Tendencia y dispersión de la variable: Días entre los síntomas y la consulta",
                  solidHeader = TRUE,
                  status = "primary",
                  dataTableOutput("tabla1"),
                  width = 9
                ),
                box(
                  title = "Selección de filtros",
                  solidHeader = TRUE,
                  status = "warning",
                  selectInput(inputId = "agrupar_descriptivo",
                              label =  "Mostrar las estadísticas descriptivas según:",
                              choices = c("Régimen de seguridad social" = "TIPO_SS",
                                          "Nacionalidad" = "NACIONALIDAD2",
                                          "Estrato"= "ESTRATO",
                                          "Pertenencia étnica" = "PERTENENCIA_ETNICA",
                                          "Sexo" = "SEXO"), 
                              selected = "NACIONALIDAD2"
                  ),
                  selectInput(inputId = "depto2",
                              label =  "Departamento de residencia:",
                              choices = unique(BaseVIH$Departamento_residencia), 
                              selected = "BOGOTA"
                  ),
                  width = 3
                ),
                valueBoxOutput(
                  "promediodias",
                  width = 3
                ),
                box(
                  title= "Boxplot para la variable: Días entre los síntomas y la consulta",
                  solidHeader = TRUE,
                  status = "primary",
                  plotOutput(
                    "boxplot1", height = 220
                  ),
                  width= 12
                )
              )
      ),
      
      # Pestaña del mapa
      tabItem(tabName = "maps",
              h1("Mapas de calor para dos variables"),
              box(
                title="Selección de filtro",
                solidHeader = TRUE,
                status = "warning",
                radioButtons(inputId = "genero",
                             label =  "Colorear mapa para el género:",
                             choices = c("Hombres" = "F",
                                         "Mujeres" = "M",
                                         "Ambos" = ""), 
                             selected = ""
                ),
                width = 12
              ),
              fluidRow(
                box(
                  title = "Promedio de la edad por departamento",
                  solidHeader = TRUE,
                  status = "primary",
                  plotOutput("mapa1", width="100%"),
                  width = 6,
                  height = 450
                ),
                box(
                  title = "Mediana de los días entre síntomas y consulta por departamento",
                  solidHeader = TRUE,
                  status = "primary",
                  plotOutput("mapa2", width="100%"),
                  width = 6,
                  height = 450
                )
              ),
      ),
      
      # Pestaña de inferencia y pruebas de hipótesis
      tabItem(tabName = "pruebaHipotesis",
              fluidRow(
                tabBox(
                  width = 9,
                  title = "Pruebas de hipótesis",
                  id = "tabset1", height = "250px",
                  tabPanel("Proporción",
                           h3("Proporción de género en colombianos"),
                           h4("Hipótesis nula: No existe diferencia entre la proporción de hombres y mujeres notificadas con VIH"), 
                           h4("Hipótesis alterna: La proporción de hombres es mayor a la proporción de mujeres notificadas con VIH"), 
                           br(),
                           tableOutput("tablahipotesis1"),
                  ),
                  tabPanel("Medias",
                           h3("Media de diferencia de dias por género"),
                           h4("Hipótesis nula: No existe diferencia entre el promedio de dias del inicio de sintomas y consulta de hombres y mujeres notificados con VIH"), 
                           h4("Hipótesis alterna: Existe diferencia entre el promedio de dias del inicio de sintomas y consulta de hombres y mujeres notificados con VIH"), 
                           br(),
                           tableOutput("tablahipotesis2"),)
                ),
                box(
                  title = "Selección de parámetros",
                  solidHeader = TRUE,
                  status = "warning",
                  selectInput(inputId = "conf_level",
                              label =  "Elija un nivel de confianza para la prueba:",
                              choices = c("90%" = 0.9,
                                          "95%" = 0.95,
                                          "99%"= 0.99,
                                          "99.9%" = 0.999), 
                              selected = 0.95
                  ),
                  selectInput(inputId = "depto3",
                              label =  "Departamento de residencia:",
                              choices = unique(BaseVIH$Departamento_residencia), 
                              selected = "BOGOTA"
                  ),
                  width = 3
                )
              )
      ),
      
      tabItem(tabName = "weeks",
              h1("Comportamiento semanal"),
              fluidRow(
                box(title="Conteo de casos por semana, total nacional, departamental y hombres",
                    status = "primary",
                    solidHeader = TRUE,
                    plotlyOutput("linea1"),
                    width= 9
                ),
                box(
                  title = "Departamento de residencia",
                  status = "warning",
                  solidHeader = TRUE,
                  width = 3,
                  selectInput(inputId = "Depto4",
                              label =  "Seleccione un departamento:",
                              choices = unique(BaseVIH$Departamento_residencia), 
                              selected = "BOGOTA"
                  )
                )
              )
      )
      
    )
  )
)
