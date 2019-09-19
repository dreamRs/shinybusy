

autospin <- function() {
  tags$div(
    style = "display: none;",
    tags$div(
      class = "shinybusy-auto-spinner shinybusy-auto-spinner-container",
      spin_epic(spin = "flower")
    ),
    tags$div(
      class = "shinybusy-auto-recalculating"
    )
  )
}
