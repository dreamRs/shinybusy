

autospin <- function(spin = "radar", color = "#112446",
                     id_in = NULL, id_out = NULL,
                     class_in = c("shiny-plot-output", "html-widget-output")) {
  if (is.null(id_in))
    id_in <- character(0)
  if (is.null(id_out))
    id_out <- character(0)
  attachDependencies(
    x = tagList(
      tags$div(
        style = "display: none;",
        tags$div(
          class = "shinybusy-auto-spinner shinybusy-auto-spinner-container",
          spin_epic(spin = spin, color = color)
        ),
        tags$div(
          class = "shinybusy-auto-recalculating"
        )
      ),
      tags$script(
        type = "application/json",
        `data-for` = "shinybusy-autospinner",
        toJSON(list(
          id_in = id_in,
          id_out = id_out,
          class_in = class_in
        ), auto_unbox = TRUE, json_verbatim = TRUE)
      )
    ),
    value = html_dependency_autospin()
  )
}
