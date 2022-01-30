
#' @title Busy indicator at start up
#'
#' @description Show a full-page busy indicator when application is initialized,
#'  then removed it after timeout, automatically or manually from server.
#'
#' @param loader A spinner created with \code{\link{spin_epic}} or \code{\link{spin_kit}}
#'  or a simple HTML tag, to include a GIF (see examples).
#' @param text Optional text to be displayed under the loading animation.
#' @param mode How to remove the start-up page: \code{"timeout"}, \code{"auto"} or \code{"manual"}, see below for details.
#' @param timeout Time (in milliseconds) to wait before removing the start-up page.
#' @param color Color of text.
#' @param background Background color.
#'
#' @return HTML tag that can be included in UI definition.
#'
#' @details
#' Behavior according to `mode` argument:
#'
#'  * **timeout**: Busy indicator will be removed after the time (in milliseconds) specified in `timeout`.
#'  * **manual**: Busy indicator will be removed with `remove_start_up` from server,
#'   timeout from `busy_start_up` is ignored in favor of that of `remove_start_up`.
#'  * **auto**: Busy indicator is removed after JavaScript `shiny:idle` is triggered
#'   for the first time, `timeout` is taken into account.
#'
#' When using `timeout` or `auto`, you can still remove the busy indicator with `remove_start_up`.
#'
#' @export
#'
#' @name busy-start-up
#'
#' @importFrom htmltools tags tagList tagAppendAttributes
#' @importFrom jsonlite toJSON
#'
#' @example examples/start-up-timeout.R
#'
#' @example examples/start-up-manual.R
#'
#' @example examples/start-up-auto.R
busy_start_up <- function(loader,
                          text = NULL,
                          mode = c("timeout", "auto", "manual"),
                          timeout = 500,
                          color = "#112446",
                          background = "#f0f0f0") {
  if (!inherits(loader, "shiny.tag"))
    stop("loader must be an HTML tag object!")
  mode <- match.arg(mode)
  loader <- tagAppendAttributes(
    loader, style = "margin: auto;"
  )
  tagList(
    html_dependency_startup(),
    tags$div(
      class = "shinybusy-startup",
      style = paste0("background-color:", background, ";"),
      tags$div(
        class = "shinybusy-startup-content",
        style = paste0("color:", color, ";"),
        loader,
        tags$br(),
        text
      )
    ),
    tags$script(
      type = "application/json",
      `data-for` = "shinybusy-start-up",
      toJSON(list(
        mode = mode,
        timeout = timeout
      ), auto_unbox = TRUE, json_verbatim = TRUE)
    )
  )
}


#' @param session Shiny session.
#'
#' @export
#'
#' @rdname busy-start-up
#'
#' @importFrom shiny getDefaultReactiveDomain
remove_start_up <- function(timeout = 100, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    type =  "shinybusy-remove-start-up",
    message = list(timeout = timeout)
  )
}

