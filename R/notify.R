
#' @title Notifications
#'
#' @description Send notifications to the user.
#'
#' @param text Text to be displayed.
#' @param ... Options passed to JavaScript method, see [config_notify()].
#' @param timeout The delay in milliseconds to hide and remove the notifications.
#' @param position Position where to display the notification.
#' @param type Type of notification: `success`, `failure`, `info` or `warning`.
#' @param session Default Shiny session.
#'
#' @return No value.
#'
#' @references
#' Notify module from [Notiflix](https://github.com/notiflix/Notiflix) library.
#' More documentation and examples are available on the official website:
#'  [https://notiflix.github.io/notify](https://notiflix.github.io/notify).
#'
#' @export
#'
#' @name notify
#'
#' @example examples/notify.R
notify <- function(text,
                   ...,
                   timeout = 3000,
                   position = c("right-top", "right-bottom", "left-top",
                                "left-bottom", "center-top", "center-bottom",
                                "center-center"),
                   type = c("success", "failure", "info", "warning"),
                   session = shiny::getDefaultReactiveDomain()) {
  type <- match.arg(type)
  position <- match.arg(position)
  config <- list(timeout = timeout, position = position, ...)
  idx <- vapply(X = config, FUN = inherits, what = "config_notify", FUN.VALUE = logical(1))
  config <- c(config[!idx], unlist(config[idx], recursive = FALSE))
  insertUI(
    selector = "html",
    ui = tagList(html_dependency_notify()),
    immediate = TRUE,
    where = "afterBegin",
    session = session
  )
  session$sendCustomMessage(
    type =  paste0("shinybusy-notify-", type),
    message = list(
      text = text,
      config = config
    )
  )
}


#' @export
#'
#' @rdname notify
notify_success <- function(text,
                           ...,
                           timeout = 3000,
                           position = "right-top") {
  notify(
    text = text,
    timeout = timeout,
    position = position,
    type = "success",
    ...
  )
}


#' @export
#'
#' @rdname notify
notify_failure <- function(text,
                           ...,
                           timeout = 3000,
                           position = "right-top") {
  notify(
    text = text,
    timeout = timeout,
    position = position,
    type = "failure",
    ...
  )
}

#' @export
#'
#' @rdname notify
notify_info <- function(text,
                        ...,
                        timeout = 3000,
                        position = "right-top") {
  notify(
    text = text,
    timeout = timeout,
    position = position,
    type = "info",
    ...
  )
}

#' @export
#'
#' @rdname notify
notify_warning <- function(text,
                           ...,
                           timeout = 3000,
                           position = "right-top") {
  notify(
    text = text,
    timeout = timeout,
    position = position,
    type = "warning",
    ...
  )
}



#' @title Configure options for [notify()] and others
#'
#' @description Options for [notify()] functions, see
#'  [online documentation](https://notiflix.github.io/documentation)
#'  for default values and examples.
#'
#' @param background Changes the background color.
#' @param textColor Changes the text color.
#' @param childClassName Changes the class name.
#' @param notiflixIconColor Changes the SVG icon color.
#' @param fontAwesomeClassName Changes the FontAwesome icon class name (FontAwesome has to be added to the project separately.)
#' @param fontAwesomeIconColor Changes the FontAwesome icon color.
#' @param backOverlayColor Changes the color of the background overlay.
#' @param width Changes the width of the notifications.
#' @param distance The distance between positioned notifications and the body element.
#' @param opacity Changes the opacity. (Between 0 and 1)
#' @param borderRadius Changes the radius of the notifications corners.
#' @param rtl Specifies the text direction to "right-to-left".
#' @param messageMaxLength The maximum length of the notifications message text.
#' @param backOverlay Adds a background overlay to the notifications.
#' @param plainText Strips all HTML tags.
#' @param showOnlyTheLastOne Auto-removes all the notifications except for the last one.
#' @param clickToClose Removes the notification when it has been clicked without waiting for the delay.
#' @param pauseOnHover Auto-remove functionality will be paused for each notification element when the pointer(mouse) enters on it.
#' @param ID Changes the ID (attribute) of the notifications.
#' @param className Changes the class name (attribute) of the notifications.
#' @param zindex Changes the z-index of the notifications.
#' @param fontFamily Changes the font-family of the notifications message text.
#' @param fontSize Changes the font-size of the notifications message text.
#' @param cssAnimation Enables/disables CSS animations to show/hide the notifications.
#' @param cssAnimationDuration Changes the CSS animations duration as milliseconds.
#' @param cssAnimationStyle 6 types of styles can be used: fade zoom from-right from-top from-bottom from-left
#' @param closeButton Adds a close button/icon to the notifications. (Notifications with a close button won't disappear until they were clicked.)
#' @param useIcon Allows using built-in SVG or external FontAwesome icons in the notifications. (By default, built-in SVG icons have been defined.)
#' @param useFontAwesome Ignores built-in SVG icons and allows to use of external FontAwesome icons.
#' @param fontAwesomeIconStyle 2 types of styles can be used: basic shadow
#' @param fontAwesomeIconSize Changes the font-size of the FontAwesome icons
#' @param ... Other potential arguments.
#'
#' @return A config `list` that can be used in [notify()] and other `notify_*` functions.
#' @export
#'
#' @example examples/config_notify.R
config_notify <- function(background = NULL,
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
                          ...) {
  config <- c(as.list(environment()), list(...))
  config$success <- config$failure <- dropNulls(config[1:7])
  config$info <- config$warning <- dropNulls(config[1:7])
  config[1:6] <- NULL
  config <- dropNulls(config)
  class(config) <- c(class(config), "config_notify")
  return(config)
}


# library(rvest)
# docs <- html_table(read_html("https://notiflix.github.io/documentation"))
#
# docs[[1]]
# cat(paste(docs[[2]]$Option, collapse = " = NULL,\n"))
#
# cat(
#   paste("#' @param", docs[[1]]$Option, docs[[1]]$Description, "\n")
# )
