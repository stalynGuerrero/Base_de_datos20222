#=========================================================================================================#
#                                  Universdiad El Bosque
#                                    Programación en R
#                             Práctica Sintaxis | 2022/10/07
#                                Profesor: Stalyn Guerrero
#                         Estudiante: Jaime Andrés Fierro Aponte                                 
#=========================================================================================================#


setwd('Practica/Jaime Fierro/')

# Paquetes ---------------------------------------------------------------
library(dplyr)
library(magrittr)
library(tidyr)

# Creación de objetos --------------------------------------------------------

a = c(1, 2, 3, 4)

b = matrix(NA, 4, 5)
b2 = data.frame(b)
b3 = tibble::tibble(b)
b4 = data.table::data.table(b)

l = list(b, b2, b3, b4, a)

ndim = array(data = NA, 
             c(4, 10, 2))
ndim[, , 1]

mean(x = ndim[, , 1], 
     na.rm = TRUE)


# Palabras reservadas -------------------------------------------------------
TRUE
FALSE
T
F
TRUE = 2

# Condicionales y uso de paréntesis -------------------------------------------

mean()


l[[2]][2, ]

if (TRUE) {
  
  print('1')
  
} else{
  
  if (FALSE) {
    
  }
  
} else{
  
} else{
  
}

ifelse(c(TRUE, FALSE, TRUE, TRUE), 
       yes = 1, 
       no = 0)

if (X == TRUE) {
  
  TRUE(X + 1)
  
}


# Funciones ---------------------------------------------------------

lm(formula = y ~ 1,
   data = d1,
   subset = d4)


pba_verdad = function(argumento1, argumento2) {
  # argumento1: debe ser tipo número.
  # argumento2: tipo carácter.
  if (argumento1 > 3 & argumento2 == 'A') {
    
    return('Verdadero')
    
  } else {
    
    return('Falso')
    
  }
}

# Pipelines -----------------------------------------------------------
iris %>%
  group_by(Species) %>%
  summarize_if(is.numeric, mean) %>%
  gather(measure, value, -Species) %>%
  arrange(desc(value))
