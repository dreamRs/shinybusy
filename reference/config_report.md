# Configure options for [`report()`](https://dreamrs.github.io/shinybusy/reference/report.md) and others

Options for
[`report()`](https://dreamrs.github.io/shinybusy/reference/report.md)
functions, see [online
documentation](https://notiflix.github.io/documentation) for default
values and examples.

## Usage

``` r
config_report(
  svgColor = NULL,
  titleColor = NULL,
  messageColor = NULL,
  buttonBackground = NULL,
  buttonColor = NULL,
  backOverlayColor = NULL,
  className = NULL,
  width = NULL,
  backgroundColor = NULL,
  borderRadius = NULL,
  rtl = NULL,
  zindex = NULL,
  backOverlay = NULL,
  fontFamily = NULL,
  svgSize = NULL,
  plainText = NULL,
  titleFontSize = NULL,
  titleMaxLength = NULL,
  messageFontSize = NULL,
  messageMaxLength = NULL,
  buttonFontSize = NULL,
  buttonMaxLength = NULL,
  cssAnimation = NULL,
  cssAnimationDuration = NULL,
  cssAnimationStyle = NULL,
  ...
)
```

## Arguments

- svgColor:

  Changes the built-in SVG icon color.

- titleColor:

  Changes the title text color.

- messageColor:

  Changes the message text color.

- buttonBackground:

  Changes the button background color.

- buttonColor:

  Changes the button text color.

- backOverlayColor:

  Changes the color of the background overlay.

- className:

  Changes the class name (attribute).

- width:

  Changes the width.

- backgroundColor:

  Changes the background color.

- borderRadius:

  Changes the radius of the corners.

- rtl:

  Specifies the text direction to "right-to-left".

- zindex:

  Changes the z-index.

- backOverlay:

  Adds a background overlay.

- fontFamily:

  Changes the font-family.

- svgSize:

  Changes the built-in SVG icons width and height. (Notiflix uses square
  scaled icons.)

- plainText:

  Strips all HTML tags.

- titleFontSize:

  Changes the font-size of the title text.

- titleMaxLength:

  The maximum length of the title text.

- messageFontSize:

  Changes the font-size of the message text.

- messageMaxLength:

  The maximum length of the message text.

- buttonFontSize:

  Changes the font-size of the button text.

- buttonMaxLength:

  The maximum length of the button text.

- cssAnimation:

  Enables/disables CSS animations to show/hide.

- cssAnimationDuration:

  Changes the CSS animations duration as milliseconds.

- cssAnimationStyle:

  2 types of styles can be used: fade zoom.

- ...:

  Other potential arguments.

## Value

A config `list` that can be used in
[`report()`](https://dreamrs.github.io/shinybusy/reference/report.md)
and other `report_*` functions.

## Examples

``` r
library(shiny)
library(shinybusy)

ui <- fluidPage(
  tags$h2("Config for report() examples"),
  actionButton("success", "Success"),
  actionButton("failure", "Failure"),
  actionButton("info", "Info")
)

server <- function(input, output, session) {

  observeEvent(input$success, {
    report_success(
      "Well done!",
      "All in order",
      config_report(
        svgColor = "#0431B4",
        titleColor = "#0431B4"
      )
    )
  })

  observeEvent(input$failure, {
    report_failure(
      "Oups...",
      "Something went wrong",
      config_report(
        svgColor = "#DF01D7",
        titleColor = "#DF01D7"
      )
    )
  })

  observeEvent(input$info, {
    report_info(
      "For your information",
      tags$p(
        style = "font-style: italic;",
        "Lorem ipsum dolor sit amet"
      ),
      config_report(width = "560px", borderRadius = "5px")
    )
  })

}

if (interactive())
  shinyApp(ui, server)
```
