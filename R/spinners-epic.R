
#' Epic spinners
#'
#' @param spin Name of the spinner.
#' @param color Color of the spinner.
#'
#' @return an HTML tag.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinybusy)
#'
#'   ui <- fluidPage(
#'     tags$h2("Epic spinners demo"),
#'
#'     fluidRow(
#'       column(
#'         width = 2,
#'         tags$b("flower"),
#'         spin_epic(color = "#FF8000"),
#'         tags$br(),
#'         tags$b("scaling-squares"),
#'         spin_epic("scaling-squares", color = "#FF8000")
#'       ),
#'       column(
#'         width = 2,
#'         tags$b("pixel"),
#'         spin_epic("pixel", color = "#FF8000"),
#'         tags$br(),
#'         tags$b("half-circle"),
#'         spin_epic("half-circle", color = "#FF8000")
#'       ),
#'       column(
#'         width = 2,
#'         tags$b("hollow-dots"),
#'         spin_epic("hollow-dots", color = "#FF8000"),
#'         tags$br(),
#'         tags$b("trinity-rings"),
#'         spin_epic("trinity-rings", color = "#FF8000")
#'       ),
#'       column(
#'         width = 2,
#'         tags$b("intersecting-circles"),
#'         spin_epic("intersecting-circles", color = "#FF8000"),
#'         tags$br(),
#'         tags$b("fulfilling-square"),
#'         spin_epic("fulfilling-square", color = "#FF8000")
#'       ),
#'       column(
#'         width = 2,
#'         tags$b("orbit"),
#'         spin_epic("orbit", color = "#FF8000")
#'       ),
#'       column(
#'         width = 2,
#'         tags$b("radar"),
#'         spin_epic("radar", color = "#FF8000")
#'       )
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
spin_epic <- function(spin = c("flower", "pixel", "hollow-dots",
                               "intersecting-circles", "orbit", "radar",
                               "scaling-squares", "half-circle", "trinity-rings",
                               "fulfilling-square"),
                      color = "#112446") {
  spin <- match.arg(arg = spin)

  bg_col <- paste0("background:", color, ";")
  col <- paste0("color:", color, ";")
  border_col <- paste0("border-color:", color, ";")

  if (identical(spin, "flower")) {
    epic <- tags$div(
      class = "flower-spinner",
      tags$div(
        class = "dots-container",
        tags$div(
          class = "bigger-dot",
          style = bg_col,
          style = col,
          tags$div(
            class = "smaller-dot",
            style = bg_col,
            style = col
          )
        )
      )
    )
  } else if (identical(spin, "pixel")) {
    epic <- tags$div(
      class = "pixel-spinner",
      tags$div(
        class = "pixel-spinner-inner",
        style = bg_col,
        style = col
      )
    )
  } else if (identical(spin, "hollow-dots")) {
    epic <- tags$div(
      class = "hollow-dots-spinner",
      tags$div(class = "dot", style = border_col),
      tags$div(class = "dot", style = border_col),
      tags$div(class = "dot", style = border_col)
    )
  } else if (identical(spin, "intersecting-circles")) {
    epic <- tags$div(
      class = "intersecting-circles-spinner",
      tags$div(
        class = "spinnerBlock",
        tags$span(class = "circle", style = border_col),
        tags$span(class = "circle", style = border_col),
        tags$span(class = "circle", style = border_col),
        tags$span(class = "circle", style = border_col),
        tags$span(class = "circle", style = border_col),
        tags$span(class = "circle", style = border_col),
        tags$span(class = "circle", style = border_col)
      )
    )
  } else if (identical(spin, "orbit")) {
    epic <- tags$div(
      class = "orbit-spinner",
      tags$div(
        class = "orbit",
        style = paste0("border-bottom-color:", color, ";")
      ),
      tags$div(
        class = "orbit",
        style = paste0("border-right-color:", color, ";")
      ),
      tags$div(
        class = "orbit",
        style = paste0("border-top-color:", color, ";")
      )
    )
  } else if (identical(spin, "radar")) {
    epic <- tags$div(
      class = "radar-spinner",
      tags$div(
        class = "circle",
        tags$div(
          class = "circle-inner-container",
          tags$div(
            class = "circle-inner",
            style = sprintf(
              "border-left-color: %s; border-right-color: %s;",
              color, color
            )
          )
        )
      ),
      tags$div(
        class = "circle",
        tags$div(
          class = "circle-inner-container",
          tags$div(
            class = "circle-inner",
            style = sprintf(
              "border-left-color: %s; border-right-color: %s;",
              color, color
            )
          )
        )
      ),
      tags$div(
        class = "circle",
        tags$div(
          class = "circle-inner-container",
          tags$div(
            class = "circle-inner",
            style = sprintf(
              "border-left-color: %s; border-right-color: %s;",
              color, color
            )
          )
        )
      ),
      tags$div(
        class = "circle",
        tags$div(
          class = "circle-inner-container",
          tags$div(
            class = "circle-inner",
            style = sprintf(
              "border-left-color: %s; border-right-color: %s;",
              color, color
            )
          )
        )
      )
    )
  } else if (identical(spin, "scaling-squares")) {
    epic <- tags$div(
      class = "scaling-squares-spinner",
      tags$div(class = "square", style = border_col),
      tags$div(class = "square", style = border_col),
      tags$div(class = "square", style = border_col),
      tags$div(class = "square", style = border_col)
    )
  } else if (identical(spin, "half-circle")) {
    epic <- tags$div(
      class = "half-circle-spinner",
      tags$div(
        class = "circle circle-1",
        style = paste0("border-top-color:", color, ";")
      ),
      tags$div(
        class = "circle circle-2",
        style = paste0("border-bottom-color:", color, ";")
      )
    )
  } else if (identical(spin, "trinity-rings")) {
    epic <- tags$div(
      class = "trinity-rings-spinner",
      tags$div(
        class = "circle", style = border_col
      ),
      tags$div(
        class = "circle", style = border_col
      ),
      tags$div(
        class = "circle", style = border_col
      )
    )
  } else if (identical(spin, "fulfilling-square")) {
    epic <- tags$div(
      class = "fulfilling-square-spinner",
      style = border_col,
      tags$div(
        class = "spinner-inner",
        style = bg_col
      )
    )
  }
  attachDependencies(epic, epic_spinners_dependencies())
}
