#Nombre: Andrés Mora

library(shiny)
library(quantmod)
library(fGarch)

ui <- fluidPage(
  
  titlePanel("Verficación de los hechos estilizados"),
  
  sidebarLayout(
    
    sidebarPanel(

selectInput(
    inputId = "stickers",
    label = "Seleccione uno de los siguientes simbolos: ",
    choices = c("GOOGL", "IBM", "AMZN", "AAPL"),
    multiple = FALSE,
    selected = c("GOOGL") ),

dateInput(inputId = "fechaini",
          label = "Fecha inicio:",
          value = Sys.Date()-2500,
          max = Sys.Date()-500),

dateInput(inputId = "fechafin",
          label = "Fecha final:",
          value = Sys.Date(),
          min = Sys.Date()-500),

selectInput(
  inputId = "distr",
  label = "Seleccione una de las siguientes distribuciones para el GARCH: ",
  choices = c("norm", "std", "sstd"),
  multiple = FALSE,
  selected = c("norm") ),

p("Para los rendimientos diarios es usual ver las siguientes características (e.g., McNeil et al., 2015):", class = "my-class"),
tags$ul(
  tags$li("Presentan baja autocorrelación serial."), 
  tags$li("La autocorrelación serial de los rendimientos elevados al cuadrado no es baja"),
  tags$li("Media alrededor de cero."), 
  tags$li("Volatilidad cambiante en el tiempo."), 
  tags$li("Los valores extremos se agrupan."), 
  tags$li("Distribución de colas pesadas."),
  
),
"Mcneil, A., Frey, R., & Embrechts, P., 2015. Quantitative Risk Management. Princeton"
),




mainPanel(
#salida de descriptivos
verbatimTextOutput("tablades"),


           
#salida de graficos

tabsetPanel(
  tabPanel("Graficos de precio y rendimiento", plotOutput("plotprecio"),
           plotOutput("plotrdto")),
  tabPanel("Correlogramas", plotOutput("plotacf"),
           plotOutput("plotacf2")),
  tabPanel("Histograma y Gráfico de volatilidad", plotOutput("plothist"),
           plotOutput("plotvol"))
)

) 
)

)

server <- function(input,output,session){
  

  output$tablades <- renderPrint({
    precio = getSymbols(Symbols=input$stickers, from = input$fechaini, to = input$fechafin, auto.assign = FALSE, verbose = FALSE)[,4]
    summary(as.numeric(na.omit(100*diff(log(precio)))))
      })
  
  output$plotprecio <- renderPlot({
    precio = getSymbols(Symbols=input$stickers, from = input$fechaini, to = input$fechafin, auto.assign = FALSE, verbose = FALSE)[,4]
    plot(precio,type="l",main="precios")
      }, res = 96)
  
  output$plotrdto <- renderPlot({
    precio = getSymbols(Symbols=input$stickers, from = input$fechaini, to = input$fechafin, auto.assign = FALSE, verbose = FALSE)[,4]
    rdmto = na.omit(100*diff(log(precio))) 
    plot(rdmto,type="l")
  }, res = 96)
  
  output$plotacf <- renderPlot({
    precio = getSymbols(Symbols=input$stickers, from = input$fechaini, to = input$fechafin, auto.assign = FALSE, verbose = FALSE)[,4]
    rdmto = na.omit(100*diff(log(precio))) 
    acf(rdmto, main="correlograma de los rendimientos")
    
  }, res = 96)
  
  output$plotacf2 <- renderPlot({
    precio = getSymbols(Symbols=input$stickers, from = input$fechaini, to = input$fechafin, auto.assign = FALSE, verbose = FALSE)[,4]
    rdmto = na.omit(100*diff(log(precio))) 
    acf(rdmto^2, main="correlograma de los rendimientos al cuadrado")
    
  }, res = 96)

  output$plothist <- renderPlot({
    precio = getSymbols(Symbols=input$stickers, from = input$fechaini, to = input$fechafin, auto.assign = FALSE, verbose = FALSE)[,4]
    rdmto = na.omit(100*diff(log(precio))) 
    hist(rdmto, main="histograma de los rendimientos", nclass=50)
    
  }, res = 96)
  
  output$plotvol <- renderPlot({
    precio = getSymbols(Symbols=input$stickers, from = input$fechaini, to = input$fechafin, auto.assign = FALSE, verbose = FALSE)[,4]
    rdmto = na.omit(100*diff(log(precio))) 
    fecha = index(precios[-1])
    fit4 = garchFit(formula=~arma(0,0)+garch(1,1), data = rendmto, include.mean=T, cond.dist=input$distr,trace=FALSE)
    plot(fit4@sigma.t,type="l",xlab="",xaxt='n',ylab="",main="volatilidad condicional",col="azure4")
    axis(side=1,at=1:length(fecha),labels=fecha)
    }, res = 96)
  
}

shinyApp(ui=ui,server=server)