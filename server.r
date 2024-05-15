library(shiny)
library(ggplot2)
library(dplyr)

function(input, output) {
  data <- reactive({
    req(input$file)
    read.csv(input$file$datapath)
  })
  
  output$data_table <- renderTable({
    if (!is.null(input$file)) {
      data()
    }
  })
  
  output$bar_plot <- renderPlot({
    req(input$file)
    req(data())
    
    beverage_summary <- data() %>%
      group_by(Beverage) %>%
      summarise(Total_Quantity = sum(Quantity))
    
    ggplot(beverage_summary, aes(x = Beverage, y = Total_Quantity)) +
      geom_bar(stat = "identity") +
      labs(title = "Total Quantity of Each Beverage Sold",
           x = "Beverage",
           y = "Total Quantity")
  })
}
