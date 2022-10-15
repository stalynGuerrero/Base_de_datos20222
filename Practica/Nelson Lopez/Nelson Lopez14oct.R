#librerias

library(readxl)
Datos <- read_excel("Data/Datos de Egresados.xlsx", 
                    col_types = c("text", "text", "text", 
                                  "text", "text", "text", "text", "text"))

datos2 <- Datos[!is.na(Datos$`Fecha De Grado`),]

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


# familia mutate y transmutate --------------------------------------------

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


# Familis summarise o summarize -------------------------------------------

salud %>%  summarise(MediaSagre = mean(HgSangre), 
                     SdSagre = sd(HgSangre), 
                     MaxSagre = max(HgSangre))

salud %>% summarise_if(is.numeric, list(Media = mean, Sd = sd, Max = max))



# Construcción de Shiny ---------------------------------------------------


