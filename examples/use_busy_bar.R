if (interactive()) {
  library(shiny)
  library(shinybusy)

  ui <- fluidPage(
    tags$h2("Manual nanobar"),
    use_busy_bar(color = "#01DF01", height = "15px"),
    actionButton(inputId = "go", label = "Go"),
    sliderInput(
      inputId = "set", label = "Set progress",
      min = 0, value = 0, max = 100
    )
  )

  server <- function(input, output, session) {

    observeEvent(input$go, {
      update_busy_bar(0)
      for (i in 1:100) {
        Sys.sleep(0.1)
        update_busy_bar(i)
      }
    })

    observeEvent(input$set, {
      update_busy_bar(input$set)
    })

  }

  shinyApp(ui, server)
}
