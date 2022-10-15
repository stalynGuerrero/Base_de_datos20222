library(shiny)

ui <- fluidPage(
  
  # Application title
  titlePanel("Mi primer Shiny"),
  
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
              selected = "Cancer" )
    
  
)
