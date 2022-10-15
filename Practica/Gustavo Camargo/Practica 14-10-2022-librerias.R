#==============================================================================#
#                                  Universdiad El Bosque
#                                    Programación en R
#                        Práctica Operadores Lógicos | 2022/10/14
#                                Profesor: Stalyn Guerrero
#                         Estudiante: Gustavo Andres Camargo Duque                                 
#==============================================================================#
#Librerias----------------------------------------------------------------------
library(openxlsx)
library(haven) #spss,stata,sas
library(data.table) #data.table::fread() lectura agil de archivos
library(tidyverse)

#dplyr
##Familia Select
select()
select_all()
select_at()
select_if()
##familia Filter
filter()
filter_all()
filter_at()
filter_if()
##Familia mutate crear columnas
mutate()
mutate_all()
mutate_at()
mutate_if()
##familia transmute
transmute()
##familia Dummarise o mummarize informes
summarise()
summarise_all()
summarise_at()
summarise_if()

##familia group_by
group_by()
group_by_all()
group_by_at()
group_by_if()
group_nest()  #trabajo en listas