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

#Una extraccion de la base donde se omiten los NA
egresados_sinna <- na.omit(egresados[,-4])

fechas_grado <- egresados_sinna$`Fecha De Grado`

#Extraer con expresiones regulares de una lista, value TRUE para obtener valores
Y <- grep(pattern="[A-z]",x=fechas_grado,value = TRUE)
#El argumento \\2 me dice que tome la segunda componente de la regEx
View(data.frame(fechas_grado ,
                day = gsub(pattern=".*(\\d{2} |,).*", x=fechas_grado, "\\1"),
                year = gsub(pattern= ".*(\\d{4}).*", x=fechas_grado, "\\1")
                )
     )
