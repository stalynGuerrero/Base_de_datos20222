######################################################
## Ejemplo de Expresiones regulares.
## Stalyn Guerrero
## Versión 1
## Fecha: 14/10/2022
######################################################

# Librerias 
library(readxl)

# Declarando x

x <- c(
  "¿Con que frecuencia consumió Queso, kumis, yogurt, queso crema o suero costeño?",
  "Usualmente, en UN mes, ¿(...) consume:Granos secos (fríjol, arveja, garbanzo, lenteja, soya, habas)?",
  "16. ¿Con que frecuencia consumió Granos secos (fríjol, arveja, garbanzo, lenteja, soya, habas)?",
  "17. Usualmente, en UN mes, ¿(...) consume:Arroz o pasta?",
  "¿Con que frecuencia consumió Arroz o pasta?",
  "18. Usualmente, en UN mes, ¿(...) consume:Pan?"
)

gsub(x =  x, pattern =  "\\D", replacement = "" )
gsub(x =  x, pattern =  "\\d", replacement = "" )
gsub(x =  x, pattern =  "\\W", replacement = "" )
gsub(x =  x, pattern =  "\\w", replacement = "" )



Datos <- read_excel("Data/Datos de Egresados.xlsx", 
                    col_types = c("text", "text", "text", 
                                  "text", "text", "text", "text", "text"))

filas <- apply(Datos[,-4], MARGIN = 1, function(x){ !anyNA(x) })

Datos2 <- Datos[filas,]

x2 <- Datos2$`Fecha De Grado`

grepl(pattern = "[A-z]", x = x2)
x3 <- grep(pattern = "[A-z]", x = x2, value = TRUE)


View(data.frame(x3,
           dia = gsub(pattern = ".*(\\d{2} |,).*", x = x3, "\\1"),
           año = gsub(pattern = ".*(\\d{4}).*", x = x3, "\\1")) )




