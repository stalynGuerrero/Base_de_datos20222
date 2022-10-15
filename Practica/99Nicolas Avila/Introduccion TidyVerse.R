#Librerias
library(dplyr)
library(magrittr)
library(stringr)
library(forcats)
library(readxl)
library(ggplot2)
library(DataExplorer)

##DPlyr-------------------------------------------------

##Familia select

select()
select_all()
select_at()
select_if()

##Familia filter

filter()
filter_all()
filter_at()
filter_if()

##Mutate

mutate()
mutate_all()
mutate_at()
mutate_if()

##familia trnasmutar

transmute()
transmute_all()
transmute_at()
transmute_if()

##Familia summarize

summarise()
summarise_all()
summarise_at()
summarise_if()

##Familia group by

group_by()
group_by_all()
group_by_at()
group_by_if()

group_nest()

##EJERCICIO--------------------------------------------
##Lectura
Data<-read_excel("Salud.xlsx")

##Resuemn d elos datos
str(Data)
summary(Data)
DataExplorer::plot_bar(Data)
plot_missing(Data)
plot_intro(Data)

##sleccionar variables
Data %>% select(Edad) %>% head()
