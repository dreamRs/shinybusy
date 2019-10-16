context("busy-bar")

test_that("busy_bar works", {

  tag_busy_bar <- busy_bar()

  expect_is(tag_busy_bar, "shiny.tag.list")
  expect_true(length(htmltools::findDependencies(tag_busy_bar)) > 0)
})
