#############################################
# Stalyn Guerrero
# Versión 0.0.1
# Curso de bases de datos
# 2022-1
# Manejo de las estructuras de control.
#############################################
# Librerias

# Leer bases de datos.


# Control con if ----------------------------------------------------------
set.seed(1234)
muestra <- sample(1:100, size = 1, replace = TRUE)

if (muestra %% 2 != 0 & muestra %% 3 != 0 &
  muestra %% 5 != 0 & muestra %% 7 != 0) {
  cat("Primo =", muestra, "\n")
} else if (muestra %in% c(2, 3, 5, 7)) {
  cat("Primo =", muestra, "\n")
} else {
  cat("No primo =", muestra, "\n")
}

set.seed(1234)
muestra <- sample(1:100, size = 10, replace = TRUE)

table(ifelse(
  test = muestra %% 2 == 0,
  yes = "Par",
  no = "Impar"
))


FALSE %in% (muestra %% 2 == 0)
sum((muestra %% 2 == 0)) == 0
any(muestra %% 2 == 0)
all(muestra %% 2 == 0)
muestra[which(muestra %% 2 == 0)]


# Pruebas lógicas  --------------------------------------------------------

# == Igual
# != Diferente
# <= Menor igual
# <  Menor
# >= Mayor igual
# >  Mayor
# &  Y
# |  O
# %in% dentro de


# Funciones para pruebas logícas ------------------------------------------
# all(): Todos los elemenotos son TRUE
# any(): Algún elemento es TRUE
# all.equal(): iguales dos elementos.
A <- 1:3
B <- 3:1
all.equal(A, B)
A <- LETTERS[1:3]
B <- letters[1:3]
all.equal(A, B)
