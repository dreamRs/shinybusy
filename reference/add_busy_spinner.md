# Automatic busy indicator (spinner)

Add a spinner in an application each time the server take more 100
milliseconds to respond.

## Usage

``` r
add_busy_spinner(
  spin = "double-bounce",
  color = "#112446",
  timeout = 100,
  position = c("top-right", "top-left", "bottom-right", "bottom-left", "full-page"),
  onstart = TRUE,
  margins = c(10, 10),
  height = "50px",
  width = "50px"
)
```

## Arguments

- spin:

  Style of the spinner, see
  [`spin_epic`](https://dreamrs.github.io/shinybusy/reference/spin_epic.md)
  or
  [`spin_kit`](https://dreamrs.github.io/shinybusy/reference/spin_kit.md)
  for possible choices. Note that for `spin_epic`, height and width are
  ignored.

- color:

  Color for the spinner, in a valid CSS format.

- timeout:

  Number of milliseconds after the server is busy to display the
  spinner.

- position:

  Where to display the spinner: `'top-right'`, `'top-left'`,
  `'bottom-right'`, `'bottom-left'`, `'full-page'`.

- onstart:

  Logical, display the spinner when the application starts ?

- margins:

  Distance from margins, a vector of length two, where first element is
  distance from top/bottom, second element distance from right/left.

- height, width:

  Height and width of the spinner, default to `'50px'` for both, must be
  specified.

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(shinybusy)

  ui <- fluidPage(

    # Use this function somewhere in UI
    add_busy_spinner(spin = "cube-grid"),
    # or use a different spinner
    # add_busy_spinner(spin = "radar", margins = c(10, 20)),

    headerPanel('Iris k-means clustering'),

    sidebarLayout(
      sidebarPanel(
        selectInput('xcol', 'X Variable', names(iris)),
        selectInput('ycol', 'Y Variable', names(iris),
                    selected=names(iris)[[2]]),
        numericInput('clusters', 'Cluster count', 3,
                     min = 1, max = 9),
        actionButton("sleep", "Long calculation")
      ),
      mainPanel(
        plotOutput('plot1')
      )
    )
  )

  server <- function(input, output, session) {

    selectedData <- reactive({
      iris[, c(input$xcol, input$ycol)]
    })

    clusters <- reactive({
      kmeans(selectedData(), input$clusters)
    })

    output$plot1 <- renderPlot({
      palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
                "#FF7F00", "#FFFF33", "#A65628", "#F781BF",
                "#999999"))

      par(mar = c(5.1, 4.1, 0, 1))
      plot(selectedData(),
           col = clusters()$cluster,
           pch = 20, cex = 3)
      points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    })

    observeEvent(input$sleep, {
      Sys.sleep(5)
    })

  }

  shinyApp(ui, server)
}
```
