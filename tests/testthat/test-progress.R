context("progress js")

test_that("progress_line works", {

  prgr <- progress_line()

  expect_is(prgr, "htmlwidget")

  expect_error(progress_line(value = 2))

  prgr <- progress_line(text = NULL)
  expect_null(prgr$x$config$text$value)
  expect_null(prgr$x$set_text)

  prgr <- progress_line(text = "auto")
  expect_null(prgr$x$config$text$value)
  expect_false(is.null(prgr$x$set_text))

  prgr <- progress_line(text = "Custom")
  expect_false(is.null(prgr$x$config$text$value))
  expect_null(prgr$x$set_text)
})


test_that("progress_circle works", {

  prgr <- progress_circle()

  expect_is(prgr, "htmlwidget")

  expect_error(progress_circle(value = 2))

  prgr <- progress_circle(text = NULL)
  expect_null(prgr$x$config$text$value)
  expect_null(prgr$x$set_text)

  prgr <- progress_circle(text = "auto")
  expect_null(prgr$x$config$text$value)
  expect_false(is.null(prgr$x$set_text))

  prgr <- progress_circle(text = "Custom")
  expect_false(is.null(prgr$x$config$text$value))
  expect_null(prgr$x$set_text)
})



test_that("progress_semicircle works", {

  prgr <- progress_semicircle()

  expect_is(prgr, "htmlwidget")

  expect_error(progress_semicircle(value = 2))

  prgr <- progress_semicircle(text = NULL)
  expect_null(prgr$x$config$text$value)
  expect_null(prgr$x$set_text)

  prgr <- progress_semicircle(text = "auto")
  expect_null(prgr$x$config$text$value)
  expect_false(is.null(prgr$x$set_text))

  prgr <- progress_semicircle(text = "Custom")
  expect_false(is.null(prgr$x$config$text$value))
  expect_null(prgr$x$set_text)
})



