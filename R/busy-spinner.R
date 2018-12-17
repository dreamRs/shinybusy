
#' @title Busy indicator (spinner)
#'
#' @description Add a spinner in an application to show the user that 'Shiny' is busy.
#'
#' @param spin Style of the spinner, choice between : \code{circle}, \code{bounce}, \code{folding-cube},
#'  \code{rotating-plane}, \code{cube-grid}, \code{fading-circle}, \code{double-bounce}, \code{dots}, \code{cube}.
#' @param color Color for the spinner, in a valid CSS format.
#' @param timeout Number of milliseconds after the server is busy to display the spinner.
#' @param position Where to display the spinner: \code{'top-right'}, \code{'top-left'}, \code{'bottom-right'},
#'  \code{'bottom-left'}, \code{'full-page'}.
#' @param onstart Logical, display the spinner when the application starts ?
#' @param margins Distance from margins, a vector of length two, where first element is distance from top/bottom,
#'  second element distance from right/left.
#' @param height,width Height and width ot the spinner, default to \code{'50px'} for both, must be specified.
#'
#' @export
#'
#' @importFrom htmltools validateCssUnit attachDependencies tags
#' @importFrom jsonlite toJSON
#'
#' @examples
#' if (interactive()) {
#'
#'
#' }
add_busy_spinner <- function(spin = "double-bounce", color = "#112446", timeout = 100,
                             position = c("top-right", "top-left", "bottom-right", "bottom-left", "full-page"),
                             onstart = TRUE, margins = c(10, 10),
                             height = "50px", width = "50px") {
  stopifnot(length(margins) == 2)
  marg1 <- validateCssUnit(margins[1])
  marg2 <- validateCssUnit(margins[2])
  position <- match.arg(position)
  style <- switch(
    EXPR = position,
    "top-right" = sprintf("top:%s; right:%s;", marg1, marg2),
    "top-left" = sprintf("top:%s; left:%s;", marg1, marg2),
    "bottom-right" = sprintf("bottom:%s; right:%s;", marg1, marg2),
    "bottom-left" = sprintf("bottom:%s; left:%s;", marg1, marg2),
    "full-page" = "top:0; bottom:0; right:0; left:0; margin:auto;"
  )
  spin_tag <- tags$div(
    class = "shinybusy",
    class = if (isTRUE(onstart)) "shinybusy-busy" else "shinybusy-ready",
    style = style,
    style = paste0("height:", validateCssUnit(height), ";"),
    style = paste0("width:", validateCssUnit(width), ";"),
    spinner(spin = spin, color = color)
  )
  if (position == "full-page") {
    spin_tag <- tagList(
      tags$div(
        class = "shinybusy shinybusy-busy shinybusy-overlay"
      ),
      spin_tag
    )
  }
  spin_tag <- tagList(
    spin_tag,
    tags$script(
      type = "application/json",
      `data-for` = "shinybusy",
      toJSON(list(
        timeout = timeout
      ), auto_unbox = TRUE, json_verbatim = TRUE)
    )
  )
  attachDependencies(
    x = spin_tag,
    value = list(
      spinner_dependencies(),
      shinybusy_dependencies()
    )
  )
}



#' @importFrom htmltools tags tagList
spinner <- function(spin = "double-bounce", color = "#112446") {
  spin <- match.arg(
    arg = spin, choices = c(
      "circle", "bounce", "folding-cube", "rotating-plane", "cube-grid",
      "fading-circle", "double-bounce", "dots", "cube"
    )
  )
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

  tagSpin
}

