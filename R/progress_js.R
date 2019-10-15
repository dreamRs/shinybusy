#' @title Progress bar, circle and semi-circle
#'
#' @description Htmlwidget to create progress bars, cricles or semicircles.
#'
#' @importFrom htmlwidgets createWidget sizingPolicy
#'
#'
#' @noRd
progress_js <- function(value = 0,
                        color = "#112446",
                        stroke_width = 4,
                        easing = "easeInOut",
                        duration = 1400,
                        trail_color = "#eee",
                        trail_width = 1,
                        svg_style = list(width = "100%", height = "100%"),
                        ...,
                        from = NULL, to = NULL,
                        set_text = "Math.round(bar.value() * 100) + ' %'",
                        type = c("Line", "Circle", "SemiCircle"),
                        width = NULL, height = NULL,
                        elementId = NULL) {

  if (value < 0 | value > 1) {
    stop("progress: 'value' must be between [0, 1].")
  }

  if (!is.null(set_text) && !inherits(set_text, "JS_EVAL")) {
    set_text <- htmlwidgets::JS(sprintf("function(state, bar) {return %s;}", set_text))
  }

  x <- list(
    type = match.arg(type),
    config = dropNulls(c(list(
      color = color,
      strokeWidth = stroke_width,
      easing = easing,
      duration = duration,
      trailColor = trail_color,
      trailWidth = trail_width,
      svgStyle = svg_style,
      from = from,
      to = to,
      warnings = FALSE
    ), list(...))),
    set_text = set_text,
    value = value
  )

  # create widget
  createWidget(
    name = "progress_js",
    x = dropNulls(x),
    width = width,
    height = height,
    package = "shinybusy",
    elementId = elementId,
    sizingPolicy = sizingPolicy(padding = 20)
  )
}

progress_js_html <- function(id, style, class, ...) {
  tags$div(
    id = id,
    class = class,
    style = style,
    style = "margin-bottom:25px;",
    ...
  )
}



#' @title Create progress indicator
#'
#' @description Bar, circle or semicircle to show progress.
#'  Can be used outside Shiny. In Shiny you can set
#'  progress value server-side.
#'
#' @param value Initial value or new value to set.
#' @param color Main color.
#' @param stroke_width Main width.
#' @param easing Animation to use.
#' @param duration Animation duration.
#' @param trail_color Color of shape behind the main bar.
#' @param trail_width Width of shape behind the main bar.
#' @param text Text to display.
#' @param width Container width.
#' @param height Container height.
#' @param shiny_id Id to use in Shiny application.
#'
#' @return an \code{htmlwidget} object.
#' @name progress
#'
#' @export
#'
progress_line <- function(value = 0,
                         color = "#112446",
                         stroke_width = 4,
                         easing = "easeInOut",
                         duration = 1400,
                         trail_color = "#eee",
                         trail_width = 1,
                         text = "auto",
                         width = "100%", height = "15px",
                         shiny_id = NULL) {

  if (is.null(text)) {
    set_text <- NULL
    text_value <- NULL
  } else {
    if (identical(text, "auto")) {
      set_text <- "Math.round(bar.value() * 100) + ' %'"
      text_value <- NULL
    } else {
      set_text <- NULL
      text_value <- text
    }
  }

  progress_js(
    type = "Line",
    value = value,
    color = color,
    stroke_width = stroke_width,
    easing = easing,
    duration = duration,
    trail_color = trail_color,
    trail_width = trail_width,
    width = width, height = height,
    elementId = shiny_id,
    set_text = set_text,
    text = list(
      value = text_value,
      style = list(
        padding = 0,
        margin = 0
      )
    )
  )
}



#' @rdname progress
#'
#' @export
progress_circle <- function(value = 0,
                          color = "#112446",
                          stroke_width = 4,
                          easing = "easeInOut",
                          duration = 1400,
                          trail_color = "#eee",
                          trail_width = 1,
                          text = "auto",
                          width = "200px", height = "200px",
                          shiny_id = NULL) {

  if (is.null(text)) {
    set_text <- NULL
    text_value <- NULL
  } else {
    if (identical(text, "auto")) {
      set_text <- "Math.round(bar.value() * 100) + ' %'"
      text_value <- NULL
    } else {
      set_text <- NULL
      text_value <- text
    }
  }

  progress_js(
    type = "Circle",
    value = value,
    color = color,
    stroke_width = stroke_width,
    easing = easing,
    duration = duration,
    trail_color = trail_color,
    trail_width = trail_width,
    width = width, height = height,
    elementId = shiny_id
  )
}


#' @param session Shiny session.
#'
#' @export
#' @rdname progress
#'
update_progress <- function(shiny_id, value, text = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    type = "shinybusy-progress-js",
    message = dropNulls(list(
      id = session$ns(shiny_id),
      value = value,
      text = text
    ))
  )
}


