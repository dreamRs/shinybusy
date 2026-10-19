library(shinybusy)
library(shiny)

ui <- fluidPage(
  tags$h3("Full-page loading indicator"),
  actionButton("start", "Start a long calculation"),
  verbatimTextOutput("result")
)

server <- function(input, output, session) {

  result <- reactiveVal("Nothing yet")

  observeEvent(input$start, {
    show_loading(
      text = "Calculating, please wait...",
      type = "circle",
      svgColor = "#5ea4d8",
      messageColor = "#FFF"
    )
    # always remove the indicator, even if the calculation fails
    tryCatch({
      Sys.sleep(2)
      update_loading("Almost done...")
      Sys.sleep(2)
      result("Done!")
    }, finally = remove_loading(timeout = 300))
  })

  output$result <- renderPrint(result())

}

if (interactive())
  shinyApp(ui, server)
