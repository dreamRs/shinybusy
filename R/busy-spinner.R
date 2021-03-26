
#' @title Automatic busy indicator (spinner)
#'
#' @description Add a spinner in an application each time the server take more 100 milliseconds to respond.
#'
#' @param spin Style of the spinner, see \code{\link{spin_epic}} or \code{\link{spin_kit}}
#'  for possible choices. Note that for \code{spin_epic}, height and width are ignored.
#' @param color Color for the spinner, in a valid CSS format.
#' @param timeout Number of milliseconds after the server is busy to display the spinner.
#' @param position Where to display the spinner: \code{'top-right'}, \code{'top-left'}, \code{'bottom-right'},
#'  \code{'bottom-left'}, \code{'full-page'}.
#' @param onstart Logical, display the spinner when the application starts ?
#' @param margins Distance from margins, a vector of length two, where first element is distance from top/bottom,
#'  second element distance from right/left.
#' @param height,width Height and width of the spinner, default to \code{'50px'} for both, must be specified.
#'
#' @export
#'
#'
#' @example examples/add_busy_spinner.R
add_busy_spinner <- function(spin = "double-bounce",
                             color = "#112446",
                             timeout = 100,
                             position = c("top-right", "top-left", "bottom-right", "bottom-left", "full-page"),
                             onstart = TRUE,
                             margins = c(10, 10),
                             height = "50px",
                             width = "50px") {
  busy_spinner(
    spin = spin, color = color, timeout = timeout,
    position = position, onstart = onstart,
    margins = margins, height = height, width = width
  )
}






#' @title Manual busy indicator (spinner)
#'
#' @description Declare \code{use_busy_spinner} in your UI and show/hide
#'  server-side with \code{show_spinner}/\code{hide_spinner}.
#'
#' @inheritParams add_busy_spinner
#' @param spin_id An explicit id for the spinner, useful if you want to use multiple spinners.
#'
#' @export
#'
#' @name manual-spinner
#'
#' @example examples/use_busy_spinner.R
use_busy_spinner <- function(spin = "double-bounce",
                             color = "#112446",
                             position = c("top-right", "top-left", "bottom-right", "bottom-left", "full-page"),
                             margins = c(10, 10),
                             spin_id = NULL,
                             height = "50px",
                             width = "50px") {
  busy_spinner(
    spin = spin, color = color, timeout = 1000,
    position = position, onstart = FALSE,
    margins = margins, height = height, width = width,
    type = "manual", spin_id = spin_id
  )
}


#' @param session Shiny session.
#'
#' @export
#'
#' @rdname manual-spinner
show_spinner <- function(spin_id = NULL, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    type =  "shinybusy-show-spinner",
    message = dropNulls(list(spin_id = spin_id))
  )
}


#' @export
#'
#' @rdname manual-spinner
hide_spinner <- function(spin_id = NULL, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    type =  "shinybusy-hide-spinner",
    message = dropNulls(list(spin_id = spin_id))
  )
}


spin_onstart <- function(spin = "double-bounce", color = "#112446",
                         height = "100px", width = "100px") {
  busy_spinner(
    spin = spin, color = color,
    position = "full-page", type = "start",
    height = height, width = width
  )
}


#' @importFrom htmltools validateCssUnit attachDependencies tags tagList
#' @importFrom jsonlite toJSON
busy_spinner <- function(spin = "double-bounce",
                         color = "#112446",
                         timeout = 100,
                         position = c("top-right", "top-left", "bottom-right", "bottom-left", "full-page"),
                         onstart = TRUE,
                         margins = c(10, 10),
                         height = "50px",
                         width = "50px",
                         type = "auto",
                         spin_id = NULL) {
  spin <- match.arg(arg = spin, choices = c(spinkit_spinners(), epic_spinners()))
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
  if (is.null(spin_id)) {
    spin_id <- paste0("spin-", create_id())
  }
  if (spin %in% spinkit_spinners()) {
    spin_ <- spin_kit(spin = spin, color = color)
  } else {
    spin_ <- spin_epic(spin = spin, color = color)
  }
  spin_tag <- tags$div(
    class = "shinybusy",
    id = spin_id,
    class = if (isTRUE(onstart)) "shinybusy-busy" else "shinybusy-ready",
    style = style,
    style = paste0("height:", validateCssUnit(height), ";"),
    style = paste0("width:", validateCssUnit(width), ";"),
    spin_
  )
  if (position == "full-page") {
    spin_tag <- tagList(
      tags$div(
        id = paste0(spin_id, "_overlay"),
        class = "shinybusy shinybusy-overlay",
        class = if (isTRUE(onstart)) "shinybusy-busy" else "shinybusy-ready"
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
        timeout = timeout, mode = "spin",
        id = spin_id, type = type,
        position = position
      ), auto_unbox = TRUE, json_verbatim = TRUE)
    )
  )
  attachDependencies(
    x = spin_tag,
    value = list(
      html_dependency_shinybusy()
    ),
    append = TRUE
  )
}
