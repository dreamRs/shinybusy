
#' @title Automatic busy indicator (Progress bar)
#'
#' @description Make a progress bar appear on top of the page.
#'
#' @param timeout Number of milliseconds after the server is busy to display the progress bar.
#' @param color Progress bar color.
#' @param centered Center the progress bar or not.
#' @param height Height of the bar.
#'
#' @export
#'
#'
#' @example examples/add_busy_bar.R
add_busy_bar <- function(timeout = 1000, color = "#112446", centered = FALSE, height = "8px") {
  busy_bar(color = color, centered = FALSE, timeout = timeout, height = height)
}


#' @title Manual busy indicator (progress bar)
#'
#' @description Declare `use_busy_bar()` in your UI and update value server-side with `update_busy_bar()`.
#'
#' @inheritParams add_busy_bar
#'
#' @export
#'
#' @name manual-progressbar
#'
#' @example examples/use_busy_bar.R
use_busy_bar <- function(color = "#112446", centered = FALSE, height = "8px") {
  busy_bar(color = color, centered = FALSE, type = "manual", height = height)
}


#' @param value The new value for the progress bar.
#' @param session Shiny session.
#'
#' @rdname manual-progressbar
#' @export
#'
update_busy_bar <- function(value, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    type =  "shinybusy-update-nanobar",
    message = list(value = value)
  )
}


#' @importFrom htmltools attachDependencies tags tagList
#' @importFrom jsonlite toJSON
busy_bar <- function(timeout = 1000, color = "#112446", height = "8px", centered = FALSE, type = "auto") {
  classname <- "shinybusy-nanobar"
  if (isTRUE(centered)) {
    classname <- "shinybusy-nanobar-centered"
  }
  nanobar_tag <- tags$style(
    sprintf(".%s .bar {background: %s; height: %s;}",
            classname, color, validateCssUnit(height))
  )
  nanobar_tag <- tagList(
    nanobar_tag,
    tags$script(
      type = "application/json",
      `data-for` = "shinybusy",
      toJSON(list(
        timeout = timeout, mode = "nanobar",
        classname = classname, type = type
      ), auto_unbox = TRUE, json_verbatim = TRUE)
    )
  )
  attachDependencies(
    x = nanobar_tag,
    value = list(
      html_dependency_busy()
    )
  )
}
