
#' @title Busy indicator (Progress bar)
#'
#' @description Make a progress bar appear on top of the page.
#'
#' @param timeout Number of milliseconds after the server is busy to display the progress bar.
#' @param color Progress bar color.
#' @param centered Center the progress bar or not.
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
add_busy_bar <- function(timeout = 1000, color = "#112446", centered = FALSE) {
  classname <- "shinybusy-nanobar"
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


#' @title Manual progress bar
#'
#' @description Declare \code{use_busy_bar} in your UI and update value server-side with \code{update_busy_bar}.
#'
#' @param color Progress bar color.
#' @param centered Center the progress bar or not.
#'
#' @export
#'
#' @name manual-progressbar
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinybusy)
#'
#'   ui <- fluidPage(
#'     tags$h2("Manual nanobar"),
#'     use_busy_bar(),
#'     actionButton(inputId = "go", label = "Go")
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'     observeEvent(input$go, {
#'       update_busy_bar(10)
#'       Sys.sleep(1)
#'       update_busy_bar(20)
#'       Sys.sleep(1)
#'       update_busy_bar(40)
#'       Sys.sleep(1)
#'       update_busy_bar(60)
#'       Sys.sleep(1)
#'       update_busy_bar(80)
#'       Sys.sleep(1)
#'       update_busy_bar(100)
#'     })
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
use_busy_bar <- function(color = "#112446", centered = FALSE) {
  classname <- "shinybusy-nanobar"
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
        mode = "nanobar", manual = TRUE,
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


#' @param value The new value for the progress bar.
#' @param session Shiny session.
#'
#' @rdname manual-progressbar
#' @export
#'
update_busy_bar <- function(value, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    type =  "update-nanobar",
    message = list(value = value)
  )
}


