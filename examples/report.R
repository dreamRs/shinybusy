library(shiny)

ui <- fluidPage(
  tags$h2("report examples"),
  tags$p(
    "More examples available on the official website:",
    tags$a("https://notiflix.github.io/report")
  ),
  actionButton("success", "Success"),
  actionButton("failure", "Failure"),
  actionButton("info", "Info"),
  actionButton("warning", "Warning")
)

server <- function(input, output, session) {

  observeEvent(input$success, {
    report_success(
      "Well done!",
      "All in order"
    )
  })

  observeEvent(input$failure, {
    report_failure(
      "Oups...",
      "Something went wrong"
    )
  })

  observeEvent(input$info, {
    report_info(
      "For your information",
      tags$p(
        style = "font-style: italic;",
        "Lorem ipsum dolor sit amet"
      )
    )
  })

  observeEvent(input$warning, {
    report_warning(
      "Be careful!",
      "There were 30 warnings (use warnings() to see them)"
    )
  })

}

if (interactive())
  shinyApp(ui, server)
