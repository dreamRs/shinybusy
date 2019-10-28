if (interactive()) {
  library(shiny)
  library(shinybusy)

  ui <- fluidPage(

    # Use this function somewhere in UI
    use_busy_gif(
      src = "https://jeroen.github.io/images/banana.gif",
      height = 70, width = 70
    ),

    actionButton("play", "Play GIF"),
    actionButton("stop", "Stop GIF")
  )

  server <- function(input, output, session) {

    observeEvent(input$play, {
      play_gif()
    })

    observeEvent(input$stop, {
      stop_gif()
    })

  }

  shinyApp(ui, server)
}
