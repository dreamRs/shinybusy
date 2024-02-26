library(shinybusy)
library(shiny)
library(apexcharter)
library(reactable)

ui <- fluidPage(

  tags$h3("Block Output from UI"),

  actionButton("refresh", "Refresh outputs"),
  actionButton("open_modal", "Open modal"),

  fluidRow(
    column(
      width = 4,
      block_output(plotOutput(outputId = "plot1")),
      block_output(apexchartOutput(outputId = "apex1"))
    ),
    column(
      width = 4,
      block_output(plotOutput(outputId = "plot2"), type = "hourglass"),
      block_output(reactableOutput(outputId = "react1"), type = "hourglass", minHeight = 400)
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

  output$apex1 <- renderApexchart({
    input$refresh
    apex(data = mtcars, type = "scatter", mapping = aes(x = wt, y = mpg))
  })

  output$react1 <- renderReactable({
    input$refresh
    reactable(data = mtcars)
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

