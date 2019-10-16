if (interactive()) {

  library(shiny)
  library(shinybusy)

  ui <- fluidPage(

    tags$h1("Modal with progress bar"),
    actionButton("sleep1", "Launch a long calculation"),
    actionButton("sleep2", "And another one (different line options)"),
    tags$br(),
    actionButton("sleep3", "With a circle progress bar"),
    actionButton("sleep4", "With different circle options)")
  )

  server <- function(input, output, session) {

    observeEvent(input$sleep1, {
      show_modal_progress_line()
      for (i in 1:100) {
        update_modal_progress(
          value = i / 100
        )
        Sys.sleep(0.1)
      }
      remove_modal_progress()
    })

    observeEvent(input$sleep2, {
      show_modal_progress_line(
        color = "#DF0101",
        duration = 900,
        easing = "easeOut",
        text = "Starting computation"
      )
      Sys.sleep(0.1)
      for (i in 1:100) {
        update_modal_progress(
          value = i / 100,
          text = paste("Process", trunc(i/10), sprintf("(%02d%%)", i))
        )
        Sys.sleep(0.15)
      }
      remove_modal_progress()
    })


    observeEvent(input$sleep3, {
      show_modal_progress_circle()
      for (i in 1:100) {
        update_modal_progress(
          value = i / 100
        )
        Sys.sleep(0.1)
      }
      remove_modal_progress()
    })

    observeEvent(input$sleep4, {
      show_modal_progress_circle(
        color = "#DF0101",
        duration = 900,
        easing = "easeOut",
        text = "Starting computation",
        height = "300px"
      )
      Sys.sleep(0.1)
      for (i in 1:100) {
        update_modal_progress(
          value = i / 100,
          text = paste("Process", trunc(i/10), sprintf("(%02d%%)", i))
        )
        Sys.sleep(0.15)
      }
      remove_modal_progress()
    })

  }

  shinyApp(ui, server)

}
