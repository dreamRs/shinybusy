
#' HTML dependencies used by shinybusy
#'
#' @return an [htmltools::htmlDependency()].
#' @export
#'
#' @importFrom utils packageVersion
#' @importFrom htmltools htmlDependency
#'
#' @name html-dependencies
#'
html_dependency_spinkit <- function() {
  htmlDependency(
    name = "spinkit",
    version = "0.1.1",
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    stylesheet = "spinkit/spin.min.css"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_epic <- function() {
  htmlDependency(
    name = "epic-spinners",
    version = "1.1.0",
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    stylesheet = "epic-spinners/epic-spinners.css"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_shinybusy <- function() {
  warning("`html_dependency_shinybusy` is deprecated and will be removed in next release.")
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
html_dependency_freezeframe <- function() {
  warning("`html_dependency_freezeframe` is deprecated and will be removed in next release.")
  htmlDependency(
    name = "freezeframe",
    version = "3.0.10",
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    script = "freezeframe/freezeframe.pkgd.min.js",
    stylesheet = "freezeframe/freezeframe_styles.min.css"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_nanobar <- function() {
  warning("`html_dependency_nanobar` is deprecated and will be removed in next release.")
  htmlDependency(
    name = "nanobar",
    version = "0.4.2",
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    script = "nanobar/nanobar.min.js",
    stylesheet = "nanobar/nanobar-styles.css"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_notiflix <- function() {
  warning("`html_dependency_notiflix` is deprecated and will be removed in next release.")
  htmlDependency(
    name = "notiflix",
    version = "2.7.0",
    src = list(href = "shinybusy", file = "assets"),
    package = "shinybusy",
    script = "notiflix/notiflix-2.7.0.min.js",
    stylesheet = "notiflix/notiflix-2.7.0.min.css"
  )
}



#' @importFrom htmltools htmlDependency
#' @importFrom utils packageVersion
#' @export
#' @rdname html-dependencies
html_dependency_startup <- function() {
  htmlDependency(
    name = "shinybusy-startup",
    version = packageVersion("shinybusy"),
    src = list(file = "packer"),
    package = "shinybusy",
    script = "startup.js"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_loading <- function() {
  htmlDependency(
    name = "shinybusy-loading",
    version = packageVersion("shinybusy"),
    src = list(file = "packer"),
    package = "shinybusy",
    script = "loading.js"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_busy <- function() {
  htmlDependency(
    name = "shinybusy-busy",
    version = packageVersion("shinybusy"),
    src = list(file = "packer"),
    package = "shinybusy",
    script = "busy.js"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_notify <- function() {
  htmlDependency(
    name = "shinybusy-notify",
    version = packageVersion("shinybusy"),
    src = list(file = "packer"),
    package = "shinybusy",
    script = "notify.js"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_report <- function() {
  htmlDependency(
    name = "shinybusy-report",
    version = packageVersion("shinybusy"),
    src = list(file = "packer"),
    package = "shinybusy",
    script = "report.js"
  )
}

#' @export
#' @rdname html-dependencies
html_dependency_block <- function() {
  htmlDependency(
    name = "shinybusy-block",
    version = packageVersion("shinybusy"),
    src = list(file = "packer"),
    package = "shinybusy",
    script = "block.js",
    head = "<style>.nx-block-temporary-position {opacity: 1!important;}</style>"
  )
}
