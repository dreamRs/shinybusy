
#' @importFrom htmltools htmlDependency
spinner_dependencies <- function() {
  htmlDependency(
    name = "spin", version = "0.1.0",
    src = list(href = "shinybusy", file = "www"),
    package = "shinybusy",
    stylesheet = "spinner/spin.css"
  )
}

#' @importFrom utils packageVersion
#' @importFrom htmltools htmlDependency
shinybusy_dependencies <- function() {
  htmlDependency(
    name = "shinybusy", version = packageVersion("shinybusy"),
    src = list(href = "shinybusy", file = "www"),
    package = "shinybusy",
    script = "js/shinybusy.js",
    stylesheet = "css/shinybusy.css"
  )
}

