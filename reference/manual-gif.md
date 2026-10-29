# Manual busy indicator (GIF)

Manual busy indicator (GIF)

## Usage

``` r
use_busy_gif(
  src,
  timeout = 100,
  position = c("top-right", "top-left", "bottom-right", "bottom-left", "full-page",
    "free"),
  margins = c(10, 10),
  overlay_color = "rgba(0, 0, 0, 0.5)",
  overlay_css = NULL,
  height = "50px",
  width = "50px"
)

play_gif(session = shiny::getDefaultReactiveDomain())

stop_gif(session = shiny::getDefaultReactiveDomain())
```

## Arguments

- src:

  Path to the GIF, an URL or a file in www/ folder.

- timeout:

  Number of milliseconds after the server is busy to display the GIF.

- position:

  Where to display the GIF: `'top-right'`, `'top-left'`,
  `'bottom-right'`, `'bottom-left'`, `'full-page'`.

- margins:

  Distance from margins, a vector of length two, where first element is
  distance from top/bottom, second element distance from right/left.

- overlay_color:

  Background color for the overlay if `position = "full-page"`.

- overlay_css:

  Additional CSS for the overlay, for example `"z-index: 1000;"` to make
  it appear above everything.

- height, width:

  Height and width of the spinner, default to `'50px'` for both, must be
  specified.

- session:

  Shiny session.

## Value

An HTML tag that should be used in UI.

## Examples

``` r
library(shiny)
library(shinybusy)

ui <- fluidPage(

  # Use this function somewhere in UI
  use_busy_gif(
    src = "https://jeroen.github.io/images/banana.gif",
    height = 70, width = 70
  ),

  actionButton("play", "Play GIF"),
  actionButton("stop", "Stop GIF")
)

server <- function(input, output, session) {

  observeEvent(input$play, {
    play_gif()
  })

  observeEvent(input$stop, {
    stop_gif()
  })

}

if (interactive()) {
  shinyApp(ui, server)
}
```
