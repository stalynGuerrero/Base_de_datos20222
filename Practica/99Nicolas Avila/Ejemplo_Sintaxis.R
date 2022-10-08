#############################################
##Ejempo de funciones y nombres de archivos
##Nicolás Ávila
##Versión 1
##Fecha: 07/10/2022
#############################################

##Librerias------------------------------------------------
 a<-1 ##Objeto
class(a) ##Tipo de objeto

a<-matrix(NA,1,1)
class(a)

??filter ##Busca información sobre una función y dónde encontrarla

b<-data.frame ##DataFrame
c<-tibble::tibble(a) ##Tibble
d<-data.table::data.table(a)
e<-list(a,b,c,d) ##Lista

##Palabra reservada----------------------------------------

TRUE
FALSE
T
F
TRUE<-2
if(X==TRUE){
  TRUE(x-1)
}

##Condicionales uso de aprentesis--------
##PAra un elemento
if(TRUE){ ##Función para una sola condición
  x=1
}

ifelse(c(TRUE, TRUE, FALSE, TRUE), yes=1, no=0) ##Función para más de una función


##Pipeline--------------------------------------------------

F(g(h()))

x %>% h() %>% g() %>% f()
X %<>% h()
