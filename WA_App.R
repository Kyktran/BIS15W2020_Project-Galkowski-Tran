





library("tidyverse")
library("shiny")
library("shinydashboard")




Trough<- c(1,2,3,4)
GCS2<- c(5/25,9/25,7/50,14/50)
MM2<- c(5.9272, 4.2424, 3.4080, 4.4500)
ML2<- c(27.072, 26.524, 22.846, 27.868)
APP2<- data_frame(Trough, GCS2, MM2, ML2)

```{r}
library("shinydashboard")
ui <- dashboardPage(
  dashboardHeader(title = "How water quality affects WA"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      box(title = "Plot Options", width = 3,
          selectInput("x", "Select X Variable", choices = c("Trough"), 
                      selected = "Trough"),
          selectInput("y", "Select Y Variable", choices = c("GCS2", "MM2", "ML2"))
      ), # close the first box
      box(title = "Plot of Water quality vs sucess", width = 7,
          plotOutput("plot", width = "600px", height = "500px")
      ) # close the second box
    ) # close the row
  ) # close the dashboard body
) # close the ui

server <- function(input, output, session) { 
  
  # the code to make the plot of iris data grouped by species
  output$plot <- renderPlot({
    ggplot(APP2, aes_string(x = input$x, y =  input$y, fill = input$x)) + geom_col() + theme_light(base_size = 18)
  })
  
  # stop the app when we close it
  session$onSessionEnded(stopApp)
  
}

shinyApp(ui, server)

```