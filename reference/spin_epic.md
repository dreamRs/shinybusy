# Epic spinners

Via <https://epic-spinners.vuestic.dev/>.

## Usage

``` r
spin_epic(
  spin = c("flower", "pixel", "hollow-dots", "intersecting-circles", "orbit", "radar",
    "scaling-squares", "half-circle", "trinity-rings", "fulfilling-square",
    "circles-to-rhombuses", "semipolar", "self-building-square", "swapping-squares",
    "fulfilling-bouncing-circle", "fingerprint", "spring", "atom", "looping-rhombuses",
    "breeding-rhombus"),
  color = "#112446"
)
```

## Arguments

- spin:

  Name of the spinner.

- color:

  Color of the spinner.

## Value

an HTML tag.

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(shinybusy)

  ui <- fluidPage(
    tags$h2("Epic spinner demo"),
    lapply(
      X = c(
        "flower", "pixel", "hollow-dots",
        "intersecting-circles", "orbit", "radar",
        "scaling-squares", "half-circle",
        "fulfilling-square", "circles-to-rhombuses"
      ),
      FUN = function(x) {
        tags$div(
          style = "display: table-cell; width: 150px; height: 100px; margin: 10px;",
          tags$b(x),
          spin_epic(x, color = "#08298A")
        )
      }
    ),
    tags$hr(),
    lapply(
      X = c(
        "semipolar", "self-building-square", "swapping-squares",
        "fulfilling-bouncing-circle", "fingerprint", "spring",
        "atom", "looping-rhombuses", "breeding-rhombus", "trinity-rings"
      ),
      FUN = function(x) {
        tags$div(
          style = "display: table-cell; width: 150px; height: 100px; margin: 10px;",
          tags$b(x),
          spin_epic(x, color = "#08298A")
        )
      }
    )
  )

  server <- function(input, output, session) {

  }

  shinyApp(ui, server)
}
```
