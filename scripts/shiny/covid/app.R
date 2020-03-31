library(data.table)
library(shiny)
library(ggplot2)
library(plotly)
library(shinythemes)

covid <- fread("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")
covid[,date := as.Date(date)]

states <- unique(covid$state)
counties <- unique(covid$county)

#Define UI for app that draws a histogram ----
ui <- fluidPage(
  theme = shinytheme("yeti"),
  titlePanel("Plot of Covid Cases Over Time"),
  column(width = 4,
         # Input: Slider for the number of bins ----
         selectInput(inputId = "state", 
                     label = "Please Choose a State: ", 
                     choices = states, 
                     selected = "Texas", 
                     multiple = TRUE,
                     selectize = TRUE),
         # Input: Slider for the number of bins ----
         selectInput(inputId = "county", 
                     label = "Please Choose Counties: ", 
                     choices = counties, 
                     selected = c("Travis",
                                  "Dallas"), 
                     multiple = TRUE,
                     selectize = TRUE),
         shiny::radioButtons(
           label = "Log Scale?",
           inputId = "log_scale",
           choiceNames = c("Yes","No"),
           choiceValues = c(TRUE, FALSE)
         )
  ),
  column(width = 8,
         # Output: Histogram ----
         plotly::plotlyOutput(outputId = "covidCasePlot")
  )
)


server <- function(input, output, session) {
  
  observe({
    
    x <- input$state
    these_counties <- unique(covid[state %in% x]$county)
    
    # Can also set the label and select items
    updateSelectInput(session, 
                      inputId = "county",
                      choices = these_counties,
                      selected = input$county
    )
  })
  
  output$covidCasePlot <- plotly::renderPlotly({
  
    g <- ggplot(covid[state %in% input$state &
                        county %in% input$county],
                aes(x = date,
                    y = cases,
                    color = county)) +
      geom_line()
    if(input$log_scale) {
      ggplotly({
        g + scale_y_log10()
      })
    } else {
      ggplotly({
        g
      })
    }
    
  })
  
}

shinyApp(ui, server)

