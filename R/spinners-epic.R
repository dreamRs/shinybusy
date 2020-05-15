
#' @title Epic spinners
#'
#' @description Via \url{https://epic-spinners.epicmax.co/}.
#'
#' @param spin Name of the spinner.
#' @param color Color of the spinner.
#'
#' @return an HTML tag.
#' @export
#'
#' @importFrom htmltools tags attachDependencies
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinybusy)
#'
#'   ui <- fluidPage(
#'     tags$h2("Epic spinner demo"),
#'     lapply(
#'       X = c(
#'         "flower", "pixel", "hollow-dots",
#'         "intersecting-circles", "orbit", "radar",
#'         "scaling-squares", "half-circle",
#'         "fulfilling-square", "circles-to-rhombuses"
#'       ),
#'       FUN = function(x) {
#'         tags$div(
#'           style = "display: table-cell; width: 150px; height: 100px; margin: 10px;",
#'           tags$b(x),
#'           spin_epic(x, color = "#08298A")
#'         )
#'       }
#'     ),
#'     tags$hr(),
#'     lapply(
#'       X = c(
#'         "semipolar", "self-building-square", "swapping-squares",
#'         "fulfilling-bouncing-circle", "fingerprint", "spring",
#'         "atom", "looping-rhombuses", "breeding-rhombus", "trinity-rings"
#'       ),
#'       FUN = function(x) {
#'         tags$div(
#'           style = "display: table-cell; width: 150px; height: 100px; margin: 10px;",
#'           tags$b(x),
#'           spin_epic(x, color = "#08298A")
#'         )
#'       }
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
                               "fulfilling-square", "circles-to-rhombuses",
                               "semipolar", "self-building-square", "swapping-squares",
                               "fulfilling-bouncing-circle", "fingerprint", "spring",
                               "atom", "looping-rhombuses", "breeding-rhombus"),
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
  } else if (identical(spin, "circles-to-rhombuses")) {
    epic <- tags$div(
      class = "circles-to-rhombuses-spinner",
      tags$div(
        class = "circle",
        style = border_col
      ),
      tags$div(
        class = "circle",
        style = border_col
      ),
      tags$div(
        class = "circle",
        style = border_col
      )
    )
  } else if (identical(spin, "semipolar")) {
    epic <- tags$div(
      class = "semipolar-spinner",
      tags$div(
        class = "ring",
        style = sprintf(
          "border-left-color: %s; border-top-color: %s;",
          color, color
        )
      ),
      tags$div(
        class = "ring",
        style = sprintf(
          "border-left-color: %s; border-top-color: %s;",
          color, color
        )
      ),
      tags$div(
        class = "ring",
        style = sprintf(
          "border-left-color: %s; border-top-color: %s;",
          color, color
        )
      ),
      tags$div(
        class = "ring",
        style = sprintf(
          "border-left-color: %s; border-top-color: %s;",
          color, color
        )
      ),
      tags$div(
        class = "ring",
        style = sprintf(
          "border-left-color: %s; border-top-color: %s;",
          color, color
        )
      )
    )
  } else if (identical(spin, "self-building-square")) {
    epic <- tags$div(
      class = "self-building-square-spinner",
      tags$div(
        class="square",
        style = bg_col
      ),
      tags$div(
        class="square",
        style = bg_col
      ),
      tags$div(
        class="square",
        style = bg_col
      ),
      tags$div(
        class="square clear",
        style = bg_col
      ),
      tags$div(
        class="square",
        style = bg_col
      ),
      tags$div(
        class="square",
        style = bg_col
      ),
      tags$div(
        class="square clear",
        style = bg_col
      ),
      tags$div(
        class="square",
        style = bg_col
      ),
      tags$div(
        class="square",
        style = bg_col
      )
    )
  } else if (identical(spin, "swapping-squares")) {
    epic <- tags$div(
      class = "swapping-squares-spinner",
      tags$div(
        class = "square",
        style = border_col
      ),
      tags$div(
        class = "square",
        style = border_col
      ),
      tags$div(
        class = "square",
        style = border_col
      ),
      tags$div(
        class = "square",
        style = border_col
      )
    )
  } else if (identical(spin, "fulfilling-bouncing-circle")) {
    epic <- tags$div(
      class = "fulfilling-bouncing-circle-spinner",
      tags$div(
        class = "circle",
        style = col
      ),
      tags$div(
        class = "orbit",
        style = border_col
      )
    )
  } else if (identical(spin, "fingerprint")) {
    epic <- tags$div(
      class = "fingerprint-spinner",
      tags$div(
        class = "spinner-ring",
        style = sprintf(
          "border-top-color: %s;",
          color
        )
      ),
      tags$div(
        class = "spinner-ring",
        style = sprintf(
          "border-top-color: %s;",
          color
        )
      ),
      tags$div(
        class = "spinner-ring",
        style = sprintf(
          "border-top-color: %s;",
          color
        )
      ),
      tags$div(
        class = "spinner-ring",
        style = sprintf(
          "border-top-color: %s;",
          color
        )
      ),
      tags$div(
        class = "spinner-ring",
        style = sprintf(
          "border-top-color: %s;",
          color
        )
      ),
      tags$div(
        class = "spinner-ring",
        style = sprintf(
          "border-top-color: %s;",
          color
        )
      ),
      tags$div(
        class = "spinner-ring",
        style = sprintf(
          "border-top-color: %s;",
          color
        )
      ),
      tags$div(
        class = "spinner-ring",
        style = sprintf(
          "border-top-color: %s;",
          color
        )
      )
    )
  } else if (identical(spin, "spring")) {
    epic <- tags$div(
      class = "spring-spinner",
      tags$div(
        class = "spring-spinner-part top",
        tags$div(
          class = "spring-spinner-rotator",
          style = sprintf(
            "border-right-color: %s; border-top-color: %s;",
            color, color
          )
        )
      ),
      tags$div(
        class = "spring-spinner-part bottom",
        tags$div(
          class = "spring-spinner-rotator",
          style = sprintf(
            "border-right-color: %s; border-top-color: %s;",
            color, color
          )
        )
      )
    )
  } else if (identical(spin, "atom")) {
    epic <- tags$div(
      class = "atom-spinner",
      tags$div(
        class = "spinner-inner",
        tags$div(
          class = "spinner-line",
          style = sprintf(
            "border-left-color: %s;",
            color
          )
        ),
        tags$div(
          class = "spinner-line",
          style = sprintf(
            "border-left-color: %s;",
            color
          )
        ),
        tags$div(
          class = "spinner-line",
          style = sprintf(
            "border-left-color: %s;",
            color
          )
        ),
        tags$div(
          class = "spinner-circle",
          style = col,
          HTML("&#9679;")
        )
      )
    )
  } else if (identical(spin, "looping-rhombuses")) {
    epic <- tags$div(
      class = "looping-rhombuses-spinner",
      tags$div(
        class = "rhombus",
        style = bg_col
      ),
      tags$div(
        class = "rhombus",
        style = bg_col
      ),
      tags$div(
        class = "rhombus",
        style = bg_col
      )
    )
  } else if (identical(spin, "breeding-rhombus")) {
    epic <- tags$div(
      class = "breeding-rhombus-spinner",
      tags$div(
        class = "rhombus child-1",
        style = bg_col
      ),
      tags$div(
        class = "rhombus child-2",
        style = bg_col
      ),
      tags$div(
        class = "rhombus child-3",
        style = bg_col
      ),
      tags$div(
        class = "rhombus child-4",
        style = bg_col
      ),
      tags$div(
        class = "rhombus child-5",
        style = bg_col
      ),
      tags$div(
        class = "rhombus child-6",
        style = bg_col
      ),
      tags$div(
        class = "rhombus child-7",
        style = bg_col
      ),
      tags$div(
        class = "rhombus child-8",
        style = bg_col
      ),
      tags$div(
        class = "rhombus big",
        style = bg_col
      )
    )
  }
  attachDependencies(epic, html_dependency_epic())
}



epic_spinners <- function() {
  c("flower", "pixel", "hollow-dots",
    "intersecting-circles", "orbit", "radar",
    "scaling-squares", "half-circle", "trinity-rings",
    "fulfilling-square", "circles-to-rhombuses",
    "semipolar", "self-building-square", "swapping-squares",
    "fulfilling-bouncing-circle", "fingerprint", "spring",
    "atom", "looping-rhombuses", "breeding-rhombus")
}



