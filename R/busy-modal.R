
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
    tags$script(
      "$('.shinybusy-modal').parent().css('margin-top', '40vh');"
    ),
    spinner_dependencies(),
    tags$div(
      style = "width: 60px; height: 60px; position: relative; margin: auto;",
      spinner(spin = spin, color = color)
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




