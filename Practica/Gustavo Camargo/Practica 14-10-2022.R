#==============================================================================#
#                                  Universdiad El Bosque
#                                    Programación en R
#                        Práctica Operadores Lógicos | 2022/10/14
#                                Profesor: Stalyn Guerrero
#                         Estudiante: Gustavo Andres Camargo Duque                                 
#==============================================================================#
#Librerias----------------------------------------------------------------------
library(readxl)
Datos <- read_excel("Data/Datos de Egresados.xlsx")
col_types = c("text", "text", "text", 
              "text", "text", "text", "text", "text")
View(Datos)

#Operatorias--------------------------------------------------------------------


sum(is.na(Datos$`Fecha De Grado`))                 #limpiar caracteres en blanco
table(is.na(Datos$`Fecha De Grado`))               #cantidad de vacios
filas<-(apply(Datos[,-4],MARGIN = 1,       
              function(x){anyNA(x)}))
Datos2<-Datos[filas,]
x2<-Datos2$`Fecha De Grado`
grepl ( pattern = "[A-z]",x = x2)                 #retorna true o false
grep  ( pattern = "[A-z]", x = x2,value = TRUE)   #retorna caractares
grep  ( pattern = "\\d{4}",x = x2,value = TRUE)   #busca los que tenga 4 digitos
x3<- grep ( pattern = "\\d{4}", x = x2,value = TRUE)
#gsub(pattern = ".*\\d{4}.*",x=x3,"\\1")           #donde hay exactamente 4
                                                  # digitos y los rescata
View(data.frame(x3,
           dia = gsub(pattern = ".*(\\d{,2} |, | \\d{,1} ).*",x =x3,"\\1"),    
           año = gsub(pattern = ".*(\\d{,4}).*",x =x3,"\\1")))
unique(Datos$`Fecha De Grado`)