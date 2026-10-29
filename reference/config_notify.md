# Configure options for [`notify()`](https://dreamrs.github.io/shinybusy/reference/notify.md) and others

Options for
[`notify()`](https://dreamrs.github.io/shinybusy/reference/notify.md)
functions, see [online
documentation](https://notiflix.github.io/documentation) for default
values and examples.

## Usage

``` r
config_notify(
  background = NULL,
  textColor = NULL,
  childClassName = NULL,
  notiflixIconColor = NULL,
  fontAwesomeClassName = NULL,
  fontAwesomeIconColor = NULL,
  backOverlayColor = NULL,
  width = NULL,
  distance = NULL,
  opacity = NULL,
  borderRadius = NULL,
  rtl = NULL,
  messageMaxLength = NULL,
  backOverlay = NULL,
  plainText = NULL,
  showOnlyTheLastOne = NULL,
  clickToClose = NULL,
  pauseOnHover = NULL,
  ID = NULL,
  className = NULL,
  zindex = NULL,
  fontFamily = NULL,
  fontSize = NULL,
  cssAnimation = NULL,
  cssAnimationDuration = NULL,
  cssAnimationStyle = NULL,
  closeButton = NULL,
  useIcon = NULL,
  useFontAwesome = NULL,
  fontAwesomeIconStyle = NULL,
  fontAwesomeIconSize = NULL,
  ...
)
```

## Arguments

- background:

  Changes the background color.

- textColor:

  Changes the text color.

- childClassName:

  Changes the class name.

- notiflixIconColor:

  Changes the SVG icon color.

- fontAwesomeClassName:

  Changes the FontAwesome icon class name (FontAwesome has to be added
  to the project separately.)

- fontAwesomeIconColor:

  Changes the FontAwesome icon color.

- backOverlayColor:

  Changes the color of the background overlay.

- width:

  Changes the width of the notifications.

- distance:

  The distance between positioned notifications and the body element.

- opacity:

  Changes the opacity. (Between 0 and 1)

- borderRadius:

  Changes the radius of the notifications corners.

- rtl:

  Specifies the text direction to "right-to-left".

- messageMaxLength:

  The maximum length of the notifications message text.

- backOverlay:

  Adds a background overlay to the notifications.

- plainText:

  Strips all HTML tags.

- showOnlyTheLastOne:

  Auto-removes all the notifications except for the last one.

- clickToClose:

  Removes the notification when it has been clicked without waiting for
  the delay.

- pauseOnHover:

  Auto-remove functionality will be paused for each notification element
  when the pointer(mouse) enters on it.

- ID:

  Changes the ID (attribute) of the notifications.

- className:

  Changes the class name (attribute) of the notifications.

- zindex:

  Changes the z-index of the notifications.

- fontFamily:

  Changes the font-family of the notifications message text.

- fontSize:

  Changes the font-size of the notifications message text.

- cssAnimation:

  Enables/disables CSS animations to show/hide the notifications.

- cssAnimationDuration:

  Changes the CSS animations duration as milliseconds.

- cssAnimationStyle:

  6 types of styles can be used: fade zoom from-right from-top
  from-bottom from-left

- closeButton:

  Adds a close button/icon to the notifications. (Notifications with a
  close button won't disappear until they were clicked.)

- useIcon:

  Allows using built-in SVG or external FontAwesome icons in the
  notifications. (By default, built-in SVG icons have been defined.)

- useFontAwesome:

  Ignores built-in SVG icons and allows to use of external FontAwesome
  icons.

- fontAwesomeIconStyle:

  2 types of styles can be used: basic shadow

- fontAwesomeIconSize:

  Changes the font-size of the FontAwesome icons

- ...:

  Other potential arguments.

## Value

A config `list` that can be used in
[`notify()`](https://dreamrs.github.io/shinybusy/reference/notify.md)
and other `notify_*` functions.

## Examples

``` r
library(shiny)
library(shinybusy)

ui <- fluidPage(
  tags$h2("config for notify examples"),
  actionButton("success", "Success")
)

server <- function(input, output, session) {

  observeEvent(input$success, {
    notify_success(
      "Well done!",
      config_notify(
        background = "#0431B4",
        notiflixIconColor = "#FFF"
      )
    )
  })

}

if (interactive())
  shinyApp(ui, server)
```
