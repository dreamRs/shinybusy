#' Shiny resource
#'
#' @importFrom shiny addResourcePath
#'
#' @noRd
.onLoad <- function(...) {
  shiny::addResourcePath("shinybusy", system.file("assets", package = "shinybusy"))
}
