
#' Full-page loading indicator
#'
#' Show a loading indicator over the whole page from the server, update its
#' text and remove it when the computation is finished.
#'
#' @param text Text displayed below the indicator, a single character string or `NULL` for no text.
#' @param type Type of loading indicator.
#' @param ... Other configuration options, see [online documentation](https://notiflix.github.io/documentation#DocsLoading).
#' @param timeout Delay in milliseconds before the indicator is removed.
#' @param session Default Shiny session.
#'
#' @details Only one indicator can be displayed at a time in a page, it is
#'  shared by all modules. Use [block()] to block a specific element instead.
#'
#' @return No value.
#' @export
#'
#' @name loading-overlay
#'
#' @references
#' Loading module from [Notiflix](https://github.com/notiflix/Notiflix) library.
#'
#' @example examples/loading-overlay.R
show_loading <- function(text = "Loading...",
                         type = c("standard", "hourglass", "circle", "arrows", "dots", "pulse"),
                         ...,
                         session = shiny::getDefaultReactiveDomain()) {
  type <- match.arg(type)
  if (!is.null(text)) check_text(text)
  config <- list(...)
  if (length(config) > 0 && (is.null(names(config)) || any(names(config) == ""))) {
    stop("all arguments in \"...\" must be named", call. = FALSE)
  }
  # an empty named list is serialized as {} instead of []
  if (length(config) == 0) names(config) <- character(0)
  insertUI(
    selector = "html",
    ui = tagList(html_dependency_loading_overlay()),
    immediate = TRUE,
    where = "afterBegin",
    session = session
  )
  session$sendCustomMessage(
    type = "shinybusy-loading-show",
    message = dropNulls(list(
      type = type,
      text = text,
      config = config
    ))
  )
}

#' @export
#' @rdname loading-overlay
update_loading <- function(text,
                           session = shiny::getDefaultReactiveDomain()) {
  check_text(text)
  session$sendCustomMessage(
    type = "shinybusy-loading-update",
    message = list(text = text)
  )
}

#' @export
#' @rdname loading-overlay
remove_loading <- function(timeout = 0,
                           session = shiny::getDefaultReactiveDomain()) {
  if (!(is.numeric(timeout) && length(timeout) == 1L && is.finite(timeout) && timeout >= 0)) {
    stop("\"timeout\" must be a single non-negative number", call. = FALSE)
  }
  session$sendCustomMessage(
    type = "shinybusy-loading-remove",
    message = list(timeout = timeout)
  )
}

check_text <- function(text) {
  if (!(is.character(text) && length(text) == 1L && !is.na(text))) {
    stop("\"text\" must be a character of length 1", call. = FALSE)
  }
}
