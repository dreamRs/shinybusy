
#' Block / unblock an UI element
#'
#' @param id Id of the element to block, for exemple an `outputId`.
#' @param text Text displayed below the blocking indicator. Must be a single character string.
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
  if (!(is.character(text) && length(text) == 1L)) stop("\"text\" must be a character of length 1\"")
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


#' Block an output
#'
#' Block an output until it is recalculated.
#'
#' @param output An output element.
#' @inheritParams block
#' @inheritParams unblock
#' @param minHeight Set a minimal height to the ouptut element.
#'
#' @return A `shiny.tag` or `shiny.tag.list` object (the `output` element modified).
#' @export
#'
#' @importFrom htmltools tagAppendAttributes attachDependencies css validateCssUnit
#'
#' @example examples/block_output.R
block_output <- function(output,
                         type = c("standard", "hourglass", "circle", "arrows", "dots", "pulse"),
                         text = "Loading...",
                         timeout = 0,
                         ...,
                         minHeight = NULL) {
  type <- match.arg(type)
  stopifnot("\"text\" must be a character of length 1\"" = is.character(text) && length(text) == 1L)
  if (inherits(output, "shiny.tag")) {
    output <- tagAppendAttributes(
      output,
      class = "shinybusy-block-element",
      `data-shinybusy-block-type` = type,
      `data-shinybusy-block-text` = text,
      `data-shinybusy-block-timeout` = timeout,
      `data-shinybusy-block-config` = jsonlite::toJSON(list(...)),
      style = css(minHeight = validateCssUnit(minHeight))
    )
  } else if (inherits(output, "shiny.tag.list")) {
    output[[1]] <- tagAppendAttributes(
      output[[1]],
      class = "shinybusy-block-element",
      `data-shinybusy-block-type` = type,
      `data-shinybusy-block-text` = text,
      `data-shinybusy-block-timeout` = timeout,
      `data-shinybusy-block-config` = jsonlite::toJSON(list(...)),
      style = css(minHeight = validateCssUnit(minHeight))
    )
  }
  attachDependencies(output, html_dependency_block(), append = TRUE)
}


