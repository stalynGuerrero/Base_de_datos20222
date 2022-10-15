######################################################
## Introducción a tidyverse.
## Stalyn Guerrero
## Versión 1
## Fecha: 14/10/2022
######################################################

# librerias ---------------------------------------------------------------
install.packages("tidyverse")
library(openxlsx)
library(haven) # SPSS, Stata, SAS
library(data.table) # data.table::fread()
library(tidyverse)
library(DataExplorer)
r
# lectura base de datos
library(readxl)
Salud <- read_excel("Data/Salud.xlsx")

## variable global para agrupamientos
bygrup <- "Depto"

#Plot
var_cont <- "Edad"
hist(salud[[var_cont]],probability = TRUE, xlab = "var_cont",
     ylab = "", main = "Histograma", col = "blue")



#Descriptivas
## continuas

salud %>% group_by_at(bygrup) %>%
  summarise_at((.vars = all_of(var_cont),
                list(Media = mean, Sd = sd, Max = max ))

#cualitativas
salud %>% group_by_at(c(bygrup, var_cat)) %>% tally() %>%
    spread(data = . , key = var_cat, value = "n")


## inferencias
Salud %>% 

t.tes(x=Salud$Embarazada, mu= 0.02)
prop.test((x = , n = , p =))



