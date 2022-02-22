library(shiny)
library(shinybusy)

ui <- fluidPage(
  tags$h2("config for notify examples"),
  actionButton("success", "Success")
)

server <- function(input, output, session) {

  observeEvent(input$success, {
    notify_success(
      "Well done!",
      config_notify(
        background = "#0431B4",
        notiflixIconColor = "#FFF"
      )
    )
  })

}

if (interactive())
  shinyApp(ui, server)
