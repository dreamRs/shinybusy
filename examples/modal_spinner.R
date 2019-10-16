if (interactive()) {

  library(shiny)
  library(shinybusy)

  ui <- fluidPage(

    tags$h1("Modal with spinner"),
    actionButton("sleep1", "Launch a long calculation"),
    actionButton("sleep2", "And another one")
  )

  server <- function(input, output, session) {

    observeEvent(input$sleep1, {
      show_modal_spinner()
      Sys.sleep(5)
      remove_modal_spinner()
    })

    observeEvent(input$sleep2, {
      show_modal_spinner(
        spin = "cube-grid",
        color = "firebrick",
        text = "Please wait..."
      )
      Sys.sleep(5)
      remove_modal_spinner()
    })

  }

  shinyApp(ui, server)

}
