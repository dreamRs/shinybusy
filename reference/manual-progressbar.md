# Manual busy indicator (progress bar)

Declare `use_busy_bar()` in your UI and update value server-side with
`update_busy_bar()`.

## Usage

``` r
use_busy_bar(color = "#112446", centered = FALSE, height = "8px")

update_busy_bar(value, session = shiny::getDefaultReactiveDomain())
```

## Arguments

- color:

  Progress bar color.

- centered:

  Center the progress bar or not.

- height:

  Height of the bar.

- value:

  The new value for the progress bar.

- session:

  Shiny session.

## Examples

``` r
library(shiny)
library(shinybusy)

ui <- fluidPage(
  tags$h2("Manual nanobar"),
  use_busy_bar(color = "#01DF01", height = "15px"),
  actionButton(inputId = "go", label = "Go"),
  sliderInput(
    inputId = "set", label = "Set progress",
    min = 0, value = 0, max = 100
  )
)

server <- function(input, output, session) {

  observeEvent(input$go, {
    update_busy_bar(0)
    for (i in 1:100) {
      Sys.sleep(0.1)
      update_busy_bar(i)
    }
  })

  observeEvent(input$set, {
    update_busy_bar(input$set)
  })

}

if (interactive()) {
  shinyApp(ui, server)
}
```
