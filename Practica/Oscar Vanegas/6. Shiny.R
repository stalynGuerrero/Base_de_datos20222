#=========================================================================================================#
#                                  Universdiad El Bosque
#                                    Programación en R
#                     Práctica Expresiones Regulares | 2022/10/14
#=========================================================================================================#

# Librerías ---------------------------------------------------------------
library(openxlsx)
library(haven)
library(data.table)
library(tidyverse)
library(DataExplorer)
library(readxl)

setwd('Practica/Oscar Vanegas/')

# Importar base -----------------------------------------------------------
salud <- read_excel("Salud.xlsx")
View(dataset)


# Objetos para Shiny ------------------------------------------------------
##Plot
#Un histograma para las frecuencias de variables contínuas, él hace los intervalos
var_cont <- "HgOrina"
hist(salud[[var_cont]], probability = TRUE, xlab = var_cont,
     ylab = "", main= "Histograma", col="blue" )

#Un histograma para las frecuencias de variables contínuas, él hace los intervalos
var_cat <- "Sexo"
barplot(table(salud[[var_cont]]), xlab = var_cont,
     ylab = "", main= "Bar plot", col="blue" )

##Descriptivas
#Continuas
bygroup = "Mpio"
salud %>% group_by_at(bygroup) %>%
  summarise_at(.vars = all_of(var_cont),
               list(Media = mean, SD = sd, Max = max))
#Discretas
bygroup = "Mpio"
salud %>% group_by_at(c(bygroup, var_cat)) %>% tally() %>%
  spread(data = ., key = var_cat, value= "n")