
#' @title SpinKit spinners
#'
#' @description Via \url{https://tobiasahlin.com/spinkit/}.
#'
#' @param spin Name of the spinner.
#' @param color Color of the spinner.
#' @param style If not \code{NULL}, add a div container with specified style.
#'
#' @return an HTML tag.
#' @export
#'
#' @importFrom htmltools tags tagList attachDependencies
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinybusy)
#'
#'   ui <- fluidPage(
#'     tags$h2("SpinKit demo"),
#'     fluidRow(lapply(
#'       X = c(
#'         "circle", "bounce", "folding-cube", "rotating-plane", "cube-grid",
#'         "fading-circle", "double-bounce", "dots", "cube"
#'       ),
#'       FUN = function(x) {
#'         column(
#'           width = 2,
#'           tags$b(x),
#'           tags$div(
#'             style = "width: 60px; height: 60px; position: relative;",
#'             spin_kit(spin = x)
#'           )
#'         )
#'       }
#'     ))
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
spin_kit <- function(spin = c("double-bounce", "circle", "bounce",
                              "folding-cube", "rotating-plane", "cube-grid",
                              "fading-circle", "dots", "cube"),
                     color = "#112446", style = NULL) {
  spin <- match.arg(arg = spin)
  alea <- paste(sample(letters, 12, T), collapse = "")
  if (spin == "circle") {
    tagSpin <- tagList(
      tags$style(
        sprintf(
          ".sk-circle .sk-child-%s:before {background-color: %s;}",
          alea, color
        )
      ),
      tags$div(
        class = "sk-circle",
        lapply(
          X = seq_len(12),
          FUN = function(i) {
            tags$div(
              class = sprintf("sk-circle%s sk-child sk-child-%s", i, alea)
            )
          }
        )
      )
    )
  } else if (spin == "double-bounce") {
    tagSpin <- tagList(
      tags$div(class = "double-bounce1", style = sprintf("background-color: %s;", color)),
      tags$div(class = "double-bounce2", style = sprintf("background-color: %s;", color))
    )
  } else if (spin == "folding-cube") {
    tagSpin <- tagList(
      tags$style(
        sprintf(
          ".sk-folding-cube .sk-cube-%s:before {background-color: %s;}",
          alea, color
        )
      ),
      tags$div(
        class="sk-folding-cube",
        tags$div(class=sprintf("sk-cube1 sk-cube sk-cube-%s", alea)),
        tags$div(class=sprintf("sk-cube2 sk-cube sk-cube-%s", alea)),
        tags$div(class=sprintf("sk-cube4 sk-cube sk-cube-%s", alea)),
        tags$div(class=sprintf("sk-cube3 sk-cube sk-cube-%s", alea))
      )
    )
  } else if (spin == "rotating-plane") {
    tagSpin <- tags$div(
      class="rotating-plane",
      style = sprintf("background-color: %s;", color)
    )
  } else if (spin == "cube-grid") {
    tagSpin <- tags$div(
      class="sk-cube-grid",
      lapply(
        X = seq_len(9),
        FUN = function(i) {
          tags$div(
            style = sprintf("background-color: %s;", color),
            class=sprintf("sk-cube sk-cube%s", i)
          )
        }
      )
    )
  } else if (spin == "fading-circle") {
    tagSpin <- tagList(
      tags$style(
        sprintf(
          ".sk-fading-circle .sk-circle-%s:before {background-color: %s;}",
          alea, color
        )
      ),
      tags$div(
        class="sk-fading-circle",
        lapply(
          X = seq_len(12),
          FUN = function(i) {
            tags$div(
              class=sprintf("sk-circle%s sk-circle sk-circle-%s", i, alea)
            )
          }
        )
      )
    )
  } else if (spin == "bounce") {
    tagSpin <- tags$div(
      class="spinner-bounce",
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="bounce1"
      ),
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="bounce2"
      ),
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="bounce3"
      )
    )
  } else if (spin == "dots") {
    tagSpin <- tags$div(
      class="spinner-dots",
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="dot1"
      ),
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="dot2"
      )
    )
  } else if (spin == "cube") {
    tagSpin <- tags$div(
      class="spinner-cube",
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="cube1"
      ),
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="cube2"
      )
    )
  }

  if (!is.null(style)) {
    tagSpin <- tags$div(
      style = style,
      tagSpin
    )
  }

  attachDependencies(tagSpin, html_dependency_spinkit())
}


spinkit_spinners <- function() {
  c("double-bounce", "circle", "bounce",
    "folding-cube", "rotating-plane", "cube-grid",
    "fading-circle", "dots", "cube")
}


