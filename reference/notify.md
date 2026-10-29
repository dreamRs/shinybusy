# Notifications

Send notifications to the user.

## Usage

``` r
notify(
  text,
  ...,
  timeout = 3000,
  position = c("right-top", "right-bottom", "left-top", "left-bottom", "center-top",
    "center-bottom", "center-center"),
  type = c("success", "failure", "info", "warning"),
  session = shiny::getDefaultReactiveDomain()
)

notify_success(text, ..., timeout = 3000, position = "right-top")

notify_failure(text, ..., timeout = 3000, position = "right-top")

notify_info(text, ..., timeout = 3000, position = "right-top")

notify_warning(text, ..., timeout = 3000, position = "right-top")
```

## Arguments

- text:

  Text to be displayed.

- ...:

  Options passed to JavaScript method, see
  [`config_notify()`](https://dreamrs.github.io/shinybusy/reference/config_notify.md).

- timeout:

  The delay in milliseconds to hide and remove the notifications.

- position:

  Position where to display the notification.

- type:

  Type of notification: `success`, `failure`, `info` or `warning`.

- session:

  Default Shiny session.

## Value

No value.

## References

Notify module from [Notiflix](https://github.com/notiflix/Notiflix)
library. More documentation and examples are available on the official
website: <https://notiflix.github.io/notify>.

## Examples

``` r
library(shiny)
library(shinybusy)

ui <- fluidPage(
  tags$h2("notify examples"),
  tags$p(
    "More examples available on the official website:",
    tags$a("https://notiflix.github.io/notify")
  ),
  actionButton("success", "Success"),
  actionButton("failure", "Failure"),
  actionButton("info", "Info"),
  actionButton("warning", "Warning")
)

server <- function(input, output, session) {

  observeEvent(input$success, {
    notify_success("Well done!")
  })

  observeEvent(input$failure, {
    notify_failure("Oups...")
  })

  observeEvent(input$info, {
    notify_info("For your information")
  })

  observeEvent(input$warning, {
    notify_warning("Be careful!")
  })

}

if (interactive())
  shinyApp(ui, server)
```
