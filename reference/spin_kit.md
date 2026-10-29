# SpinKit spinners

Via <https://tobiasahlin.com/spinkit/>.

## Usage

``` r
spin_kit(
  spin = c("double-bounce", "circle", "bounce", "folding-cube", "rotating-plane",
    "cube-grid", "fading-circle", "dots", "cube"),
  color = "#112446",
  style = NULL
)
```

## Arguments

- spin:

  Name of the spinner.

- color:

  Color of the spinner.

- style:

  If not `NULL`, add a div container with specified style.

## Value

an HTML tag.

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(shinybusy)

  ui <- fluidPage(
    tags$h2("SpinKit demo"),
    fluidRow(lapply(
      X = c(
        "circle", "bounce", "folding-cube", "rotating-plane", "cube-grid",
        "fading-circle", "double-bounce", "dots", "cube"
      ),
      FUN = function(x) {
        column(
          width = 2,
          tags$b(x),
          tags$div(
            style = "width: 60px; height: 60px; position: relative;",
            spin_kit(spin = x)
          )
        )
      }
    ))
  )

  server <- function(input, output, session) {

  }

  shinyApp(ui, server)
}
```
