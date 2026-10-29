# Busy indicator at start up

Show a full-page busy indicator when application is initialized, then
removed it after timeout, automatically or manually from server.

## Usage

``` r
busy_start_up(
  loader,
  text = NULL,
  mode = c("timeout", "auto", "manual"),
  timeout = 500,
  color = "#112446",
  background = "#f0f0f0"
)

remove_start_up(timeout = 100, session = shiny::getDefaultReactiveDomain())
```

## Arguments

- loader:

  A spinner created with
  [`spin_epic`](https://dreamrs.github.io/shinybusy/reference/spin_epic.md)
  or
  [`spin_kit`](https://dreamrs.github.io/shinybusy/reference/spin_kit.md)
  or a simple HTML tag, to include a GIF (see examples).

- text:

  Optional text to be displayed under the loading animation.

- mode:

  How to remove the start-up page: `"timeout"`, `"auto"` or `"manual"`,
  see below for details.

- timeout:

  Time (in milliseconds) to wait before removing the start-up page.

- color:

  Color of text.

- background:

  Background color.

- session:

  Shiny session.

## Value

HTML tag that can be included in UI definition.

## Details

Behavior according to `mode` argument:

- **timeout**: Busy indicator will be removed after the time (in
  milliseconds) specified in `timeout`.

- **manual**: Busy indicator will be removed with `remove_start_up` from
  server, timeout from `busy_start_up` is ignored in favor of that of
  `remove_start_up`.

- **auto**: Busy indicator is removed after JavaScript `shiny:idle` is
  triggered for the first time, `timeout` is taken into account.

When using `timeout` or `auto`, you can still remove the busy indicator
with `remove_start_up`.

## Examples

``` r
# with timeout ------------------------------------------------------------

library(shiny)
library(shinybusy)

ui <- fluidPage(

  busy_start_up(
    loader = spin_epic("orbit", color = "#FFF"),
    text = "Loading...",
    timeout = 1500,
    color = "#FFF",
    background = "#112446"
  ),

  tags$h1("Ready to play!", class = "text-center")

)

server <- function(input, output, session) {

}

if (interactive())
  shinyApp(ui, server)

# manual ------------------------------------------------------------------

library(shiny)
library(shinybusy)

ui <- fluidPage(

  busy_start_up(
    loader = spin_kit(
      spin = "cube-grid",
      color = "#FFF",
      style = "width:50px; height:50px;"
    ),
    text = "Loading...",
    mode = "manual",
    color = "#FFF",
    background = "#112446"
  ),

  tags$h1("Ready to play!", class = "text-center")

)

server <- function(input, output, session) {

  # Remove after 3 seconds (+timeout)
  observe({
    Sys.sleep(3)
    remove_start_up(timeout = 200)
  })

}

if (interactive())
  shinyApp(ui, server)


# auto & GIF --------------------------------------------------------------

library(shiny)
library(shinybusy)

ui <- fluidPage(

  busy_start_up(
    loader = tags$img(
      src = "https://jeroen.github.io/images/banana.gif",
      width = 100
    ),
    text = "Loading...",
    mode = "auto"
  ),

  tags$h1("Ready to play!", class = "text-center"),
  plotOutput(outputId = "plot")

)

server <- function(input, output, session) {

  output$plot <- renderPlot({
    Sys.sleep(2)
    plot(rnorm(100))
  })

}

if (interactive())
  shinyApp(ui, server)
```
