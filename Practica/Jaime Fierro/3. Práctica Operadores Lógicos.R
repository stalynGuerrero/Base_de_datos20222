#=========================================================================================================#
#                                  Universdiad El Bosque
#                                    Programación en R
#                        Práctica Operadores Lógicos | 2022/10/08
#                                Profesor: Stalyn Guerrero
#                         Estudiante: Jaime Andrés Fierro Aponte                                 
#=========================================================================================================#

a = 1:15
b = seq(1,30,by = 2)

# Operadores de relación: -------------------------------------------------


a <= b 
b <= a

a >= b 
b >= a
a == b

a != b


# Operadores lógicos : ----------------------------------------------------

a < 5 | b > 10

a <= 6 & b >= 10
!((a > 3 & a < 8) | (b >=6 | b < 4 ))

# Coincidencia de valores ----------------------------------------------------
a[a %in% b]

# Pruebas lógicas ----------------------------------------------------
all(a>=1)
any(a>=10)


# Estructuras de control -------------------------------------------------
x = 0.2
if( 0 <= x & x < 2){
  0.1 
}else if(2<= x & x < 4){
  0.5
}else if(4<= x & x < 6){
  0.2
}else {
  0.2
}

# Creando bucles ------------------------------------------------------------

for(ii in LETTERS){
  
  print(paste0('ii = ', ii), quote = F)
  
}

fx = numeric()
xvalue = seq(0, 10, by = 0.001)
for(ii in 1:length(xvalue) ){
  
  x = xvalue[ii]
  
  if( 0 <= x & x < 2){
    
    fx[ii] =  0.1 
    
  }else if(2<= x & x < 4){
    
    fx[ii] = 0.5
    
  }else if(4<= x & x < 6){
    
    fx[ii] = 0.15
    
  }else {
    
    fx[ii] =  0.25
    
  }
  cat('x =', x, '\n')  
}

x11()
plot(xvalue, fx)

## while 

fx = numeric()
contador  = 1
x = 1
while(x <= 10 ){
  
  if( 0 <= x & x < 2){
    
    fx[contador] =  0.1 
    
  }else if(2<= x & x < 4){
    
    fx[contador] = 0.5
    
  }else if(4<= x & x < 6){
    
    fx[contador] = 0.15
    
  }else {
    
    fx[contador] =  0.25
    
  }
  
  x = x + 0.001
  contador = contador + 1 
}

x11()
plot(fx)

# replicate 
moneda = function(peso = 0.5){
  
  x = runif(n = 1, 
            min = 0,
            max = 1)
  
  if(x <= peso){
    
    'Cara'
    
  }else {
    
    'Sello'
    
  }
}

prop.table(
  table(
    replicate(
      10000, 
      moneda()
      )
    )
  )

# Familia de funciones apply ----------------------------------------------

# lapply 
replicate(10, moneda())

unlist(lapply(1:10,function(x) moneda()))

fx = unlist(lapply(X = xvalue , 
                   FUN = function(x){
      if( 0 <= x & x < 2){
        0.1 
      }else if(2 <= x & x < 4){
        0.5
      }else if(4 <= x & x < 6){
        0.15
      }else {
        0.25
      }
    }
  )
)
fx

sapply(X = xvalue, 
       FUN = function(x){
                         if( 0 <= x & x < 2){
                           0.1 
                         }else if(2<= x & x < 4){
                           0.5
                         }else if(4<= x & x < 6){
                           0.15
                         }else {
                           0.25
                         }
                        },
                        simplify = T)

sum(a<2)

apply(X = iris[, -5], 
      MARGIN = 2,
      FUN = mean)

apply(X = iris[, -5], 
      MARGIN = 1,
      FUN = max)

apply(X = iris[, -5], 
      MARGIN = 2,
      FUN = max)

apply(X = iris[,-5], 
      MARGIN = 2,
      FUN = function(x){
                        c(Max = max(x),
                          Min = min(x),
                          Media = mean(x))
                       }
      )





# min
# max
# median()
# mean()
# quantile()#0.25, 0.75


apply(X = iris[,-5], 
      MARGIN = 2,
      FUN = function(x){
        c(Max = max(x),
          Min = min(x),
          Media = mean(x),
          Mediana = median(x),
          Q1 = quantile(x)[2],
          Q2 = quantile(x)[3])
      }
)

# Un nuevo cambio
