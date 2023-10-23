
#' Block / unblock an UI element
#'
#' @param id Id of the element to block, for exemple an `outputId`.
#' @param text Text displayed below the blocking indicator.
#' @param type Type of blocking indicator.
#' @param ... Other configuration option, see [online documentation](https://notiflix.github.io/documentation#DocsBlock).
#' @param selector Custom CSS selector, if used `id` is ignored.
#' @param session Default Shiny session.
#'
#' @return No value.
#' @export
#'
#' @name block
#'
#' @example examples/block.R
block <- function(id,
                  text = "Loading",
                  type = c("standard", "hourglass", "circle", "arrows", "dots", "pulse"),
                  ...,
                  selector = NULL,
                  session = shiny::getDefaultReactiveDomain()) {
  type <- match.arg(type)
  insertUI(
    selector = "html",
    ui = tagList(html_dependency_block()),
    immediate = TRUE,
    where = "afterBegin",
    session = session
  )
  if (is.null(selector))
    selector <- paste0("#", session$ns(id))
  session$sendCustomMessage(
    type =  "shinybusy-block-output",
    message = list(
      selector = selector,
      type = type,
      text = text,
      config = list(...)
    )
  )
}

#' @param timeout Unblock after a delay.
#' @export
#'
#' @rdname block
unblock <- function(id,
                    selector = NULL,
                    timeout = 0,
                    session = shiny::getDefaultReactiveDomain()) {
  if (is.null(selector))
    selector <- paste0("#", session$ns(id))
  session$sendCustomMessage(
    type =  "shinybusy-unblock-output",
    message = list(
      selector = selector,
      timeout = timeout
    )
  )
}

