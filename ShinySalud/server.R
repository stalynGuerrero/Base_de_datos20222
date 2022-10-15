library(shiny)


server <- function(input, output) {
  
  output$plot_cont <- renderPlot({
    hist(salud[[input$var_cont]], probability = TRUE, 
         xlab = input$var_cont,
         ylab = "", main = "Histograma", col = "blue")
  })
  
  output$plot_cuali <- renderPlot({
    barplot(table(salud[[input$var_cat]]), xlab = input$var_cat,
            ylab = "", main = "Diagrama de barras", col = "blue")
    
  })
  
  output$Tabla_Cont <- renderDataTable({
    salud %>% group_by_at(input$bygrup) %>%
      summarise_at(.vars = all_of(input$var_cont),
                   list(Media = mean, Sd = sd, Max = max))
  })
  
  output$Tabla_Cualita <- renderDataTable({
    salud %>% group_by_at(c(input$bygrup, input$var_cat)) %>%
      tally() %>%
      spread(data = ., key = input$var_cat, value = "n")
  })
  
  output$test_cont <- renderTable({
    
    test <- t.test(x = salud[[input$var_PH]],
                   mu = input$mu_cont)
    
    data.frame(Estadistica = test$statistic,
               pvalor = test$p.value, 
               Lim_Inf = test$conf.int[1],
               Lim_Sup = test$conf.int[2]
    )
  })
  
  ###############################################
  
  output$sub_grupos <- renderUI({
    
    tagList(
      selectInput(inputId = "subgrupo", 
                  label = paste0("Seleccionar un sub grupo de ", input$bygrup),
                  choices = unique(salud[[input$bygrup]])      )
    )
  })
  
  ###############################################
  
  
  output$test_prop1 <- renderTable({
    temp <- salud %>% 
      filter_at(.vars = all_of(input$bygrup), all_vars(. == input$subgrupo) ) %>% 
      mutate_at(.vars = all_of(input$var_PH),
                function(x)
                  ifelse(x > input$cota, 1, 0)) %>%
      group_by_at(input$var_PH) %>% tally()
    
    test_prop <- prop.test(x = as.numeric(temp[2,2]), 
                           n = sum(temp$n), p = input$PI_prop)
    
    data.frame(Estadistica = test_prop$statistic,
               pvalor = test_prop$p.value, 
               Lim_Inf = test_prop$conf.int[1],
               Lim_Sup = test_prop$conf.int[2]
    )
    
  })
}

shinyApp(ui, server)

