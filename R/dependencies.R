
#' HTML dependencies used by shinybusy
#'
#' @return an \code{\link[htmltools]{htmlDependency}}.
#' @export
#'
#' @importFrom utils packageVersion
#' @importFrom htmltools htmlDependency
#'
#' @name html-dependencies
#'
html_dependency_spinkit <- function() {
  htmlDependency(
    name = "spinkit", version = "0.1.0",
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    stylesheet = "spinkit/spin.min.css"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_epic <- function() {
  htmlDependency(
    name = "epic-spinners", version = "1.1.0",
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    stylesheet = "epic-spinners/epic-spinners.css"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_shinybusy <- function() {
  htmlDependency(
    name = "shinybusy",
    version = packageVersion("shinybusy"),
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    script = "js/shinybusy.js",
    stylesheet = "css/shinybusy.css"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_autospin <- function() {
  htmlDependency(
    name = "shinybusy-autospin",
    version = packageVersion("shinybusy"),
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    script = "js/autospin.js",
    stylesheet = "css/autospin.css"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_freezeframe <- function() {
  htmlDependency(
    name = "freezeframe", version = "3.0.10",
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    script = "freezeframe/freezeframe.pkgd.min.js",
    stylesheet = "freezeframe/freezeframe_styles.min.css"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_nanobar <- function() {
  htmlDependency(
    name = "nanobar",
    version = "0.4.2",
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    script = "nanobar/nanobar.min.js",
    stylesheet = "nanobar/nanobar-styles.css"
  )
}

