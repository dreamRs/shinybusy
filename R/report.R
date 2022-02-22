
#' @title Reports
#'
#' @description  show extended notifications that contain a title, description to the user.
#'
#' @param title Title of the report.
#' @param text Text to be displayed.
#' @param button Label for the button.
#' @param ... Options passed to JavaScript method, see
#'  [https://notiflix.github.io/documentation](https://notiflix.github.io/documentation).
#' @param type Type of notification: `success`, `failure`, `info` or `warning`.
#' @param session Default Shiny session.
#'
#' @return No value.
#'
#' @references
#' Report module from [Notiflix](https://github.com/notiflix/Notiflix) library.
#' More documentation and examples are available on the official website:
#'  [https://notiflix.github.io/report](https://notiflix.github.io/report).
#'
#' @export
#'
#' @name report
#'
#' @importFrom htmltools doRenderTags
#'
#' @example examples/report.R
report <- function(title,
                   text,
                   button = "Ok",
                   ...,
                   type = c("success", "failure", "info", "warning"),
                   session = shiny::getDefaultReactiveDomain()) {
  stopifnot("'title' must be a character string" = is.character(title))
  stopifnot(
    "'text' must be a character string" = inherits(text, c("character", "shiny.tag", "shiny.tag.list"))
  )
  stopifnot("'button' must be a character string" = is.character(button))
  type <- match.arg(type)
  config <- list(...)
  if (inherits(text, c("shiny.tag", "shiny.tag.list"))) {
    config$plainText <- FALSE
    text <- doRenderTags(text)
  }
  insertUI(
    selector = "html",
    ui = tagList(html_dependency_report()),
    immediate = TRUE,
    where = "afterBegin",
    session = session
  )
  session$sendCustomMessage(
    type =  paste0("shinybusy-report-", type),
    message = list(
      title = title,
      text = text,
      button = button,
      config = config
    )
  )
}


#' @export
#'
#' @rdname report
report_success <- function(title,
                           text,
                           button = "Ok",
                           ...) {
  report(
    title = title,
    text = text,
    button = button,
    type = "success",
    ...
  )
}


#' @export
#'
#' @rdname report
report_failure <- function(title,
                           text,
                           button = "Ok",
                           ...) {
  report(
    title = title,
    text = text,
    button = button,
    type = "failure",
    ...
  )
}

#' @export
#'
#' @rdname report
report_info <- function(title,
                        text,
                        button = "Ok",
                        ...) {
  report(
    title = title,
    text = text,
    button = button,
    type = "info",
    ...
  )
}

#' @export
#'
#' @rdname report
report_warning <- function(title,
                           text,
                           button = "Ok",
                           ...) {
  report(
    title = title,
    text = text,
    button = button,
    type = "warning",
    ...
  )
}

