######################################################
## Introducción a Shiny
## Stalyn Guerrero
## Versión 1
## Fecha: 15/10/2022
######################################################

# librerias ---------------------------------------------------------------
library(openxlsx)
library(haven) # SPSS, Stata, SAS
library(data.table) # data.table::fread()
library(tidyverse)
library(DataExplorer)
# Lectura de base de datos ------------------------------------------------
salud <- openxlsx::read.xlsx(xlsxFile = "Data/Salud.xlsx")
## variable global. 

bygrup <- "Depto"

## Plot 
var_cont <- "HgOrina"

hist(salud[[var_cont]], probability = TRUE, xlab = var_cont,
     ylab = "", main = "Histograma", col = "blue")

var_cat <- "Sexo"
barplot(table(salud[[var_cat]]), xlab = var_cat,
     ylab = "", main = "Diagrama de barras", col = "blue")

## Descriptivas 

#Continuas 

salud %>% group_by_at(bygrup) %>%
  summarise_at(.vars = all_of(var_cont),
                       list(Media = mean, Sd = sd, Max = max))

#cualitativas 
salud %>% group_by_at(c(bygrup, var_cat)) %>% tally() %>%
  spread(data = ., key = var_cat, value = "n")

## Inferencias 
temp <- salud %>% filter(Sexo == "Mujer") %>% 
  group_by(Embarazada) %>% tally()

prop.test(x = as.numeric(temp[2,2]), 
          n = sum(temp$n), p = 0.02)

temp <- salud %>% filter(Sexo == "Mujer") %>% 
  group_by(Cancer) %>% tally()

prop.test(x = as.numeric(temp[2,2]), 
          n = sum(temp$n), p = 0.02)

###############################
cota <- 2
PI <- 0.02
var_PH <- "HgSangre"
cod_depto <- "01"

temp <- salud %>% filter(Depto == cod_depto) %>%
  mutate_at(.vars = all_of(var_PH),
            function(x)
              ifelse(x > cota, 1, 0)) %>%
  group_by_at(var_PH) %>% tally()

prop.test(x = as.numeric(temp[2,2]), 
          n = sum(temp$n), p = PI)

mu <- 3

t.test(x = salud[[var_PH]], mu = mu)














