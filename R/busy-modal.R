
#' @title Show a modal with a spinner
#'
#' @description Make a pop-up window appear from the server
#'  with a spinner during long computation, remove it when finished.
#'
#' @param spin Style of the spinner, see [spin_epic()] or [spin_kit()] for possible choices.
#' @param color Color for the spinner, in a valid CSS format.
#' @param text Additional text to appear under the spinner.
#' @param session The `session` object passed to function given to `shinyServer`.
#'
#' @export
#'
#' @importFrom shiny showModal modalDialog getDefaultReactiveDomain
#'
#' @name modal-spinner
#'
#' @example examples/modal_spinner.R
show_modal_spinner <- function(spin = "double-bounce",
                               color = "#112446",
                               text = NULL,
                               session = shiny::getDefaultReactiveDomain()) {
  spin <- match.arg(arg = spin, choices = c(spinkit_spinners(), epic_spinners()))
  if (spin %in% spinkit_spinners()) {
    tag_spin <- spin_kit(spin = spin, color = color)
  } else {
    tag_spin <- spin_epic(spin = spin, color = color)
  }
  showModal(modalDialog(
    class = "shinybusy-modal",
    js_center_modal(),
    html_dependency_spinkit(),
    html_dependency_epic(),
    tags$div(
      class = "shinybusy-modal-spinner",
      style = "width: 60px; height: 60px; position: relative; margin: auto;",
      tag_spin
    ),
    tags$div(
      class = "shinybusy-modal-text",
      style = "text-align: center;",
      text
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

#' @export
#' @importFrom shiny getDefaultReactiveDomain removeUI insertUI
#' @rdname modal-spinner
update_modal_spinner <- function(text, session = shiny::getDefaultReactiveDomain()) {
  removeUI(selector = ".shinybusy-modal-text", immediate = TRUE, session = session)
  insertUI(
    selector = ".shinybusy-modal",
    where = "beforeEnd",
    immediate = TRUE,
    session = session,
    ui = tags$div(
      class = "shinybusy-modal-text",
      style = "text-align: center;",
      text
    )
  )
}




#' @title Show a modal with a progress bar
#'
#' @description Make a pop-up window appear from the server
#'  with a spinner during long computation, remove it when finished.
#'
#' @inheritParams progress
#' @param session The `session` object passed to function given to `shinyServer`.
#'
#' @export
#'
#' @importFrom shiny showModal modalDialog getDefaultReactiveDomain
#'
#' @name modal-progress
#'
#' @example examples/modal_progress.R
show_modal_progress_line <- function(value = 0, text = "auto",
                                     color = "#112446",
                                     stroke_width = 4,
                                     easing = "linear",
                                     duration = 1000,
                                     trail_color = "#eee",
                                     trail_width = 1,
                                     height = "15px",
                                     session = shiny::getDefaultReactiveDomain()) {
  showModal(modalDialog(
    class = "shinybusy-modal",
    js_center_modal(),
    progress_line(
      value = value,
      text = text,
      color = color,
      stroke_width = stroke_width,
      easing = easing,
      duration = duration,
      trail_color = trail_color,
      trail_width = trail_width,
      height = height,
      shiny_id = session$ns("shinybusy-modal-progress")
    ),
    footer = NULL,
    easyClose = FALSE,
    fade = FALSE,
    size = "m"
  ), session = session)
}

#' @export
#' @rdname modal-progress
show_modal_progress_circle <- function(value = 0, text = "auto",
                                       color = "#112446",
                                       stroke_width = 4,
                                       easing = "linear",
                                       duration = 1000,
                                       trail_color = "#eee",
                                       trail_width = 1,
                                       height = "200px",
                                       session = shiny::getDefaultReactiveDomain()) {
  showModal(modalDialog(
    class = "shinybusy-modal",
    js_center_modal(translateY = "-60%"),
    progress_circle(
      value = value,
      text = text,
      color = color,
      stroke_width = stroke_width,
      easing = easing,
      duration = duration,
      trail_color = trail_color,
      trail_width = trail_width,
      height = height, width = height,
      shiny_id = session$ns("shinybusy-modal-progress")
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
#' @rdname modal-progress
update_modal_progress <- function(value,
                                  text = NULL,
                                  session = shiny::getDefaultReactiveDomain()) {
  update_progress(
    shiny_id = "shinybusy-modal-progress",
    value = value,
    text = text,
    session = session
  )
}







#' @title Show a modal with a GIF
#'
#' @description Make a pop-up window appear from the server
#'  with a GIF during long computation, remove it when finished.
#'
#' @param src Path to the GIF, an URL or a file in www/ folder.
#' @param text Additional text to appear under the spinner.
#' @param height,width Height and width of the spinner, default to `'50px'` for both, must be specified.
#' @param modal_size One of `"s"` for small (the default), `"m"` for medium, or `"l"` for large.
#' @param session The `session` object passed to function given to `shinyServer`.
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
      class = "shinybusy-modal-gif",
      style = paste0("height:", validateCssUnit(height), ";"),
      style = paste0("width:", validateCssUnit(width), ";"),
      src = src
    ),
    tags$div(
      class = "shinybusy-modal-text",
      style = "text-align: center;",
      text
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






