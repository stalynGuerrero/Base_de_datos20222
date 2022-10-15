# Operadores lógicos  ---------------------------------------------------------

a <- 1:15
b <- seq(1, 30, by = 2)


# Operadores de relación --------------------------------------------------

a < b
a > b
a == b
a != b
a == a
a <= b


# Coincidencia de valores -------------------------------------------------
a[a %in% b] #Elementos de a en b

#Complementos
all() #Todos los elementos son TRUE
any() #Algún elemento (al menos uno) es TRUE
all.equal() #Dos objetos casi iguales, flexibilidad en la comparación


# Estructuras de control --------------------------------------------------


apply(X = iris[,-5], MARGIN=1, FUN = function(x){
  sum(x<1.5)
})

apply(X = iris[,-5], MARGIN=1, FUN = function(x){
  max(x)
})

apply(X = iris[,-5], MARGIN=1, FUN = function(x){
  c(Max = max(x), mean = mean(x), min=min(x))
})

apply(X = iris[2], MARGIN=2, FUN = function(x){
  c(min=min(x),mean=mean(x),q1=quantile(x,probs = 0.25),q3=quantile(x,probs = 0.75))
})
