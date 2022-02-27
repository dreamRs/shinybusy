
#' @title Automatic busy indicator (GIF)
#'
#' @description Make a GIF play when server is busy and stop when idle.
#'
#' @param src Path to the GIF, an URL or a file in www/ folder.
#' @param timeout Number of milliseconds after the server is busy to display the GIF.
#' @param position Where to display the GIF: \code{'top-right'}, \code{'top-left'}, \code{'bottom-right'},
#'  \code{'bottom-left'}, \code{'full-page'}.
#' @param margins Distance from margins, a vector of length two, where first element is distance from top/bottom,
#'  second element distance from right/left.
#' @param overlay_color Background color for the overlay if \code{position = "full-page"}.
#' @param overlay_css Additional CSS for the overlay, for example \code{"z-index: 1000;"} to make it appear above everything.
#' @param height,width Height and width of the spinner, default to \code{'50px'} for both, must be specified.
#'
#' @export
#'
#' @return An HTML tag that should be used in UI.
#'
#' @importFrom htmltools validateCssUnit attachDependencies tags
#' @importFrom jsonlite toJSON
#'
#' @example examples/add_busy_gif.R
add_busy_gif <- function(src, timeout = 100,
                         position = c("top-right", "top-left", "bottom-right", "bottom-left", "full-page", "free"),
                         margins = c(10, 10),
                         overlay_color = "rgba(0, 0, 0, 0.5)",
                         overlay_css = NULL,
                         height = "50px",
                         width = "50px") {
  busy_gif(
    src = src,
    timeout = timeout,
    position = position,
    margins = margins,
    overlay_color = overlay_color,
    overlay_css = overlay_css,
    height = height,
    width = width,
    type = "auto"
  )
}


#' Manual busy indicator (GIF)
#'
#' @inheritParams add_busy_gif
#'
#' @export
#'
#' @return An HTML tag that should be used in UI.
#'
#' @name manual-gif
#'
#' @example examples/use_busy_gif.R
use_busy_gif <- function(src, timeout = 100,
                         position = c("top-right", "top-left", "bottom-right", "bottom-left", "full-page", "free"),
                         margins = c(10, 10),
                         overlay_color = "rgba(0, 0, 0, 0.5)",
                         overlay_css = NULL,
                         height = "50px",
                         width = "50px") {
  busy_gif(
    src = src,
    timeout = timeout,
    position = position,
    margins = margins,
    overlay_color = overlay_color,
    overlay_css = overlay_css,
    height = height,
    width = width,
    type = "manual"
  )
}

#' @param session Shiny session.
#'
#' @export
#'
#' @rdname manual-gif
play_gif <- function(session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    type =  "shinybusy-play-gif",
    message = dropNulls(list())
  )
}


#' @export
#'
#' @rdname manual-gif
stop_gif <- function(session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    type = "shinybusy-stop-gif",
    message = dropNulls(list())
  )
}


busy_gif <- function(src,
                     timeout = 100,
                     position = c("top-right", "top-left", "bottom-right", "bottom-left", "full-page", "free"),
                     margins = c(10, 10),
                     overlay_color = "rgba(0, 0, 0, 0.5)",
                     overlay_css = NULL,
                     height = "50px",
                     width = "50px",
                     type = "auto") {
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
        timeout = timeout,
        mode = "gif",
        position = position,
        type = type
      ), auto_unbox = TRUE, json_verbatim = TRUE)
    )
  )
  attachDependencies(
    x = gif_tag,
    value = list(
      html_dependency_busy()
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



