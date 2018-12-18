
#' @title Busy indicator (Progress bar)
#'
#' @description Make a progress bar appear on top of the page.
#'
#' @param timeout Number of milliseconds after the server is busy to display the progress bar.
#' @param color Progress bar color.
#' @param centered Center the progress bar or not.
#' @param classname Additionnal CSS class for the progress bar, can be used for custom styles.
#'
#' @export
#'
#' @importFrom htmltools attachDependencies tags
#' @importFrom jsonlite toJSON
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinybusy)
#'
#'   ui <- fluidPage(
#'
#'     # Use this function somewhere in UI
#'     add_busy_bar(color = "#FF0000"),
#'
#'     headerPanel('Iris k-means clustering'),
#'
#'     tags$br(),
#'     actionButton("quick", "Quick calculation"),
#'     actionButton("sleep", "Long calculation")
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'     observeEvent(input$quick, {
#'       Sys.sleep(0.1)
#'     })
#'
#'     observeEvent(input$sleep, {
#'       Sys.sleep(5)
#'     })
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
add_busy_bar <- function(timeout = 1000, color = "#112446", centered = FALSE, classname = NULL) {
  classname <- "shinybusy-bar"
  if (!is.null(classname)) {
    classname <- classname
  }
  if (isTRUE(centered)) {
    classname <- "shinybusy-nanobar-centered"
  }
  nanobar_tag <- tags$style(
    sprintf(".%s .bar {background: %s}", classname, color)
  )
  nanobar_tag <- tagList(
    nanobar_tag,
    tags$script(
      type = "application/json",
      `data-for` = "shinybusy",
      toJSON(list(
        timeout = timeout, mode = "nanobar",
        classname = classname
      ), auto_unbox = TRUE, json_verbatim = TRUE)
    )
  )
  attachDependencies(
    x = nanobar_tag,
    value = list(
      nanobar_dependencies(),
      shinybusy_dependencies()
    )
  )
}



