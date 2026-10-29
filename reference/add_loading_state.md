# Loading state for Shiny Outputs

Call this function once in your UI to automatically add loading
indicators to several outputs when they are being regenerated.

## Usage

``` r
add_loading_state(
  selector,
  spinner = c("standard", "hourglass", "circle", "arrows", "dots", "pulse"),
  text = NULL,
  timeout = 600,
  svgColor = "#383838",
  svgSize = "45px",
  messageColor = "#383838",
  messageFontSize = "14px",
  backgroundColor = "rgba(255,255,255,0.9)",
  ...
)
```

## Arguments

- selector:

  CSS selector to match outputs, for example use `".shiny-plot-output"`
  to select all
  [`shiny::plotOutput()`](https://rdrr.io/pkg/shiny/man/plotOutput.html)
  in your application, or `"#my_chart"` to select a specific output. You
  can use a vector to select multiple outputs.

- spinner:

  Name of the spinner to use.

- text:

  An optional text to be displayed under the spinner.

- timeout:

  In milliseconds, time after the output has been regenerated for
  removing the loading state.

- svgColor:

  Changes the SVG Icons color. You can use HEX, RGB or RGBA.

- svgSize:

  Changes the SVG Icons width and height.

- messageColor:

  Changes the color of the message text.

- messageFontSize:

  Changes the font-size of the message text.

- backgroundColor:

  Changes the background color. You can use HEX, RGB or RGBA.

- ...:

  Other options passed to the JavaScript method, see [this
  link](https://notiflix.github.io/documentation) for all available
  options.

## Value

An HTML tag that you can use in Shiny UI.

## Note

This function is experimental, if you encounter bugs or bad behavior,
please report [issue here](https://github.com/dreamRs/shinybusy/issues).

## Examples

``` r
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
```
