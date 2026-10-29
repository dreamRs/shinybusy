# Reports

show extended notifications that contain a title, description to the
user.

## Usage

``` r
report(
  title,
  text,
  ...,
  button = "Ok",
  type = c("success", "failure", "info", "warning"),
  session = shiny::getDefaultReactiveDomain()
)

report_success(title, text, ..., button = "Ok")

report_failure(title, text, ..., button = "Ok")

report_info(title, text, ..., button = "Ok")

report_warning(title, text, ..., button = "Ok")
```

## Arguments

- title:

  Title of the report.

- text:

  Text to be displayed.

- ...:

  Options passed to JavaScript method, see
  [`config_report()`](https://dreamrs.github.io/shinybusy/reference/config_report.md).

- button:

  Label for the button.

- type:

  Type of notification: `success`, `failure`, `info` or `warning`.

- session:

  Default Shiny session.

## Value

No value.

## References

Report module from [Notiflix](https://github.com/notiflix/Notiflix)
library. More documentation and examples are available on the official
website: <https://notiflix.github.io/report>.

## Examples

``` r
library(shiny)
library(shinybusy)

ui <- fluidPage(
  tags$h2("Report examples"),
  tags$p(
    "More examples available on the official website:",
    tags$a("https://notiflix.github.io/report")
  ),
  actionButton("success", "Success"),
  actionButton("failure", "Failure"),
  actionButton("info", "Info"),
  actionButton("warning", "Warning")
)

server <- function(input, output, session) {

  observeEvent(input$success, {
    report_success(
      "Well done!",
      "All in order"
    )
  })

  observeEvent(input$failure, {
    report_failure(
      "Oups...",
      "Something went wrong"
    )
  })

  observeEvent(input$info, {
    report_info(
      "For your information",
      tags$p(
        style = "font-style: italic;",
        "Lorem ipsum dolor sit amet"
      )
    )
  })

  observeEvent(input$warning, {
    report_warning(
      "Be careful!",
      "There were 30 warnings (use warnings() to see them)"
    )
  })

}

if (interactive())
  shinyApp(ui, server)
```
