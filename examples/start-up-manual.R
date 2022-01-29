
# manual ------------------------------------------------------------------

library(shiny)
library(shinybusy)

ui <- fluidPage(

  busy_start_up(
    loader = spin_kit(
      spin = "cube-grid",
      color = "#FFF",
      style = "width:50px; height:50px;"
    ),
    text = "Loading...",
    mode = "manual",
    color = "#FFF",
    background = "#112446"
  ),

  tags$h1("Ready to play!", class = "text-center")

)

server <- function(input, output, session) {

  # Remove after 3 seconds (+timeout)
  observe({
    Sys.sleep(3)
    remove_start_up(timeout = 200)
  })

}

if (interactive())
  shinyApp(ui, server)
