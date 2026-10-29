# Automatic busy indicator (Progress bar)

Make a progress bar appear on top of the page.

## Usage

``` r
add_busy_bar(
  timeout = 1000,
  color = "#112446",
  centered = FALSE,
  height = "8px"
)
```

## Arguments

- timeout:

  Number of milliseconds after the server is busy to display the
  progress bar.

- color:

  Progress bar color.

- centered:

  Center the progress bar or not.

- height:

  Height of the bar.

## Examples

``` r
library(shiny)
library(shinybusy)

ui <- fluidPage(

  # Use this function somewhere in UI
  add_busy_bar(color = "#FF0000"),

  headerPanel('Iris k-means clustering'),

  tags$br(),
  actionButton("quick", "Quick calculation (nothing happens)"),
  actionButton("sleep", "Long calculation (progress bar on top)")
)

server <- function(input, output, session) {

  observeEvent(input$quick, {
    Sys.sleep(0.1)
  })

  observeEvent(input$sleep, {
    Sys.sleep(5)
  })

}

if (interactive()) {
  shinyApp(ui, server)
}
```
