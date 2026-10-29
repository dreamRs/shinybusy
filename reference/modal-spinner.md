# Show a modal with a spinner

Make a pop-up window appear from the server with a spinner during long
computation, remove it when finished.

## Usage

``` r
show_modal_spinner(
  spin = "double-bounce",
  color = "#112446",
  text = NULL,
  session = shiny::getDefaultReactiveDomain()
)

remove_modal_spinner(session = getDefaultReactiveDomain())

update_modal_spinner(text, session = shiny::getDefaultReactiveDomain())
```

## Arguments

- spin:

  Style of the spinner, see
  [`spin_epic()`](https://dreamrs.github.io/shinybusy/reference/spin_epic.md)
  or
  [`spin_kit()`](https://dreamrs.github.io/shinybusy/reference/spin_kit.md)
  for possible choices.

- color:

  Color for the spinner, in a valid CSS format.

- text:

  Additional text to appear under the spinner.

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
      show_modal_spinner()
      Sys.sleep(5)
      remove_modal_spinner()
    })

    observeEvent(input$sleep2, {
      show_modal_spinner(
        spin = "cube-grid",
        color = "firebrick",
        text = "Please wait..."
      )
      Sys.sleep(5)
      remove_modal_spinner()
    })

  }

  shinyApp(ui, server)

}
```
