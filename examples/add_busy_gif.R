library(shiny)
library(shinybusy)

ui <- fluidPage(

  # Use this function somewhere in UI
  # with navBarPage use the "header" argument
  add_busy_gif(
    src = "https://jeroen.github.io/images/banana.gif",
    height = 70, width = 70
  ),

  actionButton("sleep", "Long calculation")
)

server <- function(input, output, session) {

  observeEvent(input$sleep, {
    Sys.sleep(5)
  })

}

if (interactive()) {
  shinyApp(ui, server)
}
