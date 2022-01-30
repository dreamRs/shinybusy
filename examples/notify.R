library(shiny)

ui <- fluidPage(
  tags$h2("notify examples"),
  tags$p(
    "More examples available on the official website:",
    tags$a("https://notiflix.github.io/notify")
  ),
  actionButton("success", "Success"),
  actionButton("failure", "Failure"),
  actionButton("info", "Info"),
  actionButton("warning", "Warning")
)

server <- function(input, output, session) {

  observeEvent(input$success, {
    notify_success("Well done!")
  })

  observeEvent(input$failure, {
    notify_failure("Oups...")
  })

  observeEvent(input$info, {
    notify_info("For your information")
  })

  observeEvent(input$warning, {
    notify_warning("Be careful!")
  })

}

if (interactive())
  shinyApp(ui, server)
