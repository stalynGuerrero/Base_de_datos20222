library(shiny)

ui <- fluidPage(
  
  # Application title
  titlePanel("Mi primer Shiny"),
  ## Genéricas
  selectInput(inputId = "bygrup",
              label =  "Resultados agregados por:",
              choices = c("Departamento" = "Depto",
                          "Municipio" = "Mpio",
                          "Estrato", "Sexo"), 
              selected = "Depto" ),
  
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
              selected = "Cancer" ),
  ## Ingreso de valores 
  numericInput(inputId = "cota",
               label =  "Valor de referencia",
               value =  1),
  numericInput(inputId = "PI_prop",
               label =  "Valor para la PH",
               value =  1, min = 0, max = 1),    
  
  numericInput(inputId = "mu_cont",
               label =  "Valor para la PH",
               value =  1),    
  
  radioButtons(inputId = "var_PH",
              label =  "Variables PH:",
              choices = c("Mercurio en sangre" = "HgSangre",
                          "Mercurio en cabello" = "HgCabello",
                          "Mercurio en orina" = "HgOrina",
                          "Plomo en sangre" = "PdSangre"
                          ), 
              selected = "HgSangre" ),
  ## Salida de resultados 
  uiOutput("sub_grupos"),
  tableOutput("test_prop1"),
  tableOutput("test_cont"),
  dataTableOutput("Tabla_Cont"),
  dataTableOutput("Tabla_Cualita"),
  plotOutput("plot_cont"),
  plotOutput("plot_cuali")

  
)
