# Show a modal with a progress bar

Make a pop-up window appear from the server with a spinner during long
computation, remove it when finished.

## Usage

``` r
show_modal_progress_line(
  value = 0,
  text = "auto",
  color = "#112446",
  stroke_width = 4,
  easing = "linear",
  duration = 1000,
  trail_color = "#eee",
  trail_width = 1,
  height = "15px",
  session = shiny::getDefaultReactiveDomain()
)

show_modal_progress_circle(
  value = 0,
  text = "auto",
  color = "#112446",
  stroke_width = 4,
  easing = "linear",
  duration = 1000,
  trail_color = "#eee",
  trail_width = 1,
  height = "200px",
  session = shiny::getDefaultReactiveDomain()
)

remove_modal_progress(session = getDefaultReactiveDomain())

update_modal_progress(
  value,
  text = NULL,
  session = shiny::getDefaultReactiveDomain()
)
```

## Arguments

- value:

  Initial value or new value to set.

- text:

  Text to display.

- color:

  Main color.

- stroke_width:

  Main width.

- easing:

  CSS animation to use, ex.: `"linear"`, `"easeIn"`, `"easeOut"`,
  `"easeInOut"`.

- duration:

  Animation duration (in milliseconds).

- trail_color:

  Color of shape behind the main bar.

- trail_width:

  Width of shape behind the main bar.

- height:

  Container height.

- session:

  The `session` object passed to function given to `shinyServer`.

## Examples

``` r
if (interactive()) {

  library(shiny)
  library(shinybusy)

  ui <- fluidPage(

    tags$h1("Modal with progress bar"),
    actionButton("sleep1", "Launch a long calculation"),
    actionButton("sleep2", "And another one (different line options)"),
    tags$br(),
    actionButton("sleep3", "With a circle progress bar"),
    actionButton("sleep4", "With different circle options)")
  )

  server <- function(input, output, session) {

    observeEvent(input$sleep1, {
      show_modal_progress_line()
      for (i in 1:100) {
        update_modal_progress(
          value = i / 100
        )
        Sys.sleep(0.1)
      }
      remove_modal_progress()
    })

    observeEvent(input$sleep2, {
      show_modal_progress_line(
        color = "#DF0101",
        duration = 900,
        easing = "easeOut",
        text = "Starting computation"
      )
      Sys.sleep(0.1)
      for (i in 1:100) {
        update_modal_progress(
          value = i / 100,
          text = paste("Process", trunc(i/10), sprintf("(%02d%%)", i))
        )
        Sys.sleep(0.15)
      }
      remove_modal_progress()
    })


    observeEvent(input$sleep3, {
      show_modal_progress_circle()
      for (i in 1:100) {
        update_modal_progress(
          value = i / 100
        )
        Sys.sleep(0.1)
      }
      remove_modal_progress()
    })

    observeEvent(input$sleep4, {
      show_modal_progress_circle(
        color = "#DF0101",
        duration = 900,
        easing = "easeOut",
        text = "Starting computation",
        height = "300px"
      )
      Sys.sleep(0.1)
      for (i in 1:100) {
        update_modal_progress(
          value = i / 100,
          text = paste("Process", trunc(i/10), sprintf("(%02d%%)", i))
        )
        Sys.sleep(0.15)
      }
      remove_modal_progress()
    })

  }

  shinyApp(ui, server)

}
```
