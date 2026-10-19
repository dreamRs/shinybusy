context("loading-overlay")

mock_session <- function() {
  session <- as.environment(list(
    ns = identity,
    sendInsertUI = function(...) NULL,
    sendCustomMessage = function(type, message) {
      session$messages[[length(session$messages) + 1]] <- list(type = type, message = message)
    },
    messages = list()
  ))
  session
}

test_that("show_loading sends the expected message", {
  session <- mock_session()

  show_loading(session = session)
  msg <- session$messages[[1]]
  expect_identical(msg$type, "shinybusy-loading-show")
  expect_identical(msg$message$type, "standard")
  expect_identical(msg$message$text, "Loading...")
  expect_identical(msg$message$config, structure(list(), names = character(0)))

  show_loading(
    text = "Wait", type = "pulse", svgColor = "#FFF",
    session = session
  )
  msg <- session$messages[[2]]
  expect_identical(msg$message$type, "pulse")
  expect_identical(msg$message$text, "Wait")
  expect_identical(msg$message$config, list(svgColor = "#FFF"))
})

test_that("show_loading without text omits it from the message", {
  session <- mock_session()
  show_loading(text = NULL, session = session)
  expect_false("text" %in% names(session$messages[[1]]$message))
})

test_that("show_loading serializes an empty config as an object", {
  session <- mock_session()
  show_loading(session = session)
  json <- jsonlite::toJSON(session$messages[[1]]$message, auto_unbox = TRUE)
  expect_match(as.character(json), "\"config\":{}", fixed = TRUE)
})

test_that("show_loading validates arguments", {
  session <- mock_session()
  expect_error(show_loading(type = "unknown", session = session))
  expect_error(show_loading(text = c("a", "b"), session = session), "character of length 1")
  expect_error(show_loading(text = 1, session = session), "character of length 1")
  expect_error(show_loading(text = NA_character_, session = session), "character of length 1")
  expect_error(show_loading("Wait", "standard", "#FFF", session = session), "must be named")
  expect_length(session$messages, 0)
})

test_that("update_loading works", {
  session <- mock_session()
  update_loading("New text", session = session)
  msg <- session$messages[[1]]
  expect_identical(msg$type, "shinybusy-loading-update")
  expect_identical(msg$message$text, "New text")
  expect_error(update_loading(NULL, session = session), "character of length 1")
  expect_error(update_loading(c("a", "b"), session = session), "character of length 1")
})

test_that("remove_loading works", {
  session <- mock_session()
  remove_loading(session = session)
  expect_identical(session$messages[[1]]$type, "shinybusy-loading-remove")
  expect_identical(session$messages[[1]]$message$timeout, 0)
  remove_loading(timeout = 500, session = session)
  expect_identical(session$messages[[2]]$message$timeout, 500)
  expect_error(remove_loading(timeout = -1, session = session), "non-negative")
  expect_error(remove_loading(timeout = NA_real_, session = session), "non-negative")
  expect_error(remove_loading(timeout = Inf, session = session), "non-negative")
  expect_error(remove_loading(timeout = c(1, 2), session = session), "non-negative")
  expect_error(remove_loading(timeout = "1", session = session), "non-negative")
})

test_that("html_dependency_loading_overlay points to an existing script", {
  dep <- html_dependency_loading_overlay()
  expect_identical(dep$name, "shinybusy-loading-overlay")
  path <- system.file("packer", dep$script, package = "shinybusy")
  expect_true(nzchar(path))
})
