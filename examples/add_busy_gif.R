if (interactive()) {
  library(shiny)
  library(shinybusy)

  ui <- fluidPage(

    # Use this function somewhere in UI
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

  shinyApp(ui, server)
}
