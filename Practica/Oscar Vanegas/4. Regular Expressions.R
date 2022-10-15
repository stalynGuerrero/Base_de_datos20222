#=========================================================================================================#
#                                  Universdiad El Bosque
#                                    Programación en R
#                     Práctica Expresiones Regulares | 2022/10/14
#=========================================================================================================#

# Librerías ---------------------------------------------------------------
library(readxl)

setwd('Practica/Oscar Vanegas/')


#Declarando x como un texto
x <- c(
  "¿Con que frecuencia consumió Queso, kumis, yogurt, queso crema o suero costeño?",
  "Usualmente, en UN mes, ¿(...) consume:Granos secos (fríjol, arveja, garbanzo, lenteja, soya, habas)?",
  "16. ¿Con que frecuencia consumió Granos secos (fríjol, arveja, garbanzo, lenteja, soya, habas)?",
  "17. Usualmente, en UN mes, ¿(...) consume:Arroz o pasta?",
  "¿Con que frecuencia consumió Arroz o pasta?",
  "18. Usualmente, en UN mes, ¿(...) consume:Pan?"
)
# //D dígitos
# //d Todo lo que no sean dígitos
gsub(x= x, pattern = "\\d", replacement = "")

# //w Alfanumérico
# //W Todo lo que no sea alfanumérico
y <- gsub(x= x, pattern = "\\w", replacement = "")

#Importar una base de datos de egresados de la Universidad Santo Tomás
egresados <- read_excel("~/Desktop/Base_de_Datos_2022/Base_de_datos20222/Data/Datos de Egresados.xlsx", 
                           col_types = c("text", "text", "text", 
                                         "numeric", "text", "text", "text", 
                                         "text"))
unique(egresados$'Fecha De Grado')
sum(is.na(egresados$`Fecha De Grado`))

egresados_sinna <- na.omit(egresados[,-4])
