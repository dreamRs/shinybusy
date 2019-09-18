
#' @title Show a modal with a spinner
#'
#' @description Make a pop-up window appear from the server
#'  with a spinner during long computation, remove it when finished.
#'
#' @param spin Style of the spinner, choice between : \code{circle}, \code{bounce}, \code{folding-cube},
#'  \code{rotating-plane}, \code{cube-grid}, \code{fading-circle}, \code{double-bounce}, \code{dots}, \code{cube}.
#' @param color Color for the spinner, in a valid CSS format.
#' @param text Additional text to appear under the spinner.
#' @param session The \code{session} object passed to function given to \code{shinyServer}.
#'
#' @export
#'
#' @importFrom shiny showModal modalDialog getDefaultReactiveDomain
#'
#' @name modal-spinner
#'
#' @examples
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shinybusy)
#'
#'   ui <- fluidPage(
#'
#'     tags$h1("Modal with spinner"),
#'     actionButton("sleep1", "Launch a long calculation"),
#'     actionButton("sleep2", "And another one")
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'     observeEvent(input$sleep1, {
#'       show_modal_spinner()
#'       Sys.sleep(5)
#'       remove_modal_spinner()
#'     })
#'
#'     observeEvent(input$sleep2, {
#'       show_modal_spinner(
#'         spin = "cube-grid",
#'         color = "firebrick",
#'         text = "Please wait..."
#'       )
#'       Sys.sleep(5)
#'       remove_modal_spinner()
#'     })
#'
#'   }
#'
#'   shinyApp(ui, server)
#'
#' }
show_modal_spinner <- function(spin = "double-bounce",
                               color = "#112446",
                               text = NULL,
                               session = shiny::getDefaultReactiveDomain()) {
  showModal(modalDialog(
    class = "shinybusy-modal",
    js_center_modal(),
    spinner_dependencies(),
    tags$div(
      style = "width: 60px; height: 60px; position: relative; margin: auto;",
      spin_kit(spin = spin, color = color)
    ),
    tags$div(
      style = "text-align: center;", text
    ),
    footer = NULL,
    easyClose = FALSE,
    fade = FALSE,
    size = "s"
  ), session = session)
}

#' @export
#' @importFrom shiny removeModal
#' @rdname modal-spinner
remove_modal_spinner <- shiny::removeModal







#' @title Show a modal with a progress bar
#'
#' @description Make a pop-up window appear from the server
#'  with a spinner during long computation, remove it when finished.
#'
#' @inheritParams shinyWidgets::progressBar
#' @param session The \code{session} object passed to function given to \code{shinyServer}.
#'
#' @export
#'
#' @importFrom shiny showModal modalDialog getDefaultReactiveDomain
#' @importFrom shinyWidgets progressBar
#'
#' @name modal-progress
#'
#' @examples
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shinybusy)
#'
#'   ui <- fluidPage(
#'
#'     tags$h1("Modal with progress bar"),
#'     actionButton("sleep1", "Launch a long calculation"),
#'     actionButton("sleep2", "And another one")
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'     observeEvent(input$sleep1, {
#'       show_modal_progress()
#'       for (i in 1:100) {
#'         update_modal_progress(
#'           value = i
#'         )
#'         Sys.sleep(0.1)
#'       }
#'       remove_modal_progress()
#'     })
#'
#'     observeEvent(input$sleep2, {
#'       show_modal_progress(
#'         display_pct = TRUE,
#'         status = "success",
#'         title = ""
#'       )
#'       for (i in 1:100) {
#'         update_modal_progress(
#'           value = i,
#'           title = paste("Process", trunc(i/10))
#'         )
#'         Sys.sleep(0.1)
#'       }
#'       remove_modal_progress()
#'     })
#'
#'   }
#'
#'   shinyApp(ui, server)
#'
#' }
show_modal_progress <- function(title = NULL, total = NULL, display_pct = FALSE,
                                size = NULL, status = NULL, striped = FALSE,
                                range_value = NULL, unit_mark = "%",
                                session = shiny::getDefaultReactiveDomain()) {
  showModal(modalDialog(
    class = "shinybusy-modal",
    style = if (is.null(title)) "margin-top: 20px;",
    js_center_modal(),
    progressBar(
      id = session$ns("shinybusy-progress"),
      value = 0, total = total,
      display_pct = display_pct, size = size,
      status = status, striped = striped,
      title = title, range_value = range_value,
      unit_mark = unit_mark
    ),
    footer = NULL,
    easyClose = FALSE,
    fade = FALSE,
    size = "m"
  ), session = session)
}

#' @export
#' @importFrom shiny removeModal
#' @rdname modal-progress
remove_modal_progress <- shiny::removeModal

#' @export
#' @importFrom shinyWidgets updateProgressBar
#' @rdname modal-progress
update_modal_progress <- function(value, total = NULL,
                                  title = NULL, status = NULL,
                                  range_value = NULL, unit_mark = "%",
                                  session = shiny::getDefaultReactiveDomain()) {
  updateProgressBar(
    session = session, id = "shinybusy-progress",
    value = value, total = total, title = title,
    status = status, range_value = range_value,
    unit_mark = unit_mark
  )
}







#' @title Show a modal with a GIF
#'
#' @description Make a pop-up window appear from the server
#'  with a GIF during long computation, remove it when finished.
#'
#' @param src Path to the GIF, an URL or a file in www/ folder.
#' @param text Additional text to appear under the spinner.
#' @param height,width Height and width of the spinner, default to \code{'50px'} for both, must be specified.
#' @param modal_size One of \code{"s"} for small (the default) , \code{"m"} for medium, or \code{"l"} for large.
#' @param session The \code{session} object passed to function given to \code{shinyServer}.
#'
#' @export
#'
#' @importFrom shiny showModal modalDialog getDefaultReactiveDomain
#' @importFrom htmltools validateCssUnit
#'
#' @name modal-gif
#'
#' @examples
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shinybusy)
#'
#'   ui <- fluidPage(
#'
#'     tags$h1("Modal with spinner"),
#'     actionButton("sleep1", "Launch a long calculation"),
#'     actionButton("sleep2", "And another one")
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'     observeEvent(input$sleep1, {
#'       show_modal_gif(
#'         src = "https://jeroen.github.io/images/banana.gif"
#'       )
#'       Sys.sleep(5)
#'       remove_modal_gif()
#'     })
#'
#'     observeEvent(input$sleep2, {
#'       show_modal_gif(
#'         src = "https://jeroen.github.io/images/banana.gif",
#'         width = "300px", height = "300px",
#'         modal_size = "m",
#'         text = "Please wait..."
#'       )
#'       Sys.sleep(5)
#'       remove_modal_gif()
#'     })
#'
#'   }
#'
#'   shinyApp(ui, server)
#'
#' }
show_modal_gif <- function(src,
                           text = NULL,
                           height = "100px", width = "100px",
                           modal_size = "s",
                           session = shiny::getDefaultReactiveDomain()) {
  showModal(modalDialog(
    class = "shinybusy-modal",
    style = "text-align: center;",
    js_center_modal(),
    tags$img(
      style = paste0("height:", validateCssUnit(height), ";"),
      style = paste0("width:", validateCssUnit(width), ";"),
      src = src
    ),
    tags$div(
      style = "text-align: center;", text
    ),
    footer = NULL,
    easyClose = FALSE,
    fade = FALSE,
    size = modal_size
  ), session = session)
}

#' @export
#' @importFrom shiny removeModal
#' @rdname modal-gif
remove_modal_gif <- shiny::removeModal






