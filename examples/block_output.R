library(shinybusy)
library(shiny)

ui <- fluidPage(
  tags$h3("Block Output from UI"),
  actionButton("refresh", "Refresh outputs"),
  actionButton("open_modal", "Open modal"),
  fluidRow(
    column(
      width = 4,
      block_output(plotOutput(outputId = "plot1"))
    ),
    column(
      width = 4,
      block_output(
        plotOutput(outputId = "plot2"),
        type = "hourglass",
        messageColor = "#FFF",
        svgColor = "#FFF",
        svgSize = "70px",
        backgroundColor = "#5ea4d8"
      )
    ),
    column(
      width = 4,
      plotOutput(outputId = "plot3")
    )
  )
)

server <- function(input, output, session) {

  output$plot1 <- renderPlot({
    input$refresh
    barplot(table(floor(runif(100) * 6)))
  })

  data_r <- reactive({
    input$refresh
    Sys.sleep(3)
    data <- data.frame(x = rnorm(50), y = rnorm(50))
    return(data)
  })

  output$plot2 <- renderPlot({
    plot(data_r())
  })

  output$plot3 <- renderPlot({
    plot(data_r(), main = "Not blocked")
  })


  observeEvent(input$open_modal, {
    showModal(modalDialog(
      block_output(plotOutput(outputId = "plot_modal")),
      actionButton("refresh_modal", "Refresh plot")
    ))
  })

  output$plot_modal <- renderPlot({
    input$refresh_modal
    Sys.sleep(1)
    barplot(table(floor(runif(100) * 6)))
  })
}

if (interactive())
  shinyApp(ui, server)

