
#' @importFrom htmltools htmlDependency
spinner_dependencies <- function() {
  htmlDependency(
    name = "spin", version = "0.1.0",
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    stylesheet = "spinner/spin.min.css"
  )
}

#' @importFrom utils packageVersion
#' @importFrom htmltools htmlDependency
shinybusy_dependencies <- function() {
  htmlDependency(
    name = "shinybusy", version = packageVersion("shinybusy"),
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    script = "js/shinybusy.js",
    stylesheet = "css/shinybusy.css"
  )
}

#' @importFrom htmltools htmlDependency
freezeframe_dependencies <- function() {
  htmlDependency(
    name = "freezeframe", version = "3.0.10",
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    script = "freezeframe/freezeframe.pkgd.min.js",
    stylesheet = "freezeframe/freezeframe_styles.min.css"
  )
}

#' @importFrom htmltools htmlDependency
nanobar_dependencies <- function() {
  htmlDependency(
    name = "nanobar", version = "0.4.2",
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    script = "nanobar/nanobar.min.js",
    stylesheet = "nanobar/nanobar-styles.css"
  )
}

