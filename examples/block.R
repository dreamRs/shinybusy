library(shinybusy)
library(shiny)

ui <- fluidPage(

  tags$h3("Block Output"),


  fluidRow(
    column(
      width = 6,
      plotOutput(outputId = "plot1"),
      actionButton("block_manually", "Block / unblock")
    ),
    column(
      width = 6,
      plotOutput(outputId = "plot2"),
      actionButton("block_reac", "Block when calculating in reactive()")
    )
  )

)

server <- function(input, output, session) {

  output$plot1 <- renderPlot({
    barplot(table(floor(runif(100) * 6)))
  })

  observeEvent(input$block_manually, {
    if (input$block_manually %% 2 == 1) {
      block(id = "plot1", type = "pulse", svgColor = "#5ea4d8")
    } else {
      unblock(id = "plot1")
    }
  })

  data_r <- reactive({
    input$block_reac
    block(
      id = "plot2",
      type = "circle",
      text = "Calculating, please wait...",
      messageColor = "#FFF",
      svgColor = "#FFF",
      backgroundColor = "#5ea4d8"
    )
    Sys.sleep(3)
    data <- data.frame(x = rnorm(50), y = rnorm(50))
    unblock(id = "plot2", timeout = 300)
    return(data)
  })

  output$plot2 <- renderPlot({
    plot(data_r())
  })

}

if (interactive())
  shinyApp(ui, server)

