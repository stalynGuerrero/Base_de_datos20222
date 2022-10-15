######################################################
## Introducción a tidyverse.
## Stalyn Guerrero
## Versión 1
## Fecha: 14/10/2022
######################################################

# librerias ---------------------------------------------------------------
library(openxlsx)
library(haven) # SPSS, Stata, SAS
library(data.table) # data.table::fread()
library(tidyverse)
library(DataExplorer)

# Lectura de base de datos ------------------------------------------------
salud <- openxlsx::read.xlsx(xlsxFile = "Data/Salud.xlsx")
str(salud)
summary(salud)
DataExplorer::plot_str(salud)
plot_missing(salud)
plot_intro(salud)
plot_histogram(salud)
plot_bar(salud)

#DataExplorer::create_report()

# dplyr -------------------------------------------------------------------

## familia select
salud %>% select(Edad) %>% head()
salud %>% select(Edad:Ocupado) %>% head()
salud %>% select(-(Edad:Ocupado)) %>% head()
salud %>% select("Edad") %>% head()
salud %>% select(matches("e")) %>% head()
salud %>% select(matches("^e")) %>% head()
salud %>% select(starts_with("e")) %>% head()
salud %>% select(ends_with("d")) %>% head()

salud %>% select_all(toupper) %>% head()
salud %>% select_all(function(x){paste0(toupper(x),"_")}) %>% head()

salud %>%
  select_at(.vars = c( "Nd" ,  "Sexo", "Edad", "Cancer", "Embarazada"),
            toupper) %>% head()

salud %>%
  select_at(.vars = c( "Nd" ,  "Sexo", "Edad", "Cancer", "Embarazada"),
            function(x){paste0(toupper(x),"_")}) %>% head()
salud %>%
  select_at(.vars = vars(matches("e")),
            function(x){paste0(toupper(x),"_")}) %>% head()


salud %>%
  select_if(is.numeric,
            function(x){paste0(toupper(x),"_")}) %>% head()

salud %>%
  select_if(is.character,
            function(x){paste0(toupper(x),"_")}) %>% head()


## familia filter
salud %>% filter(Depto == "04") %>% head()
salud %>% filter(Depto == "04", Sexo == "Mujer") %>% head()
salud %>% filter(Depto == "04", Sexo == "Mujer", 
                 Edad >= 18 & Edad <= 30) %>% head()

salud %>% filter(grepl(pattern = "057", x = Mpio)) %>% head()
salud %>% filter(grepl(pattern = "4$", x = Mpio)) %>% head()
salud %>% filter(is.na(Ocupado) & Embarazada == 1) %>% head()


salud %>% select(HgSangre:PdSangre) %>%
  filter_all(all_vars(. > 1))

salud %>% select(HgSangre:PdSangre) %>%
  filter_all(any_vars(. > 3.5))

salud %>% filter_at(.vars = c("HgSangre", "HgCabello",
                              "HgOrina", "PdSangre"),
                    any_vars(. > 4.5))  

# filter_if(is.numeric, )


## familia mutate
mutate()
mutate_all()
mutate_at()
mutate_if()

## familia transmute
transmute()

## familia summarise o summarize
summarise()
summarise_at()
summarise_all()
summarise_if()

## familia group_by
group_by()
group_by_all()
group_by_at()
group_by_if()

## familia group_nest
group_nest()







