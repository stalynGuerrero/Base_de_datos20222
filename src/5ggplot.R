######################################################
## Introducción a ggplot
## Stalyn Guerrero
## Versión 1
## Fecha: 15/10/2022
######################################################

# librerias ---------------------------------------------------------------
library(openxlsx)
library(haven) # SPSS, Stata, SAS
library(data.table) # data.table::fread()
library(tidyverse)
library(ggthemes)
library(DataExplorer)
library(plotly)
# Lectura de base de datos ------------------------------------------------
salud <- openxlsx::read.xlsx(xlsxFile = "Data/Salud.xlsx")

var_cont <- "HgSangre"
## Histograma
p1 <- ggplot(data = salud, aes_string(x = var_cont)) + 
  geom_histogram(aes(y = ..density..), bins = 20, 
                 fill = "#61A7F5", color = 1) + 
  labs(y = "", title = "Histograma") + 
  theme_light(base_size = 20) +
  theme(plot.title = element_text(hjust = 0.5))

ggplotly(p1)

## Densidad  
ggplot(data = salud, aes_string(x = var_cont)) + 
  geom_density( fill = "#61A7F5", color = 1, alpha = 0.5) + 
  labs(y = "", title = "Densidad") + 
  theme_light(base_size = 20) +
  theme(plot.title = element_text(hjust = 0.5))

## Boxplot  
ggplot(data = salud, aes_string(y = var_cont)) + 
  geom_boxplot( fill = "#61A7F5", color = 1, alpha = 0.5) + 
  labs(y = "", title = "Boxplot") + 
  theme_light(base_size = 20) +
  theme(plot.title = element_text(hjust = 0.5))


## Diagrama de barras  
var_cat <- "Ocupado"
ggplot(data = salud, aes_string(x = var_cat)) +
  geom_bar(
    aes(y = ..count.. / sum(..count..)),
    fill = "#61A7F5",
    color = 1,
    alpha = 0.5
  ) +
  labs(y = "", title = "Diagrama de barras") +
  theme_light(base_size = 20) +
  geom_text(aes(label = scales::percent(..count.. / sum(..count..)),
               y = ..count.. / sum(..count..)),
           stat = "count",
           vjust = -.5) +
theme(plot.title = element_text(hjust = 0.5)) + 
  ylim(0, 0.50) 


