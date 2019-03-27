
#' @title Busy indicator (GIF)
#'
#' @description Make a GIF play when server is busy and stop when idle.
#'
#' @param src Path to the GIF, an URL or a file in www/ folder.
#' @param timeout Number of milliseconds after the server is busy to display the Gif
#' @param position Where to display the spinner: \code{'top-right'}, \code{'top-left'}, \code{'bottom-right'},
#'  \code{'bottom-left'}, \code{'full-page'}.
#' @param margins Distance from margins, a vector of length two, where first element is distance from top/bottom,
#'  second element distance from right/left.
#' @param overlay_color Background color for the overlay if \code{position = "full-page"}.
#' @param overlay_css Additional CSS for the overlay, for example \code{"z-index: 1000;"} to make it appear of everything.
#' @param height,width Height and width ot the spinner, default to \code{'50px'} for both, must be specified.
#'
#' @export
#'
#' @importFrom htmltools validateCssUnit attachDependencies tags
#' @importFrom jsonlite toJSON
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinybusy)
#'
#'   ui <- fluidPage(
#'
#'     # Use this function somewhere in UI
#'     add_busy_gif(
#'       src = "https://jeroen.github.io/images/banana.gif",
#'       height = 70, width = 70
#'     ),
#'
#'     actionButton("sleep", "Long calculation")
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'     observeEvent(input$sleep, {
#'       Sys.sleep(5)
#'     })
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
add_busy_gif <- function(src, timeout = 100,
                         position = c("top-right", "top-left", "bottom-right", "bottom-left", "full-page", "free"),
                         margins = c(10, 10), overlay_color = "rgba(0, 0, 0, 0.5)", overlay_css = NULL,
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
    "full-page" = "top:0; bottom:0; right:0; left:0; margin:auto;",
    "free" = ""
  )
  gif_tag <- tags$div(
    class = "shinybusy",
    style = style,
    style = if (position != "full-page") paste0("height:", validateCssUnit(height), ";"),
    style = if (position != "full-page") paste0("width:", validateCssUnit(width), ";"),
    tags$img(
      src = src, class = "freezeframe freezeframe-responsive shinybusy-freezeframe",
      class = if (position == "full-page") "shinybusy-full-page"
    )
  )
  if (position == "full-page") {
    gif_tag <- tagList(
      tags$div(
        class = "shinybusy shinybusy-overlay",
        style = sprintf("background-color: %s;", overlay_color),
        style = if (!is.null(overlay_css)) overlay_css,
        gif_tag
      )
    )
  }
  gif_tag <- tagList(
    gif_tag,
    tags$script(
      type = "application/json",
      `data-for` = "shinybusy",
      toJSON(list(
        timeout = timeout, mode = "gif",
        position = position
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



