# Full-page loading indicator

Show a loading indicator over the whole page from the server, update its
text and remove it when the computation is finished.

## Usage

``` r
show_loading(
  text = "Loading...",
  type = c("standard", "hourglass", "circle", "arrows", "dots", "pulse"),
  ...,
  session = shiny::getDefaultReactiveDomain()
)

update_loading(text, session = shiny::getDefaultReactiveDomain())

remove_loading(timeout = 0, session = shiny::getDefaultReactiveDomain())
```

## Arguments

- text:

  Text displayed below the indicator, a single character string or
  `NULL` for no text.

- type:

  Type of loading indicator.

- ...:

  Other configuration options, see [online
  documentation](https://notiflix.github.io/documentation#DocsLoading).

- session:

  Default Shiny session.

- timeout:

  Delay in milliseconds before the indicator is removed.

## Value

No value.

## Details

Only one indicator can be displayed at a time in a page, it is shared by
all modules. Use
[`block()`](https://dreamrs.github.io/shinybusy/reference/block.md) to
block a specific element instead.

## References

Loading module from [Notiflix](https://github.com/notiflix/Notiflix)
library.

## Examples

``` r
library(shinybusy)
library(shiny)

ui <- fluidPage(
  tags$h3("Full-page loading indicator"),
  actionButton("start", "Start a long calculation"),
  verbatimTextOutput("result")
)

server <- function(input, output, session) {

  result <- reactiveVal("Nothing yet")

  observeEvent(input$start, {
    show_loading(
      text = "Calculating, please wait...",
      type = "circle",
      svgColor = "#5ea4d8",
      messageColor = "#FFF"
    )
    # always remove the indicator, even if the calculation fails
    tryCatch({
      Sys.sleep(2)
      update_loading("Almost done...")
      Sys.sleep(2)
      result("Done!")
    }, finally = remove_loading(timeout = 300))
  })

  output$result <- renderPrint(result())

}

if (interactive())
  shinyApp(ui, server)
```
