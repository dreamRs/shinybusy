library(shiny)
library(shinybusy)

ui <- fluidPage(

  # Use this function somewhere in UI
  add_busy_bar(color = "#FF0000"),

  headerPanel('Iris k-means clustering'),

  tags$br(),
  actionButton("quick", "Quick calculation (nothing happens)"),
  actionButton("sleep", "Long calculation (progress bar on top)")
)

server <- function(input, output, session) {

  observeEvent(input$quick, {
    Sys.sleep(0.1)
  })

  observeEvent(input$sleep, {
    Sys.sleep(5)
  })

}

if (interactive()) {
  shinyApp(ui, server)
}
