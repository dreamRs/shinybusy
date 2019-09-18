
#' @importFrom htmltools tags tagList
epic_spin <- function(spin = c("flower", "pixel", "hollow-dots", "intersecting-circles", "orbit"), color = "#112446") {
  spin <- match.arg(arg = spin)

  bg_col <- paste0("background:", color, ";")
  col <- paste0("color:", color, ";")
  border_col <- paste0("border-color:", color, ";")

  if (identical(spin, "flower")) {
    spinTag <- tags$div(
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
    spinTag <- tags$div(
      class = "pixel-spinner",
      tags$div(
        class = "pixel-spinner-inner",
        style = bg_col,
        style = col
      )
    )
  } else if (identical(spin, "hollow-dots")) {
    spinTag <- tags$div(
      class = "hollow-dots-spinner",
      tags$div(class = "dot", style = border_col),
      tags$div(class = "dot", style = border_col),
      tags$div(class = "dot", style = border_col)
    )
  } else if (identical(spin, "intersecting-circles")) {
    spinTag <- tags$div(
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
    spinTag <- tags$div(
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
  }

  return(spinTag)
}
