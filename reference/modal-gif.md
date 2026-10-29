# Show a modal with a GIF

Make a pop-up window appear from the server with a GIF during long
computation, remove it when finished.

## Usage

``` r
show_modal_gif(
  src,
  text = NULL,
  height = "100px",
  width = "100px",
  modal_size = "s",
  session = shiny::getDefaultReactiveDomain()
)

remove_modal_gif(session = getDefaultReactiveDomain())
```

## Arguments

- src:

  Path to the GIF, an URL or a file in www/ folder.

- text:

  Additional text to appear under the spinner.

- height, width:

  Height and width of the spinner, default to `'50px'` for both, must be
  specified.

- modal_size:

  One of `"s"` for small (the default), `"m"` for medium, or `"l"` for
  large.

- session:

  The `session` object passed to function given to `shinyServer`.

## Examples

``` r
if (interactive()) {

  library(shiny)
  library(shinybusy)

  ui <- fluidPage(

    tags$h1("Modal with spinner"),
    actionButton("sleep1", "Launch a long calculation"),
    actionButton("sleep2", "And another one")
  )

  server <- function(input, output, session) {

    observeEvent(input$sleep1, {
      show_modal_gif(
        src = "https://jeroen.github.io/images/banana.gif"
      )
      Sys.sleep(5)
      remove_modal_gif()
    })

    observeEvent(input$sleep2, {
      show_modal_gif(
        src = "https://jeroen.github.io/images/banana.gif",
        width = "300px", height = "300px",
        modal_size = "m",
        text = "Please wait..."
      )
      Sys.sleep(5)
      remove_modal_gif()
    })

  }

  shinyApp(ui, server)

}
```
