context("busy-modal")

test_that("show_modal_* works", {

  session <- as.environment(list(
    ns = identity,
    sendModal = function(...) {
      session$lastSendModal = list(...)
    }
  ))

  expect_silent(show_modal_progress_line(session = session))
  expect_silent(show_modal_progress_circle(session = session))
  expect_silent(show_modal_spinner(session = session))
  expect_silent(show_modal_gif(src = "image", session = session))

})
