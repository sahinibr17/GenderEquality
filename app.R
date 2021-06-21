library(shiny)
library(tidyverse)
library(plotly)
library(shinythemes)

library(readxl)
Life_expectancy_at_birth_1 <- read_excel("C:/Users/ibrsa/Desktop/final_docs-sahinibr17/data/Life_expectancy_at_birth_1.xlsx")
#View(Life_expectancy_at_birth_1)

ui <- fluidPage(theme = shinytheme("superhero"),
    
    sidebarLayout(
        
        sidebarPanel(
            
            tags$h4(tags$span(style="color:blue","Plot")),
            
            selectInput(inputId = "x_axis", label = "X axis",
                        choices = c("LOCATION"),
                        selected = "LOCATION"),
            
            selectInput(inputId = "y_axis", label = "Y axis",
                        choices = c("MEN", "TOT",
                                    "WOMEN"),
                        selected = "TOT"),
            
            sliderInput(inputId = "alpha_level", label = "alpha",
                        min = 0, max = 1, value = 0.8)
        ),
        
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel(title = "Plot",
                                 plotlyOutput(outputId = "Life_expectancy_at_birth_1_scatter")),
                        tabPanel(title = "Data",
                                 DT::dataTableOutput(outputId = "table"))
        )
    )
)
)
server <- function(input, output) {
    
    output$Life_expectancy_at_birth_1_scatter <- renderPlotly({
        
        p_scatter <- ggplot(data = Life_expectancy_at_birth_1,
                            aes_string(x = input$x_axis, y = input$y_axis))+
            geom_point(alpha = input$alpha_level)+
            guides(size = FALSE)+
            theme_minimal()
        
        ggplotly(p_scatter)
    })
    
    output$table <- DT::renderDataTable({
        DT::datatable(Life_expectancy_at_birth_1, rownames = FALSE)
    })
}

shinyApp(ui = ui, server = server)