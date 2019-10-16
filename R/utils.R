
create_id <- function() {
  paste(as.raw(sample.int(255, 12)), collapse = "")
}

dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

#' @importFrom htmltools tags HTML
js_center_modal <- function(translateX = "-50%", translateY = "-100%") {
  tags$script(HTML(
    # "$('.shinybusy-modal').parent().css('margin-top', '40vh');"
    paste(
      sep = ".",
      "$('.shinybusy-modal')",
      "parent()",
      "parent()",
      "css('position', 'fixed')",
      "css('top', '50%')",
      "css('left', '50%')",
      sprintf("css('transform', 'translate(%s, %s)');", translateX, translateY)
    )
  ))
}

