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
salud %>% str()
salud$HgDummy <- ifelse(salud$HgSangre >1, 1, 0)

salud %>% mutate(HgDummy2 =  ifelse(HgSangre >1, 1, 0))
set.seed(15102022)
aleatorio <- runif(n = nrow(salud), min = 0, max = 1) 

salud <- salud %>% mutate(sel = ifelse(aleatorio < .1, 1, 0)) 
salud %>% 
  mutate(sel2 = ifelse( runif(n = nrow(salud), min = 0, max = 1) < .1, 1, 0)) 

## case_when()

salud <-
  salud %>% mutate(
    HgRiesgo = case_when(HgSangre < 1 ~ "Bajo",
                         HgSangre < 2 ~ "Moderado",
                         TRUE ~ "Alto"),
    
    HgRiesgoC = case_when(
      between(HgCabello, 1, 2) ~ "Moderado",
      HgCabello < 1 ~ "Bajo",
      TRUE ~ "Alto"
    ),
    EdadCat = cut(Edad, seq(0, 70, by = 5)),
    Riesgo = 0.3 * HgSangre + HgCabello * 0.2 + 
             HgOrina * 0.1 + PdSangre * 0.4,
    MediaSagre  = mean(HgSangre),
    ejemplo = NULL
  )

salud %>%
  mutate_at(.vars = c("HgSangre",   "HgCabello",   "HgOrina",  "PdSangre"),
            function(x)ifelse(x >2.5, 1,0)
            )

salud %>%
  mutate_at(.vars = c("HgSangre",   "HgCabello",   "HgOrina",  "PdSangre"),
            function(x) {
              case_when(x < 1 ~ "Bajo",
                        x < 2 ~ "Moderado",
                        TRUE ~ "Alto")
            })


mutate()
mutate_all()
mutate_at()
mutate_if()

## familia transmute
transmute()
  salud %>% transmute(
    HgRiesgo = case_when(HgSangre < 1 ~ "Bajo",
                         HgSangre < 2 ~ "Moderado",
                         TRUE ~ "Alto"),
    
    HgRiesgoC = case_when(
      between(HgCabello, 1, 2) ~ "Moderado",
      HgCabello < 1 ~ "Bajo",
      TRUE ~ "Alto"
    ),
    EdadCat = cut(Edad, seq(0, 70, by = 5)),
    Riesgo = 0.3 * HgSangre + HgCabello * 0.2 + 
      HgOrina * 0.1 + PdSangre * 0.4,
    MediaSagre  = mean(HgSangre),
    ejemplo = NULL
  )

  bind_cols(
    salud,
    salud %>%
      transmute_at(.vars = c("HgSangre",   "HgCabello",   "HgOrina",  "PdSangre"),
                   function(x) {
                     case_when(x < 1 ~ "Bajo",
                               x < 2 ~ "Moderado",
                               TRUE ~ "Alto")
                   }) %>% select_all(function(x)
                     paste0(x, "Cat"))
  ) %>% View()
  

## familia summarise o summarize
  salud %>%  summarise(MediaSagre = mean(HgSangre), 
                       SdSagre = sd(HgSangre), 
                       MaxSagre = max(HgSangre))
  
salud %>% summarise_if(is.numeric, list(Media = mean, Sd = sd, Max = max)) 

quantile()


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







