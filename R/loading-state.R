
#' @title Loading state for Shiny Outputs
#'
#' @description Call this function once in your UI to automatically
#'  add loading indicators to several outputs when they are being regenerated.
#'
#' @param selector CSS selector to match outputs, for example use \code{".shiny-plot-output"}
#'  to select all \code{plotOutput()} in your application, or \code{"#my_chart"} to select
#'  a specific output. You can use a vector to select multiple outputs.
#' @param spinner Name of the spinner to use.
#' @param text An optional text to be displayed under the spinner.
#' @param timeout In milliseconds, time after the output has been regenerated for removing the loading state.
#' @param svgColor Changes the SVG Icons color. You can use HEX, RGB or RGBA.
#' @param svgSize Changes the SVG Icons width and height.
#' @param messageColor Changes the color of the message text.
#' @param messageFontSize Changes the font-size of the message text.
#' @param backgroundColor Changes the background color. You can use HEX, RGB or RGBA.
#' @param ... Other options passed to the JavaScript method, see this link
#'  for all available options: \url{https://www.notiflix.com/documentation/}.
#'
#'
#' @note This function is experimental, if you encounter bugs or bad behavior,
#'  please report issue here : \url{https://github.com/dreamRs/shinybusy/issues}.
#'
#' @return An HTML tag that you can use in Shiny UI.
#' @export
#'
#' @importFrom htmltools singleton tags
#' @importFrom jsonlite toJSON
#' @importFrom tools toTitleCase
#'
#' @example examples/loading-state.R
add_loading_state <- function(selector,
                              spinner = c("standard", "hourglass", "circle",
                                          "arrows", "dots", "pulse"),
                              text = NULL,
                              timeout = 600,
                              svgColor = "#383838",
                              svgSize = "45px",
                              messageColor = "#383838",
                              messageFontSize = "14px",
                              backgroundColor = "rgba(255,255,255,0.9)",
                              ...) {
  spinner <- match.arg(arg = spinner)
  tagList(
    tags$head(
      singleton(tags$style(".shinybusy-block.recalculating {opacity: 1 !important;}"))
    ),
    tags$script(
      type = "application/json",
      `data-for` = "shinybusy-loading-state",
      toJSON(list(
        selector = paste(selector, collapse = ", "),
        spinner = spinner,
        text = text,
        timeout = timeout,
        options = dropNulls(list(
          svgColor = svgColor,
          svgSize = svgSize,
          messageColor = messageColor,
          messageFontSize = messageFontSize,
          backgroundColor = backgroundColor,
          ...
        ))
      ), auto_unbox = TRUE, json_verbatim = TRUE)
    ),
    html_dependency_loading()
  )
}
