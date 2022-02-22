
#' @title Reports
#'
#' @description  show extended notifications that contain a title, description to the user.
#'
#' @param title Title of the report.
#' @param text Text to be displayed.
#' @param ... Options passed to JavaScript method, see [config_report()].
#' @param button Label for the button.
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
                   ...,
                   button = "Ok",
                   type = c("success", "failure", "info", "warning"),
                   session = shiny::getDefaultReactiveDomain()) {
  stopifnot("'title' must be a character string" = is.character(title))
  stopifnot(
    "'text' must be a character string" = inherits(text, c("character", "shiny.tag", "shiny.tag.list"))
  )
  stopifnot("'button' must be a character string" = is.character(button))
  type <- match.arg(type)
  config <- list(...)
  idx <- vapply(X = config, FUN = inherits, what = "config_report", FUN.VALUE = logical(1))
  config <- c(config[!idx], unlist(config[idx], recursive = FALSE))
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
                           ...,
                           button = "Ok") {
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
                           ...,
                           button = "Ok") {
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
                        ...,
                        button = "Ok") {
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
                           ...,
                           button = "Ok") {
  report(
    title = title,
    text = text,
    button = button,
    type = "warning",
    ...
  )
}





#' @title Configure options for [report()] and others
#'
#' @description Options for [report()] functions, see
#'  [online documentation](https://notiflix.github.io/documentation)
#'  for default values and examples.
#'
#' @param svgColor Changes the built-in SVG icon color.
#' @param titleColor Changes the title text color.
#' @param messageColor Changes the message text color.
#' @param buttonBackground Changes the button background color.
#' @param buttonColor Changes the button text color.
#' @param backOverlayColor Changes the color of the background overlay.
#' @param className Changes the class name (attribute).
#' @param width Changes the width.
#' @param backgroundColor Changes the background color.
#' @param borderRadius Changes the radius of the corners.
#' @param rtl Specifies the text direction to "right-to-left".
#' @param zindex Changes the z-index.
#' @param backOverlay Adds a background overlay.
#' @param fontFamily Changes the font-family.
#' @param svgSize Changes the built-in SVG icons width and height. (Notiflix uses square scaled icons.)
#' @param plainText Strips all HTML tags.
#' @param titleFontSize Changes the font-size of the title text.
#' @param titleMaxLength The maximum length of the title text.
#' @param messageFontSize Changes the font-size of the message text.
#' @param messageMaxLength The maximum length of the message text.
#' @param buttonFontSize Changes the font-size of the button text.
#' @param buttonMaxLength The maximum length of the button text.
#' @param cssAnimation Enables/disables CSS animations to show/hide.
#' @param cssAnimationDuration Changes the CSS animations duration as milliseconds.
#' @param cssAnimationStyle 2 types of styles can be used: fade zoom.
#' @param ... Other potential arguments.
#'
#' @return A config `list` that can be used in [report()] and other `report_*` functions.
#' @export
#'
#' @example examples/config_report.R
config_report <- function(svgColor = NULL,
                          titleColor = NULL,
                          messageColor = NULL,
                          buttonBackground = NULL,
                          buttonColor = NULL,
                          backOverlayColor = NULL,
                          className = NULL,
                          width = NULL,
                          backgroundColor = NULL,
                          borderRadius = NULL,
                          rtl = NULL,
                          zindex = NULL,
                          backOverlay = NULL,
                          fontFamily = NULL,
                          svgSize = NULL,
                          plainText = NULL,
                          titleFontSize = NULL,
                          titleMaxLength = NULL,
                          messageFontSize = NULL,
                          messageMaxLength = NULL,
                          buttonFontSize = NULL,
                          buttonMaxLength = NULL,
                          cssAnimation = NULL,
                          cssAnimationDuration = NULL,
                          cssAnimationStyle = NULL,
                          ...) {
  config <- c(as.list(environment()), list(...))
  config$success <- config$failure <- dropNulls(config[1:6])
  config$info <- config$warning <- dropNulls(config[1:6])
  config[1:6] <- NULL
  config <- dropNulls(config)
  class(config) <- c(class(config), "config_report")
  return(config)
}





