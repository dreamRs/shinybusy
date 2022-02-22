
#' @title Notifications
#'
#' @description Send notifications to the user.
#'
#' @param text Text to be displayed.
#' @param ... Options passed to JavaScript method, see
#'  [https://notiflix.github.io/documentation](https://notiflix.github.io/documentation).
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
      config = list(timeout = timeout, position = position, ...)
    )
  )
}


#' @export
#'
#' @rdname notify
notify_success <- function(text,
                           timeout = 3000,
                           position = "right-top",
                           ...) {
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
                           timeout = 3000,
                           position = "right-top",
                           ...) {
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
                        timeout = 3000,
                        position = "right-top",
                        ...) {
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
                           timeout = 3000,
                           position = "right-top",
                           ...) {
  notify(
    text = text,
    timeout = timeout,
    position = position,
    type = "warning",
    ...
  )
}

