
#' @title Notifications
#'
#' @description Send notifications to the user.
#'
#' @param text Text to be displayed.
#' @param ... Options passed to JavaScript method, see https://notiflix.github.io/documentation.
#' @param type Type of notification: `success`, `failure`, `info` or `warning`.
#' @param session Default Shiny session.
#'
#' @return No value.
#' @export
#'
#' @examples
notify <- function(text,
                   ...,
                   type = c("success", "failure", "info", "warning"),
                   session = shiny::getDefaultReactiveDomain()) {
  type <- match.arg(type)
  insertUI(
    selector = "html",
    ui = tagList(html_dependency_notify()),
    immediate = TRUE,
    session = session
  )
  session$sendCustomMessage(
    type =  paste0("shinybusy-notify-", type),
    message = list(text = text, config = list(...))
  )
}
