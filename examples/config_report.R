library(shiny)
library(shinybusy)

ui <- fluidPage(
  tags$h2("Config for report() examples"),
  actionButton("success", "Success"),
  actionButton("failure", "Failure"),
  actionButton("info", "Info")
)

server <- function(input, output, session) {

  observeEvent(input$success, {
    report_success(
      "Well done!",
      "All in order",
      config_report(
        svgColor = "#0431B4",
        titleColor = "#0431B4"
      )
    )
  })

  observeEvent(input$failure, {
    report_failure(
      "Oups...",
      "Something went wrong",
      config_report(
        svgColor = "#DF01D7",
        titleColor = "#DF01D7"
      )
    )
  })

  observeEvent(input$info, {
    report_info(
      "For your information",
      tags$p(
        style = "font-style: italic;",
        "Lorem ipsum dolor sit amet"
      ),
      config_report(width = "560px", borderRadius = "5px")
    )
  })

}

if (interactive())
  shinyApp(ui, server)
