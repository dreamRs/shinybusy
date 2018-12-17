
#' @title Busy indicator (GIF)
#'
#' @description Make a GIF play when server is busy and stop when idle.
#'
#' @param src Path to the GIF, an URL or a file in www/ folder.
#' @param timeout Number of milliseconds after the server is busy to display the spinner.
#' @param position Where to display the spinner: \code{'top-right'}, \code{'top-left'}, \code{'bottom-right'},
#'  \code{'bottom-left'}, \code{'full-page'}.
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
add_busy_gif <- function(src, timeout = 100,
                         position = c("top-right", "top-left", "bottom-right", "bottom-left", "full-page"),
                         margins = c(10, 10),
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
  gif_tag <- tags$div(
    class = "shinybusy",
    style = style,
    style = paste0("height:", validateCssUnit(height), ";"),
    style = paste0("width:", validateCssUnit(width), ";"),
    tags$img(src = src, class = "freezeframe freezeframe-responsive shinybusy-freezeframe")
  )
  if (position == "full-page") {
    gif_tag <- tagList(
      tags$div(
        class = "shinybusy shinybusy-busy shinybusy-overlay"
      ),
      gif_tag
    )
  }
  gif_tag <- tagList(
    gif_tag,
    tags$script(
      type = "application/json",
      `data-for` = "shinybusy",
      toJSON(list(
        timeout = timeout, mode = "gif"
      ), auto_unbox = TRUE, json_verbatim = TRUE)
    )
  )
  attachDependencies(
    x = gif_tag,
    value = list(
      freezeframe_dependencies(),
      shinybusy_dependencies()
    )
  )
}


#' Silex logo for Shiny use
#'
#' @return Path to gif
#' @export
#'
logo_silex <- function() {
  "shinybusy/silex/logo_rouge.gif"
}



