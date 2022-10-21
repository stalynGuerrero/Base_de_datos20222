######################################################
## Dashboard de la vigilancia en salud publica del VIH/Sida en Colombia 2020 
## Shiny VIH-2020
## Oscar Vanegas, Diana Parra, Nelson Lopez, Mario Benedetti, Luis Acuna 
## Version 1
## Fecha: 22/10/2022
######################################################

## Cargar librerias ##
library(shinydashboard)
library(readxl)
library(ggplot2)
library(tidyverse)
library(DataExplorer)
library(plotly)
library(raster)
library(sf)
library(scales)

## Cargar base de datos ##

#BaseVIH <- read_excel("VIH2020_INS.xlsx")

server <- function(input, output) {
  
  
  ### Primera vista -----------------------------------------------------------
  
  # Histograma de la primera vista
  ## Creacion de filtros segun sexo
  
  output$histograma1 <- renderPlotly({
    filtrado_depto_h <- BaseVIH %>% filter(Departamento_ocurrencia == input$Depto, SEXO == "M")
    filtrado_depto_m <- BaseVIH %>% filter(Departamento_ocurrencia == input$Depto, SEXO == "F")
    fig <- plot_ly(alpha = 0.6)
    fig <- fig %>% 
      add_histogram(x = filtrado_depto_h$EDAD, 
                    name="Hombres",
                    marker = list(color = "light-blue")) %>% 
      layout(title = "Histograma de frecuencias",
             xaxis = list(title = "Edad"),
             yaxis = list(title = "Conteo de casos"))
    fig <- fig %>% add_histogram(x = filtrado_depto_m$EDAD, name="Mujeres")
    fig <- fig %>% layout(barmode = "stack")
    fig
  })
  
  #Pie chart de la primera vista
  output$piechart1 <- renderPlotly({
    filtrado_depto <- BaseVIH %>% filter(Departamento_ocurrencia == input$Depto)
    proporcion <- data.frame(table(filtrado_depto$SEXO))
    proporcion$prop <- prop.table(proporcion$Freq)*100
    
    fig <- plot_ly(proporcion, labels=proporcion$Var1,values = proporcion$prop, type = 'pie',
                   textposition = 'inside',
                   textinfo = 'label+percent',
                   insidetextfont = list(color = '#FFFFFF'),
                   hoverinfo = 'text',
                   text = ~paste(proporcion$Freq, ' casos')
    )
    
    fig
  })
  
  # Box contador de la primera vista
  ## input$Depto: variable para que el usuario interactue en la consulta 
  output$conteocasos1 <- renderValueBox({
    imprimir<-paste(c("Casos en",input$Depto),collapse=" ")
    filtrado_depto <- BaseVIH %>% filter(Departamento_ocurrencia == input$Depto)
    valueBox(
      nrow(filtrado_depto),
      as.character(imprimir),
      icon = icon("person"),
      color = "blue"
    )
  }) 
  
  #Box contador2 de la primera vista pais
  output$conteocasos2 <- renderValueBox({
    valueBox(
      nrow(BaseVIH),
      as.character("Casos nacionales"),
      icon = icon("person"),
      color = "green"
    )
  })
  
  output$departamento_elegido <- renderText({
    input$Depto
  })
  
  
  # Segunda vista -----------------------------------------------------------
  # Tabla descriptiva de la segunda vista
  ## Con funcion mutate se crea variable "nacionalidad" con dos categorias
  ## Nacionalidad = Colombia, la variable lo toma como "Colombiano", de lo contrario "Extranjero"
  
  BaseVIH <- BaseVIH %>% mutate (EXTRANJERO = ifelse (NACIONALIDAD == "COLOMBIA", "Colombiano", "Extranjero"))
  BaseVIH <- BaseVIH %>% mutate (NACIONALIDAD2 = case_when (NACIONALIDAD == "COLOMBIA" ~ "Colombiano",
                                                            NACIONALIDAD == "VENEZUELA" ~ "Venezolano",
                                                            TRUE ~ "Otros extranjeros" )) 
  
  ## La funcion drop_na descarta las filas en las cuales no se tenga reportada alguna de las fechas
  ## Se crea SinNA es la base de datos con los NA descartados
  
  SinNA <- BaseVIH %>% drop_na(FECHA_CONSULTA, FECHA_INICIO_SINTOMAS)
  
  ## Se crea variable Difdias que indica el tiempo trascurrido entre la fecha de inicio de 
  ## sintomas y la fecha de consulta registrada. Se divide en 86400 dado que el calculo da el 
  ## resultado en segundos.
  
  SinNA <- mutate(SinNA, Difdias = (as.integer((FECHA_CONSULTA)-(FECHA_INICIO_SINTOMAS))/86400))
  output$tabla1 <- renderDataTable({
    filtrado_depto <- SinNA %>% filter(Departamento_residencia == input$depto2)
    temp <- filtrado_depto %>% group_by_at(input$agrupar_descriptivo) %>%
      summarise(MediaDias = round(mean(Difdias),1),
                MedianaDias = round(median(Difdias),1),
                SdDias = round(sd(Difdias),1), 
                Minimo = round(min(Difdias),0),
                Maximo = round(max(Difdias),0)
      )
    temp <- data.frame(temp)
    temp
  })
  
  output$departamento_elegido2 <- renderText({
    input$depto2
  })
  
  #Box contador de la segunda vista
  ## En la caja de texto se describe la cantidad de casos por el departamento que seleccione el usuario
  
  output$promediodias <- renderValueBox({
    imprimir<-paste(c("Promedio días entre síntomas y consulta en",input$depto2),collapse=" ")
    filtrado_depto <- SinNA %>% filter(Departamento_residencia == input$depto2)
    valueBox(
      round(mean(filtrado_depto$Difdias, na.rm = TRUE),0),
      as.character(imprimir),
      icon = icon("calendar"),
      color = "blue"
    )
  })
  
  #Boxplot de la segunda vista
  output$boxplot1 <- renderPlot({
    filtrado_depto <- SinNA %>% filter(Departamento_residencia == input$depto2)
    pl <- ggplot(filtrado_depto, aes(x = factor(get(input$agrupar_descriptivo)),y=Difdias, color=factor(get(input$agrupar_descriptivo))))
    pl + geom_boxplot() + coord_flip() + labs(title="",y="Días entre síntomas y consulta", x = "") + scale_fill_brewer(palette="Blue") + theme(legend.position="none")
  })  
  
  
  # Tercera vista -----------------------------------------------------------
  #Mapa de la tercera vista
  # Importar mapa y convertir a estructura tabla
  colombia_depto <- getData(name = "GADM", country = "COL", level = 2)
  datos_mapa <- st_as_sf(colombia_depto)
  
  output$mapa1 <- renderPlot({
    # Generar mediana de días de atención por departamento, filtrado por sexo
    color_mapa <- BaseVIH %>% filter(SEXO != input$genero) %>% 
      group_by(Departamento_ocurrencia) %>%
      summarise(SUMA = mean(EDAD, na.rm = TRUE)) %>% 
      ungroup()
    # Convertir nombres a mayúsculas y remover tíldes para unificar formato
    datos_mapa$NAME_1 <-chartr("ÁÉÍÓÚ", "AEIOU", toupper(datos_mapa$NAME_1))
    datos_mapa %>% 
      #Remover San Andrés para facilitar la visualización
      filter(NAME_1 != "SAN ANDRES Y PROVIDENCIA") %>%
      rename(Departamento_ocurrencia = NAME_1) %>% 
      left_join(y = color_mapa, by = "Departamento_ocurrencia") %>% 
      ggplot(mapping = aes(fill = SUMA)) +
      geom_sf(color = "white")+
      scale_fill_distiller(name="Promedio edad", 
                           palette = "RdYlGn", 
                           breaks = pretty_breaks()) +
      theme_minimal() 
  }, height = 300)
  
  output$mapa2 <- renderPlot({
    # Generar mediana de días de atención por departamento, filtrado por sexo
    color_mapa2 <- SinNA %>% filter(SEXO != input$genero) %>% 
      group_by(Departamento_ocurrencia) %>%
      summarise(MEDIANA = median(Difdias)) %>% 
      ungroup()
    # Convertir nombres a mayúsculas y remover tíldes para unificar formato
    datos_mapa$NAME_1 <-chartr("ÁÉÍÓÚ", "AEIOU", toupper(datos_mapa$NAME_1))
    datos_mapa %>% 
      #Remover San Andrés para facilitar la visualización
      filter(NAME_1 != "SAN ANDRES Y PROVIDENCIA") %>%
      #Renombrar variable para que coincidan
      rename(Departamento_ocurrencia = NAME_1) %>% 
      #Unir las dos tablas por departamento
      left_join(y = color_mapa2, by = "Departamento_ocurrencia") %>% 
      ggplot(mapping = aes(fill = MEDIANA)) +
      geom_sf(color = "white")+
      scale_fill_distiller(name="Mediana días", 
                           palette = "RdYlGn", 
                           breaks = pretty_breaks()) +
      theme_minimal() 
  }, height = 300)
  
  
  # Cuarta vista ------------------------------------------------------------
  
  #Tabla prueba hipótesis de la quinta vista
  output$tablahipotesis1 <- renderTable({
    temporal <- BaseVIH %>%
      filter(EXTRANJERO == "Colombiano", Departamento_residencia == input$depto3) %>%
      group_by(SEXO) %>% tally()
    #Ha: La proporci?n de hombres colombianos notificados es mayor a la proporci?n de mujeres
    #colombianas notificadas
    test_prop <- prop.test(x = as.numeric(temporal[2,2]), 
                           n = sum(temporal$n),
                           p = 0.5,
                           alt = "greater",
                           conf.level = as.numeric(input$conf_level))
    data.frame(Estadistica = test_prop$statistic,
               pvalor = test_prop$p.value, 
               Lim_Inf = test_prop$conf.int[1],
               Lim_Sup = test_prop$conf.int[2])
    
  })
  
  #Tabla prueba hipótesis de la quinta vista diferencia de medias
  
  output$tablahipotesis2 <- renderTable({
    mujer <- SinNA %>% filter(Departamento_residencia == input$depto3, SEXO == "F") %>% pull(Difdias)
    hombre <- SinNA %>% filter(Departamento_residencia == input$depto3, SEXO == "M") %>% pull(Difdias)
    
    #Ha: El promedio de dias de los hombres notificados es igual al promedio de dias de las mujeres
    #notificadas
    
    Pruebtest <- t.test(x=mujer, y=hombre, alternative="two.sided", mu=0, 
                        paired=FALSE, var.equal=FALSE, conf.level= as.numeric(input$conf_level))
    
    data.frame(Estadistica = Pruebtest$statistic,
               pvalor = Pruebtest$p.value, 
               Lim_Inf = Pruebtest$conf.int[1],
               Lim_Sup = Pruebtest$conf.int[2]
    )
    
  })
  # Quinta vista ------------------------------------------------------------
  
  ## Linea de la cuarta vista: comportamiento notificacion semanal por departamento seleccionado por el usuario
  
  output$linea1 <- renderPlotly({
    #Se realizan filtros segun el departamento elegido por el usuario
    filtrado_depto <- BaseVIH %>% filter(Departamento_residencia == input$Depto4)
    filtrado_depto_h <- BaseVIH %>% filter(Departamento_residencia == input$Depto4, SEXO == "M")
    
    #Se realizan los conteos de casos en el departamento por semana
    total_nacional <- data.frame(table(BaseVIH$SEMANA))
    semanas_t <- data.frame(table(filtrado_depto$SEMANA))
    semanas_h <- data.frame(table(filtrado_depto_h$SEMANA))
    
    #Se unen los 3 data frame en uno solo y se llenan de 0 donde no hay casos
    total_nacional <- left_join(x = total_nacional,y = semanas_t,"Var1")
    total_nacional <- left_join(x = total_nacional,y = semanas_h,"Var1")
    total_nacional %>% mutate_all(~replace(., is.na(.), 0))
    
    #Se elabora el gráfico y se agregan 3 líneas
    fig <- plot_ly(filtrado_depto, x = ~total_nacional$Var1, y = ~total_nacional$Freq.x, name ="Total Nacional", type="scatter", mode = 'lines') 
    fig <- fig %>% add_trace(y = ~total_nacional$Freq.y, name = 'Total departamental', mode = 'lines') %>%
      add_trace(y = ~total_nacional$Freq, name = 'Hombres departamento', mode = 'lines') %>%
      layout(title = "",
             xaxis = list(title = "Número de la semana"),
             yaxis = list(title = "Conteo de casos"))
    fig
  }) 
  
}