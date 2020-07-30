library(shinybusy)
library(shiny)

ui <- fluidPage(

  # Use once in UI
  add_loading_state(
    ".shiny-plot-output",
    text = "Please wait...",
    svgColor = "steelblue"
  ),

  tags$h3("Loading state"),
  actionButton("refresh", "Refresh charts"),
  actionButton("modal", "Open modal window"),

  fluidRow(
    column(
      width = 6,
      plotOutput(outputId = "plot1")
    ),
    column(
      width = 6,
      plotOutput(outputId = "plot2")
    )
  )

)

server <- function(input, output, session) {

  output$plot1 <- renderPlot({
    input$refresh
    if (input$refresh > 0) {
      Sys.sleep(2)
    }
    barplot(table(floor(runif(100) * 6)))
  })

  output$plot2 <- renderPlot({
    input$refresh
    if (input$refresh > 0) {
      Sys.sleep(2)
    }
    plot(rnorm(50), rnorm(50))
  })


  observeEvent(input$modal, {
    showModal(modalDialog(
      title = "Works in modal too",
      actionButton("refresh2", "Refresh chart"),
      plotOutput(outputId = "plot3")
    ))
  })

  output$plot3 <- renderPlot({
    input$refresh2
    if (input$refresh2 > 0) {
      Sys.sleep(2)
    }
    hist(rnorm(500))
  })

}

if (interactive())
  shinyApp(ui, server)

