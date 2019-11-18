# Default usage
progress_line(value = 0.5)

# change color
progress_line(value = 0.5, color = "firebrick")

# Circle
progress_circle(value = 0.5)


# Shiny usage
if (interactive()) {
  library(shiny)
  library(shinybusy)

  ui <- fluidPage(
    tags$h2("Progress bars examples"),
    fluidRow(
      column(
        width = 4,
        tags$p("Default bar:"),
        progress_line(value = 0, shiny_id = "bar"),
        sliderInput(
          inputId = "update_bar",
          label = "Update:",
          min = 0, max = 1,
          value = 0, step = 0.1
        ),
        tags$p("Set custom text:"),
        progress_line(
          value = 0.5,
          text = "To update",
          shiny_id = "text"
        ),
        textInput(
          inputId = "update_text",
          label = "Update:"
        )
      ),
      column(
        width = 4,
        tags$p("Default circle:"),
        progress_circle(value = 0, shiny_id = "circle"),
        sliderInput(
          inputId = "update_circle",
          label = "Update:",
          min = 0, max = 1,
          value = 0, step = 0.1,
          width = "100%"
        )
      ),
      column(
        width = 4,
        tags$p("Default semi-circle:"),
        progress_semicircle(value = 0, shiny_id = "semicircle"),
        sliderInput(
          inputId = "update_semicircle",
          label = "Update:",
          min = 0, max = 1,
          value = 0, step = 0.1,
          width = "100%"
        )
      )
    )
  )

  server <- function(input, output, session) {

    observe({
      update_progress("bar", input$update_bar)
    })

    observe({
      update_progress("circle", input$update_circle)
    })

    observe({
      update_progress("semicircle", input$update_semicircle)
    })

    observe({
      req(input$update_text)
      update_progress("text", 0.5, input$update_text)
    })

  }

  shinyApp(ui, server)
}
